Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793732759;
	b=OQ09lN1JhTzrogcrRwvKqbmzZ+QAj7qXsB6ydmV14e2wXZsR+46d9BP7UyuILUhTTAE1
	 fn808qQsoObEdOZw2Y7yK8ZEFt4Ivxovpl2sHXXzlbwV50eGA9WrdXfOgoCZ+uPtC0Pji
	 gQ8+eo+HsDMU/DSRmeaNBhwKy0vzCsOkr9R1TPlot/dYnFNVmVt43SBjisxN3eraxTgZu
	 Xmac9O+MK8E+N45+S8H+9ZzDdQn/cZskHLSeYUbIQryrraEW+1dMlHEgBMqwz5BqXQpxE
	 KjVxjD2G2kuXCSpo7oJqWSrqtLWTcd4VaROoM6xylPCAECJyp+dTRR8hDLnZmGBYFug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:In-Reply-To:
	 References:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=6Xy9snN7MCMjs7MxYc30NcJ+E6uND8pf2Zsc57YuY9U=;
	b=IevdZYRJn5Us/pBJLM+kDo+4CWdexOLFJPzr8MZcEdIjKl3YGu0KkX7Q3WF2eaIylvr0
	 s5iOTbCBqMMsZnTmHsg+q0LOe63r8devhDtmlfIXLrF/0JWp1D+21NLBFpkqkU0WCXC6K
	 hShN+UdHYI+awE4dGJny8iERk3BfCaS5YIJgPHCECnYCAVjQOFYmLpttoEXlkG/YTQQIX
	 e6G4CkPeaP9K8OdGczxe5YkvZumEdGNj9Z9S6gd3/T1/YwTnhdVJ9+mdOOp0UeVARLDJ0
	 TLOX4sah0ZfCzybdlTKb8xSSExxjVhqawWvOt72AF0YXC80DIh/Ibi75+pwPPpbUaqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X8iVnBxY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84532606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84532606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X8iVnBxY
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1573a12.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 11:05:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793732758; cv=none;
        d=google.com; s=arc-20260327;
        b=jmLgF7lA+gEx1a3uKeIE84Us6FZJBl9HmOpTzuESJ3QxVYxqCCOJCtN+onn4dVtA59
         lOtKT+UDzK8jHCXqPJqQqEK5gS/BOOWRvIUTlyUfrF9wrXlZiG9ELEMQ7WA6k9q99NDf
         TUfiWkOL9YjhxMcQcaBad/NSB5ZYDNB+EAEnstRZgOg6fGepQ9mpNXi8DOh6osBw5cvn
         0aBXKCaGvpcd59mWIfgsOSaQzSXXYi/I8GxsQDH2jYwF6a1by+0xrgu6Qa3jzhLt9Jvs
         XBudx0VSzF+VdyhTOAQBfymiOfJBNeEKZqEmRo+uM1S8KLBinRRjuESWjtBjXva+kAyZ
         Mz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=6Xy9snN7MCMjs7MxYc30NcJ+E6uND8pf2Zsc57YuY9U=;
        fh=YkC1o8BhKLEX/2gF2JnmcaCV6Pt0EAOAIz81VezVYjw=;
        b=dQVAiGiFFYcGk2hTseXqqQe+g9wLsXtatDq1YwOZ9zusVG/8H9zvP4IrKet7WTTrO2
         QsRwpcCcT+7Hd30Y3j8gBRjhBzOsf+kSd+1afIfsVyfNiO+qsBvnXUmSZr8kaUlLJSug
         TAgouv4dxqJQJjkM225CLS3ySt4iwlMvm402LRgxpS7z/4SG09ONfv9z5tEKeea0I61a
         mK7Yw8/3RPAvKkbMd4/7kaPUV3C5h/FQlAN2CfOnpLeqa8duPx17CxBq4CT/Rw/ss4SS
         c9e4YoLUxJsMj/D7uBNNPvsWXiV/f2kavO+YLNnLyKT2kOPKTGny2Hj8wlwLpi2nAxYe
         9A6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793732758; x=1794337558; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Xy9snN7MCMjs7MxYc30NcJ+E6uND8pf2Zsc57YuY9U=;
        b=X8iVnBxYvqBh1FVs9PFSAlRQM80RnYaepLeIpWwcmlMgySDxnNTWhgGlGsvgRJy65T
         ux3LWJahQrAXsg6x6yEBvk4m2w0V0LS+QyuNuIZpXn618vYyKG9PthMfe9QUBZagbk8k
         yKzQqHlJQp/iAo7lz6s7NRmXVpgHc9FUYQ2RZOaOGCy7EJbdsVEi1dGiJAHhEGycn8PW
         1DeVqVMYrHZtgcrK9rVFdd9vSchiS2mZ7IXodqFRw1yPWZPxqxDpx/MYlYfy2XpNWUfv
         wGino4y9zCW0iZ5EQ9rEvqMk4zMzkaCLXomuXYYNlm4GFpVcsC9F+LBqOum/D0bH8Ny1
         Qqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732758; x=1794337558;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Xy9snN7MCMjs7MxYc30NcJ+E6uND8pf2Zsc57YuY9U=;
        b=GECIxb/7X31UgBfm4PEZAy9EGdYheKDjJ5cj3b0j6Xft6ntJrPC+5FgrXGQ27Dtoyv
         7Ko3C+uW4HwwnFKxmDO6ffVFELpaCV5GLCKWipJNADDNbVrJnqeyy1v7O8v4wqQ0OXSW
         YmeXC6HLhdv0WKu47fxSnw7xKKDOfaSR04jptnTb9d628GUwvq8L/8T73AOiBc2FXH9d
         8DAT95EMM9v8fANoGPhim8GTBRweDiEA8MCYW1WhgLE+gYpHExjh6Vq0K7g39K2gh7ac
         Vh0EPtHe4badZXrvBnz5YFCMHlDsmnnKDdL0fg7lt6WbZtgAZEJbzJi6U38dvfvZh2K9
         G1/Q==
X-Gm-Message-State: APuU4Z9bsqstW71k8ze/3DXSg/J0ZN7HElvIcLWGlyLXp8FKuoZYBkPx
	N97FsrSIV04aAyHQbK06MMqfj4NZCWtk01UlKh6iQccnyqAiSAzOqHgxAf1TBWiFHBHc65nvsFM
	e7BQjNhv3h0dnrJ8wQoytQi4pfIvtOs/FTctCX2cwZKKCh6YiunVUxA==
X-Gm-Gg: AYBFou3I8AJ3TQH4Unxo89l04XCxKfo9L81zi2Cvql8nwpNOj/j5SUtPqrVdr+7IjRW
	wMEOOy0vGNok39bgZfwXQ+GtZVDj1fRDx5yyCq72kWz9EQvWIn6b99S1eLkyZNKqGqwu2aCukgp
	doTO+vA+t0H47z2uuKKWD8Z5WCCe7vNU+N/ZWvA7AVk8xvMVUn1FMD/EhscLZvyMpquf9KjKhBr
	HL42Z+HhnveFqoE1yNpejz3AIDMk2NDwh6Fcn5lZDCYTBRFTvUxLgLFT8kYPeEkmJJPHY90YM55
	Z38ebQBlnPb+S3x9WqCB76PjvEJvUv2w1atpgCDvUpSIK1aQIudjhDKHh7uPXwHSF39vjBZw/eq
	jqYgVABSCu23wUfap3IMZM6dLba28fR/DGxBGZtCQne38tCK2NhYJQKLe6zRafCi8hKltXY63Xy
	IB5sM46dQ8fAyTL9qSU8u9VNiZGJdX6Mc=
X-Received: by 2002:a05:6402:23c6:b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6b53e99397bmr103183a12.14.1793732757255; Tue, 03 Nov 2026
 11:05:57 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 11:05:56 -0800
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 11:05:56 -0800
In-Reply-To: <xmqqpkwmenf3.fsf@gitster.g>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <80b7f207f42cff0a3dfe23181ee315fdc90e50ff.1793462224.git.gitgitgadget@gmail.com>
 <xmqqpkwmenf3.fsf@gitster.g>
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
Date: Tue, 3 Nov 2026 11:05:56 -0800
X-Gm-Features: AclHuK9tbc9KrRaRGhDNSRJiSTQgB4xLjMV-pWGB0TKzbWwfxW2v0D6UgGz8AO8
Message-ID: <CAF+mdida+tKjE884ZvsgLndzK8AvY0csYLzKPMmXkUpDF0r9ug@mail.gmail.com>
Subject: Re: [PATCH 1/4] http: fix retry count and Retry-After timing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, 
	Patrick Steinhardt <ps@pks.im>, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> > -	/* If retries are disabled and we got a 429, fail immediately */
> > -	if (ret == HTTP_RATE_LIMITED && !http_max_retries)
> > -		return HTTP_ERROR;
> > -
>
> I am not sure I get this removal.  If it is because the change to
> the next hunk (the condition to loop with the while statement)
> already covers it, I guess it makes sense, because we never enter
> the while() loop and we will return HTTP_ERROR more or less the same
> way as the above if http_max_retries is false.

Yes, and moving that check to after the while() loop also handles the
case where the initial request returns 401 and the re-authenticated
request inside the loop returns 429 when http.maxRetries is 0, without
falsely logging "retries-exhausted". I clarified this in the commit
message in v2.

Thanks!
