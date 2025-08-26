Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5B946A
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172414; cv=none; b=tfhXZJ4Awi9pjL0Ajcts+/CohwtY2ls9hZDLdigZ71puuEnISUIhS3Dl3KsiuB4zH1K+FI9XYPsDeQNe1O5wWfhuyVPcyZV/OlNmMHU43R2LB/2PvYFxyCsDtsbPjMBfHttcmsIKgKxVKQKvkPZgSMQdJ8H7vi22YXkmf1Fbn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172414; c=relaxed/simple;
	bh=StZY0I6NRfFWGnxQ80MoorRKJ74wplh9htU4Uh5fNlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fR4du9b8sCPCt8A55NXwoKoKFrfr1DjT4jODwrsY74G77Ge3yOSzHQDTgObJFEQdS+0qceg5ZL6U0h/T2K8EEZJ8/1fsZ4UzzUAV5r26dkr+uZV0Aj/2l1C61045pXHCDdt+grfxa0Ovq4eUBKEvw4GBPm8hjEw/SihdKMZOAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ojYFmUiZ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ojYFmUiZ"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3eb6da24859so15483305ab.3
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 18:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756172411; x=1756777211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWOm2Nt+D/7g+dbIKNsQ7FqEiJvPydQNndUHq2LmDeA=;
        b=ojYFmUiZj/M8fBpMofeb7twyaGc0aS96uJ2S5fW9BHkoAn5Cg4+vQIrq54DMBVTsgS
         EDg0EijdFz8yCJ/iGHbo5wicnbh/SGCUDDuIp7f9LcUuBGHcUQw0wHvq5JF8UVJWWioj
         m4T9D/MmzemYOm+i7f98/kmWUVUdBXO84a9qVyzx/AyR58Q/wHvpD3xgDqGI7Hka3TbU
         dcBBogcm9IlesfjhnBuPUtYUKKpF+FiLRWtKKQaHXhh6fvf1s0bH+9dR+D94cBJKYspD
         SKVv4U30n9iALuyS/+xfpK4Q6i3zLC+LlK6H0lDA7k6AbtZCyeyBkdNPkV9YoVV/JW/s
         mGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756172411; x=1756777211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWOm2Nt+D/7g+dbIKNsQ7FqEiJvPydQNndUHq2LmDeA=;
        b=Wsj3duM+Um5BzCXaNBqePA0f8C97YKp87CtQQLpQtwyF3KaINMQWNYfMbZ59ymjYiL
         AT0l+VwvOMTBqaw8DN+7fztj/MPp+uSUvtxj1rgXJUmYyUtzHPsH18DFEiIDJjspCuVw
         eYX6UYT+JP/BglGZdV3RUOMEOm2h97dEjCBmNLUnYrDxcPWNmX08a1LeruMBGDJrLTcf
         MdWaLjvsFdLXSMWpJV0ECJrhwWV5YCCKjXsL2RF1ZaQQV8fKhXz7umYmeJmU65tumBrd
         CrAbiiH990lUe8iUlxs1gksywoSPHkJBsJjTc09SkXv6iiH/DjZqqUofl42D9S0glDfe
         +t7g==
X-Gm-Message-State: AOJu0Yyq6hLOoH5kF6FiF33zYEYJ3QzZkSVN5XmCOpe7CgcN6RTlwxU3
	A5/E5/ksN4kj1QgS/TR3S14U4T48g3hvy4c/fZP8Bxtt1McXisZoCjUiyrEmsAXfPRM=
X-Gm-Gg: ASbGncvu6rRKsW8JbpbcB7PrwmRepQcm/JLh1uMpLK2QkANKhl49DlrfC/JPoe5na4y
	iR/tDYELKy32l6E+nqwYC0lccRy2d/fnTN0D+oq3rlDS+r8rlVyzUs5znrTHNPvomNroGJ1oR3y
	w6YSaMWu1WxAF9+LqTshO9FXHzd+mMZIe1o/+Q/MhXLfDU9vTiBx3l7xjYQ5CJ+Ykm6RSuBVFf2
	ZqBEKNc5TScjawFb8ngTcloyJ5BBmIw/NfVBPO2wNCsNH88WFJMDmAnyUFMiVRgh3qT1vWc34tK
	hJ0fL41W9lpouPl2bH1XfvvevW+4edNQeJTakIqOXrQXMeXV0vDJc+DjdAgroYf/gmVJwdQBjrW
	Pbmh6fOYob1+rkJf8Rmp6IzbeUdUh7aoz2NnwaiJsF680HZpgClBbzzwaK5v6sExHkJJz3NNvAx
	PnZZPvptFdHEi+5eNBCrOgIIiSuw==
X-Google-Smtp-Source: AGHT+IG7/5wF9Nq07VHH9/fgCMuEElCt5ivk7hYljJhGM63hnOGLc07B2+35lwdD5WvCY9MoYd5wkQ==
X-Received: by 2002:a92:c268:0:b0:3e5:4631:54a5 with SMTP id e9e14a558f8ab-3e921f3be05mr234487605ab.18.1756172411083;
        Mon, 25 Aug 2025 18:40:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3ea4c190c66sm58529765ab.12.2025.08.25.18.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 18:40:10 -0700 (PDT)
Date: Mon, 25 Aug 2025 21:40:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 03/16] odb: move initialization bit into `struct
 packfile_store`
Message-ID: <aK0QeYJDIXsiwBxR@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-3-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-3-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:01AM +0200, Patrick Steinhardt wrote:
> diff --git a/packfile.h b/packfile.h
> index d7ac8d24b4..cf81091175 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -63,6 +63,12 @@ struct packfile_store {
>  	 * the store.
>  	 */
>  	struct packed_git *packs;
> +
> +	/*
> +	 * Whether packfiles have already been populated with this store's
> +	 * packs.
> +	 */
> +	bool initialized;

Exciting ;-).

Thanks,
Taylor
