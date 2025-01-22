Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E731C461F
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584343; cv=none; b=UrDfa26mqHo7zcWf7xQzLtcEzyeinHxioq6/fOQ+G16lLosKXEesYPrw9KhXDCU1ZW9avV+lk/BNZYJ+Owb+tIOycIQudoTttR9dArhrn+fcAn5ouW6e2SSjh2ja5C7+J8W27V5vrlGbaOtctTVfN75PrNi2s22cVF8zHlgljfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584343; c=relaxed/simple;
	bh=lSeO0bn+ZnH5Iiw6EXL2PKMOmU/btsVx2PVN4qTraU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVXb1NrDhFcQ3UURK3UGrLfNzWogJPyyd1cdYMHq1WbDUx+XR3++d8+75tgiPcpw1XJPYim3Ul8lm/CLl+MUzrc/V4ILRSTOfjaJTCi9W8hZoG1Ezr06/eFQACY8LzF6rQ4XoTrY+RWtSg6LkVKIz3DPrI9q9d31mus5VbojSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Aotc6WN9; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Aotc6WN9"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e580d6211c8so435664276.1
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 14:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737584340; x=1738189140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNqCWGd2F6mwhmeTftV3J0z0P4BLo9ZlASCiONJZlI0=;
        b=Aotc6WN9q9QLKx2/VfK8hNkCie9IToaVxa0Mx2kkk8dJorEe01nN5JLh/jSMunu2MG
         imWekv/MR1ClBLYJrQjwV9awfoQt+y1duYfF7SQEmzwMTnu69ZrJAnLDcvkuKMdkm7Lq
         oWhLEvH9Ci87otzuCdEjBxa0Fswze/Db0mzYNFdOxF59DENHz2RXrFA6571UUG6mRcxw
         /qPInJXhT0JDHWy+ANKTpZU3w8QG/oGAj91fbFyEI4Auqy33T5hSZgxKNOj0krTO91Zi
         kpWuGNjLZHgs9QALkTnXtbMcT1Umq8YRNVZ6gScyx/lN/s49f1yj5WkO+RrqEG45PnxZ
         eGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737584340; x=1738189140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNqCWGd2F6mwhmeTftV3J0z0P4BLo9ZlASCiONJZlI0=;
        b=gMZCuUMVRBKpWB0ldmjFGS9/E1hsT1vGQsVYI6Ane3xUGy6uXTsGsB2GMeZYO6iVyP
         9aAAdsRImTwKIg5aeh7CrEi3t6f6pkJHlSxzOARDBL7aJS4ENR3w9DVSmCS8lMa4HKZH
         GqApkIiro/0XJiNqWWgEnbHayZqfw+jTRgEtL6q3ZStikSklGmdYswVxa32wT6f2I7hb
         EJpCiQB5CEOqBI7bUi2YcnV05zemCUU0sFJKvgC+V+R+YSFqYhUVZxejnOlNNT36ohF1
         v38XkhEckTlFAv5UvsEi3sBqe/7q7GRRoJ2ZT2sTXZTI8Xm7j4soW8kTT99PCZw1OGFW
         VzXw==
X-Gm-Message-State: AOJu0YyDtmcYNdsHNxeaQmjssOPGHebSr1eSZGeoZ+hGRNDh4DZOQZqR
	d/jrE8v8SdDU6fHFxOR40w4P9qTPKttYKO/3cX0f7iTZMzLHVo7ZlFiK7uAUboE=
X-Gm-Gg: ASbGnctkQS11wHnFfGOmzlyDu4CLQ8sO4uaaTjz8wbGzErZ1PyUostG9Uq0JfjEv7Fx
	vqaXZMbaOM/gJ36LvhHOW9SOUcviN3NYmfRFn1l0zC2Q1chlE7d8JvajDncLcP/awVXrpyQ6TsU
	VdsJu9JKAU2lBZ2UltRAo1OUNKC0XGKMCM1aHQPT11n1Ylj0INNUphRZTqyPmCMTjqi0TkexkE0
	8spgxcY5vwMWFUW61xct1xuiSbgeyhE2ZqbJOAQbJ/zjvMpDqvO8LoYx/KRZI0d4LpN8i7LoP8r
	QrKgDDABJDRxT65ZBrp6nAp2LVzfEo+4ok3Z6VTS9g==
X-Google-Smtp-Source: AGHT+IH68R+SjJ3CkSln3OMOMQfdhqWPJILO+2DvJoP99rA5btgPBVaruHjKpjiP5+ZwmBrVgYUB8A==
X-Received: by 2002:a05:690c:4d87:b0:6f6:c8fc:61b1 with SMTP id 00721157ae682-6f6eb9221b5mr178502807b3.28.1737584340172;
        Wed, 22 Jan 2025 14:19:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63fd38csm22241067b3.37.2025.01.22.14.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 14:18:59 -0800 (PST)
Date: Wed, 22 Jan 2025 17:18:58 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 3/8] repack: add --name-hash-version option
Message-ID: <Z5Fu0h6Mb9/hdA6E@nand.local>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <e2191244f6b21792f2551946a89cfc48af3989c5.1734715194.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2191244f6b21792f2551946a89cfc48af3989c5.1734715194.git.gitgitgadget@gmail.com>

On Fri, Dec 20, 2024 at 05:19:49PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> The new '--name-hash-version' option for 'git repack' is a simple
> pass-through to the underlying 'git pack-objects' subcommand. However,
> this subcommand may have other options and a temporary filename as part
> of the subcommand execution that may not be predictable or could change
> over time.
>
> The existing test_subcommand method requires an exact list of arguments
> for the subcommand. This is too rigid for our needs here, so create a
> new method, test_subcommand_flex. Use it to check that the
> --name-hash-version option is passing through.
>
> Since we are modifying the 'git repack' command, let's bring its usage
> in line with the Documentation's synopsis. This removes it from the
> allow list in t0450 so it will remain in sync in the future.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-repack.txt |  9 ++++++++-
>  builtin/repack.c             |  9 ++++++++-
>  t/t0450/txt-help-mismatches  |  1 -
>  t/t7700-repack.sh            |  6 ++++++
>  t/test-lib-functions.sh      | 26 ++++++++++++++++++++++++++
>  5 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index c902512a9e8..5852a5c9736 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -9,7 +9,9 @@ git-repack - Pack unpacked objects in a repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
> +'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
> +	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
> +	[--write-midx] [--name-hash-version=<n>]

I probably would have split this change into two separate patches (one
to adjust the line wrapping in the synopsis, and another to introduce
the new option). But regardless, I am really glad to see this change,
since the long synopsis line has always bothered me, but I never got
around to changing it. Thanks for deciding that enough is enough!

> diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
> index 28003f18c92..c4a15fd0cb8 100644
> --- a/t/t0450/txt-help-mismatches
> +++ b/t/t0450/txt-help-mismatches
> @@ -45,7 +45,6 @@ rebase
>  remote
>  remote-ext
>  remote-fd
> -repack

:-).

Thanks,
Taylor
