Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794593358;
	b=vJwPL9LyPeOrFMuPvCtNwCx6NLB0Ju22pOUlzarh4fCBx1qBHVZxeSBOt8ZCA7U1s3IM
	 4f0a9IjrnBy3yJbV2goSI45DrqzbTPUnjre0/oFAbLwv7zMYEt1T3h0X6CgGgpPaAz+w2
	 ahN3z1jHNiLAOLH+1TMKXziv8i2tnvnp4v39S9I9IB9A1KaLD0CJP6KIzaKPlT54bvf4Z
	 euY60qacDS5uqK8pqGI9eaeG/Bpk0RkZdtOcxO9zDcpU/Lo/HmdAq0VBD0fQkTcj9hrxT
	 UKWc+A0Zk3ogO8GwimTusl6+0VqiCUYTdPUmlmcqsHeuNcsClY01/HfQg14LBmJQ7xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794593358;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ox5iRwgBDw8LaS16W2qcPhxBfsoD44nc1pOHAjM/Jyc=;
	b=Bocz6Pfbq0Dy1EKS7RvL1tiE7aN01YenbPhvLimuhtZKgoJVrbD34izP8Fz36iu7Pnhi
	 ZvEy8QhdbWb8GFkk71IiovGQZV/DS8l1LBAUT4b7SqQK+Ex82SGIfCDAh5iJPbC5fwyk2
	 2kdWmipt5jfII3wgou50iCQ6nido+CFqBA4QVpzYoAeMsQlDruIY+yP02t8mR4pCOMSYq
	 Bwea8ONZJhfCY1cpVc9zYkGCbzv3TgLBj+wvn6BHckzoVf/1NRjlX57Fe1B8Gy5ECummm
	 DuRlzOb9ZCL5HVpQHoOh6flbbznwjFZ/xvl6OTb0Gsp7qUDs9bdfsuCz99l7r+9l63w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bUeOIH1F;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iZs6Tz23;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E772606A32E
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 18:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E772606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bUeOIH1F;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iZs6Tz23
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D9877A00D7
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:09:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 13 Nov 2026 13:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794593357; x=1794679757; bh=ox5iRwgBDw
	8LaS16W2qcPhxBfsoD44nc1pOHAjM/Jyc=; b=bUeOIH1FoFNyRrYlMuRimwcop8
	ZVMcdz0CA6NdDwXGsiK9rPmhSs8tgrM1FMlv4tsU8pu+qK0c/UDh85N4XHFWrWhO
	XbKW8LgiWiTskqPmnurkqoZy74X1jmKMLjJHrqjfUHPGLYqM6vgF0gCD3JViE7zk
	AaKqGyFVx1Uorr/Gdv1Ajan2idmmn7dhWoO0XkaKxP6jvhl9g+ZCp+xPiGb7PF0D
	K6mGFCuHxo1BqJqx0cAlFxl+dJ+r8rZfXNQWygHzctp37mtILkVe9aiBDRzioh2x
	/ZajMOh7GnwRLveK8yRTF0xxwF9wje/mzR2fXederyOSmhIkVjbz+bgXM80g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794593357; x=1794679757; bh=ox5iRwgBDw8LaS16W2qcPhxBfsoD44nc1pO
	HAjM/Jyc=; b=iZs6Tz231qRX86wULvPsLfyoYZsg90aKgwWcdMqoWfNKbKUad0I
	B4thNqFv06JNqiKmy5bIBZDfoAopOm1yg55W3wDM5jcEQ7eJQmxH5SZWo6ZjRNDS
	XdNvEzrz9SxGZKqCM9ZX+RvSW5KAdMrHrzElSVTtdHcTbzjKR4IVQzt2AJiAah65
	GntWnDEoqRHcya4+EoMFKjAol6OIvH0phmTl2xZpg08gYqtJfYRrkdxjjoR+cAQo
	6cpq7Pe11o0G4TZV7ni73rwP9SXBOdAjoFmyS5NciJ+GSCgfsOZoNEVnqErS1DbQ
	2fq/tBqoPrj3uLSBX4jN6v7Da1cBAhi0Tsg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794593357; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aZnv498xHFTBlZsiMEUgWCFZ2gM5CGX7ALSDVen+uAP1I7d
	Rxq0dFphKsgiVbm7up384+wIa90S8E7FuxcwV+SbTml4jPrCStubxsohFosnuu7Y
	EdELTDc6iYqHJxCxjiBpCHPQVWBV/pvUm5S2ZMgsOpm/AvfFilv6rycPCnSNNNiq
	iTnDErA1vI6UD+vFuLrrLNG9OCbhOFSs99VrwSDcXevD5xsz5f9PgWoHTBSvs8uX
	wU7GMn8ob8KVzjpjOqZ08JcSyKGJYa2zWdk61mP3XMu63EnlLv+go2aD6DUzW4b5
	2af2Ues6SkJyZrZdudYe11Aof2ELn5/EdrsGO/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wP1mA6m+hu0Nw6VD5VluaOwOC7sVLME2p4AuzW7odDs=:fggTVrKuMptCF6KqEWliGEYyx4GhFTJHs5Sxlbe59CQ=;
X-ME-Sender: <xms:TFL3ajqsPDdnsUK3uvRWCqvjhLhtBw52imFDc3YIImieq0oDdIbzLg>
    <xme:TFL3akhXNjRdlvG8XAIJ2obiBb8QAFGYk3QQS2skT6nzTEnPJAlBR4uaTXIWeAWmv
    4g2cT4-alv3Iang_F8l45IU-Vcn-OaVa_RqL0M4J_cKCdXRWomYj9A>
X-ME-Received: <xmr:TFL3aohsAJeCcIXerjWg3xOveDJTAizz3Ya-O979GUAfGzW25T6J1O-Bj0uW2a4eDSEqF9HfJw9mpCQqHYXj-lEkGeg0rYWTINsg>
X-ME-Proxy-Cause: dmFkZTEJ3aI01YhRIwtA+CMEdUYiucn4Mdr5Pgkx9wrwHFNAysiZ0ggoBmNiJR9Tmd4NQT
    /LKsCd7/7HCvMw7lPBHY5h7ozaYuHDkABcX4ge8mBJ+WS8UjfHYlGD/eFWtVPKxn9Va4ei
    zN2IFl+L7dpFwwvSlI8bNwu3re5yhAo/DhC+V2OF2bxAI4YPnj1dsVNh3GoA6X5Z+jRbTb
    3X4c7fnlmtFsKNxb8eIfuH1p21dmN2eHo/uMDqRxGGBHysHBtjqgnzgAOZfPgZjQFRy8Rk
    2VN/QUnC1FxaYEc6jnzItdxXE4PwbChc/GDskDlkNSQaUa9oT7d9xMsaEOvWNRropqIuMl
    pdBrz8cJMA8WXfXZnfkmEnHHJcxW9lpvxD1WPThRfKI0rx5QYxBt1JIRVcBFgL3DSAsLz3
    GVXh/vcaEDt1drMN4/OzA4OZ47YsJA//jm3AeEuj1yKwO7SlpR99XO4taCYmRfUQdaAk5j
    NjvgvORGFWwCDlRdkWN14GLl3bI0dEVc6F2O9W+Rfx2TQrL5t/SvlblgbzzAUf8NjoPeRA
    HFXx1GxZfMU1XO4pPypn6JN7g1VMru4kBFcrvEYugBzMMW3MSwcqQC7UR/LKGugH4SsOes
    5K5qTp+MWSf+MxxRpO9cmbX3vzjrHvRMgKX027TYYPJk4+C3cIvCaAPJYAsQ
X-ME-Proxy: <xmx:TVL3aiiQsS_pOUS1c-GgTVktwaXaqscc5VHE35YrtnTbMbFwkLsyog>
    <xmx:TVL3agIOFKDvUslYw2Awdbz4MZMwj-TjslbF0UYcDcqWwO6Balo5Vg>
    <xmx:TVL3apEc9NbK0X0tZZT85b45Uc3x02jQVqUe0UFmgv24aFyHOxBXwQ>
    <xmx:TVL3asS3f0G2tGQaaLX588IoMCQXZeJjKdaBXJi5GSFVa8y-mlib4A>
    <xmx:TVL3aly0Lum7kx1PuacrDxPneSUSLD9WEsO5WbZyJYJdMFbhzwY7G1Wo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 13:09:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  "Mark C.
 Chu-Carroll" <markchucarroll@fastmail.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
In-Reply-To: <ava6Q1u65ASVeth5@pks.im> (Patrick Steinhardt's message of "Fri,
	13 Nov 2026 08:20:35 +0100")
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
	<20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
	<CAOLa=ZTAYtq0K4YfcSBocf-fxadTiaJp+AV5-_6_pbNMBwYQXA@mail.gmail.com>
	<ava6Q1u65ASVeth5@pks.im>
Date: Fri, 13 Nov 2026 10:09:15 -0800
Message-ID: <xmqq33t4eh84.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

>> >     @@ rerere.h: struct rerere_id {
>> >      +	RERERE_AUTOUPDATE = (1 << 0),
>> >      +
>> >      +	/*
>> >     -+	 * Reverse of RERERE_AUTOUPDATE. That is, update the file in the
>> >     -+	 * working tree but don't touch the index.
>> >     ++	 * update the file in the working tree but don't touch the index. This
>> 
>> Nit: s/update/Update
>
> Oops, good catch. I'll refrain from sending out another version just to
> fix this one fix though. Junio, I'd appreciate it if you could fix this
> up in your tree. Thanks!

    $ git checkout ps/rerere-subcommands
    $ edit rerere.h
    $ git log --oneline --first-parent master..
    $ git commit -a --fixup HEAD~10
    $ git rebase --autosquash HEAD~11

By the way, I wonder if we can simplify the last three steps in any
way?

 * We can use 'HEAD^{/^rerere: convert flags}' instead of counting.

 * The last "rebase" does not have to be on HEAD~11; as long as it
   covers HEAD~10 it is OK, but we cannot use 'master' as I am *not*
   interested in taking any new development from there, and I do not
   want to worry about what the command would do on the merges the
   topic has as synthetic base.

Perhaps with newer experimental commands it becomes easier to
manage?

