Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795090997;
	b=XLnS9lt5POxq9j++izxHJMphPg/5lTnYpVRekEkJVSdvl9+WwONl8kfZopgqdAx2jH5F
	 lyWaXKXFYYxn+F2SMMgh2TRRMjeQojFbY2TEzIbZnmfI2MTff3QKbtKJ+pQlHUCk1vV+e
	 ruxKoIYPPbIi0qLwMCQvwvOlryMhDI3Up4hxHUOrlhZAMltoO02hCukb77k6gk30D4o0I
	 i0c6Mhj3FemJR6BRG7IxqE3CHzgFWMm4G98qAVb6NTbedZdUqTLcJr9MEl9dMXH3A58hW
	 3o/iFYdSun96CpXODOZYyDRzg8Nid0JPOGM3q7htJJrtthSj7pb8kQBk5CTNtuWyWEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gAGznzWCqBIPE1EotJt5Z134Q/uji4VFFaZZ8PVP8B4=;
	b=jw+eIyUOXsMRTXzwjfjIXK3MIWw+geDp5baRyVK0F5ZlEjXB7te5s6o8Poy/GYj+TScu
	 mj20YLjXJ6K1+xRQLvHdoxnAWVRhamCh/nPrZ2hRBnOr1GhdSn4sdvcbPK5p7wSpLpun4
	 u3l5JT8stGBE7Ltqept/AFd7RkV8xKJ6kJyVIzCF4sHpfilI7DXbEyPNpzolILol6yxfX
	 xK5ATOKKwpEvS15EyeY8irz/E5ldZcSxhw5ZC1mWZdQY2aNhhB2+XgBVwsVLGCuUt5VaF
	 s7xmYMzdWk4bQfWZOTJqwNRjuTKFAva44VkHmT3u7QQJIOt7isQxEyVF5KAdGstci9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K1JHSMr2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCA3606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 12:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFCA3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K1JHSMr2
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6ba2bd43dd8so1017a12.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 04:23:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795090995; cv=none;
        d=google.com; s=arc-20260327;
        b=cPSv8BfxkRw6VpkmOpusN1Hz8xc9V7HlK8UWIckSXFxMG6+Gm++EiNfYuVblmu4kv6
         oP3eZmd+txU2BRraJnL7Sd6xtXIQlXUT0q8Nk5JAB2/KrsXVaUtFfy4IGS+FFdIn7pG5
         2yTKjArOp12ljxyJNOE3Bn9mpvcx7DNhb2f3UoH648LpBdASm5DRvfoHn6aHYfwWagEp
         FpgmjP/p/ysIkKrMUmANkspkbBBrdVnyhefjx25Xc1n3ikV/OJt98dR7NsBit0s9ulEn
         yEKNtgGmGgM4alOqpygj9VZMh67VJ9bUGCYkASrmjFQ6QbeoTmdZ46WGOkox3IaTplu+
         ajqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=gAGznzWCqBIPE1EotJt5Z134Q/uji4VFFaZZ8PVP8B4=;
        fh=8ECD8eLEjMte1EU6/L1DhQ4yjKEUFuC8KAP4rUPUyhw=;
        b=bP/PQwnidHf6+9ni/9Ro/l5JQ3myVv3cdKeRXXhrLGpSeXWk6RJhLHRVO8h1tPUSKQ
         bTyJr6PiXgZEeEAgMEsDFV1C99TxdZsP/9JRd6v9bVxLB2hoO/UR1QY4eVPJ/YiyoArx
         cbJRBOh/O1PUNs9eaBmd49KPVtFZxgpX10u4U5ByzGVzI7Yuw0b+PdV4tpblhDttCndG
         sWAon2yvshZPqyLVvfAAIdv0kkoXnbqUgNmDfKfJqoxPDbHPkkyAkUIwG0+JsPm1PcAO
         qdiQGfB00sJfDjCjWdAy9vt3dDf/7hmq3PDKoIdGapcJxd5fbVckWJusPT4Ry3+JV5p9
         fxDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795090995; x=1795695795; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gAGznzWCqBIPE1EotJt5Z134Q/uji4VFFaZZ8PVP8B4=;
        b=K1JHSMr2nfVjuobe07h+G3PuS4EsWUAYbrwU34osSZsVWuAhXPhTvA79G9qiOEaIKl
         bpbUqYPSOSk6S44WVxrQGCWTGH3E0xMS/9a2WowHaPe8SXlEZ7St8u2UAI2tHwm8giKM
         jdHNvsgZ6t7+Dnjq9lf6CCJmK5APp8clQk1Tgbr4Y8AFXH75aSJy8Y15WydZM73AspjX
         3WbhAZw1+8nu5SegB5YSkKPT7TXq012TJqXLdVV7W2HYI7FILFNBwQnzCOfOGLAJlpJs
         exbhMfxgvfbe5puQ/1rGgwGyKz7RMprqJra3WUBa5E4o7xg2MOpx14CQL/Th+WX89j0R
         uaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090995; x=1795695795;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gAGznzWCqBIPE1EotJt5Z134Q/uji4VFFaZZ8PVP8B4=;
        b=T8FAvwWzuKzisch4PpF82a15UERz+VHPbnrSpAXotMZMQkCEOl08/Ht5UZitHB8o8S
         x40T6CU9nK4oxWCbF5KWX8fuHcovZKeWCyfZ3Z1jL+HVwWUDzjilataQtnfLzBYcpMkX
         0T/ob1BdIxEtH5+7xpdcdD9RVXmrfCa56pqYYKwiP59iykEguiVbXfdcW+rIgg0WfNKe
         wxYUDhPkIN1qVl1pQKdjzV0cuw3toVW6soW1ICE7zlbwcgtG+tYtyKyTnH9STS+ZQ1V7
         8jDOiZBxrhBJlAWuWUtcF39juhLa5bnLz80G2DN8ofR6TgVaOGnL6v4qeGOrFVCc85tW
         5tug==
X-Forwarded-Encrypted: i=1; AL+hErEP7dwefA9P6DbeQdTDeLDZcIMeuxI92BIA2CUXdVA22G/1gFPWOFRYo7Gd9OtY4UBKgHk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KEYcQtg/fPcttHPGjSUaHZPHXV69EtW9xR9Nvve2deLKuFkgp
	o9myyMlV6+g0Zdov5+ytYUtqGkCxxeykqL1pwSiZa8C+L2hcyjko2dTABuM71MVk0QtT+924N/p
	UB33T9ArcDT2Gyu3/gQQLMsbjOxQq4TrqV/NX4UWY
X-Gm-Gg: AYBFou3z6v779DtYmT6vMs0hC9zzqRXansuosfLP091axkVFryaZJLrETtHnnImMFae
	ltVvs2l1DQXo4GSB0uFpIE468YNr9ggp+8/RB2UkD/O3XSQ1flzj1/yvUNJUo5LloJEIdth5Mby
	KZz4rkupwlvAWaq2N0qN+TohhE92FW503qxfAGM7Ar8P0fNVo3semJJMbpbNWv3L0Ao49wQCGHy
	ZEO9F0z4OmNqJCHaJIdFgucf34Seg9WPzMbIaGopIByJwvJaRdUaOMbFCEo2fJ3zH6zmbXuzpF6
	5cN31cGcN2gF4fCjUZsQsVUK3ez4HsBXsaNUUKZY4TWfiETiK9yQq7ATIClnjqfq1szgUv44K77
	RdQha+Qr9nAQILrGvay6Mhz/Vf7zlJKwv38YJxyOnEgB4EFYAHnaaF96gM1D3gRt3XAjUH1HJVq
	oHCFi7AYQlAg==
X-Received: by 2002:a05:6402:234b:b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6ba144eec71mr53795a12.14.1795090990221; Thu, 19 Nov 2026
 04:23:10 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Nov 2026 04:23:09 -0800
In-Reply-To: <av7dY5lq1AAymnp_@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com> <6510dddc39ca61fe1ae2f81cb8e7febd5f82d5ca.1794022836.git.gitgitgadget@gmail.com>
 <av2TehodwlsK6BnO@pks.im> <CAF+mdify3esjp-ghiFj6uQEEwqQvOzMd0+Q9Z36BoWQGADb8tg@mail.gmail.com>
 <av7dY5lq1AAymnp_@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Thu, 19 Nov 2026 04:23:09 -0800
X-Gm-Features: AclHuK8ihu4ZaqEsvUkpDRWZp0L0A0lMKXF5BoP3YxrnvEBjiMDkgB6yVE5gK00
Message-ID: <CAF+mdidmOBb+DnsCCQXCcENC8389pou=whA3=7AGA8n4xY70=Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] http: add http.retryStatusCodes config option
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> At the very least, we should document that the expected behaviour of a
> service provider is to return 429 in case they are overloaded, and that
> all other behaviour in this case is considered to be buggy. The config
> should thus make it explicit that it is a workaround for buggy providers
> to entice them to fix their infra.
>
> That would hopefully nudge them into the right direction.

Documenting this makes sense. I will update the http.retryStatusCodes
doc in v4 to make it explicit that providers are expected to return 429
when overloaded, and that configuring other status codes should only be
a temporary workaround while the underlying infrastructure is fixed.

Thanks!
