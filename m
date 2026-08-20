Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42B35C19B
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 05:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203573; cv=none; b=dk2pRiefBvGtYgUrAyreYap1QwQ0AGqYCnZGjkkKNk9r4k5bCzFuQ8WRkckkrYLVy7OR/3HUNH4D9iQ4ho1hVZHS8ClrqmCx1Pqk6J+eAYZsfzvNJt7gnbDoEela2NT9OtkwY8cspVlT082xw/GY1lIxEJ27s/cfA3GvW2feYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203573; c=relaxed/simple;
	bh=T1oGfdABr0WOuoGTSi98Fo3pITJ/RkSW4TDs8qg6U6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF2YUmWIR5bx4ABu4C5p5WsRHPa3uas2+2uS2easqiJXhChWN5K0wh3aMMvBalYuNbhnZ1LJOoVkO4EzT+50k+5h+G8RMCa/oJgT0AR5Ya0jaYkU4KmvyXFj5kkQ8ZiKgrfxZSBy42WjLTIY9l9Abr7zVxmfF8RmOEy7f/CFMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=inSdyZwK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QGSV8FHL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="inSdyZwK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QGSV8FHL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 85A32EC0184;
	Thu, 20 Aug 2026 01:26:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 20 Aug 2026 01:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787203571; x=1787289971; bh=qAz1Bm6h9v
	bDIDBKYUT1vaKcTFiJGuz4/oZBiY4KIOs=; b=inSdyZwKcBtp1jSCDZ2WEepKBN
	fP9rd0EBnwu5SzVhEa5nI3pdBK0kILYwCdl/JFX7FuF3JBVYsPnLhKsZxYHWokq+
	9sDDRqfsiqt9v7KIK+CYvJ7Iiyw1+6Jmhw9BtpLZxBt6hn+w8ZofPf6+s0nFwy9T
	oGoSGsrcm6Db+Gui7Uia+gfNiJDwQlq3auwIgiD8dNartEDr/M19O7RX54GgqUh+
	SAUVXrxGuVQ1qV847BPLVY1dqh63CmDF3NdodQ+5bcTnTDpOVFcPjdM5vBaLbh/j
	IWTLvJ7bCWmM1dqclVYxBDitKm1RVGRizPOx/DkMBViAs9LfuRvenQ/Bipgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787203571; x=1787289971; bh=qAz1Bm6h9vbDIDBKYUT1vaKcTFiJGuz4/oZ
	BiY4KIOs=; b=QGSV8FHLIBthE2rpzSiYwhqaNWvl9E7QUeedATHeKTAot+6538s
	r2qIJc5OT6ruL4MjjmQOx4Bu5uGYh0/Fil/hFqhzsJl7olthTovVuO7hqwCtEugj
	RUhato5/EBloMgDnLhEVriA/0Q0IImVAx/ocAAhZR46Yegesr/lmF4tMKK9ReFS+
	MMXi0lqoOkptHtO+Yj9Pq8gzoul6JN0Nc8aZjyFEi6rWw+gX24ISf/AClYJmJhbC
	RgkYlow/nYtTJEuLQciS6wk6J2J+J58GcY3r9wz0A0fusFYLD0QyQ6lVi49ABU1s
	4UwaRSIfKA3tvVh7wnDuMkt5IgjH80KYGOg==
X-ME-Sender: <xms:84-GaprvrzIjCqdR3w6NBtHtlF1hT920U10R9gtg03fTnuGZG54iAg>
    <xme:84-GavWhlguAgM4qGXQU4Yk9gdtwF6lwzd4Paa9O0CXP3SQ0Q576-FzMkoUoHZfZx
    6RzqHwiyFtCbSk5umJLz7BbccjG-irQzIhneLxNb1H0j3XwLniZZQ>
X-ME-Received: <xmr:84-GagBuRFGd-0LMUyy3kcEElMluehtxtSzgPWqiB3t_3-tASCSlygN2vsTWpmBhhPWvgETcZ5K3ccDN-jOTnIJfUxP_82q3AUNeYEzWGw>
X-ME-Proxy-Cause: dmFkZTGV8bkqfBelKrEOYTxuCFFIV63oXdx5RJ/De3GHfYnihzUyCDPp5hEoaFVv+PyWcd
    yZhF2ArDYnEH4TvS6Uqc6KOwer3MKA8FqtckWW0GB5VDYCxDOHDINvZm70LC5N6EjrUFFT
    XahfYaMioJK8dZBvJAXNuGIbGnAUqcTRWbgVkSzMSyFXhI1l31gE3G3GE/sHb8CI1HS6Oj
    hrCvNmcEqPm/rHXpmRyrAQFjTYY9Aa8KnLara3YkJ9vGB/QRBIYl+kuCtxFbCUpbRgTtkZ
    BSfDghJ9xjnnKG1EW3ID43WEzCIkJw1FphpOEO4HeGwpcWRomYswGgjEWy7nzhKknufMSa
    QhNVW0vfceL/ewOwsKNfi75Qyg3XYE4nWW71qKoJXB9rQCYCw+58DUGfeQBeUYAZtFIv46
    AaDXvkv0FJjrmbZdhdo1XIXLs5dJZLBN0RfLTlYi5Z1/IWqoWEIu81L1E7cfd789ZKQjs8
    4/6QztXINZm27YjFJooT88fqF+tQXYz9MZjSgsKWX2hs+GAIJiD6//tuPREhHxbrv06VpR
    mD27pqvnxjKR8tD5Mar/H9+f8+CQhxc6lzUxMkElnQETD9Hh9JYl2OJeRx91Kw79Ih89z4
    +mclHd1+XPPd1HkVoDJAf5UNTlTjG92DpSCmXvkG84hmY/mDKS0YDKqO9s7A
X-ME-Proxy: <xmx:84-Gar1F5GCllikThOX_pwBECoxmIzD7dhWIm5J4bapF77AYsh1V7A>
    <xmx:84-Gaq1Oi-7FTZviSSs7ghhG-lVXHHzbs03NvK2nZ5vaxJLbLgVlcA>
    <xmx:84-GaoAMrNYuXrihxBjKGHrF5Yi-FVZuGxoE8wOUH_i0tRY8_6fiWw>
    <xmx:84-Gah7JhI6spPqe-Rr8lDuc23akC9uhjivDwNf6LrL5L0QXow_DfQ>
    <xmx:84-Gaj3Q-JkLLq-iehW3Z9J9tSnVINRFJIpCJBoDiD_FR4eOR1HzVWiX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 01:26:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2760cdf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 05:26:09 +0000 (UTC)
Date: Thu, 20 Aug 2026 07:26:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	Todd Zullinger <tmz@pobox.com>, Tian Yuchen <cat@malon.dev>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v3 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <aoaP7oIrR_Bpvx34@pks.im>
References: <cover.1786103607.git.ben.knoble@gmail.com>
 <cover.1787065125.git.ben.knoble@gmail.com>
 <48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>
 <aoVoJ3Ijoaj3u64e@pks.im>
 <xmqq8q62w0gf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q62w0gf.fsf@gitster.g>

On Wed, Aug 19, 2026 at 09:15:44AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> diff --git a/environment.c b/environment.c
> >> index 6676e6f5ae..c7f6b801f4 100644
> >> --- a/environment.c
> >> +++ b/environment.c
> >> @@ -571,6 +571,13 @@ int git_default_core_config(const char *var, const char *value,
> >>  		return 0;
> >>  	}
> >>  
> >> +#ifndef NO_NSEC
> >> +	if (!strcmp(var, "core.usenanosec")) {
> >> +		cfg->use_nanosec = git_config_bool(var, value);
> >> +		return 0;
> >> +	}
> >> +#endif
> >
> > Do we want to omit a warning in case the config is enabled and we have
> > NO_SEC set? Or would that be too obnoxious?
> 
> Those who use a $HOME/.gitconfig shared across two machines with
> different builds would be annoyed with one of them constantly
> complaining, I am afraid.

Yeah, that's what I was hinting at with "too obnovious". So I agree,
let's not add one.

Patrick
