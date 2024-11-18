Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D71B6CEE
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955764; cv=none; b=UiLIDGRBWA6b/mqAgTE8IMr+IynyG+SLHGq000xcDIBlq4kopxuecxQnOWMh8U2aG+Z4XYfoRV0MzcUxTl0K2T4LUzH9U3Is4g/5WKGu1Mc6HQ7vUMV8YLsdpOM72PZ7WOK2nYynga13dfe7OnIa4Lnb0viO7jG6UmFXfidAwLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955764; c=relaxed/simple;
	bh=uAefBDH5EDHr0ek0o2r9QXHeAq1oNTdETlxIQh1t1IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSYVa5JHX+CWdBT4LTfHmj90cIc7Tbsw4KOAqbDjI48/12dx0tkZR9X/PpuQ2eo+EqnBCR3DHgB1XgdmJE8NH0uU1W2EaTgtXq7uFWzzj8uE237NvMW+S0xIDo2EFMpZ1oZvoGJatZUh3vQowBngusSbYEIT0e6S78Cs0/5dcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SChA5OvW; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SChA5OvW"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e7b704b7e1so2283656b6e.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 10:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731955762; x=1732560562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgRM3++9XsjK5loKB6reLZ4Tg71I4u2P2RqrTIJ6e38=;
        b=SChA5OvWEqpmS0gAGUCJxX4+JjxENocUldWBB65E0U2oWvKGGByr7Bm8XjbNwD9XSD
         /6dg0ES4srMqa4pYPuUuDScE5wZsSI33FEtwZ/RwAvV4afylgRN6ABE0vNTk55NruSsy
         Axbl9p9TnMvAuOWs5oZekd8ohQmUBGdVPs/ifqhJUXth5tmiPFEGs/S/2lpaKeHDhNJ5
         Y4Pen6mAn08usiWja7TLWTFCiDI9URNn2uYbh+zu3Fdzl8ws5BcdyaOChNpHvwOvO1Dt
         SGbDVGmgdZDPhddwMow1qmbOrRBHm8aVsbHVAgKSZm6t0vXtOeBU+rC94Z2e6AFFc9SZ
         XTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731955762; x=1732560562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgRM3++9XsjK5loKB6reLZ4Tg71I4u2P2RqrTIJ6e38=;
        b=jvmHf5S0EXHJnIVEltUg9H1iHsEdKrO+vFHRU429KwVfASCrqe1kzlJo7TvSy07Jly
         cBlvjsVzx8zeTXa3Tu/myvFTcyEIJskS50uchwHRmvZsJAMP7snNT439EXN1GPxEpdre
         9pRmzbri7dGrzJR6OIEUkgKkEUtHoLor3OVa0ykHEBuJdhylHwmxsYLrLU04SM1Or0i8
         QRNCFHt3SoWiJtddxX6/0kEqWSQeoTwzD0pSe9Q6aWSYs96hbwh+T5xIk0SwdlT/ldQE
         2tFvHbXlUSFAu0zVbhvZ6SoQVP0mk2ey5OmZYlep5sRosLSuC1Ckt91lgSpvMmZTDUhP
         UX7w==
X-Gm-Message-State: AOJu0YwOodAD23roH3FNZFKYpWlNkI6g1Seh3FlEUlr1TEIOoh6kUCMx
	tUWLeB5TByfmlWRHQOi04pCMmfip2QxwXrARC9Kumh7PIcT9Qtt2
X-Google-Smtp-Source: AGHT+IHUyHBbid9/3hhGvz3iOke4HOB3LgY+IY2j0+YzXw7ai7GHW9wtZv7Ih5luSZOyfxX8t+YOFg==
X-Received: by 2002:a05:6808:229f:b0:3e6:5ef:31ff with SMTP id 5614622812f47-3e7e1046b87mr254350b6e.13.1731955761887;
        Mon, 18 Nov 2024 10:49:21 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd92e51sm3122117b6e.45.2024.11.18.10.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 10:49:21 -0800 (PST)
Date: Mon, 18 Nov 2024 12:47:32 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] cmake: use SH_EXE to execute clar scripts
Message-ID: <j5dohg2u5vguiffj3dkqimach725ca2yhyzu4cookd6gvjoav2@qizyg7mazhyz>
References: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
 <20241115-pks-clar-build-improvements-v3-2-29672bf65ec6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-pks-clar-build-improvements-v3-2-29672bf65ec6@pks.im>

On 24/11/15 08:32AM, Patrick Steinhardt wrote:
> In 30bf9f0aaa (cmake: set up proper dependencies for generated clar
> headers, 2024-10-21), we have deduplicated the logic to generate our
> clar headers by reusing the same scripts that our Makefile does. Despite
> the deduplication, this refactoring also made us rebuild the headers in
> case the source files change, which didn't happen previously.
> 
> The commit also introduced an issue though: we execute the scripts
> directly, so when the host does not have "/bin/sh" available they will
> fail. This is for example the case on Windows when importing the CMake
> project into Microsoft Visual Studio.
> 
> Address the issue by invoking the scripts with `SH_EXE`, which contains
> the discovered path of the shell interpreter.
> 
> While at it, wrap the overly long lines in the CMake build instructions.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  contrib/buildsystems/CMakeLists.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index da99dc3087a218d30e0fd1044567d7148d0d80a9..2db80b7cc3c6aba840f18ffdc78d2cda1877d8cd 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1005,10 +1005,13 @@ parse_makefile_for_scripts(clar_test_SUITES "CLAR_TEST_SUITES" "")
>  list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
>  list(TRANSFORM clar_test_SUITES APPEND ".c")
>  add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
> -	COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
> -	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar_test_SUITES})
> +	COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh

In the previous patch we used `${SHELL_PATH}` to execute the
"generate-clar-suites.sh". Here we use `${SH_EXE}` to execute
"generate-clar-decls.sh". From my understanding this is done to help
discover the shell on different platforms. Naive question, would this
also be useful in the former patch?

-Justin

> +		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
> +		${clar_test_SUITES}
> +	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh
> +		${clar_test_SUITES})
>  add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
> -	COMMAND "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
> +	COMMAND ${SH_EXE} "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
>  		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
>  		"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>  	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
> 
> -- 
> 2.47.0.251.gb31fb630c0.dirty
> 
> 
