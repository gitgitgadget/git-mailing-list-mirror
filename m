Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E12586F7
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228114; cv=none; b=n96jnOpVLqNqCgb1kMsjmaIlWqF4OjRAHf4a6XGydK51qvRh5zcF6B5yXTPLsRo0aNg1x4hg+/4L9Lrr+k6WDQ8X4+nrDs+GqAzsKgpitFzf1LG0kKQu93ftUVwplzCqFQRfNnDh7TmrV6wR9BVj1/F1fB34lggdeyBa7gJsjCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228114; c=relaxed/simple;
	bh=+yUdbUVWlcIu54YM6NvbVJDxmo8B1/357fWaX7Do0vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3f+oXR/4iAN7IVEhMhlmAk0vBS1M5o/7jVyTsM2tlynjIC51sYeWQI4vlndfdk9Lf98sqRZoXYffqzlQp1/Zv29BtLMBvtMAHptK+Chk187sp/ASMqCDpV0jzzIT1ohzgH3LDm7idQtrHTBkTjW9ixNR9jIp9YYphWy4YGi3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UcPmpIi0; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UcPmpIi0"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5b1c4d14f2so4242042276.0
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 14:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1739228112; x=1739832912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAQwcheTXl/3G3O9AfS7sdLYibmK8v1VycHGM4DgDC0=;
        b=UcPmpIi0Yx/2oa8kVQKCBpvN48T2p5XgEmSiHr0pb5E+picv9DXoB21atimV0tWoMU
         WrFbsOUk/ZFDY9G65VWXLqdaXLNVuKyTE8lIzHZrYcD7phg1qZDA0M+BlkCQJMIE+lwh
         8pmlH3vjdIKnOWAAoZZPl1xvqOza0+5vc70IacvCMIKW2enQkNibjiwRWIQZ0hzwWjfr
         R4IMEZakXwNBHgulbXEhVFF3zW4KyClx++jd/T3eTKbhyVb5vD0bTesfE9f6BQOj3S2X
         J8tgPICgEUZjie/cX24gOWJKqkmetlXN/DFlVuLfjcjK7KHpd3Bj39dPTSgTekvRniRP
         710A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739228112; x=1739832912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAQwcheTXl/3G3O9AfS7sdLYibmK8v1VycHGM4DgDC0=;
        b=RYd3qW9YEWMkVq7qOn+rCbP9ukXndoQtRojfRTBgpc5uP1th6S86qJYY2atPK/xslj
         L6dWEWTpSL0hYHNFfQtPqntX5LpxNxmLnaIsmdQs4zRSnnZ7rVV6HU88tohYaY3WvDkp
         uNNO+qDu7SODZtC91/aWx4v5M+p8lvG7sD/mQIRpady/pCEXftUdzMgQDsIerjKutHx5
         QIZqgUckCUweOvCm4YIfQcTrK0eaW7USdBacOSKb1ybxoHs8jG9OvHrO9KYvMkS7uw5Y
         aEHRCW5H82/dDSV2axA04p0Js+6XRySEL/ggqGGzJgQ1VOMtGPRuvxUFeWKNhWBaLoGw
         S0sg==
X-Gm-Message-State: AOJu0Yy1xWl0V27ADpqkKpJWGO/TxCSPQI6kXciTLwKR+dhBlPC0Ri0a
	BMdDsPIcSaHN1h+T8le4UJfqDaW0wsDhESHu5MGkh8NTNB9NGw3fnApRz1TPISM=
X-Gm-Gg: ASbGncuVGoWzjKY5b/NzyKPF9ptX+KDfgHjUGN8QjK5OSrTHxRowOwExLX2j3j/FpRa
	wtD+7vrT+Q1xN23EhYWLE/s7yy9xbau9PpYw9MltYAFJ35wvvqoAfePr0b2eP+O+ZoxKVpALltf
	rEPQQbQx+ct0NaFKsL2kjHVkchz/X+h1cmbvxT/Wq2iRZuuH5rma4iWdaVjatp71XwXcOVvIFs3
	XT5m/ja6LGcFD7IqmJy5yhXenJWBUuoqnI232Z6dRhoveZ2B4kNntDchbjVKEgiCXAqYORqVg8R
	eg/H1yqGvm69QN/9I7WMir+gvQQc4oZPMxQ/rFVKrjaSgr304XuNSJhV6Efnfxk=
X-Google-Smtp-Source: AGHT+IGvtOykl9TRO8MN3fIMeFylo556ZoidBH+4bYDlBQjo43IA9aZtVtWynbgIgHl2oAUJt5xEvQ==
X-Received: by 2002:a05:6902:1b8d:b0:e58:30dc:615b with SMTP id 3f1490d57ef6-e5b461c33femr13837580276.22.1739228111826;
        Mon, 10 Feb 2025 14:55:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5b3a45dbfcsm2872440276.38.2025.02.10.14.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:55:11 -0800 (PST)
Date: Mon, 10 Feb 2025 17:55:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] hash: introduce generic wrappers to update hash
 contexts
Message-ID: <Z6qDzscMzRyoIiz1@nand.local>
References: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>

On Fri, Jan 31, 2025 at 01:55:27PM +0100, Patrick Steinhardt wrote:
> ---
> Patrick Steinhardt (4):
>       hash: convert hashing context to a structure
>       hash: stop typedeffing the hash context
>       hash: provide generic wrappers to update hash contexts
>       global: adapt callers to use generic hash context helpers

Catching up through some emails that I had missed, and this series looks
great to me. I'm really glad that you ended up pulling on this thread a
little more, and the result is quite pleasing.

Junio has already marked this as "Will merge to 'master'" in the latest
WC, and I have no objections to that ;-).

Thanks,
Taylor
