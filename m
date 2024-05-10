Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2813B7BD
	for <git@vger.kernel.org>; Fri, 10 May 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377812; cv=none; b=ae1cgzETx4wKMU8Kc2l6fhDzeMmpt3PX+Ji/xUu+y5hrzNHi1dt4i2Votx6fiqyD+qiGVf7w/e00sR0+mTCgGqEsryVsS7CgvThIy/gko8A0MDokCXb7Lnrv33yIR99HzRmGQy5hX8l5mgQEdpsw2PRaCXerI+UUL1O+ZXXXKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377812; c=relaxed/simple;
	bh=bw/y2DKU7voORRVqDRJkhtHr92kM2lw/HIU7wephHL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/Np65r8mJtlR30ZHs6+Jund8k1qRS4hLILrjT6RVvl5IsMWra7rc4ZnaRdmIGkqoUQILTw267bd7aNtys0caM7OaB2k4f8weYv8wjie4GBVIELQr/igAK/edK7coKFU/GF71RGpmVirpI7XnojmTNJc8ABGrUbSnKRAfnMEvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJUXrMJo; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJUXrMJo"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f0f252db4dso348842a34.0
        for <git@vger.kernel.org>; Fri, 10 May 2024 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715377810; x=1715982610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3rLTRD76C3Uhr9EUCdV/AKpiH8+G+4bozdD6hKQiaw=;
        b=gJUXrMJonTdDsFDoVSNj0hNOcGfHOuWscOjhwnl5+eWo3h38dXLMrPyUjo68YMj3J5
         fQZJP3ldotIsOQHBb9MrUkywqUteABbw+G1D4QEZrHEtHwysQ/RxqunEwwaJZTN1W8aH
         HidvSUnKj4RbUO+m2/qHPHoNSNxoe6OtbkqV9zlsfRlqJUif0F29cmaAh8SorfbDTopd
         DvqzvQKn+gpJorDzJddgfkPfw0CyNawk/uQ4a0rG05X+4WgjBXvgfXHC6aVV3CjVoi8x
         0HQSeCCvY2/uo0RdW6FbWViz3ocohfeWooG/UbKV/uJW1ZZpF67DBmBrwJAKshshDdcO
         psdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377810; x=1715982610;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3rLTRD76C3Uhr9EUCdV/AKpiH8+G+4bozdD6hKQiaw=;
        b=K1BfrLwAAHqteZWcXs5Iq1Mg5pFe0CuC/0VD1UWA7afrjDxaUwmnnykeesnVbC4Y4z
         vEuf+wEHEg7+uDQIfaCriqOMQNIIW7NvYBFi0jZZuTalRI8RWtsLeXtZWsIT35Hcz6Zk
         mBhV5XMzEz5+aGJnmFtyEZHAHYKQSqy3nS1x/ypAOSE/k5gVMst6eT2rBu4stvVypIqY
         c9+Qv8kl+Z0rG5r955pfyWSnk357e7Q0dEcFby8r6hR/cvMgMD/ikDyNGWKlBXfu6CnB
         D98W0ocbRKz8aeh/VFX2wb2PwgmJhFh+wMrArqsCNZXkrrE3k0FdHr7bpJMwslx5hOn4
         nwXg==
X-Gm-Message-State: AOJu0YxeGKDfttuH3qzDClIDQnzfQiUiVXu9SrkXLA8HlNsA2I9mT1AP
	EoKdgHttiYL0GtfsAuHeCPhYfkbSgP8FeeVm+1pH9AyFua/nEcGk
X-Google-Smtp-Source: AGHT+IEwVnHvb2VuCmqEJsfwpPcbsCYK52A/uhWao7PmG2MYdrzUFEqWVdu5MK5Pf2SC6odvgQ4Pig==
X-Received: by 2002:a05:6830:19cd:b0:6f0:72dc:ae61 with SMTP id 46e09a7af769-6f0e92d0aaamr4111009a34.33.1715377810383;
        Fri, 10 May 2024 14:50:10 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01b6d01sm838090a34.24.2024.05.10.14.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 14:50:09 -0700 (PDT)
Date: Fri, 10 May 2024 16:48:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/13] reftable/reader: adapt interface to allow reuse of
 iterators
Message-ID: <odftefkdt65kt4qiptd4tfnlssymmv2wnpzz4uefq6sxycxdsr@b5jm42ulf3b2>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1715166175.git.ps@pks.im>
 <f688f8f59a05b667b4f4118b7f8c7504bd33329a.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f688f8f59a05b667b4f4118b7f8c7504bd33329a.1715166175.git.ps@pks.im>

On 24/05/08 01:04PM, Patrick Steinhardt wrote:

> +/* Initialize a reftable iterator for reading refs. */
> +void reftable_reader_init_ref_iterator(struct reftable_reader *r,
> +				       struct reftable_iterator *it);
> +
> +/* Initialize a reftable iterator for reading refs. */

I think you meant to say "reading logs" here.

> +void reftable_reader_init_log_iterator(struct reftable_reader *r,
> +				       struct reftable_iterator *it);
>  
