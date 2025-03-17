Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E91A2846
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247039; cv=none; b=sHQEfgxj5od6JMAiNKObITVlgu9SYDYb9lwgb33eyqG6YoSvY8gURpFV5dj9wPD2A/58qgLDjrEAjCjs39KrwBXJw3cr+6QTyZ4/BoVyp11mBm5bH63FJt8omZ+GIxegm9AIw7kmSsEFiwOnQ4aM0iNMxax0yWs9NWnyweoH1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247039; c=relaxed/simple;
	bh=YuFXXp2TzYWRxlAfAirw1G45G9rRTN2LiUKBJ1Zyuzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2v8ZajG4ccRhKjMpJnSnRBuYKy34rEW8RDyUi7jxbHl6JPDmXxCLEHqgTIHbXRGxydWZ1qko4bzBPl532EbR+siOCyDJFVK3oWszLtLlwi21PakmkPWvqy3nJAyJj97RDLqUOdeEyZuH/P3vXHZ0dPOh0wWoMo3ujE9V0Dnb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jPtilc39; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jPtilc39"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f254b875so45990786d6.1
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742247037; x=1742851837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi6owohDEHGXSsu00RNwTg4jrCHgzKON2iv8M+DYCNE=;
        b=jPtilc39b+GkxK0op2ZKs4Nbo3K/Bv0awB765Vrvu78i4NRHQoQEnMr9jyKQI32zFD
         5S1hXA6fchn25yOLmEG5CEG3D1NGLZ/qaFpStPwxomOyaAC687bz3N2p4+Mq62uyS/CB
         l1VZ7ehY0EFqAC2GrqnulaqmRx2OJHtJoKEZcA2XHJnQvEXMJAoT1qMVxKxycQ/MRSGm
         WY1JORjr/3/rxoGg5r/zC8vw7YIBrv0xnFfQ9ixbqHob1+mAn3y4mYf70fdLrrKyviyA
         CNJn+QnZx/w6AFVbzonwajM3us3tt2NJHrp1dJ9ASV+i9/VoM5n352QFebapopk1B4cL
         qn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742247037; x=1742851837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi6owohDEHGXSsu00RNwTg4jrCHgzKON2iv8M+DYCNE=;
        b=gh3tOthVq5v3AP6ukO+4uWJdGs02tJ1VMMg8hkNnbmD7q2cE2HvHoYURafJO0DUZEM
         RLN6e0b9/Auu5G5XgRdJX+tipdAbTS8xPAv/XXqsIVqLiJtji07A49dXYRcIQdmbo+Gl
         xoRpWAD51PNy3ZFl3IDbE16mJ6goK98d6Wuiu8qXYEu3hV7p3oMXg2xvZpbBXDD2RW0h
         HgfJGUmsu2A49jyloBEF3tJ26YoC29hKfN0YOM0pa2D+uhm11SC2M8G7Yg5kh7Pw/rXy
         xLVYFt7XTgvLNR8QSSyXF38C3zJerSqL22ror/BTPK2yF1J5AQyHbMIKGfG+niwmjsrP
         a7eQ==
X-Gm-Message-State: AOJu0YwlKhXa2VKBDLJh+mPviIKOlWqggAiP5dhx/v+4haXvfUUPtL76
	kMRhjHOdfIX7H/vuYwWGOyd5dGW5CxGj6JyP7pk3nvZ8tbXg6lu3F+OjYLfqD5w=
X-Gm-Gg: ASbGncu8KavAVp+pex7JyOEijKHsfFBGHyPXs3cadLCG2aok3GGBwSXNJrMP6OZ7fyE
	mtQMj/wXI1EUbJuSAKFIc7bYljW/vRgz2BtCeSWVRmup8KoZfGCzDX485mXlVRz87egGJlNErTd
	+Sr4smjU6UzK55GMWr0V60Gj4QIlTGpQ994rw9d78xjHNDL1Y2ZdsPB5IFj3eomuE6SDseHf86q
	sFviSQynguiN+2qK8uUW7xOv0SUI0HExlT91G9ITFDczZQJDrdLmkxeA8Gwo2ZsRc8qeN3sRZY5
	JXO6kOcj8G//B96Cy56MN3TNH6Cmv1wVbOGTHjzHcEAswO0ueUSvAbkBvpJA+EakwKJBxNsF0lL
	Q9gbB9DHHoOC7YsLf
X-Google-Smtp-Source: AGHT+IHBmbJjq26cFesR0A9veMtOUkzU2j7idqx9xBpwPd3N4TMqjLOt4xcn4urv7Us2zKr+0O3y4w==
X-Received: by 2002:a05:6214:5009:b0:6e8:fcde:58d5 with SMTP id 6a1803df08f44-6eb1b952b63mr15191186d6.42.1742247037175;
        Mon, 17 Mar 2025 14:30:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade330e97sm59226126d6.83.2025.03.17.14.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 14:30:36 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:30:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] run-command: use errno to check for sigfillset()
 error
Message-ID: <Z9iUe3Hg30W5LFSZ@nand.local>
References: <20250307225444.GA42758@coredump.intra.peff.net>
 <20250314210909.3776678-1-gitster@pobox.com>
 <20250314210909.3776678-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314210909.3776678-3-gitster@pobox.com>

On Fri, Mar 14, 2025 at 02:09:08PM -0700, Junio C Hamano wrote:
> From: Jeff King <peff@peff.net>
>
> Since enabling -Wunreachable-code, builds with clang on macOS now fail,
> complaining that the die_errno() call in:
>
>   if (sigfillset(&all))
> 	die_errno("sigfillset");

Hmm. Would it have made sense to swap the order of this and the first
patch so we don't have a DEVELOPER=1 breakage (for macOS with Clang) in
history?

I think it's too late now since this topic is already on 'next', but it
occurred to me idly while reading this patch.

Thanks,
Taylor
