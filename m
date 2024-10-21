Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4054A1C9B8E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540137; cv=none; b=LrsFu4QzBQi/u6EFg6bIukKUwBJzewM6AjPLE+Bo335e22m97QdxIwI1o3YQo1Zdl+gTLjg4ru1xviFCbNAvhpqCnqe6Mto9lTJCfPShnZq8m5v4rf/C7L3lvV8W/1G3rpR/Smmv+uux08+eVZIoi8mXDff7bzjwzJLkot/HXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540137; c=relaxed/simple;
	bh=0ULXrDxEGGWR5L1SJYKFJCUtv5CdvMoahPddkx+hFx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f22wyuI9byCR58JqxhdrJiUL+cCHb61a0J0e/tRoUVtWON761iAaVw2Nzf+ROmLmhiYh2t20c1HO13MlEzee4N3NjK2Kz7CSXYISFP28ClVOvkbEDdHQp9tKcMEYDMWRELt20XMV61nbM19dRRN6AAg9KD/LyLHGfhJ/4iD2Rm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Qbg9FZFE; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Qbg9FZFE"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e5ef7527deso19235027b3.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729540134; x=1730144934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0xiwwsaDBAonLg85pjF3fSiKBp+TFs3ASPbGNolYqE=;
        b=Qbg9FZFEtgnpLLHmkv4Z0jSVrHbAxwzXrrKIg67sC/U4VNRTWtETT2VgBMiDsW1T99
         Alyh/exmyqJCZYcT24+kAp3Gd4iyZsln6BZHM+ucSdSrOvv4diQfqNJEVzICilSUXej4
         Y2O5a4voV2OGbSxF63fCk6Tr8PA5m6m3MKWFePGREZxCgN6ApdvewAPsy1PKIZO/yW7G
         DYImg9bSTBscDGNvC28cInJTTu78LJN1oCLZSWWJbOugpj+XRT5Mf2OVSv00uerlDy95
         tuTrEP6iioETj1ZjCk0D26Cngbq9CZH5XAuVJnDStNWWT7u9+/T3nUnEp8cYeePOLcQV
         NyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540134; x=1730144934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0xiwwsaDBAonLg85pjF3fSiKBp+TFs3ASPbGNolYqE=;
        b=g3TfXW5kwJOPCrrZ8u4F3eQnsnZYbdxu6S6HMfeC2dYczKE5hDpaYVP9FgK0776Tc4
         oJa5uuXslEvLUrv7XBy3mtudBB8ZnKecncjS6FELbQTEJAvXGkIFnuQWL5Cggh+Gum9W
         YHzDhiP2UT4RG9WN4OEMLpmmI4tCHtnTKnQaH2VrFW+dm63rJhDgtwZRaTGglFN6IJSD
         0F61HjMpgDKX/znb63OVZ7PmKxrGrQ8PjIvOGVptv8N5PTJPdv3jahhXnx1ofuRld2qq
         BSlA0c8aBtHxhHxncb6TTtzblyN5PCxouy9xVtzPE0PRYF/CGwyHdYtVIhdSZOksI3il
         mNxQ==
X-Gm-Message-State: AOJu0YyHlAO0y9iB/suJGXD5kzYyiqe92Tq22qWOZ68GCBrh0eRkIsex
	geNvuJMd+tcoXefFygeUxWxFrprKXFz36PYMDbem4nHIh+pSTHS4DlLheUtdpVc=
X-Google-Smtp-Source: AGHT+IEfbCG9/H1j3hNoqA4cTs/r1o/MTHwlawKLjG4JmUR1dSdNuW+ezRL+6ybvuL2PesUtRTBtAA==
X-Received: by 2002:a05:690c:38a:b0:6e3:116c:ebf3 with SMTP id 00721157ae682-6e7d82aa161mr2022177b3.28.1729540134093;
        Mon, 21 Oct 2024 12:48:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f56d8sm8072127b3.8.2024.10.21.12.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:48:53 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:48:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>, Piotr Szlazak <piotr.szlazak@gmail.com>
Subject: Re: [PATCH v2] doc: document how uploadpack.allowAnySHA1InWant
 impact other allow options
Message-ID: <ZxawJIYrmoGnhXgj@nand.local>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
 <pull.1814.v2.git.git.1729355997353.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1814.v2.git.git.1729355997353.gitgitgadget@gmail.com>

On Sat, Oct 19, 2024 at 04:39:57PM +0000, Piotr Szlazak via GitGitGadget wrote:
> From: Piotr Szlazak <piotr.szlazak@gmail.com>
>
> Document how setting of `uploadpack.allowAnySHA1InWant`
> influences other `uploadpack` options - `allowTipSHA1InWant`
> and `allowReachableSHA1InWant`.
>
> Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
> ---
>     doc: document how uploadpack.allowAnySHA1InWant impact other allow
>     options

Thanks, this version looks quite good to me.

Thanks,
Taylor
