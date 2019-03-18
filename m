Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B10220248
	for <e@80x24.org>; Mon, 18 Mar 2019 16:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfCRQPZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 12:15:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37299 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfCRQPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 12:15:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id y15so17736482wro.4
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r668F2eV0Qyvi+UucT5Ntky+AJIT9xy8S3FcPTen4RE=;
        b=DQg/fi2eqq2llYNoZA7d3Yp9CDDp4zTRZmXe/7Vw3mNvgSi7PIjEA39jIWul5jbE/b
         +2bg2cC6aAUE8+/J6YBdLJLNTYC1U6ag2SRR+CEDwGivWq2KYri247gVB/Kn1bsyoCe0
         XMEZFosuXcCuGxriSg7O5+Ixf0MsslrLXATP1ByJfQt7O9MU215KOwndPZvZdan1Nmqf
         fQ+QZi/8+A+BPOg9Wge72xrEVKQJzxu/i8KCNd3XZ6kxoz6rNosQfpfrFrcsrKcNw4Zq
         QDLO1/5llNraBilTaQcva9cJtmoL4lXYLYz9QeQeuFsdpv8Xww8EEfXC7BpYEKNv2vZJ
         pnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r668F2eV0Qyvi+UucT5Ntky+AJIT9xy8S3FcPTen4RE=;
        b=kfyPFVLjn80rRmUwG9LiISCGZtgyWXwY/im03W7911kP0nKH+1Kfigl5d6vmeLzRXy
         owbYuHnLql80N40RB9Q7LNikMpjb85YFyUpBcVGXSRrBLDz7zKwV5Q6Tqf7QvBZm+7g9
         8aA0Hv9jnyHypMn/TEf+Y/TIac9AOxt9k3Lo7b0TCE1K7B3nWK0s/3R23PLiQaCY1/fF
         1khzhsyZ3pmgrYcahxnMg2zI7jRmFfpAJsJz10+RkrYm/8hLF8lJ735QFKzE5mTOWOMG
         NdB9cHTJ5Q/IdSVvawfYF+h0xiNV9dqn7L4zzoVDeJRtL+AmHM+doKTp5oFj1Zf2BXoK
         +Daw==
X-Gm-Message-State: APjAAAVDrRO3qDxpVSsQMrMbgM5h7OEQ0xF7DIGoHIFqhS21YXQjaDpK
        dAU8RK/QJ2Hn3+3Q3jPzNOR5LzXWBmU=
X-Google-Smtp-Source: APXvYqycTX0u8ZGPFxwIvYEEVi95oKpyaGPfnrUhJu69j3pdXLnHTgvIwAE/FBLoq4RLHhh2p/xedw==
X-Received: by 2002:adf:d848:: with SMTP id k8mr3344184wrl.185.1552925721397;
        Mon, 18 Mar 2019 09:15:21 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z9sm3269728wmf.12.2019.03.18.09.15.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Mar 2019 09:15:20 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] gc docs: downplay the usefulness of --aggressive
Date:   Mon, 18 Mar 2019 17:15:02 +0100
Message-Id: <20190318161502.7979-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing "gc --aggressive" docs come just short of recommending to
users that they run it regularly. In reality it's a waste of CPU for
most users, and may even make things actively worse. I've personally
talked to many users who've taken these docs as an advice to use this
option, and have.

Let's change this documentation to better reflect reality, i.e. for
most users using --aggressive is a waste of time, and may even be
actively making things worse.

Let's also clarify the "The effects [...] are persistent" to clearly
note that that's true to the extent that subsequent gc's aren't going
to re-roll existing packs generated with --aggressive into a new set
of packs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 154c7c5e652..d0eaba98db5 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -41,10 +41,20 @@ OPTIONS
 --aggressive::
 	Usually 'git gc' runs very quickly while providing good disk
 	space utilization and performance.  This option will cause
-	'git gc' to more aggressively optimize the repository at the expense
-	of taking much more time.  The effects of this optimization are
-	persistent, so this option only needs to be used occasionally; every
-	few hundred changesets or so.
+	'git gc' to more aggressively optimize the repository to save storage space
+	at the expense of taking much more time.
++
+Using this option may optimize for disk space at the expense of
+runtime performance. See the `--depth` and `--window` documentation in
+linkgit:git-repack[1]. It is not recommended that this option be used
+to improve performance for a given repository without running tailored
+performance benchmarks on it. It may make things better, or worse. Not
+using this at all is the right trade-off for most users and their
+repositories.
++
+The effects of this option are persistent to the extent that
+`gc.autoPackLimit` and friends don't cause a consolidation of existing
+pack(s) generated with this option.
 
 --auto::
 	With this option, 'git gc' checks whether any housekeeping is
-- 
2.21.0.360.g471c308f928

