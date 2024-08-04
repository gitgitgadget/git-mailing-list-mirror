Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7EA95B
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722788752; cv=none; b=marTpjuILzK+6mo3U4NXBKbJuw3JJcUurS2aECIh530tdHjNDnvsNvgKAw2dMpeZ8XiLaTttKZsYWREiIbIgvpY/oZgGbAgs2yJ0z2Yd9pfCtFRMaq/j2dV24nw4FbuA5JKLm/XiMPkDVoGIoen+QCYe8S9I5t6LoRZ6w3KJk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722788752; c=relaxed/simple;
	bh=3fzjDyAJZd+aVgTXwasEJ8IPL8B+uN8ZYyafpo9h69I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co+P/ds7sb42FZb012YKaXsj1ahvYd48S0owMU67WFzE31dkKgIjVOZrPxoIPRr3OYTygKX50s9cYauwDLsjlY9Iz1zq4Pp0c+FNZ+HOg+Pcga1ecpmtPD73O8JN8J5nT1h//vF5q0LnBZMmiwOMLnljdG/GhKg5kFntOrsaC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EWIVSzLm; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EWIVSzLm"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5e1c86b83so5153128eaf.3
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722788750; x=1723393550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWttnXRFigxPfXZA7+yZoT5fbCjxgHaXuY4iJHYorRY=;
        b=EWIVSzLmgKGxH8LVaUBTbACscfJdWcppN1R2LQ6llwDJV7BGki7BfWVCXHzOYyiJhe
         5l5OGaj1pk/AGU4itfvzrC2s98z/6EzRgUfGq1B2ED2NgQrAXKLPClPBASh9vXwaOcDG
         8C9kCYDQxddUqqBc961evIq4YozTazQ07Q0EfTRHZG02ugIseadWrZSomC7KYah114vR
         AXMLYa7aRJjDWApjyV1GjPLpoFl+XbpxtrMVcN3Kk2yb+RDpBKKGF6b+MS2uWR/tZGPK
         ktFbu2WUp/XlWixmLz9rZM4MD76tYTuAHsq06Loe1fL3++3ruTdpUkSpDj3oJ+Lmn7+e
         jEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722788750; x=1723393550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWttnXRFigxPfXZA7+yZoT5fbCjxgHaXuY4iJHYorRY=;
        b=lXyASuTWWd7016B414Put+EBFwFD1Q2y9/FsitR6QKtgdrVc7UO+XgW/UKLHye+grQ
         yGafA0c3819uzZY/hnjNOCL+dccSd4jUmCsZo87fEXpXUuRSvXBBbQdXxW/mls3swO4T
         lxXg3gBEiRfBUQ8FD9xaJR0vHW0Kn4FhSWdY1kTZ/Sk/IGHjVT7NpFgvPzb+scgvMcmv
         7oq7AI9sW5Fvu6VSNbf/LPh/jeraS9zq/24Cbx7hEAh/JVInwOGlfrQ+LpiBk5y60g9S
         wO4Hrg6YWpvfheH3cVfnApzLWxcaFQd/x9CUetug36xTrR4Dn285Ik9qgnr9yC2Pw/rz
         i+OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7jbWT9f5aoVEansyYgh6gqV7xHHs1KmMgesM2udVf6RMteBogKoKtvWHoZGTRGDQQ3KVxEnemY8klj2oo1Hi3iOBZ
X-Gm-Message-State: AOJu0YyvUH3KRBs1Fb0xQDKrKS7pMKHoHx33R99QDlwxjsVZ6ULinKpZ
	FEhECEK4iyqSxsSkoZlw6L+Is9Np04j/GKFjzchpsa4MC0tzZ6ecTYQeae+y6dQ=
X-Google-Smtp-Source: AGHT+IEqv+2eGIJSAbx0+YERRDuua148s7kjNPALPGLVJRP2244epKqyQ9ZLAkU5kvSiwoLa0Mhl2g==
X-Received: by 2002:a05:6359:7c19:b0:1a5:bbe2:5046 with SMTP id e5c5f4694b2df-1af3bb099d9mr1294115855d.30.1722788749629;
        Sun, 04 Aug 2024 09:25:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a137b4b2csm9079597b3.132.2024.08.04.09.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 09:25:49 -0700 (PDT)
Date: Sun, 4 Aug 2024 12:25:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] refs: drop `ref_store`-less functions
Message-ID: <Zq+riymYf+oKR4Cl@nand.local>
References: <1d9add71065dabb3d7bf81529d04afbcf91e3a69.1722577074.git.ps@pks.im>
 <xmqq34nmgbs1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34nmgbs1.fsf@gitster.g>

On Fri, Aug 02, 2024 at 08:55:10AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > In c8f815c208 (refs: remove functions without ref store, 2024-05-07), we
> > have removed functions of the refs subsystem that do not take a ref
> > store as input parameter. In order to make it easier for folks to figure
> > out how to replace calls to such functions in in-flight patch series, we
> > kept their definitions around in an ifdeffed block.
>
> Thanks for not forgetting this.  Will apply.

Thanks. I agree that it is a fine time to apply this now that we're on
the other side of the 2.46 tag.

Thanks,
Taylor
