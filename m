Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794254600;
	b=snNtLs1Xhf2ADwTPngdtXVs5vtBWx3gqfscWKfj2x9eDCDa7H8DZEBedGn31GQRxWa4e
	 Rk1jHHDgVKeF1/CjVTlcI78/6VJwxBi5XfuU2BhM3gjLsN9mY6zduwFHxeRqdky2xY0I/
	 SAHtwdNRsGO9laMiDde/y4cLAYRNZmNIB3LjWOPDIXK1bUtbk4sYlqsR6WHKmNRFm7ilf
	 oFS3TPiM1HARbWiUipFshoBsZ2H6mG8rgvM3g/wftyU8Kff/Ukf+Ia642L+wPT3npj+QQ
	 qlGPl/boylXNtyO/T8BTTuDopW80cJTC5cv9VqrWDKx3PS2rkUckW66jGgBzpIJRtlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Y4kZ8guXknhtOotkqgqHEc+djbELrrsUqH1EWifJVcM=;
	b=DThZwNzZKmrn0c6a01rWWra3IsjZ3ugHsBChF9MaGSQ7s54GqkVuU2wDvempgNKE4qMt
	 qq7IIh1V+AM3rCBW/c93ueLbQqWrw/l8jdhtcKvDpO0vvnJllU6GSEJ/jZxqVxAH9onf5
	 sAK6PvBM7iE4LVQhy/B2DrBIDU+MYx3+9S4C+V8GTLAO65BghbPMU1oexGAMEW4TkEdA+
	 ALaxDj/gSXFu0ceN/bcluy/JsEGFdUJz916Ucs6cw1S2GJTZoyJRnCsBcnFjzUQA/Yzof
	 u/r1uf3V+o08OTLCvVe6CSnciy3o4R5t46C4uxhHwLgFIs5mxO0c3NImCExZUiRwvKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=thomasbachem.com;
	spf=pass smtp.mailfrom=thomasbachem.com;
	dkim=pass header.d=thomasbachem.com header.i=@thomasbachem.com header.a=rsa-sha256 header.s=google header.b=Ehq7ujLJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7E606A326
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A7E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=thomasbachem.com header.i=@thomasbachem.com header.a=rsa-sha256 header.s=google header.b=Ehq7ujLJ
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b3541bb1a2so7042337b3.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 12:03:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794254598; cv=none;
        d=google.com; s=arc-20260327;
        b=siXPljTZdsH5nJ1nWYjvitkxAGR4LVAk7xWLLns6wX7EZfhOaLCHlKuZccWBuvc5gI
         axlkz0YFLky3kL4mdNeTjdY/n0HrEkwg2J++mJ1jxdRwhsVUi1SWrS7RIrw1S1Z++mz9
         NoYajGp7wQFPziFU2yHRkBguWF3CKQ6cztgNMyLH40VKlN3uyyPAdK50jwbCw2thWOWD
         5w5OZ73r1SHd92A0z0PzMMW23TVtGYw/wkNMTnN6CWwHIAXsJQ0azMyx/vHMqvA0j1lC
         00sIrjnVHiTApwgbMSe0zW9L8rNQhsOChrCy88jNUJQ4ooOMaKBArCpP17kmhAv2Lia1
         JXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y4kZ8guXknhtOotkqgqHEc+djbELrrsUqH1EWifJVcM=;
        fh=OK/nmuozSytqlEz2PNKkpp1qGgCI+bJd2ibhLmY4gi0=;
        b=SUf4+Rq0YEZAiWMaTZpwwY32kkG0q0JaUqgBGdgf7RKWsEMW12xSQstn7z4svWkWOo
         5Ldy/A8oDly3Tg/hLo1XD6Yo5dsln27lt6+ZeoDgeNzUccNN2OzzmaLDuSintZTkrL2z
         y8etQj0bWduytvGzWhAP+DCMxVPNwMj0akggbmc7rOjxk0183QvcL8XFDnGumAzmtNqg
         77maJhGMl1b9p7EK0rkgJAL5Vy5FfAGdk1F9svVFu9/btYqZLfyKOlXlzlxAOXdd55QT
         ei6ZDYxHCyVhf67x4/4WQ4xf1P8atyvffvS2bQseBZtI8Jkm6MrPpjQ6Fa1w34cZCMHY
         vZcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1794254598; x=1794859398; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4kZ8guXknhtOotkqgqHEc+djbELrrsUqH1EWifJVcM=;
        b=Ehq7ujLJ2B6p3vG2QwJhSo6XV0JKTtTBVk/Ra8Fm8qKpuXBNkhkbwT6u9VIwNqMTOu
         ivwMnN31h1njT2qvE506R+lGs+OGeTr9x2XkdOWDxqAPMrANaI1VZxokfSrRnMflb683
         EInhivm58ZgYJpNr4IA5wMyl9InkQHXbqOGae4dvnY5ZhL7F0USnVl9q0wMsJQA7Klp5
         +7Paj0QgfTLspX+taUumxezaY8//jMIRuRMOxu4ZYLhrybuMarqLeosaHW4QlxoPQS7w
         Spvcw6hgqlyCfGfbav6nEH305TLM11OTmHC3oNOoBEJmgRX6h7p38VdI/sZbMi1DjC+L
         +V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254598; x=1794859398;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y4kZ8guXknhtOotkqgqHEc+djbELrrsUqH1EWifJVcM=;
        b=T8w552dib6JmaGAcugqk9YNw4+80uLOU3D801KDe0v9S6vn6f5vPDwVzCnsrBOi1nh
         ZJ8WD8UtLaiOMSc8vK5SCbBeLASGGBftxFiaIJ+1hxT+VWY4FzdfLsCpAmyT9zkeAKB/
         he35eZsfJnT7Uaj76R/rqtgIKLpcPmCPgY2uTWliemRmim/XxClwnk8YSh9kiBYZR61c
         uhAsM2nttTX9cizY4u/aU0c8DbEGR2CzzCawlFNCzGGUDnu3qrqcWrfAkQPnMCNVHmM5
         SfkU8Wau9PYIdRLQQkAl8VNwKs5s328SMXvZEGUiydeNfoMNWenBB1804vQhS/5W3qCE
         YvuA==
X-Forwarded-Encrypted: i=1; AL+hErGcsqllypZlzXy+yykVnJCl68onxljQrIrnI8q4rO3JOQlCGwUDJXAyoryRa+ekN3BitEA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LNPRd4Y1n6BlmUamkKsR0elSQt1RUsMhwe/fIQ1VDnjZx003G
	7TcaTFxubnCa5if1eHLcm20Z1m0Tj0NC/zW8pRGYkMZGTNCjQWUOFWsMUgcM5IakF0cK8E3HwX5
	iMaJ6allbuJHP+nghzdkSVPv+Bagyw5yNmW975Wf2xg==
X-Gm-Gg: AYBFou3ZEn6lzbs7R7uGR4K8nwKhRhc+/0VU1s9uZY7h8ri0lSq9z7tS+OeknY6lBT+
	NgK3t3wlatofgvnAVzgzCufM7x578oyEUfSbZmfZbd8MBV1jlKqK1JRa7Iekt9/HEWct7DD4Nyt
	mbKuwpn/IZuqo7V724FW8rtfOBn8VqI7MIjaLqa79P14X45/HCyYek4QhVEikYSgO9joSvsAVU7
	5ImzRaq5ehwUr7GO+kFY7mP8kAYyJKfhsDfDr5wWdYM0SFFInMhPQqBkdpW++m8j42uIkvT910C
	kglYZEYq83BtWA4E+mBcsrg0l2HleFzAkUBOGdVjDeZhjXeR4853En8zIk9k2LazbNaT0Ocx3bv
	edLo8uwmJqbTQ5rzP7znJrDXlQ0kFub5/l4Img63jolft+uwukCDs6vZ+mprhJX4jH59TWrjrjK
	6MljIIznMivjL45HIG7s9pc2ai0g==
X-Received: by 2002:a05:690c:7482:b0:8b3:3d53:9106 with SMTP id
 00721157ae682-8b392d14b76mr1844597b3.110.1794254597988; Mon, 09 Nov 2026
 12:03:17 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <a9a3f4b705f98f0957bc9645395f4c68875b2896.1794040967.git.gitgitgadget@gmail.com>
 <226aff79-b0b8-41b1-92ce-78554f6b2f8b@gmail.com> <xmqqa4nhzt4t.fsf@gitster.g>
In-Reply-To: <xmqqa4nhzt4t.fsf@gitster.g>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Mon, 9 Nov 2026 21:03:07 +0100
X-Gm-Features: AclHuK9rWyCkroo9C0wK3AqB-xAkpVRUORTIqEKuKuW2tj99zYQZ-MUCZ6yCDhA
Message-ID: <CAA0xjtrBL9=aWqS=+e3suFw9ziRJixxHdCDe_8ra50HqzoHoog@mail.gmail.com>
Subject: Re: [PATCH 01/15] rebase -i: handle NULL value for rebase.missingCommitsCheck
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>, 
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Colin Hinton <colinlewishinton@gmail.com>, Matt Hunter <m@lfurio.us>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Miklos Vajna <vmiklos@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> It seems with your and Derrick's review, this is the only thing that
> needs to be updated in v2?

Yes, v2 will change only that. A missing value will then warn and fall
back to "ignore" just like an invalid one. Thanks, Phillip and Junio.

Thomas
