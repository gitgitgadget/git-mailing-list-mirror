From: "Paolo Teti" <paolo.teti@gmail.com>
Subject: Re: git-rebase (1.5.0.6) errors
Date: Fri, 18 May 2007 17:08:02 +0200
Message-ID: <34a7ae040705180808t1eebd9f0p5a4046d7b281c56e@mail.gmail.com>
References: <Pine.LNX.4.64.0705181130570.28356@kivilampi-30.cs.helsinki.fi>
	 <34a7ae040705180331x1a86782fh3b2c6a87db32030e@mail.gmail.com>
	 <Pine.LNX.4.64.0705181640270.14736@kivilampi-30.cs.helsinki.fi>
	 <34a7ae040705180739i38d4853ci95717407e81add7b@mail.gmail.com>
	 <864pmamb6b.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>,
	git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 18 17:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp43w-000430-OC
	for gcvg-git@gmane.org; Fri, 18 May 2007 17:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849AbXERPII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 11:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755864AbXERPII
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 11:08:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:15206 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755724AbXERPIF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 11:08:05 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1367434nza
        for <git@vger.kernel.org>; Fri, 18 May 2007 08:08:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KkMe3fYkQDm1wl1K+qVVDwLhFjRBKgIDsQtjMNAppVe6+XW78W4jEljKRs9Aj09Z20c+HSluf36qLiT8wDYEz7ifpFhtH+212vI2t73QJe0cP+Z3i23ofV8wHCf3/TNcPDvUv/rMu4j1JakJvEEY7p2eEuMVvSP/KRFHk2sdyf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SYF5opT8Lg89pIVrJdN5xIGd9PE5nZ/7WEUgeuS9Pr4rIlSspc5iK7xKFliRP21ZZZnddOG03jeQyoVI0aTmPi8DsSLGgnqgYkS95ws6AGIuDE8V9TrEerIUAlPK/E1DwGyBkPS30wdM0YeoCXHej4BsJNr3HwNhg7ti/CKQg7A=
Received: by 10.115.16.1 with SMTP id t1mr870982wai.1179500882688;
        Fri, 18 May 2007 08:08:02 -0700 (PDT)
Received: by 10.115.58.17 with HTTP; Fri, 18 May 2007 08:08:02 -0700 (PDT)
In-Reply-To: <864pmamb6b.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47613>

2007/5/18, David Kastrup <dak@gnu.org>:
> "Paolo Teti" <paolo.teti@gmail.com> writes:
>
> > 2007/5/18, Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>:
> >
> >> ...sizeof(size_t) =3D=3D sizeof(int) should hold...
> >
> > what I have reported is not necessarily the cause of your error. Ye=
s
> >
> > BUT size_t is UNSIGNED and ssize_t is SIGNED.
> >
> > The problem is that We store a signed return value into a unsigned =
variable.
> > So the check against -1 has no sense.
>
> When comparing signed with unsigned types, the signed values are firs=
t
> converted to unsigned, then possibly zero-extended.
>
> So
>
> (unsigned)-1 =3D=3D (int)-1
>
> but
>
> (unsigned long)-1 =3D=3D (long)-1
>
> only when sizeof(long)=3D=3Dsize(int)
>
> > and please note that also sizeof(int) =3D=3D sizeof(unsigned int), =
but
> > -1 is a signed int !!
>
> So?
>

Stupid me.. OK is =3D=3D -1 and not < 0..

Probably today  I'm drunk without drink ..

Enjoy
