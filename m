Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA16A31
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809832; cv=none; b=G1B7RBS9lUm3KHd4Lwk4MpSsnnHPAsPyM7Vhg/kuM3CtKYbXPKotUkiORDtsX9jKOimzt/ZTKzRqozzOWTpWxKRSZ4A1s6KSrMEnX79dzCEMwfy6kNWN98Y+ROMXPzdBCpONjMK23KD5heGA7JhJM6puLufR5WGJdCSFunogRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809832; c=relaxed/simple;
	bh=n8qsK7oLr6IoiAh4soFQAd1rYCRKtBLeGU88ywwrinY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO3lodEFncQDvsSgNvV91szZIzwp8jA3yEcEW7MxDNV6W+2Ud0zUrPSQRvMYC8gx1VEpFRDnzVqCfcKPMcWwnBB9Xr3Xbl+6jeJflJFlfSGn2YRn+IslxOpH0Qpd0vQHdTBOJV8PticE4bJ6FalGh2ZRGc2FzC6QpIrCq7JUxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yBhOxdqU; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yBhOxdqU"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fee63b9139so2780677b3.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741809830; x=1742414630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYHgLir5DCL/IO5c4li4ZG+j3VMRHP9z7kcejjy6gvY=;
        b=yBhOxdqU0cQkThUDlI3gcEtIwlLPVy80TM8MivEC2rW0+BP2Ald0KP2yQylAPkBhxq
         HvPz3XDRqHBqgMY8ACQtobsPIciDhmTtU29pDWAzZ3RFVvGdG8cdyDKTJqC8ejD5iedk
         dgmXI23zII3MrM6GhEyfgk1P73tI7kXvU8yJBHfcj8h0PSqVXGk/VQT6vLfHrwDul67g
         SUS45aRgKVY3v9qGWvwD7gy1ppg9skijENF3ACk4PIx8bSD+O08ZlkQBTI9Yq0s/oMfi
         IQ3tY5MV+FiqmO0Qsnnk8K8eQTK2s9WnSWuBfC8Bw1k8XLGwhsegmJDOx4ATbFaSGBT1
         b7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809830; x=1742414630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYHgLir5DCL/IO5c4li4ZG+j3VMRHP9z7kcejjy6gvY=;
        b=ofyl4zPK4SMeuRAhtlJ4UMpDUY+wRhWuXxbX19bRxKtt0DXqcdWRZSxBAnQC42v9HS
         0t5bmF9Qi2ni2feTUSyFqPpnNpGKMb4ZuM2XYddE7ji1y6Ik26E0YyCMB3IOMIenU0yS
         vXUEOfanZkban6+WiX3ieUuDgB06lFZJ0KiBEHUP9PACxY5oXVHPcVKJa3odFlUYSM0Q
         +XZuX10Q+6qH+qPW6hM688MDXRycURoKsLp01ctMSoTdOLaMORz4KRlSb6DZwAYSi5J6
         DPKnAW4/Ryu7sqI+UMNHYtcaT3HPeKJlwCBMXAttNcwE9ueHzIwJ45U8r43gz6o60u83
         UFaA==
X-Gm-Message-State: AOJu0Yy6dOAkSNprtNja6lLQt3fM8VJqPvUyfmevK4BwQha9GjrCbzc4
	R50nZJu3v5n8pFBL/ZZot94jv15Ic/jkDg6o2VDdy37/0VD5ntYSpWhv81RSkC8=
X-Gm-Gg: ASbGncsbNvDCQ76CCbbpk5tFAjBVtgpagGjhCGnV0Te/j1HZI6EmbFhf6XKJV63LSuo
	HDPMVbTQ2GDHiOGbqfL5R5bysczDX37yJT0T0eTO92snbuWxsTjxxwnDB1hXPQH0jRdH+XbsBC/
	q8cIo9dt3gBdct9ooVL0EWpCdXr9RKbBvyrnhosKbeduyWRGCxJLPs1Mv/rghC2UmRMFtfK7MSq
	AwxBxQAGrSxwik/C6eVVinkRNypPxYzoKZTD1Wb2RPqTPPugG7rHlnwLGFnLjl8DXNIWAFCtjrj
	dnPLRFohWsNgK+yHYA2Bv+Vri5drGd8iVOiVoPFOJ7zA9DSaRREcBvLqS49IYnbvoaizGiZuTg+
	ayAaQp+QoX/e9y7M3KynbCGcPslA=
X-Google-Smtp-Source: AGHT+IG5LYY58xeZ6kxaiD4fq2sh4OmduhiY5ry1vmayydRYtaYusOivWsolQSAGXcA5/Y6xdrTpLg==
X-Received: by 2002:a05:690c:c01:b0:6fb:a222:6bff with SMTP id 00721157ae682-6ff2becabfbmr13719967b3.4.1741809829834;
        Wed, 12 Mar 2025 13:03:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a51837sm33184127b3.26.2025.03.12.13.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:03:49 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:03:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/3] merge-ort: support having merge verbosity be set to 0
Message-ID: <Z9HopHJKPv7CXI3R@nand.local>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <c2a2be336e0ed7966b6ab0ef004f150537167b55.1741362522.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2a2be336e0ed7966b6ab0ef004f150537167b55.1741362522.git.gitgitgadget@gmail.com>

On Fri, Mar 07, 2025 at 03:48:42PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> Various callers such as am & checkout set the merge verbosity to 0 to
> avoid having conflict messages printed.  While this could be achieved by
> avoiding the wrappers from merge-ort-wrappers and instead passing 0 for
> display_update_msgs to merge_switch_to_result(), for simplicity of
> converting callers simply allow them to also achieve this with the
> merge-ort-wrappers by setting verbosity to 0.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index a6960b6a1b4..8021083c112 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -799,6 +799,8 @@ static void path_msg(struct merge_options *opt,
>  		return; /* Do not record mere hints in headers */
>  	if (opt->priv->call_depth && opt->verbosity < 5)
>  		return; /* Ignore messages from inner merges */
> +	if (!opt->verbosity)
> +		return;

Looks trivially correct ;-). Should we add a test to ensure that we
don't regress this behavior in the future?

Thanks,
Taylor
