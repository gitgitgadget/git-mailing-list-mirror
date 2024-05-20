Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163F8BEA
	for <git@vger.kernel.org>; Mon, 20 May 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716195876; cv=none; b=NK6zC9xoqFLTyiZYkvNYbg+YZdEw6OhXJGn5P+GgJXWiwnEGAC85B1kp7rzKOZqHVKlHFog07G4unc0L/7T+NCOI0pRRpLw+EafSJjnd9cu2p7YGEFMzWag4x1Yoi2ODnv5CFBrdSZ+YCWx73PL1XgcQz6Nqoq3O3ImFfZE7qUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716195876; c=relaxed/simple;
	bh=b6o8ZrTGZwj1FGTk6q9FqF6zW0MS1mnViTMeIZ21YUs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRyizHkSx/NO7xMl/G/S15HrvIBS1DTtwQwPhcBo4nMDDPRVjhUpFmRuYTS+pUt6IIGvJL7WL5r5K1XUm145aA5Vc7FnSJCMVoltURJxbVAPGEz99eBoJ+T/Tgl8v+ycdsPspzhh4iMvQQP3yv4r1yIfKKEwLLXQcZtLAtxqm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=TXL6J2v4; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="TXL6J2v4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ti+S/3/9XbiTrzQW94uuQmQId3n3csbMMDG7/o+d+rc=; t=1716195873; x=1716800673; 
	b=TXL6J2v4bu8D3Cfdm1Tvwm8QECSzFrNmWYZuCa0mGdip4OqkDjxacVisk3S7Gm02DnhhfQeF1jJ
	y9pbxZ/X1eBsJJjDWgBVJhq5KVqPf6I2M8otvMRkbKUvwDlPIzAczKFukLZZdERAxuvWm7XBnxpYg
	rSJ3K7FG5ITwBVme3g7VEwUKtrvy4T8cSo4f598am0VLr1gie+82IVb+p50OyDA27WTc7ch+fJyY1
	bVtY+hrcibyWFLqhbxfZqffQbji6jI8pcEdbLc1U7aCQ91FSzsuXq+xlyycMy092cIpV52sfhZ7s9
	MDd4+aB5ZmWAyNf62n6izG2Ft44O6eqqp/YQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s8ywX-00000003y3u-2Q9Q; Mon, 20 May 2024 11:04:29 +0200
Received: from dynamic-077-191-101-125.77.191.pool.telefonica.de ([77.191.101.125] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s8ywX-00000001FgJ-1ado; Mon, 20 May 2024 11:04:29 +0200
Message-ID: <bdbf99ae4d6e3669b3506a7d4a26730aa9cd0ed4.camel@physik.fu-berlin.de>
Subject: Re: chainlint test failing on Linux sparc64
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Date: Mon, 20 May 2024 11:04:28 +0200
In-Reply-To: <054f58c2de4af289008f28b140d4a4c9ab56f084.camel@physik.fu-berlin.de>
References: 
	<8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de>
	 <CAPig+cS+BcQ2t564m8Q4GO+MAThgq8pV0fEFD4S0FBfwokO2Ng@mail.gmail.com>
	 <054f58c2de4af289008f28b140d4a4c9ab56f084.camel@physik.fu-berlin.de>
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

Hi,

On Mon, 2024-05-20 at 10:24 +0200, John Paul Adrian Glaubitz wrote:
> I think the problem seems to be that the testsuite is not properly invoke=
d
> at all. When I run the testsuite with v2.37.7, all tests are run and pass=
,
> but starting with v2.38.0, it only runs the chainlint test and exists.
>=20
> I am trying to bisect this now.

Bisecting was successful and has lead me to this commit:

d00113ec3474a1652a73c11695c7e7b5182d80a7 is the first bad commit
commit d00113ec3474a1652a73c11695c7e7b5182d80a7
Author: Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu Sep 1 00:29:46 2022 +0000

    t/Makefile: apply chainlint.pl to existing self-tests
   =20
    Now that chainlint.pl is functional, take advantage of the existing
    chainlint self-tests to validate its operation. (While at it, stop
    validating chainlint.sed against the self-tests since it will soon be
    retired.)
(...)

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
