Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1E3234
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218153; cv=none; b=UU1L94+yQ9wW/4F0ZWLya/lLVDtpmUjKddFP70QXxoc3kGVIzEwjx7eGdW54VkBV4dricqvkx094ZhjR0ojp7VfXYmhfRpjOUuzBNHaNyi90pJjF1z9uahMovyZg+Xfc/OaO01SWDu6S6ngVKXPChVJQzz1Z8uiretmRD3g2pJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218153; c=relaxed/simple;
	bh=LQtuqsCjtQ8lYm6ySiykUEoiDj9M7KiapjgPzeaMp4k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zx9AVLIuL5++a00+LEdSd16zdyZIlOcwDCO5oIkECFzSPZAiVManiGK4XaqHdN97kGrx6oXr7ebesLDh/RAQ+vgr49ZfU7PLQIZspZnuoqXrBDofR5Lq0b3KevnZTM9sMG1pclxcdElXzZYr3X1KGz7bHGCd3KZhdRkpP8qXMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEwXPF7L; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEwXPF7L"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71806621d42so3250773a34.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730218150; x=1730822950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZmFU8RSo3s6mrZt8uJWRKbZiaZ+EQdEbiyr/4JtTWI=;
        b=FEwXPF7LV+acIxZaimO6SfetSDEfAV1Ts6xde7k357RIbpasSsD6LW7mNk5w4Pv8GF
         uachRPpBsRWhLxw+zNrFv6Afb34weIjie11+XgzHi/3xlghe/5W2oPCJ5yYSwRfzxUBq
         hko5M4ONSKMKNg89xzfFJjKChOwxkI70KA/KekSe+qY2GXHu+DNth3nvcQl0QTpWpmac
         FtWb0RR08ETfNc+55R//GQJ+2bQoiOrsJiyf2m4jj22izRnICKNO1H+3dMmX6QvQX2qr
         9+fgmVKarXb18JUYHNqsWXkpaW2Lt6jUL36aLCDGQUIBWL9bm6LSranJPdptVq6ZdRv2
         lphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730218150; x=1730822950;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZmFU8RSo3s6mrZt8uJWRKbZiaZ+EQdEbiyr/4JtTWI=;
        b=SVPdb1H3dbYwi2XR4qy4UAbIM4SgnI6IyIMSp9tuxX/WEhnX7wZ9N8e4eh72ZKdx8D
         +mOfgmWg/1DrnwpOa6dhytGjaXGLs62r5UHKFsalf5DOM/BsOyUTIlD42i7dKm3o7/7o
         ik70h3mz0hNFQipF2OFzlGRwiiw+0u2uAVwEeSpRHQkThwyuH4adTo08x8DparPoh3pX
         LUJuSDJbtT6yVjIYUPKcrWiYD6sM8TEXMII/AqeTY13YA1HAPfJGfCNafbKppHBodEJN
         eTzwGRGEeQlRLG0B5O3Te8ba2CmzcMklibGgqtxIBjYQWXQayb3BmO6jPGXWNyAdjL9h
         CnXQ==
X-Gm-Message-State: AOJu0YxitxMettIMHG8gglCv68uLDiIcr/2hkZOjKqLzR1C9kRQizy8c
	468XAAVT0q9GQ3318FBpRLhlJ9pRbsrChYGirX449DKBJExOoQiXPBWrqVrr8A+XQWUVTGEgwXM
	L42kFvArQgh9qDdLb6c5bDAl998WBqyU2
X-Google-Smtp-Source: AGHT+IHA6q+dT6zXbJKEm/dDBrN5+rT2IjgzhBF7kudsOYcNj7RSiplGvd0IeOC26fpkmrZfH0YcCmxEbsM7RCCyZ50=
X-Received: by 2002:a05:6870:1689:b0:277:f9d5:e85 with SMTP id
 586e51a60fabf-29051c25f90mr10564026fac.22.1730218150051; Tue, 29 Oct 2024
 09:09:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Oct 2024 12:09:09 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zx+/rEB8RklP359p@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com> <e99b1dad549bb1e87011d8722b8582172390aa04.1730122499.git.karthik.188@gmail.com>
 <Zx+/rEB8RklP359p@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Oct 2024 12:09:09 -0400
Message-ID: <CAOLa=ZR5=Zf59Eu7VyZdiO=8LUmoEKMJk4Y1X+iog0VzLh2yqg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] config: make `packed_git_(limit|window_size)`
 non-global variables
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000038d21106259fce0b"

--00000000000038d21106259fce0b
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Oct 28, 2024 at 02:43:46PM +0100, Karthik Nayak wrote:
>> The variables `packed_git_window_size` and `packed_git_limit` are global
>> config variables used in the `packfile.c` file. Since it is only used in
>> this file, let's change it from being a global config variable to a
>> local variable for the subsystem.
>>
>> We do this by introducing a new local `packfile_config` struct in
>> `packfile.c` and also adding the required function to parse the said
>> config. We then use this within `packfile.c` to obtain the variables.
>>
>> With this, we rid `packfile.c` from all global variable usage and this
>> means we can also remove the `USE_THE_REPOSITORY_VARIABLE` guard from
>> the file.
>
> Ahh. Now the motivation of the previous patch is clearer. Have you
> considered hinting at the motivation here in the previous commit message
> (e.g., "this gets us part of the way towards ...")?
>

Indeed, will add.

>> diff --git a/environment.c b/environment.c
>> index 8e5022c282..8389a27270 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -49,8 +49,6 @@ int fsync_object_files = -1;
>>  int use_fsync = -1;
>>  enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
>>  enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
>> -size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
>> -size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
>
> Very satisfying :-).
>
>> +struct packfile_config {
>> +	unsigned long packed_git_window_size;
>> +	unsigned long packed_git_limit;
>> +};
>> +
>> +#define PACKFILE_CONFIG_INIT \
>> +{ \
>> +	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
>> +	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT,  \
>
> s/,  /, /
>
>> +static int packfile_config(const char *var, const char *value,
>> +			   const struct config_context *ctx, void *cb)
>>  {
>> +	struct packfile_config *config = cb;
>> +
>> +	if (!strcmp(var, "core.packedgitwindowsize")) {
>> +		int pgsz_x2 = getpagesize() * 2;
>> +		config->packed_git_window_size = git_config_ulong(var, value, ctx->kvi);
>> +
>> +		/* This value must be multiple of (pagesize * 2) */
>> +		config->packed_git_window_size /= pgsz_x2;
>> +		if (config->packed_git_window_size < 1)
>> +			config->packed_git_window_size = 1;
>> +		config->packed_git_window_size *= pgsz_x2;
>> +		return 0;
>> +	}
>> +
>> +	if (!strcmp(var, "core.packedgitlimit")) {
>> +		config->packed_git_limit = git_config_ulong(var, value, ctx->kvi);
>> +		return 0;
>> +	}
>> +
>> +	return git_default_config(var, value, ctx, cb);
>> +}
>
> I get that this was copy/pasted from elsewhere, but it would be nice to
> replace the "every if statement ends in 'return 0' to keep them mutually
> exclusive" with else if statements instead:
>
> --- 8< ---
> diff --git a/packfile.c b/packfile.c
> index cfbfcdc2b8..c8af29bf0a 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -72,15 +72,11 @@ static int packfile_config(const char *var, const char *value,
>  		if (config->packed_git_window_size < 1)
>  			config->packed_git_window_size = 1;
>  		config->packed_git_window_size *= pgsz_x2;
> -		return 0;
> -	}
> -
> -	if (!strcmp(var, "core.packedgitlimit")) {
> +	} else if (!strcmp(var, "core.packedgitlimit")) {
>  		config->packed_git_limit = git_config_ulong(var, value, ctx->kvi);
> -		return 0;
> +	} else {
> +		return git_default_config(var, value, ctx, cb);
>  	}
> -
> -	return git_default_config(var, value, ctx, cb);
>  }
> --- >8 ---
>

Thanks, will patch this in. I try and avoid such things to mostly make
it easier to review code block movements. But here I think it is indeed
nicer to change for the better.
>> +
>> +
>
> Extra newline here (after the definition of packfile_config())?
>

Oops!

> The rest all looks good.
>
> Thanks,
> Taylor

Thanks for the thorough review. Appreciate it!
Karthik

--00000000000038d21106259fce0b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 571c6ed1cab8f231_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jaENLTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWpaQy85Y1FqRDdaVG5zRzlaaFRmQ01CcFVwNGY3NAoxMzBlYkVYTWll
aE93WnprYXpqMjVRZ0JESkpZWDBKU01nNVNNRldxM1F1cEU3azdtd0FDd3NhS2xRSFdzWGdxCks1
d3QrakU3QUdxUG4xOHluYnYwTjBrbXp4Z3BBb01VS2ltRGpLbE1URTNPV3lJM21zV3cvRy9sM3c5
Tllwc0oKZ1JUbmk2aEJtR2doR0RRYXRhVmF5SEVTMENUR2F5WFdNcS92MVIzbnZrU250cEVWSnJq
bWpYdGd6bXNObWtiaApxWnJlR1ZoR3lqczgwVTdnYW1hWmowYndaYyttZ3JLTHdkY2lNNGtzSzQy
VlhKSy9LTUR0ejNpTFk1enVRNktMCnhBNUI2STgvMXVycWUxR3R2K3oyVnJKNDB6N05ENXo2Q3F2
a2NjZHFvUTFLd1V4ODBSM0ZkcUZkSlpJeUtrdzUKYjVqSVFNSkM2Y1A1QTFEbWFWK0x6bWk1VlBD
djE3Z1IxYUVWSi81MkFraVdId0ZUbFdoMG4xUzBOMU5FangzYwp4TGRvUkJmSXpHV2Q1NlJ0SkdP
L1RCZzJLMlhuL1U5elNZS0Rsd2NHdlc4R25MbWZnZnRkaFhSNElkemlCUTRYCldpbUdKNnlJWGhL
MzhNa1NhMU1XQ3cxTjZ6N0tjRVZONFhHR0JWZz0KPSs5ZXEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000038d21106259fce0b--
