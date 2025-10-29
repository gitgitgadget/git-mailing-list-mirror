Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75A2E0922
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779710; cv=none; b=EdOKXNL0Rfeb6JCtmrSlmtAN/3nqcuP44HRJ9wePo5U92JDHFZDgBywi0i34uTP75lQQA4x0tpLgNLIEQibttkrDa2CisTNV+AZgcF8z2SFEcuXzSmIhzfkp+id5kah64YoO0ri7AzfTVB9PedzFuhtt0a2Zgf4tT5OlCJRnA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779710; c=relaxed/simple;
	bh=b3JGQQ1zFYfs6xBgmlEQa+443Dp0KfELHCFw92sxjNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzQEP4i0TzHT+2puzCtdFzxJvvgPxxEoGF3r8sYWoiGav2ojTYtrcQSGxvM99ca8VVPYvt7lyzARic1zu3o3rXStbrhl2HPPqykSIKnfpBZ0Snfknc/+6yfZhDuUGgKLeQF1Z1/vfpfSbtWY6Xi/XF0xHrZXjLigJliCyNq7GCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EQjkLKiR; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EQjkLKiR"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63e35e48a25so580852d50.1
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 16:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761779703; x=1762384503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNLD0EmFNLPf9C1sSCP045mgdqoI9SSCnPjWmqqwNZs=;
        b=EQjkLKiRxxjru+HxWeurJOfFXA4fpxkvdONkUcPSBrYLt5CZJfrwPiMagFwcQTNS+y
         oLVNqTWuxQf5Ev0p4SL8QoQ/rsJukgTZABGuyEUVUHP34GkeprZhyoalEYMEGG0rqYdc
         0nWu9maBsQvoE6LmBZttbkg9+en2mcVpQKcvJgWEfL2dTbMq9IecGJ2XtqJKSA9PrOHN
         n6T31YU91AnLj9F3uYilkbCKYKKs0f3i+n3leZ/5s13RSqnoyMKSKS2FZ3T7cGYQpb3U
         VUojDTmgwzPEQRHT4srt6lc/5gXGdroEaQuunaNhYOwqsLC2r4JjAy5Et8TEdxfUelbG
         uCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761779703; x=1762384503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNLD0EmFNLPf9C1sSCP045mgdqoI9SSCnPjWmqqwNZs=;
        b=c7JVFqmJPcr+CDzd9p7B/5sNykAuPZY692EyX58RPxl/UnzsrIJY0wl1UYc4DW2xQg
         QX8zDnFO3F4GqW1lG4lpAV9xEuMH0UpByY1WpXv+583MNK0jmYilTpwbTeQRYtirlJm7
         ab0W1LOFpGPlawrYyIbowR8k5OuaCwgv9bAn0sQRKNNIzODgzSbRaQy/gEZQ/uVLxRvn
         eMo93J4C1JlJZBOLo68CETnu9vf2/rujvzl8xuwCNWVO1wrXJ5rgFstncdPxU52J9oJL
         a1zjDUrYEA5vLrlQA1ARo8NNhONwJiF4n1/6yHomCsjkI7dXyMp2hw01nhutfHsiup70
         Ffkw==
X-Forwarded-Encrypted: i=1; AJvYcCUMyvMHylq/HJ0jsgp/MNOotPNLD/nMzK1X72OKxXqOEVi+Oz7IzqD6vvT8k1xWSenmU3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJ9bnzqXM6o8rtutwg+3uShXjuFM/c+jAl12SN2RGlE+eeTlL
	BspCuYQvLEwxKC+oDQ7xrV9kqrum9fT3c+qEILMc0Dy7ftt3sjNlmBVeQhX4n+cU6nA=
X-Gm-Gg: ASbGncuf/oaDmTKDBepi0KSN5SIcVDO5DLy0rPqboHIVnptRyJeb6DC0/8bdLTDG8j1
	lNnIhIOPLYB+NibReChiaz/pHxkfc2iQFGknS75kq542zn4R6zHEDoRptfLktbXEmCbHWWC3YG/
	O4Ck6ZW/TJicqs+cnZXOXMIAgehTCbiBKNASybGdusJ+RqJ+D5ivqLlwznEUefI4q6F9Y5E+utv
	lGewk5ftbja/Ki8o3wYhunWlg0VMvDprgPVG5GmE7aWNyytRBUS9BgeEVYBTYtmy0y1yqbcAxol
	NiM3mbQ3K46SgYQzmFmHMRMU3hl0iGySIKM5YunJOZbYv9hQ2o/7ZiGKrfyk5qTaL7enArgTk6m
	TAz36Tg61lTtki32kEMigT5Og848p47OyVZMSIJiukGCQoGkVu88uRaJ09wmKI5Ae+yTvsmBP4s
	MOgqREBWi2ZzGcrOwOympiWSBJWGAoUOZ+1lkWLVmxSfKT2avVwIUsmblusBEoMPVcW9fc2A5vt
	Iahkos=
X-Google-Smtp-Source: AGHT+IGiVgRg/zDfcHEox3cE6y1s1VU6k+JUNdIFcagm6LfnJfuTp62u1s+1OHUgLSXydMa+AWGZ8w==
X-Received: by 2002:a53:dd09:0:b0:63f:6bd8:3869 with SMTP id 956f58d0204a3-63f76d9246bmr3232081d50.37.1761779703460;
        Wed, 29 Oct 2025 16:15:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63f4c4724b9sm4681447d50.27.2025.10.29.16.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:15:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 19:15:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] builtin/pack-objects: simplify logic to find kept or
 nonlocal objects
Message-ID: <aQKf9vNkAkm6m216@nand.local>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-5-1a3b82030a7a@pks.im>
 <875xbxrc4q.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xbxrc4q.fsf@iotcl.com>

On Wed, Oct 29, 2025 at 03:55:17PM +0100, Toon Claes wrote:
> > +		/*
> > +		 * We have already checked `last_found`, so there is no need to
> > +		 * re-check here.
> > +		 */
>
> I had to reason with myself why you need to extra `(void *)1` check,
> maybe you can extend the comment a bit:
>
> 		/*
> 		 * When `last_found` was set to something else then
> 		 * `(void *)1` we have already checked it,
> 		 * so there is no need to re-check here.
> 		 */
>
> > +		if (p == last_found && last_found != (void *)1)
> > +			continue;

I wrote above to Patrick that I think the "&& last_found != (void *)1"
part can be dropped, since repo_for_each_pack() should never hand us
such a pointer to begin with.

Thanks,
Taylor
