Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398814388E
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540190; cv=none; b=Y2uBmX5Z7uiBu57PAhzHaZ1KFqTPUrSN6joRLdFPEwo20NqWAtkh8eOd1TekQ1QeFzYAqRuuasxlydm4x9IGPuqcYxvzsUmWU7KtwZ3RCOafI7LgMhEXwCdgflgJJ/20Pz/5sbg3QFjvbOm3uu74d2mKTDSqtXaZ4hOXcl/cuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540190; c=relaxed/simple;
	bh=A5UbGFBQKcayI1aeKMQBcnpxuXdlspol7fnlOcdHc+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE+0cSrq1kpfp7tw+zhSSyd3Q+BAUck6JRUu5tDr6krv24mUElaQ8uWPcBeUycZ52Av/4I8vuVXgihZF4ldL0gL8Jpn6xHVpZtaRad5vVg0ZzzK2j2ZIqoHuG6G2N8IQWUp690KwgltbCTqHh4d07NJP02fbvfUwTTsP93oY9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YlZBAhp0; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YlZBAhp0"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65fdfd7b3deso59823787b3.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722540187; x=1723144987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5UbGFBQKcayI1aeKMQBcnpxuXdlspol7fnlOcdHc+g=;
        b=YlZBAhp0udnML2CuC7NwOyDvu7Oobg7cU9IGhq3CN5TiA2sAPVq3AkDFfQk3SC5oLO
         /xv2j4DeENHJpjNqdDh4ISUi5FAeveRQ+ccSgVnDpZE6iq/SzwynEBo3oFefG1OibPFj
         E5o2PS+3NzeQikJQP9oHcKxKoHEXBcxiLo/8dn8x28XmrDwHrNGHAvB6rrNtwa81PGJs
         FKwUF5oJaQbPzOJS+Ot2j9pwvpkssAb5bHXEY1ODAWfm285FozENYHOqgE+7OFC0WDgA
         uYWXshOolbHrcVa8I2pQ9yexKxgAVN35cruI4J5FgnQ8NAmDQR8BfQ4My11OK5Mwbue9
         p6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722540187; x=1723144987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5UbGFBQKcayI1aeKMQBcnpxuXdlspol7fnlOcdHc+g=;
        b=p57+Yra6IxQxb2tLBj9IuiFwb6BdNWSUjSURGjsFSzALLuKIq3JeG544saqkHseLm9
         Dw9yX0pjjm//6XBAtTLNtgWMIaEKcrnAQzBGED7z4qnN3wZtb09W2ns4lJbhQC4l/Np1
         1eT82ZOlZsPiDtm+sINFha36jL2oJ+UjMTKRM92lX79U/6KAcyAuMzpN1A9QRUDrHGJW
         vBC5RZsx0ImDxXpOyfTPS1q7qqHKNIUs+Jbc+U0gOc8EkpXYn2Ix5asugz3rlOqpZ+vz
         FkY+O4mz7NIqeIc0KgrSo+eokTuczsBIV1hFdVV3D1AKPzoYgJUULRvrSr3TwLZkrOci
         NW6Q==
X-Gm-Message-State: AOJu0YwkZyQFaejFP3/ci+LCueE7LHKq9FPKd0weKjxgEOwH8QIDutHN
	C6qhk81OpYlPIIRgQDWxe/iI7Nv3jYLEDLn4VYk6sxxULIIHLMYCFYhs6INWpRt4QNSuxz/Y7x9
	T
X-Google-Smtp-Source: AGHT+IFuMmoSpQp49uflqqbBx+4LiqQxFI9lutbJZ6uEqRTV9OrzhRP4hF+BR0+XJEqHVhn/prfvfg==
X-Received: by 2002:a81:8642:0:b0:664:b1b6:25a2 with SMTP id 00721157ae682-68962981e0bmr11174197b3.30.1722540187622;
        Thu, 01 Aug 2024 12:23:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-689af844870sm540207b3.2.2024.08.01.12.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:23:07 -0700 (PDT)
Date: Thu, 1 Aug 2024 15:23:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Message-ID: <ZqvgmYl8BTYvsSa0@nand.local>
References: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com>

On Thu, Aug 01, 2024 at 02:03:31PM -0400, rsbecker@nexbridge.com wrote:
> Hi Team,
>
> I think this is low priority but would like to understand the situation. It
> only happens on NonStop ia64 (consistently), not x86.
>
> The t7701.09 subtest fails missing files:

Hmm. Script t7701 only has 8 sub-tests, but I think you're referring to
t7704.9
>
> Total 3 (delta 0), reused 3 (delta 0), pack-reused 0 (from 0)
> ls: cannot access '.git/objects/pack/pack-*.mtimes': No such file or
> directory
> test_line_count: line count for cruft.after != 2
> not ok 9 - --max-cruft-size with pruning
>
> The test directory contains:
> ./.git/objects/pack
> ./.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.idx
> ./.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.pack
> ./.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.rev

Interesting. Can you attach the full -vx output of this test, as well as
a ls -la from $GIT_DIR/objects/pack?

I suspect that this is a mtime resolution issue in whatever filesystem
is in use in your ia64 environment, but the full logs will help us
confirm that, or at least point is in a better direction.

Thanks in advance.

Thanks,
Taylor
