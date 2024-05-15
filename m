Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303E15ADB1
	for <git@vger.kernel.org>; Wed, 15 May 2024 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805961; cv=none; b=SUiepPfxl5SFrAUrGwY310bJbljKiTqS4c/ZxDwHr2FtJcPvQM3UVIQK9wPriPplj4K8Cn9E0MjoEGUxegUL/zG/8/KrpPUqBUGZUahyV6/doy/ESlvipOAIewpg1+6ukOovF0t1WQ9lJJk+5l9++E7jkyGRlOYr1chydxjUpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805961; c=relaxed/simple;
	bh=eb28Jm0O24NkFKHcm99+DgylR5TK2nnCIwJiJmSiG0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQn35gMWVUjl2qaFZf/TEXF21FcwgKu9Xkd/QIpP/mpgR7COaIespJwO/2mtvpjzK/ThVt4hQ11U3NrL39hMGa3QuBmQ/i9ZeTv/C/qM8I8Bd5ClQQaRs+KfTIMRdOVQTEGMcQn4TtNxMcBD2SaWdMH1oZ6kxKasiSsW8CcsxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2h+J1ji; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2h+J1ji"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23d1c4c14ceso8281fac.0
        for <git@vger.kernel.org>; Wed, 15 May 2024 13:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715805959; x=1716410759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wsr1+M4C317US+mpbpmbNgiinICjOpn1yekl2nLN9o=;
        b=Z2h+J1jigwXHfzc+0z34BAK5WJVImjymAKXP4irBKRH8oKB1i0XumyYE7GG7rtkLQW
         3Xf5TLxUib6LxF2MGNvgaIpXZShizjZ5DL/JuD6u5pNVO6DZ5fLs3DAK/EYNkOX/we/Q
         Vuz6PAGK2iiksOQ8/Yryy2iuAXdE4MR41X9Q7VdWHECnIAZBg4eIqU5N+jgrKpoFJAUk
         QsqLch/sFTHKIpziaqNpxpOp60cUgxzVn89A52ljijv2iLCvF/KG2U3Rbf4ZUOVrXWTx
         B9kscDt91QcxcM6BzKJiKMOXZEWm4wpW3kUaXhABcnhuCW46Gaxr2H2DDVfdI2NXn8yW
         /uDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715805959; x=1716410759;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wsr1+M4C317US+mpbpmbNgiinICjOpn1yekl2nLN9o=;
        b=SZSVXgRxgDbXDwqRZTZunG60viE5JcE3vdpeak4g5wYMgCYyJ2xwMljeYSynM2sXZu
         xNPxdXX6YxRBCzskE24TRTrM7UrUuRziAY6+FSnqglJNIgKYyc942t9vp0qIn5UBxma7
         eoJB5rkyuCcebaB2337EEjPBIHpKmIhuJ4YRunvSidDpaQ7FcIYnXITXQ55NLOiQtKim
         7TuhiF4bTSEnipigxhqZPvDZfpv1i7RZ4kDPhzoeRO8ga/r2SkdkD7bbJSOjB7lByxGu
         yBBNEZy//sTQWpwhhBkg85mlaMrp8ZTdrJQGGqMD/GokkLpwiiULzMqeMUnztv4JvXql
         yTgw==
X-Gm-Message-State: AOJu0YyiyrDhGmqFLNl7ODQ/EkQlKTey1ZHJaL9YEw1K9hBedXD4QsRn
	m/JHUBgYt76B9mlW5y5iAu+GrLWbnrfF7Ff87Njfr6GvAl3X+Oux
X-Google-Smtp-Source: AGHT+IFiVgNADocGYDMhBfKdexo3XRGxdfplsTIZ7zK+1NyWY9bu52ZOvdoW3pHZmKt9R2r/ATzA4A==
X-Received: by 2002:a05:6870:c0cd:b0:23c:52fa:8f9d with SMTP id 586e51a60fabf-24172a91c20mr18524614fac.20.1715805958780;
        Wed, 15 May 2024 13:45:58 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412acd6272sm3200008fac.47.2024.05.15.13.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 13:45:58 -0700 (PDT)
Date: Wed, 15 May 2024 15:44:29 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Karthik Nayak <karthik.188@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
Subject: Re: [PATCH v5 07/10] refs: classify HEAD as a root ref
Message-ID: <z5q2mk7c5d63gapkbeeuqa42sw2txbc65zmsgmel6u7llffrlz@yvkrj6d7xl3u>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
 <b719fb7110249e88b80e0cd9943a2d864b18d0e0.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b719fb7110249e88b80e0cd9943a2d864b18d0e0.1715755591.git.ps@pks.im>

On 24/05/15 08:50AM, Patrick Steinhardt wrote:
> Root refs are those refs that live in the root of the ref hierarchy.
> Our old and venerable "HEAD" reference falls into this category, but we
> don't yet classify it as such in `is_root_ref()`.
> 
> Adapt the function to also treat "HEAD" as a root ref. This change is
> safe to do for all current callers:

I like that this change gives HEAD a proper home now. :)
