Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF36B20322
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751253685; cv=none; b=PVght04B0K4sMhRvcV6GroRlPGYXeXEjvWdj+95+LxYl2TApwmL1I2x8/+Az+k6q2QBVlMCnKUDaYSQi8PPj0GkkxzwM+elLLggoGoi81jyLsUHzEM/ofF96ujDz5oxSaHyyi/CNFiAtmqnTOm9+FYUbfYai4nP/axeWuPa641g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751253685; c=relaxed/simple;
	bh=NubKIvgvUmUR3189uexhNgw/sh17SPaarjwJCKbtnd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFR8ERdfK1O7KX/V/mrwz2jnhDrHk8Hm50udI/1paqxBidW3DAQDErA1Xzs8/7MSnVo0tsK58mI0TNzgcJ3gkpMIYx56wR9khuFWOcBIAoHiDci1M2rhl2bHL14y8KLgOKt+pN5G8YvnmoM978utfYLk0Vib3Pa3JcZ8XW4r9GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN+x30FD; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN+x30FD"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-606440d92eeso855752eaf.2
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 20:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751253683; x=1751858483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Pp6hWTinvzK2UKlHDTSuX4E/9CG1xul8tlX0TFdiJw=;
        b=AN+x30FD7bcSp6lgWf6NmlAb1kICakeAz3z9p0+RrkHD0A14gNYNkqcwLJt3NQ4rD6
         bs2hMLcbNRttq+7BkX0aWMGFL3eB4p38Q6ndpscI4L1TAAUm+Q5VjV4aO8L16T1kgBKQ
         V/8I2k01MVHg0aT21YKvWmHkVCxUEUOM6vzKFOQW9TTDlOkYp7sd+9qYqh1MPmjZs4Uj
         Rlph+pET3On4LOkljqupGfdOIr74JpQPNGF8p6FLEKOalTNr6+7Qab8EGTuGKTuLm1Kd
         jo1sbcQ7PlQeyDJjXFy2G4+R3DsZiV0khbD82tfQNy5Z08F9Lh4dpxumzQI4PZMRDwwR
         GxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751253683; x=1751858483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Pp6hWTinvzK2UKlHDTSuX4E/9CG1xul8tlX0TFdiJw=;
        b=oTTjLbQZAIVRU3HL2/dz3EkK7OfiAHgT/7kblAIYi1sT7Ih+rEN1t766LlbNaHZDnm
         710ogD5IcNh/A6ziqdJ2hEVsQOJmiRzQ3TZi6rvTRtu7957YCpAEydDjv3L/N0ZyBZoH
         IIkgdcnTxUtQCHWiqtgNFO1oH1vP2WmAPOsKczuK1PijXjXBvt76AIFkGbCT/DdXYuon
         3x8pSJJTk2RHtYo/CA4H5eyauTwwEmGzueWK9hKAaq8648mu4JJJPozWjc8atTw00WQG
         n8nIfKZg+MKNff2Jll5EQkY8xXamd/Hf6FNKKizYGpJ5kTotBkVp+AmY4A7Kx292u6lB
         MR8g==
X-Gm-Message-State: AOJu0Yz/tUa8q4rVwkalDCNDl69hTKBqhZQYz/P6u13+YFGsZ89bBRmt
	Si9kdnFGm1SWJo3tnasPRu4xODhEZC+z5EwFOWQZs/Wa/ksoceHHeYhT
X-Gm-Gg: ASbGncv6M16iP92L5fhB+bu6WBvjK2zgnU99mgs81cvhrOB5oAk+CIt5lp1cCi9MO6T
	wvHZgIOr+hUI9f3Qtp0JJiVkPPZAxlllocGr8FRBWA8P83vznCLusmgraQMql77MRZ7adjocf4Q
	thup/1fe+LDJpobvm45LlwH2DCxByt//nw+Cvp8a3jFbfj/qLfyRN07h5BljxgozFQC9XXfOQro
	Y/6fnWbBLWDFLJFxAXVhwTQnjar49GYmxX16rBMo0AL/EOTbIO/DGnfU6Y7J6ei46MSvH8d4/J+
	KA7EPdRR8QYbo4EcZ658+lKUq2UJA+tuwNKRMLYgB/0TaS2YN0hQjd8=
X-Google-Smtp-Source: AGHT+IG+XsUWyuZt8np7IUEe+D6LBo0uaQL72OZR9kJ6vE+qm96rgqgtSahq5r/kgq5DUDrCkM2REw==
X-Received: by 2002:a05:6870:8910:b0:2c1:ac88:4a8d with SMTP id 586e51a60fabf-2efed7378f3mr8096728fac.30.1751253682923;
        Sun, 29 Jun 2025 20:21:22 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd4eab4e3sm2521777fac.4.2025.06.29.20.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:21:19 -0700 (PDT)
Date: Sun, 29 Jun 2025 22:15:51 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v5 17/17] odb: rename `read_object_with_reference()`
Message-ID: <nwxweqp6yd7zdstvlps3dq3jnewzxsfnisgd5ripxtmwbklrmg@zre2usdx5uvg>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
 <20250605-pks-object-store-wo-the-repository-v5-17-779d1c28774b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-17-779d1c28774b@pks.im>

On 25/06/05 08:47AM, Patrick Steinhardt wrote:
> Rename `read_object_with_reference()` to `odb_read_object_peeled()` to
> match other functions related to the object database and our modern
> coding guidelines. Furthermore though, the old name didn't really
> describe very well what this function actually does, which is to walk
> down any commit and tag objects until an object of the required type has
> been found. This is generally referred to as "peeling", so the new name
> should be way more descriptive.
> 
> No compatibility wrapper is introduces as the function is not used a lot
> throughout our codebase.

Same small typo:

s/introduces/introduced/

The change itself looks good though :)

-Justin
