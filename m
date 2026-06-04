Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06060359A99
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553813; cv=none; b=aSzavr/Aobos/B3kpcozl4Lgd5gOA36GohDIljCNh8+EEZcl8ZHT+rrRgShWPZ19ZqiDLcDNrx2M/9aV77bagpp8mTuQkZS3UpDHMMAVnAKlfljmfI8oX82gQb56qyTfT9dSsYP8X79YIPVH5w1m2YLOfdzlSh1h4/ouxOpH2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553813; c=relaxed/simple;
	bh=/hGUDPz2XwG0maV6dMDktpEuZjNQQc+2dBcmZ3RV70Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ej+ORaSTFS9feU0eUi4nNJphAkT9LBQO7m4jKjukXax6wFbd4mvXfcSyPEKzqE4E3Kua0ueMwwQVByzfIlTrM9px2oxUrwjBwaoIxBjEGdaO66EmISkmW2mWySWPwVT2RPC0FAFo/bMPaA01p/wYWr5LPgpD3U+iSzjTTko9FgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qqa+6LkK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JxEUcC/z; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qqa+6LkK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JxEUcC/z"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 297D0EC00F2;
	Thu,  4 Jun 2026 02:16:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 04 Jun 2026 02:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780553811; x=1780640211; bh=8DFzNy0yXo
	M2ObWz+OzVfxQCYTHuV1ya5UE0GSpg8e4=; b=qqa+6LkK8DV+9KT1tCYDfKtWkh
	FPMKXBiWKWEoPGZNai/YiZHfarPv2Y3IZJIpbA90TqG8VMml0gYZ5edC1+fAPrdr
	/WdPzSWX6dPWs5i1sAHdeoEm7kXhN+7Wmc11rA8lThcz3p4frbpPIV2NLBJZDHEi
	a6CNzWMX+oeuXi7lZM+94bhA3N7sK7jnE+oOlMSOGs3ryj5R1UdYSLVpNl686SsQ
	p5hqkt6QO5A5wdbxIV0sq2Ch+7hooMGysXGusTCyu1pP4oSvYrP1sp/J9rMqx2+J
	6ncSjUVD305alFdheTOAHeWX5zgZxjg8b/zNlFjxblVTHqC046/OlpsJiTlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780553811; x=1780640211; bh=8DFzNy0yXoM2ObWz+OzVfxQCYTHuV1ya5UE
	0GSpg8e4=; b=JxEUcC/zNTcr1JoYcuVkuqwMeOfR6VQyYG8S0HZgaHHfpxn/irz
	iQ0OMElfgcff/yxSyxkG71XsFteTTFqDJaEd2E0RAY+w1ihG4iS0IrhS01bcsm9v
	QFMgZebmeP9R+cB3RaPSDgA0nDxMvgEk24u4Nkp3FHeOzS/QD8zcl6JmuaUiwWhK
	2kgSQBKiDjPYBtmH4jvTjgoCcCHVRP4/nNTsBg3ihgMmlsuxvQPas1ffhvfrjGnc
	NFdx7n1apVVxRMma7w9RBhTkQeaJyh1gWS5PsuFSMd4IxRSZ6cjcXFun5zGUUwSN
	wMOj2rpiWmOpjPVRwEAnFn3Azq2YkZyeMOw==
X-ME-Sender: <xms:UxghaoWQXwtOXeLYGfsuHGxLd6tN1tFS_aLd22-ZiDUNY5B1BfdqEw>
    <xme:Uxghaimmtxx-zlUHbGf0WPVId6i2_Qrhmzqzq64be0eE4U_osM1WCxuyYsDoWQODf
    ODapWwbbP7zZFAPwjllKISIH99APo2zgoeaPs2rjd6jq1G382QSag>
X-ME-Received: <xmr:UxghaqCLjymObexXZBSzQtm4j_QMw2975g4WGyKYaWsKbhgEtjONZhpQMaHxYOYKvKKF77f3pZCZo_zlq5r0z29ZXCFgIcPhAIBwmxUHEF0>
X-ME-Proxy-Cause: dmFkZTFBHZfeCXwpmO/0xWiHXUUmTOHPXluCVCYot6MWPN5J4D/QxYbVp0ZaCKinkP0OER
    WiSgitynkWfVSfrp72U3KrXqjUid3LdFkGXVvSadzzvl7iw5wCfPvPh6HxPVFoZt4n2gTg
    IvNDvHZTGYyvI5U/9MBlfcvomjYK//QGS+rPukZIAMWUOIAN8arnzgGrgNqit+FI+qnz1B
    KYbgrxbO1z5fwF//Y0O2vf9jcdqYDzI/6U3zdlSMTCGAfZxkczut/X0r5L2nZSrFk7d+2O
    Cr7SoDUj9KAmYvkLS2kgwWVJnmejtMAi/VoN8JvPubeu614L/LLhlswGnP7owAkRH1E9IX
    E+qGyQlbyouvhPfkqrhw0BHPI79JaIffhYJwDBOFs4LCPK7DVd6Qz+H4CgwqOog489czci
    cir9B54caUgTcsEnKHlZifay8KJjrtqsc5SaZxm7DV0SERU5QTsCVNKDhjGv3u10mSzHrb
    /0aEaYrVT5v72E06ftcVCkFXTRMpDcVSSXo7xqvjsR/j58dL8ExoY5Iwq3+gu4Ku6pFi7K
    MMAoKc/Yemp37iIXBx6XGm5e1vV/8lI7UVMoSNj4IzetH1Zla0YXDf7t2apQrBGwtY9vpJ
    XPQuUUe6PgxAU3eiwPyzwRwRyknqeiHruu2K8Y9SbsZhKKcJ0z2gSP08sngA
X-ME-Proxy: <xmx:Uxghaid86khE5K-q-VQJi-XqFl_5uQTtxbdOIXBCOaSUhfBbEdT82Q>
    <xmx:UxghalJkHOdRml70z0f0vW-0SKg08scbDw2chFEuEN0xh12IuzUweQ>
    <xmx:UxghaldOaB5eONZksFMNoDlsiLF4IZ0H85K1E9kLBkLmV_qbzr5I7w>
    <xmx:Uxghas03lC6lLebJfkDixZEFDtx6JSnYcJx01hqRkYCMG636ucpltQ>
    <xmx:UxghajtF6JXu-klhnrm64RH4xN2Zbb7FsL9gH2jQNjxBSEpCZwNc-T71>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 02:16:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7312bc41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 06:16:49 +0000 (UTC)
Date: Thu, 4 Jun 2026 08:16:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2026, #02)
Message-ID: <aiEYTkwuSmStYCsd@pks.im>
References: <xmqq8q8vowvt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q8vowvt.fsf@gitster.g>

On Thu, Jun 04, 2026 at 11:35:50AM +0900, Junio C Hamano wrote:
> * ps/t7527-fix-tap-output (2026-06-02) 4 commits
>  - t: let prove fail when parsing invalid TAP output
>  - t/lib-git-p4: silence output when killing p4d and its watchdog
>  - t/test-lib: silence EBUSY errors on Windows during test cleanup
>  - t7527: fix broken TAP output
> 
>  A recent regression in t7527 that broke TAP output has been fixed,
>  some other test noise that also broke TAP output has been silenced,
>  and 'prove' is now configured to fail on invalid TAP output to
>  prevent future regressions.
> 
>  Expecting a (small and hopefully final) reroll.
>  cf. <xmqqtsrlw09t.fsf@gitster.g>
>  source: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>

I think this status here is stale -- v2 didn't have any comments yet as
far as I can see.

Patrick
