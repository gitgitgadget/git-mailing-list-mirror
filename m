Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993766;
	b=gUx+UAdKDE48XQoouM4Gxqcg4LQNvzyD3frpynGWAEOwdqNUAO8QAu6EhkiW1+XwSb0s
	 Rp82Y0C7n0cmcfZNOeV3ZjD9+U6kTyJNgXJVckW5XaK7t7mmqkH6ai2+KhKbS8sVpphCD
	 HvOMiUoHLy/2v4/4RYJsbrbW/tihGWOeosvsJe5o1de3rAb1LLlWHZQAQ1uprA8EU/MkC
	 6dFouu53Mpus2uiMabSiIUfd9FSxqVMp6WXl3qZt9VUt+Ht7YI1aLeM+DP2hHgCq11uVB
	 S+NRdEDCLw2RdNImKIFb5Y5WYMKCAhPeU0mZRBfsU1yOm6T0gJR3C90y8o7D8BAQuww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993766;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=kx/W0NvZakzeftx3E96JLhiQG0JZn9+khZz3habdfs4=;
	b=DV9nj7SDRxDgyoY17Ygzbk1w7iwKEBeOUFASyKe13rAFfsawGY4yqcF9OzbN2Dt5syMV
	 FZ9lGc+mQCX0/wTsF4SbPRqjTVB4sweQmqi62kcRbiwN2YzCJaewwHzfmvp/E8YJ+jxh6
	 73ZUwYSGFSQJeo/howkXqCCKrurvKJrXAtBq7WZ0dqiCHA7Li6+9YSfY+P7NtXYrIM9G4
	 mX1zFyKbTWmnZB35PIbsRbe8KmHAZ3a6HAdAM5RPpIkpLl4351PHgzDX71V7zsc+kZBZf
	 DbuzpzHPNckV0p++AS4bdQlPPdv9xs6z5rDMqQidlmCx3H9IHOaR5bz/J4wALI9PTCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aXo5Ipbk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OCgGsz8P;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB7606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 19:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30DB7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aXo5Ipbk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OCgGsz8P
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 79140EC0858
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:36:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 14:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793993764; x=1794080164; bh=kx/W0NvZak
	zeftx3E96JLhiQG0JZn9+khZz3habdfs4=; b=aXo5IpbkB2UV0fjV8UdaEj+HP7
	wLosI2iVd5uamuChRIvXMrL9RaDokYl3SjSkMvUU7IVZYFf7/l2A2v/pezQCn74m
	yVyKDK+ZEcG1aF+tu9hJsZ7da4/DqGIU457DEW+zlvqqtqYCkHFmmYybZqoQbdX4
	t9GPrwJu1av1BY6wqiy4RaA3OopgjzsfROVrEQoF4sayeLl/Uh6ghJPI9Yam7Il8
	AldzIVvcpmTYOQUoLQQMsKaWBbbouA9qDWGk3Ncw8CHkZdqkIsEi+/59S/6hWqV1
	q6yFQ08CIKzdWGDd7+a4e2Di8iBFdlw+4dQTtpcG56zVMlDOEoGzJY2l4VAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793993764; x=1794080164; bh=kx/W0NvZakzeftx3E96JLhiQG0JZn9+khZz
	3habdfs4=; b=OCgGsz8PZ2LPkXEUGxg/cYQcTXuzEnfQzJ3/l4bLq3iL3tDrcy1
	JRVyuLid/SSeHgz2DTj8IHXtPdLAChUHz2UM0Tdcj6OlFvUejgn3xU0D79Zo4mSB
	GtshuPr4betiWXev8d5Zru5/KlETChMK7r/gfOKlbWSlgUEQ84bRsKYlg7ShQZ5D
	hEeUFker8r7GxPsMKasA6lyxIL1kIYDmdJLbqjyebRNUdgrRoNggac9d18atriK1
	sujNwZ4V0T8RccuzYtehTaIHahoUiVjzryx2GCOiuiJ6Dku/xizWD3Y9SjiNI+0U
	bUXO9vFCvwuHekTR9BffUXx8ZPtDRoRQ4Dw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793993764; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SWVO4A+IX4iRBZnPFW1hejEfZqyPEGxiaTfMqHuehXRFSGP
	pMfrrPM536Eq8Ckon9RfKR7FiMmTApwjyDVHRqGekVO5t7eKTgwxY+VJEH7UXA6I
	whD7nUoqLACwyKxsEUub3ZPHxjDSyUcuFQcNl5cImRasSDDDEDrJyeePeUAJPili
	YYQKHcX+f3rg3KlqUSOaX03jo9ZRRu6itjQgD/0N1YsY4sWOGOkbJoCt0CHzy2zA
	FxKaJn41TfC5DxekngeIfUUXEaDnotAtUDaSujqg7sX6hHwL4VEVz4NVmtuh2I9P
	B6eeqVIWW1DIewEnXTgzziqeDreWG1SssNaLxkQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:D4nroy4XWTRFGAA1xkevjALWKYRrqAF7WzRmuRnr5FI=:FvBd4LCfGOPFP86FL1xVhAaa1RusYbVgWCoBO5j5r4g=;
X-ME-Sender: <xms:JCzuaqOb0TPvmqvLiKzjAZcUJ6VSrKR8JyZeJr8_--pVicx3m89UEg>
    <xme:JCzuariWC2mK5eX2YWS9fkr7GAQDWmix9HxQgJdk4A2DdwNJ2AKmeHoi--FPgivoT
    l_Kdew90bveymnFeQG877g_FDxSxke2nhZmyrQHlG2OTzP6ZjscSBQ>
X-ME-Received: <xmr:JCzuak5RFixLKOqgFfqwCOM_ZCDoVMmS2OQ8OqSc9qAaYWAF8PfBlJT25Vmfti4EJK_4KFe6hYYUnn3zYo-E-AHGUdNk6W90Yy4E>
X-ME-Proxy-Cause: dmFkZTGalsaXe3OR2pJoh08Ceh50jMFdu7irl0/38iYtxSsL8eMErmg2N/ewMJoia2dB90
    OMLFbnzlQ++Z4xJMlKaIuOts2YbeHibXXfnR6y/E8h4vfMvY8TVg19goSkyyAC435ND6u2
    HI7Zex2ll/qLvJyvYYqptzVa7LdFoSqbf6QtNUhQJ46Lsg4i56jW+8W7QHyvH2B1uORLuY
    53eGl3HW8BN+DnjOMTXNlIG3xBknhmTXT0XMrNv2fhdJJBOIkxhAaDAYsKpLZ6fb2BHmXN
    RiIFk4uBEy/gCrrLLXB30wAG7vC18WTFtiJUfIXlCWHwcQDl2r1948wNNBYiZkGzZOUXc4
    v6iYUs/BjyfO4KR35OY7fNS9COAR7xz+iZ2NzReNhIonECGIhjCwf2UGBzuBbqbwU1jRf9
    GJxfbkkikb6xlFtpl4GU36WGBcyVNbUEmAgbO5yC9/885cJ4KMYNzSCthv4f6U4n+itomQ
    DtSMxS7qzYwh6WSVZ4aabEB9dxFuRgWXG/epVDJpEg6IIqKilPgi3gVk90ppKnYP2paqC7
    tc64niBn4OoGCRRLuA72lnCuvfYpRfl88pwmjQdYBVf9wUBDx7/UOo3bc5FkiSJ8rBjmYl
    TZ35/zHbmxYFpZ+jFD1xd5A4o5YdFkYgQvKrb7Z1lnYr9u6MJAwhk8C9YKRw
X-ME-Proxy: <xmx:JCzuaq1nAXgFDDHYXqu8iIG9Eu0k1HrDWB5E6_t1Ih4vSHFkqPhnuA>
    <xmx:JCzuanvCunaNYB4S3xTYkiPq98m1T0mXkKA9o6eydmY3j5Y3QIZ3OA>
    <xmx:JCzuao4GRV1J4RoeDfomRyb6Qewn6DOw20D_umPVKoJDNIPnISJ4qQ>
    <xmx:JCzuardaNrLra1Gq26ccb4IMybpAS_yQ8mCuZF69IdRDdo40oolxDQ>
    <xmx:JCzuamThzJdqPJFO0Ho1kzpOufYWcGdug1Vo76fi5L0YC0JSjgT3EvIe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 14:36:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Joy via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk@imap.fastmail.com>"
 <kristofferhaugsbakk@fastmail.com>,  "Christian Couder>"
 <christian.couder@gmail.com>,  "Usman Akinyemi@imap.fastmail.com>"
 <usmanakinyemi202@gmail.com>,  Joie Joie <soniqjjj@gmail.com>,  Tanga
 Joris <tangajoris@gmail.com>
Subject: Re: [PATCH] repo: zero-initialize configuration values
In-Reply-To: <au3hVGPuDyGVwOw8@pks.im> (Patrick Steinhardt's message of "Fri,
	6 Nov 2026 15:16:52 +0100")
References: <pull.2298.git.1793966368860.gitgitgadget@gmail.com>
	<au3hVGPuDyGVwOw8@pks.im>
Date: Fri, 06 Nov 2026 11:36:02 -0800
Message-ID: <xmqq7bipiwgt.fsf@gitster.g>
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

> In any case, the patch is obviously correct and is a good improvement in
> my opinion. So this looks good to me, thanks.

It however does not look good to me.  I would prefer to see

	struct foo foo = {0};

if everything is zero initialized, or if there are some members
initialized to specific values, C99 designated initializers to be
used:

	struct foo foo = {
		/* Comment on this stuff */
		.object_creation_mode = OBJECT_CREATION_MODE,

                /* Comment on this other stuff */
		.branch_track = BRANCH_TRACK_REMOTE,
	};

Now this is overwriting the passed in structure members, so how we
write the initialization is not the whole story.

Since we have avoided assuming the universal availability of the
more recent "compound literals" syntax, which is:

	*cfg = (struct foo) {
		... an initialization with designated initializers ...
	};

we seem to (ab)use struct assignment, e.g.,

	static struct foo foo_template = {
		... an initialization with designated initializers ...
	};

	*cfg = foo_template;

in a few places as a fallback in the existing code (DI is C99,
struct assignment is C89, so it has been a safer assumption than
assuming compound literals).

But I do recall we made this update to our CodingGuidelines document.

   . since late 2024 with v2.48.0-rc0~20, we have been using compound
     literals, e.g., (struct foo){ .member = value };

So perhaps it is time to switch this to assign a compound literal?
