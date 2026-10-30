Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372877;
	b=E693kR2afndhS3j+vw/J0O5HxcikcQiFjiKUT2SA1B2NKRdr2b+E2S9cDOnGom+WU9da
	 5VTNuZiCZMbw6bklpKTbeY6VmgghA1VKj5uUVDJa1Dp1NmAzkunfbn5gtQt82px/29SHi
	 7hPUcRI/0jyHYOH/WKdP3pPMEd5y64w/mvhqSGe7YKLi9HSBgEzWpb8IOcIpPgFzE+xIo
	 jl0avBROY6g8Jh1chOP+DnDsuJOA4ykqGPeApr3xXbAHetrLtlB4Uu9+pZZrzqOMh2xOu
	 6pQ7jAIdyXt4/2NvpjRRZKsHMt4FCi/zgG+pO7o75G4gYZHp62n7LCO+0HgShnnefYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M06Vk9WYIVNoB70LXsXx8iwkYP9QQlze5DZG0pAsaQ0=;
	b=AEirvfC+5mp5q2kaf7RHhaLGGYl52vNLccaV4Yk9Uf2Jg+M9g+OSXvSxzsmzGxw3mJ3B
	 DuNAZOhxZaXDKpp63jrlVlM3BljW8WsfLc8zBQhNxzBirwm0YoRsmflBTDLQvmGMbdXm6
	 ptpnsBIINHFLeAG4SIvpYgTmE8YxMzZBQB4FmoUZRezQl8b+CJWwThKqWjmbExzRX1rVa
	 6MgSIuyV9HWCzNwEZzwaWJCRX/s17rbylLRNpf4SzYGr2PS2Bnx/mDSzPBbtlNSMeNpNZ
	 WNmBhalkzBnrLslroQEz06vtFN6v8TSVhdW5s5uXXR1pluIWT680xQqXA+34G40XTbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJleqmyw;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237AC606A33D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 237AC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJleqmyw
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4c9abc1824so120746066b.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793372875; x=1793977675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M06Vk9WYIVNoB70LXsXx8iwkYP9QQlze5DZG0pAsaQ0=;
        b=VJleqmywsqpxYROj9ZsAnMzN8iZrsnoLdElCsybFGqakVrf78wu/3jU6g85o66oVMs
         K7+eG7S4kownMzR3cM+HrvOLM/AOpwsZtybFXNDU32q7BXqKD206XJx/QVpo37B4pzmc
         ZZBbEeRr0GkTmvzP2yZiC6RPj/AF4aq0ELnznIgyx1TKQKQdKQmVMQxItzcuV2k3lgfJ
         LER4OgWo7U+emzoAM9UhI1WI4JpH3nlnKQ9RZO0OuOkz8Ji6dOP6it8cJ/3D+dM11Gaz
         fdpVHmUNQ6X7gxUlHt4fy0jaFmr+7kqDxcFfSLzDlp74MKs1/dBKn09i0heZZ5ynyDBC
         6DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793372875; x=1793977675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M06Vk9WYIVNoB70LXsXx8iwkYP9QQlze5DZG0pAsaQ0=;
        b=YZI5zoMaGNLtbjY2zbWt6vpq8vhlSANb/VmMnct8Ld7FxlLCdk3GOp1bUpu4vhJCot
         iOpONYyICFupGMs/TkG6OLxM4zRE1T2SbauxRrD2sHnvXJbl3IjlcStuZtZxo+OV8XKb
         pHXs0WOwztnNa8PkPoo9FtGDgpD+Mg0+MccCCEB8pWDy+aqNVC1tOoKSiDqjaeDkTiqW
         xmPpSaIntaKuzzkdvU+XNIqudl+dkHZZC3D05qVGXm88ceQxfRpdEtetcDprJMt2TUzM
         W67pqpNeC05K7BZc4tfHPzYU9n0Cxzf/4cC11Rdhia6c7cRWdGkMpj8A6WAF6q8ir647
         NeNw==
X-Gm-Message-State: AFq9FYJgKl3YGedzMGWp8mvNOsKDe6JqVvZ1UXrxd0s9uM418eFKJ70y
	eIyze9M+dpqJfvnWY8IPzfjBH31U5VHaG3gJy8qYR0rSmnBuipPq1xhK
X-Gm-Gg: AYBFou31QwsNcyKPs2c6k48ZJM/LL6gc94QLGcNNrTX2zv1CF45Rq20aXCjLL0q/VsE
	RKhiir3JpLQ2E41K1A60cEtNhyTjD222t8+CqT/an7CTOv+DVCCioaTOoZjoN1G6Z3mi7N6+Krj
	OuVF2FEa1Ue0KNYaQFSgbux1UHkF1hqdfR6In8rAcVqiyujApBWTOE95z0T2EuTvv6aE1nOUMV/
	TH5GCjHaQeBXbYv7S0HeNKhaLUPpzIiXwCLxo7EuJfNGHQkAKwK2oDDWtxfo6FKvjnRVpV1Q8pR
	d8AX8QM+z+05T/1FW7TR9OcFz7LFLAgWU56RnSuVWDQVVSKA+3v7aubscU4lC//ne4J9hYxPpNA
	AKTMazS0m3Cb8nLWY9G7rdFT0inv1OdZMAbR2PxXMFS+TyatG9SzyrRNOz4ROBSTBnjJmZbL21+
	peSvt1PY26rpRfpVVwf6q6AJzDvVV135YaBgCIS7L9kWtKjcdkBmUav/Osdnjer3Rwb2xmb85+w
	P99gIlZQja2Quk9J4Lldr15O5L5VvHSTD4fRHQugv9kDZegsk/31RNO4p1P8JyquMiDsn/9zqhV
	S8MdMFzLykzdyF61w/u7ARzC9Mc=
X-Received: by 2002:a17:907:1b0e:b0:c2e:2252:6ddb with SMTP id a640c23a62f3a-c4ca7a4dd49mr246682266b.10.1793372875271;
        Fri, 30 Oct 2026 08:07:55 -0700 (PDT)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabf32384sm78041266b.84.2026.10.30.08.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:07:54 -0700 (PDT)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] submodule: make '^/' work like '../' but with an absolute path
Date: Fri, 30 Oct 2026 15:07:39 +0000
Message-ID: <20261030150739.3855910-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqqmrrzkppq.fsf@gitster.g>
References: <20260929185122.3127574-1-lightofmysoul@gmail.com> <xmqqmrrzkppq.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> One bad news is that t7427 is taken by another topic in flight, and
> this topic will break tests when merged to 'seen'.  I'll try moving
> it to t7428 before queuing, but when a new iteration of the patch is
> posted, please make sure to check (1) it applies cleanly to 'master',
> (2) the result of (1) merges cleanly to 'next' and 'seen', and all
> three pass all tests (not just 0060, 7428, and 7450).

Thanks for fixing the test number. The t7428 squash looks good to me,
please squash it in.
