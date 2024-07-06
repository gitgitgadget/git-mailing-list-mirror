Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3117FE
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279711; cv=none; b=pLVbAwqPePes54UmIGUTMMen/8lKEfXTvylyazUYn/CxDRVrGJ+Rw6nEoc+W/yV2Mbi71yN5MJRKvgdIt6P3GM25L+9ZrFNa4ML+E0HxhKiH++TU446JeI3MrS5g1zamDkVoOC7RocmfZzIW06UMzwIZFdXwX48+ausczSEpj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279711; c=relaxed/simple;
	bh=DFPDBclcLd8Fk77a40yAMUmfrpI08+Z2rASFw+0cXeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDR7qYKvZgqXeEjtHnQYkNl9jIbA+aPLJ9s9Fi8h3l1zotGwuoFDqe2cdx5HDIiQ0XeGZtIdh+JXRzkLFD6waOZUwTvATXhF4TD6HeQ/m5Xj6LSI2MxmV83rGN2CDTjQ499mogg515ElFANs57JvKGor79NyJobk/wSducb7OVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cR6NyqVX; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cR6NyqVX"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b5daf5ea91so13746656d6.1
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1720279709; x=1720884509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DFPDBclcLd8Fk77a40yAMUmfrpI08+Z2rASFw+0cXeI=;
        b=cR6NyqVX/SyCR34/Fcm+BFhlhYbuUoeOzf8UzO10MWsb4gJWmQnAw7b0m26F9voVQD
         mVYMgC35ig4916qK4NH9QYMiHA2DmVkpyxtqRuuOHFLSBOnadSYFSSw76/+WFk1C90g0
         5f7XBRJ05iwUE3tlyHeeNTCtrhn2xgYqrgvbP00G3zor8/wC0Rg8KD3BE6UCI157mvmt
         9o8s/H2jrcaIkWwt5fQTIuWDv+LQb5E8qzXZy0x8OK66XQkE6TVOADY72OTQM5QFiNoQ
         Sr6uDTv5SWLyPawLIf0gcAgntOk9AuorKEmQsu4VLNI75YdlPp+rXnllbcYJ1pdtXqLU
         03Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720279709; x=1720884509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFPDBclcLd8Fk77a40yAMUmfrpI08+Z2rASFw+0cXeI=;
        b=tZE0NLrKk5ljDaVfQ91gIwY42y9QjdUP75nb9lAlvFSW5DGDl9iuWLmZOCBWzOYlpD
         IuMPXtbww1p66zF06OkNfRNCsi1FuCZW3xy3vDnZ4DM+SHFfZujP1M19tISN0y2N6St0
         sS+SZ9Ae5uY+hHxC4EXKpkklkGMDdSnnzbD2PNc/+Ih/xGwEIKCdEksAIIAtpzuTKDKh
         BHmc4U9AiqjepxSPsB8nIND+ZbgXvZBwo4YBtsp9cLsV3gULofzjmUWwkQDukv0xATbn
         fp27Zp9uTeiH3Kdu03C/hn0lrNYIv36WbP8i7jL/c3PNZiHlBJHgmiVB8gm9vz2rbqOX
         5Lyg==
X-Gm-Message-State: AOJu0YyxP/zGr7XKQY+AIrzH3h/j35Iy1VCFg63GQ/aJ/EqsnKzmRr/d
	Kmm8CIlZbo8OB9y2Q6GOEIyQA1Cb0vFfzsqbhF24L8vKThfttsOegwGxUotIPvk=
X-Google-Smtp-Source: AGHT+IEQ9kSpmo+SXUmMVDYvFgPMWX4IkpWnhlI4r7UuOVg+hI6gHm5fRGHBFQNU4H7Q+3+vwlmnTA==
X-Received: by 2002:a05:6214:260e:b0:6b5:7e97:7151 with SMTP id 6a1803df08f44-6b5ecfd3fcfmr99041926d6.17.1720279709211;
        Sat, 06 Jul 2024 08:28:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5f6dfb30csm17416486d6.23.2024.07.06.08.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:28:28 -0700 (PDT)
Date: Sat, 6 Jul 2024 11:28:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH] config.mak.dev: fix typo when enabling -Wpedantic
Message-ID: <Zolim6llm3cphdTT@nand.local>
References: <cbc9446b1b0f2453b96aa9c0d89b9ec086a619bd.1720205457.git.me@ttaylorr.com>
 <20240706063143.GE700645@coredump.intra.peff.net>
 <Zolfn81ygqfw0iOK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zolfn81ygqfw0iOK@nand.local>

On Sat, Jul 06, 2024 at 11:15:43AM -0400, Taylor Blau wrote:
> It is tempting to just want to rip out support for older compilers, but
> given that ebd2e4a13a (Makefile: restrict -Wpedantic and
> -Wno-pedantic-ms-format better, 2021-09-28) is only three years old, I
> imagine that some builders may still want support for older / pre-GCC 4
> compilers.

Hmm... thinking on it more, edb2e4a13a hasn't been working at all on the
older versions of Make that people with ancient compilers are likely
also using. So it's possible that that commit isn't doing as much as we
think, in which case we could rip it out altogether.

I don't think you can actually get rid of the detect-compiler script,
since we do have filters for more recent compilers (e.g., "gcc10", and
so on). But it would be a step in the right direction :-).

Thanks,
Taylor
