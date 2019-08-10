Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF88F1F731
	for <e@80x24.org>; Sat, 10 Aug 2019 20:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfHJU2I (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 16:28:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35409 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHJU2I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 16:28:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so99286395qto.2
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 13:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r7BVam1vzjvKeDq7MRpzhR+6JLEl5IbPg6CHrc5oOZs=;
        b=qmmnQoD4UsiMxo94kZvsiwGKqxbt37dc8V+9D7azetLcm/IuhDWwhDjUx8GWI75u9f
         aWXv8Er7qTUOzWbmnsxo9pB2WvqjFL5uP+b6o/QkxdbFl2T0/jibtfZhsFR2H9lz/Ykd
         H7bmeW7pSt/+udRDEt0ADf4gQPWB0Nrdt0I7ysGeMzPEeO4iL3r5n8YF1pESTViY1c/i
         Cz2gRHsjjceqhXMSGucB2/IEs7F6AhLssdIP7Dj+jBIZl9/39jbt4DckyL1DS/BmTPyq
         TOCLQK5bu0GMwpVb3pPviYtF+ATKGbYTSXMRpGO8nSFXu1DIKHhSYf7gRjohFfxuzJzx
         GLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r7BVam1vzjvKeDq7MRpzhR+6JLEl5IbPg6CHrc5oOZs=;
        b=cTjn2LEeaXc7RSUWa6dXofgEXKzaGPeOba1R8McitOlqQNXiP03TLMkhe4lNzd21dI
         M6FMG4PkrTPo5mW5FIwyrjgGQNJZGayT7azuh5G8uFTdup7cj3Xt0NnUU+7q37w0gJqT
         E0gUB71SgTeRpkfOBcbPYGDI5dpjsboxU3BlQa77FaxMBfckK/aRQf1X1+ufp15Ytepw
         p1AhbkCgj0VOIiuaSZ4BHW8/x54wA3fYMuBgjOohU/9a0EstXmU+wyLubj3/gRAbO9f+
         I3WbFf9ZAfnUQrO3ISYtEZAotVvFwbCH7m0IiEQsW6VzYbHhDR8/Sw2YPuLcP+dZBB7J
         ytzg==
X-Gm-Message-State: APjAAAW9eKfRu5owoGcBcI4LU4M0A8bMlxKXw5GtSBSAk7fPYjUz69j+
        y2efK7Q7O+3vqLvLgfXyX/lK2Cp8ZwU=
X-Google-Smtp-Source: APXvYqzeTiQLR+MpUY1W+QfQXQeqydEQ6tnXJ496Z92dRqzs0q6siDVgjiDsz+97xThQzsTkkcGQwg==
X-Received: by 2002:ac8:60a:: with SMTP id d10mr23593025qth.31.1565468887210;
        Sat, 10 Aug 2019 13:28:07 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u1sm54384295qth.21.2019.08.10.13.28.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 13:28:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Manav Rathi <mnvrth@gmail.com>
Subject: [GSoC][PATCH 4/4] grep: re-enable threads in some non-worktree cases
Date:   Sat, 10 Aug 2019 17:27:30 -0300
Message-Id: <8c26abe9156e069ad4d19e9f0ce131cd1453f030.1565468806.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565468806.git.matheus.bernardino@usp.br>
References: <cover.1565468806.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They were disabled at 53b8d93 ("grep: disable threading in non-worktree
case", 12-12-2011), due to observable performance drops. But now that
zlib inflation can be performed in parallel, for some of git-grep's
options, we can regain the speedup.

Grepping 'abcd[02]' ("Regex 1") and '(static|extern) (int|double) \*'
("Regex 2") at chromium's repository[1] I got:

 Threads |   Regex 1  |  Regex 2
---------|------------|-----------
    1    |  17.3557s  | 20.8410s
    2    |   9.7170s  | 11.2415s
    8    |   6.1723s  |  6.9378s

These are all means of 30 executions after 2 warmup runs. All tests were
executed on an i7-7700HQ with 16GB of RAM and SSD. But to make sure the
optimization also performs well on HDD, the tests were repeated on an
AMD Turion 64 X2 TL-62 (dual-core) with 4GB of RAM and HDD (SATA-150,
5400 rpm):

 Threads |   Regex 1  |  Regex 2
---------|------------|-----------
    1    |  40.3347s  |  47.6173s
    2    |  27.6547s  |  35.1797s

Unfortunately, textconv and submodules' operations remain thread-unsafe,
needing locks to be safely executed when threaded. Because of that, it's
not currently worthy to grep in parallel with them. So, when --textconv
or --recurse-submodules are given for a non-worktree case, threads are
kept disabled. In order to clarify this behavior, let's also add a
"NOTES" section to Documentation/git-grep.txt explaining the thread
usage details.

[1]: chromium’s repo at commit 03ae96f (“Add filters testing at DSF=2”,
     04-06-2019), after a 'git gc' execution.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/git-grep.txt | 12 ++++++++++++
 builtin/grep.c             |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 2d27969057..9686875fbc 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -330,6 +330,18 @@ EXAMPLES
 `git grep solution -- :^Documentation`::
 	Looks for `solution`, excluding files in `Documentation`.
 
+NOTES
+-----
+
+The --threads option (and grep.threads configuration) will be ignored when
+--open-files-in-pager is used, forcing a single-threaded execution.
+
+When grepping the index file (with --cached or giving tree objects), the
+following options will also suppress thread creation:
+
+	--recurse_submodules
+	--textconv
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/grep.c b/builtin/grep.c
index fa51392222..e5a9da471a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1073,7 +1073,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;
 
-	if (list.nr || cached || show_in_pager) {
+	if (show_in_pager ||
+	   ((list.nr || cached) && (recurse_submodules || opt.allow_textconv))) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
 		num_threads = 1;
-- 
2.22.0

