Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702570;
	b=wM2EE9Qzs3Y6HSM8W32pqEPFDO5UZei29wfewpOff4F38In89reAPdT45jljY4o5O57i
	 XRa+/psw5l5j+flfUfRJyz2zTbIsUCblNKrnZCrTeN2hBShB3ZYbwk1vPYWy+RWtnwvit
	 Zk/OKWHdqeMbuQcodviEn470sVQzGLYavuj9KwrqPWBd98/OB+REZJAi9csd8p/FK10NL
	 vsUzq3RXH/BqXUCirzT28yM/3Heo09VTEG/mUxkr/NZpGgDcZzGGJPwNiKzrQVwlllLQN
	 L/8gw1zd+spHtzzr15WM8/R+V/ky+Qqw26CkMxEvK5nxgn2u/THvMmdrcjCE4H4rtIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702570;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=Kwu/DeSG2obRO4b6Cwx9/AVkOFUOofhj1RCIaqPW96Y=;
	b=HWZirTnFDXNCfq7VhfzJ6mSs+d/0OnspgsQ/rlzd7wj3eBL40aJJNq8HnoLKyR09D6D2
	 7qdfXI91lHQPErqQ14u3UgVGanywpRgyhgNjN1rfyGXLI8kWk425fzUO19E829ecvgA/S
	 yekcSh2KaEEfcfXEO+Q/Pgvi3wG6eZL+tIXpVCbsCzMeYpxAU4yeiWE3brJ65vfKbLbPY
	 4AD9VAMLM0RBGAZKPbA+/hLPVyirgJNsigzeED9ZpdXS6xhHNaVYxQ7jk+SkAyzx5NYjM
	 +hYAs6qBvljoqwTm1+4axBTpWTzoVrVdHN7nraqzg58Qhp80eeMPeFJ0hHmLJnFE5BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=S08ug0X2;
	arc=none smtp.remote-ip=95.215.58.192
Received: from mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98620606A323
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98620606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=S08ug0X2
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IdPSoFIJ9bdx3BTSiunP9e2y+jToNdTPwRaMutP/+MU=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795702567; v=1; x=1796307367;
 b=S08ug0X2o5SCCzi2vTKnygz/ECRYPvvFEMQNiiypXaDXm5BTW6M+1Uvcs5YgnCBBlzIRtBEP
 VXLSDT2qOkr9T/5smlvrL2Ovd2nZfxnY3mnpDcw81N36MVip1y0vn8eZpPFEDUzYtfq9rjYIgdP
 A4EY6sv8CcGQDqddiZPhBvqM=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id bcea7f154a176736;
	Thu, 26 Nov 2026 14:16:07 +0000
X-Mizu-Trace-ID: bcea7f154a176736
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/6] packfile: rename lifecycle functions
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-2-19beb83b145f@pks.im>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
 <20261120-pks-packfile-global-statistics-v1-2-19beb83b145f@pks.im>
Date: Thu, 26 Nov 2026 15:16:01 +0100
Message-ID: <87cxrrsmou.fsf@dev.null.iotcl.com.invalid>
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

Patrick Steinhardt <ps@pks.im> writes:

> The packfile subsystem is kind of the wild west when it comes to
> function naming. None of the functions have proper subsystem prefixes
> and the naming of `struct packed_git` feels like a relict from the past.

s/relict/relic/

> Ideally we'd modernize all of that, but that would lead to a huge amount
> of churn. Instead, let's improve the subsystem one step at a time and
> rename lifecycle-related functions to match modern best practices.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

-- 
Laters,
Toon
