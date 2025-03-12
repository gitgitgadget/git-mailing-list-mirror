Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07771E9B32
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809614; cv=none; b=cGLx2LPi/oRfcDJaKZ5koZCAmXWf8rGR6z7+xc4A/Gewn5c1r7/JmhOedOv7nNeB2f+xQpYz5gia3izlN812pz89Reh0HRKlrVNX8mT/JFoYq2hX9WeTI3yfUp99Kz9g7tXaPeckzDO+x56llTt1qGJUzNtrULEwxWNg2cFO/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809614; c=relaxed/simple;
	bh=LMxXnf+4zzFRQ7H73AFnJy23fnGbk6fGeAvEIF9x6hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko3SzKfOAczPjhBiUtVbJ4tPkN1TT73uGL0UN5bEpf84YuW1rWM8Cj98cjLlFrIOPXfW5WzuaWHyZv3qtiFJugCVd9ydY70hQfk5C228DM2YiVAx0/8QQ6Vng/soLuR0d2xNHrpGHAUG13Hf8mgVraRfp10ULpNDieh31Fh8waI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yW3son4h; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yW3son4h"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f77b9e0a34so1672477b3.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741809611; x=1742414411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMxXnf+4zzFRQ7H73AFnJy23fnGbk6fGeAvEIF9x6hg=;
        b=yW3son4hsGdoiuUPJIjAxxNic4PSU4aIH3zA3qVB7obydJb/Z92Qgk8Z6CFSzHi5q7
         6umX4/1C62fjc1TtowO6NJoA4rTIKYe4mQUbVxYIvYWg/2ru5SvgErgMA4d1BprQdNRF
         RyVL5MB+auQKcz9keQuxpnD6XST2oYR8M6tae/vR6Zdp0hGR7e4UfTSp9rAFNeBJyEq9
         Xkr+7qjNMzT5omhKM7nRoCM/ZVWOMKew3FbTkLXdUXLRfmCFqVgYJnurdVqOA9RDVsSI
         1NpdER7of0cA1znHTbz+hjczgUKMTXitLerERco8zLXNV7VrGnL6Ucw+46GTUcuJoJQc
         1AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809611; x=1742414411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMxXnf+4zzFRQ7H73AFnJy23fnGbk6fGeAvEIF9x6hg=;
        b=owdkk/06xsq7dPINCtbg96MxsWjFGv84rBZWfyxaubU3makmfdgI2hRHxA2NDhdi32
         wPdIHzavMeUUL0voqSPy8tKdHes2vwZtKqPeTKtNp1UOurVcAoNo2IFj2vC1yOEAHEiz
         CY6riSh4U4n/7TKRO5iaedHm6FxalWv859SgJu2HKjvJrPFX+couSmCry2vb2NIzxM6N
         KGVKSCTE6H5lsgjh8c7RX0U/ySC0T1Ey0WQWu7bMHvHni5Y5nPdrvzPEM8BbArGiq3gq
         9F841TI0r+l2ZZo4lzRC1R+wK/xYJIscFjOKPwpR9Qy9nfsjbxb/m2cqfuey+D962a+a
         WW0w==
X-Forwarded-Encrypted: i=1; AJvYcCV+uzYMyts4o291sn2RgTIzM72D3SzwvYfIKp5f9qleYZxJywcc0cPKJg8nHzGEEaLQ4w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQEnCpq7pWMd6/SQta6YgjVhBpDiUJFMROETyfwfOCDlUmQVR
	zd5VIZUxinm+V1nVG/91n4juTmduYFAHGMr8wPUj0maMOXnks99j15yci0HPl7vDIzj8cRbrit7
	CkBA=
X-Gm-Gg: ASbGncvhcrcS1fnKNBn+a9fDAigKEIIg7nmYbYNIF+AXlOs29es4TqwiuRVRAVkiHyr
	5UQUVqAfETVkXvFrzah8AAdhXDmNI9Vxc0fU+n4p87ZEcmBtcUVBN/KuhaQjlTHw1N4x3LZMr+z
	SpYUgZ89AJKzA3chXKJ2Z5ZDYmRXewB2SxlbXmKZCsp9UCDc0uzrTVcGkLgAjxHY/8vFcKD3ezA
	VdU3wrBu+HRQ4VjYTPMni2LodgQVEdJpkTLsszF91uSFF7swxwe7cy/l4MDP3PfQENqef9eiQlW
	bD0RcUy+/NujZwn6QI2zTu1jYj18tskKckOAp4qLEHyFQO/ZunKyL3gcsfUGuoMBH1rbGp851nW
	wbohZ9PX6hdnTEGAd
X-Google-Smtp-Source: AGHT+IExfNYwOf3kvPMclBRHpnOZaUK04k4GMi33HTUTvjTbCIEvfQyi9SrIVwXDeHFhtR6DgYoQ7A==
X-Received: by 2002:a05:690c:4807:b0:6f7:50b7:8fe0 with SMTP id 00721157ae682-6febf2a4500mr320395417b3.1.1741809611529;
        Wed, 12 Mar 2025 13:00:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c483d6sm32844267b3.117.2025.03.12.13.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:00:11 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:00:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] merge-ort: add new merge_ort_generic() function
Message-ID: <Z9HnysAkF6P9uUg6@nand.local>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <9f73e54224d55b40faeb5d68ebd7ff0c13d69c7b.1741362522.git.gitgitgadget@gmail.com>
 <Z9FAgCSCZSJnzv9d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9FAgCSCZSJnzv9d@pks.im>

On Wed, Mar 12, 2025 at 09:06:24AM +0100, Patrick Steinhardt wrote:
> These two hunks look related to my above observation that we don't have
> the check for `num_merge_bases == 1`, as in "merge-recursive.c" we used
> to set `opt->ancestor = "constructed merge base" if so.

Yeah, I noticed the same thing and agree that it would be helpful to see
that spelled out in the commit message.

Thanks,
Taylor
