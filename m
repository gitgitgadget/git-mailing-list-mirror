Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBB535950
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751203246; cv=none; b=ncZIN+JThKVTlN24krL57rJILy7PyeDzcHp89gZnu7BHqjPDanWPTf5xm0SG5MTrEojSyFe8x9oVocHC9BaLjVvFitnhyiPKK+FqvscvGt5/JyFwIFwpqjYdL+9zHXqcl7DYUQJjuVq33XR/z5LTC0IBqJjEMlHyDpJDzABoUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751203246; c=relaxed/simple;
	bh=pV2M4T//iIJe0IDx1ZBfq9hGyYeKa0f0pWqMfcX4+Fc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=NICjIX89xRN7sakUijaxk3gcdpICPD5oslEYukuOBpXNJhiULYlzyclLdyAkgAmS2zGxjBRmDC9UkWWnLK+/2dwIP5Vg/1UFz96/SHRaO+6qB3nYc4WKjnQHqHw1kEnKc5XZD1YfMDOhxxZlDrNHFvTHhbOD5OLtl9uXZDHifGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNYiN4bY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNYiN4bY"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso3790959f8f.3
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751203243; x=1751808043; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/Sp4yr6j/vdnWEGwAkBc5sQf12LA8cUI4Th+HT/LuQ=;
        b=JNYiN4bYfAUOAbzm48sMyMRYiJ+3yNAZgM3rKeKc9zjTmTN5ZUOZ6SNwMEUFjp4oJO
         +8J1cwlj/1RLCs+uxDVQM/J+MCvy+VAiKD4KmnNcBjgW6RHDV5ZAnr+supPWkVijkIR1
         qOhRi1EehEXgdensCMxP6qVJBfNZkAsu6FRGc9ayvHuuZZCWsHUuZgqGPHZkZnlJBX4y
         DdLSx1hcYLkI7ATaVng4favT5mXSW/qvOIkH3uDNosmqc8lIEku/b1vxZc9WHNPt59D+
         vgoaBO3MOIxQTEEw1qloFWo7XUy1pCEH5/sEHwHpXTNdIGHnxzOzdE6sL3q+sdQ3SRr0
         vTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751203243; x=1751808043;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/Sp4yr6j/vdnWEGwAkBc5sQf12LA8cUI4Th+HT/LuQ=;
        b=Okn8vwbi7s8nmQLtphRJziXvoMmc3RqEaSNlDV+qvDvGp6eUIkHlL8VNeHj2EVBcPP
         v4kix59IkKgBy7z0nyKc4mDJnOwAQA2roFas+YJzYzBP2PE5sGrv/0D8uX99+X0wLiq/
         i3Pf560ObiftMWyxrUIwBdZAuItZAs+5biZv3wb1tWIq/iauYMoAzCqRh2HyMzhLn650
         CdJ8U8DmVwHtT7iERdCiW3JZMAaRDgukDLM7N71Zh42o9XhDEFMsRpZzWHOVDIGc6ES3
         GO+S1HNLx3a9jDJfAiXOgN79DmO034cyvk+miVS35UAzHQgI79eFn9lYti0RZnI+qzQN
         azYg==
X-Gm-Message-State: AOJu0YybxfEY+tAUxXKccM68rJB/p6A6QBAX8qqL6IlBLL1jiPITB7sx
	nRpnMaK8oBHusbW+T8B7ER7EKz9hotRNK8TAQEq1k/+TWtJ6ILxfU6RfBETAkQ==
X-Gm-Gg: ASbGncs3GxhmzPCSu7jlDor58zLhBrMMg8/kpQZanfzFXoxv+tJbOqNXHsBqnzti/Zm
	fe885FtR9WX+4Z1adkd9n6OttsGYBA0nPt2ZVO5Qh0kejBbc2AfI9J4klPDKeo2VEbkRYTDzo6X
	5e/YqKqLdaB3D8hDFK2NgsWj2vPigNW39UfAn38bSkvHcyvxmUgfQHisSyGyBG9wIcEVZP+j9KT
	bi9kk/K2oaCSgziK/mLK2IrK64Wr8GA4Bo3veqwQXe61nDLkizOmQADdYEPqcoHchb1rwCcqQZ+
	cM4N5M++rNqd5niFNlrcUa1+ozvCRhkqn2tvmvc1zGAjz2HJyT8rOz7OTtMq9ao=
X-Google-Smtp-Source: AGHT+IGaa4Va5n2XoUgI7uOU1cs5rm5wiIrc2JiEqcVlAzFi4g/bozQ2woOcvXCY92oIhmgkFjItnQ==
X-Received: by 2002:a05:6000:4b1a:b0:3a4:f6d6:2d68 with SMTP id ffacd0b85a97d-3a9186574femr9173208f8f.56.1751203243026;
        Sun, 29 Jun 2025 06:20:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa750sm7631626f8f.25.2025.06.29.06.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 06:20:42 -0700 (PDT)
Message-Id: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Jun 2025 13:20:32 +0000
Subject: [PATCH v2 0/9] doc: convert git log man page to new synopsis format
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This series converts the man page of git log to the synopsis format style.
Git log is the second largest manpage after git config, which makes the
changes quite large.

A special note about the log format description which required escaping the
synopsis processing of parentheses.

Changes since V1:

 * rework the grammar style when refering to plural placeholders . The text
   is more descriptive and does not rely on puns. Puns may be difficult to
   understand and to translate.
 * change commit message to reflect the conversion of inline description of
   several option to a list.

Jean-Noël Avila (9):
  doc: convert git-log to new documentation format
  doc: git-log convert rev-list-description  to new doc format
  doc: git-log: convert line range options to new doc format
  doc: git-log: convert line range format to new doc format
  doc: git-log: convert rev list options to new doc format
  doc: git-log: convert pretty options to new doc format
  doc: git-log: convert pretty formats to new doc format
  doc: git-log: convert diff options to new doc format
  doc: git-log: convert log config to new doc format

 Documentation/asciidoc.conf.in             |   2 +-
 Documentation/asciidoctor-extensions.rb.in |   4 +-
 Documentation/config/log.adoc              |  47 +--
 Documentation/diff-options.adoc            |  40 ++-
 Documentation/git-log.adoc                 |  86 ++---
 Documentation/line-range-format.adoc       |  26 +-
 Documentation/line-range-options.adoc      |  10 +-
 Documentation/pretty-formats.adoc          | 283 +++++++--------
 Documentation/pretty-options.adoc          |  71 ++--
 Documentation/rev-list-description.adoc    |   6 +-
 Documentation/rev-list-options.adoc        | 390 ++++++++++-----------
 11 files changed, 493 insertions(+), 472 deletions(-)


base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1933%2Fjnavila%2Fdoc_git_log-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1933/jnavila/doc_git_log-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1933

Range-diff vs v1:

  1:  1ce06a18481 !  1:  f2b69588195 doc: convert git-log to new documentation format
     @@ Commit message
          descriptions. The new rendering engine will apply synopsis rules to
          these spans.
      
     +    We also transform inline descriptions of possible values of option
     +    --decorate into a list, which is more readable and extensible.
     +
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/git-log.adoc ##
     @@ Documentation/git-log.adoc: each commit introduces are shown.
       	For each candidate reference, do not use it for decoration if it
      -	matches any patterns given to `--decorate-refs-exclude` or if it
      -	doesn't match any of the patterns given to `--decorate-refs`. The
     -+	matches any of _<pattern>_ given to `--decorate-refs-exclude` or if it
     -+	doesn't match any of _<pattern>_ given to `--decorate-refs`. The
     - 	`log.excludeDecoration` config option allows excluding refs from
     +-	`log.excludeDecoration` config option allows excluding refs from
     ++	matches any of the _<pattern>_ parameters given to
     ++	`--decorate-refs-exclude` or if it doesn't match any of the
     ++	_<pattern>_ parameters given to `--decorate-refs`.
     ++	The `log.excludeDecoration` config option allows excluding refs from
       	the decorations, but an explicit `--decorate-refs` pattern will
       	override a match in `log.excludeDecoration`.
     + +
      @@ Documentation/git-log.adoc: If none of these options or config settings are given, then references are
       used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
       `refs/stash/`, or `refs/tags/`.
  2:  ff22d0f1adf =  2:  1f6c951726b doc: git-log convert rev-list-description  to new doc format
  3:  3992c1786ef =  3:  7bab515e136 doc: git-log: convert line range options to new doc format
  4:  d451d7f6c0a =  4:  384a7d23563 doc: git-log: convert line range format to new doc format
  5:  71d9a374102 =  5:  c2e857105d4 doc: git-log: convert rev list options to new doc format
  6:  5004a622c3f !  6:  01835272c2e doc: git-log: convert pretty options to new doc format
     @@ Documentation/pretty-options.adoc: people using 80-column terminals.
      +`--notes[=<ref>]`::
       	Show the notes (see linkgit:git-notes[1]) that annotate the
       	commit, when showing the commit log message.  This is the default
     - 	for `git log`, `git show` and `git whatchanged` commands when
     + ifndef::with-breaking-changes[]
      @@ Documentation/pretty-options.adoc: to display.  The ref can specify the full refname when it begins
       with `refs/notes/`; when it begins with `notes/`, `refs/` and otherwise
       `refs/notes/` is prefixed to form the full name of the ref.
  7:  d54e297567a =  7:  d5490f7d868 doc: git-log: convert pretty formats to new doc format
  8:  9f9ce432bd6 =  8:  c2346eb580c doc: git-log: convert diff options to new doc format
  9:  fa91d919fa0 !  9:  b12b8294b86 doc: git-log: convert log config to new doc format
     @@ Commit message
       ## Documentation/config/log.adoc ##
      @@
      -log.abbrevCommit::
     +-	If true, makes
      +`log.abbrevCommit`::
     - 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
     - 	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
     ++	If `true`, make
     + ifndef::with-breaking-changes[]
     + 	linkgit:git-log[1], linkgit:git-show[1], and
     + 	linkgit:git-whatchanged[1]
     +@@ Documentation/config/log.adoc: endif::with-breaking-changes[]
     + 	assume `--abbrev-commit`. You may
       	override this option with `--no-abbrev-commit`.
       
      -log.date::

-- 
gitgitgadget
