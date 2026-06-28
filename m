Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65ACF507
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664680; cv=none; b=Omt5M3cZeHPG3VeI3utnG+qnamJDWkCGH75U+PO1o/rpTFI3tIdn3DWcxdNz4Qg4E/Dt9trXjijQSvGv3Dv5jxiz5EV2YWoPf2k0iTFk/BBfEsDjx7nGzIfCcEozrv/ev9nez0fzymepzxFt+KSClOo77Qt7JkI6zqs+uTrWICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664680; c=relaxed/simple;
	bh=phskpFff7IEsr0Kkzllt6n52RAFjzcKBTTe2YRXt1uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ag9OxhuDdlTRkhJWacBuzpn3StzVCnvTXxXmf6F4hm60Ey8blTtxFzqHSpZJ6dm/8+E0IE6joGjauZkY1lvsnU0ZfGZiwfk9AU0sSx97zL+kX8JHU6MTWoDfUWAeiq/V4YgcObzzIk1AYV+0Yz+IqVfxviI2+PyFGmDgPuAX3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=EkyX+NEF; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="EkyX+NEF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1782664670; x=1783331336; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:mail-followup-to:openpgp:blahblahblah:
  mime-version:content-type:content-transfer-encoding:author:from:subject:
  date:to:cc:resent-author:resent-date:resent-from:resent-sender:resent-to:
  resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
  mime-version:content-type:content-transfer-encoding:content-disposition:
  content-id:content-description:message-id:mail-followup-to:openpgp:
  blahblahblah; bh=R89U8wl7qWo7pXvkQOeNnGsMoFrsMjtkB9qL7Xv6o/A=;
 b=EkyX+NEFdBzMVkGJJ/ZxgUY/hlaqcNP6z5tkzdaWgVQYCzTAhd+e0tQHq34T4VO3f6zdw6XB
  s9M+P3NotPsAm0VCtQv0jnMSdTebbl5yOnSBMFHZCYmYKFvCudj6PdSjQJUqPKZzpRLyaQqU5s
  Tae4jaiSSH14pDz4yQjJXMsf70GjO/rMTuEeWWO9IuqYN7SKCx4LxMaZ9inMdLU7oX/4mSwyUn
  T15wlJYeMXWXukZr1AfO8TlXUvZUwiyTbENfpDRVZn+Mkhs38L4qKPl6G6xJigkrfPZQMHRiiq
  FrZcKki8sYJBWN2+ffulROPLzRojXrEInPD1qFDHeLIHbMDg==
Date: Sun, 28 Jun 2026 18:37:48 +0200
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org, Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: 2.54.0: fyi: endless loop at 100% CPU
Message-ID: <20260628163748.ewryhWxh@steffen%sdaoden.eu>
In-Reply-To: <CAC2Qwm+v2pRp30TYJpy8Wxzb7gbX+nzybZ_3A99cHb-xjjpCnQ@mail.gmail.com>
References: <CAC2Qwm+48Gpj=AWHzx-nO00bwVfuYoGiwd=3gExbybcOyHC45Q@mail.gmail.com>
 <20260627201558.Bw6A-jbx@steffen%sdaoden.eu>
 <CAC2Qwm+v2pRp30TYJpy8Wxzb7gbX+nzybZ_3A99cHb-xjjpCnQ@mail.gmail.com>
Mail-Followup-To: Michael Montalbo <mmontalbo@gmail.com>,
 git@vger.kernel.org, Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.10.0-alpha-44-g9d85ccf596
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Michael Montalbo wrote in
 <CAC2Qwm+v2pRp30TYJpy8Wxzb7gbX+nzybZ_3A99cHb-xjjpCnQ@mail.gmail.com>:
 |On Sat, Jun 27, 2026 at 1:16=E2=80=AFPM Steffen Nurpmeso <steffen@sdaoden=
.eu> \
 |wrote:
 |>
 |> Thanks for these pointers, i did not know about such configuration
 |> variables.  I will set them like you show.
 |
 |No problem! Just to clarify, I'm not sure you should actually use those
 |configuration values verbatim. I was more pointing in the direction of
 |potentially relevant options for debugging / working around the issue.

We'll see.  But if there was some kind of "with love from canada"
misconfiguration -- i have seen quite a bit of those, and
permanent sub-second page reload was one of those effects, in
a browser though .. and git has a little road 'till it gets to
that stage (i hope) -- then maybe these settings .. Or i have to
tweak.

Restartable "fetch" is likely not on that roadmap of git -- that
would (have) be(en) so cool.  (But for years i now have
a WireGuard VPN and go through that, which has improved my TCP
connectivity / stability massively.  But it is still a thriller to
go for some rate-limited fetch of large size ..)

Oh.  Maybe i see.

  $ git ls-remote https://gitlab.xiph.org/xiph/opus.git
  fatal: unable to access 'https://gitlab.xiph.org/xiph/opus.git/': Operati=
on too slow. Less than 1000 bytes/sec transferred the last 10 seconds
  $ git ls-remote https://gitlab.xiph.org/xiph/opus.git
  fatal: unable to access 'https://gitlab.xiph.org/xiph/opus.git/': Operati=
on too slow. Less than 500 bytes/sec transferred the last 10 seconds
  $ git ls-remote https://gitlab.xiph.org/xiph/opus.git
  fatal: unable to access 'https://gitlab.xiph.org/xiph/opus.git/': Operati=
on too slow. Less than 500 bytes/sec transferred the last 21 seconds

It succeeds with

  lowSpeedLimit =3D 500
  lowSpeedTime =3D 33

But at least it does not busy loop:

  steffen   2960  2959   0  0.0   2738   2016 S+   00:00:00 18:26 pts/4    =
/usr/lib/git-core/git remote-https https://gitlab.xiph.org/xiph/opus.git ht=
tps://gitlab.xiph.org/xiph/opus.git
  steffen   2961  2960   0  0.0  41213  11316 S+   00:00:00 18:26 pts/4    =
/usr/lib/git-core/git-remote-https https://gitlab.xiph.org/xiph/opus.git ht=
tps://gitlab.xiph.org/xiph/opus.git

Unfortunately no info where and why it busy looped.  If it would
be non-blocking I/O and .. in this area, one could understand
a bit.  Some ticks-per-sec limit (without X progress) is not
configurable?  I am not really keen to create a rlimit wrapper
for git, or whatever.  (I have limiting cgroups, but still.)

A nice Sunday,
Ciao and greetings from Germany,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
