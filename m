Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99D37EFF8
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096905; cv=pass; b=efgI0eM4hMxa+Alg+ZpDDfTDy80yQY7pNKbHQe7Ol3/D568cOdwvf6X0S5N08lIDSAEP4T2/KIonoaEPwWTzj28jDKkoynNkbqG8+8qY/KiZXQMyt9FYiWrQ2Pjz2a4hNeKK6mnp/8XfPFoLmDUexFvKzD6KWRMi3sTvJgTo8/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096905; c=relaxed/simple;
	bh=vJoCSK/1ckLMm8/aKy8RL7ZUsOFycEJ0AlpQOQVpHlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTZTOwHAP39PF8L9/fyy3lhoyRPFfWWsRVm0qJoBTHIArbGijeFPFE7qKHIA8NpCruf5dWRsCooLWsYDsx5Uzx11mMtlmtBZmeeXyWHaB7H6EqYuzwnnK2gbxdlej0Ru0sVAY8d1vtKgPL2wOeNU+WmPQGwlFHw04qLmHXr1Xw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwuBuutn; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwuBuutn"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad79df972so11743522d50.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 15:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773096903; cv=none;
        d=google.com; s=arc-20240605;
        b=CHl+qV4PbgIdLMo8+ebkNPIRzpx7qaDljok9ykMY9oT9xAwamzRvaZgkT4BFDJ4h4i
         gR97W6p/dxxJLeb2ykSa7erwTUzzArmM+Y4wPq5WMMhXNu+QuPcSkHADLxh+HXtvfm3p
         dVdkqC/zyfqZmke482E0ChXyqM312SH6zHnQjeMUp/MKKewCkT6YSV7mLEWxvSIs6eH9
         cOVw4cQqUGd+kpphSiZnRHkW76bEWu3aIvDCi+P8bk5ZcjNuY6fcWoTqSGSjF1YWyhUg
         g3NxPm5eljKc1RLfrML6oeXimBTIzvwGAPi9WaQW2HAFD57Lk5TCsJIGv6q5dczsuodu
         4LVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5JX6mu+42L60+zngVQjIpoHFtEnUyc2lCNZD+LjnJ6Q=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=iTd/ls+AFYKe8SK3to0MgLsln31C04e/VALVkL2tg8oB/s+eTvqYjmifHa1GodRoxm
         MsoF68VMvHfm8VdAPiXzQwDM8B9jsLdWyn2s+48YBgtvpmD8J4Mp9ijAFVrhOuEc+nov
         RPTPKtOqUqMuuhWYmBBe+IZHs7TYzpuWei9+s2yOJEPhTUk68lO4LzrfvwUyFyKHsUPd
         NCED7mVl46tBxjIZC5gICdB0VbfBpDQJD552LNBSNP0x0HcqnaDz5O5w8Z1UEj9d6sMP
         DzxPQU8cJXn8W8/1I2w28PxeNADBC2wbuvJBLO46w3BXdHuabg9OWd2IkZFzNwBHpIqw
         6eSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773096903; x=1773701703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5JX6mu+42L60+zngVQjIpoHFtEnUyc2lCNZD+LjnJ6Q=;
        b=JwuBuutnhZqQwy5be7iMSmSlbHOzkmsQburbn3eoQQk3YnVhBIwNVh0E1rDaew5Whh
         GdiBEHxry5Ec0bLElqdPc2/rh8SJeWe1DolXsNUBD2omc2UhfseFxq1HFEKgc8BbG33A
         vVx6WvmfEkEWzjpLKb2X7CulmHTlZJDpIqQj/pBV76wFkGQFr2lMf0O62aPj30B/K1kd
         b/Ce+BmHOe8k9HTnpYMdI06xyvpWQIWpehZqx1CuW9jKM0aArCNJHMY//89mKMQ3zRS8
         A0zS78NjGdTQ1S2dlLADZec8rTqoF1BI2ofXaSA/qFWq/ScS4NfieFHf2d6URcU53TrH
         Dy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773096903; x=1773701703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JX6mu+42L60+zngVQjIpoHFtEnUyc2lCNZD+LjnJ6Q=;
        b=P7SC+It2Ftu2pD/RHRJfuy/6PQX56UejyUh2omcM35iwj7gwvjHV/3ohEbQoYkR90+
         T52h1RxbJ6OzZ3Ml3O4+fqWpb5ThBoN+0IJ5DzNFS4a2WdGKVLPIxB0kL3verlxj39JY
         YgTBz/+kmaS5yWFFcB2baBRsvprS7VHuxRIH+CHnkdyWUZnT7MJuHXk5tWb+jb37NdN/
         ZiXxyII2Lng1FuOReQonyhCRUcU0XcybfKvW2cMFGa7xj7SXGlUZCFPPgC+SNdipkT2d
         uErQ8/mQsBDDn5MgaiXFV5XQGrkVIY+spj/sVzlvdGAfJS0EAAzyErVFfXyyrG4Pjlbv
         JDVw==
X-Gm-Message-State: AOJu0YyB3beFRMQ77pGyqaQstBN59zJOpPhLpZy2mYjuQTRRXltngQyW
	kJqm2cIiYmB3WW4GWrHHHLXyhr0jIQz/VJc6WWpLSDJfOx3ngkUty2AApTZzeeBfAW4CMn5cZqZ
	5Vz2WRQmWlh07EqmWwvOy8xfVGEJ3lZ4=
X-Gm-Gg: ATEYQzwZLAn8qwESeNtSsdcYRwcpyaeYdFgSpAik5YzjJxDkIhzdmMd2WFAZppOpVa+
	evSZScoXJgeT61ik0p+JgPNEnItihZWKYPfOZ5zkiHj94pZ/HJPSB+FEcDdRJBPCejYmxUxFGoB
	3XQcVxrR7puJAvd6uz85TF8rwgvas+2QNUKfFif95YbADGoPgxFCVBFFW1boaS/KuNkLJPMQkrZ
	yvmRF619P3E7KcLUJ+cNluULL5rs5RhrA2nw/dIoH+j3eUA45qcCtmwfWoAZkZcUbJ7sqey8K43
	gT8ggi3kMbJzlpdp9XIrk4nKURO3RISAtXeJ/MqTM8DY2o0DtaJjgKCfWAcGahDLcSEz+O2QQkK
	zoe9rAvwo5RsZi6ZY6BOjz9s=
X-Received: by 2002:a05:690e:4194:b0:649:ef87:5bc8 with SMTP id
 956f58d0204a3-64d14062964mr10894776d50.7.1773096902866; Mon, 09 Mar 2026
 15:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
 <20260309162832.605969-1-pabloosabaterr@gmail.com> <xmqq8qc04sxh.fsf@gitster.g>
In-Reply-To: <xmqq8qc04sxh.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Mon, 9 Mar 2026 23:54:48 +0100
X-Gm-Features: AaiRm50vBdRN6j0u-5ngeDGtA6s9DZyCE4o5U6sN9b78AxCUUkGXyW-Il0VDQ0E
Message-ID: <CAN5EUNQZsrtAUzQ5GgyFg5vJ-aMvAVLAQCYK6aahOSUoPa0dOQ@mail.gmail.com>
Subject: Re: [GSoC PATCH v2] t9200: replace test -f/-d with modern path helpers
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> OK.  Being "modern" does not automatically mean "better", and it
> would be helpful to say why we do this change for those relatively
> unexperienced who will read "git log" later and find this commit.
> Perhaps

Okay, thanks. I'll do that on the v3

Pablo
