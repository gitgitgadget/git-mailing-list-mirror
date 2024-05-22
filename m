Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E532919470
	for <git@vger.kernel.org>; Wed, 22 May 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363267; cv=none; b=HgYKJFrWbvPtk212o8mnoavqDFaUTqYCOJP/ExYMv8M38qTal6z/Y2fURJnWTbJsuMCSI8VjDFqFqbKAgCIcbxzqSVI0ZkrUR9hRgcNQ+kPklz7wyPJyrIl5+WDKEWMqeWpkI8zJFCAx61jKBBBjnshPKrrp3UexMDwFeq2BJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363267; c=relaxed/simple;
	bh=XfrWZ/HLbzJc6mNZPYpTUc9JSCH7Q1C/BVHW81Y3kOI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Fr/rqhsWNAfTqZ7dB4w86j2FZi3wWS1duO7pTkgMF1/5A6FS/mWFIZ4Pvc07QwZrzRWgKT71tftuvWOEInbjjhtr/NeXojAbbocalf+5NfyhPJRflImqOmSnntUoDOqAT36WWMNxtRtaG+mI6waC/O/2GY1cjoZ5CCbOYYeRBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=H58BlPIn; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="H58BlPIn"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716363260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6SZV1vOfKYn/q8KzypAmAgeGb5NDBAXzLdalElpI/Pk=;
	b=H58BlPIn+7Mwf9vbgB47fiCMV/RkAfnVur1JWU+TojoVBh8ilvH8p1raBl3NuMln1Ld9cb
	LbtEcWhoSXJ79lbyshMWPZspLCn4x3gPTtuc/hPoGL6kxcXcUPtEpogE/bQLyigV2P1qqd
	yoKhuZUDWm4/zo6sQp//3G8MTAOcaoXGu0gKq8vyd4cXoIKzLtx9QmSSARnL5NZOVN3Kgv
	MIgWuTAYQbpAMrrQ3ADI8wvkyrPoN5taaP0HfkKTrW6xhgZAGVAnu1rSoQigOrPmE0BqJr
	0wb55AWf2/QzxRwEwH/GeJf7bVhpm6/k0f9GQJkyhX8TQUSngmXq//ytV8Rkbw==
To: git@vger.kernel.org
Subject: [PATCH] doc: note that interactive.singleKey is disabled by default
Date: Wed, 22 May 2024 09:34:16 +0200
Message-Id: <3141fe9f7328a97bf3818748421f6ae929120626.1716363167.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Make it clear that the interactive.singleKey configuration option is disabled
by default.  This should eliminate any associated doubts.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/config/interactive.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/config/interactive.txt b/Documentation/config/interactive.txt
index 5cc26555f19a..067496d77cea 100644
--- a/Documentation/config/interactive.txt
+++ b/Documentation/config/interactive.txt
@@ -5,6 +5,7 @@ interactive.singleKey::
 	linkgit:git-add[1], linkgit:git-checkout[1],
 	linkgit:git-restore[1], linkgit:git-commit[1],
 	linkgit:git-reset[1], and linkgit:git-stash[1].
+	This is disabled by default.
 
 interactive.diffFilter::
 	When an interactive command (such as `git add --patch`) shows
