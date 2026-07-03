Received: from outbound.st.icloud.com (p-east2-cluster6-host9-snip4-10.eps.apple.com [57.103.76.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026321E1C11
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783101874; cv=none; b=Nn7kjNAU7o5cWXhrgGUDevYHVzuJP3fqJdk1/bwwh8kc71omcotvKfjciKaJSF5OX76O6DmE/N8zl7Lx0o1CH7Ja+uhK3E5BFprM7S9e3BrdBRP+N0lfmXGR9UWphaMCqFTy5QJHQpLbWlzZ+8TAaR6WWooEJRniE/5Hvs+svzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783101874; c=relaxed/simple;
	bh=7OkADUZNEZiduNy+aSAeSVIpg3iMnY6fyIjrs2mSWvY=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=rJgCnGoe9PBXnWkqdbSmRObumLBic9eowemfYNgYT600AnVvNNPlGTXr+Tv+5frcHzxhvH4r4Q+dnFvD5P5FFFC6ny6XbMJ798hRs6oHPlDn/wMb1M9jJdVUHJbWmBImUXLSzBStYyyAKYNMmijk2jU3emeVu0zaqBQlSovdlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=sIdgor7D; arc=none smtp.client-ip=57.103.76.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="sIdgor7D"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id 646221800109;
	Fri, 03 Jul 2026 18:04:31 +0000 (UTC)
X-ICL-RepId: 019f2927-550f-7103-b3ad-3e48824f443e
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1BHV8FUxxBC0kdXgdLVxQEE1ADRA5ABlwKcwRUB10FXVZQAlpLVBQEEVABWB5WXloXXk1FCA9EGRBWAVhWXQVNGlwYWQ8cA01WWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNUBtfAkIPHBNWFRMAXg8PTApJAV0AWgNGFDt1VHFGBkQMSh4sDi8KXXhAClQAXQs2f0AGXncCURxWDVdDVARfThkMSh1SVlsTVRdGCQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1783101872; x=1785693872; bh=7OkADUZNEZiduNy+aSAeSVIpg3iMnY6fyIjrs2mSWvY=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=sIdgor7Dx7zfVye/1TUBWbyMcu0tyk8WpogqcSfKO14sQLv/h5e5lB8J8Ikjg9Jub+pP7Sqh+xvDRky1R6oQrTPSt+0KXZJRkJjgmNvXj7orFSEljN9UrPr0K9YxmxNXBOfx8LS9zV44FrbiSXvNhJt7fDGVbtKXpkW1TVZkmF3xoJfbxOBWWJKRwbW5gjhCRyH68QawRnq4cpc8N1r0oBr8FKkPpF0iRgYzgtpPMK4QbWDTS1eAXzlbKuNhw8bSkHBEGX0drJa9+jhClle/TWBHVGEdztZ/8FVJdmURdfU3ZLmOptMUAjbFy3onlCKci5IY+4Tc9DIzjplHwsn+zw==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id 5868C1800120;
	Fri, 03 Jul 2026 18:04:30 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: krobchai wongkamw <kcnserver@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sat, 4 Jul 2026 01:04:26 +0700
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Message-Id: <31207116-CF9F-4452-A9D8-A899769FF853@icloud.com>
Cc: ae@op5.se, git@vger.kernel.org, junkio@cox.net
To: jakesteward0916@gmail.com
X-Mailer: iPhone Mail (19H422)
X-Proofpoint-GUID: vzrzCQbzvT5xhthw6LCw1lAAKDt02tPR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX6RyUb9meYSGK
 X3rJOWIRjeu/3/Gd89mS2WVv7nfZHygfxBJmQGbCP9RYV+XiFh3K/NMVJQ3dYewYKgDuwJRdYJy
 l6pXLQn6kCuM8tKlytO20p7LnyQdx3lvxd6hN2AZ2074wQyabIUeVlkryNDC7pNiSSWlnuaeqhc
 j9WAFgpCrgUUL/LrrQNgR5GfttpAGnBhmYxtYX9NBfP5Dh8FWOCczsN8O0T7irEnQDlynutmu9m
 kFgpYXXGjZRdJPcIH5iz1yOTTcs7YJ6wtbEaTErWckvLEyfFVNVGOf1SVtHTerdWc7iVRX24wut
 kIWZycrJ1AjF0MZ/Mjt
X-Proofpoint-ORIG-GUID: vzrzCQbzvT5xhthw6LCw1lAAKDt02tPR

DQoNCuC4quC5iOC4h+C4iOC4suC4gSBpUGhvbmUg4LiC4Lit4LiH4LiJ4Lix4LiZ
