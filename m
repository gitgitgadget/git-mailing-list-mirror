Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483065;
	b=zCHPy0k1YnJXfez+jkPDvNWf7yHf3MizVEngMYTUwC7vRfYgeIWg4m9UAsdkWGbOAMPq
	 bWoj7c5g7Ch0q+faAc1Sy9tOIOPqjH2UMvFX3GXE4FZpt5gpHWXispODfhhjny0qcN5M3
	 tMpG+Tuq3L5KiRRaf859QQLoInKPIkHuYpvwkE4TeS+nDZnyxQ5s+Y5H1DxCO04FCmjHS
	 kgRvHkgI85iZNucl+VO6zzEOZF5XXYuadYq/vi9i3J2/ULtmZe6YlK3NUM0rr5TPJdsJ2
	 /mAuGBhervGzrqx+yOvek2+qUeMnDjOOX89GtNXhSnwH1pa0UFpFHhTGrmBGlgLO53Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EhbeG530NCAPGf1xk+VutwfNtKQGh08Xm/SerGSLltU=;
	b=eef+G+JE1Po55CeNA2IzBRUID/7VYBQg14d7JzzowZnqjXZuKzkgh/h5WCB3iQU5Xq65
	 Ong/C4Dikj7TI7cHOZOXzZqVUbq1z9d7RPgvg2/RvlzU7C/z+66XfoYyjYxdeWbbhPLtf
	 oO4qY23CIbtv/0uW2c8ZbZOE7/4MpcrwEAD9c71DYiTfymWVtFxsgFmR+CMn7yTqgsiJy
	 QQZSWwqr+lIv86UpuTJZKi2LNWm7BIrLvpIa8ZP75SKqrHDW/DxRS2k9a0qlNX2HKHDPa
	 iwKdHqI4qKm1UVPrQpQqQjs5N6/ORZlOse5FJwZnaZUSsYVXTKhPbncBSdcg9VUDriQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gitlab.com;
	spf=pass smtp.mailfrom=gitlab.com;
	dkim=pass header.d=gitlab.com header.i=@gitlab.com header.a=rsa-sha256 header.s=google header.b=OTFXMej1;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5073606A31C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 07:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5073606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gitlab.com header.i=@gitlab.com header.a=rsa-sha256 header.s=google header.b=OTFXMej1
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1cef0439aso31985985e9.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google; t=1792483063; x=1793087863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhbeG530NCAPGf1xk+VutwfNtKQGh08Xm/SerGSLltU=;
        b=OTFXMej15Y94vHFPx8TcT29ZkXl3jP5HOOSDEtOg+AkP8+1YD2CJIFnR7zgHrxOXKv
         hh91WLOp2WU3M/xaLFG0MNLrm/SlttuXB/AVKcpWK8plY0KMoT94TXGeeHIlzIsgym7k
         KVOtIOxlQltwDz/R7HLySPyM2ugQ8LV5tziSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792483063; x=1793087863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhbeG530NCAPGf1xk+VutwfNtKQGh08Xm/SerGSLltU=;
        b=0UFOoBGT4D1cUTw78vHjmKCj/rKaK3YlSyzdcEca7EX8QgqSZW3hlxMHHO0PeMWts8
         9RRcofTQ14REvFkW/F3eMUBsac0aeztfJVA2YAQjHGjE01hQThUTjDNMtnGVY/vRb/RO
         XP0WvBKYEVEbs8s3N0+jyzCjqBtykBDVLVOnr8bq7/ivs4aMp2YgRmsEATMql0b4QHac
         6ekjt/s8jRLofMtexuv0TY6VqhfUZ2R6K5Hnmfdy0e6zoihgGKp+6i0sP8q/N37a+U/r
         Zi+PWlXxNuybJLpwEMUf4hPZ5L8SrtpDO/CN52L3uZzjRK7OSY1kJ+sv2adyp/JPg/eX
         /kqA==
X-Gm-Message-State: AFq9FYKV2tXB6j8MGsq7iDek7LIgCtnljqrLsVJXfWbYRVTtRjEQ/gFm
	baxMBblIDnGclObLH4LEBQtxE/UiagA/ad2z0ukTDIn6oJu4Z37sLb0OActikryO5gtWC6OALE6
	x1+pPzGdVkg==
X-Gm-Gg: AYBFou0idLYCqXo/tPS3OSGkiSMrarek+/0HiyvlL14rnaIx4pYMNNBlXy0tI50A3Fe
	8rYRxYVhaYapEqLKOts8JCgpTBA+sconU6I5w8sijR4k832fw59yGc8veVWFTM8M7MIb3H6LCL6
	/MDgQpOHii6CpcTrjpFr56TdiatGvDhObiMVorzpxu49JsrWdCVsa5HKOZgpEhkcpotHLH0s8mT
	QyU2uSNHmZWBmRBSwhaAljYWPk0KhKo6xvMsT/zt9Vhc8Bi7Sd2TPTJNBDxBtkiZR6V7r+Rqebc
	UTVQ030jYpTQrFcz3MNTDvHoZA49scSwNGbukr814OaSoXH/Ud6/36N5B2hLVYIW2JVf+sfyUgo
	e1E4znltxp++2xkwWonMbiAuCFaWCqaU5JIQtJJKGCDLE7NLS8V9r07rxtoKz/yK6tOCN92myC/
	7HKEw6csdgHyT3lEgGfHISImgCkuqR1Fm27d7r/Xal//q/A9NMnQwpYU9x0MPy8D2PFe6nv/Ijl
	bT84zIWMh2fiX0x4hEj/eyISaOW3TS8goSW
X-Received: by 2002:a05:600c:674f:b0:4a1:8efb:c9ae with SMTP id 5b1f17b1804b1-4a1d760d2fcmr194608675e9.23.1792483062914;
        Tue, 20 Oct 2026 00:57:42 -0700 (PDT)
Received: from iwiedler--20220823-X3P9M ([2001:9e8:aa7:3b82:d1e:f419:598f:7937])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cd348asm55426745e9.11.2026.10.20.00.57.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 00:57:42 -0700 (PDT)
From: Igor Wiedler <iwiedler@gitlab.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	peff@peff.net,
	jltobler@gmail.com,
	Igor Wiedler <iwiedler@gitlab.com>
Subject: Re: [PATCH v3 0/2] connected: fix the connectivity check with alternates in deepening fetches
Date: Tue, 20 Oct 2026 09:55:36 +0200
Message-ID: <20261020075536.49286-1-iwiedler@gitlab.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqy0btz3m6.fsf@gitster.g>
References: <xmqqy0btz3m6.fsf@gitster.g>
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

On Mon, Oct 19, 2026 at 04:12:49PM -0700, Junio C Hamano wrote:
> Your patches are not sent as replies to the cover letter of the same
> round, which is not how we expect the threads to be structured.
> Please study how others' patch threads look like.

Ack. Thanks for the pointer (and the patience), will fix this on the
next round.
