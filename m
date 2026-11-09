Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255700;
	b=TDOgyNCtE3KfdthrX7CCDxHgdQQGhC2M253gfoUcI2PWewM3LzlRbIrlK2Ix/EMDRs0t
	 wpwtgmRHFBXy2pX2mamxJw8J/dmAPFT7sw1sxg/l9EP5TkrIxrRf98bVi33NlwYDgsXDr
	 J6KImhRL24Y9yQAxhIhVGvYhDLQ/5F1kj77ko7qp6nFH+igMhPgDfPDsqGZkRBmjOvBa9
	 A1Epjp1tktDmYM6kdl1qVC2sZR3qhzDLzdxyIcasgHyPYXreaRxNa6iXODSeHp6gShEGs
	 0U+4N4AoDCxeZ1uWwssTsSFo/UH4V3OTJ/ReBaYID2b1ZQhfuLYXOeVmVzmW0mTFagg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255700;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UjqmXuf1HpDcg02LOUOZ8HXVACgsBAWB42ShlLOT+j4=;
	b=FMkKRF2gngas43fUgN9UW4iPSppI52MY3W2iuXcKryY2U0RW+8NXo/0hL+SlH+fxfVbM
	 9WniodfFWazp4oZEGdssssK8B7sCiXINH6aOWvQSmmtT82D7cVwUTdPbuvS2PWrTzO9tR
	 pvyRKuRUQZnTQVhK/1CU1lWJRv8ktzjjICIxicOAorHUsKg8L/7dyA5GyqsccBmsRl1ZP
	 5NrdGnthjY9SNL+D7QGV0ZWCvmmVcJYkkC2c/MQooj7T21+/ol7fMOByqtu1Aowg8zTtx
	 eGU56lnNjC6wn+gTcjhPxlFClS8u0mWPbnQzPSAE1tznQ3+uA1UtYHhyWWzW0xJ8Ezg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=dgvv5ifa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=w6jTuUJN;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEFC606A326
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FEFC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=dgvv5ifa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=w6jTuUJN
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BAA18140019A
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:21:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 09 Nov 2026 15:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794255699; x=1794342099; bh=UjqmXuf1Hp
	Dcg02LOUOZ8HXVACgsBAWB42ShlLOT+j4=; b=dgvv5ifayFjEpPy5KhN9iOwgU2
	wtVsyuf6myZCwYiYLhkQqV9Y3+x4gMmtgHT81Q5nySCMp5p0BguDU6GptFczyCTn
	1PmUYAbzM32qYNnqo/GlYOG07+HGI7xgJrRxK0lfgJEKplw1yw9EGkrJajlBN+rH
	FoatO5P0TF5JjEJAqPV5QnhRHOCedv7JQ8pTMRLz5t6daOEXT8ZiGs02Q6M8iDrO
	fgfF1Kj0isa7O1bNqNOr/lBrA1+kbkB4iGcP7ttTqOAWHcvTSgI50c7+0eDvtTg+
	znOoEz746dwGPJy1PPFcF9xLpk721DRDxm4Y562xLaQB9yEpaEDkkKX3AVcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794255699; x=1794342099; bh=UjqmXuf1HpDcg02LOUOZ8HXVACgsBAWB42S
	hlLOT+j4=; b=w6jTuUJNeG1AgVttgQqWImuTkDkGWuMB7YajmVT7hq9/5IVvhLZ
	qcOYkRkgPfS5zVPbe23Pkp/cA5eIqKkRvtIdpo+q5Hs/OibY6pncOfm8WZvNQW9q
	6wZ0QRKM6zPJvIjdR/58mWyxbTwck+3YrbihgMqu43Ex/nTxp3HuT9c2ci6WiwMk
	bdFMZBMUfVtPl0RAZzo45VI9uvDxl9ss+I99A1m5a0nu0HMwJwdCQlUeYFxswxl5
	L3WAappRecAJyMYvCjqyamkvak7gj7j0+dXmsY9UmHM5vsOHbmFiNE4yvviKQC0I
	JYP2oedxxY4Z9Okneo3PneeOnyHDfEcgp+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794255699; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EWjQnJxJSgPmFynFWhN5XyREOxOji3S1clReSZjHmWZb2Z4
	WE4tPYT6um6+0A3p4DASvKq+o+dwa2r94ADBxetIEkUpl4UVBMUUCosmPHKLE6hP
	eqtJ6E9NIOjBYc0Y6CTJpkTF0yH6T+xS0VUFHPhom0dwtNy1tD+Lx5vNpzp+qYMu
	lCGrOZTcy+O/JW6kQRYJF8+Ra0XK6WsO+LtW+zcTO25IfFOGNRO3Bfu9v/lJZZfA
	4G29XHlrN4Zufq1/tTqCvYUtNqvpHjo5+ZWg2tA2jdqvhjRN0ZyIPQw+vBWOld+D
	5EBv63bkZeEvuziAXAVmHrVKyATAuIHp+MLjPyA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:6CPcjRRwFb3A71I2WnweUX0RjRf75yE+ekwdJkmY3rY=:+mBQge95ss8SwNAoqj2tF7T6M1gl7Zs1o4kklMQ+gTY=;
X-ME-Sender: <xms:UyvyaqcPXeNzsxQP84us35ZKpxYdD6VIWW-q3mSYim35XACAy0zPTA>
    <xme:Uyvyan71FKLDuI_mOpkAq705iXhe7a-hluFOdkdBJqPCZ9rIvQnTXELV749PYCpVt
    eXVfoenSrbD9NrKSC6oazW1L54a6v8eb3Mu0gufDJ-3g-hRjQ-u0MQ>
X-ME-Received: <xmr:UyvyalUVZ7Ri7Fli3FpjSdgsyOnKEg9B-0MEZz86eefTFXt7dMd_lVBrKo63fFp2nbQe70w_sU0deN-AGmqdwHpUSHpKxzmShiQ4>
X-ME-Proxy-Cause: dmFkZTF/YspG2FhkyZGNkYerTiST8hLQ/q+usDtbSFC1kT61rkU8ibYfk0mkbHbCr/z5EW
    VZ62/9+dxUotnj+fAmoLF5Vo/2JzhRIYoqLqePVuNme4UvnbeC23MvVZkZ6cKKnpDnoSy8
    HR3xaoFQwahRdSF42AC2cyU8+pGxp8zL3Hjrlr2FOFlwnP9u0C1X6KUjmw6qoUGyckHe74
    tCW/nfjiVAgMx1UrVK4lBxjKdZbtrb+aSWYR6e4Dnu1lo7/RAEGQWIKzWgCd5TrWeA9cmp
    sj0t88Ujx5+MpRdyggxLpkgQGIixls3w9vMR/E0DhGXVYMuvedvY4PbS9Blpy7n+8KTtBq
    8XAUBt3fMGQ55WJZl1HO3fR2RxSrBOR3Lvx5U1K2LDlj19C/8+AQsPEueLzbdsE28h1H9c
    ykh0Ke53PFnGnzVw70PVu6OYNMygH0j9Sa6TtnPt7BYjjTINHfkI6/e0rbQ7koys+T1FY5
    /GJqNOB98eyrcb6P2uLnl4s8HmUnwfwQ0NMXKxCQnPWqnPWETu53WT9+By7HDc/Ix5xOz0
    DKGwEuESz7RZg8AL+Awdy694/UYbXfhKAAoEQZZfFx8LRpQEnQnzS24i/OF2YW06iCAJfV
    q8cNNV6qeFtYfl8DVO17YSXrYE3f3REh1hoscgyH4z+khHwWmtHv0FMZmGzQ
X-ME-Proxy: <xmx:Uyvyau7iV7Gqb4xN_65mTsL2TjAQgXlZCU-wAuV-0I3-mROpqzbQQA>
    <xmx:UyvyaopCK3YYefmigetyK6VVo5DplupD0_8XPoG5a45lraCEEebadA>
    <xmx:Uyvyaplvm8CkF8y_OWltffo5RGT5VtXd3S_Alwcq9CmOG61QJiQ-BA>
    <xmx:UyvyasNwhkXgyIXLtNu7Ac-Z_KPc81WrFXbXfK7gAK9GnGRMFZBQBw>
    <xmx:UyvyarZsNB6kQfPWJi-gJLnmKkDDm7xr0JC2jQxwX0dRm04h-SpSAerm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:21:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Mirko Faina <mroik@delayed.space>,  git@vger.kernel.org,
  pabloosabaterr@gmail.com,  ben.knoble@gmail.com
Subject: Re: [PATCH v2] completions: add some missing options for git log
In-Reply-To: <87wlqmxb9p.fsf@dev.null.iotcl.com.invalid> (Toon Claes's message
	of "Mon, 09 Nov 2026 16:41:38 +0100")
References: <63106e1dec45e82c7f132a18816b2d1fffb52752.1791921033.git.mroik@delayed.space>
	<5735bacbd5c2c48eddafb43f75f7ddcdf402ff17.1793656021.git.mroik@delayed.space>
	<87wlqmxb9p.fsf@dev.null.iotcl.com.invalid>
Date: Mon, 09 Nov 2026 12:21:37 -0800
Message-ID: <xmqqld71ycvi.fsf@gitster.g>
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

Toon Claes <toon@iotcl.com> writes:

> Mirko Faina <mroik@delayed.space> writes:
>
>> Some options for "git log" are missing in bash-completions,
>> --graph-lane-limit introduced in [1] and --[no-]graph-indent introduced
>> in [2].
>
> I'm fine with these changes, they do what we want them to. Looks good to
> me. 

Yeah, this looks good to me, too.  Thanks, both.
