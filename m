Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874723;
	b=GhXTNKoGQ2h33J/OMUsa0RPzxwqz4s08ChbuCc6KMtsOQJjdr9ijstsN0xAAByXm1xEL
	 ch7T2oqr52FeYckih97rpImblFQAHGPyeLheFOHF85dK8ed0N/sNq8nzd4xViQbCvGVey
	 uyj97u8+se7XQbzIDZnipLuChWsVxgA3anKc4KbEzriQ6pfiPSIIZuki2LUjam0Y3xwdv
	 i2lrDg51MeLvZHpR4YOQA1IqhsuCi5NyYxWWHsP5knBDbrt6zObaigC5ALXHR78aJUmNP
	 0I31Xfh3nPUcxvjKPHVIL/D2pcXio9+HGP8VnqSSrAmIKtYJFcftMAGiOi9hdrW8Hyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=c6yXoDXU8rEDd23sP9/NifRprhurb3xFp9btBts++nU=;
	b=mrV2OXR38KRmVBoPWoUmtfVESZZ8F7pkqNH8QZX6/cF764oCxotLkkgYd+ogQp0cS95d
	 fPFQmL5phFJ0+OYhNlYv5/9J75c5eBYNRxhjPLLGYtbPg2RL/SHxHYZaftjD0sdI0Wu/e
	 nGCfcHzYsm70fhrucTkCdlZ/uwuJvZKXaD/O0ch8ZZgTz8N8tJks+T+Zp/k4bRMMrn7J+
	 VrRQtT3XdkynNSG5AeNijcK75FDS0gKp433BhwqWT8HAoyO3YidaaZGf2K7ew/4AB7URV
	 IBH6bUMMO8k9ZGpBGZauEQdGHD0lSFB82hYy1PcmW0NzCdQfktbXRFHfGNAi2uT2BGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c4KZqIYM;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F040C606A338
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F040C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c4KZqIYM
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e3b22e971so867591f8f.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 02:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793874721; x=1794479521; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c6yXoDXU8rEDd23sP9/NifRprhurb3xFp9btBts++nU=;
        b=c4KZqIYMoLo4F3KCbOOMPGJhHuOlmwje3hgsrGZXhrJX0BLksgiigIxkIwK/NmxKAH
         aONil5UHpl0EamA8H+E8dKkBiO1BOmaorP7c6pEZPlShLhBoDq0f/raQ3yqlcOrMXx2A
         qU0044mTxTPTLU1ILEcun7LBAaxnENZIYl56rnEpu+cZN8kZVHBrbmAQo2lpIZfm7fu2
         cg64vDyjcdGA1BRfVJH7leVfohpPwqNicI1QXe32PxIu1FVv8R3iwLhGENeeoa/e8xPY
         ESl2Y8IajPKAO+KofB3k/lGkQKNSH6A0ubZ9GYRvWgNpdpLX5yoHjU4rJYev2L4tmfAT
         mzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874721; x=1794479521;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=c6yXoDXU8rEDd23sP9/NifRprhurb3xFp9btBts++nU=;
        b=LpeuyrIepc1O0UvD8v8OqLx3chgFf3HszmEfScE+wDJbNfDhP49X8GaYPlIGq1Yy6s
         uNxwDCvzYwwcmvkntRvSwR7dfRDmgTyrfCo2n+TriM0GM7qZSLiz0oOpsnnNOGq2mdsL
         kK4tx+1twjbd5uAUjtwW3RdzEsuX/EdgA+EBzmyEnw8PqC+f6vbuLc7HpQJhhUvcEj6f
         Axm7i5sF5tzyHZrEK8CCKkY8YbxEu6RZ75bTL2q5dd9pvwbcKklLFbHksHKHg0Vexbj/
         5OLKRT7iLKI0VvvcMHiu6Io42zCOLVHH5TNF1Wka1rlAUyr5j8Lg415FEfCip2Q9QI6E
         JL0A==
X-Gm-Message-State: APuU4Z+kUCKwc3bFsoYeaZbJXEaNtQ/XIlE4oap4tnpbSEDfCLCuhHih
	giYNiUQX0ntWRzPkUbe6Wy6H9YBtT1BBnYihc0BH7ZC43vY1j9GhywRbSrmPGw==
X-Gm-Gg: AYBFou3M6JztQZEhDP21xummXdW13Gu1S9RqcK23qxfRRHMh11U8+/xSUlJq6QwSehs
	AhWXhbk7tkZ0r27bDiRTkSP9WOqJpBugjKDBLCJvly5J0MILnBU1ikcTkYYYZpDcjgRTYoxZh+X
	Nan0MrvBMmUI8BKQH9x/bEdEvLXcpvLrRUeiK1tEcwgHjVaWJfdrndAP792DSvYAqqVwDR8i92E
	WEK6BjvRziXHy4+g+VzK6Tk0xnsQ5yEY8ga1wRk2HI97G+dBCKscJrbTStyq68ZCRig8xj/q+Ra
	TcPksQxlZeZrVPE1vKFR5CZFUzyON52wboUivkIvfS52QahA8QYN4BbuyrriHcaja9pVeV1ituy
	el5J1J6cKc0jQ3AyVKiL1X9H3I3VU8Zh3CTcUc1Ya91Kh/qMk7fc9TvYN9VpcP77zGV0vVSk6j7
	Ub0/M8j8pvxzhPcUkJjP6TSIau4Poa0rXiA4MbjgrAxAXYW8qyBBZrAHjbrXrpLy5SN2LN8boNI
	nCOYo+TZRnoohWgy8+MIQe4WrU7sci9SR6JPZRrWesf4GKDNji1a7fXI0OlUiVFU5phgHYjwuef
	H3fUx8z9XRObuM/QBg3gBVR5uxhVhaSHJ7bSmAuaY8qfwa29FK9Yrxdy7jBnag+ETIGH5jJBhB1
	pQ539Gbv16nwM1Q==
X-Received: by 2002:a05:6000:40e1:b0:490:197:5de7 with SMTP id ffacd0b85a97d-49001976027mr8380317f8f.45.1793874720886;
        Thu, 05 Nov 2026 02:32:00 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:e263:8d23:75e2:5686])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda2007esm9106159f8f.47.2026.11.05.02.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:32:00 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 05 Nov 2026 11:31:55 +0100
Subject: [PATCH] api-parse-options: add missing flags and macros
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrDuQRC3Yq5QuYhztKCQhE0UQ7
 25slx+89x8glJgEXtUBiTYWDr5APypwX+snQh6KwSjz1FrVuHiMNglhiLlsBYfgsG+s7WpFo2k
 VlGtMNPL+y74/f8vaz+Ty3YLzvAAd2xz3eAAAAA==
X-Change-ID: 20261103-kn-parse-options-doc-b4aa930ef250
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8358; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WB9jZepH16iD4PifCGbplfiqzClbBcekjYmNjPYMCQ0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrsWx+XI+PD2MPHxjWg5i/0OI3+egXYHxC1F
 cgjGC4JqxARgIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq7FsfAAoJED7VnySO
 Rox/8aQL/3L/gptwr/kvuHdE72MzIYuJdWFiFD4pkGrf2RAJvHMJPNEKjmxZGg5uh0Iq9Vh+Fm+
 CSXlNPLI28bfazVHEhC0mnCeE5oeKAlhA8LgbwsXfP9mIeQ5+j+ZKqw/33G218mIik7jTjATch5
 aB9gUC95sfOj3GvM/804mj3WrJWv/S/qLlVXzrgGz/W4p4EsvAWBRjUciz0E4v2qdLJtC7b+b6S
 MRpk3nenZH+Q5W8Tj/R7ccGcm1CMDMOVjMkpvX7jwJzl9psTfTvuFlL90DaNeCrZMBR0dInid9O
 RK2pwjE9DtUT3i+WfA6XRYegGuOvwUJJNGBJy4pz+OaCKr2t6NeIXKbOecIH0EhUDjSmLP9SOQw
 oOGslYT+JbqLKh+3Esx713YT02ENx3OqDBjhsPS1Di4+LidaNRilUjTVaDDCc8ap5EChCKp+IDi
 EvFbdoGCchdrKJcFh+aX3N7m7HxND0kyMcsY0Ry6LRWW154TCGCRb4Yj9hkBTkOUf21H2mS9576
 S8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'Documentation/technical/api-parse-options.adoc' contains
documentation around the parse-options API. The document is missing some
of the macros and flags provided by the API.

Add the missing flags 'PARSE_OPT_ONE_SHOT' and 'PARSE_OPT_SHELL_EVAL' to
the documentation. While 'PARSE_OPT_ONE_SHOT' was introduced in
202fbb3315 (parse-options: add one-shot mode, 2019-01-27) as a temporary
flag, it is now 7 years and still exists. So let's document it, as when
the time comes, it is always easy to remove the same.

Also add the follow missing macros:
  - OPT__VERBOSITY
  - OPT__SUPER_PREFIX
  - OPT_CONTAINS
  - OPT_WITH
  - OPT_NO_CONTAINS
  - OPT_NO_WITH
  - OPT_CLEANUP
  - OPT_PATHSPEC_FROM_FILE
  - OPT_PATHSPEC_FILE_NUL
  - OPT_AUTOSTASH
  - OPT_DIFF_UNIFIED
  - OPT_DIFF_INTERHUNK_CONTEXT
  - OPT_IPVERSION

This brings the technical documentation in line with the code in
'parse-options.h'.

While here, add the missing `flags` argument to `OPT__FORCE`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
I was reading the docs while reviewing another series and ended
up finding some missing documentation. This patch tries to cover
that. Some of these might be options/flags we rarely use, but I
strongly feel its easier to make choices when there is adequate
documentation.
---
 Documentation/technical/api-parse-options.adoc | 103 ++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 6dfea34220..8b7eeb7b9b 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -138,6 +138,16 @@ Flags are the bitwise-or of:
 	turns it off and allows one to add custom handlers for these
 	options, or to just leave them unknown.
 
+`PARSE_OPT_ONE_SHOT`::
+	Process only the first option (and its value, if any) and return
+	the number of arguments processed, leaving `argv[]` untouched.
+	`argv[0]` is taken to be the first option, not the program name.
+	An unknown option stops processing without an error.
+
+`PARSE_OPT_SHELL_EVAL`::
+	Wrap the usage output in a heredoc followed by an `exit 0`,
+	so that a shell can `eval` it.
+
 `PARSE_OPT_SUBCOMMAND_OPTIONAL`::
 	Don't error out when no subcommand is specified.
 
@@ -230,15 +240,25 @@ with `flags` set to `0`.
 `OPT__DRY_RUN(&int_var, description)`::
 	Add `-n, --dry-run`.
 
-`OPT__FORCE(&int_var, description)`::
+`OPT__FORCE(&int_var, description, flags)`::
 	Add `-f, --force`.
 
 `OPT__QUIET(&int_var, description)`::
 	Add `-q, --quiet`.
 
+`OPT__SUPER_PREFIX(&str_var)`::
+	Add hidden `--super-prefix=<prefix>`, which stores the prefixed
+	path to the initial superproject in `str_var`.
+
 `OPT__VERBOSE(&int_var, description)`::
 	Add `-v, --verbose`.
 
+`OPT__VERBOSITY(&int_var)`::
+	Add `-v, --verbose` and `-q, --quiet`, sharing `int_var`.
+	Each `-v` increments `int_var` (a `-v` after `-q` sets it to 1)
+	and each `-q` decrements it (a `-q` after `-v` sets it to -1).
+	`--no-verbose` and `--no-quiet` reset it to zero.
+
 `OPT_GROUP(description)`::
 	Start an option group. `description` is a short string that
 	describes the group or an empty string.
@@ -273,6 +293,11 @@ with `flags` set to `0`.
 	Introduce a boolean option.
 	If used, `int_var` is bitwise-ored with `mask`.
 
+`OPT_BITOP(short, long, &int_var, description, set, clear)`::
+	Introduce a boolean option.
+	If used, `int_var` is bitwise-anded with the inverted `clear` and
+	then bitwise-ored with `set`. Cannot be used in the negated form.
+
 `OPT_NEGBIT(short, long, &int_var, description, mask)`::
 	Introduce a boolean option.
 	If used, `int_var` is bitwise-anded with the inverted `mask`.
@@ -291,6 +316,16 @@ with `flags` set to `0`.
 	The string argument is stored as an element in `string_list`.
 	Use of `--no-option` will clear the list of preceding values.
 
+`OPT_STRVEC(short, long, &struct strvec, arg_str, description)`::
+	Introduce an option with string argument.
+	The string argument is appended to the provided `strvec`.
+	Use of `--no-option` will clear the list of preceding values.
+
+`OPT_UYN(short, long, &int_var, description)`::
+	Introduce a ternary option.
+	`--option` sets `int_var` to `1` and `--no-option` sets it to `2`.
+	If neither is given, `int_var` is left unchanged.
+
 `OPT_INTEGER(short, long, &int_var, description)`::
 	Introduce an option with integer argument. The argument must be a
 	integer and may include a suffix of 'k', 'm' or 'g' to
@@ -340,6 +375,17 @@ with `flags` set to `0`.
 	Use it to hide deprecated options that are still to be recognized
 	and ignored silently.
 
+`OPT_NOOP_ARG(short, long)`::
+	Introduce an option that takes one argument but has no effect.
+	Use it to hide deprecated options that are still to be recognized
+	and ignored silently.
+
+`OPT_COLUMN(short, long, &unsigned_int_var, description)`::
+	Introduce an option that takes an optional argument and sets
+	`unsigned_int_var` as per the column layout modes specified in
+	linkgit:git-config[1]. `--option` and `--no-option` without
+	arguments are equivalent to `always` and `never` respectively.
+
 `OPT_PASSTHRU(short, long, &char_var, arg_str, description, flags)`::
 	Introduce an option that will be reconstructed into a char* string,
 	which must be initialized to NULL. This is useful when you need to
@@ -366,6 +412,61 @@ with `flags` set to `0`.
 	this subcommand is used. The subcommand is not listed in the
 	usage output.
 
+`OPT_CONTAINS(&commit_list_var, description)`::
+	Introduce a `--contains=<commit>` option. The argument is parsed
+	as a commit and inserted into `commit_list_var`. If the option is
+	the last token on the command line and has no argument, `HEAD`
+	is used. Cannot be negated.
+
+`OPT_NO_CONTAINS(&commit_list_var, description)`::
+	Like `OPT_CONTAINS()`, but introduces `--no-contains=<commit>`.
+
+`OPT_WITH(&commit_list_var, description)`::
+	Like `OPT_CONTAINS()`, but introduces a hidden `--with=<commit>`.
+
+`OPT_WITHOUT(&commit_list_var, description)`::
+	Like `OPT_CONTAINS()`, but introduces a hidden
+	`--without=<commit>`.
+
+`OPT_CLEANUP(&str_var)`::
+	Introduce a string option with `--cleanup` long name. Commonly
+	used to parse cleanup mode as specified in linkgit:git-commit[1].
+	The option does not do any parsing itself and simply stores the
+	argument in `str_var`.
+
+`OPT_PATHSPEC_FROM_FILE(&str_var)`::
+	Introduce a `--pathspec-from-file=<file>` option. Commonly used
+	to read the pathspec from a file instead of the command-line
+	arguments. See linkgit:git-commit[1] for more details.
+
+`OPT_PATHSPEC_FILE_NUL(&int_var)`::
+	Introduce a boolean `--pathspec-file-nul` option. Commonly
+	accompanies `OPT_PATHSPEC_FROM_FILE()` to denote that the
+	pathspec elements are separated with `NUL` characters.
+	See linkgit:git-commit[1] for more details.
+
+`OPT_AUTOSTASH(&int_var)`::
+	Introduce a boolean `--autostash` option. Commonly used to
+	automatically create a stash entry before the operation and
+	restore it after. See linkgit:git-merge[1] for more details.
+
+`OPT_DIFF_UNIFIED(&int_var)`::
+	Introduce an integer option with `-U` short name and `--unified`
+	long name. Commonly used to denote lines of context for generating
+	diffs. Cannot be negated. See linkgit:git-add[1] for more details.
+
+`OPT_DIFF_INTERHUNK_CONTEXT(&int_var)`::
+	Introduce an integer option with `--inter-hunk-context` long name.
+	Commonly used to show the context between diff hunks up to the
+	specified number. Cannot be negated. See linkgit:git-add[1] for
+	more details.
+
+`OPT_IPVERSION(&family_var)`::
+	Introduce `-4, --ipv4` and `-6, --ipv6` for selecting the IP
+	protocol to use. Neither takes an argument or can be negated.
+	`family_var` (an `enum transport_family`) is set to
+	`TRANSPORT_FAMILY_IPV4` or `TRANSPORT_FAMILY_IPV6` respectively.
+
 The last element of the array must be `OPT_END()`.
 
 If not stated otherwise, interpret the arguments as follows:

---
base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
change-id: 20261103-kn-parse-options-doc-b4aa930ef250


Thanks
- Karthik

