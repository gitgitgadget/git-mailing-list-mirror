From: Alexei Sholik <alcosholik@gmail.com>
Subject: Re: tracking submodules out of main directory.
Date: Tue, 28 Jun 2011 13:05:10 +0300
Message-ID: <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	<7vvcvrxlol.fsf@alter.siamese.dyndns.org>
	<4E08C89E.5020109@web.de>
	<7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	henri GEIST <henri.geist@flying-robots.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 12:09:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbVEn-00008X-30
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 12:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab1F1KH0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jun 2011 06:07:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61461 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756573Ab1F1KFL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2011 06:05:11 -0400
Received: by gwaa18 with SMTP id a18so2612gwa.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ndgcwxz4pdEXmt6hQfD1SvT9QLpSmkuVQH0YHbkB4S8=;
        b=OS4KOP998aYjIThtkfy2vjS6Xd6MGDMh+QgYsSCkxIlNbslWm+iz9gQYCvXQuTd/yW
         U7o2DNUAFNNiIN+/kQ+ONX1pbk77vJZWoM1h+KSTVAMkJbJ/Y3iqHeTLQ+OM98QJQLsL
         FfSORu0We/zr4gQloc7VIUytB4/eW2CXY/IIM=
Received: by 10.236.157.67 with SMTP id n43mr10593247yhk.95.1309255510505;
 Tue, 28 Jun 2011 03:05:10 -0700 (PDT)
Received: by 10.146.168.16 with HTTP; Tue, 28 Jun 2011 03:05:10 -0700 (PDT)
In-Reply-To: <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176389>

On 27 June 2011 22:05, Junio C Hamano <gitster@pobox.com> wrote:
> That is what I called "there is no direct way". Wouldn't it be nicer =
if
> the .gitmodules file in the superproject said something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[module "project one"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D proje=
ct1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends =3D li=
b1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[module "lib1"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D lib1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D ...
>
> and then "git submodule init project1" run by the end user implied ru=
nning
> also "git submodule init lib1"?

This is a very nice idea. In my workflow, I find it that I more often
need to clone a repo _including_ its submodules, because the top-level
project won't compile without them. If we had a way to specify
dependencies on submodules, `git pull` could automatically init and
update them.

If a user really wants to clone only the top-level repo without
submodules, git could provide him with an option for `git pull` (like
`git pull --shallow`) to do just that. I think this second scenario is
less common, so it is more reasonable to have a '--shallow' option for
it, instead of '--recursive' counterpart.

--=20
Best regards,
Alexei Sholik
