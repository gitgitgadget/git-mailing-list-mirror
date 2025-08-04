Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA27218AA0
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343767; cv=none; b=n1tRcDMPUTMQPpNmb4NNOceoxOisLgRmpfq3fK9g0sVnxSr0X8Qz1BZ5rRB6n+qOUTMHSJn7apuZaWlc2wtbANmnp0vqV9rUqmaM07OufaLFq3a9Sdkd79mdyiEB5jfAVACaB0nwb265Ez0xthiBiAZa3tSChsSda2sGN1MzgnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343767; c=relaxed/simple;
	bh=AOnRlX2g0K9Qvnmc70+iGKKn7nFEYQ9VkN6hgVIX0qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sE3aF7tBz3KhEq5YqniAOw+2u0z6+yp3KQ6eh0Cnh/I+LCFloGc/2vI/WZ6YHqiykk4kP7+SocYcCPXdVLoy5x1oHnlgdvubRrii9y1NX+vDWJl6D0geECeDczGa3Uj6Rul+RwBGOLclu3FY+l+a1bVGSDhDNJ+3nAjXDte+P+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VCYrkoGg; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VCYrkoGg"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8818be8d6e4so55810139f.2
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 14:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754343765; x=1754948565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOnRlX2g0K9Qvnmc70+iGKKn7nFEYQ9VkN6hgVIX0qs=;
        b=VCYrkoGghX40WgemV16DdtA0qk+ShJETv4CPVdstv944ODxfWWbrWP+55cqiAJTqXq
         pZiFkg71FbMU0KMsxvmWpX1Cn//+nDRxj1lqqwDmlJeXSVSTaYeLGUeHjYuy7iI7R/Vj
         UJaK/qq5ldfqWX2gc15WJRyNG5o8w426FRq3n+gfiYSAlS3glQFsXeapGZ6IYmg5qV0m
         ma5QVa+eDwRaRV+XelkXsKTO2Mlh/vmOcOxH3dGpRQ7yvqndNFfi1Du4i3tmMIVOiFeC
         J0A0LsSCQIdOaWz6aaEAN5rXU+PV8dhBzEk97hBi/MDeZo484L91v279SLfTaw+DifIG
         ISXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754343765; x=1754948565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOnRlX2g0K9Qvnmc70+iGKKn7nFEYQ9VkN6hgVIX0qs=;
        b=cdaqfNFE0c27JVJRS4JcNwMiUgaqlU/Iz5sK3PS+wxispGhC5LoYoXoBKNEErz0mwV
         X2rjSwTsjmLUObvhjM9VXsuneYl4am18ksjGMmlJznyrK36eMs7VVy+2xMZSMo2eBv/w
         cqbPGeByR7mgt5PZWQLYCpT2sXBrTQsmzf7iM6DLjn/wMMZ853CwOOXjwiAMB/1rEv9D
         DzUWgFqHNxDg5qK0rJ29w43hF1Ksew4OgW9dLH7NHdAsyM5Q1mac3RUARX3fAABoZIlV
         4hSJ7sqHaivFZLj/ia5NSISz1q8Kb10GpJ9XkJhGy3ooV0RIk0+vFWJzlZc9rgsSlU2O
         8hFg==
X-Gm-Message-State: AOJu0YzmJXGV7IkMuiGl65ry2ZVBML3SIaLU+vomDJBF6jIlZwpNe7PW
	Ln5ARz2lDRr4sb7tNjbJ11J2fpagk8L3OrykpqNQoqVaxLOjgE6x6LWckf9alv1dBO/W052Y0Xf
	Nt/DG
X-Gm-Gg: ASbGnctaD62DyBDtb/qHB0dS6Ebi+/n3l/Mh9mPKbo/NCM7JjaYn54HP81SoqfNvP7M
	FL/dWsbFIGv1iXC7NGxWez5e9qqf9qAdGV2UGkRhTa62mH4rXCGivgyv5FDKuIp1JkixjZfy2Ta
	pOCADv5oXiSWcoNs2x73X/Eivy1kNIK/5XCos3YNpLdqyyBFWXp3yWxRJShcejFnqW5k9WeIFZ6
	nVuJM74OSD0ymJ0TfzkQtrtM8/FCqOXg5ls+6OZ3Y/iuzBTtwd6/MNwtW+j/IqJH5TRJp+FZxnx
	xeMjymKX2VSLQJ3SvMipxvuc7rKfJh5KD4OQVFP94SdF4GndVjwYVcXCyHJlHZGL/47lRkEYkOc
	7MNYuwD6E1dS0FBcCNtyaUCrnxyMWk2oL3UGLY2KcKf5Pf/mdmUDKntbCLBi4c9z7CRO2MmALkd
	12XAun
X-Google-Smtp-Source: AGHT+IGeopLM+NQLZ734nlycSUTtK6pX/TIItgXOpSvLAXyeln8uOqBvh72jYYyW2Pr8Tx72mMf5aA==
X-Received: by 2002:a05:6602:6d14:b0:87c:31ad:abe2 with SMTP id ca18e2360f4ac-88168327832mr1831613339f.5.1754343764997;
        Mon, 04 Aug 2025 14:42:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50aa413bfbasm830940173.101.2025.08.04.14.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 14:42:44 -0700 (PDT)
Date: Mon, 4 Aug 2025 17:42:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
Message-ID: <aJEpU0VUav17beOt@nand.local>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>

On Mon, Aug 04, 2025 at 10:17:18AM +0200, Patrick Steinhardt wrote:
> When writing a new commit graph we have a couple of counters that
> provide statistics around what kind of bloom filters we have or have not

s/bloom/Bloom

> written. These counters naturally count from zero and are only ever
> incremented, but they use a signed integer as type regardless.
>
> Refactor those fields to be of type `size_t` instead.

I have some thoughts about this, but I see that others do as well, so
I'll refrain from sharing them here and instead join the discussion in
the sub-thread.

Thanks,
Taylor
