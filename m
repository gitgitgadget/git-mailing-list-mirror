From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Tue, 18 Nov 2014 14:51:36 -0800
Message-ID: <CAPc5daVy0Oe6UX3VCk_7UdabktbM29MceP9mt0ZZHad1K4HVmQ@mail.gmail.com>
References: <1416073760.9305.174.camel@homebase> <xmqqy4r9yc5u.fsf@gitster.dls.corp.google.com>
 <s934mtwo0zv.fsf@mad-scientist.net> <xmqq8uj8wbhl.fsf@gitster.dls.corp.google.com>
 <1416344066.3899.25.camel@mad-scientist.net> <xmqqegt0usy3.fsf@gitster.dls.corp.google.com>
 <1416349502.3899.30.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Smith <paul@mad-scientist.net>
X-From: git-owner@vger.kernel.org Tue Nov 18 23:52:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqrcv-0008Qx-F3
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 23:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbaKRWv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 17:51:58 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:42873 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbaKRWv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 17:51:57 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so11848352pab.7
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 14:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7fRtI+8TcOR7KK/NsXt0W6tNSl0jPxHgN9SrnXcbKzQ=;
        b=wPUNtPJCZZFov0AtCm1MX34B5182+X0Z1ipakH6qM+zD9BE57UZR4+Pvtlkn2fKfZW
         Rw8GlwcZmpFC1+mqKodwTWLw37J9aWNXsX4SV58RB59FxatQPhwRb52GEHdix3bounRa
         5zpqyGZQpFCmWnZ3c4GrBX4juVnYyi2/+G909RXyXi2mIhcaSOEmdrtav3aDiYdde8uy
         wztZ7TGKYv/bmGJ7RGjCVI3pVWnaDm3pj/aF4x7Tyy3vpWb1BpzACae9Jd+4CvfP7hUy
         nUV5MrLr6BlE9+qXcftT6+jR31DHqfW43jbvPcoVWeLdV9NR79AFGKiypgRw4kp8v+XS
         L1fQ==
X-Received: by 10.68.191.106 with SMTP id gx10mr15350166pbc.125.1416351116948;
 Tue, 18 Nov 2014 14:51:56 -0800 (PST)
Received: by 10.66.74.134 with HTTP; Tue, 18 Nov 2014 14:51:36 -0800 (PST)
In-Reply-To: <1416349502.3899.30.camel@mad-scientist.net>
X-Google-Sender-Auth: KUNUUrkW6mL1uGacRu6uNtcHTqs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK, thanks for digging. Let's go with this version, then.


On Tue, Nov 18, 2014 at 2:25 PM, Paul Smith <paul@mad-scientist.net> wrote:
> On Tue, 2014-11-18 at 12:58 -0800, Junio C Hamano wrote:
>> Doesn't the description of the -A option I quoted upthread hint a
>> simpler and clearer solution?  I.e. "test $(ls -A | wc -l) = 0"?
>
> Yes, but unfortunately for us the -A flag was added to POSIX Issue 7.
> It's not present in the previous version of POSIX, Issue 6:
>
> http://pubs.opengroup.org/onlinepubs/009695399/utilities/ls.html
>
> It came from the BSD world, so it might not be available on older
> SysV-derived systems (AIX, HP-UX, even Solaris... I don't have access to
> these anymore so I can't say).  Ultimately it's probably more portable
> to assume "ls -a" always prints "." and ".." than to assume "ls -A" is
> supported.
>
> Cheers!
>
