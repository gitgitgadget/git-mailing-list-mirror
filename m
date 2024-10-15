Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A65D53C
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952510; cv=none; b=X7lkp9aUHHw2Jb/WvOEaWxczlQ2Ub0DHRz9ljD2uXEPVebrJjxTxyqO6Lmd4cqsJbODSF+XucEWE2ulKGWn8sj7/ctW/LaIQUX+dixkrnMf5TZvNtMJ+0LAc9UydIo7xX9wBo2pkDjkSIyfYwDoff6fT+Q3bArhq4rcRD1dguRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952510; c=relaxed/simple;
	bh=TaHLdxiAudKHtFmD/yqogBCGX/sl1hefbK/5PjntWEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzG6MK/6zfnaqFl701fd8phTLKYGyOOFp+Pt0Y6Um7VQIaUqOHtKmG8uzQBqChd0+KkzyjrOBVMxOm6upXFJyDfH6BXrA1bKQwcYAyO2djfhqnMDcNvZNM7xlOnRb3kPjV0D7p9U86XQJgXTp4FO2eI3QpsSCTgHhmHUQBr98zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=OvWkYEQf; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="OvWkYEQf"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e34fa656a2so27408557b3.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728952508; x=1729557308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaHLdxiAudKHtFmD/yqogBCGX/sl1hefbK/5PjntWEM=;
        b=OvWkYEQfXCUKgh8MTA2PUTNi4n42XT99P7gVr4lnoftDnbG+JSqK6Cl3+3SqPs//E5
         /MJxZCRtWLco9PvJiJGUXxvk7S0CkMIjm6xHBphHAn35C3OvW64kWJqy+onA0X44BUOn
         wiVdTrEk0qDkb0EHJp34unIr8oXlgLiLCOXIgzy/6yRPI54qrqbaNVhnaryUAo3TTKEb
         TwWUrMZe4nbFx+qaMl10lM0OUccIAhLwHNS0f0F0yL9uIcywW7JAV+lUR06Ci/rBWX+e
         JzPqMyZhqmMNutkyyK71IUkGEjmi2z9AvQaeAX28OluCE2YfZ/I5sUxHeil6k7nRZU1C
         aWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952508; x=1729557308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaHLdxiAudKHtFmD/yqogBCGX/sl1hefbK/5PjntWEM=;
        b=Z3xfT5E27xNy/INJsM+Oppyhnnd7q2A32wDLlR+7w++J9SSzS6+hEnMM5hxD+Ug8Jt
         Yopi0me1P+noPFaY442vop+lrJtQNCYVycKNH4gqS76/d94iQod1Da0Ez4/zVEInWfYQ
         iGUOv8A2eUfGRzCtQtvXLqjXRlJYzLuZFuzKpomzRXZBQ7wEmUk/k0945JrzchLuO5hg
         qru5obUvjWFnY6YzD98pteUU101WvCHKkxGbcUmbbiAp40zQkaVg+yaro4eZJanvoVKU
         hYxjqC6WKjr8uLVtH6UHm2uDgv+u/hDvVrHpcBEqBhRRnVLT2ROvtnrjnxgLxGzEuQgn
         TSbg==
X-Forwarded-Encrypted: i=1; AJvYcCVLMfp3H/dGHNtc4vI5P5p4Qs1V54ClqiYlvix4zgoWSvqsoCZ3pDTb1wWdTH4Wa/w1qMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbdray+dnjDrN0MOLjL1WGBcrjwy6PJJCo8/PVSr/8AiQ5sPo7
	u+Vc0ewr9wN+q4yqlDri92ms5LwScNulrwAbQl6uIxs6uyPytMTszw52My84TJK6FCY72QWXsw+
	0
X-Google-Smtp-Source: AGHT+IGByQ9tZG7gM7xx32wsz0Kb/SnAt5p+TYR4inmALC+IOVmBE+oEAtTHPz0A98DT2Z7psGQyBA==
X-Received: by 2002:a05:690c:ec4:b0:6e2:c5d:4edf with SMTP id 00721157ae682-6e364100665mr76178607b3.9.1728952508469;
        Mon, 14 Oct 2024 17:35:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5b51d9asm537107b3.54.2024.10.14.17.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:35:08 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:35:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Andrew Kreimer <algonell@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Fix typos
Message-ID: <Zw24ul77FO8fPhAs@nand.local>
References: <20241010151223.311719-1-algonell@gmail.com>
 <Zwz05AIAGLOu_EdD@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zwz05AIAGLOu_EdD@pks.im>

On Mon, Oct 14, 2024 at 12:39:38PM +0200, Patrick Steinhardt wrote:
> Thanks, the diff compared to v1 looks as expected to me, so this
> version is good to go from my point of view.

Thanks very much for reviewing.

Thanks,
Taylor
