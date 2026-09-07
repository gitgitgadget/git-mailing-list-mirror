Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685651E421
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799063; cv=pass; b=CiWy/hi30I0BDTDOFnPFL20WeTNL6oTsS0XeReUhs7YtREZj3zIq7JVfpKZbEeGlV48Kfrc9AsFYDyo+u0jIkTUHh7NSipbVX4yoB3po5k6RhP8OWGqckA4AG+J3CoWbEjdwdOyGmeeUoqvzC+kZi++7oLZorpjXuIjjimz7uWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799063; c=relaxed/simple;
	bh=F5OGX+/T5ZeOXzjPaS65jqF5vqDmvk72qirbxgkYZMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hhvup/C8XtgZUp2J13vwzNEgPbA76KJod0OTUcX5mDbx3famm/7prnSGarqeXm+tDc8nYAC36Dknu8D9F9769ldL1ehkHlYMvfDILJqeyJmWX6JwvI6Hx+kxvpjh8wjp5iXG7uk5AISEVuSEMAdASyyy++jPpbT8TLJRrqtOrDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=QmwJkuy/; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="QmwJkuy/"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8623b1e7cb2so16071597b3.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 09:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788799058; cv=none;
        d=google.com; s=arc-20260327;
        b=PhPcBH1GU3dho/wVty8exhiRWdKz5LgacfAjiThmizK01RZ8XYtPEI0EGONuzO/Az2
         pr2HA10vwBfq8gScbYru2senU9GLlo/Rmajyni2MlU0HSuCYV7D0y4paQpQJVZC4N2jM
         +HEka9rZ78dsyrJJdxyB5HJ5UWdROi2+hlOucaChVmgdihaKyvgitBpP7l9R1X395nzn
         fDGIu+83C9RfzygCD6dOZkc7C5AbWx6rCXVqr+rFq5yeibf27Euq5CXC6/KvHHTU5PkB
         w1TMRbUZskc5fTxIlICEImuKpIxfFtsqZxomAHJAhAKiEtTvCnEUaAkXxg14pkmIa3eO
         SG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F5OGX+/T5ZeOXzjPaS65jqF5vqDmvk72qirbxgkYZMU=;
        fh=DODnQCqkWDdUbsQb+QVlPbHuCSEyESHAv6/EsgoeJ7A=;
        b=nMuT49C8NMOd+/q12674LQ2DAG1f5CHSg4JHfYAsUZ+JllTqLfHnruJ32skM77M//W
         MgT67q/9blwNi85f9yOofQ66QXk7n7P87fu/6BEtyyNZEk6t977+p8orHwW3kRbAnV0i
         PWjY3ZTlwx083dJR5Sc+O0dswbvPQ+Q6Kq6jz8sfvY6yLhI6M0+TgkvI5pOcPMyCDn+B
         hzdPvo5hvw88N57aYMexKS1ynleC2CvGyIZUT7z68FGj0hOrRXh8dUcOLuXiEeOBYzCQ
         R4VuEa4nh8Sutph+YKwy707ArVlm92HXUE4I/PgCq5YSqA/7iV+4Clq+izdSRm2iiGod
         tmUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788799058; x=1789403858; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F5OGX+/T5ZeOXzjPaS65jqF5vqDmvk72qirbxgkYZMU=;
        b=QmwJkuy/1hKZy1/zO70/35Bi2dhkpDIz8GcfPLZ5bjglMMTQpY/5Q5nrmgVWQCUvOi
         GSYz6gVfNgdgDFIbbYWLTAz9aNiqABOqkk2fqVMUww+X8Gs6T+wjcR6+oe7xBu1OxR2P
         a7ZMxJL4AphPMEcN/XYGz1Dy3Q0D5oiKq9gfaDNB5hS9hoWpBmcnR4oh26VV3OR7fPLH
         qA5G2o38r0k9uv9quZN35o+47wkKCh47T0J0twVNgD1susZfdFX6OhTBNLBMuucTRE86
         zIIJSj40Mik69EYqzbOtQ2ymHQJPy6mgp9qP26yLzWIHk6AyzQgH2rfsKypby1QQXl5z
         RE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799058; x=1789403858;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F5OGX+/T5ZeOXzjPaS65jqF5vqDmvk72qirbxgkYZMU=;
        b=Zf/RYIGcSpYWI1udYCAx4c9Owk9qo+6rq8rS6+jnsFff3F4S1+uoezVWjP/PIEgeJg
         D1nLX2KJ/L7d5v6y6WQPLiux5RuSktP9KMoSbnHgPT5shscGVsnmjbEXZrTmgsQSFkY7
         8saF71RlmBoWbdQ/4foOg0trnXnhd7+pHtZwxnwCQo9Q7vtiCY5jV58y/KXiFNbXoyz+
         MymGY1YuOz+EzlXoA3yLa5OLrOg55Z6QsJ/eC+CLpZO8XEwlAEstJO8OOegF2fLUkY9+
         Pq0FQ2DGtFTN6mxL4ZB2fDLfBsq59bqu2Ealw5uAWD4PDCtR6Dw2D5j0zF87KWgk3t8G
         T1UA==
X-Gm-Message-State: AFuF++mj5gTpYosOyudjodSiNimyBjOGwEzhBVNuxnFQmGKI/OYhh5/W
	NeSsuYOC2AvR7SVzanHvIoyfREFX6tF74sKaKnMob3Zkmk08/dWHf53v2ZmGs0BoSZJKmAAMXfc
	F2TjZFHSNuDXpNwsCWvExBl817pNj9o0sF25gj4gxRg==
X-Gm-Gg: AYBFou2SsokD5S4Bo3VLfuL43A1nvHvqKwVkW9sPpoFHHGMr5Y38b2C/FRZ06zgteDh
	1xsqHjxr3Jb6zJKoztx2c0qyBWLPIkkeD8hONhTaL9Wk1z9M7vS3RjFgKA6jITFidHsPjDM5o3A
	GtsIhDkpwEZjyV+n04Q8wMHKlrzAL3p+BfN5WPmQNR6MxeOOElPcJApiXvCQAwwHac9TZ+PgmMs
	9pIrrk+BkGSpq47EJzBAil7voParWjKmAUbBdwty2FsgRsxF4x9r0bf7yhSUb9n81hRQyqbcat+
	r6w48eX+j2q/Ev1PUjs3MoMhJVzqWuwduNGRqv1B+FAQpHwuocXDWOOKL4U0XI7ukgkYRKhMIH1
	Umvs=
X-Received: by 2002:a05:690c:4029:b0:873:5c0f:296 with SMTP id
 00721157ae682-8735c0f0485mr45748377b3.64.1788799057669; Mon, 07 Sep 2026
 09:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com> <ef8087e80db18c511e31dd9c7dd6ea3d57dd543c.1788537086.git.gitgitgadget@gmail.com>
 <ap5yT0sOtLQQa4AY@pks.im>
In-Reply-To: <ap5yT0sOtLQQa4AY@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Mon, 7 Sep 2026 18:37:26 +0200
X-Gm-Features: AcwNN1UD6cCPBMoq0d1ObmLsdHaKlvhs8i47H8pvOUEx9qaIr2ne82NPCUqfNgs
Message-ID: <CAA0xjtr9wKMuxTPwy+P_WpvJt1wocc4VzJ=O-C2Y_B3XuO_auw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] config: add git_config_append_parameter()
To: ps@pks.im
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On 07/09/2026 10:14, Patrick Steinhardt wrote:
> Readers who don't have any context around GIT_CONFIG_PARAMETERS and what
> it does will have a bit of a hard time making much sense of this, I
> think. It usually helps to give a sentence or two explaining what the
> infra even does, and what this quoting looks like.

Will do. It is how "git -c key=value" reaches the child processes: a
space separated list of 'key'='value' pairs, each side single quoted,
that git_config_from_parameters() reads back. I'll say that in the
message.

> Pointing to that other function makes sense, but neither of the
> functions documents the actual format that's used.

I'll put the format in the header comment as well.

Thanks,
Thomas
