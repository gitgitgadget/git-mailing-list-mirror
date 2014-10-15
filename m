From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Wed, 15 Oct 2014 21:14:10 +0700
Message-ID: <CACsJy8DEY=Dh7ErG7wN-w-v9pu8Ms0FZNX06cL0dkxpJTZefWQ@mail.gmail.com>
References: <1413090791-14428-1-git-send-email-max@max630.net>
 <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
 <543D58D9.5060606@web.de> <xmqqoatezhnx.fsf@gitster.dls.corp.google.com>
 <20141014183431.GA8157@wheezy.local> <543D7EBA.4040206@web.de> <20141014221509.GA10580@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 16:14:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XePLk-0008L8-BZ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 16:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbaJOOOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 10:14:41 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37115 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbaJOOOl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 10:14:41 -0400
Received: by mail-ig0-f177.google.com with SMTP id a13so1448156igq.10
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FCJCalOxmFtAxgaWbHE/u6QWLegCJH2ds+eJohtM3zc=;
        b=Azp5D2qfd7LrG2thIBrdeLeUmI95FUxCWTrGlussvXihqUfVlR0LK5Wav+CZhVze5B
         l5i//sd8tolFH3CgYBnF9ZfchQFytdipX1BrRabmu7+HjdzM6SdtWRlZ2KDmJYXZoxfE
         y3El09V/7uNtv+lguvG8eOCucT0Z4LZF8JGfeOpfrxrwwLFRNd0/2yD5N2yU48x9MQNV
         S+IjYlmLbDIEaJfgijBuTzdmfXEh/XteRVh9ZizT0dlAdPqEOii6gQZXleqEaTYbXMxM
         kgYU1MFIl7NKwNaK3BNPxzLeWw7DAxebNv7Jv5wQ1qobyhROxz4mWLYhM+116PdukYWy
         rBdg==
X-Received: by 10.50.61.226 with SMTP id t2mr14639265igr.27.1413382480348;
 Wed, 15 Oct 2014 07:14:40 -0700 (PDT)
Received: by 10.107.131.1 with HTTP; Wed, 15 Oct 2014 07:14:10 -0700 (PDT)
In-Reply-To: <20141014221509.GA10580@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 15, 2014 at 5:15 AM, Max Kirillov <max@max630.net> wrote:
>> Hmm, so I tend towards adding GIT_COMMON_DIR to
>> local_repo_env until we figured out how to handle this.
>> Without that I fear bad things will happen, at least for a
>> superproject with multiple checkout-to work trees where
>> the same submodule is initialized more than once ...
>
> I learned about local_repo_env and agree it should include
> GIT_COMMON_DIR. Unless it is removed at all...

It's in the same class as GIT_DIR and GIT_WORK_TREE so yeah it should
be in local_repo_env. Removing it would break t0060-path-utils.sh at
least. Unless we have a very good reason to remove it, I think we
should keep it as is.
-- 
Duy
