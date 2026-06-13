Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1730568C
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781359705; cv=none; b=Qi5kfokTjO245X6WUpPK5IgtJLHTZykxUS2jQSXddfsGVhjLeCcx2tMnPQ/NNk7Lo51WM1sQKqBEYWDnBKwLzwQYvFBiW4l+77VVtULieXpH1m1CcfVj4pQAHZKT2bq2emLg8qKLfOVbitt/ij2rJ12Jmw/uINAqEAfYs2lpMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781359705; c=relaxed/simple;
	bh=18RyCzF0vg1qeP7K1AfzIjj3Uyr5ODI8eLrXAnuX01s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qgum8rHM5Btn6KbCOUV/UljqbBuPM+JAc/7piXflYNgXFrJlnkHQ+DAf5KZz7j57x9VZZPvLC4F577ncuFPlholk1/EXuWYdaIKepMtJScbvly+ZbXYnVEg0O2xgNDo/XHAc0f+jUYXGYRpi7qjrErVPqG97RlaTVBbIRtxgYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=OhH7gAOH; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="OhH7gAOH"
Date: Sat, 13 Jun 2026 22:08:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781359701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=f1NMgaX5jn4iUVEEjuhLKtyYKYuu0GdkpSY8ZbSYaF4=;
	b=OhH7gAOHdzUkKfkN6Yf1HZk6UCp0H3R1ro16HZzZXwVDj3m5tmLKiJMXH5Zt1IHt1INrjf
	+6xSJ1uDL8w2BA4VSKj0pC3S3UQJXjtrqEXde3X2Mwu7o9BE1tjB60Gs6hEq7hFveUwLAf
	4P+klGFJgNJN317z4QpA0mPBAR5E9zVjv8LzkqqKuFonp5SI3tmDLfR/LHT8diYDYmfbu/
	uNSMEA1uhbaa0Djpu71Blw3/gRnkhD8NytwqFAPbW5uov0SJ4J53zFP9J4w1SOx8L5gSsb
	7mEtvEXUyr/Un/kUMn2apZgQoSAGc5Stoend14dBLeVBhm0aIqj6oZHZKPWmtg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Subject: [RFC PATCH 0/2] doc: clarify review replies and reroll timing
Message-ID: <cover.1781358364.git.wy@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi,

This small series updates the 2 documentations: MyFirstContribution and
SubmittingPatches.

The first patch clarifies that review feedback should not be answered
only by sending a new version of the patches, which is talked in [1].
Contributors are encouraged to and should discuss their planned response in
the existing review thread, so that the next version does not become the
only place where reviewers can infer the author's reasoning.

The second patch is originally from an email from Patrick [2], which
documents a rough expectation around reroll frequency.

Patrick suggests: There is no hard rule for when to send a new version,
but batching feedback and avoiding multiple rerolls of the same series
in a single day is a useful default. The text also mentions factors that
may affect this, such as the size of the series, the depth of review,
and whether the topic is close to being picked up.

Since I am the newbie here, please tell me how to attribute the credit
to Patrick. Thank you Patrick!

I am sending this as RFC because I think my wording is quite rough, and
there must be a better way to express all of these, including how to
manage the structures of both these two documents. Any comments are
appreciated, thank you!

[1]: <xmqq7bo5nf31.fsf@gitster.g>
[2]: <aietF4BX1Ewt3cpG@pks.im>

Weijie Yuan (2):
  doc: encourage review replies before rerolling
  doc: advise batching patch rerolls

 Documentation/MyFirstContribution.adoc | 27 +++++++++++++++++++++-----
 Documentation/SubmittingPatches        | 17 +++++++++++++---
 2 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.54.0
