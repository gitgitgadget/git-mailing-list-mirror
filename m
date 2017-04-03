Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB961FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 21:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbdDCVRB (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 17:17:01 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34797 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbdDCVRA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 17:17:00 -0400
Received: by mail-wr0-f178.google.com with SMTP id t20so8555962wra.1
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVIrsiqP2k3A6BczcLpMzq6258vfYiMQiOKnzri+NmU=;
        b=O5gcajoRE08QT4r7smdOGNyEMFKjHTS7F4M1HdAlx5mQN5MhWljgEs2aZ85UaKRXe2
         v4yyH5VvIO3INuw6I5YmpCc5A3ubCblpd9T/pmt4oGuqq9sBz+QkLK2jDABbASLHE7Ag
         YYVhlnckcdGIry0lMmxdZ6gIQnEknXVzXLsIBUnWADpV50VrHRIPPthucgCvDezl/OAh
         06kNqo9B5Ykh9BlwvE+hBA+TAEjw55j+sRqwPZfrV8zILR8OwI2+3u5k7x22DxX16DCX
         hPBx+eYUm/UO/efI72ficrhBIcD8isz5zLpivjiC6qDVCnBm8gmEj63nQUG0sfV2OURn
         CxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVIrsiqP2k3A6BczcLpMzq6258vfYiMQiOKnzri+NmU=;
        b=OifluweajuWh1spLvCpRKafcQsn7LZ5lnl/eAxgmpynZwKAsw6Cqzz7phbBZRfFAsD
         RBLOqEW/qfCY3vtGiC61xnWzHKqlZ0A5C9cb2rYH7hy4iPv7nd88RfrUD+1iIpazseWz
         1LQeEsYHspKydL+e6G3gFV8Hgb/12k4wPBEM1V8wU0ftiyCOgyju1LUkBKdsgIDMJ6jO
         Db0Hb2AzOsDiXfwYJZm/hS7sHUjFDYp8uPbnDHd+oI6s8IK3CmpOWpPGpikJFUXLrjqD
         X8p8v159F9Gms2M37sqeUu2tS/ipJ1a/NqGDCcBwY5EloqUk+xWpXxBANsIaRwRk6ZMY
         7NpQ==
X-Gm-Message-State: AFeK/H3vKJv7DioR5Pan6OUKtIYuXrCalk61useT1gpZNulNCkznhi7p8QEU4idDamuLIw==
X-Received: by 10.223.165.85 with SMTP id j21mr16163607wrb.56.1491254218490;
        Mon, 03 Apr 2017 14:16:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 24sm19652552wrw.46.2017.04.03.14.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 14:16:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH/RFC] gitperformance: add new documentation about git performance tuning
Date:   Mon,  3 Apr 2017 21:16:44 +0000
Message-Id: <20170403211644.26814-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new manpage that gives an overview of how to tweak git's
performance.

There's currently no good single resource for things a git site
administrator might want to look into to improve performance for his
site & his users. This unfinished documentation aims to be the first
thing someone might want to look at when investigating ways to improve
git performance.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I've been wanting to get something like this started for a while. It's
obviously woefully incomplete. Pointers about what to include would be
great & whether including something like this makes sense.

Things I have on my TODO list:

 - Add a section discussing how refs impact performance, suggest
   e.g. archiving old tags if possible, or at least run "git remote
   prune origin" regularly on clients.

 - Discuss split index a bit, although I'm not very confident in
   describing what its pros & cons are.

 - Should we be covering good practices for your repo going forward to
   maintain good performance? E.g. don't have some huge tree all in
   one directory (use subdirs), don't add binary (rather
   un-delta-able) content if you can help it etc.

- The new core.checksumIndex option being discussed on-list. Which
  actually drove my to finally write this up (hrm, this sounds useful,
  but unless I was watching the list I'd probably never see it...).


 Documentation/Makefile           |   1 +
 Documentation/gitperformance.txt | 107 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/gitperformance.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b5be2e2d3f..528aa22354 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -23,6 +23,7 @@ MAN5_TXT += gitrepository-layout.txt
 MAN5_TXT += gitweb.conf.txt
 
 MAN7_TXT += gitcli.txt
+MAN7_TXT += gitperformance.txt
 MAN7_TXT += gitcore-tutorial.txt
 MAN7_TXT += gitcredentials.txt
 MAN7_TXT += gitcvs-migration.txt
diff --git a/Documentation/gitperformance.txt b/Documentation/gitperformance.txt
new file mode 100644
index 0000000000..0548d1e721
--- /dev/null
+++ b/Documentation/gitperformance.txt
@@ -0,0 +1,107 @@
+giteveryday(7)
+==============
+
+NAME
+----
+gitperformance - How to improve Git's performance
+
+SYNOPSIS
+--------
+
+A guide to improving Git's performance beyond the defaults.
+
+DESCRIPTION
+-----------
+
+Git is mostly performant by default, but ships with various
+configuration options, command-line options, etc. that might improve
+performance, but for various reasons aren't on by default.
+
+This document provides a brief overview of these features.
+
+The reader should not assume that turning on all of these features
+will increase performance, depending on the repository, workload &
+use-case turning some of them on might severely harm performance.
+
+This document serves as a starting point for things to look into when
+it comes to improving performance, not as a checklist for things to
+enable or disable.
+
+Performance by topic
+--------------------
+
+It can be hard to divide the performance features into topics, but
+most of them fall into various well-defined buckets. E.g. there are
+features that help with the performance of "git status", and couldn't
+possibly impact repositories without working copies, and then some
+that only impact the performance of cloning from a server, or help the
+server itself etc.
+
+git status
+~~~~~~~~~~
+
+Running "git status" requires traversing the working tree & comparing
+it with the index. Several configuration options can help with its
+performance, with some trade-offs.
+
+- config: "core.untrackedCache=true" (see linkgit:git-config[1]) can
+  save on `stat(2)` calls by caching the mtime of filesystem
+  directories, and if they didn't change avoid recursing into that
+  directory to `stat(2)` every file in them.
++
+pros: Can drastically speed up "git status".
++
+cons: There's a speed hit for initially populating & maintaining the
+cache. Doesn't work on all filesystems (see `--test-untracked-cache`
+in linkgit:git-update-index[1]).
+
+- config: "status.showUntrackedFiles=no" (see
+  linkgit:git-config[1]). Skips looking for files in the working tree
+  git doesn't already know about.
++
+pros: Speeds up "git status" by making it do a lot less work.
++
+cons: If there's any new & untracked files anywhere in the working
+tree they won't be noticed by git. Makes it easy to accidentally miss
+files to "git add" before committing, or files which might impact the
+code in the working tree, but which git won't know exist.
+
+git grep
+~~~~~~~~
+
+- config: "grep.patternType=perl" (see linkgit:git-config[1]) will use
+  the PCRE library when "git grep" is invoked by default. This can be
+  faster than POSIX regular expressions in many cases.
++
+pros: Can, depending on the use-case, be faster than default "git grep".
++
+cons: Can also be slower, and in some edge cases produce different
+results.
+
+- config: "grep.threads=*" (see linkgit:git-config[1] &
+  linkgit:git-grep[1]). Tunes the number of "git grep" worker threads.
++
+pros: Giving this a more optimal value might result in a faster grep.
++
+cons: It might not.
+
+Server options to help clients
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+These features can be enabled on git servers, they won't help the
+performance of the servers themselves, but will help clients that need
+to talk to those servers.
+
+- config: "repack.writeBitmaps=true" (see
+  linkgit:git-config[1]). Spend more time during repack to produce
+  bitmap index, helps clients with "fetch" & "clone" performance.
++
+pros: Once enabled & run regularly as part of "git repack" speeds up
+"clone" and "fetch".
++
+cons: Takes extra time during repack, requires doing full
+non-incremental repacks with `-A` or `-a`.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.11.0

