Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B7D2505D8
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744746481; cv=none; b=C/eEMWVMr4FM/ZepkjAtP0bR2ePI3Dfbe9dDJQm3HeOq8fLxxW6TcjvGCAkYGUjhubQakA9sMJBNJA895AFAK2HtsxDiWPEp/lNSathmMekzXwzG9Jt2u0dunw66ADSb2+EbK768tUR+aPqzG9ukz6WvVRuLFWSI6wZK+hrH5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744746481; c=relaxed/simple;
	bh=7bZgYX52vw8Ev7OZj3C7og19BsySjLKDqKjTAq+iLfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnFC2fQVmgyBZ5nD0K37p1flQ2Y2ujl1sTvdLrBX5TnEKFswbnEcNaf5pYLF2v5II5Nl0Os+hJ7JRBeSA23WXSExM3bzDPNPt8vyCCNkwHso8lslHmN2qnu0Gk206Lgm6nlw2hif0GRB/8bi5gKhvWtuVECei79FWZQNyq/b9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=B+gAW1gh; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="B+gAW1gh"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f94c2698so30176496d6.0
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744746479; x=1745351279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlo7CnZ+ier4EBTfNagiPltTkXDWCbdct2NiH28Hh4U=;
        b=B+gAW1ghSQfE0JvM/9p0cFkfzyLHEbSAoZF/qce3fbMTCKuwiCPmJJtQCoYQSH5R/b
         6xojxvVJQf55VXMikij0Ll49pbvh8hqscUwFpKuMzsEhJfhWCXhe2t9is9geSg/gmfP3
         gZati/qsfFQyoofyYITAJUfiAo6FfgNGb84s0IY6lnQQfAnVMWPKLS/VsrcNCGLwBRoo
         8lkyH32ypdPgTGgd/EIQAHMqhN3Dwb3O+4DTZ7nekXjxHVne3K8ehlDoNhFb+3490yb8
         pRyYtbQWeRYfunlFUKH3viGZ+xr7+kzCT6bSZKKEX/sA4qNQnfJb7JIITRV4Vnu7pr0u
         uZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744746479; x=1745351279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vlo7CnZ+ier4EBTfNagiPltTkXDWCbdct2NiH28Hh4U=;
        b=RmQoA6numkiqNE5UbOccaPyjLkrj/v61lf/yzy6Aq1CCcnlu4Brv2ZHU5Xr3dJ/QtU
         eFbdHciDj5GyJATrVMXre+Oedb7EsHftIdDFImumN59E6rb3yF14SuaFeUN0K7Np8G+6
         4Ck3ZEEd+w+4MYGaaCGrKY1UbxroROMEGtXvkWy3i1ueK2KCdCXHGpiCuop4KERBeHBq
         oFszYDP6N8J3se+8AtCtm3MdSBjk36vWZqq2yk4WePEpxowSdb7ssdzdMMGhLADfZjku
         VY+Jp7LgXzGPv/9HyyDcNO6Rwp4aviF1XFQkm6M13NJS/KXGRUa+xZYAqV3qkYQQhyTE
         Q8wA==
X-Gm-Message-State: AOJu0YzaqoUwzZUXHCwg0auxtHqZSUKze96PJ59z/zQhXEMlT+Xc+mYa
	NRc5El0vG1x30+29UWgxhZejlF5x8Y4Twuype8aFg2tL1uqv3rMmx/3M+Hz9W6I=
X-Gm-Gg: ASbGncvqJf5aQRQ3gxekOjQeCq/NtloEKQoczkzsZAI2BCu9XMLNiILaxRTKOiTeeZH
	73BtFsXD3PNyOlZ+2LI1DEKeq1tvYy7NdtN/ZkLknmcXdGxeDZZeBbF/2J3LRBpW9Z+dPNRueiG
	F8lNO7T+ZtxG/fpSE61QQX9VqsJU4apaIaGh/RblMwUlHCrI73HjbkHVTP310Jl0SV35Gs+WVFv
	awlhn8J2pKnTPo7b4+AQUHiceMF6GhWwsGa28ZND5Wyvl4zgZEHEAinDakW621EPJu0H1PppH7F
	SCOE1wBtuw2CksAxYlLzN7x62SfSLL6ui1MjoiV7dQut6PgpOwkhRJW1uftAI9j6RI7Xau3WqsM
	hqAbW29FBJYck
X-Google-Smtp-Source: AGHT+IGBy8PepgapIyS0rqvJno/e4nasvJ2+LMt4UqjakHMwQbUDp06YdfeqSwy9dRCMcXx04+YP2w==
X-Received: by 2002:a05:6214:e4f:b0:6e8:98c0:e546 with SMTP id 6a1803df08f44-6f2ad9d2e08mr10384496d6.29.1744746478839;
        Tue, 15 Apr 2025 12:47:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea2179esm105540396d6.124.2025.04.15.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:47:58 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:47:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/8] object-store-ll.h: add note about designated
 initializers
Message-ID: <Z/637cMz7AGVXokX@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
 <920c91eb1e5a1b6d5faa54240dd9c85f72968edc.1744661167.git.me@ttaylorr.com>
 <CABPp-BGH=GRAo2Vy8sia75p=2Uoza0kwTzoy9FKKxE5jDFfGXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGH=GRAo2Vy8sia75p=2Uoza0kwTzoy9FKKxE5jDFfGXg@mail.gmail.com>

On Mon, Apr 14, 2025 at 07:57:59PM -0700, Elijah Newren wrote:
> There are 46 #define'd designated initializers in the code base, from
> DIR_INIT to OIDMAP_INIT and everything in-between.  The logic used in
> your comment to suggest not using an all-zeroes initializer doesn't
> seem to depend in any way on something specific to object_info, yet
> none of those other 46 cases in my quick scanning have such a warning.
> And 29 of the 46 define some kind of initial value for some fields
> instead of using all zeroes.  That would suggest that one of the
> following is true: (a) those 29 cases are buggy and shouldn't be doing
> that, (b) those 29 are all special cases someone has thought through
> carefully but perhaps someone should add the same warning you have
> here to those 29 other cases to avoid uncarefully thought cases from
> being added, (c) there is something specific about object_info that
> you didn't call out here, or (d) this warning you add is unnecessary.

For (a), I wouldn't say that the _INIT macros are the potentially-buggy
component, but rather the use of a designated initializer in the
presence of an _INIT macro that initializes the struct to something
other than all zeros.

I don't think there is anything specific to the object_info structure
here, which suggests (d), but I don't think that the warning is
unnecessary, it's just overly-specific. I think we should have a
convention in CodingGuidelines that forbids designated initializers in
structures with non-zero _INIT macros that don't otherwise have a
comment about their correctness.

But I think there is some discussion to be had there, and I want to
disentangle that from this series. I'm going to drop this and the
following patch from this series and split them out so we can discuss
them more thoroughly while letting this series move ahead.

Thanks,
Taylor
