Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DA0E20248
	for <e@80x24.org>; Sun,  7 Apr 2019 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDGTwk (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 15:52:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51721 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfDGTwj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 15:52:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so11910918wmf.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 12:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/A8XOkySTNrBhJOhhzMmwfo0SaDP8OPiDWiZmHqW5s=;
        b=YYkNXXFrLTPbG9AWgm/Flwu9aujIAz9L3zE9CCjM6F7K/1WDWAAsxNe1CGdWMh+6z+
         W/xZU1+/lVUwXG8tOtrazfHtPSxrHMnGtcGZHjHN6w04bkbeoMTZmBJgMknxV+RJJari
         KnYhwK5AIPlHyFlImZt9Xign+rqhByikSDxLz42LGQ77XM5lvDk00ZtBA++UsqtdISVP
         fD+7PGEW+WYEKzPC3Gr5C7EPXEt56b+YyA3RT0C8xfSGsXVxo3F2ySNBZH39eyqqEemB
         afBj0qFKFz8QU8Ains41y8/X7VfJjvgXZTfAv4hJAIaeJCNVKoo+OjXbMwR3dugHyBD2
         d98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/A8XOkySTNrBhJOhhzMmwfo0SaDP8OPiDWiZmHqW5s=;
        b=a1VXvWWBar390fUs7CMaGK10LddUbFVzmsbJgjIIlu32ZjcbqG290+8RPfZs2PFUB2
         4QCn17Qa/w76toTfuuvmeg46v15Re+WpIPW5cpeFhDu9tw2IdCR8MTeEdoxOtEYFRt89
         17PNB47DQIR3FqjnVCo3ZILZM2vjuAXXmkO5mbxbLS9Bu8C1uazDnnw7sm+rVE8xBB4h
         6gXdqiBcbZgDRDE9c4LqWGXH+Ny/HROjFnuVPXaT218GP8yrxVXyzI1zpmtxK8djHrB1
         YQMbjminOhly3S+dG4LZtHyWeP1RZ/Fz1tulisSftRiMnEl3uZrVit+gzmJ9Zk23eRJe
         MWJw==
X-Gm-Message-State: APjAAAWJfYTyhKh/S8oRnEFfEZ2ZIr+WpFkp572RMTn5M+4V03L54Y88
        CALvpmWHN4rAzrlkS+g2dgSILFNi
X-Google-Smtp-Source: APXvYqydmkdPshPFsqR+UPwmSvEooSlClJ8ETWZWPBqgLrLIK1unX+LKwxOMSJ7zIJVTdc5PfvON4w==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr16128070wme.24.1554666757519;
        Sun, 07 Apr 2019 12:52:37 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16sm41815402wrs.0.2019.04.07.12.52.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 12:52:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/11] gc docs: modernize the advice for manually running "gc"
Date:   Sun,  7 Apr 2019 21:52:07 +0200
Message-Id: <20190407195217.3607-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190322093242.5508-5-avarab@gmail.com>
References: <20190322093242.5508-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The docs have been recommending that users need to run this manually,
but that hasn't been needed in practice for a long time except in
exceptional circumstances.

Let's instead have this reflect reality and say that most users don't
need to run this manually at all, while briefly describing the sorts
sort of cases where "gc" does need to be run manually.

Since we're recommending that users run this most of the and usually
don't need to tweak it, let's tone down the very prominent example of
the gc.auto=0 command. It's sufficient to point to the gc.auto
documentation below.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index a7c1b0f60e..dd22eecc79 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -20,17 +20,16 @@ created from prior invocations of 'git add', packing refs, pruning
 reflog, rerere metadata or stale working trees. May also update ancillary
 indexes such as the commit-graph.
 
-Users are encouraged to run this task on a regular basis within
-each repository to maintain good disk space utilization and good
-operating performance.
-
-Some git commands may automatically run 'git gc'; see the `--auto` flag
-below for details. If you know what you're doing and all you want is to
-disable this behavior permanently without further considerations, just do:
-
-----------------------
-$ git config --global gc.auto 0
-----------------------
+When common porcelain operations that create objects are run, they
+will check whether the repository has grown substantially since the
+last maintenance, and if so run `git gc` automatically. See `gc.auto`
+below for how to disable this behavior.
+
+Running `git gc` manually should only be needed when adding objects to
+a repository without regularly running such porcelain commands, to do
+a one-off repository optimization, or e.g. to clean up a suboptimal
+mass-import. See the "PACKFILE OPTIMIZATION" section in
+linkgit:git-fast-import[1] for more details on the import case.
 
 OPTIONS
 -------
-- 
2.21.0.392.gf8f6787159e

