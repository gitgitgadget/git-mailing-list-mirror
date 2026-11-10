Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327220;
	b=GnLjBsOuKHWB3mTk/ZoFrfsz2dStNthi4Hp114vqdpJMi61LaKwDqwHWW1B+Q/4qZIRX
	 ogahQkqtX7VanLLfPH+hmjoOi7Y5vwI8cKX0V8+pnslaEZeCdmBsTI+tBcUkRKc9td8n0
	 nQw7nLZtOlPg6jDce30P5v3fJcPHOecQ81J7stuubNPrIdr53lBHViG+qdaq8LvmfLlgE
	 pCu87VZUxRuXyNAX8GzVNn1SsVgDAkZzeJEUWf7fHfSvdkUWlBNRaRkj8n6LxuDUClym1
	 8uLkiwVM93w7mo4S7BSHIt16cUmT4oiWV6LallpgkAdS3IVcrkYf7ASM+cxMq5TU7pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q2CLbYmextQLN9SvjW8u9jjRlmP5ID23dzxVTYnCHIc=;
	b=aJPSGj8TO8vkWVm9PYvOcb8KrCXTn2CCgQcTCJGi8vXd+MHw1ktPS5EJYmt9i2C81b8J
	 xedczeRDJgbG5qanhJHMVY351uTIq5E2I+On9SkR4Sg43bT6aYbG0xjGOZLqPJr4a7LZr
	 i5bFIhTLn5q+6LoY00kX/jIn7xqsGKriBT3q6CG9rv6Z3wFYh7c/HXFdX4nCX+c5Jr/Rg
	 gCGq229oPISkx3g3L1tENySQ/qS43p4RXAL/fUpcm26MEc+FFFggxny3OUahvE3BnVxzX
	 6KS6FzODP+oqVX7yaK51JSder4gUoODTYU5jFcjgNyJZPk/wr+8ZY8yoTMy8fJ4DmuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z1OUz5f3;
	arc=none smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7F606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D7F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z1OUz5f3
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so2209258e87.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794327218; x=1794932018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q2CLbYmextQLN9SvjW8u9jjRlmP5ID23dzxVTYnCHIc=;
        b=Z1OUz5f3e+ZP3oq04mhyM/8GggclA+E1Rb3FGL4s30VCjc1WIbAoYBExi+bM1MIuDK
         FCjBvPkonwJ2M3QDgk7z2vMxTbPkWIAUUoROAuF7DOUl2hOWP1RmiUSczPPAUFqN/ETl
         8DlIbt3ANaUU1mfK1U0by0wpqt7h6ju3/bwKTDv3QwzkWpMi14cWbS7qXy1HarYCbBz7
         2Zq4gBrp681DaWGIyiKBVF1cgL+nb4angFtC82WIcuOGMsLCJYMS/8qt0Zi/ch124yat
         wgjM1DI9SAyhOJTrJIxAqqgBAP5ETVpwMu6hCXKSBdgd/1bQxPwVjzErTtNNXQwYsMWG
         op8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327218; x=1794932018;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q2CLbYmextQLN9SvjW8u9jjRlmP5ID23dzxVTYnCHIc=;
        b=oCoBdRj/VZ/p1oYoQ1BqSYeAoIErfkNaqVaTvewpikrZhR2oisqWEt6CDbyCLvLcmp
         tZ6XCCbVwWaTGILocDGKEx5qfEt9Gvqa3d24iOe5J9yVUJzsYjPXXBwhxGOj48KAUwKL
         QXkZX7N1M9w8K/pUqz2Ceo1uDeG8HZ8og5eTFrZ8CGt9ZychGHHef7yPWY8EeD1J2LZj
         YnLOUMY8L5S+zGXKqjgehCy9U653ejGxw5q8vUuU+0Hd0ONxwrU9PtYLbRkQ5OnRlPAT
         8exb/jiyoaeCR95P9PrgRBUwVuN2hp5gTj0OmikdaMZBHKjhlj25QQSHDVWdgJatJagy
         2D/g==
X-Forwarded-Encrypted: i=1; AL+hErFZ7UGjFNP7FtP+96nQcrwsVTqIJ4L3K3xCpUIBtw6qMN+BVcENdteHCl9ki6LpM3sfe0k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8p/VfhZ5/JrLn+c7oeWpDnQvyQHrNxUiP0+Z91NPWmG09rxjoB
	EVJKMKeCrbrmqIwS7XfkXF2knUEnYOoLAGjmTXefsRPrTJr48j5hEciW
X-Gm-Gg: AYBFou3CI1v6Oz3/tXPslXhcUil40SQYfVeDXftRB31WR3u8dLv/D5S5B5wb6IhRyMp
	EcbLNE5lF02u5SnuFDCvxK67vEhfVuF8pjK6RzSI4qX52TBdyo1Tg29kET44Cz6vwXJzOhRnwSD
	IeTjk0Zddve+nroKCkaqC8x/YBiETJByG7TF5pYhuts0w8fHnLss5ACgp0PoE+EoudYD7KNlND7
	kDEp1FhMVk8WGNBS33n5HJhW6Pqw0sBvj9svw02oZNEJIbTaLuiyqArH5Y2ELGvwIseIw3esfl7
	9pMgQnG8Y47VEWzpgELxozxXMxVjN++xA7JUCJlwMbs3M571VNk5MOwv57IvFS/KEMsPd7UwWSE
	ObMEzNv5CVa0NTCRkFwDzLZW+c7Z/aORZ2UBCRPJurCP7s7mIQKLQxb72Q6MZ0ItJQbcKniXHGn
	NCXkHJch4yeZT5kC9DVLCWPuIt/K+NdZPg1uVcPOdCbSJx8ViDQvE1GJgHzap6P/6fcI/yYennd
	qPJPK1mrOfDYevylbCwYfK/XdnfZOoQZ0RynJ+Js/bLMJ+u5TYcfl5TeGzUqtaMHu0F0Gxcinwi
	uUXxjxj/YqwnaFVfVLlCB/3Iu4e/9MyWu7DZcLGaWidFNC7JIiBGWPHe94+LaIO9fw==
X-Received: by 2002:a05:6512:2399:b0:5c1:57d2:354a with SMTP id 2adb3069b0e04-5c15c7b3adcmr22376e87.18.1794327217770;
        Tue, 10 Nov 2026 08:13:37 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157b79efcsm516531e87.7.2026.11.10.08.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:13:37 -0800 (PST)
Message-ID: <4e312218-292d-4449-98db-96cc36b7b089@gmail.com>
Date: Tue, 10 Nov 2026 21:43:34 +0530
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
Subject: Re: [PATCH 6/6] object-file: stop including "git-zlib.h"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
 <20261102-pks-odb-loose-cleanups-v1-6-fbbc86c29693@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-6-fbbc86c29693@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 16:50, Patrick Steinhardt wrote:
> We no longer reference `git_zstream` in "object-file.h", but still
> include its header. Drop the header and add it to all the other users
> that implicitly depend on it.
> 

This looks good and straight-forward to me. Thanks!

-- 
Sivaraam

