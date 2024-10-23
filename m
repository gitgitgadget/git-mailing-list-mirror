Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C8083CDA
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709823; cv=none; b=QhPi3vZzuF65CTu7jPYa2nXUCRnaJ1PQOAIf5R6mNpqjQm5y84aycydqyx1SiZgSu9PRJo/IfOegROi0iXWjWGRliRZjqrDj+raLO0Fp7N67fhcH8pupse+ZEP2OtoVD7QaThDeCwLoTPYs7bDiU7NQyXUJY46f/6kufoDPw2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709823; c=relaxed/simple;
	bh=wPeFxWZHoLPpG572JwdRH1slxmUydmKqb9yauo/GAqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfIg83N734FdCE1aUhD+DB+fLEQBL8EZVvQMppfhZ1XWjCYdgyRXzT040qcqQ6MImyvsFIZKTNzZm1QKjbmvyi7APi8e6HGcVIQ0wSCeGcCUC1jrlBL36nXh2zy1zN6W7+6EW7mcpyVLniuTzZoqNfCB+h78KMznXCJlgW+6w6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uw4TceAs; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uw4TceAs"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e38fc62b9fso685387b3.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729709821; x=1730314621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPeFxWZHoLPpG572JwdRH1slxmUydmKqb9yauo/GAqE=;
        b=uw4TceAszwhOdGrD8c+sf3U8o61au9Thi1eh+rBQI7RYueF/NvmJ6pEUhy/1sJCHJ5
         YQJSruJr8GS78XctXRKMMoSR9WlMxte213s0jnw0JLoRBtnysZxuLBuI3EDQu401/4CA
         lOiz22Aa2/K0Eu99vcH75cOlxSD633lWy32T15YuLgrnQ2nGHgY8PXXvm4NiUq6KHzWs
         1qFMFuw1EOqbYYwVS/VmGMt4DYvGYtEYXE9xOz4PT6FsQiE9cd9l5T8neiCNRTpa6Tov
         hA6ULu1AHVz3CghcHGFdr7zDLCL5//H275DkaAeP8/uj1Qn+vEolN3jZe55zovdiehfe
         3tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709821; x=1730314621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPeFxWZHoLPpG572JwdRH1slxmUydmKqb9yauo/GAqE=;
        b=W42KiuyBOLTlBNGHjtFsTaivaeC+JVmlvC7nDkRNWhUu02DCW+Or6P1uNDUlu0Ylfq
         kfQ2/WF+2XKXBv4YZNeN5XJtyIubx2t3Iv+w9gY3mu90jkAu5j9DhuWf9+PpfuI2HUB9
         RD0J+6b2Vi6ZX3zF2fDRhlq0sgvfd9tNFSs1ZJbseXVmeYs2GQbheo3Ubb6W58ibNC7G
         tMuGfC6PQCOm2lDTiO0ycZiAg6lStOSp/WrF7m4J32ArddOuAlKTRQ0HNAzNiA4OIQKK
         fTwukHtbxVdyUtQuQYcTXS/qf9mb85j11rge2ENGgDYLh47a5x6+76j5KpQ4WA53yjhh
         pPjg==
X-Forwarded-Encrypted: i=1; AJvYcCWiPpFCM0FORZ3ISdAQWBvRpmsDrVTMHMiztzswwosNyqAB30ptmYOxtLtWGCveKi9kOmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+JfgQ7Czbf7blPKG72ghp9zQ1NUvB8orn5xPFSUEd3NnBQRA
	gJtGlb7FuJ3Dqh5NZA+oyCfroSxfdxFOUw6+j/TT45cUBJ5+q6HlZ/3Cu0ZYWJg=
X-Google-Smtp-Source: AGHT+IGS7eCaDB8Y/MZABE3wxaZ7XPt4arEijQ3+WUSmfYmNWeh2cm0wM1J484DGS9g1sr/Ej4uN6A==
X-Received: by 2002:a05:690c:fc9:b0:6e2:11e4:2f58 with SMTP id 00721157ae682-6e7f0dc122dmr37066877b3.7.1729709821037;
        Wed, 23 Oct 2024 11:57:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb6b3sm16588887b3.93.2024.10.23.11.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:57:00 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:56:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH Outreachy] t9101: ensure no whitespace after redirect
Message-ID: <ZxlG+4AFGtOBK0eM@nand.local>
References: <20241023121113.915310-1-kuforiji98@gmail.com>
 <97e5c9ec-28c7-4f37-9dae-26e4219f1f98@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97e5c9ec-28c7-4f37-9dae-26e4219f1f98@app.fastmail.com>

On Wed, Oct 23, 2024 at 06:46:42PM +0200, Kristoffer Haugsbakk wrote:
> Hi
>
> On Wed, Oct 23, 2024, at 14:11, Seyi Kuforiji wrote:
> > This change updates the script to conform to the coding
> > standards outlined in the Git project's documentation. According to the
> > guidelines in Documentation/CodingGuidelines under "Redirection
> > operators", there should be no whitespace after redirection operators.
> >
> > Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
>
> I can confirmt that this patch, when applied, fixes all of the instances
> of this style violation.

Thanks, both. Will queue.

Thanks,
Taylor
