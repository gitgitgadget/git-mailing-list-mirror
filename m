Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698953B635B
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888651; cv=none; b=uG4MHjON38rIKDhYvWXL1eOCnSlLlb3++EH+n7ANjcEk5k9PSPrPUnd6Ddfu+o+Yxp0jAAdvSZWk3BPt9USxIt+47zppbu670lsb52t+3eBM+3NHwS5vyPxC1L6q/LP+TJ8BKZZkvVtBh0GhkUklRUCHRLltEKlO5kSg8BcFvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888651; c=relaxed/simple;
	bh=tnBMPC3YhbMMfLN4o30wJvGTxHIl0cR3wNj7exDn9NU=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type; b=SyMRm8OfjkHXO1iAvqKmPIMDQDTHiUoVfOzVfX6E2Blq05ks7oqA30OM3Mg1bfMdoeeQDWRx4iyknQ5ZYmteIUAxvE5Pu+7nspAcU5F5rkSMpozWiawltyE5Y5nHXuzjOOc4BR3kFNw/DyFuM0bOPkd5BRXb3kVvDWGeVblh5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DR3gfdab; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR3gfdab"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c6c57c5c07so16098085ad.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781888650; x=1782493450; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mRvSJW18PKhKb/jziTduwIS8QWZkOBJDiTVSAJ5TJgA=;
        b=DR3gfdabiNHXIqp8YYJVrsN9A9pM14xiCC5v6OwyjrfpDAJoX3RM8/pYhlhp76JEVM
         YYmYmGFNm2Nam64ilfEJDtG/GJTFr4fAd+HG63wh3G5jfGqmM9+zPEEeit3x7bhTfdh5
         1EodrpCBUMpXF9F8O7itsyNqvgFizVksyD4WbgtaGqBboK1pcD5GcrPiiygaSeLh3iNQ
         2Io9YLsPUIbRwX5EtjZYFx2RGgOFqezJYWg2ayCXNBPN0DtL0WEd6oiBr995wf3irwXH
         8O42D1nSjJjH986xSFjMl2oEag/ozqk7Yieiy9MJM7ZYgYJOT/0SWaHPpihcDB/XRiMC
         rctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781888650; x=1782493450;
        h=references:in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRvSJW18PKhKb/jziTduwIS8QWZkOBJDiTVSAJ5TJgA=;
        b=QAYtl2skHERXdHCApjh+cdxbW7KXA9DgK8ZVTr1xTdrUlU3YfSKYo5gi1E943IvENE
         T98OI6Lb9luPSeUjBcVpv9X2/t4tY+nsBmwjFlIPuo5lwQPERR7d63MGinC0KiOazj2j
         6xbaca7m61e6UviF9xqSZb7LccXpYNYcZj1V/Nk2FzZwx/BwgTKD8Kwh6Ll7ij6hqmQz
         I7wCS4jgm4NS4wjG5Hwd/ufDudSyEQr7pZJkUegyLc7woCk81auHzEhTyXqUZ90lS1ed
         Az7yTxcZqdxlL7JZNIQ14f3DNBUcIY2aD8kTMd9/9cIkCoTKFLE1bG9TuFSpuftr5maP
         iSRA==
X-Gm-Message-State: AOJu0Yx7ODqSs7BFwzcjduKn6QsXoklzaBvqNK9oPm4VpfLdnsrzATX0
	6bO656Woo0KKMXOC908nKSV5N6aDmXZ+dHhBBzg4D4IcgxnRU8xVYQ0r7jiCIl5U
X-Gm-Gg: AfdE7cnRsM8kS6ZfSkOI2Guw5125SWdiHnnpTb1OnmmAqq4ksDja1D6i1pJ6A0J/+oY
	fqAOiDg9795xIQ0z/2Xxko64489eCaCLOyiCG5le9xTLKEcDmfwtt3O09rXHvR0nhVhDONeS/2+
	YhRI3YIVlZpRU3OfDoccofb9WKSu7NxILjz+a8e0eyyDqJKStJDKV6iLohb4akdjtmBrYS7gee1
	QVyVvB2tWUYFKEsg/X9UKCfS/KvPwdV9HMOvNf35IT+pLD7WR/7RABe9qQKSV7jB5pAMo2HPVGH
	IG8OOJnHsV5WMncjY1cz5TDU3v+stZxD56sDSIM/n/ig4ozRq1NRukgWpHB73L8ssiBy37QPM8X
	/AHei6eGk2G+OJiFA4QkQJ0IbN0QdceJ63RYImB5nlB1uLRK0jlfLjCxB14tTp/KUnobMU9YEVJ
	drRO5QXXkADw==
X-Received: by 2002:a17:903:178e:b0:2c6:a185:be8b with SMTP id d9443c01a7336-2c718ccaad3mr55766185ad.10.1781888649520;
        Fri, 19 Jun 2026 10:04:09 -0700 (PDT)
Received: from 11 ([111.92.66.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7209fdd27sm29465555ad.66.2026.06.19.10.04.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 10:04:09 -0700 (PDT)
Message-ID: <6a357689.0f9b68c4.317a5d.1919@mx.google.com>
Date: Fri, 19 Jun 2026 10:04:09 -0700 (PDT)
From: Jishnu C K <jishnuck26@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2] help: include arguments in autocorrect=prompt message
In-Reply-To: <ajQuqTB580gqNP8D@denethor>
References: <20260618142033.15216-1-jishnuck26@gmail.com> <ajQuqTB580gqNP8D@denethor>
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

v2: Reworked as an incremental improvement to the existing
autocorrect=prompt code path rather than a parallel reimplementation,
per feedback from Junio and Justin.

---
From a4e8fb6fd6dd6a501e565c7500cbf927d7cb0b42 Mon Sep 17 00:00:00 2001
From: calicomills <jishnuck26@gmail.com>
Date: Fri, 19 Jun 2026 13:01:40 +0530
Subject: [PATCH v2 v2] help: include arguments in autocorrect=prompt message

When 'help.autocorrect=prompt' is configured and the user mistypes
a git command, the prompt currently shows only the corrected command
name:

  Run 'checkout' instead [y/N]?

This leaves the user unsure whether their original arguments will be
preserved. Update the prompt to include the full corrected invocation:

  Run 'git checkout neo' instead [y/N]?

The help_unknown_cmd() signature is updated to accept the args vector
so the prompt can show the original arguments alongside the corrected
command name. Callers that do not have access to the args (e.g.
builtin/help.c) pass NULL, which is handled gracefully.

Signed-off-by: calicomills <jishnuck26@gmail.com>
---
 help.c                      | 49 +++++++++++++----------------------
 t/t9003-help-autocorrect.sh | 51 +++++--------------------------------
 2 files changed, 23 insertions(+), 77 deletions(-)

diff --git a/help.c b/help.c
index 30f32a7206..9ea4c076e1 100644
--- a/help.c
+++ b/help.c
@@ -739,7 +739,16 @@ char *help_unknown_cmd(const char *cmd, const struct strvec *args)
 		else if (cfg.autocorrect == AUTOCORRECT_PROMPT) {
 			char *answer;
 			struct strbuf msg = STRBUF_INIT;
-			strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);
+			struct strbuf full_cmd = STRBUF_INIT;
+			strbuf_addstr(&full_cmd, assumed);
+			if (args) {
+				for (size_t j = 1; j < args->nr; j++) {
+					strbuf_addch(&full_cmd, ' ');
+					strbuf_addstr(&full_cmd, args->v[j]);
+				}
+			}
+			strbuf_addf(&msg, _("Run 'git %s' instead [y/N]? "), full_cmd.buf);
+			strbuf_release(&full_cmd);
 			answer = git_prompt(msg.buf, PROMPT_ECHO);
 			strbuf_release(&msg);
 			if (!(starts_with(answer, "y") ||
@@ -762,37 +771,13 @@ char *help_unknown_cmd(const char *cmd, const struct strvec *args)
 	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 
 	if (SIMILAR_ENOUGH(best_similarity)) {
-		if (n == 1 && isatty(0) && isatty(2)) {
-			char *answer;
-			struct strbuf msg = STRBUF_INIT;
-			struct strbuf full_cmd = STRBUF_INIT;
-			strbuf_addstr(&full_cmd, main_cmds.names[0]->name);
-			if (args) {
-				for (size_t j = 1; j < args->nr; j++) {
-					strbuf_addch(&full_cmd, ' ');
-					strbuf_addstr(&full_cmd, args->v[j]);
-				}
-			}
-			strbuf_addf(&msg, _("\nDid you mean 'git %s'? [y/N] "),
-				    full_cmd.buf);
-			strbuf_release(&full_cmd);
-			answer = git_prompt(msg.buf, PROMPT_ECHO);
-			strbuf_release(&msg);
-			if (starts_with(answer, "y") || starts_with(answer, "Y")) {
-				char *assumed = xstrdup(main_cmds.names[0]->name);
-				cmdnames_release(&cfg.aliases);
-				cmdnames_release(&main_cmds);
-				cmdnames_release(&other_cmds);
-				return assumed;
-			}
-		} else {
-			fprintf_ln(stderr,
-				   Q_("\nThe most similar command is",
-				      "\nThe most similar commands are",
-				   n));
-			for (i = 0; i < n; i++)
-				fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
-		}
+		fprintf_ln(stderr,
+			   Q_("\nThe most similar command is",
+			      "\nThe most similar commands are",
+			   n));
+
+		for (i = 0; i < n; i++)
+			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
 	}
 
 	exit(1);
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index 6fe2da1595..75821d63e1 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -70,57 +70,18 @@ test_expect_success 'autocorrect works in work tree created from bare repo' '
 	git -C worktree -c help.autocorrect=immediate status
 '
 
-# Default behaviour (no help.autocorrect set): when there is exactly one
-# similar command but the session is non-interactive, fall back to printing
-# the suggestion list and exiting rather than showing a prompt.
-test_expect_success 'default: single match non-interactive shows suggestion and fails' '
-	test_might_fail git config --unset help.autocorrect &&
-
-	test_must_fail git lfg 2>actual &&
-	grep "most similar command" actual &&
-	grep "lgf" actual
-'
-
-test_expect_success 'default: multiple matches non-interactive shows list and fails' '
-	test_might_fail git config --unset help.autocorrect &&
-
-	test_must_fail git com 2>actual &&
-	grep "most similar commands" actual &&
-	grep "commit" actual
-'
-
-# Interactive prompt tests require a real TTY.  On macOS the TTY prereq is
-# skipped due to IO::Pty reliability issues; these tests run on Linux CI.
-test_expect_success TTY 'default: single match interactive, answer y runs command' '
-	git config --unset help.autocorrect &&
-
-	write_script git-typotest <<-\EOF &&
-		echo typotest-ran
-	EOF
-	PATH="$PATH:." export PATH &&
-
-	# Feed "y" to /dev/tty via a wrapper that answers the prompt
-	write_script answer-prompt <<-\EOF &&
-		# Write the answer to the controlling terminal
-		printf "y\n" >/dev/tty
-		exec "$@"
-	EOF
-
-	test_terminal ./answer-prompt git typotest 2>err >out &&
-	grep "typotest-ran" out &&
-	grep "Did you mean" err
-'
-
-test_expect_success TTY 'default: single match interactive, answer n exits cleanly' '
-	git config --unset help.autocorrect &&
+# autocorrect=prompt should include the original arguments in the prompt.
+# Requires a TTY; skipped on macOS due to IO::Pty reliability issues.
+test_expect_success TTY 'autocorrect=prompt includes arguments in prompt' '
+	git config help.autocorrect prompt &&
 
 	write_script answer-prompt-no <<-\EOF &&
 		printf "n\n" >/dev/tty
 		exec "$@"
 	EOF
 
-	test_must_fail test_terminal ./answer-prompt-no git typotest 2>err &&
-	grep "Did you mean" err
+	test_must_fail test_terminal ./answer-prompt-no git lfg --oneline 2>actual &&
+	grep "lgf --oneline" actual
 '
 
 test_done
-- 
2.50.1


