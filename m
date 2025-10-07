Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F271C27
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759874169; cv=none; b=J7S/QEQaAkKVe3S9ZStPsYdcBKImzliwkQWI9UYap97jceg7JxJIlyy4UQNgKRam2FFa9cmgINgWvUvm5dQVI/gRpC4oF6XEHmKJLwq+nTU4peaXDXPOsUOQbJu+sm1NlBmd1uTXPigNKzT5LxM8bbYewVtP5/9XkiAM3CIUoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759874169; c=relaxed/simple;
	bh=CooHQDioWjplVSllQUNyE4yCu4wsWyPA5qWnDYSy9y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9QKjqwJHqB4nuiqAh2Mu+uLD8mu63+TQh+KCb8YoHZnZmPeZmoMF6zg/oRxfOHQRM3UfgtWwoZosRNuQuMzt4Jpb2iDsuWda8iCjNXxJFlZNE38ruEahH19mQpNC7/O25C09owZKjt7aTYAaDRccb6C5J4mWgYl4shS1SZLrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=i4HSzSSa; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="i4HSzSSa"
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-92790f12293so324950739f.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759874165; x=1760478965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CooHQDioWjplVSllQUNyE4yCu4wsWyPA5qWnDYSy9y0=;
        b=i4HSzSSaUZWGi9A3ZBqGifunp8DnuW8gsy8yOe9VRhXrPCBmMd8jA6KqabSloSWc2M
         3K46R0V/8DRQRqYOcuW5u0W4YZr66UPEVN+lCfLoUSbvgUvcbTxzULXJt8q3dJoF8vEq
         5StgCML0TOQRKiCtk19joN3q/YDKP2HzkWcQsJaktznva6GfjdASfzwrivPd6+Fxx7tU
         jSbI6puOoZq1VVcXVPzCcrfMUHKtf2QzUw5N97T4WhWFaYtYYe1DRCFJfB+dWuL6wa6r
         RGcMslBk7Qg3gfp+FRBrEpIyDjw8eFUQU94RuLQybjPjum5JqxEFWfUZLiJ0O0jjOU+r
         Zi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759874165; x=1760478965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CooHQDioWjplVSllQUNyE4yCu4wsWyPA5qWnDYSy9y0=;
        b=T7WgbVzprkmrV0YR3huU1c1YzKvKCLoSlsCV6f4DpayY2HkHo0EB71wOgclNXLS71U
         eTI3aW2+SN2MOUKTBpVUPHrZLFUmu18f+H5HNcLXtyuaCKYfjDzjXFha6Hwi4ArqS3dc
         UedEKM1CSVx6yi9GicEBLhV3/u2nhaPVlijxUtm/1OYwMJ3H19Db68keFNeIJsXhuUSa
         buosRPTMbvvFsPjw/oaErjwriQ+YdkkVIF8UYH2UOpGkgnv/JCh7Fqzpkzd0rr8VQ3ei
         asRnpOJSY2o363DHetxdXfH4T/jSGwmufmfyVIxeANFeTe6FIymKGeet1gnVitLS7MII
         GJ/g==
X-Gm-Message-State: AOJu0YweJqMj8gG6mGgEoU27f93nW6lBXKD3nEV/IwSJKWFFkvpgNI/+
	I1ZHWpoxiqnkAbPvcuRpRV7ReNogjmxZRkDWXfrWL1qRr9Ema70WmaAViuQLlAiApOAEJqhUyT8
	y3NLDJC7OToXN
X-Gm-Gg: ASbGnctTQ3v3fTNjUHNhE40znAobmvJjtJAxmjoFEV3ngS14WOdZYJVaJN4iX95xSTE
	iJOw6sQN89L3gtftfMCB0IrxSsbeOuUdOAw1weu1OfUDPsOuYjy/otcJY9WdBZeJvodA+/DA5gS
	tY/XBqi4fWBzxq6WMI/oG95CPKK6W8T7mY3ocghv3J9oQFJauuvJd9GTXAfRU22dxyRey1ZMhta
	52DcnFFjgaMQUEGVlpwPUy0EoR/CDxfpGVALdlnpJHwqJcEMooBeRKZ+RnHs1I2K0VuMvK+4PwR
	JTvB2RUGsuHYPWydZGbyMBa4rXRVvsir2qLWYntKao47Vq/UG7Yis/QqnsdFPAccaYqBev1tYt3
	CNL2RO+tWRXBgfq8o9uM7XbtNob6dDZz9mY4ppf/Ja+3qfVj1azJe3HeAuY6/ScF/UIcal3RcEp
	IJmQxJiFkieARB5x31CCCnznldu7ZhOBX7EI4VBzQczM8hnQqWig==
X-Google-Smtp-Source: AGHT+IGIqsdDsIqpsiHBllKQnrUl9QzDE4egXhzsZTJJe5qI48JY9h0y/LxdEpYA4N4PuZfmbmGu8w==
X-Received: by 2002:a05:6602:6b08:b0:93b:b799:460b with SMTP id ca18e2360f4ac-93bd1831b33mr109543139f.3.1759874165624;
        Tue, 07 Oct 2025 14:56:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93b9e8966a5sm459270839f.10.2025.10.07.14.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:56:05 -0700 (PDT)
Date: Tue, 7 Oct 2025 17:56:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/13] refs: introduce wrapper struct for `each_ref_fn`
Message-ID: <aOWMdG/vxXy6bLKZ@nand.local>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-1-916cc7c6886b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-1-916cc7c6886b@pks.im>

On Tue, Oct 07, 2025 at 12:58:38PM +0200, Patrick Steinhardt wrote:
> [1]: <ZmarVcF5JjsZx0dl@tanuki>

I agree with Junio's follow-up[2] there that the benefit of dropping
peel_iterated_oid() is worth the one-time blast radius of this change.

I reviewed it as closely as I could, and everything here looks good to
me. I'm excited about the direction that this patch is taking us in :-).

Thanks,
Taylor

[2]: https://lore.kernel.org/git/xmqqy17c3c1v.fsf@gitster.g/
