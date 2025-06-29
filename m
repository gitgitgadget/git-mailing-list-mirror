Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC992248B4
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751203252; cv=none; b=Fnujiv2zra9rUQIZPbXpA/pl8r+e+ZZQettHzINUTCibvQmiDtseJKshZXdFNYtddsuw+sR8tsIdgIs9TA1ctx8XJAu9osvPDgDlFEmUY3CwUNe9ZpqXS2oTYfXmCBxq5FIx4ceT+5O94IWvd58fu1j2iOZ2WCurOs6FFHHw22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751203252; c=relaxed/simple;
	bh=5Vivm7zlvtDyeEldchp1Yb2uq1kJ+o54+a0okplrDfY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=f0+waSaCl5SDW+KzJXjqYZLGiVs4FFHLH0GwT+Gm12bV2+Sq5LU8zH8r/Bmd29Q82gMhuVgFirPZayK1t+ZOPptR64OEbsleqytKCLDTPkE1zhs1cGN+xDiJL7mAi2LzW0F3jtrPKnr/ehQdXJdGy8g2PIAz+KDZghuF/yz5j0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPtcvfcS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPtcvfcS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so13754355e9.1
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751203249; x=1751808049; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iV5Ln2yJ7CyoeSYvnZu8fmciQFIDTNMYuhkQNWMiwh0=;
        b=GPtcvfcSDwOzOeRHb2YfP9e26kRytbT/Ue4y0RP7SUQAGDk93hib04Z5r0Ro2EtA3G
         7cQ/CD2F8Rm1XUz+CvM8nI0xsIk576W1Nv/QHr+hP9UBkpM6agBtNOrdTC3gv7VBf2ns
         8j4vW7a9A8KTGER4B6E/9q2Pe+jiPlpXZjqlRH77MmP8UKM5fWAQmojm8Az1Q4HAR5Y/
         WFfROfsVep952N+60eQWGgrAqGaHb6f03xnL58y/B0FnJMT12yBTMGM2BwXQaN5x9FoC
         qKW5S0UlKris9o6lm56+6Ax/JPzhNzqeBmNdX7owEy3nj4fEBIcmCvBw/m6bPAFGAHU7
         +YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751203249; x=1751808049;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iV5Ln2yJ7CyoeSYvnZu8fmciQFIDTNMYuhkQNWMiwh0=;
        b=j+Ll4I0p4Vj1397fDqxPhb6XS8VMfIrywM3tPz8ao2vAvvw46F+Qv102PeecpGw2aG
         HiXQnGeTGaJRtY1ZG6dpmZuXPolaOg1mNfvXe52+IZa4Je82B8YoU+4e9dTT4iPPxoE7
         PKxrT70xZ65j+f6BmEDiLPOoXRMM0cVqsPuwCSHDgnzZR2BsMbvDCy10W5YpJ7fhGwLq
         9NGxDiV4J8b74J0cdhVHkZzVAStHbNKdXI6BWfBj/5+5Gcf+XeKzWwc1Rp8CticUffcD
         gUSnA9DoB9BsJqUVhBUyaSEmWUTtTycS2Orno6+rrrttC6bWST9jj0axoBJcvq3hBwDh
         2RgQ==
X-Gm-Message-State: AOJu0Yxo2ns03Vzx0f3TmP0Avr5w1l0R5cwDuuOEppCFMWINnjY9KRXs
	C+UpPzEJoGYmMgNE5Zjk9e+cxY5B1NKJAnbBdUfFPKncMuXTJMEtnT251UUA+w==
X-Gm-Gg: ASbGncspauA/macenMO0WTnzILaC3gSbO/Ldk4w0mR5ENTQ3jg/MuFsL2g8Tn/7dXBe
	r6i/uU/pHpJGvQVaO8e7wGr4ijccuA7CE7NLg0WKqQ2x2YdS/fR8uE5hZ2FYyBija+jzTgmT32U
	Pjq2HaIrf7nU8+FUd4sLNhCGUcA3SMZn7G7BDdariDmuBSwfYaqIBn0Q5dEP6P3pTcCYvLRA06D
	4qMATfenUUp4ue2oob4SZHkTIPrPh34uHTipgwXacb77pszBPwH+8W7JdjKApBktOxprKk9aYcs
	+O+ySoXbYmrsjuBvrN8CFK2zQdwwsGE2DdPWwGYDhe5UF5+jscLUNXQMVRDvHDY=
X-Google-Smtp-Source: AGHT+IFWCxPBI9KcHh2ddwZqFRbSTdEpmYluOK6SBYVmCrBcuZlHY4XWA3Tf3yZntcY9gS43PpnWZA==
X-Received: by 2002:a05:600c:3f14:b0:453:7713:539f with SMTP id 5b1f17b1804b1-453a0694830mr2552735e9.26.1751203248461;
        Sun, 29 Jun 2025 06:20:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a72dasm104745615e9.16.2025.06.29.06.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 06:20:48 -0700 (PDT)
Message-Id: <01835272c2e92269ba0e571b29d0756f63fe9c79.1751203241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
	<pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Jun 2025 13:20:38 +0000
Subject: [PATCH v2 6/9] doc: git-log: convert pretty options to new doc format
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

- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/pretty-options.adoc | 71 ++++++++++++++++---------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/Documentation/pretty-options.adoc b/Documentation/pretty-options.adoc
index b36e96abe28a..963f4f0204f0 100644
--- a/Documentation/pretty-options.adoc
+++ b/Documentation/pretty-options.adoc
@@ -1,38 +1,38 @@
---pretty[=<format>]::
---format=<format>::
+`--pretty[=<format>]`::
+`--format=<format>`::
 
 	Pretty-print the contents of the commit logs in a given format,
-	where '<format>' can be one of 'oneline', 'short', 'medium',
-	'full', 'fuller', 'reference', 'email', 'raw', 'format:<string>'
-	and 'tformat:<string>'.  When '<format>' is none of the above,
-	and has '%placeholder' in it, it acts as if
-	'--pretty=tformat:<format>' were given.
+	where '<format>' can be one of `oneline`, `short`, `medium`,
+	`full`, `fuller`, `reference`, `email`, `raw`, `format:<string>`
+	and `tformat:<string>`.  When _<format>_ is none of the above,
+	and has `%<placeholder>` in it, it acts as if
+	`--pretty=tformat:<format>` were given.
 +
 See the "PRETTY FORMATS" section for some additional details for each
-format.  When '=<format>' part is omitted, it defaults to 'medium'.
+format.  When `=<format>` part is omitted, it defaults to `medium.
 +
-Note: you can specify the default pretty format in the repository
+NOTE: you can specify the default pretty format in the repository
 configuration (see linkgit:git-config[1]).
 
---abbrev-commit::
+`--abbrev-commit`::
 	Instead of showing the full 40-byte hexadecimal commit object
 	name, show a prefix that names the object uniquely.
-	"--abbrev=<n>" (which also modifies diff output, if it is displayed)
+	`--abbrev=<n>` (which also modifies diff output, if it is displayed)
 	option can be used to specify the minimum length of the prefix.
 +
-This should make "--pretty=oneline" a whole lot more readable for
+This should make `--pretty=oneline` a whole lot more readable for
 people using 80-column terminals.
 
---no-abbrev-commit::
+`--no-abbrev-commit`::
 	Show the full 40-byte hexadecimal commit object name. This negates
 	`--abbrev-commit`, either explicit or implied by other options such
-	as "--oneline". It also overrides the `log.abbrevCommit` variable.
+	as `--oneline`. It also overrides the `log.abbrevCommit` variable.
 
---oneline::
-	This is a shorthand for "--pretty=oneline --abbrev-commit"
+`--oneline`::
+	This is a shorthand for `--pretty=oneline --abbrev-commit`
 	used together.
 
---encoding=<encoding>::
+`--encoding=<encoding>`::
 	Commit objects record the character encoding used for the log message
 	in their encoding header; this option can be used to tell the
 	command to re-code the commit log message in the encoding
@@ -44,22 +44,22 @@ people using 80-column terminals.
 	to convert the commit, we will quietly output the original
 	object verbatim.
 
---expand-tabs=<n>::
---expand-tabs::
---no-expand-tabs::
+`--expand-tabs=<n>`::
+`--expand-tabs`::
+`--no-expand-tabs`::
 	Perform a tab expansion (replace each tab with enough spaces
-	to fill to the next display column that is a multiple of '<n>')
+	to fill to the next display column that is a multiple of _<n>_)
 	in the log message before showing it in the output.
 	`--expand-tabs` is a short-hand for `--expand-tabs=8`, and
 	`--no-expand-tabs` is a short-hand for `--expand-tabs=0`,
 	which disables tab expansion.
 +
 By default, tabs are expanded in pretty formats that indent the log
-message by 4 spaces (i.e.  'medium', which is the default, 'full',
-and 'fuller').
+message by 4 spaces (i.e.  `medium`, which is the default, `full`,
+and `fuller`).
 
 ifndef::git-rev-list[]
---notes[=<ref>]::
+`--notes[=<ref>]`::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
 	commit, when showing the commit log message.  This is the default
 ifndef::with-breaking-changes[]
@@ -80,28 +80,29 @@ to display.  The ref can specify the full refname when it begins
 with `refs/notes/`; when it begins with `notes/`, `refs/` and otherwise
 `refs/notes/` is prefixed to form the full name of the ref.
 +
-Multiple --notes options can be combined to control which notes are
-being displayed. Examples: "--notes=foo" will show only notes from
-"refs/notes/foo"; "--notes=foo --notes" will show both notes from
+Multiple `--notes` options can be combined to control which notes are
+being displayed. Examples: "`--notes=foo`" will show only notes from
+`refs/notes/foo`; "`--notes=foo --notes`" will show both notes from
 "refs/notes/foo" and from the default notes ref(s).
 
---no-notes::
+`--no-notes`::
 	Do not show notes. This negates the above `--notes` option, by
 	resetting the list of notes refs from which notes are shown.
 	Options are parsed in the order given on the command line, so e.g.
-	"--notes --notes=foo --no-notes --notes=bar" will only show notes
-	from "refs/notes/bar".
+	"`--notes --notes=foo --no-notes --notes=bar`" will only show notes
+	from `refs/notes/bar`.
 
---show-notes-by-default::
+`--show-notes-by-default`::
 	Show the default notes unless options for displaying specific
 	notes are given.
 
---show-notes[=<ref>]::
---[no-]standard-notes::
-	These options are deprecated. Use the above --notes/--no-notes
+`--show-notes[=<ref>]`::
+`--standard-notes`::
+`--no-standard-notes`::
+	These options are deprecated. Use the above `--notes`/`--no-notes`
 	options instead.
 endif::git-rev-list[]
 
---show-signature::
+`--show-signature`::
 	Check the validity of a signed commit object by passing the signature
 	to `gpg --verify` and show the output.
-- 
gitgitgadget

