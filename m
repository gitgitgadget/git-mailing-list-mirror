Received: from mail.marc-jano.de (mail.marc-jano.de [116.203.25.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354B28504D
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.25.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140578; cv=none; b=ZyrGeBCqQNGZrz3GzULAeVQLwTiCOqEiA9R57ls9iUzSbTRl1xm9I/B5YxVJA1MzLUbCd3XfIm2pWGwBhMgtZ+5UUO7NbgSCUsqKlcGWV5hquxvoYrv+DCLrmuyFrEG+3A56zDpkMZLLaIQdk5gbVKUdMklhm1c2ds/A9JlGtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140578; c=relaxed/simple;
	bh=OqAGiMcotuksxVWfvO3RJ05s1vSrKtPE9TDKVfvZSK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSjvGqjyoMOxkn3LOs8sz56XtJKQTylxy7dJTfymg4LG+RxNxAcGf/2v38yO96h5E8DU1MJVu5w11cnDlhw33KF4WgDcSoMSTgg869siTGGCi9scoedaS6cblFx2vIoEtE3z9yHs80z/w6xQ1VbmY4HFo/62I6qnULMwK55vVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marc-jano.de; spf=pass smtp.mailfrom=marc-jano.de; dkim=pass (2048-bit key) header.d=marc-jano.de header.i=@marc-jano.de header.b=D9FXQz6r; arc=none smtp.client-ip=116.203.25.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marc-jano.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marc-jano.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marc-jano.de header.i=@marc-jano.de header.b="D9FXQz6r"
Received: from pc1.trash.bin (IP-045128182188.dynamic.medianet-world.de [45.128.182.188])
	by mail.marc-jano.de (Postfix) with ESMTPSA id 1E3EF85BAD;
	Wed, 17 Sep 2025 22:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marc-jano.de;
	s=default; t=1758140567;
	bh=OqAGiMcotuksxVWfvO3RJ05s1vSrKtPE9TDKVfvZSK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9FXQz6r4/sDI8lZlRJm7vug6yWpz/XnQF407s8YrSI25ECMAWbps5jNG2/vjHPbq
	 HKoktgaU2fvpccjuixNMoGB81o4xU2rcIUiuk7qYZaiZJ+Jh8rAvZ7BosTknd9lEGW
	 m6jai0wiJOX4WOFTpn2av+izw0GvPiai3f6JyrYgl132VinaRFaCozII9DBW49Oa7a
	 fyCexCWTZqt87uJEOCL8KlckCh6ZWU4LoGtfcUg3MhnkssJUwUI2KTDBwwIatfHmKS
	 zkO2dRvfWr+JXBF6PTdLz4QNSBWj9ymRQFwvdihNjUCtWPGTAm4bsv1IzRUdpwGavl
	 k24TonGA2DgUg==
Received: from pcdm2.trash.bin (unknown [192.168.4.71])
	by pc1.trash.bin (Postfix) with SMTP id E44F91B0810D;
	Wed, 17 Sep 2025 22:22:43 +0200 (CEST)
Received: by pcdm2.trash.bin (sSMTP sendmail emulation); Wed, 17 Sep 2025 22:22:43 +0200
Date: Wed, 17 Sep 2025 22:22:43 +0200
From: Marc-Jano Knopp <y--gitbugs@marc-jano.de>
To: Jeff King <peff@peff.net>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>, 
	git@vger.kernel.org
Subject: Re: [SOLVED] Re: safe.directory does not work at all (git 2.39.5,
 2.51.0)
Message-ID: <vuldcnyfwo6nii35kpwzpjws74hvgbeesovjpq4r5n2244usry@svmiikrnpviu>
References: <duuus2ifgydpwpja6vccvxbcnxdgy6mc6h63okzv7xdqo23fpi@ermurkhms4j3>
 <lamzerhpp6kbgzbhztgaqvdcymaqvec232sen67t6wx4rmobih@lqqivgroonmp>
 <hbghuae56gm6ypox6q34mt4q6awoeb3itxsnmgpouycn7qodch@4pjsh24jhmqs>
 <20250915022301.GA593748@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915022301.GA593748@coredump.intra.peff.net>

On Mon, 2025-09-15, at 04:23:01 (+0200), Jeff King wrote:
[...]
> I dunno. I don't love either of those that much. And while it could help
> things in general, I think the main clue in this case is just that the
> error message refers to '/git/main/test.git'. And that path is only
> meaningful on the server, since the url was my.server:/git/main/test.git.
Good point!

> Knowing that the config advice is _also_ coming from the server is
> probably the key subtle bit, though.
Yeah, the keyword "remote" would probably have been successfully caught
by my brain's pattern matching algorithm ...


MJK
