Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FE146D6B
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788394; cv=none; b=gxcYNxRHjLjHppVkws0D+KqEuW2GSrcixa6Rebtz0Qqzi7obXijdtNXQ0bZTjFjrBcxGuUiRBes5TAWNhusxMAsLTlnwVJX+pMPh051w8SMnYq3lt3zIAs2L8xtlWrZovPDK7sRwP5MVNdnlxvMWO5dqzTB+vuWkuhw8QVKr4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788394; c=relaxed/simple;
	bh=bItoFW4fEaTvgvzxHDS8bSaNAESdiCpg4/mcVvKrFbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag8/UA9cvjinsRxVimazmuuPhYtKXS06f9XOlbNVzDC54b4jo8EMkvEhpJWvDTYGO8VPUjUA6j8JTWLyJYtcLhGAPH/DbKAK0sYl+h+k8D5uvR18MqEzAsYpCNML8alYLfKJM3NyCldgLyaByFTwzhlfzoUa4AV6FPN0UBPfDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mQh560zL; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mQh560zL"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e290554afb4so1368062276.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729788391; x=1730393191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3DGnNsQdSfUnbxiiahNoBNVTlzefn1iWg76GU+dRJw=;
        b=mQh560zLv+SLX1kTq+FTt9TzpUkAr5/mTqi0DfkwZ5DGOrHSV0cxAJgFd5U/8rwd7l
         iYoVdO+3i0+5DxcMibWJU1cVHGFpOOuZDAZs3CXEIiWkraXtC95rOus3jTEu/nEYoOEz
         T2qZR4jtaHocR+65ZVaCYzBmQPxI/2d0CrYpgZO5U2p56nyulOQyHG8mvhUefQzDkd8f
         sJ2kE0gdOtsVXZmzPgN5AEuliOOqCbxROTfHEvjw1uVK1XL1CapsdxR5I5I2w4LC0R7Z
         NBL3yowGIhPVjd9XjjWzKPvtJrtRvArnYNro2GP8yJG8wQkL3S7F0LKNUwedzCOimV3j
         32SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788391; x=1730393191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3DGnNsQdSfUnbxiiahNoBNVTlzefn1iWg76GU+dRJw=;
        b=lquiuoFQOn8Kd+L3QPbmxtikU6eq4WS1ZI/xs/DH5IAn31j8Vw8mqgp5HF+nxfMZxs
         p9r7WJZk+vW0IQr6T1iWMxnm5R5UMH9vmVp+Jxd2b4EGIobx+B/St97eRQzGud31Gy+k
         8AKo1UglZOpMDbcWJjfEMPc0NYGXCdulpSFfPZBTbWXb8V99AB6JnbU/TJ5kpbX6GcbK
         zjD4rmScP/Esijj7dKiHV2t9WEdBHJhGteCJpO6eF6enWdraF6RpMCV2xj/vtugWdqn0
         IZu7PJoyBckWPqZpNMMvYklHTz119h6sVM4VBlNGLOWhgb+80qDEoCIpW0QpYQ3toOgq
         QcqA==
X-Gm-Message-State: AOJu0YzNiURiVeH1AM63zFUxzPcxRzb0suV3k89cvNsXaV1CM3S3b2kI
	N+jAy4LYnSSh+ILiQficHSI8vEMwrTBY0IqBvpGDenaGya0W3ylcH3cEWsB5DBpysYnS/1/xKzF
	jBMo=
X-Google-Smtp-Source: AGHT+IHjvHo04GrosHGdKPtXEk7PTFIgm9CGhpd1cHGm8aCnKwH2SzQ7biuLSmzUUuhn0moZUhwIsA==
X-Received: by 2002:a05:6902:1ac8:b0:e22:4f74:9590 with SMTP id 3f1490d57ef6-e2e3a681b68mr7534609276.27.1729788391393;
        Thu, 24 Oct 2024 09:46:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2e2b5c36d6sm1099231276.18.2024.10.24.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:46:31 -0700 (PDT)
Date: Thu, 24 Oct 2024 12:46:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] t: fix typos
Message-ID: <Zxp55YTXyRT5wGuo@nand.local>
References: <20241023170111.6638-1-algonell@gmail.com>
 <20241024114721.14270-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024114721.14270-1-algonell@gmail.com>

On Thu, Oct 24, 2024 at 02:47:20PM +0300, Andrew Kreimer wrote:
> Interdiff against v1:
>   diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
>   index aecd03d69f..1305b1cc25 100755
>   --- a/t/t5528-push-default.sh
>   +++ b/t/t5528-push-default.sh
>   @@ -147,7 +147,7 @@ test_expect_success 'push from/to new branch fails with upstream and simple ' '
>    #  - the default push succeeds
>    #
>    # A previous test expected this to fail, but for the wrong reasons:
>   -# it expected a fail because the branch is new and cannot be pushed, but
>   +# it expected to fail because the branch is new and cannot be pushed, but
>    # in fact it was failing because of an ambiguous remote
>    #
>    test_expect_failure 'push from/to new branch fails with matching ' '

Thanks, looks good to me. Let's start merging this one down.

Thanks,
Taylor
