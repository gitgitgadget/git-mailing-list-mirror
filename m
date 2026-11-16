Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836600;
	b=1wCYJ2dZc24ZcP9l8s39777dfXGdgzwnWbq5UEACAqjALHchPcLlCTVekzwwgGgfYNl9
	 tZ7+gN9zdIVacdLLAAMqMhU6hZj4XHH5t4i907rRODE8gMf8kuYGGOmumJ4J1I6xQXPp3
	 RZanMIkFB6gC/+HOa6olbUiDCFO6BrAyI1TuYOa/OHmfxoyyIv4ulH9M3F/97Ubxzw4qT
	 JvfkwzX6Pjf/8iSh1B2a/NTlcPI9Mc7bcTHiz7I7x4PdhCJXDEXtIthueCeYtAUG6JIeC
	 kMg46x6XSvgHWxB6nsGKB3vNixywqfry94tEHhUv2REgzu8vJlA/OP5Vbl/65v1fwMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PfQElnZ8v47kC8WatWtAEKtRu83VAwh5tnp0qn2WF+c=;
	b=iETJuKFn7/PGNKNxYk5y0dOcReAEFDxuICIrF8Pzkr3hJuJAfij16lfCnmWMxIjILPKQ
	 7ASS5bmEuxJAd2qvp8WTvvzVamYf5OzcO/abAToWGLEFzMlWIVVDWxdhUs4Jwef4B6w78
	 i3bhHHfdpgTw/EtNRkf+2WoYPesb9EPZX6x3ReObDTJ71lf0bqlOg1aLmDn5zwYerJtEq
	 +Oj81Bw0+s7DEW/BJuANy2i+OUvdgmaeOcPsXO9vUTUDP6bSUABsmXBEGLTTF/L1io3oM
	 vVxvb62e92tKgLgAGYnJL17EaBx9yy/95IIWkXQ/IoXUfp0D6FpOAVp6QUx0370SOJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QSbS0YKb;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E4606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 828E4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QSbS0YKb
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-536c8f958d7so22869211cf.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794836599; x=1795441399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PfQElnZ8v47kC8WatWtAEKtRu83VAwh5tnp0qn2WF+c=;
        b=QSbS0YKbfya8eDsdAbE3G+D3KFGm8E7vyzDM+JvhtFRGeIF4I1lbO2SVdWl6zo+7qS
         95GNOrlQNtYKyjsks4jB/X1Ji3GI6uMkGuA60gUVevmF7/uIl7IeytLoBS0Vvs7MvesD
         mVG0BqQH0ZjF7VbkO/m28xiSKfKzD2kkhGNja2wPUNt30zKPXcO2t/PLnEaYGHqM39xQ
         N1syZ+h6OvrMIxYplUQK8AqtjRfTUCI3Sv3wmYBK+poowZ7E414RH/pGYwDCGKIH/GQs
         FtwqUZRyQIT6XrEn+qRVl+QHUDC5jhD4Buw29Zt7k6fRVZz1yoYrnWwMCmRG+U3e13AJ
         hXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836599; x=1795441399;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PfQElnZ8v47kC8WatWtAEKtRu83VAwh5tnp0qn2WF+c=;
        b=neWoKu0gNc0z6ios6S7s/spTkDd1wXBRXOV3E8ZyxY6T9l5DWLH8tyMhvkCf3JYJnJ
         85krXYuygSzHz90o+y0lv32w5lONUhPcnXzO9fO1k4fM2TWo3DUbM8eidG9YcBEHGZzW
         dC/iUXzuVeOeCz8Go9oo7Ek2M8nKUl1uGXuLvcYTIjC05veKQxUTWSNK9nU1x0YNmY7o
         cHJ7ciWKrkGMtidMG59h79Vv4jQatSTldqDzEsJ7Ins4E4WgGG4PJw/AnZH1CnYEX0VQ
         w6fd9pSsWIz00JIolJF+y+/a0cNjYz3sI8EjHjbAee0jXP9iukuvl88pGATauU+mMCkN
         Sc1g==
X-Forwarded-Encrypted: i=1; AL+hErFUB78Q7jCIvHauJ19DJzEV7I36t+su+IOMZ0wRVLPvaCaTcRkxEXgl4W//3XGU5ukV8wk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ojyqyLI3uHvjs9zTj7xDQonMSB2DV9BfzG4jtXhFBEivVqCBx
	QvPtsYptDXcxe/JX3DqbnXMmT3ZHFFt2ZWhdlzBNIG+YvhzrAP+pMHBx
X-Gm-Gg: AYBFou3rtIgr5PHkUaC3dLYq/lEcr3OZ08AYYk1xNljXu4H+VonXBYkXDKV6kRBAGCs
	yAYVSMJXvlue/C/KL2pAxFWNVe1yr2iAxCf3HFpev+kSKKCXok8wpQINW5TkHNO8RUu27o4e/46
	/2+4h3aGqrEnLaR8S3zGPPY1Z7Zy74z1ZnmXwoMLjQXr33oBAKstWiu9bvMQO2XUJ13SVNT0e7k
	1fnHE/rE59ICVX56E154kt61sS3cJCIbFapkFhPxzGNUuYhB/KrevBjL6PcqKjd7O6xSsIwsljg
	8AHbMR/GNYdZicgsNHEq8QKRyBlURjoE33GK5YtGqMTmlk2/fMhetPbmMqx2aonm0aY8kyycFeW
	bfg12KfYw5504IZlsKZ271rkuJ0YIsTSJzcRaqMiTHarD4OIlRRwBcIQMPZ8zN21shscys6FCNq
	1FaNlbT40f+klNcJd3/Q+AOZi22qwkCk6ErNW7fs0CjXSSehM/2aAPECbzyAJbqucd5FDU6LvYp
	ac6r8MNEsGhfQZtpO5lDnk70KegCwt9vS5VtbSJDoggrYlwktDqDEpd7pplgCL2ESCR/UJZfWiT
	ClgpxZ18h06WHV9/CfSLfPHoSIK5itBP9slAhQr3e5wuAZs/X6DTiFGBnvSMO0lE85mSE5mKUHh
	rjAH0+qCjQxrBJXoBr2AvdtSiqe6ghwjaW3ACJ82gbT1z+U6YSFxzhR+qMfhSlsJSBweq6P7MOm
	SgmCZAb3kUCT6r1166TFfIN5D2Ul7CKZycxjTP6l6TbtvdhHU9n0xmWEwU
X-Received: by 2002:a05:622b:1c2:20b0:55b:e0b6:f2ac with SMTP id d75a77b69052e-55be0b6f5d8mr96568271cf.9.1794836599251;
        Mon, 16 Nov 2026 05:43:19 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0a2006csm81724881cf.10.2026.11.16.05.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 05:43:18 -0800 (PST)
Message-ID: <0b4f65e1-bebc-4dcd-961d-42da1fe02a77@gmail.com>
Date: Mon, 16 Nov 2026 08:43:17 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] builtin/repo: don't fully parse trees
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
 <20261113-pks-repo-count-objects-speedup-v1-2-7ba4f29e74fb@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20261113-pks-repo-count-objects-speedup-v1-2-7ba4f29e74fb@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/13/2026 6:46 AM, Patrick Steinhardt wrote:
> When the rev walk hits a tree object we read its content and then parse
> it via `parse_object_buffer()`. This requires us to perform some extra
> bookkeeping that is ultimately unnecessary as we keep those trees in
> memory.
> 
> The only thing that we need the tree object's content for is so that we
> can count its entries. But that can easily be done without having a
> parsed tree object, all we need is its content.
> 
> Refactor the code accordingly, which gives us another significant
> speedup when executing `git repo structure` in "git.git":

>     Memory         3.4 GiB ±     0.0 GiB      3.4 GiB …     3.4 GiB
>     Memory         0.7 GiB ±     0.0 GiB      0.7 GiB …     0.7 GiB          -80.4%  (5.1x less)

This is an impressive memory reduction! Very nice.

(I'd comment on v2, but my email host must have bounced those.0

Thanks,
-Stolee

