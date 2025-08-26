Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E5196C7C
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226662; cv=none; b=q+YUu6REvXsYh/6sSth/4b/uK1PipKIiVrLIREEABV5zeK7L0nFva/ZIizdT8dGuS/LwESE3/0W4raC4Ca0YuFD8yd57sKIdVR7aEJiS0sh7C6tY6hKLoGh5iXycHYRoUyDBYkhFdqwhBfxEZZa6U+JpMtRbW+pBW9cgCt9PcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226662; c=relaxed/simple;
	bh=ru9ivsfGomk/YY/EkSN4YufKHL2qX8L4cYXrmYRVW0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/NhyGVUdeGX2+7AtafWNgTHxdCVVMudGDuwW0eT0UY+y+5/v/P8CXCegfJJiTOZiUmo+NnLEm4+Hqq3ri1SdjUvrOZ6hCVkBs+7wKI52NNMdRSb58WkIqQLbokR93iSFryfQjHh8mOAzE9JaybH3PtQWldZn3ZNbxYEwYrgp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2lCY6gv; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2lCY6gv"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so65260a12.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756226660; x=1756831460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDV29QwR/hlnQb3a3pIDCgLL6By+C3RiIB8sCFnLQKU=;
        b=A2lCY6gv0LlzgG+3A8Y8ia3N/Q8UpcXNerRsic4Gxx3YYYBZka41tXan48HyjHbmNV
         ClxeggcUsX0GcXR+rw7Yx7FjU2JZFy5eJ3Dg4liraoK3gn4ys8gEzBVeWcgm3XRn/Foh
         xbY6U6MgUBl4kSOR5vGIDLBVpXXc5doTP3TIpm/HqyV8slXED5gxXpTMa4dmXp9JYfas
         iNcPXuzQjnotyG6XpbZpjy8CkjNvgP1lIW2qBW/gW9l5PhAwUfblH4C/QN6hUVFC1Gqj
         C+0TIBSp46lZY7reOMmbRadQbXydNJh7PX5EEYQAXSbC02A7biVh6tKuDid/EkyyWbD3
         IHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226660; x=1756831460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDV29QwR/hlnQb3a3pIDCgLL6By+C3RiIB8sCFnLQKU=;
        b=szYqbXyjKToi+VBZ4XMhPgja4JLm7eKVPnRgAFOtoTETt0MyVzJNyCDz7LROOfFaW8
         EELGFKGytP06RleXJGhhRXqhjHw7z28LOx1Ne2HkR3vnbe55SxuUds8Uc+sj8Y0lHHp4
         MIh+HmesScacrLJ1ijQ+1iXlfncS3bIgQ3U5PWouKm84HEnsubAwFMxdixOwwa840Giz
         p93ADt8YqKdcYB4LLV50loAk6tuEOmpXfA5npm8sRq61Zn8eAuXoumNjVBhFTqOml8k1
         XCZ9gipcCnXVFYKNCcYtjwsTwVqLgmIsMIZtNHnCxwbjtLXKjjdrft18dhSz4H/fIVos
         uvdQ==
X-Gm-Message-State: AOJu0YwVKXk3mNtmgt7vzCV5qe4e2nz/VnnavYRjiUBTTQOxEJPY8eqE
	I7pWQ933OrqxK7W9DoxOH7c9pk3al7HubA4Iv7KDGi8O153cc7EqjoRw7U4RsQ==
X-Gm-Gg: ASbGnctgBQ6JcxqPe2BvLTz2tA4eXRwUOvpVqVz2yrJI2PvS7qVPA3Ah1Iu9422sg8v
	0vpGFZLVWlDm21fnrLKyEOuASmB/0c6K34cJpHt+DLB2sslfMXqVDUl0U4HWW6IpVP+kdMlhbIO
	BB2o3gQ/qmXDN0+JhTs5TX2JNcfJOEPGjkIbnbxFc8wjVnr2TBMvkI9MDYJCRdANET66NYrSXtY
	pFEEVvPi7BaVmSfGgfU0LnZu+t0tkUhSBbbTiAEbqu3N4RFFhwC125VePD4rhw0BbNFFT/glpWT
	y0dlcHoL1hKNJs8guQFb00xpTNmEydRj3CLFxhBGxbfnvBY/Iii7f0A2kKQT8BoGSxRNyEoy9rx
	VrzJGqGb7XqYtCqo5Tn8dxJIEimtK
X-Google-Smtp-Source: AGHT+IGcD8kK/jbyKN5Srdq6fE8iFWUFsBhznzRUEh4bVkKZwBf/QzRINMvamNb7NGiS700IaYpHUA==
X-Received: by 2002:a17:90b:3f86:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-3275085c831mr2830921a91.13.1756226659988;
        Tue, 26 Aug 2025 09:44:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3276ae27da5sm29564a91.7.2025.08.26.09.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:44:19 -0700 (PDT)
Date: Wed, 27 Aug 2025 00:44:17 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] refs/reftable: add fsck check for number of tables
Message-ID: <aK3kYZA1eq-sCs9b@ArchLinux>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
 <20250819-228-reftable-introduce-consistency-checks-v1-3-8b8f6879fa9e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-3-8b8f6879fa9e@gmail.com>

On Tue, Aug 19, 2025 at 02:21:02PM +0200, Karthik Nayak wrote:
> +test_expect_success 'table count should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git commit --allow-empty -m initial &&
> +
> +		git refs verify 2>err &&
> +		test_must_be_empty err &&
> +
> +		touch .git/reftable/0x000000002812-0x000000002813-c830a596.ref &&
> +
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: $(pwd)/.git/reftable/tables.list: badReftableStackCount: mismatch in number of tables

This is a bad usage, we should just use `reftable/tables.list`. And this
is a common pattern. We would print the relative path against the ".git"
directory.

Thanks,
Jialuo
