Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC992517AF
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339507; cv=none; b=Y6Y5r7iN4VDeTtlbn6CeVAVhs+c4oL4STUAyuPUfp8NyYJIP5LEkmYTlQWgupjT/NTVEp2ZHOKsANQxFIHxUvN/jIw2JiJc7qwrU34o3Q0t8MjUEpbP4pPkc6pKDWYZYCGt7cF/uF16pJ4N42wgaVs1W4+XZyxpdq7cZ2RABhN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339507; c=relaxed/simple;
	bh=UI1HE0mlIpYeB5oidHiJcZzmfV+ocERy3eYMWlJuYqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKUUeufo6T3Y8VpXEP0+gEVSbZk0wXVFIexe5S5AkItPdh7RM7+PWUD1/S8VYgCeSDg3XLsjgXPtUpVvLUoJBITrWVs9pE1KL4hshuxgIbrdjQCoXwLLZIRjIFAnLbs1G0zemzr+P2x31VbQmTs00iHI6dBSImXDMuEdVZ6dfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJz8Jjj9; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJz8Jjj9"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso1419188fac.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782339505; x=1782944305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUBlah3ZqIr1Ufm1JLRhxilRhPIdxTH783hcIV9WntA=;
        b=YJz8Jjj9kwxJ9ob2ByR2sETBYBlQoGcLHLengVTyRdIyIaA9hVkBE1CCXv4YzIgrkM
         ZezxHCOAeoV05S9Pfyj2PW1T5pB8Hko6qnt7gUCxzlFwcccJzc/XktwqeyPeKDcy1zK2
         tcWuBsbzw9TvBcFLiFnKCjo1tCGWbdhwLW7y/ec8wIu+gyifXxXMyfkRs45/k17F0tDD
         DKJZ+Tfty02w8NilJSFRQ1/csUzcffMfpMxHUk4Qk9gFh3YLqopU0nkkwnQr16LXWtcF
         5i/O+cxlEqBOA1qPTDSBgZCMfsAikeHRUnCovLZR8tcz0gI7vLRp0biqlvQlmGS+xfdj
         7QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782339505; x=1782944305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUBlah3ZqIr1Ufm1JLRhxilRhPIdxTH783hcIV9WntA=;
        b=l+EyaNgTYH4Zo7JxbJIdWxYCwjPwKdBV2l58XdiGjnam4IQi7fPweCbyGzMh4+tYKJ
         ZxprfFXUNYV7+jy9El8b/Qol/uN2+O086/AN60h229QHCQm0nA6ru/wS3uFEzWt4zLXv
         ov1kx/vd6+ZPTgIN39MTgn54wuk7mHUlO+hj3fxsYB8KWfY35LpN7UoNnvCRurWn7fdd
         VCBTjCHUJZYoShpBugexoIOF4oW/s3nfj7CwPoc0Z6GUIxeJuEOkrF+v161FWNuxiFMa
         ++0O9MC+G81pmmYqdoBgSYStuhi9Q2RBh+SBY6l5+mebzPcCpcKbK2Vkk9PK3u7Dv/Pw
         Xx8Q==
X-Gm-Message-State: AOJu0Yy0Z9yKjD+dcTNNXCgBhtwom2hE1DK+yZLjKuEqzYOWssZZtG0M
	TYUCyAeMd+IQjcwW505BVKPIOcafnj1Xe068jg+4v1rkj1Dw938r4QJ9
X-Gm-Gg: AfdE7cnoJcEHRNjdPMYDrf1j7+tD7WBaXw5cG21ELDkmvCgnEb+8kxSECxPT/Z0buc3
	J72IGwgqC6MPRo8iB8rvnHoQQwL/b+cDYOm6BzvRwo9QO14L3kOC+pjIoLudMzZW6rK7lSWtGZr
	ED8cWMMOpfSwbniGS4vSl2DFtGUEaPnIYgNgTj123bKLto8Ti2WsSSWrc/IyljKTdtvX4KBvmU2
	R6S/guL8BIbSVGfnn6jc7T5ni60KE3rpAysPnF4uvj8wcTg5JJ2Y1pvWG7oYnZs/cCkV0EgCoey
	QQhhUHrWciYYpcHf+VV3Kb+BceSPt0ahNdie4QlcD/Mxc24fdDFOUsD5LQ51VSu5G57l+rkwKAc
	Y3HYqDTNAdgREZduobve7JBsfscjgKNHq/ZBJTLO79qrjIhC+D/4KwqPJSSo9xXwmkUWuU8rHv+
	jT5ghGiA==
X-Received: by 2002:a05:6870:158f:b0:43c:83b9:5057 with SMTP id 586e51a60fabf-447dcbb1556mr3974239fac.30.1782339505293;
        Wed, 24 Jun 2026 15:18:25 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f042517sm10322780fac.13.2026.06.24.15.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 15:18:24 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:18:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 10/11] refs/reftable: lazy-load configuration to fix
 chicken-and-egg
Message-ID: <ajxU-McoGrfkeKTs@denethor>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
 <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-10-018475013dbc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-10-018475013dbc@pks.im>

On 26/06/22 10:28AM, Patrick Steinhardt wrote:
> Same as with the "files" backend, the "reftable" backend also has a
> chicken-and-egg problem with "onbranch" conditions. Fix this issue the
> same as we did with the "files" backend by lazy-loading configuration.

Makes sense.

> Now that both the "files" and the "reftable" backend handle this
> properly, add a generic test to t1400 that verifies that the user can
> configure "core.logAllRefUpdates" via an "onbranch" condition. This is
> mostly a nonsensical thing to do in the first place, but it serves as a
> good sanity chekc.

s/chekc/check

> Note that we had to move `should_write_log()` around so that it can
> access the new `reftable_be_write_options()` function.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c           | 146 ++++++++++++++++++++++----------------
>  t/t0613-reftable-write-options.sh |  19 +++++
>  t/t1400-update-ref.sh             |  12 ++++
>  3 files changed, 116 insertions(+), 61 deletions(-)
> 
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 608d71cf10..d74131a5ae 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -141,10 +141,21 @@ struct reftable_ref_store {
>  	 */
>  	struct strmap worktree_backends;
>  	struct reftable_stack_options stack_options;
> -	struct reftable_write_options write_options;
> +
> +	/*
> +	 * Options used when writing to or compacting the reftable stacks.
> +	 * These are parsed from the configuration lazily on first use via
> +	 * `reftable_be_write_options()` so that we don't have to access the
> +	 * configuration when initializing the ref store. Do not access these
> +	 * fields directly, but use the accessor instead.
> +	 */
> +	struct reftable_be_write_options {
> +		struct reftable_write_options opts;
> +		enum log_refs_config log_all_ref_updates;

Any reason in particular that `log_all_ref_updates` is the only option
outside of `struct reftlable_write_options` here? Isn't it also only
used during writes?

-Justin
