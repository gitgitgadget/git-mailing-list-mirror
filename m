Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3431F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 19:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeJKDCG (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 23:02:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38352 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJKDCG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 23:02:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id a13-v6so7038121wrt.5
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+i32l6bJxnz/AXvxnR8d0qryzc03rMCKVpwCNiDqt8c=;
        b=b0xwECuOdP/+hzujPMfoxQ5AUTvCOcm1di0/2Oht5Ia8JXgvP0efvE5SeQYFO15seB
         VKtRZp4Yu0SuuudqhTRmjsEkq5dqT88UJw9lQtOulIjFmx7avR9Aj87BFXbB2m46i8uo
         nOYiH9GskiGZcFA1fW03YfDxak25sirgfPhCpLyc+l7T2PVmZ3ZSgdrBhMsGPhWQHKt8
         fXz4ys08wdYtlC+GE5bjOFeGj0H6vR94OVdCh+pDwbt95VX7V8vH403nyikAhkaI8Qws
         lblIONJmXuo80FSdexEuPjHxM0MmO2bpcgMmheZXX83YZf4iZ2RzzEHKNgo+8FVCaO7L
         I8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+i32l6bJxnz/AXvxnR8d0qryzc03rMCKVpwCNiDqt8c=;
        b=IZ3vllN0HIhHbKRXD7E+NwFt9meORRJvVcts0CaREI6C1Z/PjNJsSjnGZz+5j9SFoZ
         0f9IkiocYtX+91Bo0c38ZUt7wJJz/a7dRp4pu9RC+UhognNWBnw2+I3GgcX2RvEu/Tvr
         xXXFqYFOfpwSycGC4Zwmv8h/w9FnDaRlc1L5ApF/nKPdiuHRtjFGhK0sJmByS6D836SA
         cZf9XGpmGOL58C9i0loO3uRDszVWplOEtMVRfpJ52r5S4/NjiN5EY2nAl3UaM3xwqvws
         vpE4he7UtrgvB7UC4KIAvKhiLGMu9AG0HDhaBU4fKzotRXJMl7dL/4hxDNLHlZZxk+WJ
         2PTQ==
X-Gm-Message-State: ABuFfog9x2ye8Bzpd/e0vulv5YalDKmerlSmclh3L5fpHym1Z1XQp9fZ
        XCBaL4HaTauKPCKq1LeMuWjkBSSnfkw=
X-Google-Smtp-Source: ACcGV60cUzSLssT02dT2A6YsdGqPOM98G86g0xyHlfLE7jg6w/GadZxt5aJaLZ/L+jee7OAuOMI0Kw==
X-Received: by 2002:adf:ab13:: with SMTP id q19-v6mr23809515wrc.62.1539200306822;
        Wed, 10 Oct 2018 12:38:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a18sm18520049wrx.55.2018.10.10.12.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 12:38:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] gc doc: mention the commit-graph in the intro
Date:   Wed, 10 Oct 2018 19:38:18 +0000
Message-Id: <20181010193818.20399-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.390.gf3a00b506f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explicitly mention in the intro that we may be writing supplemental
data structures such as the commit-graph during "gc", i.e. to call out
the "optimize" part of what this command does, it doesn't just
"collect garbage" as the "gc" name might imply.

Past changes have updated the intro to reflect new commands, such as
mentioning "worktree" in b586a96a39 ("gc.txt: more details about what
gc does", 2018-03-15). So let's elaborate on what was added in
d5d5d7b641 ("gc: automatically write commit-graph files", 2018-06-27).

See also
https://public-inbox.org/git/87tvm3go42.fsf@evledraar.gmail.com/ (follow-up
replies) for an on-list discussion about what "gc" does.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

In light of the linked thread let's see how controversial this is as a
stand-alone :)

 Documentation/git-gc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index f5bc98ccb3..c20ee6c789 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -17,7 +17,8 @@ Runs a number of housekeeping tasks within the current repository,
 such as compressing file revisions (to reduce disk space and increase
 performance), removing unreachable objects which may have been
 created from prior invocations of 'git add', packing refs, pruning
-reflog, rerere metadata or stale working trees.
+reflog, rerere metadata or stale working trees. May also update ancillary
+indexes such as the commit-graph.
 
 Users are encouraged to run this task on a regular basis within
 each repository to maintain good disk space utilization and good
-- 
2.19.1.390.gf3a00b506f

