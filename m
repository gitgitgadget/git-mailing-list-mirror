Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493F21D3F6
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952461; cv=none; b=THsaRttuwRd4+c0mBz8ECzp8teBNYee02L7gQZM58pHoAUssR8YaHLvNFzs9Ud6E/Vn1/lbmcf0Bv8og+IU7EHWgown49D3d+NJckLiQlTNXxBzOYhGnMMcDiNE4nsKRkq1dlZatRnXR5tzZnfFUOTyiXuoa44MOi7frAl8gXQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952461; c=relaxed/simple;
	bh=O03ox2OTdC+Pr8/JR3Kv6NY57XZn7dd4WT+2p1tL49g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=azhWGxVnrrmKC+NvDU9YvxV64ZCZuSDsrCcwMvLE7zPQgbLipMJFB2m81guBtTd7Be6ntocNay7N27ENDUer6ST8li8I8zfgbdWUsvh5zEBzPk2XC/Q58AP2KFCuBSbwapTp6BIt9h9snN40at5+b/fd8ndn2E3/o0yHJmsGfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRI0Uzwz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRI0Uzwz"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7682560a2f2so647342b3a.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753952459; x=1754557259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPQKN0buZM9w2wNPDazxNz7Eqlmchl9jQe1BzYvMCZM=;
        b=YRI0UzwzN5NDedgryhjYglwHcGuZFamvKfGaC9eRp2mhKTVjcW5YWoOoNPcvbTPtw0
         bVcmPn6KeK7k2bzqOWquyAtdshfCfZJoQitbz3l3Q2MbxTa6LDsRPX3N6xLG4E1hhpil
         eDQkEYmyQxtyjO3kDoeDiG4CNEFuj7ljwUexibJCDHQRe2t/m9Hac6Vbpqzw8M/w3Zkx
         xeP302SJfNuAfOlOidaCDlyOAUrt+kglo4dSRI1vvIGI66NHMuVQDswMqrphoalFQ7A+
         C6sKw01O4xgoQkIYUtfzq+GeE+CMCqSTnAuVMq8sNAI00werscg9fL1DflWnIlVE7D1T
         Z5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952459; x=1754557259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPQKN0buZM9w2wNPDazxNz7Eqlmchl9jQe1BzYvMCZM=;
        b=VzUcz+VPjX/QLGAvCLJ7TsdmGnz81GC7DyWg+OSJCkaf/qxOP125vPTS6Wr9Xklr3Z
         k+TurPWoFhUDuGLn3Uz6UJaGmKXVSDdrS/EaF/sdS66zD9FxXAMK3i4i7GpGD20k01R0
         VFZ+zLEvpdnEe5DeYI6HtPIL5ROsrow0NnjpYE8NASeKUJOpwRnaZDuuEpn6omclPd9o
         HpvPtWJh3DSl51R56HsSg8KiH85j3zoRTaM1CIZKpcWS+6kILdIR/VgIZ8/S2Xx7RrwZ
         grkc3GRTez4HlV0PJHM0YGmS5kWDaCjRF8ciMW4DYTDV3AH0S+E5dUldm8a4ZzpFsTLb
         yp1w==
X-Gm-Message-State: AOJu0YwiEdZgQMcm+cztJNf50PmKZji4HhLcGiAU39gmjl+GZD+7QA3R
	CGqKeiVPzi01nCo513Z0ZZ/1pw3fdtsRkULmqcCilntE6AMDA4OGmuRl1GFhGw==
X-Gm-Gg: ASbGncu5atkUYyZyQYTac7v119jeqH20/mhO9Z6mZWLi+fAp7PiCwvmiGkehKC+qZho
	0OzVPMxwJ7IVUMZ6Vksfu2rkb0HjMxYcdJQlBHTRNSVbvOPZmCJR/G4mh8ZmoIrNpd4jNIExLCJ
	CEawqunoXEwCX4ln16YGg8ZulnEUodmTo0Ix80LCn+T4lqbz4voZCnZaG7P4WS6oUjUVXc0GU6r
	P0/DPC08HakMutC4IftU6+81FLTviTaUH74Y/ESjIZcqRif+N20Gs4E2JstxQllI5/0Sfba4+GD
	2Yy1WZtZX5PlvYpyEt4cMD7Nt8yBo3wT80gP8gsS7yslgKWSqLBhDD/znPggXQ6Lr0Pn3+xZTKK
	QiFtuhV8JAP0rpHSwMmw=
X-Google-Smtp-Source: AGHT+IGQNpiN4PKTfuKjh+XmekDUTkWywwBRs//vTXpyw/7quMO5dpHEyyeNiagedE4HJ612ASVuyw==
X-Received: by 2002:a05:6a00:859f:b0:76b:cc37:d4c5 with SMTP id d2e1a72fcca58-76bcd0810e8mr2033574b3a.5.1753952459401;
        Thu, 31 Jul 2025 02:00:59 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd22csm1057745b3a.65.2025.07.31.02.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:00:58 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	Meet Soni <meetsoni3017@gmail.com>,
	John Cai <johncai86@gmail.com>
Subject: [GSoC][RFC PATCH v4 3/5] builtin/refs: add list subcommand
Date: Thu, 31 Jul 2025 14:30:38 +0530
Message-Id: <20250731090040.1625303-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731090040.1625303-1-meetsoni3017@gmail.com>
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git's reference management is distributed across multiple commands. As
part of an ongoing effort to consolidate and modernize reference
handling, introduce a `list` subcommand under the `git refs` umbrella as
a replacement for `git for-each-ref`.

Implement `cmd_refs_list` by having it call the `for_each_ref_core()`
helper function. This helper was factored out of the original
`cmd_for_each_ref` in a preceding commit, allowing both commands to
share the same core logic as independent peers.

Add documentation for the new command. The man page leverages the shared
options file, created in a previous commit, by using the AsciiDoc
`include::` macro to ensure consistency with git-for-each-ref(1).

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-refs.adoc | 16 ++++++++++++++++
 builtin/refs.c              | 14 ++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 4d6dc994f9..ee563aa7e0 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -11,6 +11,13 @@ SYNOPSIS
 [synopsis]
 git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
 git refs verify [--strict] [--verbose]
+git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
+	      [(--sort=<key>)...] [--format=<format>]
+	      [--include-root-refs] [ --stdin | <pattern>... ]
+	      [--points-at=<object>]
+	      [--merged[=<object>]] [--no-merged[=<object>]]
+	      [--contains[=<object>]] [--no-contains[=<object>]]
+	      [--exclude=<pattern> ...]
 
 DESCRIPTION
 -----------
@@ -26,6 +33,11 @@ migrate::
 verify::
 	Verify reference database consistency.
 
+list::
+	List references in the repository with support for filtering,
+	formatting, and sorting. This subcommand is an alias for
+	linkgit:git-for-each-ref[1] and offers identical functionality.
+
 OPTIONS
 -------
 
@@ -57,6 +69,10 @@ The following options are specific to 'git refs verify':
 --verbose::
 	When verifying the reference database consistency, be chatty.
 
+The following options are specific to 'git refs list':
+
+include::for-each-ref-options.adoc[]
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 998d2a2c1c..848a7c9072 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -6,6 +6,7 @@
 #include "refs.h"
 #include "strbuf.h"
 #include "worktree.h"
+#include "for-each-ref.h"
 
 #define REFS_MIGRATE_USAGE \
 	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
@@ -101,6 +102,17 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int cmd_refs_list(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	static char const * const refs_list_usage[] = {
+		N_("git refs list " COMMON_USAGE_FOR_EACH_REF),
+		NULL
+	};
+
+	return for_each_ref_core(argc, argv, prefix, repo, refs_list_usage);
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -109,12 +121,14 @@ int cmd_refs(int argc,
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
 		REFS_VERIFY_USAGE,
+		"git refs list " COMMON_USAGE_FOR_EACH_REF,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option opts[] = {
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
 		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
+		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
 		OPT_END(),
 	};
 
-- 
2.34.1

