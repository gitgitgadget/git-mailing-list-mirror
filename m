Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FEF2727F2
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758751124; cv=none; b=LoxLsnDRP/1G3/fA2m1JhuN2LheL5WYi7Why7cJWaLpnX+z5SyuF2MgZQvTZ+Ji/Ni9lx3t7t8tS7ddWfg0JmB69Ac0D6lyig0eEAyBCyw8R1cz7xxVF/xPlanrT09+s2lATF2JuJDUw1yswRpEbmRjDvvIYHEajFpR223dhJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758751124; c=relaxed/simple;
	bh=nDsjCaMp/W+oxmkyAW8GxF8l04Q5zSzxZVm3Q5HVl9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdxQz5+2r5G47Ep4x92NxxFb45R4pKEHmFuS/+0dXHGbO4oqceMfi/DgAYqD/wHMdX/DMLCIfkkpOdjLYu9diCOCQ8dGwB1SsaZiaj8r0KDMrD4Pj3spE+ofWKx4lYAsDtqe+MROGH+U+KqGp9dOU1samjaeq3zanL9AzIPWJxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlZzAtaz; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlZzAtaz"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-35bdcaf79e7so217882fac.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758751122; x=1759355922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AYXBjr891Cq3sFPcSKnTXEkeSc137k/t79i4n47dnvU=;
        b=JlZzAtazIxbJ6O43XZSLFSel7zdhMwuJ2ONIePwQ9YSId+uWfEi2pzZEeNaBx4wmuL
         Mk3r3zXB1H0nhPDqIP8xUmP7OQYAD/Os6HKqA/GoZOCpBJWUYCGHz3Ln/iUum9oeAH3m
         PvSk+Qm0REXbyKtI+ePeGPY6yOXTq9ZwNfxFR3i/ooNetQk/QqV/f2L/Tp23x+6buzD3
         khMLw5K674hME52a4XhZZ1z5D0xj03tUmlJwdaCnZRwiK7bpJXwIb3lATrTMGI6yZeg9
         Mt5aNlhnG4YkUzhM7C6R/neRTbFDSEf1qyGJGYBHjv0yB41MZXKw1aYXzhyvVDfMO2LH
         /Xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758751122; x=1759355922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYXBjr891Cq3sFPcSKnTXEkeSc137k/t79i4n47dnvU=;
        b=qq3T1B6IWRJMeimznWt0eJCHP/ErAdfEJ8hX12svLPaPg+FnMgRehkVfQuqiZnsurF
         jWHl5wxt3u3uF/+ZvjeElLZ7EJY9tq8KuVMO/MU0QZW+1j1ACeuV1xvKJQrXuNSd2yIp
         NAjcMoAnGhzSQmH3TnbqbyY3Olky3BDh7qLD+M2c0nJCbpdFhGTUNQm0rloRQPfop38l
         J6uemzTZR0B/M/4M86cYhNOXDftUzMAEiC7Eci46ZHM7ifZIID6dx5quHUff3LI/cILe
         EnSVdmhoilU2J9IXiR+UfqNu36N4iCq6oaOZqjNjd/AeFZ1xdr6j61g/TlCHWiVjuDg1
         i/UQ==
X-Gm-Message-State: AOJu0Yx73Vx+OtQlK1Hn0vb08/XV+IGbiMUeJoD4InSI8PNDCj2Xrug6
	akyRyN8l600QOcRtO+fqCeNHmss5das7zoWWovO/rLVpLZOlphRfxJeS
X-Gm-Gg: ASbGnctC2VRVsSU1cfbKCOVTuTrAMEEKw9mvKzlCYuio5ysppke/aN9O0SR1W0sn80Q
	LZb76mDCxzDMQ2nnil3JZPBGFe+rzGVpc2664IHkWjpAo/SRwhw/FuK1I5WNVHWxTFKoFjgAGuW
	FfkIuQ34dMfstEx7QI9ajjX9gxyPR+x/ejtTCknyiuz3iqVNvB0IUztECkO218PXEi7H5TH+R7x
	1KH81efEgZIOg4wy8SvQPrWuo8VBA7eFUTWkViu0BsxkGp/W148hOHrc+Its9qDUhu9iE6jb1M6
	XkIwANP0I6znr1l5GrIF4ooQRgUWnL3gvE7LKu2+N+lhgCHMEb4gOonNgWZZhr22Nghzg4rfxb6
	hIMGvnxb5D3/ScUSW
X-Google-Smtp-Source: AGHT+IGTa+VMf+e9HkQvGoG5ltpLk945zFjwQvI5U47hk6YfuDSxeOhWdvRqtvaeZBSkfz9MEBjltg==
X-Received: by 2002:a05:6808:1b29:b0:43f:265d:fbcd with SMTP id 5614622812f47-43f4cc1f8d2mr752766b6e.9.1758751122224;
        Wed, 24 Sep 2025 14:58:42 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-363b51637a2sm24009fac.29.2025.09.24.14.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:58:41 -0700 (PDT)
Date: Wed, 24 Sep 2025 16:58:40 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/15] packfile: carve out a new packfile store
Message-ID: <c7njxu4uouqmaudci43lbfm3yk52qffrxvkw3yyhmzmcoy6ogn@ukd2x2emlkqd>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>

On 25/09/23 12:16PM, Patrick Steinhardt wrote:
> Changes in v6:
>   - Fix a grammar issue in a commit message.
>   - Update a comment to reflect that we access `struct packfile_store`
>     in "midx.c" directly, as well.
>   - Link to v5: https://lore.kernel.org/r/20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im

The changes in the version look good. Thanks

-Justin
