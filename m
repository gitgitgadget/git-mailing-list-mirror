Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C6E1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 16:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJCXPd (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 19:15:33 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:49580 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbeJCXPc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 19:15:32 -0400
Received: by mail-io1-f73.google.com with SMTP id k9-v6so6000997iob.16
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+qH5pccGL0W3kFlZtyFaRBOXWS4gt/fo6K8dxxE0mok=;
        b=bghQNKglhFrKLNaeQ/dO4aw0NI5FA+tjlpq/gTQcvmzZ5bwBpNZW4QcnJru8KiOvt2
         7Gz73CcwxA13S2Sof1eAIf59aVc0Y6eGkSHoKP+cq78oBN7Qv+AVP+2Rg+6bVek5lZfX
         gfgUeaXjGa4g3q23DXwFVgV3mkER67uZJsk0S02HhgXSyiyXbUOTZyR2fl2anK1p5RqS
         u0fn+OxsHkJXCz6UhQbUhofzF2c1hxKkvsJlIUwuzbkGowyjVHCzn9OL/bvcJ38AJj3h
         MfOzOX6hNF42Ykwzy9ETgoj2ATk7m8JnRCBQc7h+J50U7KzysSj7CBQCoImqTyBkWyT1
         v0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+qH5pccGL0W3kFlZtyFaRBOXWS4gt/fo6K8dxxE0mok=;
        b=Cer0ralgOqAcPkhrQoo7RlQJTM8uOn8cyZwdKpLNc8/Tj5exfPYimAtYO6D0MdFQdP
         uEmvjWPA6VxC2v5akVdL5cp2HlPNB1ofSjgEJWm1HzpKPm8q4ZZxjHpOjk9uhjHrtOf/
         Mp7lmslwLiPTkI206C0nQvAbmCMbIkictL4Xi/9VRidtcpdFTpONTbsaj3hlx/sVtpcS
         GtNSzt/BSInlvuQw01nF4nUqKe751Kjx1ed8HFW9tjTjUkc1wG0chxK4gnC7YzSYXjAV
         07yyus9yQFUQe31qXBYEUsREOnQ6KceC3ZETsA/4Y8OfeRuqSstDkCnlF/B6CTxgA7he
         E1+w==
X-Gm-Message-State: ABuFfojlUR41dwmYX9ILYbnrl/HMDhTKalzfoxIvq4TWRaNz2DG9vsoP
        hgPhTinO93ijRVZiJux1lCEX2Okc9K5yT9l67dWdlfBSPaCEGGkEnLDKSg2sMTo4zu2MJViyNH5
        Pb9hnZIsLxD2WrpW1oajr5dIJp7ohzM2VfqCb10ISS+3h5LrolMJiuZUUuEE=
X-Google-Smtp-Source: ACcGV608h3KhZnqSuRsUGEZf5JGQliiJfbjRSehMWRp8B9VAk41J95JaQ26gIQZZ9As4CuZbEHoN++ilIjbv
X-Received: by 2002:a24:fe01:: with SMTP id w1-v6mr6070853ith.0.1538583986286;
 Wed, 03 Oct 2018 09:26:26 -0700 (PDT)
Date:   Wed,  3 Oct 2018 09:26:00 -0700
In-Reply-To: <cover.1538581868.git.matvore@google.com>
Message-Id: <a45b646fced228e5a7fab4db7a35c1c6084e58d0.1538581868.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538581868.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 2/7] Documentation: add shell guidelines
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the following guideline to Documentation/CodingGuidelines:

	&&, ||, and | should appear at the end of lines, not the
	beginning, and the \ line continuation character should be
	omitted

And the following to t/README (since it is specific to writing tests):

	pipes and $(git ...) should be avoided when they swallow exit
	codes of Git processes

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/CodingGuidelines | 18 ++++++++++++++++++
 t/README                       | 28 ++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 48aa4edfb..72967deb7 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -118,6 +118,24 @@ For shell scripts specifically (not exhaustive):
 		do this
 	fi
 
+ - If a command sequence joined with && or || or | spans multiple
+   lines, put each command on a separate line and put && and || and |
+   operators at the end of each line, rather than the start. This
+   means you don't need to use \ to join lines, since the above
+   operators imply the sequence isn't finished.
+
+	(incorrect)
+	grep blob verify_pack_result \
+	| awk -f print_1.awk \
+	| sort >actual &&
+	...
+
+	(correct)
+	grep blob verify_pack_result |
+	awk -f print_1.awk |
+	sort >actual &&
+	...
+
  - We prefer "test" over "[ ... ]".
 
  - We do not write the noiseword "function" in front of shell
diff --git a/t/README b/t/README
index 85024aba6..9a71d5732 100644
--- a/t/README
+++ b/t/README
@@ -466,6 +466,34 @@ And here are the "don'ts:"
    platform commands; just use '! cmd'.  We are not in the business
    of verifying that the world given to us sanely works.
 
+ - Don't use Git upstream in the non-final position in a piped chain, as
+   in:
+
+     git -C repo ls-files |
+     xargs -n 1 basename |
+     grep foo
+
+   which will discard git's exit code and may mask a crash. In the
+   above example, all exit codes are ignored except grep's.
+
+   Instead, write the output of that command to a temporary
+   file with ">" or assign it to a variable with "x=$(git ...)" rather
+   than pipe it.
+
+ - Don't use command substitution in a way that discards git's exit
+   code. When assigning to a variable, the exit code is not discarded,
+   e.g.:
+
+     x=$(git cat-file -p $sha) &&
+     ...
+
+   is OK because a crash in "git cat-file" will cause the "&&" chain
+   to fail, but:
+
+     test "refs/heads/foo" = "$(git symbolic-ref HEAD)"
+
+   is not OK and a crash in git could go undetected.
+
  - Don't use perl without spelling it as "$PERL_PATH". This is to help
    our friends on Windows where the platform Perl often adds CR before
    the end of line, and they bundle Git with a version of Perl that
-- 
2.19.0.605.g01d371f741-goog

