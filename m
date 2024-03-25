Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1D518E06
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374352; cv=none; b=RQwwTIiJtoyTGoDf3506Hj/RiyZVkanaBsIfy9NCGEUWK8CaipZRE0gcwU8wOhKiAjhT9PuxFL7ek4Fvgg6wuBHA3v3cLKRhOKaQUICJ0AtZfgYOjrjNFqoJHB7gBJiAXFqUoFTsS2ek2DZWZYPwanZuZbE4q3RGIASCCs5D+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374352; c=relaxed/simple;
	bh=8fBEyLfhatTROYHkwiwsAiCAA5j5gmTrxYqd1axrJoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuXVP9FwjHhHo4lW+t4PTgrt1U4m22C4wITSNCs9MfBrDlY2caZylzVe+IrGMnOMCYcSq3gfmocKJ10dvCwN8RSGJtHwA+CPPk2W/YT2rAJUrXGutwXIgrTdHAoYn9Q8kpWAQeFQGb5G2y1VGmmFWaxPwEhmO13XZziTAl5sIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=skop7AnC; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="skop7AnC"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:d5de:3293:133e:f31a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id B877960316;
	Mon, 25 Mar 2024 14:45:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711374340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojT9zRckcfb97F59nI3NP/QmN2MPhorc8rs39tX5XAg=;
	b=skop7AnCCxYQKiQiYZlalEnHo3+1jc0ea8jd+r5/0oP04BRvAfjGkfITJJybb+k3y8Pz2x
	kJHZW6+8DiE5GmriBAzNhcXMlTwLC/rlJaaffNnpPKspxc3/yTcx0SwEZFPTU4nSnCTdMH
	5Bm8sSrYKbxaKT0RgQXlKMb/wAKogk592RI8JPvO3uB5ScdlLvyH4sXqFyAMQkgrolXg8z
	3Za5n2U6cG2nY8+f9WDd011db+vJIwgCr6wIzM3AcqZxfVE89V01nNs/D61gIGpk8zCP1l
	4WDCF/qyyFnun9dotifVWXiIh/xvZra/o+uNQQNGE+fm2F8kPILPOgl5ApD+Sg==
Date: Mon, 25 Mar 2024 14:45:39 +0100
From: Max Gautier <mg@max.gautier.name>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/6] maintenance: use packaged systemd units
Message-ID: <ZgGAA7uwx3aqy0pH@framework>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com>
 <ZgE2pFt-pXurYnKU@framework>
 <03513931-7070-4430-bfae-aa039f73d74b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03513931-7070-4430-bfae-aa039f73d74b@gmail.com>

On Mon, Mar 25, 2024 at 10:06:29AM +0000, phillip.wood123@gmail.com wrote:
> 
> It is possible to wait on a lock file but I'd be worried about building up
> an endless queue of processes if the process holding the lock file crashed
> leaving it in place without anyway to automatically remove it.

Side question: we can't use flock(2) in git, or lockf(3) ? The latter is
in POSIX.

-- 
Max Gautier
