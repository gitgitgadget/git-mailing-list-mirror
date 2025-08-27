Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4315C158
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257654; cv=none; b=Hia+2qKWb41V4BSnGiwM1bnMXKslHgwhH8qSy2q886cOeGeBvoEFhY1rtNQ84do1+z6JdKWMjQpoLjrKU1Nhe3sDnQSFPVk4gnjmCt5MN1HiQkLegXCylZClYZCHsGTecRP/MiJAyZS4e300MlRIhPKtSdizuJKuMA4UZTOfm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257654; c=relaxed/simple;
	bh=efEGn4cH2atZ3eEO6IsB+uVkKVDAbS0QFb7GQFwelx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UikrcTNVyTbqwGLR373sEjXquHVpl7KvKinHOawuLkIEpfjQnnmCt88vuxw8tajzSmlJxhPZw3ocD3G+QB7BPGo/4QvslsCrbEBo9RpWzeuuFhq5SsVyybexEkPhNKZ1gqNigOi2bhxZlisM7/8V5M7L9zH7Zj9ktAR61N8hJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WphSgpU3; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WphSgpU3"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ea8b3a64a7so21199315ab.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756257652; x=1756862452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=neO4ZZiAEuPhylijQrvPs0G3Oiqee9xVKFdwE/zu4A0=;
        b=WphSgpU3NPAqOqHGPxVjWTnEn04jy+zXxGSz1STmRGd4B2YCcVswtfcJBfsm5FlCTO
         kL5gsxDMY54cvbFhwZajLkL31a9RWIkoh4RRNPw2YcC7U5DbFls31pW/Y8lDq8p0urfU
         8DAb8IAD6JsM+aPiakgflUZJn5UT3tyAzqwTrNpG9c6u3UWIQvBYRDgV0dwIlWC0PSNT
         3q8Lr38nFCB4APNVKejb8AvMDO6UxoBt5EXbEj9GkwUjtUuKCAiscQ5SUEKCnZXuOxox
         QaNGmQQYai6TP5kQdH/WiEHdJzVTg/HJYOqo4Cr4KKDZDTma2HzccTlhjbeuiCXGKKi1
         OBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756257652; x=1756862452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neO4ZZiAEuPhylijQrvPs0G3Oiqee9xVKFdwE/zu4A0=;
        b=DhJ4/lsFhhI8rqL6H3rA5ZWy6LKwYrN7/hAF+q9KjX51uWn7dnax8yuMFxB1vM6uSM
         nzA+BPJVMMoi+wOq4b5IeodaBHKlvU99nok+Ah1hNqptHpi0klPKmHtMvY7kHO7yKP6C
         80xdwg2EvjOy+0V5TQnfmSpzQsj0YaqYGvns2zYl1YCJgdjV3IYdWwxGSmC0iG3Xtf33
         zbXJmS7+NBHIOL65BGQrYec4lvVswVQsveTqaDTgohDTXW+ZF1bxEbgdKD4KAZ0eKJBX
         QNIf+40Cyv8/m9EsN3eBgve/TXeu8W8eUFJEETlVNPL4/9EgRrOkXUwhjiI5F/W26iRD
         UqNQ==
X-Gm-Message-State: AOJu0Yw479XK8pnZhytoBk9r6vxjSVzf8juYCg6Rr86sQbzeDZbBsYUk
	8838OPU4lZQHEaPP/wj/IbCrezk1fbOYXqRWfMFBqSZJmqw96W4Ep8kJlKI3TOnXsA0=
X-Gm-Gg: ASbGncvxWJ/uuqhcsonEDKPFGVd4V+pvl8DFQrSh6IrSKeUCbXmX+f259SyhRF6RBVT
	ipyJOV2+ywtvrzS5llMHunCgRxNvSbyb4RmgI8dhlefVXivZ6upEsny00p5aSzjy4xVzPoRzwR8
	8XTWRWJpMHEgTH7EtPuR/DVy1tSxli08+ZqrA4zRH++utHLIJ9Xsk7qXtSCFYbn6Q+szIVO2WuJ
	j28K/RifTRRA2/TczLBOZawpLBESJjJyvG8kc3mqWUqJ/iJOUngZGeWwtLAEg8eTYmqeaWzQ/Es
	dTbe0UPPNXHgrm0HTXe+slrifaunlzAdtDjuzxqnp0YHy+N7i57lXQETVkhBVuvWKQy7nJ8iWE8
	/14LN6GO5DXGCfs4hsHIuyk/t5oziNi/dsKV0KyxF/AWsnwbm5lABoLdWvAyr/Nz/1kLJwApTaN
	h192bFdfoBgIs1v47arK2NxiFbx51ZL+gaQKiN
X-Google-Smtp-Source: AGHT+IGPNuI5XEGKxjZ5dL4rQde47kXGmcliz8Pej+1lwwq5YE56C7NpWPvh0tYkupuoL/dvFWdEtA==
X-Received: by 2002:a05:6602:3c3:b0:86d:9ec7:267e with SMTP id ca18e2360f4ac-886bd155520mr2876878939f.4.1756257652106;
        Tue, 26 Aug 2025 18:20:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-886cf7a8c45sm613994939f.15.2025.08.26.18.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:20:51 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:20:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 13/16] packfile: move `get_multi_pack_index()` into
 "midx.c"
Message-ID: <aK5dcpG+U4LTp0Rl@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-13-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-13-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:11AM +0200, Patrick Steinhardt wrote:
> The `get_multi_pack_index()` function is declared and implemented in the
> packfile subsystem, even though it really belongs into the multi-pack
> index subsystem. The reason for this is likely that it needs to call
> `packfile_store_prepare()`, which is not exposed by the packfile system.
> In a subsequent commit we're about to add another caller outside of the
> packfile system though, so we'll have to expose the function anyway.
>
> Do so now already and move `get_multi_pack_index()` into the MIDX
> subsystem.

Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  midx.c     |  6 ++++++
>  midx.h     |  2 ++
>  packfile.c |  8 +-------
>  packfile.h | 10 +++++++++-
>  4 files changed, 18 insertions(+), 8 deletions(-)

And all looks good here.

Thanks,
Taylor
