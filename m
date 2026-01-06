Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC9F1A9F85
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694254; cv=none; b=CE5nOBxeR4+SH8Eqdi114Za1JZwNxlPCRjADiTL4PQjWpGgkIWsGNvnHLD0w9VD67ywWU1XX1ynoodthOM2Sx9MCzkR9EG9xXb/jrNzlUauIkH8vteDa00mI10fpr4dfW9wYrN1lBysPi0Qx/otMtCbDHeCewW7IoqQNYIcA/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694254; c=relaxed/simple;
	bh=xIbXtv5epJ9BQescNICK+QqaIHRTRNpOs8NdLMNZRMw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BjaLbGbzW5x8sKS9ZVru1KDD8x4ENS+iGOcNqOUSkq7oi92do1bMko9JLDYd+IDah47xjwt0JYW1azBi1VHawhxYI5gNYdBYY46+zdWUMSdTP+v4jVyUmP+kqHEcgMht2jtuOGB3bXt5DtYb225VlX0ATEuvdJmIsUTgJZJ67sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=A28/8zV2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="A28/8zV2"
Received: (qmail 600939 invoked by uid 109); 6 Jan 2026 10:10:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=xIbXtv5epJ9BQescNICK+QqaIHRTRNpOs8NdLMNZRMw=; b=A28/8zV2uYQ3JX6rdSBfuYpQAoUpl8ebJDHiH2+Ug+2Bq52xe5z8GwX2nhrnh0kdGUMOG2L+6a4HaoPuogSbz16eMnvnVHG/ZPe2FEzJAcQJaCilsFlMTgtffW9aM3QK4nEQo+1Yg41U4pssFQN2jSpimF6GetQPyYkwBqGDJ9FZnSO6obe+61uFtNZDzJXuJ2D5633aszkSrYY46wGMejBYPGVZzwYh0wopA9HhXF59DwJsEGa7hUi+kWIcP6bMm1ZwVC7ywk1zByg2eTS6ukHYrghTPg/1AWMi6C3qZnWYBZi01jsrFONkCkjNOAbSiB+QgAVvfVS94QMy8wdPig==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Jan 2026 10:10:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 789043 invoked by uid 111); 6 Jan 2026 10:10:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Jan 2026 05:10:48 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 6 Jan 2026 05:10:43 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] more t/perf meson/GIT-BUILD-OPTIONS fallout
Message-ID: <20260106101043.GA3723319@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series fixes two bugs when trying to use the t/perf/run script to
compare two versions of Git.

  [1/2]: t/perf/perf-lib: fix assignment of TEST_OUTPUT_DIRECTORY
  [2/2]: t/perf/run: preserve GIT_PERF_* from environment

 t/perf/perf-lib.sh |  3 ++-
 t/perf/run         | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

-Peff
