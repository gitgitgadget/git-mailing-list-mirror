Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68018E1F
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731274754; cv=none; b=rJQbWnm76/Nti+fqRYZ9B3/0hzA9P0uAWP6HHnCEhgFc1wyHw2PxAPIg0cjPVVT5g5MYGXqjXDKKiAdxhGrV9R5AqDRbCCDjd26GqFSzpCQqkTEnj7CUbqtf5eWRaYgzI3Blf5DlUYocViVwGLvGyDVylsy1nqlrtELGv4U7LLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731274754; c=relaxed/simple;
	bh=xFv5Af7t1csA/ukdFRTuNr+/lOzLrZ4f/crcu15yKv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q1NC3yHuX992kMzRJPKEDQ07rp3aTiQygtOAxWbJ8h23tH5LfOVSSanJygFF2kRfZ7zDg8lj/BNfJVZp1tgyEVYsGI6RPBUh7hYDibhskT7ZGIOYaWU8TNlvyVvdf2vR9X5nVMFFdNyBRQTnSXgHiNPp52TWx0ElwY9YEflswOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT3W/NGC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT3W/NGC"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so2310561f8f.1
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 13:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731274751; x=1731879551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xd/iByfiqdf+reFEyYW4bIUBb8o2JgEdtin8VbNrzcU=;
        b=OT3W/NGC/KTGwUGqyUo4E3a4anscQeZCzJfbUbnxjyY9Rqcwxe8MZxybepddZNZ9da
         8TV1GqXAESGtSoxqirR/m5K+8F9zvQ0wwgD5ATjQVAWbhcXc1T1gbiE2+modEHLJefVe
         tuZmGRqkO+gqj+xiUjsjfHyV0N1xaSPh4UjhzkCP6qQFfugDqqXcCSXzJMMSUikLcOxh
         +WSiEe+pan2YJbzZXRhYhfnUwlAkizAlEcF7ep0mYWNzKjPczuQXwF1toIcZcf7epr6O
         qd0eMfUJj8EmmWj62W/mAA+T/uTjfQPBHRPljFYWvda5YAyWtiOuNcrkIgrIhXpTe2C8
         D/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731274751; x=1731879551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xd/iByfiqdf+reFEyYW4bIUBb8o2JgEdtin8VbNrzcU=;
        b=Tzl0q/2whu2TqRPrz+ArMGC7RIeAYiEqsO+ac1evf77SAYPB3nQSJPq68kbofrYl2j
         Wb1Mj+HIlDKVy5/tNOpE61MUoZaNaujcnS6+2uZL3j+Yl5cdrfj1XHNJdqATtMsXhHJG
         MVI56gqvgvLleRFNEf6zxVLtZcr+p/J3ks5In2+l6eKHvwWXEchN+s8z56FxPA+M3sWf
         RS5RnfcYjDqz1Z8B+M4WsJMayYl7j7y7IJIV8LyPMcmw3ujm1UK44SwzL7FxEIfKIguu
         6Vla6QBNKorHqC52Zct3uWM7F52oWNl+A+xRolTtenTVDBqg0e32ilgjd/4wU2a1C21q
         VDAA==
X-Forwarded-Encrypted: i=1; AJvYcCX1wIM9mh6t+YdsNKqqXDjlZ/pEeERuZm+MoxZIk5rCg4RZD5EEheuPt3FjC5Sf1FeYld0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6tQsDwDcBvdbFZaifwObvoYGF1luT1GpM3GBj6+b+o3PXkl5a
	1iCHIKzWfzFpmz9EIHTu2SSfdjQ9hEtIT8aN9wdmRZX/nJYMKpL2
X-Google-Smtp-Source: AGHT+IGlzIkpU3TOQubfqP/BoEo1cw5Y3LnDTOSEmQElg0v3xAux3XKt3/NjWmKPi2gFGSO8/2FnMw==
X-Received: by 2002:a5d:6483:0:b0:37d:5364:d738 with SMTP id ffacd0b85a97d-381f18813cdmr8416335f8f.45.1731274750676;
        Sun, 10 Nov 2024 13:39:10 -0800 (PST)
Received: from gmail.com ([178.237.229.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97d658sm11171001f8f.39.2024.11.10.13.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 13:39:10 -0800 (PST)
Message-ID: <41165e8c-eb5d-4fda-8f6b-67b7ec74bcbe@gmail.com>
Date: Sun, 10 Nov 2024 22:39:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/26] strvec: introduce new `strvec_splice()` function
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1730901926.git.ps@pks.im>
 <c23e1a08854530f5c2474725ddde1da1068c2c12.1730901926.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <c23e1a08854530f5c2474725ddde1da1068c2c12.1730901926.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Nov 06, 2024 at 04:10:44PM +0100, Patrick Steinhardt wrote:
> Introduce a new `strvec_splice()` function that can replace a range of
> strings in the vector with another array of strings. This function will
> be used in subsequent commits.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  strvec.c              | 19 +++++++++++++
>  strvec.h              |  9 ++++++
>  t/unit-tests/strvec.c | 65 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
> 
> diff --git a/strvec.c b/strvec.c
> index f712070f574..81075c50cca 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -56,6 +56,25 @@ void strvec_pushv(struct strvec *array, const char **items)
>  		strvec_push(array, *items);
>  }
>  
> +void strvec_splice(struct strvec *array, size_t pos, size_t len,
> +		   const char **replacement, size_t replacement_len)

There's nothing wrong with `replacement_len`, but it has caught my
attention because in other strvec APIs we use null-terminated arrays.

> +{
> +	if (pos + len > array->alloc)
> +		BUG("range outside of array boundary");
> +	if (replacement_len > len)
> +		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
> +			   array->alloc);
> +	for (size_t i = 0; i < len; i++)
> +		free((char *)array->v[pos + i]);
> +	if (replacement_len != len) {
> +		memmove(array->v + pos + replacement_len, array->v + pos + len,
> +			(array->nr - pos - len + 1) * sizeof(char *));
> +		array->nr += (replacement_len - len);
> +	}
> +	for (size_t i = 0; i < replacement_len; i++)
> +		array->v[pos + i] = xstrdup(replacement[i]);
> +}
> +
>  const char *strvec_replace(struct strvec *array, size_t idx, const char *replacement)
>  {
>  	char *to_free;
> diff --git a/strvec.h b/strvec.h
> index 4b73c1f092e..4e61cc93369 100644
> --- a/strvec.h
> +++ b/strvec.h
> @@ -67,6 +67,15 @@ void strvec_pushl(struct strvec *, ...);
>  /* Push a null-terminated array of strings onto the end of the array. */
>  void strvec_pushv(struct strvec *, const char **);
>  
> +/*
> + * Replace `len` values starting at `pos` with the provided replacement
> + * strings. If `len` is zero this is effectively an insert at the given `pos`.
> + * If `replacement_len` is zero this is effectively a delete of `len` items
> + * starting at `pos`.
> + */
> +void strvec_splice(struct strvec *array, size_t pos, size_t len,
> +		   const char **replacement, size_t replacement_len);
> +
>  /**
>   * Replace the value at the given index with a new value. The index must be
>   * valid. Returns a pointer to the inserted value.
> diff --git a/t/unit-tests/strvec.c b/t/unit-tests/strvec.c
> index bf4c0cb172e..855b6023371 100644
> --- a/t/unit-tests/strvec.c
> +++ b/t/unit-tests/strvec.c
> @@ -88,6 +88,71 @@ void test_strvec__pushv(void)
>  	strvec_clear(&vec);
>  }
>  
> +void test_strvec__splice_with_same_size_replacement(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	const char *replacement[] = { "1" };
> +
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_splice(&vec, 1, 1, replacement, ARRAY_SIZE(replacement));
> +	check_strvec(&vec, "foo", "1", "baz", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__splice_with_smaller_replacement(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	const char *replacement[] = { "1" };
> +
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_splice(&vec, 1, 2, replacement, ARRAY_SIZE(replacement));
> +	check_strvec(&vec, "foo", "1", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__splice_with_bigger_replacement(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	const char *replacement[] = { "1", "2", "3" };
> +
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_splice(&vec, 0, 2, replacement, ARRAY_SIZE(replacement));
> +	check_strvec(&vec, "1", "2", "3", "baz", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__splice_with_empty_replacement(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_splice(&vec, 0, 2, NULL, 0);
> +	check_strvec(&vec, "baz", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__splice_with_empty_original(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	const char *replacement[] = { "1", "2" };
> +
> +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
> +	strvec_splice(&vec, 1, 0, replacement, ARRAY_SIZE(replacement));
> +	check_strvec(&vec, "foo", "1", "2", "bar", "baz", NULL);
> +	strvec_clear(&vec);
> +}
> +
> +void test_strvec__splice_at_tail(void)
> +{
> +	struct strvec vec = STRVEC_INIT;
> +	const char *replacement[] = { "1", "2" };
> +
> +	strvec_pushl(&vec, "foo", "bar", NULL);
> +	strvec_splice(&vec, 2, 0, replacement, ARRAY_SIZE(replacement));
> +	check_strvec(&vec, "foo", "bar", "1", "2", NULL);
> +	strvec_clear(&vec);
> +}
> +
>  void test_strvec__replace_at_head(void)
>  {
>  	struct strvec vec = STRVEC_INIT;
> -- 
> 2.47.0.229.g8f8d6eee53.dirty
> 
