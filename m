Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498721;
	b=30doBYcSpQSeGvhbK+PJz6gV3YMDEzujpWTCNV3U3xu4AR4cm+pwgc+iYkt61dqpqBv4
	 0kqylRJL/I1ahezSOTyulaW3+AvIgErwERxBB9mafckz8ydmOnRd/kXRq29mRawt+g6Mw
	 oG9bOak3bBgvWdiAS1Jv5KOZfo37QXpp1B/gh3AdaDHSvl2K5GwM/Q4CR9AF3zagIrAmJ
	 wcC+UxILXlmBmpuqOKgBQjPfY8miLDRV3a7nadCx5PCldGqIIun2xCZiGC/cIkGb2CNjW
	 YPQqzyDqNY4lW3h3rG/0qkcKxCqmAj3KxsInPn4HS5+BRcaw4dYs4g5Frr9IVj6Apow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498721;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=QBXB0beJ5L2CKpNMBbQqsEyZLu1MjdAL/rr65JgSqeY=;
	b=WpKOsC/zc2dfaBg/CzkofcMjSVFX1TqtYO1H2id7cWsqYgjxYYd006HBsiuGa2VZqhQy
	 stHFcN5CgjvIcGcLhX9u0888QJrqczkitZQ1qhGtrgHS20D5M2zFTKuxO5Fd3m1P7FOas
	 B7gL+qC+KT730Fp3wPIg4pQdq4t7/097vHkrMAK00DcySRgj9jmoZUKl2EB1PcCbtzSWd
	 z6ei8OOwPQmf6VDwcMmrr5QKrvj3XCJg8STq7g1ZKeD2tow1yBm8MMq7p0JYwBnLCJQqd
	 8QCdr7HRTiaqIIPzmwXUTB8sGBMvb6PKV3/q10+DTzoAOu5NH7s1sixX4lFKd0bu7MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=Oca21uF+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tKZE3lyJ;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63246606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63246606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=Oca21uF+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tKZE3lyJ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 857D37A014D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:18:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 20 Oct 2026 08:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792498718;
	 x=1792585118; bh=QBXB0beJ5L2CKpNMBbQqsEyZLu1MjdAL/rr65JgSqeY=; b=
	Oca21uF+ZPx6UzobpHPC+bulQFQGqExtVuqoTW0LBVRA3MywQ1N3GTdyQ1hdBJHe
	sC4F/uDF4XOXnfDrQ2SUxVCIRMcVQ+FJF6u98enP7GnmUysbBto0sHFITwpqudsC
	NjemWaozwgAghso2PQO/d7XMQQaRHaYgd7UztyNtWXmZc4eNUClR961B1ddCztIZ
	PIQ0I0hwqFpE6eKQGVfV7oHvgciYSSbPkG617wReoQkX9SNTjFCV8IaMd/HlKZVm
	8A8ini6sOa/1cmjU+rLBcLqGp2bArm0eWMIPcO/cYhQKIHkMoUCM4Tk676iolyCH
	4ua6TV8MG0/vrUDpjDh3OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792498718; x=
	1792585118; bh=QBXB0beJ5L2CKpNMBbQqsEyZLu1MjdAL/rr65JgSqeY=; b=t
	KZE3lyJAkUkUNV3qDTiVqTN15PN+n0ymHgh+Cy7a9qHIqZpyH14zvORO3/wtw5yn
	zPVSdYeP4L/qMNc7otTpBbtk698JTlXyB62HlIsyUO1Pwbgd5kct0ADc7b61Yq6w
	DxN3qQzPge1/o2sKJT4+xv5xDl/EVXFllIHuaig7fDvhr2SbApU/c7FFmo9ILRI0
	7cfmU/Leu2OalIOwSJ09fWUvhPdg04X7b7M4G3fawx3Q21PcUCs9Gs3acy1jGk32
	CW29siHRxh0fo0u/oc99GVPC/XTAR71yY39jGGAf6dMEtSbMf3a7mTeKbCOkKfPr
	OkQ+uVWXwQ2J6xYWGRZ6Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792498718; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Kbv5MV2vM0LWwnXCBT7TqHLJkBnuNZq7zoLHE0u2jx9B90Q
	a/NUseRuDQUA2zGJo3Z2OBWLxTGJJ9jMB0ec4aqqYiGkUjnNtzqNG3YMsJ0+JM7s
	x+PbvnxTNgMv09xlqJDJwfRdF/nR47fQECFwLDCZJJF0UQbW6omeGRBfPCihm/A8
	ZSII2agDuuZw629vqEDgfpvoGgpbdLpg5SMx8FMahtv0AXcQmVT9M+bbnJF82qbv
	iDuLv4XpsqgseAooqFyl8pQYszOCB5pii7xtJbr4/gXw71Wyjkb2SpN8h+/ZQE4b
	tExCTiPJW7BFCBNPCOOaYPjooXw1NkMz2QJfMAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6mCgjcjIEZj2NMo5IUbMICR6zHUwtlsydHtedCRrlxw=:QBXB0beJ5L2CKpNMBbQqsEyZLu1MjdAL/rr65JgSqeY=;
X-ME-Sender: <xms:HlzXau64bFQo9FZmyyCmUYHTlvmOWSj4G442_wHtHZD4P8Je7LcfLQ>
    <xme:HlzXau5RB-OOTtPkc3_0pinR1-JT5FCPQCOGYb92tMQPe1NrsWB8IT9S2NOfDEjsN
    JmsM1EXFHtz3VHWLfRcL11G3wpkaLh2pmmbGtkSPVi1XojZ7tIdIzkF>
X-ME-Received: <xmr:HlzXaifEC5f8ke7Y4N4CI6WxTIYP2Qua7sLqw3cH2a2wA62lkE8oE5rp5-gniYF29ZzdVKfVCvFwnsa95c8SEFDAljYQPGCS6JaHnmJ4zCMwlAcCACH2>
X-ME-Proxy-Cause: dmFkZTG2hzLT5bX18BO2BiuVtZng/7LW4DdqZup4tP7fcN+ANuk2UnyzbRoh+3YF34oTHN
    6e+nwKSwcA/n8f3pQfchAW8L9Y7+MF/nd2mmoHYzQgE1v/+40QbOqHadzpkQoTtdeARGkj
    e2hRIoZ4Za6v0dEg35i3Ld35Lw+2dEXoninIsDKdOTjaO6tZeOLOWslduHXpcEZEp/O7CF
    yDOy2l0zJv8Jqa9MTS7+44X0ZdyqWOE9qWvZlgWuEXuO9iRcDhjl70mNW/li64VcmPagzx
    /u1oV88s1wRJ0zjRhD9ZpCqA1MJKNwmUiSU4/4WpQMCCPkgtTE02SjnIyCgh1Pb70sw+XO
    1ulIfokH6bOL8m5gfoEYfe010TMNynUkCHrUnxsly8iMmI/sTzZrEeP3sFxC/szc06HDvA
    9cL/IhgbwMKXP5QyMHclX9LWu5lL6GhsNiphuNf7KZzA9LqnFvxsQaKv54SPtky6xsYE58
    pchrTt2qDkZidhKXmdvnTL3QRVJJW6ZQYqQMfZ/5a7YgGXrDXLO5RXuhuaGymNOcmJDuBE
    sMtYBCqAAklA/fE6a++6F25hcMBgX7RfrgZgFncuENnvGJzbxf7tcXHnwhBYIiMtXG9gTZ
    afSjtjzSMdH/iGj4YijPDLDiyM0lL+QUvdukcNChhC0AoPG8IOzDWGpMZEHw
X-ME-Proxy: <xmx:HlzXaqCcUWH2sVex_vxgoV6-JGZ6VZP0Havn0_xaRbl_7MyibRglCQ>
    <xmx:HlzXat-lOJMc_iO63HBVE9Rg0slw_inZLcgT4IuInWcUjdfRAgIseQ>
    <xmx:HlzXatJHTy44blrg14xKMDltliQ1r38fJQvufLzzAeQQkMcRcGXVow>
    <xmx:HlzXauhTy8saaEnKDbVdZIDMQApXc6tpBu5XrtpEeKgtl8MSo80b8Q>
    <xmx:HlzXah8B-IF2h0pvitzVqW9wdhvlRZCPKzv7qNNLy4Jze9S0NUy-MtaH>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 08:18:38 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v2 0/2] doc: add new git tutorial
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <DB04A709-0EDB-4402-99F1-94D8FFD23F13@gmail.com>
Date: Tue, 20 Oct 2026 08:18:27 -0400
Cc: Junio C Hamano <gitster@pobox.com>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FAD8AD8D-1F2D-47DB-ACFA-C523865E2221@jvns.ca>
References: <xmqqld7tyxi0.fsf@gitster.g>
 <DB04A709-0EDB-4402-99F1-94D8FFD23F13@gmail.com>
To: Ben Knoble <ben.knoble@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Oct 19, 2026, at 10:24=E2=80=AFPM, Ben Knoble =
<ben.knoble@gmail.com> wrote:
>=20
>=20
>> Le 19 oct. 2026 =C3=A0 21:24, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>>=20
>> =EF=BB=BF"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> =
writes:
>>=20
>>> So far we've gotten 112 comments from 30ish beta testers who have =
tried to
>>> learn Git for the first using this tutorial....
>>=20
>> And we waited for 10 hours after seeing this cover letter in
>> anticipation, but the patches haven't appeared on the list archive.
>> Does GGG need to be given a gentle nudge somehow?
>=20
> I received the v2 patches. I rather suspect the list did something =
interesting (or the archive), or that the messages were too big.


I see the patches here in the list archive
=
https://lore.kernel.org/git/6532e60e30864c9bccfe5be0731c6913aa44d188.17924=
21748.git.gitgitgadget@gmail.com/=20=
