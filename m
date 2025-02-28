Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95801F4C8F
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762831; cv=none; b=fDYiqAFzhntrcTsggFQjd2Wuhj1Zj6muiOgcWjU1fBwmG6FDb29mWP0ARcIGXkLSPxmTr+i6y1wbs8rn8d8cLlAufo+ZfbDHKGpopi5xnMjcpdabdMrPfLQbFiarszOIrcLbmzrQtMqhHDRGmvgEI6vGUvXKGpRr9kqrB5+fGE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762831; c=relaxed/simple;
	bh=diHs3LEdsC4iOA6ht4V/nhgXyH5bWpYCGUc8aGrtY3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkBqRMUIlZpirLWv9CUtEHO+yuwwZuKjdVKu6kRXCkAgzQ4cXCXYKlKOmYdkU2hWmfO+q+L3pmu9ygwtaSpTsz7096pgdGU9piC0RHEDMdooxXXGtS4IamNppzYofnH6XZ6PdgP5wt33tBsplH1Tu79nhbIuNdJg2y9/wbejPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSNvSk6H; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSNvSk6H"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f417de5e25so1094435b6e.3
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740762829; x=1741367629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNVpYlLns1zfVD9SPkndZQHEnuXRyaAChTot7VrkNCE=;
        b=FSNvSk6H4dplAhpxDH928Xd9vrGjvIViAWFAgrQxCubP8yI3CexPlYM16poMvDIC0+
         ChDhK+Rb+HpMQyMhM2gNH1pRm90oRHExNXBsLZhJLaZaAeBIxtcJVFZOpyo3PiwVXNRu
         OgMpeVlGt2O16Vs47eppCOlHCXAwSkB+C1NB9CykbRz/ftku8CLvtKRCEuUVSH060oql
         7yWgcp/LuUdS+0mQVycYbfFiw2fpJOr9Przk57fXndPEs2j5emzEUBcw6m31VRviOdSr
         +g1FR6mupPIQOznSMtb6J7pFxyFWZhH36mH0nb19JphJkycIg7rPUC3j/AOgszCvVG/V
         UIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762829; x=1741367629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNVpYlLns1zfVD9SPkndZQHEnuXRyaAChTot7VrkNCE=;
        b=eAc/Nzml7+p9Bo7+v/YyCtkz5vOJdE0XuXMG7De/xGQwKwbWoDXyyMD21J5qAjwJVf
         sARa+aLG1WLPotskl84BnHqN2+PiqYnNlnlRzIcGYUf2NfE/+NEqdwBxmEgyjgrQy0FK
         LIr671kJBYzzG2samvRaE9jMUAst5cc3tdJ+9nx+DsZSsGJEgOc5/RmTlXaDj5hLD+ay
         h37R1Wean+LKVj3y4IAqjUwuVqsNC2xVgq+flGCzrP9Q1vEQEb3rS6SmeBLJg5/2kaAY
         sZKrDGlBxcg8ma4dmXxvoVzoB9U0NvUdFvsonnYUh3oN8EyiqaFN+otIxGloKt71BFSS
         Sl7A==
X-Gm-Message-State: AOJu0Yx3SiM+qyNTm2BCmSizWh5IDH2YGY2e6zuAJJPOd75TEzdZae2P
	s1R3jQ/qNvHjm4vy5AhyeMDpvde1BD+MgZKYSCQjYjvq6Ep9obl7
X-Gm-Gg: ASbGncuFul1oaBI0/WTRwhWP6Wix5kioQemde8AKs9Tt8cHEKs1poeA3GrBoAZ1YtLS
	ETxhifQ1wcobpS7Sr4pptac35uleV4kyYbaJHnVZT09RTxHgOt+FJC07BZFurKGwoCi7qw0fkY5
	e2MiS0zy3Mvb20pW1267DTe8mySRqFFbGRb3snZBRYPin5ktleXTvhexotSXAbQuhX/R9u9Sf5L
	ZecHIc53oFOJy1wPssNy97aF3NtbBddXo3C+pAhjspzRP+d4ozuIzl4SAz+DBYlpZ26pNGALqFV
	I2KTQPDmFbqPyRd7Lcs=
X-Google-Smtp-Source: AGHT+IHp8ae80ehpYL+YI68c37nxUVFumGDdceV+/rzvwZ58otjUFyKy1kUbYM7fWiiTMwNy0nd8VQ==
X-Received: by 2002:a05:6808:21a7:b0:3f3:e9d5:77a0 with SMTP id 5614622812f47-3f55830f4c5mr2454757b6e.0.1740762828802;
        Fri, 28 Feb 2025 09:13:48 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-728afcffee2sm705735a34.18.2025.02.28.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:13:48 -0800 (PST)
Date: Fri, 28 Feb 2025 11:10:32 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 2/4] diff: add option to skip resolving diff statuses
Message-ID: <r33nifirglhjiqhwxa37fuujvzoxefzs7g5ovjdtx43d6wu76m@mca3i66mgmtt>
References: <20250225233925.1345086-1-jltobler@gmail.com>
 <20250228002604.3859939-1-jltobler@gmail.com>
 <20250228002604.3859939-3-jltobler@gmail.com>
 <Z8Fz5XHtyG_m0_bX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8Fz5XHtyG_m0_bX@pks.im>

On 25/02/28 09:29AM, Patrick Steinhardt wrote:
> On Thu, Feb 27, 2025 at 06:26:02PM -0600, Justin Tobler wrote:
> > By default, `diffcore_std()` resolves the statuses for queued diff file
> > pairs by calling `diff_resolve_rename_copy()`. If status information is
> > already manually set, invoking `diffcore_std()` may change the status
> > value.
> > 
> > Introduce the `skip_resolving_statuses` diff option that prevents
> > `diffcore_std()` from resolving file pair statuses when enabled.
> 
> You mentioned to me that there was another user that basically abused
> `found_follow` to skip over this, which seems to be in "tree-diff.c".
> Would it make sense to convert that user to use the new mechanism, as
> well, so that we don't mix up options and state?

I was mixed up with something else and mistaken. There is only the one
expected existing user of the `found_follow` option. Apoligies for any
confusion.

-Justin
