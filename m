From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] clean: confirm before cleaning files and directories
Date: Fri, 26 Apr 2013 16:41:19 +0800
Message-ID: <CANYiYbFzEoEgJzKsB_hiKNy2JCxaTDX30wXNjnzComOzJJF_cw@mail.gmail.com>
References: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
	<vpqfvydhfbx.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 26 10:41:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVeDi-0003pi-F8
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 10:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395Ab3DZIlY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 04:41:24 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48792 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492Ab3DZIlV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 04:41:21 -0400
Received: by mail-wi0-f178.google.com with SMTP id hm14so323401wib.5
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 01:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=hMabcMxG8OKuoDjU7rVjBmJvY4c5dGL02oNGEDJMzuo=;
        b=HDmQFxRhd+Dwg0HdyWCb4WZ2WT5vfpZYkTav2KOSdLXorA9SCY9JK3F7MxxNTn2BTN
         AuBNwtfvXOFu7Nsl8/uye1R9iea60nhdGuxHc7Tk9pfnYQPBfRvPkZqkt198ePU6jW5g
         dzNucAFDBftp8ygPqEEAlijq8vzkytUhIvXmUlJudEPlvSZPbQJ/2Ka6eyYh+Kshcs7s
         iNzNF8RLGBUgLE+EymwsVkaCQqEMnW/2NiFm2QhjA0jaXhM45rfoOLKu79jUhplmWVD0
         Pof7OE9AOq1cJiDXVz0X/eMQ83n34v7iAMTluouYk5ML/MITKlmAZuQ7sXsEYiGF9FY1
         BfVQ==
X-Received: by 10.180.12.235 with SMTP id b11mr2463245wic.13.1366965679482;
 Fri, 26 Apr 2013 01:41:19 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Fri, 26 Apr 2013 01:41:19 -0700 (PDT)
In-Reply-To: <vpqfvydhfbx.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222512>

2013/4/26 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> >  * run `git clean` in interactive sessions,
> >  * not a dry run,
> >  * and not quiet.
>
> Err, does this mean I'll have:
>
> $ git clean
> fatal: clean.requireForce defaults to true and neither -n nor -f give=
n; refusing to clean
> $ git clean --force

( you omit something, because nothing to clean won't trigger this
confirm dialog)

> Are you sure [y/n]?
>
> An optional confirmation dialog seems interesting, but activating it =
by
> default even with --force seems really weird.

I don't know how many programmers had been bitten by runing `git clean =
-fdx`,
but I bet there were some. I think safety should be put to the 1st plac=
e.
It is because "clean.requireForce" defaults to true, all people trend t=
o run
'git clean' with the '--force/-f' option.

Maybe we can do like this:

1. Set the default value of 'clean.requireForce' to false.
2. Show a error message and do nothing, if there is not 'clean.requireF=
orce'
    setting, but the user called with a '--force' flag.
    ( like a transition for the change of push.default in git 2.0)

any opinions?

>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/




--
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 18601196889
