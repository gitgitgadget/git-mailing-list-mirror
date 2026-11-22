Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795381406;
	b=bHnmlXbTDW45mjA3xbjOgJ/HPTM37FSF80erwjolQMm9le+Q5xS8QxGMK5HhKDM/AXWD
	 50CB142srAP9QFKapVIB9rfjc28crKnxj+0Kt6E2QN2wwLcn0PGNOAhrZZ8AhC62FyFPP
	 vmVWG1vSwMOLlrIIMjeKt3CIFIuIj05MWVQZPaIHErD4F1U/vXndZV5CXsnNyolUOAls9
	 vN9SQwy229pRXjlAYhoLKTa3+IKepoHKGA+IieF66E4biHwxKNoUW8/m99X/TzdWgJgho
	 BL//4W+Y3jARje51Fe9Pcsd5IEs+3TDOg9FqMKeiICfET7HZK0iDt6kbBzLxZ3tItkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795381406;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=+fgMbc2yqTimdtGLb8AD7uRVtQ0AsPfQITtQXZiy17k=;
	b=5m356K4UBucPHCu8Lwiy1IMmPbeNhBQmzYKcf4SZbaEFZ7UfYja37tn2CVSsfOQ2hJ37
	 QBX/7gscGuUgAQmB+9XCsO8SwSvgxyhVmE4zNl8Lrx/vJBxfbVKsw9YUgNqCrA55z9pUy
	 qz2JyzY6u/dhsUn4lhgcp6wnY7A6NgQVe/hALpGSassBC56oVKMRxyMltB9ZlA7EpFUOL
	 GJj0RV3w1Vwxz5/Icu5WqNC+r2ylXfV/yALorv3m0B9gbTQsaR1PvpE8yDy2rj3WdJEX9
	 2mxCaB/Cz1+7rsyLjxTBPg1gTkcHct6Sd+Qgiq+bcpagehSsEAIrRmNZ+H7t49oGDrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=EBQ6h5yR;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60457606A31A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 21:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60457606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=EBQ6h5yR
Received: from localhost (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AML3Mvo2253570
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 22:03:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795381403; bh=+fgMbc2yqTimdtGLb8AD7uRVtQ0AsPfQITtQXZiy17k=;
	h=From:To:Subject:In-Reply-To:References:Date;
	b=EBQ6h5yRrV8iZ+jPCjXM8Ow/1+HgIWLVuDzugdj8Oku9RF8m54Ybt2E2Hq1+rlHeq
	 4O9HwxG6jwEM+OwWdN+wFPcczq25eETzvH1SZ0pBsTVaNzSvgopre5x/RTuvi2rJti
	 BhwM89PcVgYteY4UXJtnEO8EXFrIAPupiTVNqaUs=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Subject: Re: [BUG] T7527 fails with 2/70 tests
In-Reply-To: <gh1p8cmwxf.fsf@gouders.net>
References: <gh1p8cmwxf.fsf@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 22 Nov 2026 22:03:22 +0100
Message-ID: <ghwlq4lgth.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 22 2026, Dirk Gouders wrote:

> Hello,
>
> I noticed T7527 (on origin/master) is failing with 2 tests
> and before I start digging I want to ask if this is a known problem.
>
> What I already saw is a core.* in a temp directory which (among others)
> causes the test_cmp to fail...

To be more specific: the core file says, "git fsmonitor--daemon run
--detach -" is failing with "BUG("double remove of watch for '%s'",
w->dir);" at
compat/fsmonitor/fsm-listen-linux.c:144compat/fsmonitor/fsm-listen-linux.c:144

Dirk
