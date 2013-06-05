From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 08/15] for-each-ref: get --pretty using format_commit_message
Date: Wed, 5 Jun 2013 20:21:31 +0700
Message-ID: <CACsJy8ABwroExpXQRX8OYAnDum9+sX1+JB9z+WNn+YcZoXi5KA@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
 <1370349337-20938-9-git-send-email-artagnon@gmail.com> <CAPig+cRmnc=poOZUxZms_OWdLpBM_q=h+MDYisu8WtuF11PYXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 15:22:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkDfE-0003lC-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 15:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab3FENWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 09:22:03 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58574 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab3FENWB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 09:22:01 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so1101177oag.19
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/7lyDG8eEqbnZZrrj46tmvtmuwMq4dveZQWdsZ58U5M=;
        b=MCd6y9YCeFbmNWE8O+MyH6KyHTfLtMEBHyDl449Uw6ICUu9aEaDsyAHmuKqhjD3U5V
         ar4xoWsQOEy2Ka/El+igtEjxyhJaz6a3PIL0TVnhJgFP9BMoiHOGlqev718+wcWG7479
         8vp1dyiV8Tr0CdJTmWpf1oZulVF+qRt8sd9onqql1zui50lSVbgmKdRY5FoI2yP7dFeW
         DWF80ep+843mlNe/Tj8Is5gHu2LPpgIFi8ApCpV2yYLfEXvRwdX/XEGZRExVQV8e0jWA
         z1kRJejt93eRHarSHwIF62vmLoKNnD2unjWRu96pX/qRscyZ9HcfCH/TthkZoQhd2unL
         5iTg==
X-Received: by 10.182.220.130 with SMTP id pw2mr13435265obc.80.1370438521454;
 Wed, 05 Jun 2013 06:22:01 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Wed, 5 Jun 2013 06:21:31 -0700 (PDT)
In-Reply-To: <CAPig+cRmnc=poOZUxZms_OWdLpBM_q=h+MDYisu8WtuF11PYXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226448>

On Wed, Jun 5, 2013 at 4:12 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +Caveats:
>> +
>> +1. Many of the placeholders in "PRETTY FORMATS" are designed to work
>> +   specifically on commit objects: when non-commit objects are
>> +   supplied, those placeholders won't work.
>
> Should "won't work" be expanded upon? It's not clear if this means
> that git will outright crash, or if it will abort with an appropriate
> error message, or if the directive will be displayed as-is or removed
> from the output.

It will be displayed as-is but that's a bit inconsistent: %(unknown)
prints error and aborts while %unknown simply produces %unknown. The
latter is how "git log --format" does it. But I think we could make
for-each-ref --pretty to do the former for %unknown. It'll be
consistent with %(unknown) and we do not need to elaborate much (it's
pretty obvious when it does not work).
--
Duy
