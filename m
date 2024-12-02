Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4A1DA103
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176879; cv=none; b=fJ3xpdaobn87gK5gxjSW0WmtCzqVuRKFKt11f8Pf01i650vyGEK+Jy+uKUldBtKi3seWOCUuZRkhLeOYgxS4tLl6lqJG+ksGy9S0+VZbxZBlu9OshjSi2XoVOPtOQZjKIcfqK/MRuzJ+wraPiQE2DQsEC3n73Qq0ys/rBKxH31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176879; c=relaxed/simple;
	bh=J0uZX0pOpENwipHdN80lT+tDVrU4hPBSX1MJxq82Fq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCQW9TqvCawAl/EF8IbcSQpr8OG/yOH/8Eg454v3+omf0RChz3qhrWNNwD7ZdjgPJ7MMqLGOmCKoKgySGHLf5B9WVyyg73QSUK3pJBhSCePl7a6xJUH0H2tKgHO1HKZ0fQ9EMGV/LJiPzvBwKEpd+JCb9kQQP3zg9OKw/aerOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcOPV/TF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcOPV/TF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so43358895e9.1
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 14:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733176876; x=1733781676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33aYrf2oO6zP721looDxAtPCLmJCH3MYhvWLx9HaoLk=;
        b=EcOPV/TFFSSZVo3iqrJvYf6X1SgDS3V1kj8P3WJIXQ5C9mR2sVDTj/QFbEG5y14yIK
         TGiwT4Rl1wV4PdIElwvD3mZNsWZH1vXf11vc+8qy99ngPmdLhmRcLSpcqLxR3EFWg8jj
         ydRvxqs3KSmn34mQ+gU77ceZ6QvN7U11tCeftA+Ktj03g0bJCEhsYZAFKfdO/fuY3zW9
         RUhdo+9IIZranD/uQu/WA+hEvmWw8SJIvsaGiE8K+ugCLrmN7dUhdFkuGfvQJnmYUrcF
         xQUVb3n76T2f9kLWnec56ocG3BRpSPHDQLMO8yoAbvnQXeDNx0huyYZE2UREKob2rJV9
         UcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176876; x=1733781676;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33aYrf2oO6zP721looDxAtPCLmJCH3MYhvWLx9HaoLk=;
        b=a99bIjHPsSNE2hS2lPNVhC34DXPdJzV2XSjuAS8eeBVTe31OAaJnyW3K2iaUdqQ7BD
         IPVU96JuiU8IkE/j/zMKJLIMU3F444wt4FoxgTwlIBMM84IGz+lphTtToMZUJjmjU0Z9
         66PPTQJBmePzdifjI2EBu0qkxLBtogRqh82MN2q7/J2Ws+Gj2yQjVOFvjvdqF4q9YhL5
         vx+hCihuf3eV99Q6Z1j2TaRZz6oeVxhkSn5dtmMCyvkia3TRctoNuFZ1/qL15gBwkKAm
         O6c4DvfZWMm350loKiRNqzCPRio504A2wF90VN8Em7lKIcUP5aRfyvwOAHNoqUvfgHR7
         YTWQ==
X-Gm-Message-State: AOJu0Yx4qw6p5TYc5e4FGGuHZMO9lkq2mkP4+HDFVRZ71BKLzYnL7NAX
	tu2XFbieWSExhhDAncV6Ao8vmcQbCohS1JU0KTu6jGQxqi4SSidT3R2u4w==
X-Gm-Gg: ASbGncvNO9CDvMgg1TDACB/79QTrLOUJ5imfcTCBUNrQHsXh5kNu3kJzGV1Kux+dYWN
	ynLtk2YJ5SmBPXZyMnPd5G7AMvvaztj9BeZ0haCBcrkOfcmmQutZPkMyX3fEaRma688GkPThhCT
	rgkRqV1fJWGFA+TQkuOhNctxyZ/Pe+TZHzvmZzFxTgzhtQCbG7XnCRyaYRZsRV51PVt4wPAOVya
	Bhr6zgctsBnbZfBQdpYIK76h+DQ0LoAW+X1W47/3fgmJ05mSk68y08+auUFnd8ZzzorGNMLF+Jy
	4hudi/5F65k=
X-Google-Smtp-Source: AGHT+IE2zXEAZ2OTgKDLK2yEbVediMFnW2XlszmIyzvjwf3OlxcptD7MfhhcwVEZrPZDgYcnvpb9Ew==
X-Received: by 2002:a05:600c:4f08:b0:434:a781:f5e2 with SMTP id 5b1f17b1804b1-434d09b5092mr629195e9.8.1733176875991;
        Mon, 02 Dec 2024 14:01:15 -0800 (PST)
Received: from gmail.com (119.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dc63f7sm165173845e9.23.2024.12.02.14.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 14:01:15 -0800 (PST)
Message-ID: <b0bd6c5d-83eb-4545-9b38-ab4e69d3882c@gmail.com>
Date: Mon, 2 Dec 2024 23:01:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] strvec: `strvec_splice()` to a statically initialized
 vector
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
 <xmqqiks2kg6o.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqiks2kg6o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Dec 02, 2024 at 10:49:03AM +0900, Junio C Hamano wrote:

> > Let's avoid an invalid pointer error in case a client of
> > `strvec_splice()` ends up with something similar to:
> >
> >        struct strvec arr = STRVEC_INIT;
> >        const char *rep[] = { "foo" };
> >
> >        strvec_splice(&arr, 0, 0, rep, ARRAY_SIZE(rep));
> 
> Well spotted, but the explanation can be a bit more helpful to
> casual readers.  If there were a few paragraphs like below
> 
>     An empty strvec does not represent the array part of the
>     structure with a NULL pointer, but with a singleton empty array,
>     to help read-only applications.  This is similar to how an empty
>     strbuf uses a singleton empty string.
> 
>     This approach requires us to be careful when adding elements to
>     an empty instance.  The strvec_splice() API function we recently
>     introduced however forgot to special case an empty strvec, and
>     ended up applying realloc() to the singleton.
>     
> before your proposed commit log message, I wouldn't have needed to
> go read the implementation of STRVEC_INIT to understand what the fix
> is about.  From the fix by itself, it is a bit hard to see why
> empty_strvec needs to be special cased, until you re-read the
> implementation of STRVEC_INIT.

The explanation can certainly be improved.  I'll send a v2
iteration soon.  Thanks.
