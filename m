Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AC2797B5
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382914; cv=none; b=Fh9bANE0amobwJO4dyF8zYiTZyq8lBngRH/PRFuzXSwSlSoTtAg7IYw6Nu+vJAsi/POETO7MSDI3VvkuiAAvrAMa9sszO5Q8alfrY0iSn7WQgcI6ANV8rVFvPSXYncF7zUa/I9bZbqPf8m51tHJFuFm5rPTFGwj4qEyfG2rIIwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382914; c=relaxed/simple;
	bh=tucn8+eIxjwIIw5NoV2zXuhEMuW89F0ERfqmE7vFDSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1VrRq1c9UYfDngkdKsowKGivuer9aY6c+iMrugyyAITodISZsr4YR4Kgi3DQVlIW5hJeG19/GaaVQr9DvYiXbBAcMaj2e3gCPLnzqNn2f8ZgW4IgwVaBP6SuMN7Q8nkRjWj04PFN+uHyY0HFlKGwEtblO5OWplWw6HDyAwTNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hoqgyCgX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e2JWN8P+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hoqgyCgX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e2JWN8P+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCDB71400029;
	Tue,  1 Jul 2025 11:15:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Jul 2025 11:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751382911;
	 x=1751469311; bh=pDE1hUs/F7dcPxnwJFPQTK3bCG1+ggyvwr/GAD8h95w=; b=
	hoqgyCgXrj2y5oTwKOU8pj3r841SS4v4pW8Udau4RWy4MtxKkj5IhbR7bC0NAXLy
	5HjN8KMqDTt+LEjyZkK/CzM+YZxOgt8Ifqo9tYCQ+cf8t6NWZsR16A0rc9NYoEeN
	wElSvvGWGoppLiJ5typ5XlNYJLSGxVvqYCHdCTeXRljo07N0PjanH6m7y6Nbp1DC
	L3K6efN0tfEGYZxqLYJ8VqMPKZoECKQ5HzsH/+HwYs5yFD2BaS61lhl4Mqheg8Fq
	+AqPU84ueTXUg+mWFMeDbey0ONPoT0rC1VDWQgQylD/f5pQWPmSUidzbkpxQlOAd
	JRbrumKZe1s4bnF3aV6Mxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751382911; x=
	1751469311; bh=pDE1hUs/F7dcPxnwJFPQTK3bCG1+ggyvwr/GAD8h95w=; b=e
	2JWN8P+44hhZQU4/T2fVyrNYChJa3H6OwfIoFuxzfwIJqgGoUXkUYetiS5TVrBVk
	98vW0FDBRaCXHfloe7zNsB5emAhuT1M95sM8ovK/mev1DgnRx4k42a12zbyT5zbL
	3Ygoq9QL5D/SSTTe6QDiTq3t9bOH/DCJttJARRj+RgyOtaOjApUg9zv0XzTrYfbV
	RBzkasEv1n1KtE7xj8g6X90pfd3Hu38P+oB7wUCBkLH23m8dJrsv67pCKV98b1g/
	TJkJz/CRdv2Mm3Bgv1SNMXM6kWN+nI1WUyMNizx+6FgBBduSJgedZN/RgSekvL5Q
	bxQTpoB92XIt+rSX3LikQ==
X-ME-Sender: <xms:f_tjaKgJMgVKBmEwPWgHC8O_QfeirOV2jYmPjMrQMC_J-15Qcig5MGM>
    <xme:f_tjaLAo0QmyQMofM8yy6Ryo08nz55XOBCeSB0LrKgKhljfxgRSRb08s1i29Yd4D2
    fE3DmOx1fqOQ3LQmA>
X-ME-Received: <xmr:f_tjaCHLPDIPkZjiu1BLmX_9NLGLnvopUfts0-hN1afh8EKANbDicQ9LmFevENGMfw0D3b2YYUVG3glsJQh0tB57BVS444z9hWtJQoc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgv
    tghordgtohhm
X-ME-Proxy: <xmx:f_tjaDSPsSdvrOObBrvizK-B6WY2LSjn8vmEKEYfm9ZNC8MveUKmtg>
    <xmx:f_tjaHx1dsUN1Dy12uErvccsbu6wvJRElJRQidNgmQX5p5RP3OVNXw>
    <xmx:f_tjaB4KNNj89rYasp5rmAWBomLe5plsEdraVRGUoaBb9YnS_oPGhA>
    <xmx:f_tjaEzUhJnJnJ6HFzcm8Fy8d3ngs5sTCuV8xRQsjXCZNYEBmKnWvg>
    <xmx:f_tjaGNtoDOj1tb6XsMC53dSIUxfnEimbquWuMn5LYLMmiVeJNJ5Zt7o>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 11:15:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/5] config: mention --url in the synopsis
Date: Tue,  1 Jul 2025 17:14:32 +0200
Message-ID: <8300e0fc3491991bcc8e4a7bcdd1ac97313cba1a.1751382830.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0.136.g907b27ebd9e
In-Reply-To: <cover.1751382830.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name> <cover.1751382830.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

4e513890008 (builtin/config: introduce "get" subcommand, 2024-05-06)
introduced `get` and `--url` but didn’t add `--url` to the synopsis.

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Unbreak t/t0450-txt-doc-vs-help.sh caused by source/doc synopsis being
      out of synch

 Documentation/git-config.adoc | 2 +-
 builtin/config.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 9d8f9bb04e5..511b2e26bfb 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git config list' [<file-option>] [<display-option>] [--includes]
-'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] <name>
+'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] [--url=<url>] <name>
 'git config set' [<file-option>] [--type=<type>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>
 'git config unset' [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>
 'git config rename-section' [<file-option>] <old-name> <new-name>
diff --git a/builtin/config.c b/builtin/config.c
index 706269647e5..5efe2730106 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -17,7 +17,7 @@
 
 static const char *const builtin_config_usage[] = {
 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
-	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] <name>"),
+	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] [--url=<url>] <name>"),
 	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>"),
 	N_("git config unset [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>"),
 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
-- 
2.50.0.136.g303b50f9132

