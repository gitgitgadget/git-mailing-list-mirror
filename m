Received: from sonic313-19.consmr.mail.sg3.yahoo.com (sonic313-19.consmr.mail.sg3.yahoo.com [106.10.240.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420619049A
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.240.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735647034; cv=none; b=WzBMtZpHEFV5ChLOCErjfuCDicVZqPjUoEejuAK3oVne+cgRUyJvqHSxNoNttiz4KQnBVguMj9emDuie4F0a2s0pJHEj+uu2Wi8Thevgr3tjh2oFpQJXRZspO4JUAKXZ8M6R42rCcPnb4CatJblDfOXkwfHHRbe4i703rrIuHko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735647034; c=relaxed/simple;
	bh=EaCDBP8KC9joOhkuIAZMEe4caKtWxHfkjIaHiXm6oBI=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=ryERhwjrjkn75kL2bBlnjlE0cVi+E6msIop00VbxaQlH/fkeH3plHY1HlJ/Ol3v03BYdTo6xXI3tonu/NFP8DiwxY46ukdQEdr5hoqSh+xg2Az5HtL7ZzRwFTuSaYyaPPAeMmQtAbZMRkkh94qSzcE/JriNNXnmXn1uVEsNERFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=fail smtp.mailfrom=fedoraproject.org; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=atqn9CD1; arc=none smtp.client-ip=106.10.240.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="atqn9CD1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1735647029; bh=EaCDBP8KC9joOhkuIAZMEe4caKtWxHfkjIaHiXm6oBI=; h=Date:From:Reply-To:To:Subject:References:From:Subject:Reply-To; b=atqn9CD1ByquVRS5TMK4ljEth5/7ASMrCKouaN7FB02PoorsRLOf1O36e2p8ThZYUPi1wbqdh0gw/MaaK1HK3O6D0qOodVt4uPZ5uqCez06PLXGHKTiyyZ3KvRUHMhb61pOrTGAJKazx3TmQekd9iXsvXQpmh0z159CqvARUrwb/BnyXNTnuwIGhgXst8Qy3dfyxfCwD15C9TYCFFu9N7kCoYWIJ7pPn/Pbz7NfMoFlje1NyU+bN7Q6PIXDqESUrS+OBjpEO+lqXh1ZLRK4pUlKcekDYhFBJLe8Vuj4odBrR0c3xf3+Q+Gi4mj3i8kbektqG/zdldf2liJX9C/kMSQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1735647029; bh=8lTM4rCl5A56HAxPC7FTOD8Z3KejbXdcVF1yE4zS2ns=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ZKalyFoJyzriMQCuBGAeb1LpNFBvBCyR0KHjufZIK27aRVaQWPiFX1oZQvxMJtVAabne4KOVuAsEnJ/IjcMi/aMJMJsapa6m4xKol5Kmy5c3U+Ie+3hptR7IePL2kTahze0BH26G49ilIIqeu9D5xS6yjwIdCsdmL1EKrTuuVipc1i797+uEwOO1+mJKj7SSGl0kBxCZj1IC0JTJg0zbwJK02NkG+i3AQu7EruA4cvNkUspclk+3ZdM8Dfw2smq72l4fz9Sorjh8IDICBZ+rgVYOqIClUt5e0eUfq85/Uh7o+0cLztgg7kkiF2dEk6GdVvaarHT/As/StgxhzPwDug==
X-YMail-OSG: t9zm_NUVM1lHbMeUbSUCzycc2v7M2GXxnkuvOl64CPxB3i5lJlgfF2N4LjbKYai
 rVLgqMCJk4wBp2NVPw0KRHgAAI6PzLuyOBJduSvEM.UAy_eRMwRi9a3iDVj06zYpvT97Q3z._M5A
 SGmB7EEiHEj8FmlYMOLkFHAkvbdqdYmegbJQicdSgU7OvPVCuXVBpBctYwPTgGNH4KIFRQ_puIYO
 YTKnli2urdNAy4QYSdaLwSSfsn427qsSeHqXjXHWMyktboPmA1KVkH18_eJctG_6RlAM635OJ.RZ
 aFVakzcfVMRkhKzO1pZfjeX3gYGRkSRVnUkLdTWoxWy6xRJ9NzIORAT31OEXTOaBwrDp2JgQuw2i
 6A8JlObO2_WDH.F4I7a5qgmCN83alja48J8PuijkCJuoOfqUvEPuEltbAGSK4law6OwNp1ypATad
 nOJLGcwiaHw8GcjkEJW4vGhobDL.H61VMseeLLb50Z_6NFH4Ugj84CklBJ2zo5NbQF5r_mTcgkpV
 kGpr5o4NLE0zJbdb8QzICMAyw5DkPanpNIzdDiWhe1PVUf2o2kRH6zvEe4I1pCkqpEiHjOJLoNG7
 .Z7VtLqPgYjaNsFRNC49qZj0yCDhZQHFFJ7NTVc3cuC0NwUkEdjCsBMJhwNzbQvsQ9LAWHfy2S1d
 9Br41BEW4wTRIwpM0HM2_enrMNFcNkfWpkZWsN1Svrt.BxifIcjZ5o354J3jnqe_O610XOymZtJW
 WEDSEsC_CqFmvF6TMmVXrGrIGPAbVC_eCBiwMFHWchIu3EjjR8UywMXBbOgjtJgur2cIrC2YyvBR
 t3SXwmFqANGVDnZIfeILpBu7_gMLn5GP6FdxG3nY4N0F3OwwsZ5ox9Ix9anRlZj.6JSxYVrvem6T
 GyN1xj14mIsDqb06DY7iS9lvK46EfWx3jP_XVnVcHTqlyQnkFcQRgrhTefZv0Fx8q.8lf0neiVwO
 Ns.kRm8WjwGG8u8iRm92LAd3CeJTceEHLdj9sSfQQ7urSQB_gn.XD8Pd8nkg6kFIytsTU8iZ61x0
 qR985otydWei6VrT6p8IEzzWnugJsfq3B0rMSdUOgAPCHjEVsuUWGS1Yku5rs4hBOLV78rT.Y2l3
 6dhaCFf6JymDPrq.E8FIlPZ5Jmwjd04DIvHCg9PbZ8teeGBZ_dd5R6ull.3clGDpbiIr1HKqL1F.
 tuzF8HBczSM0R0guppAYVO3zkLkL2CyoSCTWXZyvF_56da3ic1W0ZTJ2ePDON04qJGEFkVLc_AM3
 s.gOItQ6f0kbiFNIPsUZYb8CNIOInqddanZJLzDdyjR6HjTlVmq1HDaSiBZrs8NcTfpcw6PkM66S
 htFujGCzIA3TG18ERuQJ0LvuIOQSjm3vfGrU_mEkXjYGbs..wr2f5VvqfhsiWV0oiOdxdytkX3f9
 bEckMORe58j5d_u35T5mRKeSsKYXz43E9B1shRXfSl.Uun1y65C6tnE255g0C9CCgEPKnkW9b.0W
 HSyDnDbGT8c.5HjMRPzPgC9pXkz.fEQ6J8zfz6jQWGZGlwfGK8FMh1RjEg_DJoptWUW6gNTXlIOr
 siVZYjVE6egqB1w45bPDUdSNh51acrfUAtPZljG1qwmYniur2wdRHW3kv9XbYCFjlKJcok6OEiRN
 lfVMLwkgGsp_B28o0qWPellSOeWHUACBu2Nuy02lnFKUgkf9kJ2Z3ejikGu2kLsOmd73dii.5uLB
 5sqmtVq7CUKRX18ipr17ZB1E.B_HeyhD8XM82ZuPKb_6tRpISo8MUgGJxr37cFVD2DohU0cJKYtb
 1Bo6F5YNCsPmcX7aVzafnDSRfUHCX0faDOlumuySglLh7PmIF3IO_7XBxbB5.mZoXjxM.F_te3Nd
 KB.3nZgrLO3X3KtxbpVEIY.xhrg650sEH6LMZaEAh0fy0Zgk.Yj6otEoZ5rZ555tfQmqDGuzEuji
 Gxze2RoQmt5L33in05l8jJ1RIsycWAehN_36DV5Bh8OyzKfmnvHepeeUdst_7J_nhXn5iz_odfE1
 _LWvoqDFNGXktYPgZwM3PXC0MicRbvGlGkL52FvvpBp8rfIkoLLJ7T9tq79s4NpekHH1ezMExqPH
 2CTTDZsCYH8B9GgS6iCWb.c2fYRaH3V_YBgq5FcPoth4RgQJ0RA_4.OpZRLqI5nrDRRbieVJvKdc
 5ZfPTNGybXhcMvl.C1ajZGaa_7Pc7ogJDXWSSOb2VUEUWEuKZ_ljRGa80_OwbYy8z6Pic63AIYf9
 rhe3onoA8lcg6LWaUMhf0ZS9ZjFj6LlwoQy03jmlZ7ru4Q6l7UNWw1x4yTzH6Vw--
X-Sonic-MF: <pjp@fedoraproject.org>
X-Sonic-ID: 2c549ef5-baaa-4fed-a7d9-bb9285d4d5bb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.sg3.yahoo.com with HTTP; Tue, 31 Dec 2024 12:10:29 +0000
Date: Tue, 31 Dec 2024 11:19:44 +0000 (UTC)
From: Prasad Pandit <pjp@fedoraproject.org>
Reply-To: Prasad Pandit <pj.pandit@yahoo.in>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1964163554.5326830.1735643984559@mail.yahoo.com>
Subject: File missing from git branch
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1964163554.5326830.1735643984559.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.23040 YMailNorrin

Hi,

Kernel-ark -> https://gitlab.com/cki-project/kernel-ark/

* I have forked the kernel-ark git repository. The forked tree is regularly=
 updated by pulling commits from its upstream repository above. I have adde=
d/committed couple of config files under '../arch/x86/configs/' directory i=
n the forked tree, not in the above upstream repository. Let's say

=C2=A0 =C2=A0Fork was created on - day-0
=C2=A0 =C2=A0Files were added on - day-1
=C2=A0 =C2=A0Updates are pulled =C2=A0- day-2, day-3, day-4 ... day-n

* The issue is: the config files I added are visible only in the main (os-b=
uild) branch. If I create a new branch with

=C2=A0 =C2=A0$ git branch new-branch <commit-hash/merge-hash/commit-tag/>

Those config files are not visible/accessible under '../arch/x86/configs' d=
irectory.

=C2=A0 =C2=A0Note =3D> Files are added and branches are created on the same=
 forked tree.

* Generally committed local changes are visible across local branches, righ=
t? Is there a way to see/access those locally added files across local bran=
ches?

* Is there a different way to do this?

Thank you.
---
=C2=A0 -Prasad
