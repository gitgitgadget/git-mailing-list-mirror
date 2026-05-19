Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2311A3A3E98
	for <git@vger.kernel.org>; Tue, 19 May 2026 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234688; cv=none; b=pypIV3Yh5gkbffe5HcuZBXjbrTSD6o0pSGe3gqCmMT4LSjE/xC3Ee5Rs/Ak7y7ImOxLFOddGuYps9S4zF2HA+WwTLI78BYGDbW3vW2EWGiIAopnoOpXj79z/jBNmi8rZGIcrqGyV+6Oh5pE/4SInW9NDNJmzbe85yz7V9KW7Ipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234688; c=relaxed/simple;
	bh=2mdgC+YpCslF3FO2joTBd2mumsRLvvqooEpAAuHfJCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMytz56uO8aPTBXVw+kuHaP7iocg/7cKFeVHDRUpRn++9+iQHppHW4/jG/vthKMN6m8hj3Bmz6EDn8/SpWodRlwjAWNlZYFm+ks36bv3pYJhGUmWBiwjI6ldP1WiiP11llNIHrhoErSduYkTh/QA7qnuinif72zAruKPMXjTy54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oHvCyAjd; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oHvCyAjd"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bd5c773ef3so36608397b3.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 16:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779234686; x=1779839486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wclxKX5lgceIp/bZRALrtQ7eFKzyXD6GjkV8Mpnoi60=;
        b=oHvCyAjdSBQIweicjGOIQIL5YBwBceoF//MtfvVxBh6uW/byl5gHB5X54fM7X1LYW+
         8dybPd48PrqGBdFa4yu5zr0MUz87xVEpYxQfKhjjuYerqKufDkQ5s4OpBDf6946yXhHe
         45ySk946hCH4hQdZbn+X/tcM5B+WDyZY0HSCiUKyeuC23/GW2+JwtRQw7QJFdHTgXJd9
         GY5qzIKtprqj146tsklE9bhJmPiCZsFEGjAnWHA6D3M9TLZZXLktK1ukdVkgyXzCpngq
         401qpRWszIlzWU0b4rcoFpwRiDtWY1oPJ4eufGrhFyXDScYnaom5GOaW71yyBRrW7O7+
         aFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234686; x=1779839486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wclxKX5lgceIp/bZRALrtQ7eFKzyXD6GjkV8Mpnoi60=;
        b=C4dk/tEFMli/MurTmrRtjdN290B9HSsJ3btxtg4TUhaeoaOH2cPtEKuRqUH1wR2CLv
         LM0sVD4AUqziCSsVidraVDrLChMymh2GxH5AO88bfTcHThbMjZYvb+0wOYAnhn7zipqh
         1GrjML1/1/HIHV7jXqb1WFwtcuiHBhZvCWFskkKfW71vywDOxHcc7xh5/0dlA+e8nxKI
         EjWgtT+7TgirBNT7kgjjQV82jfAs2I78evpyjHyBEIxkRWpKDrY4HYAiucAp5js8Ymuo
         4zF1A2XXT4xLZWcJnpogJ+1HQFjBsjCxazEWc0zekzp7Nqs4thxepyzDCeQ7yExIM6Jc
         dM/A==
X-Gm-Message-State: AOJu0YwyQpEvtIRP8SIs18T9/4qEvHyPz2OY0Z16crAMqHdzqtKRvVc0
	pCVwtQ7c5ylhmfvUobm6ZgHBhWvam843sdE+gu9IoZHt1R/b0uLNJ/JPch3pfeBSSFk=
X-Gm-Gg: Acq92OHO7B8yZFQV3HyQ77F+C7XV4YzpF6JtL1dK93Hrs7XXMJRRkEtsQLK4GzpSyc/
	iySY1ZBOE7rljdBBA0F5xqgPADr9jiYdBL0kV3BxtqcBv1lHaaKhFU5uco1YEjo7miSltMNyq2w
	4EkBGNTU7yCPumA39iPq47qafYZTagre47Xh6kdBdnQhcbnU+VqspOEGmCdirPxejgqjmD4OfbH
	GGUvr7p2H2aG2Tx4U+9geyc3KwuZCDYZoSn4jX7ALevs0K4+KyPZfrVk+KRhsG2a8fUTeIJg5ni
	rThTpi90CTISJBBw/xGoYlDpIWrwNjvSKlxuo8gPGcLNzSV86Wx3Q/J1Iopcw0fp/rBl/1mdOQU
	NCM3vi+tQ1Lfq/kjHGQb2ohmSLB3xJ3YHM/oFtxl7sZL2HGGpXHy37yBrsolXtM+teFbMCYiTot
	Ywg+Tt1Y84ILA5Y+HCOo1/9siFO4Bw4z8Z92UchC80aou3tm/i2VKTv1AHy6v81zpNsKIHXveYl
	NESJpRGkRg3Lnwd9Eo2GtP/K/vHEXfWbQV9N5i5YmGPod3OKFdxPaWkRMAFVC25gF4NWOc4REEX
	r4+hMKIIXxbvWtcA
X-Received: by 2002:a05:690c:86:b0:7ba:f3a8:7a87 with SMTP id 00721157ae682-7c95c2f7f9cmr216053127b3.40.1779234686116;
        Tue, 19 May 2026 16:51:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cfbc6b97e9sm14025207b3.45.2026.05.19.16.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:51:25 -0700 (PDT)
Date: Tue, 19 May 2026 19:51:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 03/13] t/perf: add pack-objects filter and path-walk
 benchmark
Message-ID: <agz3fOHvVKGLMxgb@nand.local>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
 <fb8a0f9c43d4e41712839a93c4db6a294a7b5285.1778707135.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb8a0f9c43d4e41712839a93c4db6a294a7b5285.1778707135.git.gitgitgadget@gmail.com>

On Wed, May 13, 2026 at 09:18:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> +	>depth2-dirs &&
> +	while read tdir
> +	do
> +		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null || return 1
> +	done <top-dirs >depth2-dirs.raw &&
> +	sed "s|^|$tdir/|" <depth2-dirs.raw >depth2-dirs &&

Ugh, I think that this was a bad suggestion on my part, since $tdir
should be empty at this point.

Could we use --format here like so?

    while read tdir
    do
        git ls-tree -d --format="$tdir/%(path)" "HEAD:$tdir" || return 1
    done 2>/dev/null

I guess that breaks if $tdir contains a formatting atom, so perhaps we
should keep the spirit of the original (but using an intermediary file
instead of piping the output of Git to another command).

Sorry about that, I'm not sure why I thought that was a good idea when I
wrote it :-<.

Thanks,
Taylor
