Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A47C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 08:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbiAQIVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiAQIVI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 03:21:08 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C1FC061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 00:21:08 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id x83so10207221pgx.4
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 00:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMoxMiQoVTgaV/8KjA2uCC4WceOm2hSP0k8xO/9rRr0=;
        b=cH6U3M5SIGtsDfO0skwr153ee28tI/h4BOcSkz/LfKqcSGgSM2Bmr6HXRRuhjK5wwm
         7ZqotYuyvt8tZHDvKOunDbT/6ndQmvYTmGkbzVBOIzguQf6gRAlqs/i10/KeUhL3olmy
         bPUck/AhP304zSYCVhxMXnnelm7BgyUaLrk6YJH7j5X5FPCCo+18LNSXKExImuKqn6K3
         /X1DCTGmekEo8gspm0LwPpB8+CT7DassOk2PctItWysGxIVf9HftHdzzZ7HFgaWrv8Zd
         Yb+85kgVdeSgHcWCh0d1EPQfxQXVcz9Sxck1JS+qf4zWvPvf41m+crAoojaM2hSR3ejC
         B0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMoxMiQoVTgaV/8KjA2uCC4WceOm2hSP0k8xO/9rRr0=;
        b=cfcxbRuP9Duy0co9q0+Z5l63zhMQ9sBnBWWm2kylErFwRgUJDmYu71WuHjAUj43lcP
         LlW1DaRJFRvuP9+k0kMzXeRkaU0l9h2SeV/xVtCnkai9IcNbFqIH6earN2H9nWs0tgjP
         KSJkAPB9bL9LNhZgU+PpuRj2W6PL+vR+NBQH7noGccex7OBM/6aUlFB7a59AQ0XPhCNB
         qrWrlu709m3MPpbxhwNNs7hvXMc+4N7C+s3WTqY4VnD8aQ6fc4KeZH0Y47spcchbmpir
         H+9mqy083gEpRddljaBiEyBqGeyllwmIQ7T+vmKfxF+qu+Cg2ZojkowrRfUETB4XVKYY
         LI9w==
X-Gm-Message-State: AOAM533WofQiJMBkulUcpEmUXGjkOgaNnSYx9l8KfS65+6H4F0aevkoY
        B2bKkR6CuMGPEZ7R5gggfgYlClibGyTP8nCi
X-Google-Smtp-Source: ABdhPJzmEKwOAlwMOodhhkU8a+3RotyqjuWVG82yqs5/bJsxArEM8DzFQz4Bwt6qgcsMBkV+M9k48A==
X-Received: by 2002:a63:5712:: with SMTP id l18mr2365786pgb.343.1642407667630;
        Mon, 17 Jan 2022 00:21:07 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.45])
        by smtp.gmail.com with ESMTPSA id n26sm10944842pgb.91.2022.01.17.00.21.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:21:07 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sandals@crustytoothpaste.net,
        tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v1 1/1] git-cli.txt: clarify "options first and then args"
Date:   Mon, 17 Jan 2022 16:21:01 +0800
Message-Id: <fe748304d94e0ae25fd3549aadc49cf951ff2d64.1642405806.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.391.g9ef3d6f133
In-Reply-To: <cover.1642405806.git.dyroneteng@gmail.com>
References: <cover.1642405806.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some commands permit the user whether to provide options
first before args, or the reverse order. For example:

    git push --dry-run <remote> <ref>

And:

    git push <remote> <ref> --dry-run

Both of them is supported, but some commands do not, for instance:

     git ls-remote --heads <remote>

And:

     git ls-remote <remote> --heads

If <remote> only has one ref and it's name is "refs/heads/--heads", you
will get the same result, otherwise will not.This is because the former
in the second example will parse "--heads" as an "option" which means
to limit to only "refs/heads" when listing the remote references, the
latter treat "--heads" as an argument which means to filter the result
list with the given pattern.

Therefore, we want to specify a bit more in "gitcli.txt" about the way
we recommend and help to resolve the ambiguity around some git command
usage. The related disscussions locate at [1].

By the way, there are some issues with lowercase letters in the document,
which have been modified together.

[1] https://public-inbox.org/git/cover.1642129840.git.dyroneteng@gmail.com/

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/gitcli.txt | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 92e4ba6a2f..1819a5a185 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -19,6 +19,15 @@ Many commands take revisions (most often "commits", but sometimes
 "tree-ish", depending on the context and command) and paths as their
 arguments.  Here are the rules:
 
+ * Options come first and then args.
+    A subcommand may take dashed options (which may take their own
+    arguments, e.g. "--max-parents 2") and arguments.  You SHOULD
+    give dashed options first and then arguments.  Some commands may
+    accept dashed options after you have already gave non-option
+    arguments (which may make the command ambiguous), but you should
+    not rely on it (because eventually we may find a way to fix
+    these ambiguity by enforcing the "options then args" rule).
+
  * Revisions come first and then paths.
    E.g. in `git diff v1.0 v2.0 arch/x86 include/asm-x86`,
    `v1.0` and `v2.0` are revisions and `arch/x86` and `include/asm-x86`
@@ -72,24 +81,24 @@ you will.
 Here are the rules regarding the "flags" that you should follow when you are
 scripting Git:
 
- * it's preferred to use the non-dashed form of Git commands, which means that
+ * It's preferred to use the non-dashed form of Git commands, which means that
    you should prefer `git foo` to `git-foo`.
 
- * splitting short options to separate words (prefer `git foo -a -b`
+ * Splitting short options to separate words (prefer `git foo -a -b`
    to `git foo -ab`, the latter may not even work).
 
- * when a command-line option takes an argument, use the 'stuck' form.  In
+ * When a command-line option takes an argument, use the 'stuck' form.  In
    other words, write `git foo -oArg` instead of `git foo -o Arg` for short
    options, and `git foo --long-opt=Arg` instead of `git foo --long-opt Arg`
    for long options.  An option that takes optional option-argument must be
    written in the 'stuck' form.
 
- * when you give a revision parameter to a command, make sure the parameter is
+ * When you give a revision parameter to a command, make sure the parameter is
    not ambiguous with a name of a file in the work tree.  E.g. do not write
    `git log -1 HEAD` but write `git log -1 HEAD --`; the former will not work
    if you happen to have a file called `HEAD` in the work tree.
 
- * many commands allow a long option `--option` to be abbreviated
+ * Many commands allow a long option `--option` to be abbreviated
    only to their unique prefix (e.g. if there is no other option
    whose name begins with `opt`, you may be able to spell `--opt` to
    invoke the `--option` flag), but you should fully spell them out
-- 
2.34.1.391.g9ef3d6f133

