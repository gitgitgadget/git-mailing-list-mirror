Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242927470
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053077; cv=none; b=N3WKA6lw5LY1pDCOtv3kChmWNClE2QibD4ahmqrp2www93j9kzEedvSw0CeRLGI/wnHMihyHlT5CQU3HibUolc4HlgZM0O6hLp6YpE7ERZTwaRh+4wv0hTd4XLRMPhWkGuCOWxgYb0QKHrOC7b1kpwDN0gCVngVakychx2KZNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053077; c=relaxed/simple;
	bh=GvNknGvyDiZxdNRaNnTymeDorMZ7RXzm6KFN3P7gMkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjZo0NHs/XEt+Fi5tQONuFVLgav7hx5jUChel6klVxcsNLW9EUnV3eLaMaGxep1rQ0WupExNRR1Ryjz14mvXODagR3IlOy7nMw2JFjs4HND1AOw//pzHR3QHAS+rTkjgoDX/7ETGIAJBvdRUbCDfKUKpsWf7l2oeDIwewQ6q3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=e3bmNalH; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="e3bmNalH"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6430834244aso2654407d50.2
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053075; x=1765657875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MCqDkx8QDPam93BcW+nX5AGGubdW4uJQXEv2YuiEPc=;
        b=e3bmNalHCPScBT6N76+zNc1tE05lkBA/BL46veTvDCRvNVuYy7ZU/5k533FfVlwQPD
         CrjV/2Nxj5f1TedQnIxZk7jGG54qtB1Z6d+0jRIaR665hNmuasHVNvKY0NLrqKdoxaxy
         XO/Va3iU/3iUdOwb0eft9BdPxDsoRK/DwvetYrwMjYaYonPF9h4q8CHTW/7UGemNMC8L
         fANLqo7TrwRCjEATm/4MaiqLrPSGzCFHXHMefrUQ0t/5ak3+LHQT+iqY72mpWiy/xH1G
         9EqKnhlDevXY0pe9FQmxEDnnSrGVa0WSREXcrszcuWcRQPJJagrIx911wbq1pUQ+p7xZ
         fN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053075; x=1765657875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MCqDkx8QDPam93BcW+nX5AGGubdW4uJQXEv2YuiEPc=;
        b=IM/l+q8ywC3Q/5ugiqoU3LI8fNvCxcyAMq6j3EfaEjWykqAuYcvT+jCB67IGsDgV8h
         AHQ4cevmZp1hMzG+V6eH6FHr7OcIc/DWpzbaiyDUzHNom8n4rc+pgdIfWwyqB/YFHwCH
         n1rMCR+7QPQ3MZ3B1AZQo1odFwlJ6tvpWTyRaDyAn6PEXk5MZMKZDA7FiuWr7tsi4Z9g
         LpceMLOAMLvlfJ3MIa5k1/uYCveun5IsaP6oCdacX6WDz+UYxTTSCaa6AnbBlQbyqqco
         6a91m4criq0Jswywi+23UHdGPu+Ze08ZFKa7UgJiMqS9+aOK15ubpI/0VPHeuGJ9F7Mv
         MIYw==
X-Gm-Message-State: AOJu0YwDOEus4IJCZ32vu3D4NcSI+/s0dleHDYZ+JtdpU12aWrWwAH/W
	bV5pTuZa9RJaOVsdXy21Up0uicGecKuswC2yqaUf8utqxgcVK4j/R8tC1wdQc/6HU6nbrMGwq5C
	wZq9FoD4=
X-Gm-Gg: ASbGncuMGLapFx1QjXFI7Kid+CKtVmL6HvILimmvi4IFDcOtXp1L7NTYuwvPHhLTQd8
	OPLsx9BhqZMhtQsl5lDKhVDHP3a3QLRGuAI4uCjNQcuzxQkzVJ5/j2Nhsv1mV4QRtJy60fVtjuB
	0WrRDF3HltVTQX9g0KleUWrLPykF4Zmb2mzMYAjYaF071yK+B/8DZt2F8ailwZigIurPT5HM8D+
	DXiu93TnLsAf2C8Nh/cjpra1JgLPCJhX+Ew9XmfV+cp3xQ2fZE0Omuv8AXfTQ5cVmD66MpJ0/wC
	ld9O1ytTPRn+GDy8HbBPhT3oHr2E6PA4XcAGR+QyicQ3GOu1gakLParzRu98yypGuyD7PVhymfM
	LOO0gOF9BO3Js0VYZB7DTVWnUYSIBKylVj2lToQq3z18OvesHhXP+E6U20THJ3FeurhauCcfjXl
	AQfPmjYg30JAK2ssZAO2gdJyxtXoPg59X6BwdzSWPrlnVC4VLXNfDN0/ffaJiKtVZYaq65DzWTU
	T7Cas+h6i+fHJaMZg==
X-Google-Smtp-Source: AGHT+IFXsVevSx6ED9Ptx+qQ9+ZmVwnSIGet5jZUxSxNx1wo/OGvep0pyJxSENlannaLSdXcSgKU6g==
X-Received: by 2002:a05:690e:400e:b0:644:542b:bd1a with SMTP id 956f58d0204a3-644542bc123mr568443d50.59.1765053074786;
        Sat, 06 Dec 2025 12:31:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b4e574fsm30588427b3.24.2025.12.06.12.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:14 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:13 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 05/17] git-multi-pack-index(1): align SYNOPSIS with 'git
 multi-pack-index -h'
Message-ID: <e19fcd92622c282194fd60d4a8e8feb135c50551.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

Since c39fffc1c90 (tests: start asserting that *.txt SYNOPSIS matches -h
output, 2022-10-13), the manual page for 'git multi-pack-index' has a
SYNOPSIS section which differs from 'git multi-pack-index -h'.

Correct this while also documenting additional options accepted by the
'write' sub-command.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc | 7 ++++++-
 builtin/multi-pack-index.c              | 5 +++--
 t/t0450/adoc-help-mismatches            | 1 -
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index a502819fc38..164cf1f2291 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -9,7 +9,12 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] [--[no-]bitmap] <sub-command>
+'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
+		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
+		         [--refs-snapshot=<path>]
+'git multi-pack-index' [<options>] verify
+'git multi-pack-index' [<options>] expire
+'git multi-pack-index' [<options>] repack [--batch-size=<size>]
 
 DESCRIPTION
 -----------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index ca98d4c3ba3..c0c6c1760c0 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -13,8 +13,9 @@
 #include "repository.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
-	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]" \
-	   "[--refs-snapshot=<path>]")
+	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
+	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
+	   "  [--refs-snapshot=<path>]")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index 8ee2d3f7c81..e8d6c13ccd0 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -33,7 +33,6 @@ merge
 merge-file
 merge-index
 merge-one-file
-multi-pack-index
 name-rev
 notes
 push
-- 
2.52.0.171.gd6a4e6b6955

