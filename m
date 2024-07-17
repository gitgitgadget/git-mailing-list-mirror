Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6025C17E91B
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222261; cv=none; b=ef6z29TQ3VH27PKTmvCnOy9WAZ+ixtsL9sMfh99W/tPbjip6iwo4VmLrwHwyF5wNX3oeGPebPinbQb3rxdbQ2KE3YKOtg/zuZz7CeYOu31J8YGmpEhc3ablVEDntir2dMgZldMf01g/J7yY9q0Wf1F+T0aToRIeYNzm7hj00dyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222261; c=relaxed/simple;
	bh=9bXKsAb+OHmNy47moerA815+p++oAFx+dh2xl4bkB6Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YNIXZhsPY5otJ2Pfn4/CaouhEWWgMOPjH4a3yvTw/FxA/IiJnm/8PueAjGVr24VqHSlWUM6/Kgap1lehWTfKwH4pmE2hz9QCrn7il/edBuwyVpFreJhyx+x4POR3dZY7DcwOZLGI410kUUZU3/gqOzYZEUR0nWQA17f30t9/eDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BXw3T2Jk; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BXw3T2Jk"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-38c616bfb47so4432405ab.0
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721222258; x=1721827058; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcD028qsdhewmGH59z16glkIG8HdYX8lL4B0W+e2zBI=;
        b=BXw3T2Jk1WMguYYdeYMvg7NOmJFFy5YRj/l0kX7kVBeRP4Zu2bDmHDM0JMPUtHpbZC
         LdV+iJhcge5+JCcarTptLu7A3AJhpF/abG+QTfKubvwVO4/FpJxLgOerjEJL5zpE6HjI
         QgZCukVgsNAQgrgJGHEda/3HUtW84wZlyBhyxRM9gr9fxh5NdaBjW5QjGvPZhosSiQMK
         DBFfOTRxSBn/knUdxlRTYxrRHugJ/AsEItpldx1MhnCBit804ttfUmC+8CYfnjCKr71M
         nvDu3l/fKZXHg+o549k3fkBlFR4BoYaYiInuwPGZUmvsc3PtOtqQX78ZCwQOoA9P6cug
         0BUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721222258; x=1721827058;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcD028qsdhewmGH59z16glkIG8HdYX8lL4B0W+e2zBI=;
        b=FJYC2GapNCMKYMO48bCEE2ZNJceTC10jEFhSxf2epYDbJov/OH2d42IO7TfzEoKx+P
         m3VCFpQQ/Sy96+wUChX5ZmkQvnCJ+0npbJ2Dcs3GOHNgszPqYGX6Uc2N5If2hCzkqlGf
         o2bJ7imRb5Zav9TQ3dVufyuqcVzJMuyPi9hhUwHbV5eTgKSMY7cK1b3e38bSdAI8CB1h
         RdgHiGEJupOgRDlbTg1fRd/A7bEIfLNsjbgtc4OY1CaM53l0X5eZYC7dO8F6rNgS8p4U
         AC8BYoyrWt3A7COoo5s4lazTqW335Etxw4SCytsj6bWJQBJSb69+jBH9niQDkZenhu08
         +9Sw==
X-Gm-Message-State: AOJu0YzhkB/Dl6u6ibXuve/YQ8TxYH2RbQw7wHbdqPH20PvclPQI+IlB
	aQi43SqgBMcRBh5wqoV45B7aOj2S517WobujJ+BmCWQWAoyHOd2NsRkbsAg+tJVr99DWJubeBrk
	t
X-Google-Smtp-Source: AGHT+IFM8LRzX5AFfyIMUcE/43p2c25hZjqTBnK5ZXv61UWaWcVdeTS2rzBYGj9SIRPQS6Em0dMAeQ==
X-Received: by 2002:a05:6e02:1d1a:b0:38b:48c9:55be with SMTP id e9e14a558f8ab-395526d98ffmr19150035ab.0.1721222258069;
        Wed, 17 Jul 2024 06:17:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950b1d5f6esm7443435ab.28.2024.07.17.06.17.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:17:37 -0700 (PDT)
Date: Wed, 17 Jul 2024 09:17:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [PATCH] Documentation: fix default value for core.maxTreeDepth
Message-ID: <57610d9ca635b6c76b9af5b3d3f346a9bc7621be.1721222249.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

When `core.maxTreeDepth` was originally introduced via be20128bfa (add
core.maxTreeDepth config, 2023-08-31), its default value was 4096.

There have since been a couple of updates to its default value that were
not reflected in the documentation for `core.maxTreeDepth`:

  - 4d5693ba05 (lower core.maxTreeDepth default to 2048, 2023-08-31)
  - b64d78ad02 (max_tree_depth: lower it for MSVC to avoid stack
    overflows, 2023-11-01)

Commit 4d5693ba05 lowers the default to 2048 for platforms with smaller
stack sizes, and commit b64d78ad02 lowers the default even further when
Git is compiled with MSVC.

Neither of these changes were reflected in the documentation, which I
noticed while merging newer releases back into GitHub's private fork
(which contained the original implementation of `core.maxTreeDepth`).

Update the documentation to reflect what the platform-specific default
values are.

Noticed-by: Keith W. Campbell <keithc@ca.ibm.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/core.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 93d65e1dfd..60ca9f2b68 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -756,4 +756,5 @@ core.maxTreeDepth::
 	The maximum depth Git is willing to recurse while traversing a
 	tree (e.g., "a/b/cde/f" has a depth of 4). This is a fail-safe
 	to allow Git to abort cleanly, and should not generally need to
-	be adjusted. The default is 4096.
+	be adjusted. When Git is compiled with MSVC, the default is 512.
+	Otherwise, the default is 2048.
-- 
2.45.2.746.g06e570c0df
