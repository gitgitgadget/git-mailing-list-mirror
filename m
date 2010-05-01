From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: Integration-Manager Workflow and merges
Date: Sat, 1 May 2010 05:40:20 +0100
Message-ID: <y2g86ecb3c71004302140p43c2a778xe3015192e5227dae@mail.gmail.com>
References: <4BDB6FA1.4070802@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian Andres Mancilla Matta <smancill@alumnos.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat May 01 06:45:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O84Zu-0007nF-Gv
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 06:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812Ab0EAEkm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 May 2010 00:40:42 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49284 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab0EAEkl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 May 2010 00:40:41 -0400
Received: by pvg7 with SMTP id 7so508820pvg.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 21:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=AE9vrfI8Mb9Sl3o9o2pMyPCCA6WB60aXMGZ4TZHu1Tg=;
        b=DzKf76Kn1OQZ8MeHuqPsM04r4V7uM9j2bO3rv9Q6nbAu2CJMOIQbEH0bCMPXUD6WKF
         9tcDrsbJuBdt/PYnttaekzI4l1tX4TTc6JYidtCmWVray2gFlfeDQMic5BmPU7NwRguM
         4a3ikj2877KBCQjbl/sdo7E4HN6h7y/PLXBsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=gu8zXMCNVAAVWTtEITy4+6h5JNGjt3kmWSGFGC2cD0Pt9zAOQQRWD5PokMPuKIhJ4/
         /Elozi8MLrMTVB7Vg+9+DVbqiLaWSXzO28ets/JCvylNjLwMrI3801fR8GjcLJ7s9IEc
         8bRh8+Awb1n5s/MeuYegCMi1zTNlFXgtg3riQ=
Received: by 10.142.152.39 with SMTP id z39mr1406370wfd.336.1272688840107; 
	Fri, 30 Apr 2010 21:40:40 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Fri, 30 Apr 2010 21:40:20 -0700 (PDT)
In-Reply-To: <4BDB6FA1.4070802@alumnos.inf.utfsm.cl>
X-Google-Sender-Auth: ae6052135920ed83
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146078>

On 1 May 2010 01:02, Sebastian Andres Mancilla Matta
<smancill@alumnos.inf.utfsm.cl> wrote:
> And this is my problem. We have two differents commits (9 and 12) doi=
ng
> the same thing. If Dev1 pushes his changes again, and sends a new pul=
l
> request, what will be the state of the repository? I think it
> will look like this at the end
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A01---2---3-----7----8--12-----------13 =C2=A0=
 devel
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0\/ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 /\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4---5-=
--6--9---10---11
>
> but the history is a mess with those two merges doing the same. And t=
his
> is only with one developer doing a merge. If all the others do the sa=
me,
> it will become a pain.
>
>

As far as I know git will not do a second same merge.

I'm not good at these but IMHO commit 10 will be a criss-cross merge
of just 9 & (8,12). Git knows that it has commit 7 in the branch with
tip 11.

Try out this on the command-line and notice which parents are listed
in the $git log or use gitk to see how git merged stuff. Also run gitk
on large compex repositories to see how all the different merges get
done.

History is a mess by definition =3D) git doesn't care or assume that an=
y
branch is more important than the other ;-)

I don't understand what kind of pain does this cause? doing $ git log
devel..HEAD will show you just the outstanding commit Nr11 =3D)

With regards,

Dmitrijs.
