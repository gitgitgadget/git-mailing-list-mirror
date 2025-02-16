Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F7290F
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739683972; cv=none; b=JZYUrgD4Gp/XFlA497/IYjzVNFYy9UMHz06T2MOwuQabcWim5HVf7Spf5AxqQ6ZhIyWvGnXRBLDMWx1HYGQCNGMkHuFPLrPm5ai21cimHDtoRV9u/6s5YMW5tpXOFkLb3tLS+QuLc6MIpicEsuSGDhcqVFjM4MLKoAK7QdmEVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739683972; c=relaxed/simple;
	bh=v+6/7QdDQ/vOckAk+a9FAzFK+bQJvTp+a1SmfHXW+uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRkGOMf2ALlL8+sqEhFQdxj84yvGMZ71FJ9+v0q2T84ymZ9tTRRHWEtMfe4JtcJDSiEVaXvuSXxK4tOaU+egrNt2U+ETdR/brKniiR4GnXYvkjDUzRIVHnbhJmgCx7V3LWNA0XoNYukLPxdlI7XqkbudUNp8xeyUJ1EOvNTSHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKrzBx1V; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKrzBx1V"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso3464005a91.0
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 21:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739683970; x=1740288770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RDUGHdM22/Ozg7FwsBqFJz5D05Z5sZumS/JvFZGKhU8=;
        b=eKrzBx1VjQ1k0KuQgrck5LW8Xg+qsw4VcdgFWXn/xEm2ZtbC8g0+vp0OrIq3I54eqc
         K5sdKAUBi0KgSGSFWBcJmr4nCPOiLA51J7GCPprHCIr1yWf96gjM2J6PXhKgpbTetnMR
         3mSHuYjwwJ9eFZkE0a4jCp7cU2aeNMj6o8YUJEn0wewTQScSA4ivgnKfqDoI72huvzBp
         CGWGENr735vzVe93XZtdH7es+eVvr12lEBD/mRYMpRGd8UGeXuTSV3cvxjt/I839AvrQ
         tgXEhbn3ZXNUsqR+1YB3TuNVdEQDUUmT2iZ3NDo+84UozbwpYIlDog1lgJDeO/t1VISj
         X5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739683970; x=1740288770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDUGHdM22/Ozg7FwsBqFJz5D05Z5sZumS/JvFZGKhU8=;
        b=XyC0w6WLERJkNJGHqcTrwXob2PpUWxl82WlkLWaii726+Xh17KXnUV19XPn6mIEZHs
         zo10M0nXrvhXLVPEaewDcIJ3TBU871mb4Bf9zEW7jlFRz/hO7Yo/6+85sk0aaj7GI1It
         yfQs6H8UNw/6tawv8TUQYvzb+HGZzV/77NvCqm3H6Q99Wl5viuZvb6bX6DfRQ6BVqGAm
         LrRQah7leWnXiuTRLoAc8NSmj23yd8KOQtsJS0YQyfxhN9BjDqPDnjZtdeP6D+obxMMb
         9cYrCzKEhq0ZWsz1pwgOV0dAIKPikgJCrC1cyHvDst1VfHY4vqxGpfHO5q3rQTlM83W1
         8r8A==
X-Gm-Message-State: AOJu0Yzu1mzKZyQJF/X19au239x+Xb/X+iZa+u8f0ErqjV5yQJBLyzIt
	ElNlborS36bQ8odeBrMlrDhNGOpPwm7niDVopg9hRr8wOx7wVpvdEO3yhg==
X-Gm-Gg: ASbGncscp3R1b4Z/Ub5Q1CsSEQeVBQkF5GpFXlUsRKTW+njk91EYrSPR9jJODwvbqyB
	EKUubYUFnIMvfjGeN5XUGRwl3YBJMJvBCSBgETRdPfm3NQ9NAXBEIRYuk6nfp95SqDzYPN028e9
	ZhKq+XXnoXDls/UwPdRIHLi73UjnZWL8thvaRMMt80vghOEvGRtg5xyHonXfgZV4q5lfOse6IUx
	lRFiQJwmphkKD+9x3P5ml9ST8HPbJJv3mVyIKvPDKzTyA6b8wth/pGXUKaVwxkt9QdiKsnR4kLC
	GfJT/ww148Q=
X-Google-Smtp-Source: AGHT+IF7i6GzFmdFn5kNhCdo5ijY0ETF+ROLLY3mQo/B3kNI1I5AIjd3k68zyauLoPagNpn+HgT9+g==
X-Received: by 2002:a17:90b:3e8e:b0:2fa:2252:f438 with SMTP id 98e67ed59e1d1-2fc411503b5mr7266425a91.30.1739683970328;
        Sat, 15 Feb 2025 21:32:50 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc13ba6969sm5737415a91.47.2025.02.15.21.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 21:32:49 -0800 (PST)
Date: Sun, 16 Feb 2025 13:32:46 +0800
From: shejialuo <shejialuo@gmail.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org,
	christian.couder@gmail.com, johncai86@gmail.com, ps@pks.im
Subject: Re: [PATCH 2/7] builtin/verify-commit.c: stop using `the_repository`
Message-ID: <Z7F4ftdJHlMB0RL-@ArchLinux>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250214230210.1460111-3-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214230210.1460111-3-usmanakinyemi202@gmail.com>

On Sat, Feb 15, 2025 at 04:27:18AM +0530, Usman Akinyemi wrote:
> Remove the_repository global variable in favor of the repository
> argument that gets passed in "builtin/verify-tag.c".
> 

I think this is a typo. "builtin/verify-tag.c" should be
"builtin/verify-commit.c".
