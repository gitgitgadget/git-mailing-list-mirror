Received: from outbound.ms.icloud.com (ms-2003j-snip4-6.eps.apple.com [57.103.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093333F8EAF
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495015; cv=none; b=NPF/Af97VfJPhfneoYNonfnzXZ4DfMzrLe8+RQU+bicb1bM+0Meryk131urAju5PxO1qrGqZFdAVlOi1cUlEWnXQrqUVsg9qKCNQJVtpsTM/jQEI5OO5xEAQAjxnfzoY8ycFrlfDlSKAtnNgTNxt/v53WhP5W4cDzHGDr19ZiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495015; c=relaxed/simple;
	bh=7OkADUZNEZiduNy+aSAeSVIpg3iMnY6fyIjrs2mSWvY=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=sBNVnGP2x3zkgr0jJmoss3b+arjoidGGdLqX1bXjJ+GYe2WNsP7m1XJB0nhydbBnM+sj1/3Fb3APxSYg0lOP61AJVR2HPMEzI5XmhQIQiKAAxaw0nq0WncB59Ier1j6y0H7PMy691mgkBw/aMeaQX9gDgOB+GRTSSzO61eoIrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=sZJWSpz6; arc=none smtp.client-ip=57.103.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="sZJWSpz6"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPS id 350BA180010A;
	Wed, 08 Jul 2026 07:16:31 +0000 (UTC)
X-ICL-RepId: 019f4095-e0e3-79aa-989a-4cced3807871
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1BHV8FUxxBC0gdVQBLVxQEE1ADRA5ABlwKcwRUB10FXVZQAlpLVBQEEVABWB5WXloXXk1FCA9CGRBWAVhWXQVNGlwYWQ8cHUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNUBtfAkIPHBNWFRMAXg8PTA9PcVgEKHE2FEhyXQ5GBkN9TR5VdV4CXXg8cl0AXgNCeEpyLHcCURxWDVdDVARfThkMSh1SVlsTVRdGCQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1783494994; x=1786086994; bh=7OkADUZNEZiduNy+aSAeSVIpg3iMnY6fyIjrs2mSWvY=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=sZJWSpz6BIZ2RG9z4aHeekqMy0Ep39ZwWi8VI7q8mBM5IOQVLmXav7Bh/fXutozQ0UG/8eeWS/PveDYKwbtc7qWw8MQ/6LqbBrZngnBO7WG3ZtxC6zufgEwFMugYjYAg//LUd1ACdHl1YR5H0UgYjxH7+pRVlrBmu88ghrFf46Um6TDGITFTy+enOm6vOAgNRa5AKks/GZS0VyCOcCro08fmBeFI89uBPIh8D7bPdxOgA/WppSwodVr9BfeOUjtom/9bXUZnHwAKLthygxXQuEfpsp4Y6u8kGDATYvs6YEZXbu+C8G0E7BAn+sC8e+PmO4NpT8GskSuG8jt5vARc4Q==
Received: from smtpclient.apple (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPSA id B2A2C18000BF;
	Wed, 08 Jul 2026 07:16:30 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: krobchai wongkamw <kcnserver@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 8 Jul 2026 14:16:23 +0700
Subject: Re: [PATCH 00/16] path: remove dependency on `the_repository`
Message-Id: <67B53CCF-0A09-43D5-8B50-ADA07512A2AA@icloud.com>
Cc: git@vger.kernel.org
To: ps@pks.im
X-Mailer: iPhone Mail (19H422)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2OCBTYWx0ZWRfX1mLFjqZ8FAwn
 Mfpry/E7y8/ewUe8hlR3P7dYOMozXzzu3r6V0jdXndx6sVAFVRjiIARt/POeOYrDjqzLx5heiOU
 tIBI+fQV4eY0huZ1uQskGsopFv2LiUno+ysjo9Wzokk0Sc5tggxMFRgt7NzO+ITwM1xQlQeuQrw
 95wO3t89RRldivuv7wktynaFnRAzobRxe3NzrU5Sa2ktQGktHmN9cePdrlH45kDZC4s9JIDgZyd
 p2DaRuGlsCa6Pp/LRCed/6XxQiLowsz3NHjuVJ54trgNbD+Ve8LNimOdCoROYPgW4zsXL8UHDkx
 LDBxWDoI7Mu6KhY1/gf
X-Proofpoint-ORIG-GUID: aAuwtaGX6sna7e9sjoLxxS6kJ6BO2PYN
X-Proofpoint-GUID: aAuwtaGX6sna7e9sjoLxxS6kJ6BO2PYN

DQoNCuC4quC5iOC4h+C4iOC4suC4gSBpUGhvbmUg4LiC4Lit4LiH4LiJ4Lix4LiZ
