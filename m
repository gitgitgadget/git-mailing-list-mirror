Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD853E2D
	for <git@vger.kernel.org>; Mon, 20 May 2024 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202976; cv=none; b=s0qoeT4DT0bundPJ5srnjOk1etxDXneIjHX1fxr8MEmrQ6bxPmEe9MuaWeRcMTjDoIcexE6HwXSYgpEWSDFsqbaYUST19S0C0O2DlWd+UY0K/QcJoGShtgtmPlGcSNJG5obbhOATUfvpZ5DFGNZd6J9eiZeGMlbgD5iyGgcZDEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202976; c=relaxed/simple;
	bh=XYySrmyUx8xnDBOxJimh9wIKyebAACrbAkzC3TsGWTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cnQh6VWUgYuv2oNQF6NgZ1P5waous9qylTaKInSZSdCTQ29tDUjyDuPue1t3r2aFwi1gzF4MF9m3576LSZtr6r6L+jwMpBCnc8Gvt/iwZRc90vouvI4OyoG2xFYQqRn2rkS+OGzPnNfIuXLcZXdbAhHJQV3FV+VJVxNaQgpUwoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=BG2/qint; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="BG2/qint"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tuHi90wlhFK9wlYqUvMLjqnOE1Zzls4AZzj2tYFBF8E=; t=1716202972; x=1716807772; 
	b=BG2/qintX+QQAS+ENpFuVNAQmcRCvVHrayInZUZd1XGBHh4+GXeba3mX90FrYA4VHSGoNkXEh1G
	uLOnagF9F/PJEj6AFOu/n7oAYgNEwG4NFqVjHsIZygVgsAocAPq9X6ZzT9fPvesmQyVQHHXuPnZZB
	x6ymI1cfy0iVN+qxBmEOjB345digG0qK7OIqg3Qmj8N9/YxAoSharGiOuekVa5JMGi+Vj42WXt2RT
	KFXD+5/l4RSN9tKqzBh9AcZ7TwKVarnYfN3WsuyilOtvJKKJtsuCHfpfJchD183+AbnL5j0sFjDwM
	UpUc3ZgtXPfpmlbNlLha+XwkMZ4wy5cYiljw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s90n3-00000000BeX-1CNt; Mon, 20 May 2024 13:02:49 +0200
Received: from dynamic-077-191-101-125.77.191.pool.telefonica.de ([77.191.101.125] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s90n2-00000001UGl-3cVT; Mon, 20 May 2024 13:02:49 +0200
Message-ID: <46caaa2d204844cbe5625428ece5b2fe8656364b.camel@physik.fu-berlin.de>
Subject: Re: chainlint test failing on Linux sparc64
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Date: Mon, 20 May 2024 13:02:46 +0200
In-Reply-To: <7acbd5c6c68bd7ba020e2d1cc457a8954fd6edf4.camel@physik.fu-berlin.de>
References: 
	<8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de>
	 <CAPig+cS+BcQ2t564m8Q4GO+MAThgq8pV0fEFD4S0FBfwokO2Ng@mail.gmail.com>
	 <054f58c2de4af289008f28b140d4a4c9ab56f084.camel@physik.fu-berlin.de>
	 <bdbf99ae4d6e3669b3506a7d4a26730aa9cd0ed4.camel@physik.fu-berlin.de>
	 <CAPig+cQL73gVDDSH_=8Y6D0Pro58W1O2Rb-hettVcfZudXjOZQ@mail.gmail.com>
	 <CAPig+cQLsUTpjiZ_TXh2GJAS=tJScUWYxiuR87rtwdTu8H9PXw@mail.gmail.com>
	 <7acbd5c6c68bd7ba020e2d1cc457a8954fd6edf4.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Eric,

On Mon, 2024-05-20 at 12:02 +0200, John Paul Adrian Glaubitz wrote:
> > which probably explains the behavior you're experiencing. To fix it,
> > we'll need to see the output you get from:
> >=20
> >     cat /proc/cpuinfo
>=20
> Here you go:
>=20
> glaubitz@stadler:~$ cat /proc/cpuinfo=20
> cpu             : UltraSparc T4 (Niagara4)
> fpu             : UltraSparc T4 integrated FPU
> pmu             : niagara4
> prom            : OBP 4.38.16 2018/11/28 07:24
> type            : sun4v
> ncpus probed    : 48
> ncpus active    : 48
> D$ parity tl1   : 0
> I$ parity tl1   : 0
> cpucaps         :
> flush,stbar,swap,muldiv,v9,blkinit,n2,mul32,div32,v8plus,popc,vis,vis2,AS=
IBlkInit,fmaf,vis3,hpc,ima,pause,cbcond,aes,des,kasumi,camellia,md5,sha1,sh=
a256,sha512,mpmul,montmul,montsqr,crc32c
> Cpu0ClkTck      : 00000000a9beeee4
> Cpu1ClkTck      : 00000000a9beeee4
> (...)
> State:
> CPU0:           online
> CPU1:           online
> CPU2:           online
> CPU3:           online

In order to verify this theory, I made the following temporary change:

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 556ee91a15..63cac942ac 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -718,7 +718,7 @@ sub ncores {
        # Windows
        return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSO=
RS});
        # Linux / MSYS2 / Cygwin / WSL
-       do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^processor[=
\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
+       do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^processor[=
\s\d]*:||^CPU[\d]*:/, <>)); } if -r '/proc/cpuinfo';
        # macOS & BSD
        return qx/sysctl -n hw.ncpu/ if $^O =3D~ /(?:^darwin$|bsd)/;
        return 1;

and I confirm that this fixes the problem.

Let me whip up a patch and post it here.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
