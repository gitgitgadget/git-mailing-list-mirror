Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE7210E7
	for <git@vger.kernel.org>; Mon, 20 May 2024 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199360; cv=none; b=Bw7AYRuPn1SvKeFZUvt0odL72bC2XIVs34tIs2ZqjwnwDlQKFg2jEzdMjgUF5Dbiy9ChndH0pd1W8gZZY5auCPkXX1WQAsGE1/yhBc8Duom9jxF0gkrsfn/an9GndTjDXjYvYTfzAXy5gHqLBlXmtYs/190Se3F5pT1JUMxeX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199360; c=relaxed/simple;
	bh=JVbyjUy3/AMBv+8xTZ4caDegu06wgfpIGMQW817jpm0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bt7zsrIcrOmMDpa/IYYgdQwDTNcEWmAXT6uTbdJTd0eohyG0EcmnFSete6wtHXK32u53ZG5nvG6pvYsVFAnELlzoWz72SvAPA7P/CHghEWaoDQldGzcItuOF5HPyiTZXGg19VQTmB+qtrv5HV2sdnr870Lc4lH/N3ZqM7mEhxaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Fird2lDJ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Fird2lDJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qylZ5lJIknfs/izJTrv5pVL1qpHr80ZMzvo8qFnh/xo=; t=1716199357; x=1716804157; 
	b=Fird2lDJMadl4n3Ye8mEBiSzZ47w0ZoK85kW54wOkuUQ3JXflxM6jt8nouHF78m54lkwyQjiTVp
	R22IkDOQ9KqPFvBYbgp/UmAxFrPnIuLas+f4MEdsXA6OiOVZwNY/k5QaJvVsw9nR/6MFxv570ewSI
	nHBZaf2SyutJSS4QUmnlncHj50kijwNo16VpayaYjXIvvoTYoBGaak90gfi5sfzOVHqsc4quaY+uG
	O6D0ouG4wcee8fmN8r652IFC5XWIayFC4LwCcKIRNB+iMAjJjQ8C7/lwrSiCCqW5EpjThpUyZZBnf
	NFq0Lt70ZM9N5nNqH3QajuQ18zIkZ+vd/K4A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s8zqk-00000004AIH-3niG; Mon, 20 May 2024 12:02:34 +0200
Received: from dynamic-077-191-101-125.77.191.pool.telefonica.de ([77.191.101.125] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s8zqk-00000001MbI-2zCH; Mon, 20 May 2024 12:02:34 +0200
Message-ID: <7acbd5c6c68bd7ba020e2d1cc457a8954fd6edf4.camel@physik.fu-berlin.de>
Subject: Re: chainlint test failing on Linux sparc64
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Date: Mon, 20 May 2024 12:02:34 +0200
In-Reply-To: <CAPig+cQLsUTpjiZ_TXh2GJAS=tJScUWYxiuR87rtwdTu8H9PXw@mail.gmail.com>
References: 
	<8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de>
	 <CAPig+cS+BcQ2t564m8Q4GO+MAThgq8pV0fEFD4S0FBfwokO2Ng@mail.gmail.com>
	 <054f58c2de4af289008f28b140d4a4c9ab56f084.camel@physik.fu-berlin.de>
	 <bdbf99ae4d6e3669b3506a7d4a26730aa9cd0ed4.camel@physik.fu-berlin.de>
	 <CAPig+cQL73gVDDSH_=8Y6D0Pro58W1O2Rb-hettVcfZudXjOZQ@mail.gmail.com>
	 <CAPig+cQLsUTpjiZ_TXh2GJAS=tJScUWYxiuR87rtwdTu8H9PXw@mail.gmail.com>
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

On Mon, 2024-05-20 at 05:58 -0400, Eric Sunshine wrote:
> On Mon, May 20, 2024 at 5:36=E2=80=AFAM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > My suspicion is that "actual" will have size 0 for you. If that's the
> > case, I'd suggest running the commands from the "check-chainlint"
> > target in t/Makefile manually one at a time to see if you can figure
> > out which is failing. For instance:
> >=20
> >     % ./chainlint.pl --emit-all chainlinttmp/tests
>=20
> This reminded me of an earlier report in which chainlint.pl was
> producing no output for "actual" on Linux for s390x processors. That
> was due to /proc/cpuinfo producing results which the script wasn't
> expecting. It was fixed by 1f51b77f4f (chainlint.pl: fix /proc/cpuinfo
> regexp, 2022-11-22)[1]. At the time of that patch, I noted[2]:

Yeah, the output for /proc/cpuinfo is not standardized across architectures=
,
unfortunately.

>     A separate problem is that chainlint.pl doesn't fall back to a
>     sensible non-zero value if ncores() returns 0 (or some other
>     nonsense value). That is, of course, outside the scope of the
>     well-focused problem fix which this standalone patch addresses. I
>     may end up submitting a fix separately to make it fall back
>     sensibly.
>=20
> which probably explains the behavior you're experiencing. To fix it,
> we'll need to see the output you get from:
>=20
>     cat /proc/cpuinfo

Here you go:

glaubitz@stadler:~$ cat /proc/cpuinfo=20
cpu             : UltraSparc T4 (Niagara4)
fpu             : UltraSparc T4 integrated FPU
pmu             : niagara4
prom            : OBP 4.38.16 2018/11/28 07:24
type            : sun4v
ncpus probed    : 48
ncpus active    : 48
D$ parity tl1   : 0
I$ parity tl1   : 0
cpucaps         :
flush,stbar,swap,muldiv,v9,blkinit,n2,mul32,div32,v8plus,popc,vis,vis2,ASIB=
lkInit,fmaf,vis3,hpc,ima,pause,cbcond,aes,des,kasumi,camellia,md5,sha1,sha2=
56,sha512,mpmul,montmul,montsqr,crc32c
Cpu0ClkTck      : 00000000a9beeee4
Cpu1ClkTck      : 00000000a9beeee4
Cpu2ClkTck      : 00000000a9beeee4
Cpu3ClkTck      : 00000000a9beeee4
Cpu4ClkTck      : 00000000a9beeee4
Cpu5ClkTck      : 00000000a9beeee4
Cpu6ClkTck      : 00000000a9beeee4
Cpu7ClkTck      : 00000000a9beeee4
Cpu8ClkTck      : 00000000a9beeee4
Cpu9ClkTck      : 00000000a9beeee4
Cpu10ClkTck     : 00000000a9beeee4
Cpu11ClkTck     : 00000000a9beeee4
Cpu12ClkTck     : 00000000a9beeee4
Cpu13ClkTck     : 00000000a9beeee4
Cpu14ClkTck     : 00000000a9beeee4
Cpu15ClkTck     : 00000000a9beeee4
Cpu16ClkTck     : 00000000a9beeee4
Cpu17ClkTck     : 00000000a9beeee4
Cpu18ClkTck     : 00000000a9beeee4
Cpu19ClkTck     : 00000000a9beeee4
Cpu20ClkTck     : 00000000a9beeee4
Cpu21ClkTck     : 00000000a9beeee4
Cpu22ClkTck     : 00000000a9beeee4
Cpu23ClkTck     : 00000000a9beeee4
Cpu24ClkTck     : 00000000a9beeee4
Cpu25ClkTck     : 00000000a9beeee4
Cpu26ClkTck     : 00000000a9beeee4
Cpu27ClkTck     : 00000000a9beeee4
Cpu28ClkTck     : 00000000a9beeee4
Cpu29ClkTck     : 00000000a9beeee4
Cpu30ClkTck     : 00000000a9beeee4
Cpu31ClkTck     : 00000000a9beeee4
Cpu32ClkTck     : 00000000a9beeee4
Cpu33ClkTck     : 00000000a9beeee4
Cpu34ClkTck     : 00000000a9beeee4
Cpu35ClkTck     : 00000000a9beeee4
Cpu36ClkTck     : 00000000a9beeee4
Cpu37ClkTck     : 00000000a9beeee4
Cpu38ClkTck     : 00000000a9beeee4
Cpu39ClkTck     : 00000000a9beeee4
Cpu40ClkTck     : 00000000a9beeee4
Cpu41ClkTck     : 00000000a9beeee4
Cpu42ClkTck     : 00000000a9beeee4
Cpu43ClkTck     : 00000000a9beeee4
Cpu44ClkTck     : 00000000a9beeee4
Cpu45ClkTck     : 00000000a9beeee4
Cpu46ClkTck     : 00000000a9beeee4
Cpu47ClkTck     : 00000000a9beeee4
MMU Type        : Hypervisor (sun4v)
MMU PGSZs       : 8K,64K,4MB,256MB,2GB
State:
CPU0:           online
CPU1:           online
CPU2:           online
CPU3:           online
CPU4:           online
CPU5:           online
CPU6:           online
CPU7:           online
CPU8:           online
CPU9:           online
CPU10:          online
CPU11:          online
CPU12:          online
CPU13:          online
CPU14:          online
CPU15:          online
CPU16:          online
CPU17:          online
CPU18:          online
CPU19:          online
CPU20:          online
CPU21:          online
CPU22:          online
CPU23:          online
CPU24:          online
CPU25:          online
CPU26:          online
CPU27:          online
CPU28:          online
CPU29:          online
CPU30:          online
CPU31:          online
CPU32:          online
CPU33:          online
CPU34:          online
CPU35:          online
CPU36:          online
CPU37:          online
CPU38:          online
CPU39:          online
CPU40:          online
CPU41:          online
CPU42:          online
CPU43:          online
CPU44:          online
CPU45:          online
CPU46:          online
CPU47:          online
glaubitz@stadler:~$

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
