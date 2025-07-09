Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88226CE18
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042249; cv=none; b=oDVesU5VZHyIH4tjDXy2n9zSrXG6hI00VlFwzwlrTQ5dZXKNkjPpWm6r5cDdNO5G4RM394lKcBW32ZZ5IvIYxVQRaPjShelNjPidKBb5pEe45JKsaSyO7XEstSSIRzJa1Ta61u2dBe+MfJvtgu9ETysZDSK+PbQ0kZ2T5RFmDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042249; c=relaxed/simple;
	bh=RcZJfKiVrapadjSbyiKjI/UKYKFE1ngyYvZGcm7/Kgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ob5KrNEDv3i/SbpGo1nDonnTRRVJfFdCbJ9CaSe+CLu3rh0HzP9oAyBLEWTMZ113b0wjBWMgjjhFx7pvJ0/8UobTK6K/FUsZRwe3JFCnPE0fvVlpvGaLCDx8Gdtu4g1Zq2t9q9HHavWgTBGNTmFixfto3xyoL+eW4rOnJyh7mRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JnFAGhW2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gVpchh4A; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JnFAGhW2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gVpchh4A"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CFAA140025B;
	Wed,  9 Jul 2025 02:24:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 09 Jul 2025 02:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752042247;
	 x=1752128647; bh=TSUIUK9jiTJddhd7Z1cEm6gbIyChedhCCraEQBnmyFI=; b=
	JnFAGhW2FJ+FY2Q2fiXDWnNEu2s6k1fpUkFnMci60lSjrtq90/1KM+RHbGwcZpPA
	kP7q6oyP4U+BPT3j/5ka23WYC8VTWsqJlefwUmJklRr6bcCpxxWQVSBfcDun61U+
	GhZm2+K7X0ma8if6OOTTQFYNwQvbKdmhRJd1BnbWnk7eaMHBT9MBZCO+ntRzoiiW
	KZlQWziVbBJ8xVwwQka+RTfNPqILxYjS7lEgr6G/U27eMwICQ6HEWGDgLA0pUYL9
	l0Ik7Tk5LtNilO3Zq8kWm7gUGryO1aU0KknW8CFtoigx69wBp2RGY6AW1SXF1jl9
	OrFyhn/i03dmX0da0zO8Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752042247; x=
	1752128647; bh=TSUIUK9jiTJddhd7Z1cEm6gbIyChedhCCraEQBnmyFI=; b=g
	Vpchh4Aagl8v+rNbrPG/+FWgsm8hqXwsU8tw2e06TMQY5d5OkVv/EaRMLMhOnP+f
	C8zhevr4C1C9Tzj76L0tUcXIUzEREhmAo7bCj5IUZ45gWasQQ6oxFnYaC007Y5YA
	2654poH7TpunXDiWUgxUBcr88bfB20ufaIgGb3ahe/Le5HSqH0vGoybK/0mg53ME
	UhQxW2r6bj5GDjI+QsowWU2mbG9l3LBEIBYEY/EPQRzarykRB13KEeA7dLt43azX
	wqJZsQzHl2ntXYTxFyQuAuhiH7lJ7ubFo/vi1Qo5w+mCye9ZxLxKpB6eb9uXBCJb
	AnU3H3HBucAH4qYXvdKJw==
X-ME-Sender: <xms:BgtuaKKfmSQgaNisAJPv0DiCLW4QDuyCx2OxqYzu0mEM2SXoZH7ZNA>
    <xme:BgtuaF9Y4YcI4EgMh5gS2NnyBPXimcWeOS7AxlJ3XgmU4CLu-att2xZEArjZt35tp
    np6TdJFRZFaVNH9ag>
X-ME-Received: <xmr:BgtuaDxaOXyGS_xe8LwIFXzrEUzO-bePpBsZhb-w8N1Mc2ZSbPfaPglBXPzmxoKB0Np0WUzf9CBbLg1PGvFV9ihuc_ERtftFWEIgAYLi49LVpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epleevjeffvddtheeuvddutdfhkedvtdefueejffehjeegudehieekvddtieejuedtnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpmhgrthhrihigrdhnrhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepihhrvggttggrrdhkuhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvth
X-ME-Proxy: <xmx:BwtuaC6vpxbzjYwGctqisr8dWSiQeRyzg_tJ3M5jVHNJRTj7S91Cfg>
    <xmx:BwtuaK_lmT2vuyzbXgxkjDyaUtKQBj7I3i43xORzk311PTk-Htgnuw>
    <xmx:BwtuaHrDwpHUA2-5_7kqJU2iQJCJA5hQribuS2k4hzXSQd2wLf0I-g>
    <xmx:BwtuaLr07YDxHNzGYkInmoOvPGDcV7zAePiiG5ms3Q15b24ruSYmTw>
    <xmx:BwtuaAxr95kpWj1Bcke19yFK_jdLsyFmTcyov5gHKXo38iskFbMSyqSO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 02:24:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0526b4a7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 06:24:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 08:23:42 +0200
Subject: [PATCH v3 8/8] ci: use Meson's new `--slice` option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-meson-cleanups-v3-8-29ab15b9ab85@pks.im>
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

As executing our test suite is notoriously slow on Windows we use matrix
jobs in our CI systems to slice up tests and run them via multiple jobs.
On Meson this is done with a comparatively complex PowerShell invocation
as Meson didn't yet have a native way to slice tests like this.

I have upstreamed a new `--slice` option [1] that addresses this use
case though, which has been merged and released with Meson 1.8. Both
GitLab and GitHub CI have Meson 1.8.2 available by now, so let's update
the jobs to use that new option.

[1]: https://github.com/mesonbuild/meson/pull/14092

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 7dbf9f7f123..d122e79415a 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -298,7 +298,7 @@ jobs:
         path: build
     - name: Test
       shell: pwsh
-      run: meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % 10 } | Where-Object Name -EQ ${{ matrix.nr }} | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group }
+      run: meson test -C build --no-rebuild --print-errorlogs --slice "$(1+${{ matrix.nr }})/10"
 
   regular:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bb6d5b976cd..af10ebb59a3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -178,7 +178,7 @@ test:msvc-meson:
     - job: "build:msvc-meson"
       artifacts: true
   script:
-    - meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % $Env:CI_NODE_TOTAL + 1 } | Where-Object Name -EQ $Env:CI_NODE_INDEX | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group; if (!$?) { exit $LASTEXITCODE } }
+    - meson test -C build --no-rebuild --print-errorlogs --slice $Env:CI_NODE_INDEX/$Env:CI_NODE_TOTAL
   parallel: 10
 
 test:fuzz-smoke-tests:

-- 
2.50.1.327.g047016eb4a.dirty

