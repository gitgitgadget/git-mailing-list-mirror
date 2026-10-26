Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034314;
	b=z4c0tv4Ufqj4T5LW8sq4NttmNdx4to1ACPZwPz0Ds+Ys1UK25o9V1ohp+2RcN1/FQ6f/
	 JtIZAS5PSGhbznKP3prkAo5MmnajYXBAUdLlyqjhPgRdTfnY9jaHCymRLfZCO4H+/oh8L
	 i+fG9q7QJjK034iI1fpHlB92KQWEDIR0GFhkqTzueUPE3Huh9JjGDxhS3s+zNkjLlT5kc
	 ZNr+tDWTpttC16H+ffHavSWIiaKpitQtZMiqxZzJjW3D2c0wbo986nV+j4y/Z/mmAku8m
	 1FihcBbka0q08QMCdu98O5PH4JbTsfF3ygrhqwdG0mtaDznLs57vpruZUIY3Fa4n6SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034314;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=DV6uFZ5ap0du+mw8xO5e3jzvg90jl52k9Z91A1TPUOY=;
	b=BTCXYrkupROn5LMEfs8Aan1OELyZuI3lnstG1idr5M4PnQQqeMD/6oaQ8UmqzpGNG6u5
	 gUIxlkso31lTaf4CVSAzlJFUixnwUXMqb5hFjn0h5MlohJ2zUQciBifIWgFZGxi6iqJvC
	 1unFVWQ11thrPJ1ISL46GXDFIIF5nvNNMMVVjuwKxdCPReug05FH2Rb1AdV2EJN18ZaVy
	 KKp/lcJdCweuh/U9ZYc+DLcKMNw1oIPjTlOimP6V6ap8p0mUwoh0EVYSTYXJ8gwvY8JR5
	 QY+oAdQC08ndNZ5npuoA+FcZ0cQfQaO9Z6RWGmkfV6qedrJseA/sZ5UMJkWw7AkNPHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="hv4/ercI";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VPSGcnY9;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DF606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD4DF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hv4/ercI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VPSGcnY9
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 327F81D00370
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:05:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 13:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793034312; x=1793120712; bh=DV6uFZ5ap0
	du+mw8xO5e3jzvg90jl52k9Z91A1TPUOY=; b=hv4/ercIjC1Zu26pYK8Fcp3Oio
	FdFw/mX9CfEgs4BDjdl4MvlseSeEGpuFlkNaFxsLF5jNTjOEb6+4U0Pbu6an9tJT
	+a3Ppi7LVmYe7oL0HRf+p6JVsqxwgivenMIbtx8WwfgNKWe1jqip4UYzjIEaaEO+
	Y8y6eYZ0AKe1XPSb3jp/veb6XS3PGmKLYtz1pqR7EQcUnkds82oLl2op0l5F11gd
	+oV8RpXvm4+jhsKhTjDrE2rJ3ZkzVtOJ4OFtCl/PyIA2hr7mkCiT+qM1g7CqISv4
	SPBnDRCw57x6S+zMMmj6ymTNACqognoKK9kUoCuewn3GDb5tUfZW9o99EJow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793034312; x=1793120712; bh=DV6uFZ5ap0du+mw8xO5e3jzvg90jl52k9Z9
	1A1TPUOY=; b=VPSGcnY9vLed7i8mlRtO2ZX8wyCBH9Ee+WnrErSrv4SmU8q623S
	cZxfpAn/EelY1r3P6B+mNqT5XzewrWGIRbTPmpCnq8CVIWbsfpk6pMug7odzj5FZ
	ToTTcRcIdu9iDtCjEyO5b0w516FcanB5eAIsJ8S62eeFyw3n8C9v+wpXR1rKxEN9
	/uHeIjpytmCsLS6Uny/1SpBTzvVbIuYpSv5eZYuvNTMuogjEUNtpMpUOS2JdZ3ku
	imR49/bUmwnKMpvh1BLWkMho0Zz03oB9043AvpxfjyifDKlhTEilb7w0qWKxGWZF
	u+Bov4zM8oPJLCSAzfT5DMfd2V977WPQ54w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793034312; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YBTVZHyN8mWnmOUpQj0EKmtQF/3byQPJfN3eErAntfGPpw4
	s1CiEDKLBZuLhDag2qz0bOn54Jb+JlvPPR6c60pQGReFk01pn/7n1T0GiVkXpTIz
	szDF1ccdDscf9IIsaPWSQWZ+jNeTEjwA96V9JjeoGZ7xtw1LMJrV9C0+qGBIPieX
	UB/ahmdVNVJwJ/GfDmK6mJV6OARVcGGyAYt+M03dwBZiIKtg/VyfwKazeKXZXz4T
	tYMnUlcqmJYG/mT39z7DmxunbdrsyNYZzvdgCWdEPcddOuq+w2sEWSWa78ASSg+u
	Y2j2viR7zVzH8JdHOat3euDH+TVRpovk0vqgeDg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Q43iD+kIoKqQZPsGkLOn/2540vw4Quzm7a7x+CHECeM=:fdtwhgVDsbR1Vc2mptIYOhzFGjQQQWkkTN7tBzdO9QQ=;
X-ME-Sender: <xms:SIjfaiLEu4gHOS1z-AkMSOWDgqExGHdL7JFRZwAuEzGrydWdVKvOuw>
    <xme:SIjfat1P8ixcGGoJ7ZpB4PblHEEWOcXoAvTYSGyo-7TADbv9RIrjbo2vUvP15O5tB
    oP1iGaAKocVDhyT4By7pO-tYa0h5cI4luwz-XZlek3P6qTzdwFovw>
X-ME-Received: <xmr:SIjfasjpa2VjNayJFBhfWk3hqFsxB4fTcJUuqpdGDMcJMT5XqY8oBIj1C9KRS8Jn-iZ4JP1nsYRhXh_aRJvvcIddbUNShJQUKjyX>
X-ME-Proxy-Cause: dmFkZTErgViWIqSY672ydJjl9Qie+vnAtXd4JnAgE0v+UmzFKnPCtglhIMDqraqxdaH2BC
    b7eGm29zd9WK/vy0VcYxl2nh5VaNvWb+JRbTrGmmZnKOnGACy7SkHQiARK+50z5lEr+e1X
    iRllWuy+PNMCSYe57RiPAJdl8RdEkyTUxQY/+NhcmwZdaeZKVOsdJGc08YccdKk1qGS7c/
    2SA2uhodooTCPJRb8S5eGsCT1UQEEHYtnypK+yejFURQRPJgYMohZwUJtfnaRqjiFPJXPA
    3niNslF4ENy9x0Y7utyijcfJ5oPheK1vKCsmBVOkiYoDROihfOs3M27W4OaDIJ4nQtWzmS
    IJTQ4PVtf8pC2me9o2yWN20kaiAQAoBGOyGiCV0qcyUUKZLb9MtUwmUZSwEtw2FyKE1SKN
    ANagfCCxtijFy3g6ApZfeZnGIlWX6BgdvVp0PbhskRSWiQO7ssR0UaBC5P3F+1Dn6ksegg
    8yB1J1ic83fUmlChPduazRYTH5ryUdCenUbjEIWmkNDmNvoQQWE+2N61ash6rea0cUCtjb
    j1P9iZHTE0UG+y0Wwh3ZF3imjxbxtsmjV13QKiuEJZSuYLw6xH8Y2tmvG3WwaB7AWGr3uw
    rmT4MERJWoImDGZUnxDTeKXyEP9NlBtmrrvL0fAVJfUJIFG2B8/3PanaCyaA
X-ME-Proxy: <xmx:SIjfauWpSftVjEeB5PPCdiyPlTnKLOLQ5HsDWphP4cz-ygziAWKW9g>
    <xmx:SIjfarXjkshN6jtlOhsNA732xmirGJlZLOhE3pRWYXOjYiR6mDsq-w>
    <xmx:SIjfauiwK89KuYyIomWN_-5e5PBfFUAmvaVf2UepbklO2qY3PMGe3A>
    <xmx:SIjfamY5c8qG0PvGWkj-QK170d2GcG2gxeKeZWBVHz-EHIPwOfuD8w>
    <xmx:SIjfagXHPWR8Ij1g2XOnFIIHzl8na5sT8P8FHdHJWX51zVnK_TxQkmJL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:05:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Julia Evans <julia@jvns.ca>,  Julia Evans <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
In-Reply-To: <20261026131339.aky08%taahol@utu.fi> (Tuomas Ahola's message of
	"Mon, 26 Oct 2026 15:13:39 +0200")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
	<20261006055002.M9X9O%taahol@utu.fi>
	<26a10538-525f-4160-8719-b82968c39261@app.fastmail.com>
	<20261026110008.Rixj1%taahol@utu.fi>
	<85254bd4-19a1-4ce5-b61a-dd3057389c36@app.fastmail.com>
	<20261026131339.aky08%taahol@utu.fi>
Date: Mon, 26 Oct 2026 10:05:10 -0700
Message-ID: <xmqqjyn4s88p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> "Julia Evans" <julia@jvns.ca> wrote:
>
>> >> 
>> >> Agreed that we shouldn't advertise an obsolete tutorial. 
>> >> I'll remove it from `command-list.txt` on my branch and submit a v3.
>> >
>
> That is still a good plan.
>
>> 
>> Oh, after I wrote that I realized that gittutorial-2 is actually already removed
>> from. command-list.txt on my branch. 
>> 
>> Or at least that's what I see when I look at the version of this branch in
>> Junio's repo. So I'm not totally sure what the next step is here.
>> 
>> $ git show junio/je/doc-remove-gittutorial-2:command-list.txt | grep tutorial
>> gitcore-tutorial                        guide
>> gittutorial                             guide
>> 
>
> Are you sure your remote-tracking branch isn't stale?  It seems Junio removed
> je/doc-remove-gittutorial-2 some time ago.[1]
>
> Links:
>   1. https://github.com/gitster/git/activity?ref=je/doc-remove-gittutorial-2

I do not know what "Deleted branch" on that page means.

I did have a squashable fix-up on top of that branch since Julia's
patch had some broken mark-up, but I do not think it had anything to
do with the entry for gittutorial-2 in the command-list.txt file.

Puzzled.
