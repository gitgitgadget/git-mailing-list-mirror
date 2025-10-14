Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3CF3081AD
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475422; cv=none; b=tQJ85NaKfu4yytP1QK4E/hqpu1kwO595mGDqYefmXhSmmIQDrxPw7unK//meOdOeYnZoaT+si9yROrGS1kQSP5Qq3ZkCq5vpp2e7Qhp0co3k9y88QUxAbzruAAfJcCnADEH0zY4bgDmewSGZNI4eH9nszlTgMnYM4kGO1QFyRgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475422; c=relaxed/simple;
	bh=ne//J1YgRzpSydhozPe62Os5rVk65GlWn6eQ+U3okqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBInEpjQSh+0A+4pr7bdcu+DR6mtctEmO9PwZnXmLiSc66UwNmuFcm4f/NgOFkdUck0OGpaxWnZSgh9bMqHNptUy46QyZ+M8wx3jcmj4FCEXmr6aEJtdknjsEjlGTCWTXQSFPoRIaBjgsMDi90sHZYVr4R1TnJjkabSJeIfbQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXs0JY8G; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXs0JY8G"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65043e595a8so817096eaf.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760475420; x=1761080220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0zyr+bWWmHekiuWc60wa3u2/VN78rrVyAzWnejzCfU=;
        b=BXs0JY8GT3lub+mY8GAQ/7bM1aU0t0UAaw0LCEJrozaupMvks6tZ5TqJB5Po9V/aFC
         d01pkQUsTvEmz5vtSYB/sZGmQ7OJz6AsjD/rwobc9PtikCKRXhQi057Enmrat8icTaiD
         SRKQJEYtzvTtalt598QOJGS/8CYDz9n4B77SPtNaX8QUegeOj4h0hajBMhpfvX9QMMTj
         gOKw8z+TmZe6cdVKvtm1xK5IFu/SQnFwUH8xVgi6hnDMJmDg7fSsp9Egq/ru2lnjGfeQ
         KCanWkoDNFX5myNuTU69FzdBwGjht1rqRVpHcpPWW6k2/8/FjqOOTFUxwYVBbey7SNuX
         2pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760475420; x=1761080220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0zyr+bWWmHekiuWc60wa3u2/VN78rrVyAzWnejzCfU=;
        b=goxBlB2q0or1GFsqzdRsbOwFjytl0EpHSxTKfnGLnYlhMAhpgwZBa5AahtnehpoiYI
         GXZb3ZMQafocvqkriv2JqsHEGxYRr1l6uqODs2rH/5wn1YqmHMgwSG9DXFRgHmSVFzki
         DDMo5KL/yfcSkOAjNwk39HAc65sYCtqARTseYXrPt5lwros9zgI6zxHFK07syCecuvff
         N27N/xP5YBrUkY8akhW0W6lIbp0UmYwvJf8ewOWT2s+1xtO7WHaZI9Y0dDgcQGIEG67a
         orSPrbuSOq0AN/OYsBRsdcEnwa9Ykof4O96e0AwY7qFNAJXRcpXLpizuVCHABeEafeQ4
         2nYA==
X-Gm-Message-State: AOJu0YwJVbEJXr5OS+sY9whHVB9PRnaDkTClesanMjPRTD3To3mPsORo
	zcVMWK1hxUht6Pblx0np+MMoiAUW6515t0MFiW8mFGms36maIoEoXXuoNAobXw==
X-Gm-Gg: ASbGncslOiQGuSUXgHnaFaVr0gou/fBXOK6n7jTFRo5Jir1HPGaMNdEv4ZWf/uAfNJE
	eonB7lMbmfVji0PdvL2Ukzd5L7A1CPTThziTYxbI0UQar2LAv7YdhDPjAbWL8xNFaJXqHuMlFeY
	+Eff7EX1TvP+H4wFGmpi5KLzQsWXH8kKkaIqJI3Vq/4VpnxJY/1d4S3OxWTyLBxh7l7AQ0WzEy/
	G17hUAhhlnuJWVM7z0N0AMMczt3GKqxavQfz6j2OCLxM3QZ9nQu/1zOSwbmeU9p/2NE3Tpic+Zg
	36Bc/LPEeWsoVk4Uj4qJextPYmf+SwgLfir1YfnCrwGqc68EtnmjdJ5hx670tXX+XMuYlR1IpFC
	NhyhSAB+So2m4hVsDJiBPw8BLaggvZM7I6XM=
X-Google-Smtp-Source: AGHT+IHNP+nN57QuXo1xazGcy2NEo6RqQbQcQMFUFjzpYBhBEDkN156jt/xxTbIi0xOOSnY0Fs9/Cw==
X-Received: by 2002:a05:6820:2ac1:b0:643:f2c6:f834 with SMTP id 006d021491bc7-64fffeb9bc1mr9815991eaf.7.1760475420057;
        Tue, 14 Oct 2025 13:57:00 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-6501803c449sm3574106eaf.0.2025.10.14.13.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:56:59 -0700 (PDT)
Date: Tue, 14 Oct 2025 15:56:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/6] ci: deduplicate calls to `apt-get update`
Message-ID: <rxdwxiokqn2vak4sm7yxzisolbugzr26ygcq4mue3fu5lmmfra@r2pj355wu5mf>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-1-394502abe7ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-b4-pks-ci-rust-v1-1-394502abe7ea@pks.im>

On 25/10/07 02:36PM, Patrick Steinhardt wrote:
> When installing dependencies we first check for the distribution that is
> in use and then we check for the specific job. In the first step we
> already install all dependencies required to build and test Git, whereas
> the second step installs a couple of additional dependencies that are
> only required to perform job-specific tasks.
> 
> In both steps we use `apt-get update` to update our repository sources.
> This is unecessary though: all platforms that use Aptitude would have
> already executed this command in the distro-specific step anyway.

The distro-specific setup always executes first and does make these call
redundant. Make sense.

Not related to this change, but at a glance it looks like this job
specific setup relies on using an Aptitude based distro. This does seem
slightly fragile if a job were to be configured with an unsupported
distro. Not anything we need to change here though.

-Justin
