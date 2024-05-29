Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23945176FD2
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022131; cv=none; b=NvXSuYf9+O5lW1KoB5oVAYAXT17BC7hcUsTjwNoMER9WO+CubSYAm/74jiukmHVEZBN/1wCf4+Dvg5mWKR6ixA54OOKJKCpuefGPQdk6CzBqthie5MUTrCWqypEIdxfFm/zZxQWQAttsKH/BJmPjnGgVrmugRbSrQK/4foh66V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022131; c=relaxed/simple;
	bh=27N15hxeTALuNNf9rz+VodKz1/JbRZ6ETJY5WaP1o2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyBuJXYY5sC9GYkPFTLTAzSpno9DQ+VFI3tPwV/+eyzwlwS4ZwqmjMYBtrEGpzbIPR7Ny0876qOM/tz8Q2B5rBUvFqsngskAUX0mDRIV803YHUIvvnAHlc00fdvQQsbxJ4k07eUQyYDS6m8/52Xb0HfARy/V/iiHvuQTlFbXtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YMy6wHCL; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YMy6wHCL"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d1bdefedc0so97376b6e.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717022129; x=1717626929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27N15hxeTALuNNf9rz+VodKz1/JbRZ6ETJY5WaP1o2s=;
        b=YMy6wHCL/7uNuUEkpm7LLe2BOrKiGgQGHRjl5hJkk4tdYyHuvlw2gQQDGNsi8pyaAO
         1DCda4hepWhUXGMyBM3dpSt05usG4Z+hpLOUXpMIEcOrykyWLXynJ1cIrLLDibayOwsH
         v8b0/HN89Fv6d3Mn5CKvXVy0yt1V0Fr4pKYrp/zpL9E57W5i2ixE81QhO+RrqCZhaI+e
         WzbTvfCqdCe4kxrYU5MoFXeRVJ8WlG4orNv4NDBN7KczAk3OigbJNfgStRJFC2+BtIRc
         9fT7TcZEgP/809kW0ssaiIKr4O2Bfazte9s90FP0QYkDoSOUU79wcRS/4KHq1n6rQles
         eHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717022129; x=1717626929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27N15hxeTALuNNf9rz+VodKz1/JbRZ6ETJY5WaP1o2s=;
        b=lfWpESJhEnUwT+cChUzlOn7SmldAO+xBSLNxUjoHti1sqy6a+20MYu5u47kRqdsjzi
         SuNMFYlG8Gk9rbTb7Ko264nAZunvS5sUVztVG7eolfbtzBU+zEUYkSh8hfcIYBgqz2Um
         GEpKjgq60xiTv0j6tcKQbkvLqxWY7qx8Rh0nAdatG66ZDOXPov7UYUqzqXfmgVj3a+tW
         7j7iDCshLBMv+FGO8yyknBe5UEJAdgc5Ob9e1Pz/jouAU065fZZ1gHeoUIxSaCB0LnsX
         ZJGcJ089Ldhwsnqsi+z90MoW7bM3yDLQYN13f8nbRUWXmwXpWqEmIf7KZAhm9AEwyoCD
         tGsA==
X-Gm-Message-State: AOJu0YxUCPJ6G58wb929kz+a2FIVNR22Fo6AWUf+N2uX0mIf5KhyW2tG
	mWKhp4qrzIo+6WagtW/LlqB7vAgWo+gNrNKw3RxmoTJw5v8L4c0ExqLvbByUNcRrcZosDCPStrZ
	Iwx4=
X-Google-Smtp-Source: AGHT+IEPT5HUEuKTvqvHwgApo5FqmOJ+OoSnY/mYuaCkI8JGCwsuvuZ6oRc21WSCgjUGaWhy5OA2Lg==
X-Received: by 2002:a05:6808:1392:b0:3c7:ef1:483e with SMTP id 5614622812f47-3d1dcd0d6a2mr397200b6e.39.1717022129049;
        Wed, 29 May 2024 15:35:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070f2fdfsm58721436d6.57.2024.05.29.15.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:35:28 -0700 (PDT)
Date: Wed, 29 May 2024 18:35:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] midx-write.c: reduce argument count for
 `get_sorted_entries()`
Message-ID: <Zletr6Q7QBgQ0CgQ@nand.local>
References: <cover.1716482279.git.me@ttaylorr.com>
 <07dad5a5812794be6e355b1e0eb3722d452f292b.1716482279.git.me@ttaylorr.com>
 <ZlbdrczSqKgueK0g@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlbdrczSqKgueK0g@tanuki>

On Wed, May 29, 2024 at 09:47:57AM +0200, Patrick Steinhardt wrote:
> Nit: I think it's a bit surprising that a getter function would modify
> the passed in structure. It's also a bit puzzling that we assign
> `entries_nr` in here, but rely on the caller to set the corresponding
> `entries` field. I think we should either have the caller assign both
> fields, or we should rename the function and assign both of these fields
> in the function.

Thanks, I agree and should have changed the name of this function in the
existing round.

I renamed it to "compute_sorted_entries()" which takes only a single
"struct write_midx_context *", and assigns both "ctx->entries" and
"ctx->entries_nr".

Thanks,
Taylor
