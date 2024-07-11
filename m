Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C332F46
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709364; cv=none; b=B8U1RPqaVt37fum57CQQt649cLlRK3jgtd1zWm1EV8Oeugiv11Lpo8Khmg7eQjJOPrR98/x2tKzVAFQoQzG7xzZQZcLO5O0IVbYxvAEOxLlSVwSQCrTJKKPAFJqGtfJRI3OOKjwZnlGaBom403SOW5ErVnXFes7Hxd8Ym9Dj+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709364; c=relaxed/simple;
	bh=PWuJvg60iS3hMYL6bdwPfaw5naqI+NLX7MqOkuuS/yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbG3mfaK9vhrwiwSqFOpfAylKHVydYkhb6dk/d3wC3ugdOMxmulMx4q6c+DECW0l1vnMvbbfShX8OcTweOHzpJ1bBgc3XzhEj7kW3Q0Th7JgphAqpep2dHHXplM9nUx2ZmJCn7RK+7VmNxKHfPXK605dQGjLI3+e5kgXCQNy21M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1Wi4JPO; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1Wi4JPO"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c47c41eb84so551393eaf.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720709362; x=1721314162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XgacDLC2Kwc3Q4h8GMD8XtygvXE3QTyfval5mQ+pmEo=;
        b=g1Wi4JPOsRjJc7lf0spRiYFItxMFv2bmU6JtNUyUIvMqFMIqGJoDzCJzFZJ0LO/Pjo
         Vb38FHZsp4ZWdyFiXDc33c6d+dfaRyAwQDeKdfWAcyOpVdEGoeOrDdHS8I7c0FdicvFj
         vBGkxQ/S/hiQLWSz1SUjGtYiy/6TdeXIKLmH3pMgyiuQ/plCHzGeat6XlQzyrc6ZH1wq
         5rHNT8AVe6YCGCwTn7LDNDaQ38eTxx01Jxl83x7cEcQO+SlDMsSThCqluV41DDqudBQZ
         +/fk/v7w4C0KXsOeF/NLUF16E21z+3GD2YM2Oy1RGbxyFnhvpudeioAa0HlhAnMVSXam
         OGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720709362; x=1721314162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgacDLC2Kwc3Q4h8GMD8XtygvXE3QTyfval5mQ+pmEo=;
        b=NalEIUNJHRTMefGJF4ZsynLgn7IeEETkL4psZQGyKQyulwYok15iwuU9oE9ac0N5iV
         ZQHPS3vbZIxydI6KoF4J6UiMW3ms9plHx0/Zd4M+CJ7R98BL0MinH5DghCKNIuaWVvTG
         a1smE+Ay2vHkQcsJreyokJz/S4eJWkiHoQxJBKKcWA575XuMstUe6Gp3Rk0CoYGxKAXp
         /MUY1Ci8G5YZT9zj4XzZAYkcIbLWsk5DyFbevtki5iXLFm2QDkQOwdNHMWVnsMcHcgV0
         +QPyOWKsxLwuZXLWFe28Cpln1wNonM+UEs85A32BXwVeEJZMyGaWxL+wboZoH7RMx0Oh
         RGTw==
X-Forwarded-Encrypted: i=1; AJvYcCXc0mnvF6WSD9nELM0rVVwTBBSkavZcn2XTD2N0zzsEBvTQl3dhhePcQciIVsGJu84eU9YVDOCUYiCoSzpD55pIUyIp
X-Gm-Message-State: AOJu0YzmJyV3aeFLQhUtqUle4YC0LcZTAUAdfcFLIHMnCSm/7bI3y2qW
	j9tt2OOv/G2w5q5c6u/RtlV5vvIXyuvhh+WaH9AcAHOJpfWJiJ6NpS3Q+A==
X-Google-Smtp-Source: AGHT+IFzSCZMhQp3hsulq7AdxKMUJ5487r37Yl0gjHhrpikjLMtaHXAVKgXbpFl7VzNi/kw2UwZaMg==
X-Received: by 2002:a4a:accc:0:b0:5c4:177a:23b1 with SMTP id 006d021491bc7-5c68e48aecamr8479134eaf.8.1720709361893;
        Thu, 11 Jul 2024 07:49:21 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c697de267dsm717984eaf.16.2024.07.11.07.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 07:49:21 -0700 (PDT)
Date: Thu, 11 Jul 2024 09:48:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org
Subject: Re: [PATCH v2 8/8] check-whitespace: detect if no base_commit is
 provided
Message-ID: <zq2x3k5gshs5jgx6zglfdzu4kx6vrrzugfvd4w4pjfh6uyjc4r@4x2zt2ftfmsq>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240711083043.1732288-9-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711083043.1732288-9-karthik.188@gmail.com>

On 24/07/11 10:30AM, Karthik Nayak wrote:
> The 'check-whitespace' CI script exits gracefully if no base commit is
> provided or if an invalid revision is provided. This is not good because
> if a particular CI provides an incorrect base_commit, it would fail
> successfully.
> 
> This is exactly the case with the GitLab CI. The CI is using the
> "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" variable to get the base commit
> SHA, but variable is only defined for _merged_ pipelines. So it is empty
> for regular pipelines [1]. This should've failed the check-whitespace
> job.
> 
> Let's fallback to 'CI_MERGE_REQUEST_DIFF_BASE_SHA' if
> "CI_MERGE_REQUEST_TARGET_BRANCH_SHA" isn't available in GitLab CI,
> similar to the previous commit. Let's also add a check for incorrect
> base_commit in the 'check-whitespace.sh' script. While here, fix a small
> typo too.
> 
> [1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .gitlab-ci.yml         |  7 ++++++-
>  ci/check-whitespace.sh | 10 ++++++++--
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index dc43fc8ba8..c5a18f655a 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -119,7 +119,12 @@ check-whitespace:
>    before_script:
>      - ./ci/install-dependencies.sh
>    script:
> -    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
> +    - |
> +      if [ -z ${CI_MERGE_REQUEST_TARGET_BRANCH_SHA} ]; then
> +        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
> +      else
> +        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
> +      fi

Not worth a reroll, but it would be nice to have a comment here
explaining why we have this fallback as, to me at least, it is not very
obvious.

>    rules:
>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
>  
[snip]

Overall the GitLab CI changes look good to me. Thanks :)

-Justin
