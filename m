Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD523F421
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754345466; cv=none; b=Iuy/U1rdKG/GEgbS0D0mI6lWMzNrk6UnD1xMNaxHeAM6j91x54mbfqQNeqB2fPsja71ZSxv7N+aFpWdEc66yWL3cuq/JLjAwfZ09C4f6LYJ/2woNBIj2XWUCHA7wvX4CyOhwVLpeREfJfsf1625CLYs8k3xdNVLuMf9yRiIg7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754345466; c=relaxed/simple;
	bh=6CeSRqbJLgb8t3SMQh5lowlckpdq3kSOIJdEWAXk//s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBgO4Sp00QTL/BwE5Q789Q5Du7dcpFbRwhpInnLjAtnZW48Sg0vgMhKXCTm1I2BSIpwjtP4jOJfFjdcMuRG5t6lN27f29O1MGe3Os/9m1ddsCqVOcrmlnZQ8EE7vLVzmVzNBGdm2Sh1x0hRrJPHU24ONvSmmtzGDtmt8YEdJ++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=iQsRSecr; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="iQsRSecr"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e3f1e69090so14840645ab.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754345464; x=1754950264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vTYNCOpFtgrnXyqSJvxPIZ1u4EUGFrxsor8optNYW+U=;
        b=iQsRSecrW2OqNxf9IX4ZE2XjV8UpVJdLLW7sKWnmehAfN09xfalVZaZCM9IeN5uQRY
         rRdIoK0DG2L7f2ypqbV1ZYblscFI1JTdFYvQTR5/9HvVJA89v5+vYth8vhqssqRm75Lv
         POziSDwhhIU9optJdhBaoPQFDpK976ENukuTa2QmbRDSQvFN/r84neQRRlkBwWd6mwdK
         9fMB/P3N2Gfot2HPcKpX9C5KxYHplkspOinErPSwLgck7VwtavKw/vqdbXFDYK7bpmbR
         Cx905ZCqLyUwoD1TZ3+h+vnJ0ntSlQLk8f/BVwy5yTBldkPFK7z6ch8B6MssVK/MUjsl
         j7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754345464; x=1754950264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTYNCOpFtgrnXyqSJvxPIZ1u4EUGFrxsor8optNYW+U=;
        b=QUyf2duFqGyCGx2CvDLOuoe29P1rIBXDqZ4CtEGH0WNK/6SRBbIxesE5yD/jOh2oad
         gD7CKtQILzgBA9JJgfcRGJxa3gln69uE3Aju9malLveOYdvXtxlayqakPekUq5WqXL/u
         uA8qR+qbAeOO8y9UkvK7Xz9FKcipM0jlQcSbXf90xhHsTpXj9mgBGK09Mw1SDPouAtsd
         kibFaxqaSWrNAalGcxjYFgp6XvI+en22V8e7+B8XiSZYGFyW5tWaNZ+ORTZ00U2ZdXiN
         g1EezlrkDD6MVq1x1/7kw38rdkCOcRRlTaRXqhP80P/zIYdcy1aDxuUj3qjrDk9TjSgt
         OueA==
X-Gm-Message-State: AOJu0YzYl1LP3MxYdfNhhPP8euDQl0w0+4LJh3SYy412U6EL+Lamax1G
	IRvfvAfUTtnZxw+Ewe0CYfpPMP6irJvLqkbNt1YziDxNb15MeMfViqDZCPWESb65RvFygi98sxb
	s1VYo
X-Gm-Gg: ASbGncuokQ6o2QFjUaVPcwl79mzvCtFNvmT6bDJJr15wYgOUvvdAFAH71ezqGuICltF
	MiikR4s/LTJd8c5BV/y2mrUsqlyhsrYaGVxRZqmmGirbTNiPVesVwyw1EXqwMY/iAzZq1Tzl2mi
	v+hjZAtkq63fwPUDZ4mFaFFSmtqpoN6wwmvG6Mtn15Y3zq1ZdrqAYQCRWxrbfCuN7mC2clu2z5S
	LAHFC9d+oBFepfdV/jfo0gXYoFO6jp0V528bIhBYO+90Ovyw/JI1NRT/tRHXG/k3EbzwcLgXR6A
	iRidMZOAYqsKaKHz3k3kKudoybQ/C1R4aLOJFaxtq4fw81FoUheKArPEj3wmk1sM8518Ks/x26a
	8cs79W+F6dAQApxj+DmKMi/3YQ3klkbQpa7Fk85sIEE9z1eK3XV2Xjd2vofg4n7a7D3rGUxbFnp
	UbYoNO
X-Google-Smtp-Source: AGHT+IEUTA25wd2Rwrc07hfxF9PkNDPANy1/UraawcJJOaGOJTPmHMo5Wbhd4kni94EK03l95odNHw==
X-Received: by 2002:a05:6e02:b:b0:3e2:aafc:a7f with SMTP id e9e14a558f8ab-3e416122d83mr233866515ab.7.1754345464076;
        Mon, 04 Aug 2025 15:11:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3e4029d9958sm44419585ab.25.2025.08.04.15.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 15:11:03 -0700 (PDT)
Date: Mon, 4 Aug 2025 18:11:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/9] commit-graph: stop using `the_repository`
Message-ID: <aJEv9vcdtsn7WGc8@nand.local>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-8-850d626eb2e8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-8-850d626eb2e8@pks.im>

On Mon, Aug 04, 2025 at 10:17:24AM +0200, Patrick Steinhardt wrote:
> ---
>  builtin/commit.c |  2 +-
>  builtin/merge.c  |  2 +-
>  commit-graph.c   | 79 ++++++++++++++++++++++++++++----------------------------
>  commit-graph.h   |  2 +-
>  4 files changed, 43 insertions(+), 42 deletions(-)

Looking good.

Thanks,
Taylor
