Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815758;
	b=otfgMXkpG4CDvXMQ798TjtsVevEXQvvOEDZ4Afd9ksWVqwG5mqgG5L/8xfgksSxBkPHp
	 2KwYVqDpnnOzw8xq2ctk4pH4jIWdR2c6lswhtniaceTF8ZbtS1fDBT8fTNrEcvNvhFENL
	 fMmiek+/vmAf145DCXypZi08q2d2s9DBq/TsiSkrw3Flb/Jqbd2G5tM6yMvsE+qzRCsJk
	 3eaiSPpJTm6swEzy9RsVeoGyFIbJSHYt2KgCk5cYgeQCqnTWdYAatH+K25G7JRo4kJcHi
	 8FQLcoE9gnC4DoZT2pp0iB/jll4YuIr9zbsUu/igqQxJH+0yAdhnS3I7Qt/pZX3LA9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815758;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=pTBc6xMGHG/BzS2EHMLVIb8juhCeOcp0nd7fTPGDt+U=;
	b=iYaJovIylnUt3WY50EDmEt2kfhZwPtOE8dIES6k3e/jjwrklSls0DwjTIawrbZdF/352
	 QeLD4vvo3vI3mRK2vcSG6Onac96Rfqoq1IKTj8RFkJuj+rNru2/B++AfdUd3cANxJAwyB
	 HeDGb676pB6L24ak4EvYxzWrXPeE2uXLr0Rb2nbwsRroz5kTUhmJICa5RewPEY8zerw4m
	 3gZ+ZN6huM6C8RMPBWo06cMPs7Cb2vOTsJ0yRgPd66xfirZR53wzZmFOw26vsLJmqCDQk
	 H3bSo8lCGs2KsBKOLEw9mz8V8hoYxbjvVuTdSJWCNpOIp+THSDQ2ZxUlmFisON5lYUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=Ibhs1v4l;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="ipp/eZya";
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB05606A31F
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 21:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB05606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=Ibhs1v4l;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ipp/eZya
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id A3E8C1D002DE
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 16:42:36 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 27 Nov 2026 16:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795815754;
	 x=1795902154; bh=pTBc6xMGHG/BzS2EHMLVIb8juhCeOcp0nd7fTPGDt+U=; b=
	Ibhs1v4lfj4BfIRHVG/u18vvrojBvAsOwLSt9kho6lCgkNWtVythX9ofccqGmrvU
	0Fi0qe59FhH1QnhI1q8GDYHUDSB84Bxpi+PLSKun3lurha4Dj4MHo8TajxlVkz/L
	+TTXc8CxaRM1IngrfcTg49enzifAPSYsQfQQfysnpECLpwXG3t6BOlny9npX+Fx0
	t2646jiOUZJbonnVxZsHFdCd02hkMgEQjvfPKiJqsguzlPSBBY22mW3gK+RfUcDS
	RLKjhABgizt4TSQCyzluYd6zd3QWNqqUQ1hAaRCZS/R5CnOI1hrsT9lD5gJEHkAq
	JvKEp3f6x1MqAnDVw1plpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795815754; x=
	1795902154; bh=pTBc6xMGHG/BzS2EHMLVIb8juhCeOcp0nd7fTPGDt+U=; b=i
	pp/eZyagB9dYontRhKDQocdaGCIyBUQKSBKoeyZn+RPwi/AjTFH/ieEuv2/DWIT6
	+LHZQ54Go5j4KtUBCogNVmADA5aWj/I5SsIfjae5f2pNX9QhCkwet6WMGCVzYHgG
	+BrZTjPTIdrGAVvklszFYEVdj9JEsXCma1c7ieKuR2hu2EOxeC9sDFL0c4vR/VVJ
	ImqIwwlRFABUQVgc27Kt5S4yfkVuRFZMnrio3qatBrmmllPrrF+juxDPr+Syq72H
	/PREXcYamf5BnUneT469irZlrt9YbH/YL2M9HJqosfnKIovulhrDSWOW6TSAemtR
	hpkHck4pir4vi+XxRq2hQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795815754; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:eSpkOLsHB4qwRahRHlQ2UhOktolQFRKUpwt91Xb2STCQrUk
	xp+dEHShm0UsldOdGR61tdOQ1ntS+SHTGfYI5nJc2j9BEiLFqtZt/OzESUM5rnWX
	30ejhJZytSKXjoHAeFfUCj5sAcHqInX2vd5i1cqfkQaeBsl+uees3p67b92ox/PM
	uj3Kf6iBL5sPnDXH6pZ6obMAQJMLesEYj7oJ9bYz1VgesGBZvEdQNK+DKlWqmvVO
	XexTKlUBw/ApgYj3zWbpJFjvgIbIwg46a6TQMNuy28EsDQWmGCffnjHL3oe79+Z6
	u48JVzOAOsMxQaxwH52Kjg+iNyR8gtWH2DPPt0A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3eJzEIxdC9gav5gLqgJa4JvtP2XLe6BhmxasMiU4Fa4=:q6/CcWJw932Hb0ecoJPeuDZkHb3p+L0GyCatyc2tEL4=;
X-ME-Sender: <xms:SfkJaxEEXVOAzIJlH7Sko5lha_pWZMHvCU8Op3D0EXz15Fe_3lI1SnI>
    <xme:SfkJaxLVfGlN8Oa13F2cf0TKZQ_Di5AEY4Y96fZoPMF9zyUrOKfwZD5CvBnHpI0MS
    agsv2X3TNuELovixbrlo5OGJ-VRE3RXLCM52H9jJrDCAywz8nrjxJU>
X-ME-Proxy-Cause: dmFkZTFPsS08KDQHYOzCR1UjZmqp3HiqTLyGmVupDYBHmVQunnIRm0e0XXcCx5WdCVnxpr
    n4OuwYzSx7LcFc7IaTBQahfvh/TSbBNuEJZJs2WEogQNYOIbjGZugkM9pibSsQujfy4x63
    WiXQAjsAHyxpZYzVWl3eYEiSSvUWulME9dnk8m8YczWprDYJzScO7wSht0I8Ts2sR/JNEW
    xhh4d+J91VE8UB6WbkcC44xuaxrVpp6iqd2Dkk6JMxPtLQsnpWyzYidfp0be9+IohcJSyD
    IIfxfEOgvkASluvC51Apn81VxVul9rEaYADoyOo2RUE8c803x1Qve096z6ICmsyosc0aqW
    Afv2+gKyPQwVQxyqhg8jmwwiPg9kM0tYx0T5CJ+jJYHD25hxpKC6R6O41dd4avwcEaETiw
    iUDW3l5SYFsmRvF9XejE62QQkX0NOnw99SHZK3CbwCNN+JyevL+A7hcbK6oY7EXnNLtx9W
    1JQ31t1JZSlhLJvwu9WP8JXY8Opy+yHAG0eyxV8rEzxk3+yA+pcmQtx+psRiNnNuHgk/vx
    eZMi3LtptJeMjFzIrInNf/UY65vGk8gQ5Y3dEbeZJw6/RbzRqR96WHQldIiVuzx0MGbg7m
    BR6p7jowklrtShQxQ1RWUTrQdpivhNTGaNNcKVK/Z7n4RpDTVDeZF8qzqBLw
X-ME-Proxy: <xmx:SvkJayBty-Y_pHRwT8ShW62oCpNzBFBUmo7xhl-1m0mnei-1tzk1Ww>
    <xmx:SvkJa0S68kr6ab7ts4gngSCvnWMvVIS3SofY746Pd3F7PUGiXIS7Lw>
    <xmx:SvkJa4riwxWq5GQOuy1TQ021zxZkMBHl2vcDkkdVAiqH7-lsU4TZ0g>
    <xmx:SvkJa-zxuM_60tueao-8T3ipJ1gU6t0YSeXpLD3G-l9T_p-JkHlXNw>
    <xmx:SvkJa99g-O_oyR6Mwd2ksU1W09Ub9XTiUoo4sIXMN8gPV4WMiQ0e-EAn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0D8F022C009C; Fri, 27 Nov 2026 16:42:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A0QsAW1MiT87
Date: Fri, 27 Nov 2026 22:42:11 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Thomas Bachem" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Julia Evans" <julia@jvns.ca>
Message-Id: <0db2d28c-0f8e-46b9-9e2e-b1a08213d64b@app.fastmail.com>
In-Reply-To: <pull.2334.git.1795636878793.gitgitgadget@gmail.com>
References: <pull.2334.git.1795636878793.gitgitgadget@gmail.com>
Subject: Re: [PATCH] doc: mention the tutorial in 'man git'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reading through.

On Wed, Nov 25, 2026, at 21:01, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>
> Previously the tutorial was outdated, so we deleted it from git.adoc
> in e2e5e9f740 (doc: use `man git` to teach users how to
> navigate the docs, 2026-10-16).

Okay. That also removed gitdatamodel(7) because:

    mentioning the data model feels out of place once everything else is
    removed

>
> Now that we have a new tutorial,

This is 8f0635da (doc: add new Git tutorial for beginners, 2026-10-30).

> bring it and 'gitdatamodel' back,
> using the same language as before.

Does this patch/commit =E2=80=9Clogically=E2=80=9D belong to the commit =
that you mention
here? In other words, was it a small oversight and that is the reason
why it is coming now? I ask because I know that you have long-term goals
and are working by building on previous series that you=E2=80=99ve sent =
here.

Okay, so this is the structure of =E2=80=9CDescription=E2=80=9D with thi=
s applied:

1. Git is fast, [...]
2. See gittutorial(7) to get [...] See gitdatamodel(7)
3. There are two ways [...] `git <cmd> -h` and `git <cmd> --help`
4. There are guides... [...] use `git help ...`
5. View HTML versions with `git help --web` [...]

I think this flows well and makes sense.

At first I was wondering why gitturial(7) and gitdatamodel(7) wasn=E2=80=
=99t
moved to (4). But that doesn=E2=80=99t make sense. (2) mentions two impo=
rtant
guides for beginners and those who are interested in the data model
concepts, respectively. Meanwhile, (4) mentions how to access the guides
with git-help(1). And there we just need to know where we can find the
guides. It=E2=80=99s not a good place to shout out specific guides.

Acked-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

>
> Don't bring back the other documents, which are outdated.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>[snip]
