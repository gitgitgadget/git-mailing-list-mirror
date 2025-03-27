Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF32135B8
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743077095; cv=none; b=F5NuEDjqQ5HoMnwbj8fBID78FBKKdD0zXkycU0I/1nlnqGs+i9p5AODmh5szUszm7kn/1MCmQXWjAOTPjZaVvfntPvV+rvn9D7R/DDT61xiUr1xFljbdyAQlQaeUnKMslCP9vUNGdKMK9Pbg1C7+gu+c+4Xi3vjgHPOea5apQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743077095; c=relaxed/simple;
	bh=ePhohhW1tBC78KdoF1Vadb1z9JA1l+W+YKrg9Je76K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxdCzI1zoZ64WVeu1ndxK6QB8kDcQolcK63vY2+m2lTsMyee09M6R3PDtLmPUmbTZzX66eSWFOQzNANZceaI5gSrk2qF/y+jNtuZp3PiccJjcIO30JnWB+pycV6LCTMoYf745swiujKyOuVRzZVzwnbitiQJRuYXByMZVByu5KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ418uN0; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ418uN0"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ff37565232so8509507b3.3
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743077093; x=1743681893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dAqqLFc2fx4Lzbg3dQjYYSKQRNQP6A43DTUt4gigPNY=;
        b=IZ418uN0hGXIGrqSMgii0F3YF6AZ3rtWGX/dMmpa1C1iSvmGBY6UNmGeMJbU2j1S2q
         UoZTv3fQ2wHvgc0Wtpo5VATpAeqGFEXk4T1brI46w0BXnyCdUQdkytUk+3AgTN44cTg9
         HQWpJyDTl/T5OsMKhjAR79WOdDxSxPSJOhOY9pYTD6HAE+ZN/esOu1B6loPtbej0ek8C
         TkF/dCo7dmHmoLVBp+lP0WCYf+78msTvK/9cUHodM6nsHV1qrbiht//sKcMoKm2ixjaG
         tgOjGrFM50YKBJLGlnFHwSKC8oEC1YZ1Hx2nSwcquX4xjIGk+EhZuzXhpLs1fMIE+wY4
         wVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743077093; x=1743681893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAqqLFc2fx4Lzbg3dQjYYSKQRNQP6A43DTUt4gigPNY=;
        b=VMGpTOSYZNH3vhxbof+iOLpsPpiDrH9QAjEOVo2+IBimImYH/BEJ25C6cdsYmkJ/pG
         vf9uoSV4C3e10evhq0oEyGnhzMj8YnKiKhFAPwwsKXKrC1B57swXD+2/Dx2rUeNBNdRl
         lEXL5kXEXi3Scu2O+fOhMZifAH804yKkDSsrtXIHlbu7mAVAFbxYNXFDPLp3SIfW0F9s
         EiXUHjPS/VsbY1+h6e3z4mfbzX25NFZULy38EwiVskLQHiaV5ODn324idiB1dovGXclF
         2wPRmCVeZvhGV0fUZe3IJQCZ6yneQ30etiOf7BiaeufsV4MgEjygkI/P1pXQx/VZolm9
         dxkQ==
X-Gm-Message-State: AOJu0Yw4OSd56H5BCT8ZQ8/drbC9mlswCLV+pUnM4uifFIZ+ksYk4QrL
	qrNbTt6b4mxlwTq5WuD8mZZ7IXovwgjIg/im2BWFR7zKlAl11xfM
X-Gm-Gg: ASbGncu363Zh9eC0z+WeJDBehBBL2KgByXIWztp/9USkmvd1sqVJVYMdXhoYzClY6lZ
	U6IPsCFv9aO4DW/73GZY9cvWVb9PkBBYcb3D+b2rsk9v0jbsz7s/zBu2evlJ0eaqmbJfHZSRytP
	OGWCI/Gu0UsBNssCYu/vLLhYIEFyASVU6o/II2cG8t8ieU2UZ89Da103+a7qbvMFLR/wr+gZUtr
	umIKFYacyzhv5EG596PCJmcxLfEK3yUKfKutN3sPzVva3V3HJnUkAKfS0fWQ78Ej/KpTKF1vPnm
	GHXLtiJl9XIsuMTimqO/vexd3FueL7A5shgXgJyZ/inTnxZYrF31szb96ZwYdCTWXx4c1KyOgCn
	+9mleO/tAdKwVHSHlmwA9
X-Google-Smtp-Source: AGHT+IFlSRJSJalAp9Z1JUniP6mCQ/VBu38Ju1MXd8ASEYzz34f9NUGGH2GFc6sosvYRh8DJrfBxyg==
X-Received: by 2002:a05:690c:d0d:b0:6f7:5605:c62b with SMTP id 00721157ae682-70225092a62mr45126847b3.27.1743077091554;
        Thu, 27 Mar 2025 05:04:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c975:a5ad:5770:2589? ([2600:1700:60ba:9810:c975:a5ad:5770:2589])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba85b40esm30370407b3.89.2025.03.27.05.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 05:04:50 -0700 (PDT)
Message-ID: <511c7ce2-cd1c-4d0a-98b7-c7f5569a3eef@gmail.com>
Date: Thu, 27 Mar 2025 08:04:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Introduce git-blame-tree(1) command
To: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Patrick Steinhardt <ps@pks.im>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?=
 =?UTF-8?Q?on?= <avarab@gmail.com>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
 <Z+Rl43VR3ErE0Bu4@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z+Rl43VR3ErE0Bu4@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/26/2025 4:38 PM, Taylor Blau wrote:
> On Wed, Mar 26, 2025 at 09:18:24PM +0100, Toon Claes wrote:
>> This is yet another attempt to upstream the builtin command
>> `git-blame-tree(1)`. This command is similar to git-blame(1) and shows
>> the most recent modification to paths in a tree..
>>
>> The last attempt (I'm aware of) was made by Ævar in 2023[1]. That
>> series was based of patches by Peff written in 2011[2].
> 
> For what it's worth, the blame-tree implementation that this came from
> has evolved significantly since it was originally written in 2011. Most
> recently Stolee and I worked on a version that uses changed-path Bloom
> filters to narrow the search, passing un-blamed paths to their parents
> at each level of the traversal.

It's worth mentioning that the underlying algorithm was nearly rebuilt
from scratch with this "passing un-blamed paths to their parents" aspect,
which unlocked other features such as caching results to be used by
future queries, even when the tip branch advances.

With that in mind, using the 2011 version is unlikely to be valuable.

Taylor: do you have a drop of the latest blame-tree implementation that
could be shared with Toon?

Thanks,
-Stolee

