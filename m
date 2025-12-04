Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CD0334C39
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842927; cv=none; b=VmfAl//WGUhNpJpWo04bIx/rJSJT8zxFn/HhU6bvoF2U/7wYtqbakzePZevi9i1tZA7nS3kiVlGfmUu/krzEwiAYzmMLRdktsCuVQGTvY2ACEmgwpQO1qv+XFca+LYIMNErXlq1pnTFOEzxap4jwjPv4RB7ZgW7T6r5Rrl89GPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842927; c=relaxed/simple;
	bh=aNHD9A0B8ucKCrjTk+dCVADV5ZJjEV+7W2uaup14gmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iE3Xe0b8O5ZT5WIHtgWaJG18Vae91lqrZ9pXohh/GhEpOsNixfUeycRkMN/8aAW02HpQq0s2li2pSASfbqvTMg//aAetiigi39PJTAgFBVkBM5K6HB8zZA8/ry7hEip/twcFYIDub5tQfZ/42B3+IQTLrNYpG2G5mmfZqCudxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM5wGhMn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM5wGhMn"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso13362495e9.1
        for <git@vger.kernel.org>; Thu, 04 Dec 2025 02:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764842924; x=1765447724; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNHD9A0B8ucKCrjTk+dCVADV5ZJjEV+7W2uaup14gmQ=;
        b=FM5wGhMnLLrN7D8N/oV64zwvS8eEen7cRQGVizYK4uz2XrklPV82Jcje6BkJqRmuYv
         TOFZ+HRdb1I02HbKpO+I/ifMUICwuVI+/CI8pVvB5CT8vgmJ0qD5iZshGNMxi+CHVJ9m
         6u4Vb7AD/upn/Wq0M+ISckFy9HQsOjmcID6BPzoEnFWXHbZ/N0Xp1gEVpocwoP4TddnZ
         gEomcbQ6iPcToXrInO3w8q0XsNHyF3Bm2YdhT3KGOWvtTJ7ItiD8+w9ZoGK1iNgF41M6
         HBV1q0z0F138j0WOilvRg1XOUhSXhsdyR1e+9cjtOPeoojpz498yvTSkbs5CBin+lDlj
         OeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764842924; x=1765447724;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNHD9A0B8ucKCrjTk+dCVADV5ZJjEV+7W2uaup14gmQ=;
        b=Tml9HiRB9Xq6G21sGfElcNFqeXfyTKSMfMACq9Y0JuDSAmuCW274CmrwbHH95yJZSe
         ToRboawsSj7ky1fPyPlDHiOVP9kCuBbJ69GO6EN4V/xqTkLoaTiM2n673ODT7Gxs8dZU
         95qPnoTbSUEgpJEYj3jI0qudDSSa3xfbTiyfXAA/auu8lmfRnZIM9v2zV9mZ4lpDHbd6
         4olRQyxlDVCdqqPdIJcai6xjgjiSybBRdDZLZKh93FOJZOJlPeucxertrzqZbsiiK4jd
         Eie5Jdt73oOBHku640695IeJQyyHW8oQoIV+CFfu3CKlO6cqXSRSI+HX7XrsgMgqMt04
         BVHQ==
X-Gm-Message-State: AOJu0YwuG6vp7k+rjrkmwu/amjJVZj7HkVhCkFHQyJghCaPB0A66mseL
	a0vWcCqvPT8Mp5TQlH4Di0utzvC+z+1gH0FLz0oUV+bu54Y9JhuDMalY
X-Gm-Gg: ASbGncv9YalKfqDJiqRjWI+PDGrxYQx/J1KjtdzLG4ODSQa394/H3OwrKmWBW2Y9vS+
	OMllwzKYYY0ifOM4xlyYXt/oY9k0GC+vY21FsNvuy4ILOzV/JA9XtvZgCxeNC1332JvyIHBBfM8
	CAbZ9goKpESffXBAME07YG0eXiQvdFnLI2uC6LWnr1PDvjiCl9nFhlOw4ICgXxbzxUD8Jmr6V20
	j61tEus8Lr2eXIInt9v2Bdv3i8RO6sXold2kJwJSeFzXdCvVN6ycItZErDtDpwq0EXLJM83ObnF
	Gc1fva8p9SlUKlNkt5PxdE+dv6rO5SyvIKIQ5rBmSzp6uZzvDAIzYFPaA2zRJw+vPc15xj9wdHx
	VRS4TxGKAVdmdFipOqv5C6nd0o5vYh8huzL+x7bSsuStEDj2kWbKzojHSD/fLE+O8euW0MmINpe
	Tr4A==
X-Google-Smtp-Source: AGHT+IEeaHC/++f+Va9r4tYUMMLmBwTiJGf6rV9L9eyehA/j9m4/pr5K7gLE1t7PQAPUEreLuZ1D6g==
X-Received: by 2002:a05:600c:4fd6:b0:477:a219:cdc3 with SMTP id 5b1f17b1804b1-4792eb36fd9mr31767115e9.12.1764842923384;
        Thu, 04 Dec 2025 02:08:43 -0800 (PST)
Received: from ubuntu ([105.117.8.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm22503965e9.0.2025.12.04.02.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 02:08:42 -0800 (PST)
Date: Thu, 4 Dec 2025 10:08:37 +0000
From: Bello Caleb Olamide <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, usmanakinyemi202@gmail.com
Subject: [Outreachy] Blog: Refactor in order to reduce Git's global state
Message-ID: <aTFdpfZMa4S4hxMh@ubuntu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everyone,

I am the new mentee for the Outreachy December internship round. I have
created my blog [1] where I will post my weekly updates, challenges and
progress reports every Wednesday.

You can find my first post [2] on getting ready for the internship.
I will update this thread weekly about new posts and if you have any feedbacks,
you mail me.

Thank you.

[1]. https://cloobtech.hashnode.dev/
[2]. https://cloobtech.hashnode.dev/beginning-my-outreachy-opensource-internship-at-git-overview-and-project-description


