Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868393CB571
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268317; cv=none; b=hi7BjpKow/jsyI++qT7U0yNIpBNhNJEyre+yOasv6ioTzssTt0AagKxEkv/4myTI4Xr4MR4CTRurnJ5DqGxoaQMfh7iTjoyultWgzy40d1n7A7+jClTCrqOLWjb1mdqrqF+PBzD+sk3PJQfO1sg12bSUl6k52LG8WyY0mF8qTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268317; c=relaxed/simple;
	bh=FqesKS5QIyrNyn9dv/pZhoQ05NLPaCEK669tEJCTR1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZL80OGYgCQOn5oK1tSAFMCyysqVvlN5+nKLrMaGQiMmjJx2CRlEihtO7IpWVWA++qqptDpuotXMt6UbhN96QRbtuMkZjUKRYJ72rh8M6WRloJNoSoIgQUtubXcPb/ranVan52RuQPOQOSJSivvmCcVxl6zMzM9PAZc2jrvgdYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b5AZ8UHZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u47aYAEA; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b5AZ8UHZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u47aYAEA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 80118138027E;
	Thu, 24 Sep 2026 12:45:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Sep 2026 12:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1790268314; x=1790271914; bh=qqgZ8fENjfBJbvjoGF0/U
	4FBWUgovmTCpiQAN4HTxk8=; b=b5AZ8UHZ8stYL4S+sbdsi+SpWWEZrUfjjKMMy
	zx9lnhohPL9pbBObRgzdBOQEXd6KxRUdbNY7r0AT5xpILvkCuN0nT6GJR0mIlsIa
	PSeaj5q0X9POojg9np3fDQ2znuWLldvw8VPNan1z+rfqcXYn1Ay4CVcLnBNo8N9q
	aa1HecBJEfznWfR3jpxo7i/wRka14QjNCaWorNPs1vEpaGwZIx0L5dxBd3Hyss8y
	7zyqoI1eAKqgFgeut6KpSDXBvai/Sg0M5/AnKn4V8cEpVMGY7amYQdZrPtUwwhXe
	GlcLoIGxyT5vOsr97WUVep0WShLt4pCseoF/xrWPqeDWFhXIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790268314; x=1790271914; bh=qqgZ8fENjfBJbvjoGF0/U4FBWUgovmTCpiQ
	AN4HTxk8=; b=u47aYAEAQtuQHBlDqBMvkW81IQyxJl/Q9bnXxv25ALN8lkTALT6
	3XvJlk+INwu9Nc54fMduOPH7WyMUbydH5RVdb394gbn/AFn+YK/bB692H0snby9X
	lpIij2OsDsMm8Ww5PI03rOl/1rpm+okUGGoJGmgITWk/d4s8n8aCmRNz+hSAG4Or
	V/C/ANjcEjWiRZracYUcXnfXYX51657KGAw2oocXxEFWACvHEKSKrb/aVMEeVj3a
	d1MUzHNB48hvfEgT+P7ctxJrJWOTzxwgJRrGUbsZweYC5LAPvIZ5qC95+4PRQwbw
	FSJLD3h7qC9zeKLWNExrHwNjpqTvI0N0GXg==
X-ME-Sender: <xms:mlO1airiNLpI9BwQVo2J9v1b4oEb8RvJkJNfESbY0L8AMIl6Q3P69A>
    <xme:mlO1aoH_P2iUy8RgynkgCydw2HFDcLlOfVNKBWCfkpTlObnRivlKBoNfxWKSbpv9O
    myyFSkUHLcJ4Ei6j01Vq9n5bH3opz42hwHe6bxXKh_rioSO-Wl_ytPV>
X-ME-Received: <xmr:mlO1akm4N4DMrqEOdI6zV5KUha_UVYCLMxr42bk35W200s_flj_KBmTdponXuDtGFVa8LuFocTZjkYNQ-TOMUtev0I9MYxI8nJDr-Y7jVkSp>
X-ME-Proxy-Cause: dmFkZTEIyFAuxr0E4Vjx45FbaETBLy3Jxu9bbHp2+ZLbfraj23aq3KglIqHL7tqaMUOasa
    ssPaNrROneev1yiLfWnZ2jy4WDTXtb64gkT6zB2kt9m68/p3RAbSLuuylAJFZWNRe0WpBf
    mPXRfR91GC1fya28jXmcsmXFVmp8Xg6q5mJnncnpVHRGe/K1Ipb0Ole8Llnu9ly0+qxgsG
    iz/rk/ZO+yNPM+ybnhYvt2mY2ogGLeaX365dc/G9E6lHxNhutyH4McZdLZYXEa8rfbDYzE
    fQp5l2zHlyFlnFbtBqJGpesRL83sKopKQ7K4kBaFi+8c92S7AamYyyGDMj2zMD8ZHBwJGD
    lizGNWcFwSHM8nMCQQnC9psnEJMFX5qaL7YGTL85ClewWboKRshLvuTIv3LwxkBrhhEU0A
    PJvbNYMnUsjLKGHaA/NW8AGUAgvP3vXlx6PQX00A8FH1vn3VE6txQFBAoAENj75/Cj0Ye8
    ZwveG/ayN2TxXp6cMTjBgpGS1Afjtua7TwyQVc+z2vSZDIcES7//ZzCoyJQ/IA+r/+9CUA
    9lxi0BUn9ZO05vyEVY7J4QzqEm6xemabFJVlRMlaGiWQANTbeV9Ez6A6wmL+eKyo5xcU+c
    qXgtUXyus5q5xH6nxZ1Fvl19cQ0x8dbhrASgPSUP27vOnf2Q67UyKUu7BywA
X-ME-Proxy: <xmx:mlO1armQYcH-cjlyMlNs3JIY2n4fq3ekmIY-zdpTK_8uJscauGKW8A>
    <xmx:mlO1altQfkEfZbR3R4K4xsexWUfXYTwoyA7pqCCLtxwp0oU4zNh_lg>
    <xmx:mlO1aul5b2dS1yT3OXur4R4K3hTVjhZgs3hGbs1VK3qRao9rMVTGzQ>
    <xmx:mlO1agtInRCJQFRIq9hY_GK322LAEkM9nbqz9QLsF8LjBb-AzALjiA>
    <xmx:mlO1avPIkgPjmw3sFRVwDacjyZpCvhJnggwAPG1dcdXafEEN6fvvKghU>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 12:45:13 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH 0/1] repo: add filtering options to "repo structure"
Date: Thu, 24 Sep 2026 12:45:02 -0400
Message-ID: <20260924164503.119506-1-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    repo: add filtering options to "repo structure"

    "git repo structure" provides a collection of useful information
    about the information stored in a repo. In particular, it's
    valuable for diagnosing performance issues caused by large objects
    stored in a repo.

    The current implementation of "git repo stucture" provides summary
    information about everything in the repository - all of the
    branches, remotes, tags, stashes, and notes. But sometimes
    to properly diagnose a problem, it's useful to be able to exclude
    refs that are known to not be relevant to the issue at hand.

    Add a set of flags that allow a user to selective exclude
    reference types from the report generated by "git repo structure".
    When a ref type is excluded by the filter, it no longer appears
    in the report (ie, if "--no-tags" is passed, the report line
    for "Branches" will no longer appear under "* References").
    Following the pattern of flags that are only used to
    disable functionality (eg, "--no-verify" in "builtins/push.c"),
    only the "--no-<reftype>" syntax is listed in the updated
    documentation.

    Overview of the changes:
    - Add an enum to represent the structure flags.
    - Add structure flags to the options for the "repo structure" commands.
    - For each reference flag, add a conditional in "count_references"
      which decides whether or not to add a ref to the pending list.
      If an references is not added to the pending list, the things it
      transitively references will not be added to the stats.
    - Add a set of test cases to verify that reference counts
      in the repo structure report correctly omit the specified
      resource types.
    - Update the documentation for git-repo to include the new options.

Mark C. Chu-Carroll (1):
  repo: add filtering options to "repo structure"

 Documentation/git-repo.adoc |  35 ++++-
 builtin/repo.c              | 158 +++++++++++++++------
 t/t1901-repo-structure.sh   | 276 ++++++++++++++++++++++++++++++++++++
 3 files changed, 427 insertions(+), 42 deletions(-)

-- 
2.53.0

