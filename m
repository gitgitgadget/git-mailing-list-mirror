From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Wed, 18 Mar 2015 16:58:00 +0700
Message-ID: <CACsJy8CS1h+7JNLpvzpZd1AmOGHQA-sfHSiMJmJ0KF8Bj9+PiA@mail.gmail.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
 <CACsJy8AiHHKBD4vV5aJec9CGzBqfSCNU6-j=LjDhsp2VrC55+A@mail.gmail.com> <550949BC.1020500@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 18 10:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAkS-0003lR-Hn
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933305AbbCRJ6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:58:33 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36311 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933217AbbCRJ6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:58:31 -0400
Received: by iegc3 with SMTP id c3so34026861ieg.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZgsgyUTWgNzM4WXvln9OnBdQm/oO9CB2ue7Ldf6LPWw=;
        b=m/rab0bBudvpPgVQyYf481vvHAmMrFZKKkUGKrNvPUzCL2VKrpirWZiSNUeMTk4G9X
         LKu6qdQzxEV4LDQ5oOegTRfNMb5YbNBztAN2+Zx2p5/gf3+pKDAK40kzQKuZfiQCPh4Z
         1Xhdi9TYYZ99kL0wbCOOmEcP/FsZSESLn2+j5sn7yMI96tW+XK9Ns/CRLy/OZfKJ+Fvy
         EmKJBEC517am9A++dVlJ4TOWGdrAGEN6AoI2MXBEuuzS759eOAA2sHYSSL4hN1Z/0IEH
         ECqs3LMJ/qA/cWSTcDmrSxXZRfBO7Qycdm2iK/YeBu+djcixwVr+CfyrV8XDF1GomJWs
         YRGQ==
X-Received: by 10.42.41.148 with SMTP id p20mr91870697ice.62.1426672710656;
 Wed, 18 Mar 2015 02:58:30 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 02:58:00 -0700 (PDT)
In-Reply-To: <550949BC.1020500@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265711>

On Wed, Mar 18, 2015 at 4:47 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Thank you for doing it. I was about to write another number parser and
>> you did it :D Maybe you can add another patch to convert the only
>> strtol in upload-pack.c to parse_ui. This place should accept positive
>> number in base 10, plus sign is not accepted.
>
> If the general direction of this patch series is accepted, I'll
> gradually try to go through the codebase, replacing *all* integer
> parsing with these functions. So there's no need to request particular
> callers of strtol()/strtoul() to be converted; I'll get to them all
> sooner or later (I hope).

Good to know. No there's no hurry in converting this particular place.
It's just tightening things up, not bug fixing or anything.
-- 
Duy
