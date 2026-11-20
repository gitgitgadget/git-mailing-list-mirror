Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172571;
	b=5Ed2nKF8KhKtVcVkVsMkCPbhp1yY5OIgvmc1qagGjbXtvEJJJCTdwvKCD00z69Iv3mL9
	 M+hT66BZ56bF1lhfUf9S6vYe2TvKUFoYlP0C2yrDrNLwsddkAar26LCJbDrEfzadhmRRw
	 If6kf8tTwFjSy0Brfv3mVehvme3+0MWMKDcCI5Fm0UuF+RCmDJnutNPC9JyB8Bn5nHhBt
	 Ufu7t1ZIzrEntI4XEd6heJVDVUt8H57qu+/vbDaYZdQ8xyWr+/bs7j/Y65RiVGbrjFXsL
	 JUHOLIph1gZ/71oJvUyqDR/hAF53E30R8XtNGq9QvfsRo4Vaft/MBq1e3XE76TUMkrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uFwYHYFnl2QKX8zXAJQw3kIROE3oakGspOaYfG+7eKo=;
	b=RD5FOMALlP7CaWtWQE3tpow1gEUMQC3CS5vaT7BpzjOu0PoTmE9GmChAnIis18+pFMEJ
	 BRwm/FR13X/Up21BAGTBEAPPg1qpSo2bomWuqxQHQ/DEVZHVhA3N9BCpOi+ZsE+6SWLxJ
	 +Nemh2cq9ZuyHuvxYK8Cz55ySrqafHDqW9F30fDqd5UesrnJVte50nKS5DfNOLen/Qfdm
	 PLhMzibnNzkWDQhpl0CXo1wmQmckzLyg1eUx3A81NzWMZx29Uhd7LOWgFH4iRqDkWbsdw
	 kVeYd1Rn/qtvjbhSWzot5eyDJeb7hxLPP0KZ0AnNh9wGOON4Ol1Qrx+OFriAnCYMY1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hMwAudWB;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE36F606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 11:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE36F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hMwAudWB
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b87408c797so958291a12.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 03:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795172569; x=1795777369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uFwYHYFnl2QKX8zXAJQw3kIROE3oakGspOaYfG+7eKo=;
        b=hMwAudWB2iY7kLeZh5nCNMcdTbMR/qhbmqtkBxSApe6239AmaNToDFhWtC/aogwDh7
         CJ25c4tS3g4QEMKinMPsil56Fwi77Lp5Jve0Af/wfx1UbdEYppWKPP8g1+bJbqn87BXt
         z3wDd6QkXKnW299jNGp/jy3CN60/murJOcr6WGOuxynijYzTHOqcK1V6nRna3OtByMLF
         8XlZcnKCYkkD1R4lRphsqbyjs2yowv1Ccr8NGm3Mk2cS3fr8YQEn0g5YaPTo+DO3SSd2
         3MOsCxD2m8rUpFRBNqWCnQYJsfhCdyP3xsdPLZjx+8u7ZBbc5pIn0MrKIpvhX+Jms2uw
         eItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172569; x=1795777369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uFwYHYFnl2QKX8zXAJQw3kIROE3oakGspOaYfG+7eKo=;
        b=AglStluer53DxaOz5nIowWQEzXw1kJSkRVH+JzkPW0mA8PxFVuVOTSKEgh/j8L3bfp
         XPsfi0LB1w++bvOKqqqVDGXp+q/iFcAXGWeL73pQtnqbpkg/tnqYVxyyyhWC37uTqJk4
         dHc5uWiAd/Z6ZENZcIFrilyruEogj1cMbk+U0Djpg1f9bmFeVZ7DoQ/lnWgayL0OfgUQ
         jbkKjFTfkeNAbdWac5CGwDEq0GYHILYnyMCC2pwAHFsVfsJtGocu/IEDtlpqB51pWVhq
         cNKJ7H4r4zJb8qhB3m+iPfL1sq3dBh/Mn6HWPpMTh9xRY84lopHs/TSNc5VPPa2gX5w6
         g6mw==
X-Gm-Message-State: APuU4Z82To+2m9h1+u2OiBaWrqHcvMxEpLvM4lszj7m3+chz1rPqJ4r5
	e7U3qkd21YsJY5iIi29ZbM80zIgTQI+EbjbDBBwlWPziD/GbSrPHVTzbBKLOPM8X
X-Gm-Gg: AZFdTZfLaUAXV9WOVSuufXtX1Pwo+QQMQt26eE7UXxBXHnCU1+YO3A/jMCahKgZpAmf
	ua04Q9Slpj1/HtwylU9g77FVNu/sZ9tpkGXXO59Pj+BVkgWqFqxDqLSOwjFBn+u9ssaeNS6JSQ7
	gDGYwb4EC2Ofpp4dBTb12KVtwppx/jgjhyllenAyfiBd91FdLpszJ/UNnbO5cpi2ZAtntYI+gsc
	pdDFgBo1QIslRS+d+Ds0nzpFfFSIv7AckW0BaqRKY2HETDjH9hPZIMa5HRlTA/LUB0YCDkCfP9X
	ORnZMczmF5uZ61j+Scnvh3J1KzxFVuFX1K5CXIUF3WTRAHldfl3Z8FPe51xUqkvWJB+2k+KsqII
	vZwVVbfE9Tb9tU1aZ6EZT5TAAf6prj9uyps9Twf+XtoRNOWX1H8wXKglmzYYZt1tDNwxVvZXDkl
	p0HwXl7rWHOOgKPJ15/uXVFiu62eGWMwLIXYVqgTgfk2tBeXD5j8a5ZDDLPLu5fzRB0MOMW2Shq
	Ji9uRxkS9jmxIaoCHslf5vdYQb/tT42MIgB2buDyRSHvAhopBZGIusGdZkz6DveIfj3LUgPoD+Z
	4XhBB6PEywO0zaeWG6YfkBunG7W2C6sd2Ew1Vzguh+A3bPz00smJ4WNPe8LFk/e9V1doEk9DhYS
	Aj7Kzs4nkoqUfFkGBFauOMKqGYPAbIjhgUTEvOL9UlCyc1zppNZxXrC5pGl48VHG981g56467nF
	f1uoqu89wGoxgSQPBKP50M2e1MHs/0
X-Received: by 2002:a05:6402:1e96:b0:6ba:2f05:2508 with SMTP id 4fb4d7f45d1cf-6ba37ec0a65mr2280696a12.39.1795172569047;
        Fri, 20 Nov 2026 03:02:49 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370faeeasm1046759a12.22.2026.11.20.03.02.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 03:02:48 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH v3] doc: wrap emailed text to a maximum of 72 columns
Date: Fri, 20 Nov 2026 12:02:15 +0100
Message-ID: <20261120110215.42209-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120055908.83043-1-okhuomonajayi54@gmail.com>
References: <20261120055908.83043-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CodingGuidelines, SubmittingPatches, and ReviewingGuidelines do
not say how long an emailed line should be. State the limit in
each: wrap the text to a maximum of 72 columns, matching the
commit message convention, so it still fits on an 80-column
terminal after a few levels of quoting. Leave a blank line
between paragraphs. A block of quoted text counts as a paragraph.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
Changes since v2:
- Use a maximum of 72 columns, matching the commit message
  convention, instead of "near 70".

 Documentation/CodingGuidelines         | 7 +++++++
 Documentation/ReviewingGuidelines.adoc | 6 ++++++
 Documentation/SubmittingPatches        | 6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 23a4d2186a..c5bb6ce120 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -33,6 +33,13 @@ Git in general, a few rough rules are:
    achieve and why the changes were necessary (more on this in the
    accompanying SubmittingPatches document).
 
+ - E-mailed text, including a patch message and a review reply, is
+   wrapped to a maximum of 72 columns, matching the commit message
+   convention, so it still fits on an 80-column terminal after being
+   quoted a few times.  Leave a blank line between paragraphs.  A
+   block of quoted text counts as a paragraph, so leave a blank line
+   before and after it.
+
  - A label "NEEDSWORK:" followed by a description of the things to
    be done is a way to leave in-code comments to document design
    decisions yet to be made. 80% of the work to resolve a NEEDSWORK
diff --git a/Documentation/ReviewingGuidelines.adoc b/Documentation/ReviewingGuidelines.adoc
index 6534643cff..be15ea6fda 100644
--- a/Documentation/ReviewingGuidelines.adoc
+++ b/Documentation/ReviewingGuidelines.adoc
@@ -116,6 +116,12 @@ guidance, and concrete tips for interacting with patches on the mailing list.
   unrelated to your review from the email reply. Make sure to leave enough
   context for readers to understand your comments!
 
+- Wrap a review reply to a maximum of 72 columns, matching the commit
+  message convention, so it still fits on an 80-column terminal after
+  being quoted a few times. Leave a blank line between paragraphs. A
+  block of quoted text counts as a paragraph, so leave a blank line
+  before and after it.
+
 - If you cannot complete a full review of a series all at once, consider letting
   the author know (on- or off-list) if/when you plan to review the rest of the
   series.
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c60855f706..94a33b9421 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -700,6 +700,12 @@ WARNING: Be wary of your MUAs word-wrap
 corrupting your patch.  Do not cut-n-paste your patch; you can
 lose tabs that way if you are not careful.
 
+Wrap the prose you send to a maximum of 72 columns, matching the
+commit message convention, so it still fits on an 80-column terminal
+after being quoted a few times.  Leave a blank line between
+paragraphs.  A block of quoted text counts as a paragraph, so leave
+a blank line before and after it.
+
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
 e-mail discussions.  Use of markers in addition to PATCH within

base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
-- 
2.56.0

