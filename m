Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D73BED27
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508485; cv=none; b=FhGxZkgRPUs0HQ05ZJtEsKSoDsjj1rKXjNsxJT8yxsLKwnPuBSMi5RZsZE1a1RFvm4AwW4vd43Dpwgq6Xa94GeMVnVjlHLQnLfOj5LTY/TNiKpVKSwwqZU2lgGq7rbouSHoWkjZdTluo2yP2EwJfPIdr0rmVIbcKZnNCnDiRoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508485; c=relaxed/simple;
	bh=buo50hObi1CbYGr0aX/p+iv3KXxsJkUt7eaWfxRDG1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm/AF0WZ2qfBbHmPv/o7KXXg8GsLUKI971HEc3HxLecOSp0ywikubn9tNaSEw2tmS5fsSDEvkmQ9p7aN3zI4JPDoAo1kfg45/Fk2n/JKKhMmzJFxQUTxtkyVj/dMkt09XGpyp3zYAFygc39NaelWfyudlasIRHcP1fgodjE1ask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxsOT0J8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxsOT0J8"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4631679f204so1403506f8f.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782508483; x=1783113283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KzPMI/ztIJEqjrr282mCkQC1SOAWRFQb64i5un6Hqvw=;
        b=kxsOT0J8Qyl9SsT/nnRBxMu6GKKP2o2bw1efyupHefFnR9gw3XOqMG6TWYY7UQWG7r
         1w8sGHg++B5hyvJKTNVc63smQLGP41zoUaCZjMyc1ngA51IKnh48mVOg3Wd+MltkJDZp
         JVfSIDc3ED3Fs9C2RCZMYpLytMjWqZl/NyrQaDcitjrCKTHA1FrMK9QghObURGEV85dc
         L52PSZsE2jyxc2v6NRcTaBWrSGerVKWNJeC1t3Ix4OApCxo6D1UrQrTzP6Px6v61XhYU
         4amLTJrknFSrXOERw8q61dZfEcO5i4Z1ub2BSHHUIoe1DK5mjIUru1Z+8V5iwG8MtcYp
         EpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782508483; x=1783113283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzPMI/ztIJEqjrr282mCkQC1SOAWRFQb64i5un6Hqvw=;
        b=lo4khSEuvfkMkJYytf+dMv/PDx48cpYjmP/DG3neSLcEZjixqSzSY6vZjz1giEJb2H
         /Cu6Ug9eZgYOyT6dhgAcBvZg9GpPJ2V5ccTTtt0CiXxChxkoSnpX6iPaCjdWEvHBa+B7
         0278whahuuF6qG4y9cPO23cTDGreLhszyh5yF9Q5rBO/OMRxtmwc4Tj+nymveqxr2CCN
         JpjE/NYy/AmSGfftxNaRP9LQxM5NPavvWNRvKPfDZK6Y4bduuU3ml78smFLahkGFKyQi
         c0JDBdauh+Jv9tvkLNGBpIPu7s1+A2j6egcuKc45mwMRcznId8znkiFh44JgUI6GvIIS
         2r6w==
X-Gm-Message-State: AOJu0YxxrkzeP2Vrcv36lM1P7qBhH4AVFZ5uvQRcafovsDW07rgNq10i
	RklTaeBri4a4aNo+MzbvcTotG7aqpNWdV4kxTlYOTeKwnlsc6HFlQRCu
X-Gm-Gg: AfdE7cnAD2PN7UJCoUE2qJky6qTomcDqIJvSXIva7ccg6Gz/OJf7+00MxqCKlUpZb47
	LoM6KzHfD1hceg3JjcVdsUOfJKLjQl7DmxIHxWfHCiGNbkvV6MlDKqKjhFh2yEjcpqTWx/NjFYh
	yNxfv3V7cDq3hOmQDje9YM87mXcCpCeTLtEhBNXEIOFYEj27Q2jQUyMVNVTdpNvhOAM/fPgDy3h
	mch6bZ+QDSnbbfq2Q2KAuRGDF974JpaKPHsKZQ+4QQB3Qk/ihJZ4K6bneiEB1HRJGTsKvBsZHlO
	mL0eFInJDrzYLA9tYwkbxOU5gpuRydPAaplK0vyg0caGYbYvbWSUEDi9oFLT6aMm1j74sZznm3b
	V1koiwDMpy2nygYqHVFFC8Tdg+48eIRoEUJYCgrL4IXZmAz+mOtgPnBO0Fm44r55ghKDvGg/yzd
	B/vOHVPEBS0DrNUJrDW9gk4caBCU3DXVcyRap7T8i3nU36X51CvLD7ivUMPircEGIPYKxtxRTpI
	NjBJtHAD8/i
X-Received: by 2002:adf:e00b:0:10b0:46e:65ac:cfb3 with SMTP id ffacd0b85a97d-46e65aceae0mr7128474f8f.1.1782508482640;
        Fri, 26 Jun 2026 14:14:42 -0700 (PDT)
Received: from localhost (20014C4D24E33B0068A1174AC0C38AA2.dsl.pool.telekom.hu. [2001:4c4d:24e3:3b00:68a1:174a:c0c3:8aa2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01c3bsm29639774f8f.10.2026.06.26.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:14:42 -0700 (PDT)
Date: Fri, 26 Jun 2026 23:14:30 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, cirnovskyv@gmail.com,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v2 1/2] dir: encapsulate excludes_file lazy-load
Message-ID: <aj7rtj9NsejqN357@szeder.dev>
References: <20260626075037.532164-1-cat@malon.dev>
 <20260626075037.532164-2-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626075037.532164-2-cat@malon.dev>

On Fri, Jun 26, 2026 at 03:50:36PM +0800, Tian Yuchen wrote:
> diff --git a/environment.c b/environment.c
> index ba2c60103f..8efcaeafa6 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -134,6 +134,13 @@ int is_bare_repository(void)
>  	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
>  }
>  
> +const char *repo_excludes_file(struct repository *repo)
> +{
> +	if (!excludes_file)
> +		excludes_file = xdg_config_home("ignore");
> +	return excludes_file;
> +}

This function has a 'repo' parameter, which is not used in the
function at all.  This causes build failure when trying to build this
commit using DEVELOPER=1:

  environment.c: In function ‘repo_excludes_file’:
  environment.c:137:51: error: unused parameter ‘repo’ [-Werror=unused-parameter]
    137 | const char *repo_excludes_file(struct repository *repo)
        |                                ~~~~~~~~~~~~~~~~~~~^~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2922: environment.o] Error 1

Please make sure that all commits can be built with 'make
DEVELOPER=1'.

