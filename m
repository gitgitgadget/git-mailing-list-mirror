Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551F3AA1A6
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907519; cv=none; b=kLC2ZGYiaEniES5AqrzMBfgKZSjiuDykkw6o1MMbOs8YxHZZHBEtFRDmhqVNoJ6Vr0tg4MK5Yn8FAt8mPoX4Vg2gPi9H3SQ9+CEnvkrEW7pgsysrwEKw36G311AgdOTFZvOmFWyxOkjKj0ptoB2k/LUDvG6cNn8GjBDVBDuaCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907519; c=relaxed/simple;
	bh=gQsZR/EU3iErsZjqpww4IanqFCOxFwUalrkF1Kksf7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERMJFv7efXXCqXc2HwVS4zoRjW/x4nR34jnR6C3NpBg9TkeH7GnMbXyARHvGOrpUDEkEQNXl/51AiQv5edVLSpo+hO0wWyoZrJMadQ9Q20SqHC/JVgTbEg1PcxYu2cNYMVhWQVKVOGyG7QdDgtcejfHu7dPSFUAJZ35XARdaHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=seYliR1Z; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="seYliR1Z"
Date: Mon, 8 Jun 2026 16:31:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780907515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dI1yYWDwxfBsmdD7NZp4cbxV8GjskIG0GE2olREjgho=;
	b=seYliR1ZG8KEhYnnTdxMxGn3O6zOS0hJzbytnUpggxtFtAcvAu7DIIjag1vRAZO8p2wx8t
	JwKe6Fp3aUDvdbz9BJnSJ0ZZ0+xzQb+WSvVrcInMM1GNIvrPKJYyDtutrWOjKa/z2BHtS4
	dfQxwBxnrtb+6Wo2Ii/FNDJ+fwv2tQuc+vY79mHu/woop176EJufyDNibww+a5YFYaV09N
	RURNLtCauvDxKBXQG3QQbkX27iCKkqN5eF68x6lZo7VRYJwADn3yHz45MPfvmQTLx0XKAD
	ssvTsKnr74YlkbVXR6lEWN+xYwiw7ed6USw5bhspl78tb9MJEZqHv1rSIqjB8A==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tuomas Ahola <taahol@utu.fi>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 1/3] Documentation/MyFirstContribution: recommend
 shallow threading
Message-ID: <aiZ9hQ_SWTzxI3Ck@wyuan.org>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
 <20260603-pks-b4-v2-1-a8aea0aa2c23@pks.im>
 <aiACDLOtd_0_CCD7@wyuan.org>
 <aiZlu36Fh020L1Ip@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiZlu36Fh020L1Ip@pks.im>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 08, 2026 at 08:48:27AM +0200, Patrick Steinhardt wrote:
> On Wed, Jun 03, 2026 at 06:29:32PM +0800, Weijie Yuan wrote:
> > I'm afraid there will be some chaos.
> 
> I think "chaos" is a bit exaggerated.

Oops, sorry for my poor English, I guess "messy" would be a more proper
choice here? ;-)

> > As mentioned earlier, GitGitGadget now supports deep nesting of
> > iterations, if b4 changes while GitGitGadget doesn't, it would be
> > inconsistent in the archive. So, negotiation is necessary here.
> 
> That's a good point though -- if we change the recommendation, we should
> aim to change it consistently. I'll talk with Dscho (maintainer of GGG)
> today.

Thanks for your effort on this! Let´s see if the community can get on
the same page about this.

Thanks!
