Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165149;
	b=vRnC/TLdNgAR1Xs68uYgUB0aaO4z5ozezzrJLoFZxn4URUjbiaGVla8vixM54Izaikkh
	 mo02MAxTVpcSVjTYXe4+vbBixaRYr9/zyICSrC9ae9C7MXgBRYAjZBnFJFRVAJJ+uxCSa
	 a22PQ8hO8zTuMtr1W4s1RcjSJ1DzpVVWkVJJxMWavhGHoQPh6Q9Oj0SAOVdLmqH0WNSX6
	 2NTBBf9u7aBtr+f4NjTmPUB+0tBGH17MrZ1iM+kUJuVqGjTfaI4IUKJ1pGc5fDR3D5TXS
	 qsQekjSUxzkgcPwRyaF4DqFXliueS1xbctFPHiLKFhbb9x3r8MbWv5OdRqP5yvpZJQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aAE714njjkEBSzbEX/V+hus5gTF1yTY+jYUSwlsIXkY=;
	b=KgiT7w77TlDJ4sBY+SI1I+i+YN+Bmti7u1RFFKnGJnpi2lUgPwTnWflZV/AaBQFyubnC
	 OqSW8MLgrPqIxCymbe0XHAPkzdLkxhpTXhPHzQ1OF+za96vVmQYAiQNGJ+cOGrk1oUsWK
	 Q2toY0uhf7DdAV4LB4es7gF4edGFN9IEPl9FNla8ABnSmYuH8V3EThzoZMhxzJgmc5vHy
	 35fqGIz4jn41D1MkA6Sujwn982MdKF45s7MJPBaZ9/QfxpNi9IUCAeAw1CaAh15qDXxiR
	 XCIc/UPqas4a08TVQx4XB/UmiimMfsEMHLL1FecDEzQjamWblB8z1iDTERCjU8/SFgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BOSYkqKx;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9469606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 19:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9469606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BOSYkqKx
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a2af4c8d00so515973c88.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 11:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794165148; x=1794769948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAE714njjkEBSzbEX/V+hus5gTF1yTY+jYUSwlsIXkY=;
        b=BOSYkqKx9V9CTMUTj1TGCfHKZNcRESrNIBUsxtoDtORFLhafQJuJZNXxQUn6+k0CWl
         8+GYgx6dfY675TKGUnrC2MsSnW3Chhe/E19fIzzF/TMvr2WcfU87A57F6+C4qyUZG3Pc
         efjSKHsFe3OUvtPnCTm1fwrcUNMSmbYIZUKHqwZPAJmGcE76L+P6/m0cP19OmMNVonri
         V3n8TZiutgNiYz/IO/KG9EulvzzFRNGEdJjgZSxOJpZwt/Ap54Gg0bldcVIJKrGZIFx1
         73E5+iUqTimfzgbzC8l3aTYaDpdQBd6bxXeBOohag1QZVRbBAIpWmJEBBGLOdPF6P/FT
         rUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794165148; x=1794769948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aAE714njjkEBSzbEX/V+hus5gTF1yTY+jYUSwlsIXkY=;
        b=HcRPcOle6HzIDkreBUmS82eXYpiS2kP7r+npFRvjVRn4pUjpVgznafAg1L82WRAS8x
         Leaju62DrLCwj1N1RzS0yJUr4d453wS4t6YrWV+6T0jbecSSAByZwu7JC/tQjhA72ng+
         QrnNid1DBl5pkA8svfjAS9ZsFGaqwzfTCCq6htOKbAHQBCtstjIJPAOIq31e15+OxPmW
         4bbXZE5Oi20ICj0y/FceJ2UhytIVTEbNbVNYXOjzyIWHs52wwvo/ReVkMlQfJglqZyX8
         JnG/Mc2gAMRPJOTaUXQ1kXSJBOhoqjQC5iPtPEgTpQkW7Dmml/hwN/xkvrjiybwEkrgZ
         RRPA==
X-Gm-Message-State: APuU4Z8Ys3ZzhjRVDSETOSDNTYC1yyZpe/wrCKEojRKGSgjvi1G2anJl
	eLC84zcOcBZ0ztUzj27UGIfOjAfixlAdBgd29VwqIQML9oLWofl/e+gq
X-Gm-Gg: AYBFou16nWKJR/ibznQL2ILmVIsyustSFxsp42PVv07mgsBRg3Xc2skHPpEhj6y+9MM
	ne+UG7xAX5l4N7vcf6dmzd9bZvjQb+ANhykNiQ7Sjzpc1Cv+025d9W48dp7d8w7sbZAhATlZ+J9
	vFyBLCQAWpSvcdsz/vB/326fEflmKzSc5wEdLM9xaZnWTWCl2AcsS/fy7MRkzDm2lYAsr60IACF
	Fp4QOVO7WmcODENVIc2IvTAhrYDdEgknsYRHjT+RL7kURNwW9fFF4oYe3PTzWOcj8LFJ4M8rB5b
	mvThHFwYtxPDCpaRiKI0Y0yvwUyds4a+cyp4bHwBocYYiOhi8mV0avQGEq0e9AEHdEOqXFnwKex
	oVVIWaiKgd3gYA8NQVlOa1COknWWX1kxiYlxtvcYGCaZz/bM7Xz8VPzp4UauGnFM7G7npWL6MqB
	9PLwweK+iK6vRf/4F6Wr4a/m6PB5SR7TO4ZePegNAj0he8s2/gjbL+AV3vYmbQ3AGY9ssSa9Irw
	oYhYfDqKAlqBS8orT89Y94Q9+SuD1TgjcbWyfrqthPzr8w0IT3hZgW4XnXJqwLa9zYKWukyJgMM
	3GfxRRbFbk6ggSe1mP7yqbTNtOF8KwPOXIEb7M2Qj1jjIYxkU7DK
X-Received: by 2002:a05:7022:458d:b0:14d:baf5:c415 with SMTP id a92af1059eb24-1b39fecbc9amr5039185c88.7.1794165147823;
        Sun, 08 Nov 2026 11:12:27 -0800 (PST)
Received: from Anonymous.localdomain ([223.181.58.0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771e5728sm6716223c88.16.2026.11.08.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:12:27 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH v2] doc: describe promisor remote fetch order
Date: Sun,  8 Nov 2026 19:12:12 +0000
Message-ID: <20261108191212.594-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqse1b2ljp.fsf@gitster.g>
References: <xmqqse1b2ljp.fsf@gitster.g>
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

Hi Junio,

Thanks for the review.

> Would it mean the same thing if we replace "next remote" with
> "other promisor remotes"?

Yes, that is what I meant. When a fetch from one promisor remote
fails, the objects that are still missing are requested from the
other promisor remotes, in turn. "Other promisor remotes" is
clearer, and it matches the previous sentence, so I will change
both places in the next version.

Thanks,
Hussain
