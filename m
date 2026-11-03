Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694818;
	b=36Bvy5H5ksStf4vjPr7QtETUclTO0zBWKQ/bHJOKaHoMJWWhPh1xST1FV7nhJPHs4nd1
	 NaB1yVo3/9mwCeTMWu+3Zy1CdF8ic/muNXjGBze48q1ZYzx9ialIyCWocP9uzw9J03+qw
	 FNOuKS2FuM51nBRrhGOV6LPM7XewLEcrzl/ORrPVyyxjG5Z68XIoiNtUnsMzQ7frrLmgx
	 jFrjWgPnZISK4heaC1TvGCNTGzSHzk17CPDnA4+XKYmf07FD8WZLIO4NlBg1O4BF1JdQT
	 y9GHgpSc34mylYITRD+mBaxdmG4LcqamlxslK8YH2dvTj2uIugJ4gPsSHQYN3Z03N4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=+MngY9dah/x26kMsJryyjRHG0SyAu4uP9xkz02vdgpc=;
	b=nJpwRwb2UHqM0TvKqP3g+leJnLJUjqv5xxCZrcbnXQfVAyO4CUR/H9iaPjxqRcL2SxH4
	 WPfBo1wvg+06285DzIi0me/OXtJF3NGFekKbJQsqILEuXZ0S4181b9A7YypXVr1YNSC6B
	 kWxIIzaIG+lY/hTzJqiLSf30sPyCDODVLPCLRSLrAqpoOnBbawEFgqukrEMCbZ8RBOhRo
	 fieK+RLl+3q9tqDpDlEavHCxOxwAxS5ddz2hjm05pywhvtTrO8b9kR5WiRlb+TF8z70yB
	 rC+WfavGkvZsNfsCqE4o2hwJcyymnelLs7MhdIszsPasMCshJljaA8bFmLfAOC4jjpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BFspNVuN;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40077608362F
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 08:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40077608362F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BFspNVuN
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6de2f213b7aso1671136eaf.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 00:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793694817; x=1794299617; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+MngY9dah/x26kMsJryyjRHG0SyAu4uP9xkz02vdgpc=;
        b=BFspNVuNgXiBCRMGTWE5OiZxLYIhCOruEE6zHRCZm1LtsPrGyif50VkrFtPZHcsxHS
         +YTDcafvQDrSjqFJR3WSp3p3GJ18sym/4AkR1BmzTP43KOMI10ed1+nLDAfMROnVki2s
         dd3/IYW9wnWXZyQHhXrw47k1fhnTzmDw1XFWzmtvyd/yDnMPCd+Mm/YPTiZk/IcAupNO
         crU8iWnmIpLyYvYeMnKVF4uysEU2xNQEl7vyWV1hKl5L4JIynEX1FBEgw4n43sXQYj/3
         cq7IdVk7tcdQaHwuDLsPchyGnVqilTrY01WJrnIxen02F32wOXGaaDfkPJEdnJO9A3o7
         6BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694817; x=1794299617;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+MngY9dah/x26kMsJryyjRHG0SyAu4uP9xkz02vdgpc=;
        b=IaBk0y4zux3hffhT3K1COOGY03SqFBFktQjiqiwIn3QMuMUkpuDHvDAVIFPrbfptSV
         lv2IJsKpNhu4fepzJpxhag6X5WKnWZyQEM0bw8zvWnp4Vlh9caFu670tKPVU1f1KmEwp
         +D5ZOzCr6WMsjqouMGSNI5fcb6A9m4cIdlhZi2A80dX5Y6CpmlaJscazp7zo9t4GHOZD
         OUYSbBouQONB+racyDVjQoxEDIKZHMrYkCIq7/IjW9x1vjiR2CKJh5weY5XJQDCrV2eq
         ypjTxWgkRnoZNJZrjK95VhPG8J+pLemxp1cLAecmAh7ZEG2Qe8ttoApX87X9CMeoyt5+
         FbCw==
X-Gm-Message-State: APuU4Z/vv3vE66qh/d3raY5bvzXMlDDQJNIHoLI+tWumsuLbstzCJ/3o
	/Qjm4fE1AWViId5G2zM7CML2AGISvodjkaOfJpmRFMS4uuHJLXv8NQtvQ3bWSVn/Mmk=
X-Gm-Gg: AYBFou1ThAP8DmZSLSTDrgz0BvlkvnpPJRFHACYzwwbVLK0pftzhf6L6ehhS6qfCIsT
	XtOBBJQ1x1UEykmqSfoiaJK4Xxt/NIgaRngKz2NyCHS9Ue2VDnCB2b4saafh5wEyAwD9Tb0lSDL
	eCzzoPAz9cZjXXkZ0ffMzH3lpHCmIAK3qyPDs1z1VTiP8SNp/Qmv+z5rbQJrcVAeN4IHj6WHDvg
	DVs9mic9nXGgWH8qagKG7VjuHJoO5bO3u0EZhWfdl60raLAlRGsCEsKAeeO0TNMs77aYLlO+g3Y
	zLDAbbp0+2UWygqHfFGkynarrUiuv4a25WU/luozjSqa7fsXqYdjVSCPNN9y+6c4yyFlUaqZ1uN
	Zg5mmsAtpT3CQki9sQ8OoNE/GMXb/nTbJPtyyNAn7ie5LnxejZXOCZKjDk91YGaxhDMt2+wnTdV
	YAIxFKscEPIB1HNwqC1RnDAFLmdqqTe0wJP4MEjpnIMVVGoa7Vtqtjj7/zYQvEMgggwhqhT1vnk
	xrA52FlZvITiNh+ZYq5Eas93ig+/xwlqvN4ZmgoIQJDC5mvaIKp+sm/ELSZkxmOQ4LI/nChfn8A
	je/XeIZj+PlXILmHxebhLszD3D1DUqyFmQ==
X-Received: by 2002:a05:6820:2206:b0:714:75fd:7758 with SMTP id 006d021491bc7-714f2a2ca2emr6819014eaf.66.1793694817073;
        Tue, 03 Nov 2026 00:33:37 -0800 (PST)
Received: from [127.0.0.1] ([64.236.131.249])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2d1b4d6sm10357154eaf.8.2026.11.03.00.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:33:35 -0800 (PST)
Message-Id: <pull.2470.v2.git.git.1793694813386.gitgitgadget@gmail.com>
In-Reply-To: <pull.2470.git.git.1793298807397.gitgitgadget@gmail.com>
References: <pull.2470.git.git.1793298807397.gitgitgadget@gmail.com>
From: "Husain Sitamuwala via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 08:33:33 +0000
Subject: [PATCH v2] check-ref-format: use parse-options API
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Husain Sitamuwala <husainsitamuwala21@gmail.com>,
    Hussain Sitamouwala <husainsitamuwala21@gmail.com>

From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>

The command parses its options by hand, comparing each argument
against string literals. Use the parse-options API instead so that
option handling is consistent with other builtins and the help
output is generated from the option table.

Keep the existing behavior: --print stays a hidden, deprecated
synonym for --normalize, only --allow-onelevel can be negated, and
parsing stops at the first non-option argument so that options
after <refname> are still rejected.

Drop the early show_usage_if_asked() call, so that -h is handled by
parse_options().

Two minor differences come with parse_options(): unambiguous
abbreviations of long options, such as --norm, are accepted, and
"--" may now precede <refname>.

Signed-off-by: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
---
    check-ref-format: use parse-options API

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2470%2FCodeWithHusain%2Foutreachy-microproject-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2470/CodeWithHusain/outreachy-microproject-v2
Pull-Request: https://github.com/git/git/pull/2470

Range-diff vs v1:

 1:  9f05296454 ! 1:  991ca870fe check-ref-format: use parse-options API
     @@ Metadata
       ## Commit message ##
          check-ref-format: use parse-options API
      
     -    Use the parse-options API to handle command-line options
     -    consistently with other Git builtins.
     +    The command parses its options by hand, comparing each argument
     +    against string literals. Use the parse-options API instead so that
     +    option handling is consistent with other builtins and the help
     +    output is generated from the option table.
      
     -    The command currently parses options manually, duplicating
     -    argument-handling logic. Using parse-options makes option
     -    handling consistent with the rest of Git.
     +    Keep the existing behavior: --print stays a hidden, deprecated
     +    synonym for --normalize, only --allow-onelevel can be negated, and
     +    parsing stops at the first non-option argument so that options
     +    after <refname> are still rejected.
      
     -    Replace manual option parsing while preserving support for
     -    normalization, branch names, and refname validation.
     +    Drop the early show_usage_if_asked() call, so that -h is handled by
     +    parse_options().
     +
     +    Two minor differences come with parse_options(): unambiguous
     +    abbreviations of long options, such as --norm, are accepted, and
     +    "--" may now precede <refname>.
      
          Signed-off-by: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
      
     @@ builtin/check-ref-format.c
       #include "setup.h"
       #include "strbuf.h"
       
     - static const char builtin_check_ref_format_usage[] =
     +-static const char builtin_check_ref_format_usage[] =
      -"git check-ref-format [--normalize] [<options>] <refname>\n"
      -"   or: git check-ref-format --branch <branchname-shorthand>";
     -+	"git check-ref-format [--normalize] [<options>] <refname>\n"
     -+	"   or: git check-ref-format --branch <branchname-shorthand>";
     -+
     -+static const char * const builtin_check_ref_format_usages[] = {
     -+	"git check-ref-format [--normalize] [<options>] <refname>",
     -+	"   or: git check-ref-format --branch <branchname-shorthand>",
     ++static const char * const builtin_check_ref_format_usage[] = {
     ++	N_("git check-ref-format [--normalize] [<options>] <refname>"),
     ++	N_("git check-ref-format --branch <branchname-shorthand>"),
      +	NULL
      +};
       
     @@ builtin/check-ref-format.c: int cmd_check_ref_format(int argc,
       	const char *refname;
       	char *to_free = NULL;
       	int ret = 1;
     - 
      +	struct option options[] = {
     -+		OPT_BOOL(0, "normalize", &normalize,
     -+			 N_("normalize refname")),
     -+		OPT_BOOL(0, "print", &normalize,
     -+			 N_("print normalized refname")),
     ++		OPT_BOOL_F(0, "normalize", &normalize,
     ++			   N_("normalize the refname and print it"),
     ++			   PARSE_OPT_NONEG),
     ++		OPT_BOOL_F(0, "print", &normalize,
     ++			   N_("deprecated synonym for --normalize"),
     ++			   PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
      +		OPT_BIT(0, "allow-onelevel", &flags,
     -+			N_("allow one-level refnames"),
     ++			N_("accept a refname with a single level"),
      +			REFNAME_ALLOW_ONELEVEL),
     -+		OPT_BIT(0, "refspec-pattern", &flags,
     -+			N_("allow refspec patterns"),
     -+			REFNAME_REFSPEC_PATTERN),
     ++		OPT_BIT_F(0, "refspec-pattern", &flags,
     ++			  N_("interpret <refname> as a reference pattern for a refspec"),
     ++			  REFNAME_REFSPEC_PATTERN, PARSE_OPT_NONEG),
      +		OPT_END()
      +	};
     -+
     + 
       	BUG_ON_NON_EMPTY_PREFIX(prefix);
       
     - 	show_usage_if_asked(argc, argv,
     -@@ builtin/check-ref-format.c: int cmd_check_ref_format(int argc,
     +-	show_usage_if_asked(argc, argv,
     +-			    builtin_check_ref_format_usage);
     +-
       	if (argc == 3 && !strcmp(argv[1], "--branch"))
       		return check_ref_format_branch(argv[2]);
       
     @@ builtin/check-ref-format.c: int cmd_check_ref_format(int argc,
      -			usage(builtin_check_ref_format_usage);
      -	}
      -	if (! (i == argc - 1))
     +-		usage(builtin_check_ref_format_usage);
      +	argc = parse_options(argc, argv, prefix, options,
     -+			     builtin_check_ref_format_usages, 0);
     -+
     ++			     builtin_check_ref_format_usage,
     ++			     PARSE_OPT_STOP_AT_NON_OPTION);
      +	if (argc != 1)
     - 		usage(builtin_check_ref_format_usage);
     ++		usage_with_options(builtin_check_ref_format_usage, options);
       
      -	refname = argv[i];
      +	refname = argv[0];


 builtin/check-ref-format.c | 49 +++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index fd1c9c0e0c..d698da99d9 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -5,13 +5,16 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "parse-options.h"
 #include "refs.h"
 #include "setup.h"
 #include "strbuf.h"
 
-static const char builtin_check_ref_format_usage[] =
-"git check-ref-format [--normalize] [<options>] <refname>\n"
-"   or: git check-ref-format --branch <branchname-shorthand>";
+static const char * const builtin_check_ref_format_usage[] = {
+	N_("git check-ref-format [--normalize] [<options>] <refname>"),
+	N_("git check-ref-format --branch <branchname-shorthand>"),
+	NULL
+};
 
 /*
  * Return a copy of refname but with leading slashes removed and runs
@@ -58,37 +61,39 @@ int cmd_check_ref_format(int argc,
 			 const char *prefix,
 			 struct repository *repo UNUSED)
 {
-	int i;
 	int normalize = 0;
 	int flags = 0;
 	const char *refname;
 	char *to_free = NULL;
 	int ret = 1;
+	struct option options[] = {
+		OPT_BOOL_F(0, "normalize", &normalize,
+			   N_("normalize the refname and print it"),
+			   PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "print", &normalize,
+			   N_("deprecated synonym for --normalize"),
+			   PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
+		OPT_BIT(0, "allow-onelevel", &flags,
+			N_("accept a refname with a single level"),
+			REFNAME_ALLOW_ONELEVEL),
+		OPT_BIT_F(0, "refspec-pattern", &flags,
+			  N_("interpret <refname> as a reference pattern for a refspec"),
+			  REFNAME_REFSPEC_PATTERN, PARSE_OPT_NONEG),
+		OPT_END()
+	};
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
-	show_usage_if_asked(argc, argv,
-			    builtin_check_ref_format_usage);
-
 	if (argc == 3 && !strcmp(argv[1], "--branch"))
 		return check_ref_format_branch(argv[2]);
 
-	for (i = 1; i < argc && argv[i][0] == '-'; i++) {
-		if (!strcmp(argv[i], "--normalize") || !strcmp(argv[i], "--print"))
-			normalize = 1;
-		else if (!strcmp(argv[i], "--allow-onelevel"))
-			flags |= REFNAME_ALLOW_ONELEVEL;
-		else if (!strcmp(argv[i], "--no-allow-onelevel"))
-			flags &= ~REFNAME_ALLOW_ONELEVEL;
-		else if (!strcmp(argv[i], "--refspec-pattern"))
-			flags |= REFNAME_REFSPEC_PATTERN;
-		else
-			usage(builtin_check_ref_format_usage);
-	}
-	if (! (i == argc - 1))
-		usage(builtin_check_ref_format_usage);
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_check_ref_format_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc != 1)
+		usage_with_options(builtin_check_ref_format_usage, options);
 
-	refname = argv[i];
+	refname = argv[0];
 	if (normalize)
 		refname = to_free = collapse_slashes(refname);
 	if (check_refname_format(refname, flags))

base-commit: b9e5cff1803ab24582201ef059516eb16014b9d9
-- 
gitgitgadget
