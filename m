Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C130AD1A
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420013; cv=none; b=Qj7hN0vOCOk+yS9FdjrM/kzoO/FYmthP+PC7TJijF+HVaDw21mpj9PoT/5Olb/Tb1xs9Gi2qtvo2mUcEEtNVXBEjB7sW4rY4fZgUXKg8zkKkqATgSF1m+a4yS8WE2TlvE0Dwx4T5EynsCzwz+i8wg56EWa68Irxu1qr1KLMpOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420013; c=relaxed/simple;
	bh=3g7FgUlWnlSF3+AppiyIWMedIvDwnc3pWAtepplrTEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iga4r+1k11YikUYR8zsk2yAMW0xxKQSF93+xkFZp0hMOps7oO63Eyfs7BxnkTpdaxFsq3Hq9UBP9e7L3WiH0Lhrfpz7nx5BwIp48Bhu1BO7RSZNqMesZGWwQ3qL4O8xM2UZpfXWspA26KF5m5BO8P12wKhNVJTPrYUijcjrGouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xt4FaGru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VyERic8N; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xt4FaGru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VyERic8N"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 014761400090;
	Thu, 25 Jun 2026 16:40:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 25 Jun 2026 16:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782420010; x=1782506410; bh=qeolhj16XE
	Onlag7r+7Lx5y9b8yq9DIFbeeZWVyz3CA=; b=Xt4FaGruAsSspu8CHT65vP8KMn
	0yChJvwT9yjjhDeJZO20zKfIsfaN1V5VXgFazdCVvoUU2oGodM0SIxnIO8ABYEmk
	HiMwDhAz9RPovnH7Q+l00UshbrgV074dudEcR551FrT7pO0gaiv4mhO/YHQPCzvf
	myUoRrQDAfgVHdiwQVT+2pdEM8Gydil3z/qlTYsjITXGHjzYwxxEUJZpybIMvEAk
	Og3oYYA4sLc5sutNl6XLFnt/+3fParUJs/FyAh7TO81vp9HlY3JrSLdqUIiagWQu
	Y3ov/4A9KtXcyFXVaoeM3J5GlBEyj4N77jW+HhV9qCaMNzrCBj4k8tBIv+VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782420010; x=1782506410; bh=qeolhj16XEOnlag7r+7Lx5y9b8yq9DIFbee
	ZWVyz3CA=; b=VyERic8NIlkwYyktCA3WNfeZLfc+h9Rvg6hrtVHra/e4G7FjSOj
	jxBPX0o+AjMm2RqPg47aoU4QkeLtBGQ7BpwS6uFDeed4fq3I5bIc4nSAtXRpgdV1
	tsnGoRQotSslKW/m50S9C1YFZnwBVNCauR+iilFCnWwh0Vw0ON3K8Fd2U7rTnyen
	2e3f6afkNZVTYwUPpUH6c43l/nEXkMteZtKLQZY9qxHbPCDAfNzaWoLUq1mYN9wR
	xKQ0zRPw+ZayL+p7FFHUZY/ofhOx5cfPbu0jNTFz8R3Tnl2Xd0d3YF3AqPcHNC/m
	PE9UFjXbJIL0HqLaejDkQamdZGuudUkWtSw==
X-ME-Sender: <xms:KpI9aiomx7CkdZvCjvm6JjrdvS8lQpsUdd-USlvrWFHcIOSl8tCiiQ>
    <xme:KpI9ai4Am8pvaU98rvKCm4wamQmiUOI0XTBntjCK8eAF9c746xd2_aFFTH9z0tE9l
    sVmAZKjSIQKo9_mxwYuBs7istnJpO771eqlagMXbjMZTxL0sL1f5Q>
X-ME-Received: <xmr:KpI9apdD1H979-0cCjMotU9cBPuxulTXD3eqXqYqN_poFD2YCog9uuYegkh0Tjdf4WgQMsN1ePs_ryfrb2Vq1q83QLULPlg1gszPLbE>
X-ME-Proxy-Cause: dmFkZTFxK3szjqyUDlQzaan54LOctyARjlDPXLMkzY4rx4vX0aS2MyDj0cKvDZwaQn+Tsm
    IEru7Wkw/wkzf5cFwIyKa0GSfBM9vgazv9MQ4nzDQCLH2LB5yqfI6ZsZ7KiTmHxo8u9PuX
    9rybHawba02dNX42bGcsNyVNiCyZUGU4Uu0Mfu7cAMMiOgKGu7iuP5eqKxRuaT2d7J3wrL
    T7ceUZYIyjQSt1tOHLRsjKpOAjSTAgQDMcnCdKXXOTCAvPQqaEilWm1Hqs2GuBtjSa9obU
    dQQ8+uM7UxbMEH1H/auC/Tpt4eQxfDsW1FeyjXJyFHmV7qJbPDU764vjXvppfN3LCS//Bh
    p2x+u/rK/PtvMR2gt2uV3BiD4elyWMalbQBHsiJNZ5hdVa5AucUHjDP4U25QItqQCi3+7v
    31CgpR+AWl+azv39zbHlF+qm6NuZDUEQy614xrrwxFckqkxWSQbDP5SKpGJQQHS2BbsKh/
    ZJhzyf+k6Gc7mdAzw36GV1Z80pyUM61TYaNDV7ozBHi3GcsrRFhoPrKT3sHVs/JvYCk/jE
    FPGGLf6HYVucVtYl0oVFVneWfT0Co/sJGv/q3IIjTgNJPuJ282EB9tvMtF/FuS+NQLKReG
    FczX1iB2LTioorNgxHZYxZRXIKhuwplYONgdIkTdOBEYe7PoLrvqI/9POhOw
X-ME-Proxy: <xmx:KpI9an7f_fHwfkHl8XSj0Owd7zmjJq4wsPIrGIAfzrbg-nxIdeX7DA>
    <xmx:KpI9agsxwLM_CYG2dqWuKkS1vVfhmKCtSf0dO25SbG7fH0qovY-Yug>
    <xmx:KpI9angjVkcZZmdA_QyCvmPGxtUbwBc2fl5-xXMiM2263WtX7HC8zA>
    <xmx:KpI9arpFBfo2XJl00gVV4bpI95-J_lNn_kKhyqM6Kit0N4GDyQrYeA>
    <xmx:KpI9ankCFMGGtSyS42g8dMdYKBW8M7sDROXC2FTn8eXmRb2P_Y9b3NYb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 16:40:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  cirnovskyv@gmail.com,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v1 2/2] environment: move excludes_file into
 repo_config_values
In-Reply-To: <20260625161845.7543-3-cat@malon.dev> (Tian Yuchen's message of
	"Fri, 26 Jun 2026 00:18:45 +0800")
References: <20260625161845.7543-1-cat@malon.dev>
	<20260625161845.7543-3-cat@malon.dev>
Date: Thu, 25 Jun 2026 13:40:08 -0700
Message-ID: <xmqqwlvme4lz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Continue the libification effor by moving the 'excludes_file' global

"effort"?

> variable into 'struct repo_config_values'.
>
> Since 'excludes_file' is a dynamically allocated string (char *), it
> requires proper memory management. Introduce repo_config_values_clear()
> to safely free the heap memory when repository instance is destroyed.
>
> Note: 'if (repo != the_repository)' fallback logic is temporarily added
> in both the getter and the clear function. This prevents calling
> repo_config_values() on uninitialized submodules, which triggers BUG().
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  environment.c | 28 ++++++++++++++++++++++------
>  environment.h | 15 +++++++++++----
>  repository.c  |  1 +
>  3 files changed, 34 insertions(+), 10 deletions(-)
> ...
> @@ -733,3 +736,16 @@ void repo_config_values_init(struct repo_config_values *cfg)
>  	cfg->sparse_expect_files_outside_of_patterns = 0;
>  	cfg->warn_on_object_refname_ambiguity = 1;

Shouldn't cfg->excludes_file be explicitly initialized to NULL here
for completeness?  There are other explicit but redundant 0 assignment
to the members of this struct in the same function.

>  }
> +
> +void repo_config_values_clear(struct repository *repo)
> +{
> +	struct repo_config_values *cfg;
> +
> +	if (repo != the_repository)
> +		return;
> +
> +	cfg = repo_config_values(repo);
> +	if (!cfg)
> +		return;
> +	FREE_AND_NULL(cfg->excludes_file);
> +}
> diff --git a/environment.h b/environment.h
> index 52d531e4ea..2839913551 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -98,6 +98,7 @@ struct repo_config_values {
>  	int precomposed_unicode;
>  	int core_sparse_checkout_cone;
>  	int warn_on_object_refname_ambiguity;
> +	char *excludes_file;
>  
>  	/* section "sparse" config values */
>  	int sparse_expect_files_outside_of_patterns;
> @@ -133,13 +134,20 @@ int git_default_config(const char *, const char *,
>  int git_default_core_config(const char *var, const char *value,
>  			    const struct config_context *ctx, void *cb);
>  
> -/*
> - * TODO: This still relies on the global state.
> - */
>  const char *repo_excludes_file(struct repository *repo);

Good.

> +/*
> + * Frees memory allocated for dynamically loaded configuration values
> + * inside `repo_config_values`.
> + *
> + * Note: `excludes_file` is currently the only heap-allocated field in
> + * this struct. As other dynamically allocated variables are migrated,
> + * their FREE_AND_NULL() calls should be appended here.

Isn't attributes_file also heap-allocated member in this struct as well?
