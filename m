Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7036134
	for <git@vger.kernel.org>; Tue, 21 May 2024 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716333767; cv=none; b=me7jkunKQujGvPuN7OwHxbQ/8uYOHmkRVF1qJUgGikuUqbZZLTFYog1knzRxaDYFhfqoDiNLtz4ptqsdC7xXMGRuvbv+MU1UMpg+sM7do7Tq8apeM02NFxI5GYkcbICBoqhVvYdGO+SWsDHU/Satfc7yxy7i9GXB5gRfQ0jPB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716333767; c=relaxed/simple;
	bh=6oLQxJbUqo8V2CcVThCAPSgGDvhs5i2xB/mv9DMirUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVd9wqhSP3Jqens0ztmhJ4TqGV0tpFYqs2VHIKtiySXCdyy/u4zlpLiT+FVjH7v5c64u2zy5UzYUQB/xboW3sNuxpjxZ4G+haomIMxgjQBBGa1SAp4ctH8x2hj5vpc9dIeajGHY3tHzMeHMpIIG+YU7SwyhJSvjm5eFE0MS1RK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esrruglh; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esrruglh"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b296194ac1so3486281eaf.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716333765; x=1716938565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+nTArtae8dCQ/O79n7IIReXnZpWL+76FsE6V9QPUVO0=;
        b=esrruglhafMU+FL93kqk/gs7sprpsIqauMIY6TD3am+/nLEwUNXw+8zeucBKapUH0+
         7lHoGUmgQTVnswtqYEOUop0F7FgNAi3JZMLnb/RIGID5yOQmU7jjig/93nCQdzUns8vA
         vr+EqIndcBihM7BSbp7l0iB+vOAaL7Xk34Mo9gqLjZYy5GwFlT7KCJJig94lirGarGA1
         o9vOdhCtH2XcFBknKK3MpZ82RlLRr2XvSEYk1/L+FyCXMCicUJsczrKdXx5LP+dKlsA2
         v3sk7Szi3m75nYltr44motXQP/21gx9pz5Mvi83OsHodBE9ECloNjwhme3n9tJqHpnFJ
         gi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716333765; x=1716938565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nTArtae8dCQ/O79n7IIReXnZpWL+76FsE6V9QPUVO0=;
        b=VUXsg8ATdZ/o/nyZyrcIB02HAtU2ETyKYeYCgE+aLOXTz+hWaunphv2yeEclZiNcuQ
         KVacJX51tbFwGhS+vzNhs81nOMPes7zpNj3z4dlnxYfz7rMOMnPRr2ftykhD8qMRXrhI
         xXFURPSv8bPtdNJw7oA/t+lQdUlj0lkHH1+Vv+S5XDASE9N65OR2yP6ZFZ69+7hxhSJu
         YpDP1cp3vmOcIzC1PdQt2jNF8KnllybW2Q6zOAqYua3ziqbl08DbMsEi67FrdUMKULLX
         /svLFxHJjdzHTGD49xZM5cSMvMdOB1WQKcQCzJuP6kNUuO/b1uajA/xuKvrOB+0A877G
         AbSA==
X-Gm-Message-State: AOJu0Yx2UctU55rm7YHkTDpZ/df7BcfHC2KtlIHUc2Xq5t3cnSdPUx+5
	LTqC8iH0oF/294gmWYnWHm5DgbrMx42nskLdyBFbg5A4VAO5hSOk
X-Google-Smtp-Source: AGHT+IEYHToBBi3jzJsgZCl4XpIA1Ny+5T+kClB4U3neWMM6ejv3VryBxSbg5XF4J4Hw6Y2DbAGsFQ==
X-Received: by 2002:a05:6820:1505:b0:5b2:1095:a58b with SMTP id 006d021491bc7-5b6a5796d45mr435496eaf.8.1716333764955;
        Tue, 21 May 2024 16:22:44 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b26dd4d075sm5680852eaf.3.2024.05.21.16.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 16:22:44 -0700 (PDT)
Date: Tue, 21 May 2024 18:22:43 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/11] reftable: pass opts as constant pointer
Message-ID: <emcnb7fqqihc6mdjusk7wp7fr5zoxllpectcbtbhazbay273j3@us352qejrtnr>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
 <f1c9914a77ab9bfe27a62e324cc3eb388f4118d9.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1c9914a77ab9bfe27a62e324cc3eb388f4118d9.1715587849.git.ps@pks.im>

On 24/05/13 10:17AM, Patrick Steinhardt wrote:
> We sometimes pass the refatble write options as value and sometimes as a

s/refatble/reftable

> pointer. This is quite confusing and makes the reader wonder whether the
> options get modified sometimes.
> 
> In fact, `reftable_new_writer()` does cause the caller-provided options
> to get updated when some values aren't set up. This is quite unexpected,
> but didn't cause any harm until now.
> 
> Adapt the code so that we do not modify the caller-provided values
> anymore. While at it, refactor the code to code to consistently pass the
> options as a constant pointer to clarify that the caller-provided opts
> will not ever get modified.

Doesn't really matter, but would it be more accurate to say "pointer to
a constant type"?

Overall, I like this change. Improves consistency and readability :)

-Justin
