Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213DE3B0AE7
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486952; cv=none; b=hUSIZj1qtEmCzFPVqbOE1pqN2+1/lCL17HL5aFbR6NxryIJtfUvrFn2dM68m5syFShNHCdq7nsY1+9RbiPlOOpx4fwOvn/N/6ck+zY60g7TMjb9CyMgLSy2cRAL8eqTVvnoJon6NxL//avi+hyU/SgJEMIW0t3+H/F0OBVFSIME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486952; c=relaxed/simple;
	bh=kEgjY8argK11cK752aZgRaK1o7L2v25ynTKeOe7ITZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqDXpp8mw5IUrLYSzmrR9Ax2/7wkN3m3BmN6ri1B8RWjUPnbDUEWAt21uM1x5TnVkzoBRUWu9zZeuM0m7Y8DnJROgEzZKY9KRxZ/CmNzblTYxDUZXEFptAsz2Z0lPEbLNeumdBy4u9t7tS4D0CK0VClXbZRAS8Ut2NwBRAcLlEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luqDDZ8C; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luqDDZ8C"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6ae5baaef5dso331161eaf.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786486950; x=1787091750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0qhDJP/zc2xnagI/9eOQFeneLCJ99PNvoQmx13NdiAc=;
        b=luqDDZ8CwXBmJj9+4cmPBNUJhfFCI0y7hYk4mFPPQ+5cDKuEULkBOSh02bu1yGtZZA
         I9ju+/DhXCF34V/kS/Ojl0lvr6HfSsUjzNeXdFwhtFEYaEdzmz7iWXXfhnUiu+eX0MAX
         VTWtG8igxk/oRSnLTeeWiHyy1RQ+d3MFnjSYoUiKeVIvFxCVkR/mUdRNblX3dypk9/Xh
         FG8kShU+WDqrNnes3NxGwBHDt0ahpk+TaNjmMTNKvIq/kBKR48tXJ2bK1ppHkfPY+9OF
         hMNd8Uqbo5W2r/DlaMzZtW4JvVzo+gm2CZLATgk5hyZtyhH19Fn8RVA7px4Lj44UJAD4
         rLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786486950; x=1787091750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qhDJP/zc2xnagI/9eOQFeneLCJ99PNvoQmx13NdiAc=;
        b=ilIPobyE4SvYFkmmr0tnZIezt/jtJAp+cVr+U7T8xE4wbWgNEEu9ZjKqj3JTIO5kTg
         psQK2WF7wTsZ/mxfJRSr/AAllHcGstPp62UmuYlYPPc7J1slJj7+21Hes93AoaZdVvUC
         bAlU9EP6+rhr7+AD964VuTA2d5OlHN2VF7uXwq/+8QN8JRtJeinxopQTge7QMSNyIFgG
         WljCnKrT1ZluLVXt3Ozq+eIyOyD+p9buXHg1XpaJ8VvygqvgRuCJ8grrtcPB/9XXKNAc
         9ovehCpe0iWZJ08AhOxYfcxtixt7n3ChvJoa39e2om8T+dFW5dkU/QzTuNxbklva+TQz
         4TcQ==
X-Gm-Message-State: AOJu0Ywp8kTl8AxIHrESxnctkXSsGOd1EdOVRXEBxB4+JrX7Nx8B6857
	OHuMCTzgzIO/6VHefkQTwwWwNnm81GwTdmZeS/67/xB2fuLxNrCghxjysgSI0g==
X-Gm-Gg: AR+sD13X1L3iR/gbDhJsyy82Pt40GXGnWlfnATRz6Wj+mv2jcIidt4axpfPhftaXsJk
	GTjjZhzLG8DqSg3mnCE4Cg8BLVBMz4ywTtu+/jpIFW9/pW1mA+yAupTde4AmiBvKKJRO0y8Z1eP
	o2rNzBjhvzMxRyzN4kyowu3r7WZlOxLkZlTZBn77FRm55qJexCMxhCStqs78bGGPTiv/zen5eSO
	vppL7ryTvdtveNJSdAViUwNTy9NxhPqDNJwQFDgViuvUPNCjVKHOHcNafLV1RMRpVy8X/BqdcrC
	L3tgbfHouxXSaYNnv2TCP/J4+vlp0r3a4xTmq1YdhhkD+ZBNJsMvrAKpz4oeKIye3XROZIpUVF4
	SgdkH14S7vLMveH3/Dd7K72qZZxfuOrOEYi1w7yNdiP2gWXM7+z7eau9Spqvl6mNdl+O+1Gkgd0
	yUKNK1+uOifDWxhsp49H7+wimE4AxTdQcpLBUMDGcYIFCVhDNVJI4sVQ==
X-Received: by 2002:a05:6820:2d05:b0:6ac:a68c:c598 with SMTP id 006d021491bc7-6b0abcd7fd0mr2684303eaf.3.1786486949861;
        Tue, 11 Aug 2026 15:22:29 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e355aae71sm552186fac.10.2026.08.11.15.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 15:22:28 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:22:28 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] odb: drop `loaded_alternates` field
Message-ID: <anufdy4UAqoLWPgG@denethor>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
 <20260810-pks-odb-eagerly-prepare-alternates-v1-3-f0fa4a4004e1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-pks-odb-eagerly-prepare-alternates-v1-3-f0fa4a4004e1@pks.im>

On 26/08/10 03:33PM, Patrick Steinhardt wrote:
> The `struct object_database::loaded_alternates` field tells us whether
> or not alternates have been loaded already. This field was useful before
> the preceding commit as we were indeed lazy-loading alternates. But now
> that we started to eagerly load them we can assume them to be loaded
> after `odb_new()`, and hence the field does not serve any purpose
> anymore.

Now that alternates are eagerly set up, it is safe to assume, if we have
an ODB, the alternates have been loaded. Makes sense.

> Remove it.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -1132,7 +1126,6 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
>  	 * the lifetime of the process.
>  	 */
>  	if (flags & ODB_PREPARE_FLUSH_CACHES) {
> -		o->loaded_alternates = 0;
>  		odb_prepare_alternates(o);

Also nice to see this go away as I thought it was little bit awkward to
unset it just to allow the us to reprepare the alternates.

-Justin
