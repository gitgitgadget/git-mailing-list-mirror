Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0A1E47CD
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502942; cv=none; b=Rlq9VEQqX/KoCqM/vQX8ztGHO/jWHcSpt8LxqYqlQgoJNN4pZGXSiXuqqsqrUNLvOdOontKRGJUCWcC+d7zcfv/XAEPjhAtqGejv2PvowXVS3ppEkolalz51BWe/p6Q66Ute1QRfsSG4wzevd4bYO+COuZvS8YQyFsDUJq//hGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502942; c=relaxed/simple;
	bh=LrEIcppuUohX/9sYgxq9g75mG4cERVIWSutju8XcBQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAlv02KOrBr2eHRqRy5I57+V1Cd3ImqkTjIUvl3Uhktu0q7fQ26sDjNY8IHEB++HTLQT+TZvQaKs74fJ64GPGdtT8U8JqB+Jnu6E791yAu/iijqaXG9VVgYxz+Y9ObstdeTpmRIG+JsJx+OcAI32gKNCZ8UZ9BHIOD32AqYyH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0sccfW7q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=POHCBcS7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0sccfW7q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="POHCBcS7"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F439114022D;
	Mon, 21 Oct 2024 05:28:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 21 Oct 2024 05:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502939; x=1729589339; bh=SPdkmEcqLP
	Lf0qgPODV1uPepi+bcqh+gFmXFNZmg+V4=; b=0sccfW7q1xA4mWinQQ+L7npOYQ
	Isko1syXzkYy7otlxDvvWGopo/ZdZOWhpVoNAO3Qd1LPQWtpzm2sBdoNrFlfLVav
	7tJgE4HACa/0o7OICWU0ptztQ5HLh4S6ry0PuCg+swDmvXiTI7D5UpSj8FEKKLqg
	wASvQM+6Y7QN4+ph6sYJWfsOx5c3/cn4VOlp9lJnWEmcyTlAwoAOnigiPAocLg20
	t/sw55PDjKThJtArY5rx3mCJOzHRVgntRmaGpTlnFZBt5pYzFP/6LBrsCncywAf+
	GzrisDvjBuIBQMEinSLTOLzyGTg+QXkfH7kou0g4if+2w5m5glffJoAtZd6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502939; x=1729589339; bh=SPdkmEcqLPLf0qgPODV1uPepi+bc
	qh+gFmXFNZmg+V4=; b=POHCBcS7Uhj03uNpC7iH/lmzxafYpswVuuFdKsfF4nur
	dpv6W73qjjiRAszb9Ujy1fECXQSQcbf0+tMqTlbE8zlVphWZiAXUOJAILlKWeK6V
	P/w49OMWPj1S+NcPslLGIx+coKfNSkNmAp1fhIkwDClpXuasmZdXBBhLxzSPtueB
	lMFUzz+WvclRnXCsvq8jG7pTtBkfyBaAO7apOrWzJ7BJwmq5SWPgmpfn0AOORPOm
	LixME2hKrsIMoJpjBYGTbPu2zixu/2/Z+wxP0kId0VCLdPeFQYBKh2bRAAQ/FeX1
	biMlpeSClF9G4xUKzGee6YOfscHtNRAdqV2vSE91Gg==
X-ME-Sender: <xms:2x4WZx6D8EGgTtxXKBRGsc4c3py5hXJVAgGBy-JEB4TjQhP-HKGrZw>
    <xme:2x4WZ-7j0lTlKwqGYjB7Iqi4Rg0VJ5PWevDj5pDO9yPdkONug66WELTCStWVKAPVr
    G9WtfLVMHqX8WdObw>
X-ME-Received: <xmr:2x4WZ4c4WxE8HjhtHsX4mgKPlzXgrrcq7YfYmTIJX-X2LBBdEobPKmSk2mt3dRE1LaSJ-muEs5ZiRSwjbathV4flWggIWLHIq7QFaYALkvt5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhm
X-ME-Proxy: <xmx:2x4WZ6LH98tNGm-3tg6HtVUoNw5MWDxuE6AwZbweIlcelByc3mez7w>
    <xmx:2x4WZ1JQdzd7YhFc9mo0RLBklpkZHv5OqgAUXKyKHK65lHcBW9ywEg>
    <xmx:2x4WZzx7dXgsTIgsR9d02IVDsfHWUKiqi_qBRw38drtHQGvs9VYodw>
    <xmx:2x4WZxLyquzJTR94WNWXjg4ay5k-Q2_L3N-S4hr1MhijzuJeBIZGxA>
    <xmx:2x4WZ12MA3glGGVa1sXJFcgYM008n9QZWCjq3KAqAy472xY_JHwsYbiR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0de0e157 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:31 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 18/22] t/helper: stop re-initialization of `the_repository`
Message-ID: <132fe75090656ee05198512b95acfa6eaa33f3e2.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

While "common-main.c" already initializes `the_repository` for us, we do
so a second time in the "read-cache" test helper. This causes a memory
leak because the old repository's contents isn't released.

Stop calling `initialize_repository()` to plug this leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-read-cache.c  | 2 --
 t/t7519-status-fsmonitor.sh | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index d285c656bd3..e277dde8e71 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -11,8 +11,6 @@ int cmd__read_cache(int argc, const char **argv)
 	int i, cnt = 1;
 	const char *name = NULL;
 
-	initialize_repository(the_repository);
-
 	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
 		argc--;
 		argv++;
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 7ee69ecdd4a..0f88a58a819 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -2,6 +2,7 @@
 
 test_description='git status with file system watcher'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note, after "git reset --hard HEAD" no extensions exist other than 'TREE'
-- 
2.47.0.72.gef8ce8f3d4.dirty

