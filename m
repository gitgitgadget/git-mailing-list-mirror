Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36A231853
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738629; cv=none; b=GlpAsYYYJ7caeAM3Cr05ldcNjkFvycxI8ouw+Vu8ZRl9u/fXBHA+FjFig9CovFtf0TRIXYhAEAdtfYKHE9HbQGxco5e6s3Cq05WthHnu2rIQpVy2zxzLX/lonc1nInkFBjn/rnCiQZUBpqHh37QHaTYiQgLeigwKx3uLtD8R0jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738629; c=relaxed/simple;
	bh=7HrrHG3jOxUAuOsT7+YfCbxCrSeM/Cwf5DJbrp/mx9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuezFg9nGq4cwdvl/LzkFb0R6czkwc3PHSQHAjhEYmFuGHeE7kJeVqNHRqNNplC2z8uPgQubW21sooOjoFez4IEqDakEhLg45FXHIHmyfs90ml3+0iDt9WVwK/9L0dK18BP2tf623+yTfkFR12BAOj7F/GcZaMQQxuj7Puc+CPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRXojdnh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRXojdnh"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313f68bc519so541479a91.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 00:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752738627; x=1753343427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeLKsKrpVQawgdiYKl4FL6G0EnAzB7HGCc8XEBGWARE=;
        b=IRXojdnhLFGgwNsF8EpDGcAykcQkaQ5dU7uPqcVI6LxnJGjHIVHbVOn6xz96FraRMt
         +KJdfNjqITr5wdfdbLfbJeesgAvMbg9rgbaHXU2PsGZUnNw1d2hKSoRLJNbJy44MFWth
         aq3BIQCTi95vzqP6wxsbJFEgGsbdng+CtseSozuKhx4gcscaPgz8NWhbpz9djH3xjNPk
         MIvc9LugXrtWXib6MXcx+eA4+mYdyDQxHvM7VNYwMwAh8w3iFjMLoDt/tyEZTmh7xmTp
         Q1vMj7kKZoTxQ5vFH+0kpJqSt1CnGY0sCrnuBRQWb6raIzCANxGBR9XqtH8cpkQQEr+2
         FaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738627; x=1753343427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeLKsKrpVQawgdiYKl4FL6G0EnAzB7HGCc8XEBGWARE=;
        b=pPULiud9fcSwrTwzrol5gnAiRp+KK6ViqtvBe+MvAB6ExyHdTs50R+gFPLcefshByu
         ci1Z5BiTcHanH+dlYqHtHxxt079SowPxQsLleS5PWwnkp9t3Wv9dXQT6gaPBzEMa+aFY
         +N8xlrS/WgFd7HLMbplYp8XzncGhmbcX7YMRuIiw+Ue+sEbHqpnrtuKx/6oJD7genab5
         w+j3o/KTsmbkQrRqXBbNhqBeMlKzJimKkEXyChX8rA5PoB8UuMkoBC5b3PWBOPvSQ76X
         CZPfslOrvLmdsZ8fJQB5DEMhcocGhKbFWwjXoN8VSB2cX9T9mFA+Dt3pg1RSSYfJY81F
         Xohw==
X-Gm-Message-State: AOJu0Yxb3fVVuEKE3XfXHVch9pCipxnV0T4DylJHo8ykCb7FDgTkDYhz
	YMFtGdiTdRZWEFrb3e6bclfPSy6F+KQbn3NtGf+EMI2dhrmGH1bt6XGbmT9lCw==
X-Gm-Gg: ASbGncuycU9wJkcF1ldFioAXVEMdLcg91qO4lNWwMb9W8qnCVBbeJBp3NyCrdu0Kgu1
	tuzjKsbG2tlPpeJ4jSdZtg/OXrY4tfRWxNofhhzZcnNwXFRY2yw6aJGx7adoaSv5j0/9mEAQeBB
	GJG1nTN8ORSvh74Lxo6Lgu4Gq+7CHq73kdPAKcnPsvFyTIk9O9mx/3UVrJTeKlg2zQlMkFuM04Q
	VA5Bj0bUrorAI4siUCAMKeglEWRoNJiZLRisAEYzKi6R3cDrFDuozoEYGEhOJlGkO5HJe5UPDzE
	RWDxi6osuSkXG/I4SOWck2uxOTzrtL5XtzjvddmscOZ7PLjsXtVhMZtXZLeftulCLCGVszvAU9j
	05T78Bs5y+cMz7FuN0bx7rsUevPfmdw==
X-Google-Smtp-Source: AGHT+IG/hn9dbBjovLG7qkSoDDof9aveUMEulFabOaSekaDaoO3vVGD2fUku1pe2yYJ5iPZjfQKcsw==
X-Received: by 2002:a17:90b:280a:b0:313:fab4:1df6 with SMTP id 98e67ed59e1d1-31c9f4c5115mr6154636a91.32.1752738626648;
        Thu, 17 Jul 2025 00:50:26 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e6a68sm2877518a91.19.2025.07.17.00.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:50:26 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][RFC PATCH v2 0/2] Add refs list subcommand
Date: Thu, 17 Jul 2025 13:20:07 +0530
Message-Id: <20250717075009.26262-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627074934.1761897-1-meetsoni3017@gmail.com>
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

This is the second version of the patch series that introduces the `git
refs list` subcommand as a modern alternative to `git for-each-ref`.

Thank you to everyone who provided valuable feedback on the first
version. This new version incorporates the suggestions, improving both
the code's implementation and the documentation's structure.

Changes in v2:
  - Refactored the implementation of `refs list`. Instead of duplicating
    the logic from `for-each-ref`, it is now a thin wrapper that
    calls the original command. This avoids code duplication while
    maintaining identical behavior.

  - Refactored the documentation by moving the common command options
    shared by `refs list` and `for-each-ref` into a new standalone
    file (`ref-list-options.adoc`).

  - Both man pages now use the AsciiDoc `include::` macro to embed these
    shared options, ensuring documentation stays consistent.

---

(v1 cover-letter text)

This patch series introduces `git refs list` as a modern replacement for
`git for-each-ref`, as part of an effort to consolidate ref-related
functionality under a unified `git refs` command.

Git's ref-related operations are currently handled by several distinct
commands, such as `git show-ref`, `git for-each-ref`, `git update-ref`,
`git pack-refs`, etc. This distribution has a few practical drawbacks:

- Users need to rely on multiple commands for related tasks involving
  refs.

- The commands may differ slightly in behavior and option syntax,
  leading to inconsistency.

We propose a long-term consolidation effort to bring ref-related
subcommands under the umbrella of a single command: `git refs`.

The implementation of `git refs list` is functionally identical to `git
for-each-ref`. It reuses the same internal logic (cmd_for_each_ref) to
ensure complete backward compatibility. The purpose of this patch is not
to introduce new behavior but to provide an alternate entry point under
the consolidated `git refs` namespace.

The motivation behind this change is twofold:

- Consolidation: Centralizing ref-related operations makes them easier
  to discover, use, and maintain.

- Evolution: While the initial goal is parity with existing commands,
  this consolidation allows for careful reconsideration of which
  features are essential. Over time, we can:

  - Remove legacy or obscure options that are no longer needed.
  - Add improvements that wouldn't make sense to bolt onto legacy
    commands.
  - Offering a more consistent and user-friendly surface.

To verify backward compatibility, this patch also includes a test
`t/t1461-refs-list.sh`, which runs the full `t6300-for-each-ref.sh` test
using `git refs list`. The test uses ${GIT_REFS_LIST_CMD:-for-each-ref}
to allow substitution without duplicating tests.

This patch is deliberately conservative: it introduces no behavioral
changes and leaves `for-each-ref` untouched. The goal is to lay
groundwork and demonstrate viability of ref consolidation within `git
refs`.

Going forward, I'd like to initiate a discussion on what the ideal
surface of `git refs list` should look like. Which options and features
from `for-each-ref` should be carried over? Are there any that are
obsolete or overly niche? What improvements might be worth considering
now that we have a new, consolidated interface?

Feedback on this, especially from those who rely on `for-each-ref` in
scripts or tooling would be very helpful.

Meet Soni (2):
  builtin/refs: add list subcommand
  t: add test for git refs list subcommand

 Documentation/git-for-each-ref.adoc  |  80 +------
 Documentation/git-refs.adoc          |  16 ++
 Documentation/refs-list-options.adoc |  80 +++++++
 builtin/for-each-ref.c               |  24 +-
 builtin/refs.c                       |  35 +++
 t/meson.build                        |   1 +
 t/t1461-refs-list.sh                 |   8 +
 t/t6300-for-each-ref.sh              | 333 ++++++++++++++-------------
 8 files changed, 331 insertions(+), 246 deletions(-)
 create mode 100644 Documentation/refs-list-options.adoc
 create mode 100755 t/t1461-refs-list.sh

Range-diff against v1:
1:  e7b19c71eb ! 1:  b2d3026520 builtin/refs: add list subcommand
    @@ Commit message
         instead of duplicating its logic. Forward all arguments to the existing
         function to ensure behavior is identical.
     
    -    This prevents code duplication and allows `refs list` to benefit from
    -    any future fixes to the underlying `for-each-ref` machinery.
    +    Add documentation for the new command. To keep the documentation DRY and
    +    consistent with `git-for-each-ref(1)`, refactor the shared command
    +    options into a standalone file. Use the AsciiDoc `include::` macro to
    +    embed these options in both man pages.
    +
    +    This prevents duplication in both code and documentation, ensuring that
    +    `refs list` benefits from any future fixes to the underlying
    +    `for-each-ref` machinery and its shared documentation.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: shejialuo <shejialuo@gmail.com>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     
    + ## Documentation/git-for-each-ref.adoc ##
    +@@ Documentation/git-for-each-ref.adoc: host language allowing their direct evaluation in that language.
    + 
    + OPTIONS
    + -------
    +-<pattern>...::
    +-	If one or more patterns are given, only refs are shown that
    +-	match against at least one pattern, either using fnmatch(3) or
    +-	literally, in the latter case matching completely or from the
    +-	beginning up to a slash.
    +-
    +---stdin::
    +-	If `--stdin` is supplied, then the list of patterns is read from
    +-	standard input instead of from the argument list.
    +-
    +---count=<count>::
    +-	By default the command shows all refs that match
    +-	`<pattern>`.  This option makes it stop after showing
    +-	that many refs.
    +-
    +---sort=<key>::
    +-	A field name to sort on.  Prefix `-` to sort in
    +-	descending order of the value.  When unspecified,
    +-	`refname` is used.  You may use the --sort=<key> option
    +-	multiple times, in which case the last key becomes the primary
    +-	key.
    +-
    +---format=<format>::
    +-	A string that interpolates `%(fieldname)` from a ref being shown and
    +-	the object it points at. In addition, the string literal `%%`
    +-	renders as `%` and `%xx` - where `xx` are hex digits - renders as
    +-	the character with hex code `xx`. For example, `%00` interpolates to
    +-	`\0` (NUL), `%09` to `\t` (TAB), and `%0a` to `\n` (LF).
    +-+
    +-When unspecified, `<format>` defaults to `%(objectname) SPC %(objecttype)
    +-TAB %(refname)`.
    +-
    +---color[=<when>]::
    +-	Respect any colors specified in the `--format` option. The
    +-	`<when>` field must be one of `always`, `never`, or `auto` (if
    +-	`<when>` is absent, behave as if `always` was given).
    +-
    +---shell::
    +---perl::
    +---python::
    +---tcl::
    +-	If given, strings that substitute `%(fieldname)`
    +-	placeholders are quoted as string literals suitable for
    +-	the specified host language.  This is meant to produce
    +-	a scriptlet that can directly be `eval`ed.
    +-
    +---points-at=<object>::
    +-	Only list refs which points at the given object.
    +-
    +---merged[=<object>]::
    +-	Only list refs whose tips are reachable from the
    +-	specified commit (HEAD if not specified).
    +-
    +---no-merged[=<object>]::
    +-	Only list refs whose tips are not reachable from the
    +-	specified commit (HEAD if not specified).
    +-
    +---contains[=<object>]::
    +-	Only list refs which contain the specified commit (HEAD if not
    +-	specified).
    +-
    +---no-contains[=<object>]::
    +-	Only list refs which don't contain the specified commit (HEAD
    +-	if not specified).
    +-
    +---ignore-case::
    +-	Sorting and filtering refs are case insensitive.
    +-
    +---omit-empty::
    +-	Do not print a newline after formatted refs where the format expands
    +-	to the empty string.
    +-
    +---exclude=<pattern>::
    +-	If one or more patterns are given, only refs which do not match
    +-	any excluded pattern(s) are shown. Matching is done using the
    +-	same rules as `<pattern>` above.
    +-
    +---include-root-refs::
    +-	List root refs (HEAD and pseudorefs) apart from regular refs.
    ++include::refs-list-options.adoc[]
    + 
    + FIELD NAMES
    + -----------
    +
      ## Documentation/git-refs.adoc ##
     @@ Documentation/git-refs.adoc: SYNOPSIS
      [synopsis]
    @@ Documentation/git-refs.adoc: migrate::
      	Verify reference database consistency.
      
     +list::
    -+	List references in the repository with support for filtering, formatting,
    -+	and sorting. This subcommand uses the same core logic as
    -+	linkgit:git-for-each-ref[1] and offers equivalent functionality.
    ++	List references in the repository with support for filtering,
    ++	formatting, and sorting. This subcommand is an alias for
    ++	linkgit:git-for-each-ref[1] and offers identical functionality.
     +
      OPTIONS
      -------
    @@ Documentation/git-refs.adoc: The following options are specific to 'git refs ver
      
     +The following options are specific to 'git refs list':
     +
    ++include::refs-list-options.adoc[]
    ++
    + KNOWN LIMITATIONS
    + -----------------
    + 
    +
    + ## Documentation/refs-list-options.adoc (new) ##
    +@@
    ++// Shared options for for-each-ref and refs list
     +<pattern>...::
     +	If one or more patterns are given, only refs are shown that
     +	match against at least one pattern, either using fnmatch(3) or
    @@ Documentation/git-refs.adoc: The following options are specific to 'git refs ver
     +
     +--include-root-refs::
     +	List root refs (HEAD and pseudorefs) apart from regular refs.
    -+
    -+
    - KNOWN LIMITATIONS
    - -----------------
    - 
     
      ## builtin/for-each-ref.c ##
     @@ builtin/for-each-ref.c: static char const * const for_each_ref_usage[] = {
2:  8ce521880c = 2:  2d6534841f t: add test for git refs list subcommand
-- 
2.34.1

