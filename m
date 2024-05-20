Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836321350
	for <git@vger.kernel.org>; Mon, 20 May 2024 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198991; cv=none; b=Jic3MrACYqAJYrFNSavNL9YVwinUrUCWIgA0z7JLeuRTLc3tYhdx1DKlqMFbuu+j/zov9W8AidlFhj0n7UVtTDkbnV0xdpEKFc1KVlfrGvxfJkALy8/CkA6zVbmoXqujT0/gyltLeMAQkXvMJExcFi4tGTKyrhnVc0XDDt7yul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198991; c=relaxed/simple;
	bh=fnjFDfkkzxrfk/oMx5M/Xv8WZoNlaOb6AdLiMrik0kA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGNywBn1eMgofSp3RvB3oIlbLR4QQ066WcPkcePnLCNAJblfKORlg2KjRCZ5xnGTcWhaxY//1DFxWOpoUWjof8/U5xq7A5qukM9iyWtK+8SsnfJ5zvYHtCpzlIyu1qzgmgL2376BGzXR4R74jyHKAA0Io8cQJzB7cKMroFQNOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=a9JDU2zA; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="a9JDU2zA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FpNp2hKCvk5T5I9wwww8N8XP16EgpLM1wKJUQcIw93A=; t=1716198988; x=1716803788; 
	b=a9JDU2zAD7v4/T4knwOTrlY4eeCtUs/v3FOETGUR4do4b+r2TV29GXXolNSJcTyRqCJbj50nejy
	Idu5eagYUNsYTvHfmlrhUf30NPmTyqO4aDqPBUlgSRyE6D8aFgCUFiYmBAY7m83XngKzMKj1guUCq
	vRKGNkhpBwZZZ1IxsPqYQVUaZkjmLY/UadLVvkD7VEGjo2lWFRy6xCoGA3Ch9ODYn/xomd/xsATOC
	LtKI6PA72xxnUZPr25ve7WpbAV1EePFjdZXKE36k4ESKuqQHb11Vk62rdDsXSH0X8pO5Uqh1GlBgl
	OvIx2bAlSCKAKcDJ/YQ76azrvxYeSMd+e4rA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s8zkn-000000047rU-1mMT; Mon, 20 May 2024 11:56:25 +0200
Received: from dynamic-077-191-101-125.77.191.pool.telefonica.de ([77.191.101.125] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s8zkn-00000001Lkl-0vji; Mon, 20 May 2024 11:56:25 +0200
Message-ID: <506815cf70ea114a3c4177a779481fdc13bca39b.camel@physik.fu-berlin.de>
Subject: Re: chainlint test failing on Linux sparc64
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Date: Mon, 20 May 2024 11:56:24 +0200
In-Reply-To: <CAPig+cQL73gVDDSH_=8Y6D0Pro58W1O2Rb-hettVcfZudXjOZQ@mail.gmail.com>
References: 
	<8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de>
	 <CAPig+cS+BcQ2t564m8Q4GO+MAThgq8pV0fEFD4S0FBfwokO2Ng@mail.gmail.com>
	 <054f58c2de4af289008f28b140d4a4c9ab56f084.camel@physik.fu-berlin.de>
	 <bdbf99ae4d6e3669b3506a7d4a26730aa9cd0ed4.camel@physik.fu-berlin.de>
	 <CAPig+cQL73gVDDSH_=8Y6D0Pro58W1O2Rb-hettVcfZudXjOZQ@mail.gmail.com>
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

On Mon, 2024-05-20 at 05:36 -0400, Eric Sunshine wrote:
> That's the point at which chainlint.sed was replaced with
> chainlint.pl. It also leads to the same supposition expressed earlier
> that the "actual" file seems to be empty for some reason, perhaps
> because one of the commands which creates it is failing somehow. At
> that point in time, the creation command for "actual" in t/Makefile
> was:
>=20
>     $(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
>         grep -v '^[ ]*$$' >'$(CHAINLINTTMP_SQ)'/actual && \
>=20
> which uses `grep` rather than the `sed` used in the present-day
> t/Makefile. This may imply that Perl is somehow suspect or that
> PERL_PATH or PERL_PATH_SQ in t/Makefile are incorrectly set, or that
> t/chainlint.pl itself is not generating any output for some reason.
>=20
> After running:
>=20
>     cd t
>     make check-chainlint
>=20
> what is the output of:
>=20
>     ls -l chainlinttmp

(sid_sparc64-dchroot)glaubitz@stadler:~/git/t$ ls -l chainlinttmp
total 32
-rw-r--r-- 1 glaubitz glaubitz     0 May 20 09:54 actual
-rw-r--r-- 1 glaubitz glaubitz 14797 May 20 09:54 expect
-rw-r--r-- 1 glaubitz glaubitz 15086 May 20 09:54 tests
(sid_sparc64-dchroot)glaubitz@stadler:~/git/t$

> For me the output using the latest "master" branch is:
>=20
>     % ls -l chainlinttmp
>     -rw-------  1 me  me  14797 May 20 05:26 actual
>     -rw-------  1 me  me  14797 May 20 05:26 expect
>     -rw-------  1 me  me  15086 May 20 05:26 tests
>=20
> My suspicion is that "actual" will have size 0 for you. If that's the
> case, I'd suggest running the commands from the "check-chainlint"
> target in t/Makefile manually one at a time to see if you can figure
> out which is failing. For instance:
>=20
>     % ./chainlint.pl --emit-all chainlinttmp/tests

It does not generate any output for me:

(sid_sparc64-dchroot)glaubitz@stadler:~/git/t$ ./chainlint.pl --emit-all ch=
ainlinttmp/tests
(sid_sparc64-dchroot)glaubitz@stadler:~/git/t$

> If that produces output, then that's a good sign. Try capturing that
> output and feeding it to the `sed` command:
>=20
>     % ./chainlint.pl --emit-all chainlinttmp/tests >lint.out
>     % sed -e 's/^[1-9][0-9]* //' lint.out
>=20
> If that produces output, then something else is going wrong (such as
> PERL_PATH or PERL_PATH_SQ being incorrect).

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
