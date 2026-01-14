Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08431379990
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426863; cv=none; b=MPvVLu0YVLN46E8kQ5KIRTq4TLLFw9aWBxM6pmQ5a0N/X5aznIfwY2EtRfxgTJxcE8MRSrowR7stYi7XbGL/ciWpOFg1yb+GRxheXJgBDh3QCJrlU7d0TtItH9DsjofSzXDr6aFzMifW5BXq2PzLvc1V1LfodNSrVNzybZQMEeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426863; c=relaxed/simple;
	bh=UJxKozLXqlIIRZpXaL6leeYaLqWSxubOZHWOTD63K8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8nNWGA3rOOMfszEONHArbAXKxn1f2r7sbDQB77vCadAxWfjNnrSxOw/UM4jw6eD4SsheBxjA0e26N7y6iG42dmqzxMlmpUvFAvcNLbdIiEYd3uiVPGC80Fb6ddH7yydNbbHDOz7BQ3PSv27KpyCzZ0o80zRM8JpBOLAshN0x2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=mE8a2Dcc; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="mE8a2Dcc"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-6420c08f886so285826d50.3
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 13:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768426840; x=1769031640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJxKozLXqlIIRZpXaL6leeYaLqWSxubOZHWOTD63K8o=;
        b=mE8a2DccHZJBJe7NG4v6MgVkegIKFofmDbvsO1C1VvyfbFDvi0QcbnmIC4gINmgY03
         qQ9g8rDLDmQUWyEBYL6IR8k6yVRl0MLCqbvFZwgYF/JfkQWItIHvY6usS5Ns9E6bCp8N
         NsFOt2MuwlxVPXvdNKCokR5/HS54ERMdzQ/xkGe0qPi38pWleM/8I5M7u7JrERMtpCV7
         HoWKRMGZROuOjUBrdbXICw/o0OKXtabuJMQ3NNdG2Z6KQtA6YAcQDo30YFATcGDjBhgW
         8Ndfxe2nCfuFMpJ6OXQJIJqwrxagMOubDjM1ESbUFozTlYrFeQYlwrsLzUiqEg/KYuS4
         eMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426840; x=1769031640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJxKozLXqlIIRZpXaL6leeYaLqWSxubOZHWOTD63K8o=;
        b=VZOtrxlFS4Sycge2uKeNlXkJg4wSda7B2g9h1BEiZ0dzuwbVZOv8v4K6Xzasz1UMyi
         eJ2atcigB0f8uRYfO6qKgfD8Ad2gg+eleU0RX+rnEOPEntDYYhkl+MXMkf43LSqK5aZu
         sT2ILWFZIKQZ+4rgHsfXKQhThTnqddbmM/j/niQ4gcR4mbt4J39ZJrlr/hr5qrSAiOhr
         xDyrRvzVlLsCNPPD608q/qhO4Sd2DBVkzB+Yb8SkUvMRgv6++c4GTBTBBxAMDZuPF29W
         CCRRgjpKwnZjgOAapkltS/QWxSddlq3uhthXtMtPg9QizBu7C2G/PYe1dYvgLDSi9lpp
         0BdA==
X-Gm-Message-State: AOJu0YwQAfG7RugBb6+QM18JnM6xqnuOevtDu5UGDlpVcbB5PyZtZw3w
	IALt3wMQ+1ie7C+Br3ydzRtxiCBUTyra/SPF197K3SOJjDU/et39FM8d2s54vIlD5e4=
X-Gm-Gg: AY/fxX6Zf17aug/aEgDicLhYBMLETlRp20SCo9CF5hTjxsDzchiR2vt99/8ZXTPV7Mk
	TaZMD0yrp436fiAL3PbmDZpPb0j9D3SHXUK+G2dp/snO57W3ZFOdd/aTEU7i06HcSv+aP82qrnt
	oD7TLfI3S8uEFZD5l8Vscy4oCoyAnXaozl2kKowWq6WuaNuEzxGoFSnyeKI/7xgt8WLFhjApaNL
	327BH//NGnVuPdonkIFKPCAxlZyPDsP4wd3gsRV4l+dmQKNyPI0umJfbbhR1aFQrzfkcF+3F+b7
	G3/9WWJy285I3g7Z2JecC3W5n4Vq1tnjkkwZW8905iHfRKgVLeZEtxq/H9X/Wxc+SqkE2riFXcv
	I040SYNs3fJJNc1ank1jCBoT+4NMat0EDT93GYYhtE1sZ6vw8tr0DvM8TL6iGVopPP50nTNTZZ0
	RszWXOf03Q2XhXrYE0yYGzC2g1q/QaF5o1ZnpKhEbwFd9oCM6lpIaCT86EWSUJ901PQ73L5snpu
	shpARbGguB3cPUcMw==
X-Received: by 2002:a05:690e:128d:b0:63f:ad22:f0a6 with SMTP id 956f58d0204a3-64901aa53ebmr3315768d50.1.1768426839502;
        Wed, 14 Jan 2026 13:40:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b262fsm10961975d50.18.2026.01.14.13.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:40:39 -0800 (PST)
Date: Wed, 14 Jan 2026 16:40:38 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 08/18] midx-write.c: don't use `pack_perm` when
 assigning `bitmap_pos`
Message-ID: <aWgNVjCej8wO85iD@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <315a0ea2985894f5ae5f166bdd1685ce0981fb23.1768420450.git.me@ttaylorr.com>
 <xmqq4iongaoi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4iongaoi.fsf@gitster.g>

On Wed, Jan 14, 2026 at 01:13:17PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > But the process is completely unnecessary in the first place: we are
> > enumerating all values of `ctx->info`, and there is no reason to process
> > them in a different order than they appear in memory. Index `ctx->info`
> > directly to reflect that.
>
> As long as pack_perm[] is permutations of [0..ctx->nr-1], it does
> not matter, as we are clearing all the [0..ctx->nr-1] range anyway,
> in other words?

That's right. The contents of ctx->pack_perm here aren't so important
since it doesn't matter what order we consider the pack_info structs in.
As long as we see all of them we are OK, hence iterating over the
ctx->info array directly rather than in the permuted order given by
pack_perm.

Thanks,
Taylor
