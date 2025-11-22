Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858C1239E80
	for <git@vger.kernel.org>; Sat, 22 Nov 2025 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775428; cv=none; b=AjuXkyPWEvqxPvowll91VqDLbG9e55OYwFrwhswk+mHpBlG+qDVuKPkMK7Gk7TxpcUNWYol0jt2kC/0QYhjP4Gu2A4isfACsoQdp+Xf0HPRomxkt8+kAgfB/HImkdbcpFpKDTqitoY2fREc09TRyEgaBOl4pH5O6P8glwLMCjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775428; c=relaxed/simple;
	bh=2ksGBj+2FaEu8Gq+iuyBHdZXq0umT51LdmO0UtGGaRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxNQlVPbWNeCXhOHF63eJ3KtZ08i+PI5WS+n1FDcbmisgmPqpwWu+vcxtMPjOf8Y/Yw27F66bGVmFmDEb1Ss/h26qjpgumB0RFnYYi8GMDUIWnyPevK1smCedK83Ib23psCn1OJREeV1DuxjkNhyBqlxzVMuU4zU4j/RJ8ccV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c8hMh0rO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c8hMh0rO"
Received: by linux.microsoft.com (Postfix, from userid 1227)
	id AA803201AE68; Fri, 21 Nov 2025 17:36:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA803201AE68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763775419;
	bh=5k8xQuZmdaqAZd8X0XR+8HujqM2fl2T4ZEiw6QSY7Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8hMh0rOUg42v0qjF+heZ+hyjjqmLzz4cCltF2lfWVIEx2ybqSH4/m2/FPhF4kb81
	 /gf0T4WMRE5Xio6ezpxzfYxGRYMv4v3DdYSxGfFxAaNLnEl6khsQF9rCsRdkLrgIe8
	 tKoSXxOkEQtpZhtEGu+DbnZ6TRC/kcNez38SQic4=
Date: Fri, 21 Nov 2025 17:36:59 -0800
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Delilah Ashley Wu <delilahwu@microsoft.com>,
	Derrick Stolee <stolee@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH/RFC 0/4] config: read both home and xdg files for --global
Message-ID: <20251122013659.GA3947@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
 <46aa7034-b186-4adc-ad0f-8c7a4d799687@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46aa7034-b186-4adc-ad0f-8c7a4d799687@app.fastmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Oct 10, 2025 at 03:27:24AM +0200, Kristoffer Haugsbakk wrote:
> On Fri, Oct 10, 2025, at 03:14, Delilah Ashley Wu via GitGitGadget wrote:
> > As reported in [1]: `$HOME/.gitconfig` and `$XDG_CONFIG_HOME/git/config` are
> > both valid global config locations, but `git config list --global` only
> > includes the former in its output.
> 
> Note only if both files exist.

Thanks for the clarification, I'll be sure to note this in my v2 cover
letter and commit messages.

Delilah =)
