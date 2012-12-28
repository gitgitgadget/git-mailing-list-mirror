From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2] wt-status: Show ignored files in untracked dirs
Date: Fri, 28 Dec 2012 15:05:30 +0100
Message-ID: <CALWbr2yNR=K3MqBVe=sfSxPaJ+-A8utHBqoiHPHPLxr_9e9SVQ@mail.gmail.com>
References: <1356516985-31068-1-git-send-email-apelisse@gmail.com>
	<1356528674-2730-1-git-send-email-apelisse@gmail.com>
	<7vip7omd8c.fsf@alter.siamese.dyndns.org>
	<20121227034859.GA20817@sigill.intra.peff.net>
	<7va9t0m69o.fsf@alter.siamese.dyndns.org>
	<CALWbr2wFg_9oDoZ_BUQwAzVV+UJSqBQRrMYmt6fv=fo02RL7Zg@mail.gmail.com>
	<20121227161920.GA28162@sigill.intra.peff.net>
	<CALWbr2xmtvchR4G37-FzzgScKe4p4RjLc7=Pg8d4K6SWO7tGAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 28 15:05:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToaZM-0007Ir-J2
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 15:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab2L1OFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 09:05:33 -0500
Received: from mail-ea0-f169.google.com ([209.85.215.169]:39603 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab2L1OFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 09:05:31 -0500
Received: by mail-ea0-f169.google.com with SMTP id a12so4227818eaa.14
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 06:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gAFSoZu2XG6JOvC/Nl5sJFTDr6tEgWxxySSRMZU4NRc=;
        b=01l5huqdFmG8/Kl/grSA9U1lbnhee/BCKDTHOX3Fq99+XJXrzUMPTTDsWYQiN3GbJX
         UzcPqXBbjhC89ysjLEGCoUHdAp+DQBrkI/Vd0sMdewkEz14fi6jYAhZZw+APi4PSC8SU
         YOP49aaV20V5pwUu1Dfp2/tMJu+fJjzNKtAgnd0+fCus8Lp+UxFOpl2eKs3lz/h9Grx4
         loyv+2Yk5IXNbl40x2rcetVIyvRhH3XXyn51RsYhquEPrEIigPAtkfg4sCutEEe4iQX3
         Jt1bcpCx8iczP1+Ir8zh5S8s08Q+knzvPZMURuReQk3zPGnuebC80YYT6nsClN/YOpHC
         QCIw==
Received: by 10.14.194.4 with SMTP id l4mr86682001een.42.1356703530637; Fri,
 28 Dec 2012 06:05:30 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Fri, 28 Dec 2012 06:05:30 -0800 (PST)
In-Reply-To: <CALWbr2xmtvchR4G37-FzzgScKe4p4RjLc7=Pg8d4K6SWO7tGAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212241>

Hey Peff,
I actually have an issue with the behavior we discussed (referenced as 1.A.)

Using the example from Michael's mail, I end up having this:
$ git status --porcelain --ignored
?? .gitignore
?? x
?? y/
!! x.ignore-me
!! y/

y/ is referred as untracked, because it contains untracked files, and
then as ignored because it
contains ignored files.

Showing it twice doesn't feel right though, so I guess we should only
show "?? y/" with untracked=normal,
and "!! y/foo.ignore-me" when using untracked=all

What do you think ?




On Thu, Dec 27, 2012 at 6:35 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> By "committed", I assume you meat that you have "dirA/unco" as an
>> untracked file, and "dirA/committed" as a file in the index?
>
> Of course,
>
>> Thanks for putting this together. I agree with the expected output in
>> each case, and I think this covers the cases we have seen (case 1 is
>> Michael's original report, case 2 is what I wrote in my mail, and case 3
>> is the one you just came up with). I can't think offhand of any others.
>
> Great, so I can build some tests reflecting those behaviors while
> waiting more inputs
