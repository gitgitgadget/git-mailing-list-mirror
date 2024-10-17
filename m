Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F420103D
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190635; cv=none; b=O6joqC2/jvGm534v4l9/89AONEatNKTZ8aYDUd5Q85hj5hMKBRUPH6D0IFAK6h9Xt+ZSVUNeESwJdkjXMZO/HylunnYgd45IYW8aDg0/nW5NRA3NRIamO3ormvncoY97hOfcCQFnDw4IqXrmDwpajAIhWQJfdvB6I/wcAfL1JvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190635; c=relaxed/simple;
	bh=8hPdCtReSICKcWcHOt83dAC6GhLeyy8MUgVaFJMzIaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtxGea74mC7Aw4+N7oP57Qd3b0X3tJOTxzVdDrhcp/WXXn32MO9TD9vaz5iANXYrbHTkSc7lcLhJDMN35J3ZAeOyGVmy+5ogceY4TOyZBWLnXTtLOxYki3STp0aUDqQgxG790Jiefeb73fBlxogUvuAFOq2sR48e+cupfHAM6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qCDyrlEP; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qCDyrlEP"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e38fc62b9fso13910187b3.2
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729190632; x=1729795432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bilH7JXaaOpijNy6baCz08SgT6imuQ8/qfJLs4w81yQ=;
        b=qCDyrlEPD8qE93F/6TaebSTAZBxL9aI/+0xWRXNitq1TKUnRUvC4gyUShq8lb/Z5JJ
         fQknk5D4zY0fCC/qdGyQXOzwCFTwS5BGk167svm/iThvawMxm0yPI/eRvXqyTHMqecw3
         0yLiIpZBilJTqVABdgw1XtYTde0yJ/gbsts8VSREvg6sAXTWSKhjYri/2D0OiocFOiGt
         yEnmDLtOdLDvyJ9RmBbk/yxc5TU7gbNB2rJTCDBVNJAqEO8Mc7iT13e9qlsHuo8gR1Pt
         hFU4eA46edcc6dCHL/un4c462u7uPu5z9DFS6q8ZZKSwmsiu81/8R3RrTq2elw3zUkBb
         Cq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729190632; x=1729795432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bilH7JXaaOpijNy6baCz08SgT6imuQ8/qfJLs4w81yQ=;
        b=d7DJDzdO4tx3E3wTcNyr+XtnPJcXu5SNhOYaeuNnU2fuasT48NVZjjRIzELhqQbciC
         Ud563QQWjxKs2pdZt9vaf1zTJwHy28JOfr81OH0uhBgOIi4FlbJmX/azPsdfaeelPU5U
         Ib0IVVuijdh/TvQQORJV445r8gPgxVdUByREP+x8UYvXmSJLw80KIqLcQIULF9gy31k1
         hqEQTI2rlshxzzTgsw4hcdGuBlUWJ/B2BUwv92jGNYsrI0XQ1NvMN0L70xUbXjByEaX7
         EuqgSn2agdLPvguKFG2eztaL1ErpjT4LAU0E3khx/VU/fmycdp+3qlSN9l/YxfeWjxhp
         pgrw==
X-Gm-Message-State: AOJu0YxGO+E4cqNrSWD+0Kx02cVMUzkgr2kf/0ZBrBx77FwAyCT2Mkiq
	jkYgc3nx/Ai6eoa2bf4Z98kvuQuNt9AMcaVEEmJDH4mmNdRykbZlR8/gZeMec1g=
X-Google-Smtp-Source: AGHT+IH3WpqsbnjfoEHj9GWY5j1G4b8MJryzOpbGhqKYEHvWIJzrT2Okz7XaWO5LRpFj2l5ZWafByw==
X-Received: by 2002:a05:690c:4493:b0:6d3:e798:a1e1 with SMTP id 00721157ae682-6e3644d403cmr181041577b3.40.1729190632693;
        Thu, 17 Oct 2024 11:43:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d261fdsm12432647b3.119.2024.10.17.11.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:43:52 -0700 (PDT)
Date: Thu, 17 Oct 2024 14:43:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?U8O2cmVu?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org, tboegi@web.de, phillip.wood@dunelm.org.uk,
	gitster@pobox.com
Subject: Re: [PATCH 1/1] [PATCH] mingw.c: Fix complier warnings for a 64 bit
 msvc
Message-ID: <ZxFa5ucGZAVfqlkX@nand.local>
References: <ZxAgmvoyxZNnY1nQ@nand.local>
 <20241017171820.2679-1-soekkle@freenet.de>
 <20241017171820.2679-2-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017171820.2679-2-soekkle@freenet.de>

On Thu, Oct 17, 2024 at 07:18:20PM +0200, Sören Krecker wrote:
> ---
>  compat/compiler.h               |  4 ++--
>  compat/mingw.c                  | 25 +++++++++++++++----------
>  compat/vcbuild/include/unistd.h |  4 ++++
>  3 files changed, 21 insertions(+), 12 deletions(-)

Thanks, this version looks good to me. Unless we hear otherwise, let's
start merging this one down.

Thanks,
Taylor
