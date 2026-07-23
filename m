Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA413F54A7
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841583; cv=none; b=IeXGgFoaFTJ7dB2/Cg15BrpXvkbcd/PZrapTZXUrUdJrQbM+dESDXKtNd64wuOemVzCqY2P7/AyuF95WsOFjLdtOK/SyEIr3TZawCdMSQ/74qEIXtuIGk7zT+G/ALgZZUBIg5gl6W5EbvcDPueJbhooBu3GLcG1XWUg/OZgscRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841583; c=relaxed/simple;
	bh=H28LdFAH69ddSKwY/zgWlunoL5XzbKtyPdzljixSCSA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=cubVhmO93AoZixq4yC9Lg51UN8EK3ZMW/M5l5nTjWXnZ6Zn+fBG1mRlXV1MULLHlFAuB/RktenXLfHlEelOKIrWrY0P1LfXKvJPSp5C3E6E/rHNz21d3v0L82G0YdBRs2Pimduhu7aOqnIhZcASzIcXJHM8j5wY79+8/7prS75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhqGWyLd; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhqGWyLd"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb68bdf53aso512409a34.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784841581; x=1785446381; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nazj7aqef6uGgy9P/pXKPJiBkriKrNtUCgslSlgtUg4=;
        b=FhqGWyLdoz/CXFxzqEGCUvR073KiaqMUn1F0WcYcg73IyNCshNtQHB7e6oJ7FHy+Nj
         kT1x8pCJlWmRZfxrlL4YmFVrxjRCM9Vg156cI5KHJeynblGYn3scg8mUKEwP6pkSy5Uf
         zsKF4yJWk7mf4QzQrhfm/SSgdlsT2yLBceFqgFMpJ6nvhcFhCiYglsEV8N69UW7169oz
         xnDcFNKyaWX6oKt0sggABTOtrIyQ3e1yiwRyuBLsV08OnYn0A9q6rsiRFDIsBpWhEvmo
         oLafcXV23qJ9Ae1eXRuyBleDNcef64Al1O8V9+rncBJOwQhK7usnEFaiZPK0O0IEIckZ
         EBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784841581; x=1785446381;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nazj7aqef6uGgy9P/pXKPJiBkriKrNtUCgslSlgtUg4=;
        b=jjOViaXefxuUm7SCneo8YgNVhrVbJ2jVmD1f3P+LEGg2XxuBqgTy1yfr1i01TWHnDK
         AlMG6XZSyOtnJeqPpyQUYSpA66hN3aW0zjn6AfsaHu5xWmzTMdiuylAdKfVBn5XjYRrk
         UiUh8KscMauq/Qkio+poIG/qAaQpJwr65TiK+JiRvFUUSx/WwN4DRNi/9dkce6CEke6m
         JpOdxDZzylOc0zRvLSlf8R8KMpju69RY24bX04m7rGw5JGIeNrPfXS8wuRQRZrHpBfRx
         71MR1bSJ/CSntGGaQx0rsLpruU6FVBPAirkG+yzUK6dRmaaMPrYQjrK1V6PdBUSZZ7RE
         dNnw==
X-Gm-Message-State: AOJu0YwjjyPqzcHsxku3rKegvReq3E2VNPP36cPFDdW/yym8jmgtb8Wa
	dgVKaPbk1Exr2Eel/pC/RgBO9XxyHoFAnFW5kHsbwle8v6I+gcXWAizjHkPgcQ==
X-Gm-Gg: AR+sD11XkirpCYP5VMKUZB2DKOmvotMgqETm0Kfeq+lLDQAax/3MNokPQdv6suNfO8c
	V12W60aCb+IA8DAbRvPA88nWiFnoGKVZxihp8Jaam+XViQzmAWLTJoZ3gGDJlEBgmXQSXCTDrMa
	ydWQdia2a3Cu7LmcEAvb45yUZJMvvItIOemykKH15I+6n5K6/kSqU8R4BnSlJmpsKl46d5w3tsK
	sULKonssN4nzQpkyTVC4tLPkzPA0B7jt1IkZ2qSRpbT/oT+RseeiBTg4hGk423fUJjCgRVK5bNa
	fpAIylOZxp0tJCOLz35Y6KXDES8X2PVCaS6tLNEXTTVSDL69f3YKvWATa5Kv8rmeT+8ZLkpht6y
	0ef7U77MBD5ZDfooQwklsTN7xPR2fPLRXtqOeR3GOHa0pDP9QDjgfhxovBCmZPlYh75iRbt0zFO
	XqvtrlwA==
X-Received: by 2002:a05:6830:3488:b0:7e6:e8cd:bb7e with SMTP id 46e09a7af769-7ee43a4c105mr2618276a34.4.1784841580772;
        Thu, 23 Jul 2026 14:19:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.167])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766f0cfd8sm5164332fac.5.2026.07.23.14.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:19:40 -0700 (PDT)
Message-Id: <740b24631de2c2aff01dcb461f60121fbd11bfe1.1784841567.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2185.v2.git.1784841567.gitgitgadget@gmail.com>
References: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
	<pull.2185.v2.git.1784841567.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 21:19:26 +0000
Subject: [PATCH v2 4/4] doc: convert git-request-pull synopsis and options to
 new style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

 * Replace [verse] with [synopsis] in the SYNOPSIS block
 * remove single-quote formatting from the command name
 * backtick-quote the flag
 * use _<placeholder>_ form for positional parameter terms

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-request-pull.adoc | 38 +++++++++++++++++------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-request-pull.adoc b/Documentation/git-request-pull.adoc
index 15dcbb6d91..8523c4e6bb 100644
--- a/Documentation/git-request-pull.adoc
+++ b/Documentation/git-request-pull.adoc
@@ -7,8 +7,8 @@ git-request-pull - Generates a summary of pending changes
 
 SYNOPSIS
 --------
-[verse]
-'git request-pull' [-p] <start> <URL> [<end>]
+[synopsis]
+git request-pull [-p] <start> <URL> [<end>]
 
 DESCRIPTION
 -----------
@@ -19,28 +19,28 @@ begins with the branch description, summarizes
 the changes, and indicates from where they can be pulled.
 
 The upstream project is expected to have the commit named by
-`<start>` and the output asks it to integrate the changes you made
-since that commit, up to the commit named by `<end>`, by visiting
-the repository named by `<URL>`.
+_<start>_ and the output asks it to integrate the changes you made
+since that commit, up to the commit named by _<end>_, by visiting
+the repository named by _<URL>_.
 
 
 OPTIONS
 -------
--p::
+`-p`::
 	Include patch text in the output.
 
-<start>::
+_<start>_::
 	Commit to start at.  This names a commit that is already in
 	the upstream history.
 
-<URL>::
+_<URL>_::
 	The repository URL to be pulled from.
 
-<end>::
-	Commit to end at (defaults to HEAD).  This names the commit
+_<end>_::
+	Commit to end at (defaults to `HEAD`).  This names the commit
 	at the tip of the history you are asking to be pulled.
 +
-When the repository named by `<URL>` has the commit at a tip of a
+When the repository named by _<URL>_ has the commit at a tip of a
 ref that is different from the ref you have locally, you can use the
 `<local>:<remote>` syntax, to have its local name, a colon `:`, and
 its remote name.
@@ -54,11 +54,15 @@ the `v1.0` release, and want it to be integrated into the project.
 First you push that change to your public repository for others to
 see:
 
-	git push https://git.ko.xz/project master
+----
+git push https://git.ko.xz/project master
+----
 
 Then, you run this command:
 
-	git request-pull v1.0 https://git.ko.xz/project master
+----
+git request-pull v1.0 https://git.ko.xz/project master
+----
 
 which will produce a request to the upstream, summarizing the
 changes between the `v1.0` release and your `master`, to pull it
@@ -67,11 +71,15 @@ from your public repository.
 If you pushed your change to a branch whose name is different from
 the one you have locally, e.g.
 
-	git push https://git.ko.xz/project master:for-linus
+----
+git push https://git.ko.xz/project master:for-linus
+----
 
 then you can ask that to be pulled with
 
-	git request-pull v1.0 https://git.ko.xz/project master:for-linus
+----
+git request-pull v1.0 https://git.ko.xz/project master:for-linus
+----
 
 
 GIT
-- 
gitgitgadget
