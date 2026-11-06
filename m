Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955011;
	b=d+uClfBZQ7iS0ogMXL4tksv/7RxGYYcPRUF0+Vfp5JrOMX7zF8Le/OGb+PvUbCe60fme
	 yTjqEZpA+IHntD6o7GMPttWkOsTNhm2F3Vs03tMoHWfvJ3rcfZOHlij2anNp9edaVJH1x
	 C4Ib2VlJAU7sj8EuxDz4MEbfJU+/RipXB7zPGvp0zfr3sVvQB7YCA1EhuSalSRQsjQzIQ
	 44Sfio6i39PpCyYloPkipKIELOAA9QteNmbb9LVbAjizLxTtrGvdf6L435YHh8hGTxyFx
	 bTazuba/jExK0sAq09aHF4iILevutrzClN8HXbjVVex4wzZ79qjmoqL6q9HF1GpzSog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=INcir9hz9UCGOc+ql7OBd5vO4ztF8KOz9BrHIdV1FwU=;
	b=tG5Zc5rBj7H7SWGbpiXVkq+RvXzO20O7/lWgZrQmVYrYURVoO4VAcW9yWLJ6DX7pO5OE
	 VdQGJwoTjzBUVqluTeqBoIx2CHtxuZNtWFTEhKd8qME9k3UzB0EZtihKBj/9lTI+1Wzpr
	 gmm4oA3ve5z9+nhvJr0piUrV3LD/ktgYBPqsMZzNJOrnLNteDEcchVo8skXgBnI6zkMea
	 qB49zJ3Ro4htU8CDpypXGRQA+4Eaw7RcZBkSqpA9oeUAK71FFHATVmtzeL/8OIpI4ogjc
	 g6BDmgnBbf4gnQN1tohI/5r6sBH4jGV+G0i7xqOnXdMYlAs90X0m38v3mhgUswaAYZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lvQmsmU0;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84147606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 08:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84147606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lvQmsmU0
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so2669355e9.3
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 00:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793955010; x=1794559810; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=INcir9hz9UCGOc+ql7OBd5vO4ztF8KOz9BrHIdV1FwU=;
        b=lvQmsmU0Z97CLMNnBinKgXz24uaD31+EFOJoRTl1HsfMXYWsZ6qKA29rjvb7myCMKx
         JB/El6jH7m+mn/BOvSxIIPMEpfcR05rZT0UgMetqTaz8A7ntaFDqlDrpWcjBuqulW++9
         5AdVLF+ud9NnTqjQZBlgUglnNLfjZ6JgtzCFFzmDp/LSJdjFtFiN7dRuWfh4up4N8sje
         BH2755Iv8hsKgf/bZkXoSYPpfFK6KyzN0c/sSrx6aZSBcgv40Jxu2xCGsc7cQdj9+ir8
         vTfHSzA3ivb0gbd8JWyJp65Dr+DtHW3K36OjZ23hx33DwctxLK8vgIg3glE5sOaJJFL7
         N8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793955010; x=1794559810;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INcir9hz9UCGOc+ql7OBd5vO4ztF8KOz9BrHIdV1FwU=;
        b=nS4NgziUMCMatbB8xAWBXbpNAHpq69Cif0JMsYPN+ufwkCwyjrAYb7uByrtdPEisvh
         gPBB9ixMlLH+1znUnGpc74JNYKyfvoQ3cZWhzpcv8KzuOLdi8UtZYDUMvmLv6H06mEwW
         mg9rpe2j1tgmbujygQCwpmUvpSK7GHvialOr82uGPvUaA5/xU0OstqkPXAohtp5+EmXv
         AbV26/Ffiw4VdKD6WSzvWIwQFXsQV599q3LGnVRyhRcXfS3Gx+K7jNCJ+gqwJWhEaNB7
         leEZikypY7nwl5kFsrzAMExcby3Jxu+6ZuIirEqq+rIVwgVStB/r2OdPaaOBw5crHpsM
         +mEg==
X-Gm-Message-State: APuU4Z9+jYfj+UStNRfq7/XzOY5gEbiaQzVaWWtp+SfAE3DwPc787Xgh
	txOjSnXuceG1xN8AwwH0yIEyJyAyW2UGPnxxkOs7k8BVJxCn+TROZTRa
X-Gm-Gg: AYBFou0ld8+1WBfJ9rbJ2A/QE80MVJnu9pHMvVq6LeC/utvx/mxesU+BbNv9uaaC4VQ
	EODfp0wk2Gr1pWk9aA4RamstRDdoW9dcnLxe45R1I7faHv6PBkL8KH+sbEbX/WzvB2VS3/NXTc9
	bEkOQUdfgJ0DW2jV7v+QgEdUTUKWsNKMouGehey5gII/Ruefzf50VujaYLakatNLkGVWFO/aBez
	Z7MEm/+6u4sj5Ux6vNikcV2UM5k+dWt8rZJ/669mADQH/HUCBF4EIr03lk9ZntUkfShwc3DzejB
	0FwE6w/obzcOg1k4D8nr/yiaMVxUMNlqg/7QgOMFovTauENKGQngNV3p2au1k/F7gxY1ZH/Khto
	GVATZ+bSTCcrmWXAsAamXQ1q0qNxPs3vYt41eU62WQIL6nexzOUcMrTC8qbU6W8zqouHm+iMp98
	9GcJW0Vsm1pqyYWEoCmx+vsK9RZzP2xqgAn4rVSU/Zbij11FogS8QLJOoWy8j3PF9+igSwUbNSx
	DIYZ5mXUenx112p8vKFAco8g4DyJZyTCpgyoXag6qEezBw/9L0U8/hV0xMNz1XLkCOCOadm6WtX
	Otzj6CRbJBTV1BmLJIy32Cbbd490Zlcoi+XqE7AnL+JAVd/GuItZE67aa0hd4+7ovsw=
X-Received: by 2002:a05:600c:1913:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4b6de0ce791mr27409375e9.16.1793955009306;
        Fri, 06 Nov 2026 00:50:09 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:aa6d:af6d:81d:8d48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6e168f331sm49993665e9.3.2026.11.06.00.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 00:50:08 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 06 Nov 2026 09:50:01 +0100
Subject: [PATCH v2] api-parse-options: add missing flags and macros
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
Message-Id: <20261106-kn-parse-options-doc-v2-1-453ee7155348@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0K6dkxbQIMr7mFYDO0AVaGkg0RDu
 LsF487lS97/bxFMwRGLS7KIQLNj54cI+pAI0+HQEjgbWWipT0rJFO4DjBiYwI9TdBmsN1BniEU
 qqdG5FHE6Bmrca7+9Vl/mZ30jM21fm9E5nnx4791Zbd4vkf9PzAoUZDIlazEvsjOWbY/ucTS+F
 9W6rh9Zt+hCygAAAA==
X-Change-ID: 20261103-kn-parse-options-doc-b4aa930ef250
In-Reply-To: <20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com>
References: <20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com>
To: git@vger.kernel.org
Cc: herroyalpriestess@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8825; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Gnh0iGBsso1zkYASyo587qoAYbmUp1ZxN9VcPmgoawI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrtlLwWQ+CrFa79+bWUpSvvdKEN90qwvjP2o
 NMeLIjS7NVmnIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq7ZS8AAoJED7VnySO
 Rox/ltQL/1hrlWTfhJniz7NhlcJpMC+Xaccc6WRp+kbNyIvTakd1pzaetQHpW4X6mTFTf0lrhnc
 Wg1fqkxALR7lAqsO8SA2Dk5R8dD7ZjKX7gQPCNkVcneEsMfRB9iwaI99TPBPWEDQnQR9RinrT66
 2ahHTFku9cpnOPO9hU452ptIAsJpxsXnrn8GmFfi5uQQ+JY4t7NAMfFtWBAYsFlP7FgcfCG1Q/K
 wUUTmQ+2PqV6CLtf/eKhvT5YZ9qD1iLuBEGxSXHzsKfqZlTOeIIMtMHmYrD3zrQoJpjgGnz9Zzf
 2pWDW8sdauZCK9emtBbQ3rifCzhMkumu5rOa8g8dlru4X1dTFCRNgOKuJOKmuuDQc4VX0k+BhVZ
 1Y5vdXs9WMskezsQoajf4MwDLf3eFfoIAAinA0RViEm70rpCrbiEC+1SgtD9tZ/GJTUsWnYUZ9Y
 Xdiee4GQWWZmbhnDIX60cI28hCR+aeaZTRKWmz+oWoqGt6Q2msxqvVCvhS0cOT7oEQiA/sRWhh7
 0U=
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

Also add the following missing macros:
  - OPT__SUPER_PREFIX
  - OPT__VERBOSITY
  - OPT_BITOP
  - OPT_STRVEC
  - OPT_UYN
  - OPT_NOOP_ARG
  - OPT_COLUMN
  - OPT_CONTAINS
  - OPT_NO_CONTAINS
  - OPT_WITH
  - OPT_WITHOUT
  - OPT_CLEANUP
  - OPT_PATHSPEC_FROM_FILE
  - OPT_PATHSPEC_FILE_NUL
  - OPT_AUTOSTASH
  - OPT_DIFF_UNIFIED
  - OPT_DIFF_INTERHUNK_CONTEXT
  - OPT_IPVERSION
  - OPT_ALIAS

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
Changes in v2:
- Add OPT_ALIAS which was previously missing.
- Fix incorrect and missing flags in the commit message.
- Fix typo in the commit message.
- Link to v1: https://patch.msgid.link/20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com
---
 Documentation/technical/api-parse-options.adoc | 106 ++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 6dfea34220..b7ce616749 100644
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
@@ -366,6 +412,64 @@ with `flags` set to `0`.
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
+`OPT_ALIAS(short, long, alias_source)`::
+	Introduced an alias to another existing `alias_source` option.
+
 The last element of the array must be `OPT_END()`.
 
 If not stated otherwise, interpret the arguments as follows:

---
base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
change-id: 20261103-kn-parse-options-doc-b4aa930ef250


Thanks
- Karthik

