From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] MALLOC_CHECK: Allow checking to be disabled from config.mak
Date: Mon, 8 Oct 2012 15:19:45 +0200
Message-ID: <CA+EOSBnKqkQ_nLyEKzxsMYnB04X9ABMp3P3CuDy3ohfcoEbQtA@mail.gmail.com>
References: <50706B54.8090004@ramsay1.demon.co.uk>
	<7vbogfquc8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 15:20:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLDFv-0002lZ-LU
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 15:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab2JHNTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 09:19:55 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62529 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab2JHNTq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 09:19:46 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so9018643iea.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7ZySLjN1ROJAq15qHBpUbx8Bg5M1qs38ee5DBGIvg2o=;
        b=xQ3xEWAi2yi2fLojqALn7NAalAHtf2BHpAYMHdoI/PJ+7Z+lsHKdxxJCd530fKj/kb
         +Kcn5aLXb67D+tSMUUkuI143whxLZR1Thkm7mqNHUNkUfb3Bjq9H3JuhTc/Y01GhLJnQ
         VkMU7X3ZFBuQQgkM5xBQPHt1xVoGtdXScBuK8R2Rxb55PkdpwpdLupmWBYlv1IS4snAi
         9OA/doBK4+e6GxYAY/Si6eOt//HoEZe+b75bcAfn1RMTuW12FthiSz0AjqvEqN7uxKO7
         Uri8c2XLil8xH6q2GPyKnjmut6eAU1g0Bfxj/2JRaEa9Xo2egaC5lOSWsMMpFlSY0SmR
         7X1g==
Received: by 10.50.7.135 with SMTP id j7mr8080091iga.34.1349702385560; Mon, 08
 Oct 2012 06:19:45 -0700 (PDT)
Received: by 10.64.58.135 with HTTP; Mon, 8 Oct 2012 06:19:45 -0700 (PDT)
In-Reply-To: <7vbogfquc8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207229>

2012/10/6 Junio C Hamano <gitster@pobox.com>:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> The malloc checks can be disabled using the TEST_NO_MALLOC_CHECK
>> variable, either from the environment or command line of an
>> 'make test' invocation. In order to allow the malloc checks to be
>> disabled from the 'config.mak' file, we add TEST_NO_MALLOC_CHECK
>> to the environment using an export directive.
>
> We would want to encourage people to test with cheap but effective
> checks when available.  I do not see "malloc: using debugging hooks"
> message anywhere when I run tests, but if you do, I'd rather see us
> check if we can tell glibc to stop doing so first without disabling
> the whole test.  Your patch feels like the first step to a slipperly
> slope whose destination would make us say "we get too many messages
> so let's do nothing in "make test" with this configuration." when
> taken to the extreme, and obviously we would not want to go there
> ;-).
>
> Elia, you brought the MALLOC_CHECK_ up.  Did you hear about this
> issue elsewhere before, and if you did, do you know how other
> projects solves it?
Ok. I have found. For me this is not a problem any more these days.
Was fixed in glibc 2.8.90-9 2008

* Wed Jul 16 2008 Jakub Jelinek <jakub@redhat.com> 2.8.90-9
- update from trunk
  - fix unbuffered vfprintf if writing to the stream fails (#455360)
  - remove useless "malloc: using debugging hooks" message (#455355)
  - nscd fixes
(from glibc rpm changelog)

This is the bugzilla filled and closed
https://bugzilla.redhat.com/show_bug.cgi?id=455355

Ramsay, what version of glibc you have and in what distro? thanks
