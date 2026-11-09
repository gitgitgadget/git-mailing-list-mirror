Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223907;
	b=NHmUYGhwOnQi+EpzqQcU+OLqBjy9dFjALnXAH/GhMGcxE2E3X+yJM4XrGidSQOE/bU4v
	 AlJK3a78IrAWJofMsTCDrvqZobRe7TrPPteddukKL108uKCyIB7ZXGyz77HJVhdMi0sXp
	 fPofzBvL5TU/T3Eju3OrAoghmZ7ipwEmxJ1h9AwjUOl2FOdEs6zcNq2sQswNiJfx9KBWE
	 FSuc4EFYKrEvtG80AwG8asdOz/dLZiMV1o2Uq6QmlHxNYI91qRoslbaZ74Ce+cZiAg1yX
	 RtAeQYA4RFDTBD0oiyO7znUNTSFE8ouV6nkPbjgvMB2tqx7BVmDRTGw9eiYikTwBpSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=4kVVhYmqE3m5lb19LjEfpWmpCRYfPJFDr3/UzCCJLdo=;
	b=2SIEkp6uJZnLi6U3HJ2WsHHQICu7EgSvuZuEAo5tKC8SzbTAO4ipU0oMwgmX/gTSn0Zi
	 lCZyc2c5TTxpUyWk8EV5wB2bvb6Qye5SFhCNkek/SIp+Bx8qaiTFac4UGbUrJrrD7d4L1
	 D7nBBwDLURhdFg9jgSSyt8YdnCKrfn508M5vJHgD6Mgt+v8Xgtq7N4ToAH7imXKzC57tO
	 c9srZl9Sl9szWj0yzVEi/Jg8sHdnwbjg588MafE9lJlkUB4FoudB85giVdalGpFYJ7fJg
	 6c1NXpe8Y7c2y7Tbj5KoLPczbGbjJ8EgJpc0fT4FwgJmU+PbO7xqs2orgvVKwgJRgFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hDIiijJS;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8198C606A332
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 11:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8198C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hDIiijJS
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so471285f8f.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 03:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794223906; x=1794828706; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4kVVhYmqE3m5lb19LjEfpWmpCRYfPJFDr3/UzCCJLdo=;
        b=hDIiijJSRoKVVM+MDYVGMsIStKfWjS7RmUQ9sHWNtRpgyHl2JHGjvKl7KmSqoQVOpY
         D8FDYrRdvvQpbVLmqVT+Rbk1O2DcyodFCs4oITiXrqPhRkmxB3K4Fb9Qy2g1PEmuxlu9
         B2J4KVuy0cWFSowur1+kgqiAQ1fvISqXnFnCE+S6oZn9C2l5PgsuxEV/7rlPp9YHtTaM
         C9UAOj6uJ64dknlCkG3i3way4bt9jy/C8Se7UCc6eU1kJv5+JRLLCDTQiDspOwPVTxHP
         +on/3cKxR91xoL5dMUfLEIkRcf5O/jY3MmlYYQj3YIThOUyx/JWuXZfsE5hyuc5WUMnf
         dn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794223906; x=1794828706;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kVVhYmqE3m5lb19LjEfpWmpCRYfPJFDr3/UzCCJLdo=;
        b=0FCvq2AViIS13xLX+Y/1VrOPjj/UzYEVy8hfh1vIubN6Klar3vhanv/QPJnaKM7YmP
         GawyG219ZaoA6BuPLobqLOUiwXNTu1L0BVhQUEfLLhdp7FsB7Yz01hCkw8njKfLmVjrX
         j/1u0voXUgA3NyaV4tItb1xUPyR2a799pWV+nW7Kp6gaLrs5ASkilkjjKIbH0Q1bJypN
         vuH8Sepp2Kox9EMV/XnxVmRRskCQrv6ikuKQBzXs9OIj8xtmvijJW0JsVDi5liJpcu3Q
         fElnpJDhimCekLUVSoTPfyrCZxYUWD6BP2e+Xy6Vww/R/P/xuD6LMONslBH378Twj7r5
         Hjxw==
X-Gm-Message-State: APuU4Z+PR9OGfZ8AD8d630NzX9z6FoWks2nz8KqCORSpY3Ng6w6kirSw
	00u0/sRDl+4uYlP13aUQDfz3el/xpICNwsjr+5qudgSgGHXNLZUEEfftItu1wQ==
X-Gm-Gg: AYBFou3LW21zA8+/VWzUphp404FwCPIEpF6mwEPN3RwRhXs/X/pDyKYpg2dgbllFh6H
	cSSqINAHeHaJkLjK0d4oBIZ8dWY6BescB4lPMDy/8vFlRe750kVV+6YvuEzEn/BpHBWSM0f03LG
	6DpxA9E+ys9pMcRhSekfsJU0JIDuRPblYvSqzeiKclLz6d+5Px++XAJpQr5C+AhpqM71u3BSMEd
	2meBE3FmHpAY8I/kcvFFOn7VXcaHuxoM4vIWYysdoNqFaMA+FQQfd2qaF2HxWYm4wSvRkLOwq2F
	15OuPP5gq/7pAEyX5Ks8ERkkpkXjXIYpDjRY2HlmcXagRVfBPdnVfG/Lrolb6vJj4bCWaQGHgTf
	p1HpqirHnl1oJ6+px7+pG845l/hJFyJUvdXiDK3K9ELYEhWQETGFcAcNjJAJnVz+7oAuGbWP6UX
	4DSfcf4hsFAF26UdShyYPe5pTln+/GqYMuhhZDhvMF5Llp3NFF1623x2mx0EPnEhOYNK10EXjdx
	ehasHvh9zQiXK0JwTF++jVeYSkNa2YFLaXTIYcH0Pd5vxntI2FaSPs0UeTQyG95cMn32bAL/Erz
	HG1K3KadHBHGdaBMExDjoCPBEJuHRGpIilA+N69yDbCWh9Up+hwOIGPpIfcGZV9Tgec=
X-Received: by 2002:a5d:64ee:0:b0:48d:ca32:e90f with SMTP id ffacd0b85a97d-4958502bdb8mr5199042f8f.55.1794223905488;
        Mon, 09 Nov 2026 03:31:45 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:62eb:8cc:cf4f:87d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596f9ab09sm9102689f8f.28.2026.11.09.03.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:31:45 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Nov 2026 12:30:10 +0100
Subject: [PATCH v3] api-parse-options: add missing flags and macros
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
Message-Id: <20261109-kn-parse-options-doc-v3-1-e60022942721@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNTQ6CMBgFr0K6tqY/FMSV9zAuSvsBVaGkxUZDu
 LstxoSFLl8yb2ZGHpwBj47ZjBwE440d4uC7DKlODi1go+NGjLCCUsLxbcCjdB6wHafIeqytwnU
 uZcUJNEwQFK+jg8Y8V+358tn+UV9BTcmViM74ybrX2g00cd+E+J0IFFOcEw5aS1HlpTy1vTT3v
 bI9SonAtpLij4QlieAAJRWC54etZFmWNx/y3Y4PAQAA
X-Change-ID: 20261103-kn-parse-options-doc-b4aa930ef250
In-Reply-To: <20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com>
References: <20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com>
To: git@vger.kernel.org
Cc: herroyalpriestess@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8984; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=hjqnMELUuMdZBahE2NYRQbvGyz76qdOiCGPzCKulxYo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrxryAWb0nK7vpfW3EknzegNScrHXq7hCxJE
 bxqYQCpgMIYGokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8a8gAAoJED7VnySO
 Rox//4wL/RpzQ9lArZ+k3FDY/OZoReAsJXuN0sfYd4GAJgIJJDr0wMap4lIT8O5VUS66nNIDCru
 ODFVoqKjravt+Wlgpp9wRphH7r89j1aLx07RemEkUymXy/B/Old7vh6CgkVyKtpawzTGqmanBpg
 apCVqLevLDp1UxssVNe/jnVdi4X65dF0QE6tGbUPWlhX3/stWIF7GdRtTg90ARrkAvjSiHUS3tH
 E0xMw9SSIcNzVt3C3GeOoXbfBbblfhLhhQk8O16o12u/6A87HWWG45B828hGOKfWlVrXgCfw8nZ
 BFW4GTPQvDRabq8elUEq6DNxwmE1jpTMmJBz3vQKrtqMNlfPNo974Lt3yqexNvXeOR+xJKqz2DN
 v+JrOsjdWoABN11mSD2Ikwl7AVbWIUI0/rL8LX9DMteh52EPwkOT6QD0yYK18otME6WD8ToM48e
 4arQFfPcH5rWWYqvNPBiLUO7/27NPKNR6XmoSRMI2zcI7KEUQ6v7v7EgDGsjEdocmbi3qyrZlE8
 HA=
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
Changes in v3:
- Fix typo and rename the variable
- Link to v2: https://patch.msgid.link/20261106-kn-parse-options-doc-v2-1-453ee7155348@gmail.com

Changes in v2:
- Add OPT_ALIAS which was previously missing.
- Fix incorrect and missing flags in the commit message.
- Fix typo in the commit message.
- Link to v1: https://patch.msgid.link/20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com
---
 Documentation/technical/api-parse-options.adoc | 106 ++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 6dfea34220..b20f74bc72 100644
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
+`OPT_ALIAS(short, long, source_long_name)`::
+	Introduce an alias to another existing `source_long_name` option.
+
 The last element of the array must be `OPT_END()`.
 
 If not stated otherwise, interpret the arguments as follows:

---
base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
change-id: 20261103-kn-parse-options-doc-b4aa930ef250


Thanks
- Karthik

