Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907A13633F
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020279; cv=none; b=eXaxr5HYmjPKEtiwZ41QNt/KzlSZZXcjCW33Ju3GXCjx65Wx4FKl8hFcDIk0aFkVxOVFkaLLTsoKr6gMOLskTb8SHCLYamNr6RPCIE7COYJsSV4HZxSAUwxtZBXKGwHJQQxnkABJRZsZ9gBCf6yyTaOM6IjuMsBk0W14gmq04jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020279; c=relaxed/simple;
	bh=tiGgtVRlDn66GdhRTh2UwlDGtuJrrA0Iq1HXxpP8hX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BY+lgJtlWIcEr1csyz1yfpQ7nH4gzN23TVDbK1yyy63i6JLidTDUR3Wgt+vOxKnHc8194xbz9su2FeOZgDNRffqhzb+AQzvsUaZmprrPmT35LLA5+x+oVquSz0NLboEINmHv9zwyeCBxiBGOna+jp6gzpHF/6/oW+F6RoZETzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=i0xuOR4P; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="i0xuOR4P"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476b89782c3so2766631cf.1
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1743020276; x=1743625076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tiGgtVRlDn66GdhRTh2UwlDGtuJrrA0Iq1HXxpP8hX8=;
        b=i0xuOR4P3lL4ZTGXSwRZuwgpjRa6FjWrK6vXcZ67oama5dB/PO89mYJ/ZO5mVmDHmn
         XWeZyy9Mm+qHCgW44+32PxUo+yijDE6HZZqJSsREgOugM1r5F/5NZv2GHnpl8iydBpaq
         nkYzRWVcL295cBzGx3/zzeDsGCpjr2EkERbqmqweMB5/YYVcFmA6ur3ygOnhdanHqIuk
         pD8eOhiWYeiiEG+JFxsTxmmG4z+E2GAhMNBedc9fFlNMbHUGk5jNJgV2dtE88IGwccN8
         WTwVr3Zsxq7ox49BABdqMLjC9CnCGyU+4S+cSpVA3saYJworCJQfGp0hDT1o7mWJQGHH
         1XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743020276; x=1743625076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiGgtVRlDn66GdhRTh2UwlDGtuJrrA0Iq1HXxpP8hX8=;
        b=vuplQyav2S9cBo8VFBgC/74vmp2/gD6jyTEmoSpMiVrZcWjF25WLSnZvLKCi5F47gy
         vz1Fln5wLLLZEVcJHrRUpLN6yytZ1xCv67BV4ZqcbCHWsjGPft2NFJ2xr2BZltjwMQzR
         e09tyoxG+mz/9olxQGsfkxzPmk1L6BX8e1GzzLMRQePvR76ZaZkBSGV0pmiWdE3mOd52
         mp9qJ3QsyF9flLAqIOJALkMEz7lx0LsvBCl9Bhy/y40qqAVxkC7gRPyOxmPR7QX3fRNO
         +bXsdw/Zwbp+WSUyUIWrk3NiU6x6dHW98y82e5qzzCwiwbWJfxZrrCnddv8G3ziyUaVk
         WSSw==
X-Forwarded-Encrypted: i=1; AJvYcCWMoiFJN2yngxRlAx2Fiza6zgjgjFJBWhkTcdferLsrEtkJHE/LANyRXcctCIMpZbyVNv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbkrzoh+lnd/qH28k6ZTyW1EqvQLm8YigyBXsoyI6VA0I6qn+O
	IQjHPokRSaFbHVCykirtB42LDaorp92qgUiYrHEUgrkUqUJ/+fasUJ8jVOPH6ts=
X-Gm-Gg: ASbGncvV/AQgtXRiD8JV7r5gdyhx65L9RviCv8zgtcnfB45HJk3KagqVg72Lcw2k0sp
	At2pPGJlTcMMAqA0S12/fZjTFMyh48wMpO3+Xo2EwByZ1+4oAqjSgZdSqn1h1hi8eAg5bDtp/Wr
	RNqm+7gQ1jnHuK2+BuMMIFHRMwRnPm6lzL/DaEuUJ0m3v8RGJLJZ34ybd6mXYDdsnrZdiHHWsD9
	ASMlXLYQ8/b0LhXCoZNTL8zkZCfGhTN+o7Zw34VPXOA8GW3nAtmhPodvlRvAwqaeBXQ4RQ9puMh
	L/lIN5EApkQVwle0oxuC1+JV5Fda7VEezm+AVgKdIRaKi53P3aMI+DD0jFf8u2/M9IxTdH0v69A
	bj+3zNFU27Eu0Y0CK
X-Google-Smtp-Source: AGHT+IGEwKTp3jVRiB+yGPiSMRwSCNnMkX0QHsO61DKxK2TEaVBKzHMqRzvQM1gfF9Xb7No26sJehQ==
X-Received: by 2002:a05:622a:250b:b0:476:7e6b:d2a2 with SMTP id d75a77b69052e-4776e18f5d3mr20099261cf.35.1743020275942;
        Wed, 26 Mar 2025 13:17:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d15a16bsm75159021cf.7.2025.03.26.13.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:17:55 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:17:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/2] Avoid the comma operator
Message-ID: <Z+Rg8iz1cV/pSok+@nand.local>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <Z-Kf9ovF8zAemgUP@pks.im>
 <22fe76ff-7940-86bd-af50-c161e3d04864@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22fe76ff-7940-86bd-af50-c161e3d04864@gmx.de>

On Tue, Mar 25, 2025 at 03:13:47PM +0100, Johannes Schindelin wrote:
> > It would be great if there was a compiler warning we could enable for
> > cases where the operator likely isn't intentional. But I couldn't find
> > any, unfortunately.
>
> I was not actually planning on adding the CodeQL workflow to git/git,
> seeing as its CI is already taking way too much CPU time for my liking.
> But in `microsoft/git`, I am kind of required to, so we'll catch those
> issues there.

Heh. I should have read this email from you before replying to the last
one ;-).

I would actually be interested in having CodeQL support "ship" for
copies of git.git that are hosted on GitHub. I wonder if we could do a
similar trick as in a56b6230d0 (ci: add a GitHub workflow to submit
Coverity scans, 2023-09-25), where the ENABLE_COVERITY_SCAN_FOR_BRANCHES
variable controls whether or not the job actually executes.

Thanks,
Taylor
