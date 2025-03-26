Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611E137930
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021543; cv=none; b=t5XR9u2utaVpGKLKD3pNT+URCdoKFzIF1KmTGSIwFhW7Nm2Y0VnwTZNcCBQk/bAy0lNNXyd0UJgLOaIm1f8tsrYTaxl6+2J9MXIObKoUJj9GLvsWxU42MoRZOZItcvC11MPQctwrd4QiRx7Jt3y6Jy29FgFXAxPltNePcnBgQ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021543; c=relaxed/simple;
	bh=avvcqoduiUaYxNu9ugV1+DYJQnG6/t3BohBEoieu4A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czimddT+1xYmZMnc5DJ0pBNzXXpCXyJNA320YL26uflpmJ6PIZ5mYqJTKerazK45al+mG/GPtw7i/Vn36NWd40F9r41pbA9WgFE42A43Uc/I0D4wHTYSqCRjcoFRN/JR4rLjT3s5jeS/m1xVbcXy8n8i82feueAcIDq4YHwr7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IHO5ZE0g; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IHO5ZE0g"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5675dec99so38203885a.0
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1743021540; x=1743626340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=avvcqoduiUaYxNu9ugV1+DYJQnG6/t3BohBEoieu4A8=;
        b=IHO5ZE0gS4spJe41obwbV483+L7NxYBO5xDGFHgg5f64Ls/muK4cNVxEkG+trms0La
         SebY04slTRRZTRRQ0tikRdD+zwDvNG5nlZrg7bls5wUlKEaebx3qESSsMI5B4ukZ0/fK
         Lp1UvVZ9qA0LSSPcyk2jDG6bAq6/XU0WPxYq2LB/E0Xy4uqdu++pCEn203sB9lpYV4G0
         +zw1aiGuUKB7shDmlrFQdSYWo+LUkrtHRfj//R55PIv3nbbQpv8XFe0dg+wkdcv3AKk/
         D0DwFfGqltV/+17pdmu9Ik/V3jIwck4heWm626xyQynUGnjazQ4D87oQAdKjIGTdE+IT
         jcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743021540; x=1743626340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avvcqoduiUaYxNu9ugV1+DYJQnG6/t3BohBEoieu4A8=;
        b=vAwORo1N8nmGWsYyiqVJg0aIPkUeOBG8BHUZH2p7YweeCFEnfrYo5+0yWIKWq4/oF2
         uZyqjqYcFZrAnIZCKkWeek0IZ5TXD9Ff2ZG3baHxW/KcwsDxXmnti7sCXKc2m7zVMtlL
         5AQ6CrOiNcUz84zR3Al/QXODdGJlfZtnymRztj+GdTBTcWdzBkB4MbL15lRJxtbvPvPQ
         Hj+b4iUlZdt7e6f1mNjhhZYLbZTaXTttMePukkMIEoUBtsz4qIA8C5HQOOToKY3m6kUN
         +2Gp9aDvAWOuOjeZOHrIWk0DNLJWlBDb6kX6wFmeWI2baAVQ/wWCn4CyLJikHYFvBCKZ
         w8JA==
X-Gm-Message-State: AOJu0YwJ8UKNgXD7MjRmEnh0QqKiXXyvi3ZhFNaAx+13e3hdBn04ukIR
	8e/XGVh6bFDy2SqmNlZyuronXBC+ZqK59rX22A0F/081rMIt+qX/BlrODpaon1Q=
X-Gm-Gg: ASbGncu3DrVXc5TLW0v4ldB6q/p7Ek2FzRYELXw5cEcBoGVt4dGShBFjkKZMu8dNImi
	hnWVcs6HonjcWyGNwVeqeJGz9/RhR+MZlKzxg0JvTapu6XoVZj3vRJS4E7WU1yNALl/DoTu/JtV
	uoVsX1ov+cYzV2pAHswBc7oLwmFPVLp+pbRuZ/PgkObLmDCxozZS6NTqjBERvIGefAAtE8JrcCM
	b9BnYrvv+7SgqYky6tfx6r+0f568zw0g5LTuBqcy1FckMQrmbpT+A/Kw5NtcRh+Y0auUGI81+Ot
	ftlwofDg6aCq+38TL8OjOEDJBLMLMRfdH2RYN0xN+Z4CELbo1zH9YkoyT0zzX+JA5USKOWopnRo
	dVnbdevzV35QKOBFm
X-Google-Smtp-Source: AGHT+IHNcnEeFCRtXvOThI0bKbURFutZBZ0yUHqsY6Dt1ZATBMcsji6araxl8yq8Nx9F6lr4bdrttQ==
X-Received: by 2002:a05:620a:2942:b0:7c5:5cc4:ca63 with SMTP id af79cd13be357-7c5eda7ffa7mr164782785a.38.1743021540460;
        Wed, 26 Mar 2025 13:39:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5b92b9af5sm807102285a.6.2025.03.26.13.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:39:00 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:38:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/8] Introduce git-blame-tree(1) command
Message-ID: <Z+Rl43VR3ErE0Bu4@nand.local>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>

On Wed, Mar 26, 2025 at 09:18:24PM +0100, Toon Claes wrote:
> This is yet another attempt to upstream the builtin command
> `git-blame-tree(1)`. This command is similar to git-blame(1) and shows
> the most recent modification to paths in a tree..
>
> The last attempt (I'm aware of) was made by Ævar in 2023[1]. That
> series was based of patches by Peff written in 2011[2].

For what it's worth, the blame-tree implementation that this came from
has evolved significantly since it was originally written in 2011. Most
recently Stolee and I worked on a version that uses changed-path Bloom
filters to narrow the search, passing un-blamed paths to their parents
at each level of the traversal.

I wonder if it would be easier to start from scratch with the modern
implementation rather than land this one and try to build on top of it.

Thanks,
Taylor
