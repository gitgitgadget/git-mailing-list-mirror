Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549660;
	b=C0UukWHn3ENnyp4mpmrVXldtnyKRcSNNFJ+AwB8DIn5Fl1i6NQh0tsGuU2ZIdY1Z8c/w
	 AMnA3ZeJ8G4LP7/yYDJQ1v+bb9J61yzo2nl9IKkVHvjsfDJ5AaNu5uF2qQBXvbOedOPIb
	 lyqtm9F6wEkGtTwLVA2T9hLKmTVPFSbUmZdh3n3qq+nIOg1vQeIGdmxRStOBqO4t4bk2T
	 Gmx7ng8BjBYnVJyHf544etqwJNiSGBQMtPmmPAJIVhV7CUbRZQEqIs9c15E5eGa7CCqBc
	 7cTN2q06QS9PpFnZY+l0oOPBJESM69/WY6PzNXJNwAI0Z7i87fKiNCvbvum8/SwN7Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549660;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=yy+39xH/ZRDjouidghPGD9nlI/fM3U5OimHDkiOmibE=;
	b=EbNnAjGxoDai+gpDAsZuNrR52rPyHdeQjLbXc3LRBfreovc7W0UXv3niWUyz7fWq0UG8
	 JcWhqtfK9U1t1LAs41X4QiSoNETxfPyiqZyOymDweqNpVdFYotJ5UafjGmIoyDDoo0UzH
	 CDBTP17W7x355G0MX/zgYRKZupv7Shx6tUVWuiRHRJ3ajUZn6gHTmYU4Ue5rEqqKV2NS8
	 RvtoqSX6gu+xS8GGA2cGVBAX8Fsisasl8rZUtXmrvIRhPzABkcf4jV4pwEoW87zvIj4wd
	 MxaQzvdHeu4Rd2V1zBDPrQXWRxTy91bi2YrZVEK5oKRIdGROZq2u8Vvw00+TRmki1dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gzMoWAbu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="xPCBmMk/";
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAD606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 02:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7EAD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gzMoWAbu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xPCBmMk/
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0151DEC0216
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 22:27:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 20 Oct 2026 22:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792549658; x=1792636058; bh=yy+39xH/ZR
	DjouidghPGD9nlI/fM3U5OimHDkiOmibE=; b=gzMoWAbuMGbwSVOhItfa5vUZLi
	4+de/CoZFn26hUycqmZRnljs17G/ysQesuePIkggD2A/QAA58T/4lvEiNBiKAGE+
	q2URwcwg0CDJgrOyEZZuBA5QSmJof6Df4UgbM42eD9ttSpBYkDdLUhJDXCMI+Syz
	TISRfW0vZ48pQu+5HcNUtt2iWpHAZ2QkED41Srah0T6zM+FDCWpo0DhCk0Pe0ZV/
	L15dKP75iH83N/EFIopLjnF1fhL+ZEYwhthWJRlsHGByLMeHcxB0T6Zc24p3lz1w
	Aljg7MrMT+UpQbK8RyFCfQ9CpL8mdf7LqYbhWbWqoTqDkyPq3Xd/wRfxI0eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792549658; x=1792636058; bh=yy+39xH/ZRDjouidghPGD9nlI/fM3U5OimH
	DkiOmibE=; b=xPCBmMk/Cg/q7vItzDapyHojm6ko7n2sz1rkCyWdDfv9/i/5uGy
	bdqwShrtaFGdFpXU9f3O+UKbCiT1myXxZcYh9NYWAoQ24JUXCdMOiFeuVphTZhLI
	y0JJlAdwjkyqGkWVi+glJLBJeBRsv/EQ7c2f06nY+yDGdagiCgnPLfckOkAh5t5R
	4VBkmaJfdDH6wFCwXUvh2Jr7O9wGliO/Of7IZJD5bjX4v+qHygtvGNX2tL4LKb2I
	4zSH8MlMzSvjPmQTuMqk8NESeMAvpQ9W4p/Or9WbeCXPLlcVG3m8NRTgjvp1pE/e
	5S3aufEewYvgJdgM5e0iTOtm9S4t1dY6Ngw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792549658; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:boqrECmX66MaiIBC2nUtA/byINAyfPgKBSUnFTGQWoFzqlA
	C/5QfGiXeGow2XlX17bbt65r+T62tstMuKxJ/i7zZCNxi0tBYQBPNHyQ/K++Esrz
	tVxZjo9d1l89YboT68skEDWOISldZBo7YUwZhc3V89rC1w1vnIuTcfidrk2gT8i5
	ig13G/krNbNVQus4VQW1I9YWw8VvYEriu85kNsHhQxlY/PomMcgZ8Uuz14eJTRt9
	ZvW835cwRsw014r0a6/c0TQ5cm27EjarjAgEYgV4lsaS+JPdj/Ou0vWfCRJWSN2n
	ENBGq5PdIyEFpbDJShECW0Qd1iUfjxWnV2Lvfng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:a6QiRsf1Hr+tvVHXfV6rNJZkGpwZpMbGLrOQCkdMIv4=:uHEsCPD0Xeb97ai0qKI+rNqT8fmZTy3tom7bZmg1nhY=;
X-ME-Sender: <xms:GiPYaha4eUUtfv9cphkQzI_UET3SRht7x5OWEgRjwnVGeYL8x5gkBg>
    <xme:GiPYavQLrNOUf5gpv1nYXvAnEt1AJB0l03GBdyIy1oFsEhqyBM9ZBhbon9L9KmlxR
    sQVvx6I2FlTrdWRkii-KFrKKWbayQeIQQBo4HKeCpUtkPXkk21C8fs>
X-ME-Received: <xmr:GiPYasThAPMfhvfYEhrSaLVGH1CKFdFLKxzcZk0hJAXy6GDwC1S50npNLMuortyKXIINPR7jb-QaSQ_lBKgS8oF0SQ107o0UdRp8>
X-ME-Proxy-Cause: dmFkZTEZdbitCfsJJth9zO+zTcA1eFYOWEZb9P1t3jhs/BVH4onHWugMFUUGoaoE72RVPx
    Fmu8suqU2FGixppeVieimpyueRhe5dopsa86XXuMKTpr5QGqb6JskseGarJ95CqgGxTSNW
    M513LZfuNwiNa8R1jX/i5nASR2LCPXu+Dr4ZX89HuG7WEJlHZnCXtw45326T3FPXpOcknJ
    3JA4kusn3F7dTPBLZM97rnazwZCvf3kEd0GYtQ+C4bgXOqsTyn4/j9r+plK/T28I/+jkuY
    esTQmnIwX06I/CrrDE2lYbgPrhHPHFnLX5V29KWf06CMkzwFNMbsDmeecFoddpt3TqrPFH
    Jny93WKp+rWj2orNqjBoiISsPkal4A6QG2anU48ZJkyJYC7L24jWx/1+VexGGLCbSQ5vpJ
    KIBsL4eP8Nidn//UbWif6KgTxyr5XYh+7hQzZyQ0aIbozf1RlKBRCV2Y7TrenrNrsbJ/y0
    I93Q7vVj2f0+M1q47hfibnHcTq5YaVmf+zK2hbB3VtwC1JayPMzFLHszSkiagR3y0+oIQa
    az0vSmwaR6ReLIwi7yAbZLJetLBzLd2tRHcaWR3s+Pqffw4yYz0GHVJFTCQhQp3VSVZfKA
    bCQn6AbE2vfPCqgvYPraE8dSgxWjkCkbmrVX4J5v1SZM7tO3jw1EA7uMoX8w
X-ME-Proxy: <xmx:GiPYarRih-Cy6D1pyBPWDsfZ81ai4fLcD-i9dPRswlntY4ZYVSXv-w>
    <xmx:GiPYap57WIe5y-SAkYvsy1MQLBfovcx9ofzWLhEIytHpSzSG8XNx9g>
    <xmx:GiPYav3vYB0C6VULYgiqR-G7hwGI8w025ysdauRCYVAv-OqoOfkXEw>
    <xmx:GiPYasDEWJNXOSHHCs6h9QREdTw7SHcU8_KB0fi6Y-cPFuGq11-VuQ>
    <xmx:GiPYauithM5JCzlQmaKK70kGH7p3UMxc8EoluHlCSrKfaHo62z_UNXsM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 22:27:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v3] refs/files: keep root refs out of loose ref cache
In-Reply-To: <atcNOMxaz2WxDIA1@pks.im> (Patrick Steinhardt's message of "Tue,
	20 Oct 2026 08:42:00 +0200")
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
	<20261019203427.2637569-1-andy.koppe@gmail.com>
	<atcNOMxaz2WxDIA1@pks.im>
Date: Tue, 20 Oct 2026 19:27:37 -0700
Message-ID: <xmqqik2vss86.fsf@gitster.g>
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

>> Changes from v2:
>> - Drop fixes to documentation of REFS_FOR_EACH_INCLUDE_ROOT_REFS and
>>   --include-root-refs added in v2. I'll create a separate patch with
>>   those as well as other fixes for outdated uses of "pseudoref".
>> 
>> The range diff shows the changes from v1, because they're of more
>> interest than dropping the documentation changes I'd added in v2.
>
> Thanks for this. By the way, I would recommend to have a look at b4,
> which handles all of the bookkeeping for you.

Perhaps it cuts both ways.  Can you tell b4 to do the flexible thing
the author did in this case?

> In any case, this patch looks good to me. Thanks!

Thanks for writing and reviewing.  Let me mark the topic for 'next'.
