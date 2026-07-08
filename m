Received: from outbound.ci.icloud.com (ci-2001k-snip4-1.eps.apple.com [57.103.91.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84634404F
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494686; cv=none; b=fi8aSOT45SV3shQhiX6cSGWD1ibOTm3+pGv8CzZZzAYnysARq5cuurM2SXhZMqluY9fCca/kA5dulsw351he9BAU6rQcVQXOKwuKL3PxpNlUBibo0CGZLJFKepD5vl+b5J81hyhj2I9+a723HY+759GE4gIxLKhvQuMc1H2fOrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494686; c=relaxed/simple;
	bh=7OkADUZNEZiduNy+aSAeSVIpg3iMnY6fyIjrs2mSWvY=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=HsAmCck763GqX2XUWXbsrd68isWaQ5ddhLxvDjhzkHEJSBtDU7IBoO/pvv1jPwrlNVO7hdY5mCV4XmheJ5ZzQFoRm7wo3Pmz4Z874k7Ua1EUOHtRREaegTdusXGwbDhCmGCju5A1UbXY+VqbKHPknIik+a8kH9SB9Aq95pqnLK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PoDQSYIA; arc=none smtp.client-ip=57.103.91.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PoDQSYIA"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-4 (Postfix) with ESMTPS id 64410180012C;
	Wed, 08 Jul 2026 07:11:10 +0000 (UTC)
X-ICL-RepId: 019f4090-f817-7ce6-a700-3ada842df71f
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1BHV8FUxxBC0gdVQBLVxQEE1ADRA5ABlwKcwRUB10FXVZQAlpLVBQEEVABWB5WXloXXk1FCA9EGRBWAVhWXQVNGlwYWQ8cE1BWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNUBtfAkIPHBNWFRMAXg8PTAo7Ci8AKQtIFEx3KHJGBjV/OR4vBip3XXpLClQHL3E2DU4EK3cCURxWDVdDVARfThkMSh1SVlsTVRdGCQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1783494671; x=1786086671; bh=7OkADUZNEZiduNy+aSAeSVIpg3iMnY6fyIjrs2mSWvY=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=PoDQSYIAnkRVtQ9Hdsq+wavFdAdO9/mfADZo+XIW8LOJcdP+MzEbKAeh1y8vbrKuFXIbt5R8B3+7GrGmEbcr6IW2sPNDMISLREKGeTZUVN8I/ZYs8n89ncUSmfm9k1cGrrJnVsKru0tVQ9yLu6RARe7R0Ev/KnawEX14ASHjrc4JS/7EIqQ+ce8GSw6m+q4+WeNGgRcQ7wWGwFQNS0HF61GrdYwMygkILD8OztQbnqGlpPPvBZ3Gw3XqXP5kbu9rqGDwLAnqYAz7/DeJggu2BfK6h/al+TgDKytRcIwuXmQNVMOg0xen092xs9BS+2zssMQp43fWk2LKVlyXiTGV8g==
Received: from smtpclient.apple (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-4 (Postfix) with ESMTPSA id 58524180012A;
	Wed, 08 Jul 2026 07:11:09 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: krobchai wongkamw <kcnserver@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 8 Jul 2026 14:11:05 +0700
Subject: Re: [PATCH v2 15/16] environment: move access to "core.sharedRepository" into repo settings
Message-Id: <3C9B7B98-4DEE-4EFA-B1AE-C3990DCF467F@icloud.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, shejialuo@gmail.com
To: ps@pks.im
X-Mailer: iPhone Mail (19H422)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2NyBTYWx0ZWRfX30Go+3ht7V4B
 yR4uOsQFxftGeI/V+sXc6g9j2QuekIIZQO618j3SdoJg8UaNZod3EOYhzaQZFJIXdk9Rctvl1pR
 SS+ZpM5nCHDC3l/XO6kYPZbD6zT3ThndtpNn2Zds298tNpxDDG8+TKFJLAQ542ktPzmCLoTQyaL
 vpm5+70okaDaSpcn7pUMomsuov/R8ogHEYpsyeogM2Wgp2QE3qAUSEcebe58saeEnY+QenuJw4M
 Jf9j95Rk2Nk+oNG/I8YSJq8dzgEF818gewz0xF+VYV9psVx1jiLdk51CI23iKJpGgO6mmGH+G0/
 T6jMGyxl5kSwy1Lq965
X-Proofpoint-GUID: NbVElPdjuqH9wYMLrDPli2CVh6aftseK
X-Proofpoint-ORIG-GUID: NbVElPdjuqH9wYMLrDPli2CVh6aftseK

DQoNCuC4quC5iOC4h+C4iOC4suC4gSBpUGhvbmUg4LiC4Lit4LiH4LiJ4Lix4LiZ
