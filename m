Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D01BD039
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819648; cv=none; b=dMPc+SHjxUEbf260uAHnMnWFxNO/pa0cyv+GsT31lkw8aP8T+uDD5j/RErQ8EdVuD2Dck8KaQBV+jMztyKCvoo1FKW8bm++hcIEJmaCv5qHNu74WK6fxw4sTsFZqM2K3YOAONro32oEXoJBlflbP9deAc5SUjVCPmUqLLHFu25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819648; c=relaxed/simple;
	bh=gacvfys0pJqpV5OWAXC+Hs93lOyg2dlfq589MgGJic4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mzn/BOboNGqEw9Unx9YRS49KEgRozsRDhesx+aO/L9Iu/Hr3SzJoCj58Gt5S7dEQA4uO8Gub43Ygbo8JJRVFGkIfU7R9uRMrjTG5LAFclhnwenbuawuprOox+e8V7M/a/AXAUqf8hyq+TOaaCMnCs31K9DeTbMNmgqfQ5Q+nYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo8sSY3i; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo8sSY3i"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db35ec5688so1174691b6e.3
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723819646; x=1724424446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O2u2bJP7K92Q1Athx7abMYptTfxiyjHaMcQe0cM6gDI=;
        b=Xo8sSY3iD1YlxV4DC2ccRek3m9w9riTEExVCjGAzizxDXKgRQXnxqVk3RdGc1WxYyR
         PbQlu3boRYfKEHOGpFpWrVeV2hPuAC1j5cfWVlomNqyBQMyWpMY7wA6Sv9IRKln0wzFP
         S5Fa62yXF/bQdobzviCSRbX2pdbFujKmaTT4RfYDHO+VPZekRJyr4zqOt7dtzfewFNs7
         VtnYpPMZDTbsq3yYOR0ps4F6+a54fetcDLXPTgJ0qQGRGLDF1n5foGVCudYRulUTBZrQ
         PtIKF2Lr4wk4XkR485TXApWgJMRiXPr0jdNQoqWq+ay8DrXbtcInXlmfvqs9p+jl/uVR
         xDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723819646; x=1724424446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2u2bJP7K92Q1Athx7abMYptTfxiyjHaMcQe0cM6gDI=;
        b=XSZfPwuAPTmjWBBSRbpW0/6+ECZjuHdBvzOcWzx6wyv2YFy81Lrk8sL2BT6AYGcM21
         ipnqZYdc57r4qF93skGA5LB8JvAUVnBvb5om3ekRFK0b3SXGAF64YZ6eE7QKsPAOGP2x
         CzhMhfyPDULnIyaF8ATPF0Q+kuYarIN2yyD1okivtQWZYlhgw6M35Utrg/lcpb9VKGU0
         9+XDSq+3bE5Z19pfS5N34+p1zLpx6jpS3NZ/7OfmpWKummiiUDTKCTYbXPgeoqz41HYx
         1cCLgfqtEzKd21kxBsjFoHoYORig/VGZeS5nyvEWuAy1aeocWtpIzZtaO0YBR1hhMjFY
         YY9A==
X-Gm-Message-State: AOJu0YylfqU3TNYcor118SRkbLG1gXn89C163oGKDK83830GZO7EF5MT
	N26rktM0a3ZpWqlFjmOQ4aH1Y+MaL7wjvL/GGHCmwkEXzy3DEDbanYDcOevCpL0=
X-Google-Smtp-Source: AGHT+IFaJwQmJ610VSTCbmAwjRqXfxBgClB0hg1DZpkbW9Crn4aeFPaZTCDOa30xNyhMtyIxqeoQvA==
X-Received: by 2002:a05:6808:22a1:b0:3d9:24f8:7dd2 with SMTP id 5614622812f47-3dd3acc2dc7mr2790376b6e.6.1723819646171;
        Fri, 16 Aug 2024 07:47:26 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33f047b4sm700250b6e.56.2024.08.16.07.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:47:25 -0700 (PDT)
Date: Fri, 16 Aug 2024 09:46:35 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] Introduce configs for default repo format
Message-ID: <ay6lkuxsmdlqbjcrhk2qooh2ewuaumfzjpyhgowbsh4mycwwyv@pzsttqqgqvsp>
References: <cover.1723708417.git.ps@pks.im>
 <cover.1723798388.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723798388.git.ps@pks.im>

On 24/08/16 10:56AM, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my patch series that introduces two new
> config settings `init.defaultRefFormat` and `init.defaultObjectFormat`
> to make the default formats configurable without environment variables.
> 
> Changes compared to v1:
> 
>   - Extend commit message to mention that we also move
>     `repo_set_ref_storage_format()` and `repo_set_hash_algo()` into
>     `repository_format_configure()`.
> 
>   - Extend commit message to explain precedence.
> 
>   - Fix a grammar issue.
> 
>   - Fix a copy/paste error in the documentation of
>     `init.defaultRefFormat`.
> 
> Thanks!
> 
> Patrick

All of my comments have been addressed with this version of the patch
series. This version looks good to me. Thanks

-Justin
