Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCED6143722
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943820; cv=none; b=FAVF1EbtKzbr7eSRUJqRK+E2Okjp0IivXBPzX87Yj4PPdSoqe1B4IMCUbWUWK7tfVOCDcK+LskeAsMFeO4qNpc8Ys7Dfb2JbafkdF/MAlvft62OLBrqcg35qheqT18sRhdgU7aAIgWV+e0wsp4VgTj+LNw0Zo+4VyLvFLLWl7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943820; c=relaxed/simple;
	bh=U3/Xdxsb8tuZGHwTwYsUyWgxtDCPAgJ2K0FzYLOAD4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKgJlmBS7SoT8TFBZojx/YAEi4x0KGKpkrOcghJ8KsQXcDQ4+1H5/KqGyIBorMFkCKx29Pmgxnignh9MPbFgrEyr+EFES08QD2DxuoNap+/bVSfIx4cl1GR6CW3FXpa2Mb9a/wucV0miH4dVfr7udsFpGKfwBRn3bdI8tAs6kJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fB/FU1Hg; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fB/FU1Hg"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e2e3e4f65dso42999097b3.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728943817; x=1729548617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ir6Id6i6o12JB65AzXXzHgeFaTIZF86A2nJ8M/g6Urg=;
        b=fB/FU1HguvgtDbcRcP4ySMAPFh3dD0y8Ky0Aa9e2SFDFLfmNH7JBne2BGI5HwQCIKV
         M1O5uMzc3gC0W+N81tF6uDEC5oEqot6X3AETCn0fxnhBoWBL3NHPsW/J/cY6IwW/0qh2
         XfQ9m017DVtTneFy5LoF/wgwYwDj9SgZ4ZrraHV6uKSw05XfhM8Z2Bkgp65KHHS01HmK
         BRPOYeuXpQbgVau6xlCQZwN7j0OY0bkp9/gYYvLniO9iF593ZBOKVeIsAZIrmYZfdii+
         YtEO0QWaImQWNdfZLcZdKP7IheIuErmLB5P79qMAuZkYAKqUs4daSCRAYHPHk/3BRROJ
         9n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943817; x=1729548617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ir6Id6i6o12JB65AzXXzHgeFaTIZF86A2nJ8M/g6Urg=;
        b=NQFEgjLoRGDe7uQ6djId4jLM5VnJ6KrS28l2ZZb+aOl4u1bbfSXGaqLNCn0jlmCDdF
         tYbk2TvxtTFUUOHJi+GWPWy3LgHFDcEv3j02lZImg/0jwN1aZyCsKccLtHgjTI0644eR
         zusaYXCYMxddKM9y5xmG3fe4wW0mmy2hOIg5kwh/k8oOngbQlxycMsfvzpU9LBio+Mlk
         pa5xG4aQIXU0iqNtuyHFcf54oziwsGJ5SQ7DyBa72XwckDLElV4N7Uqa5i6y1A3+3fyZ
         llaBr0yi8y76nZlAX/AZK1oSENPdvOrxQ/7LVv7BMsXsK4CZ21FGpsQKiOByrLDyvrRv
         ct7w==
X-Gm-Message-State: AOJu0YyivOMcog15i0ZDm8Kj8/6CtsVHN5szO8kKoc5yDcPQIdVYr+83
	jWxgVqg4CKvovOOyovtEVz5phSiYDUaqlAY6LcfvOdfDYlLmLKoDhWMXQTYp+SY=
X-Google-Smtp-Source: AGHT+IGH3GnQcjQHJJSUxT3amv3irSNTtZtHt9lI4HRWvFYzLOXF8VMDoC7z/Z38XnbPdUPPAb7ryQ==
X-Received: by 2002:a05:690c:6c88:b0:6db:d572:aa7d with SMTP id 00721157ae682-6e3479cf1bbmr103026997b3.19.1728943817585;
        Mon, 14 Oct 2024 15:10:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d25fdbsm39917b3.113.2024.10.14.15.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:10:17 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:10:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/10] t5500, t5601: skip tests which exercise paths with
 '[::1]' on Cygwin
Message-ID: <Zw2WyInmctTHRRmd@nand.local>
References: <cover.1728906490.git.ps@pks.im>
 <e1b9617f9439ce81172d7fde74369ab12407f5dd.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1b9617f9439ce81172d7fde74369ab12407f5dd.1728906490.git.ps@pks.im>

On Mon, Oct 14, 2024 at 02:21:31PM +0200, Patrick Steinhardt wrote:
> @@ -806,11 +806,17 @@ do
>  	p=ssh
>  	for h in host [::1]
>  	do
> -		test_expect_success "fetch-pack --diag-url $h:$r" '
> +		expectation="success"
> +		if test_have_prereq CYGWIN && test "$h" = "[::1]"
> +		then
> +			expectation="failure"
> +		fi
> +
> +		test_expect_$expectation "fetch-pack --diag-url $h:$r" '

Very clever :-).

I am not sure what is going on here since I have almost no familiarity
with Cygwin. But this feels like the sort of thing that Johannes
Schindelin (CC'd) would know like the back of their hand, so perhaps he
can illuminate it for us.

Thanks,
Taylor
