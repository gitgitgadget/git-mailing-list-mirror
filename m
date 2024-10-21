Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA66C1CF7BF
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542916; cv=none; b=ZFncxQoPb7HEnIAk0VxSXCtvxcn1TtfcOMcl2rzv3YElR7gsNEb+6CtGZyzquiolPNmV+ud8u9eZdNLxkzSjhq65j+LqyO3ZcjpDjUyGJ7FRhZ+gWWqj8Sx2pvNrHl5eMEW2vkC+REpb0wNskuPbC7cyCDAOhzqNdXdeo+QAzfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542916; c=relaxed/simple;
	bh=U6yH8NoTLYSqFjSsU3BS2osm3VdIR9zteokIxqo5PbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqbF4yEty9qVB+8yuutgO49zPPFJFk181W03c0vevpzxTYFjy3XOzFvYKqrVrEHeRmcYyKVfZdjKZwEVEtPAsfFk9XSm2GP6R3v1Nlx1H+8bpUUGhrQ5KUfk+4JIWT5ub/jXeAuTPhjlwSKTq1sJU6qoAGdSkoKNfez/gFebwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0R2ZVayF; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0R2ZVayF"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2e427b07dso40985867b3.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729542913; x=1730147713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7TuRdE7A/acANGicN1CbbSvMQGb0tBNUwnkIPed7TY=;
        b=0R2ZVayFNooSqC1TiS/spKIBYYVsF6RSb6lI2wmfjG794caZTRRNJN39yC9I2NJm/+
         MoxjQFbuFk2duN8TnHDtQQ3adoW35bDKJD7kOtTgwqFV42hGu2J480FC351K/Rj3x9um
         qCFoNstG0q7k5gACWedVt1Eaa7QPnfVMZMtcuyPQD2sCw64OL59ph1yup7X7OAKSIGFE
         tSRrBLJvV7MJLba28uqGHjyX39Ka/C0mYK4A321Apv3M/tpUAryGLf0e0A8epPaQoIXS
         QUjRC1s20Bf/U5d4htv5kNmMnJnIib/T/gddNQZrClLrre73suxIoVs2P0PFgF4URRYH
         Uaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729542913; x=1730147713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7TuRdE7A/acANGicN1CbbSvMQGb0tBNUwnkIPed7TY=;
        b=T3pbjR5Op7aa8lNkcpQOeNhzEJXWXU/jGsMOwcy6sVBObQlVh39ffCwFftwf3SRPkM
         Fe4USuqoigNOzUSAmd1P5eljrJgM98O0Zct+JK7u6CFeQHHRN+cF6GINKqP6qRgSLQfG
         6zFUXk8LJrrUFc75yETWxcUenXEMQbt4diSXyN/SGbIJaGhkGgpeK3f4CMIi0aH6mpJw
         guJq58u7VTL6xyInse68lxj4na3iZIthC3thKPS/QGTUjG5cJHRQrGQwVVjCDoxaXUzy
         tvxX2ZDKX1rnwOUd9PE699Io6j22sXFdN7bhSbdE/YRZVp1UevSzmHLGZI1BuZWQsPPd
         qmyg==
X-Forwarded-Encrypted: i=1; AJvYcCVF5E9Hjol4gxnbxwDoLyUjbztgEsMv4xsUdz3R7txPAXP83nhPjfK04pFiARLVtBhb5MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtFRPQDPlTZX7c7RDPzWsT3xTocd9FPvPQyrZD3thw9nT5xD/
	BXS+SC7ccNwCsXAQzf6h7h1O1VgsbuAO1kp4MdZinsU3TYQl2gURVE8tkKiApyQB6mrFbxXUayd
	6
X-Google-Smtp-Source: AGHT+IFauirNZdgMR0iv1HtAwT5QgV30JWYCH7SU/2SEGPUVe7SVgdP/LhGYSQYgnssxK/FtJdF+qQ==
X-Received: by 2002:a05:690c:6e05:b0:6db:e045:3b07 with SMTP id 00721157ae682-6e5bf9d4a2fmr123872617b3.17.1729542913715;
        Mon, 21 Oct 2024 13:35:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5acc3e8sm8139507b3.57.2024.10.21.13.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:35:12 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:35:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Jeff King <peff@peff.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Message-ID: <Zxa6/4D8lWgqqaxM@nand.local>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
 <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>
 <20241021191441.GD1219228@coredump.intra.peff.net>
 <D51R90BTHJMY.1C1XY5P4CHTWG@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D51R90BTHJMY.1C1XY5P4CHTWG@ferdinandy.com>

On Mon, Oct 21, 2024 at 10:09:38PM +0200, Bence Ferdinandy wrote:
> > E.g., I think you could do:
> >
> >   upstream=$(git rev-parse --symbolic-full-name @{upstream})
> >   git log ${upstream%/*}/HEAD..
>
> That particular one will break if you have something like
> refs/remotes/origin/foo/bar, but I get your point.

Ugh. Having / characters in remote names feels like a mistake to me ;-).

Thanks,
Taylor
