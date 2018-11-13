Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DD11F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbeKNEzh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:55:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54910 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeKNEzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:55:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so13118462wma.4
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+nUIoM+0aHiMZhJpgNsCn4eCKjDIuAVir5KDwfCs6Y=;
        b=ki1B8XIaWQ3Wnqn0vuXbsgQ6UWyyXiUO+eEEqh6pCoo2tOperATMBfrEY2XkUp+2uG
         R11wVPJFt17Dg6Pj4JbOwX2NmIKVk+uDXCOFdFnxJGYQLfcNiI2wzOwTiuhKU3G7Bw4f
         U6tNquAc7l/TtAOx1Lqis1SEz6Ml28SXa6PfhMn+iTwalvfzoDxY6YM8XLwb1oQCUB9f
         YrSWlFI5rMEvwmZlIAj40Oy9sIlzgtnZ3MsxZB0/D/IKoyFiFOHsqULgtYSvqotRROPC
         9lT7d1niQnCCphxzfQJticFK3SY7PtRwJUNYRcBbZcHKumb0XBCxEKKHHPavCVlT5h7o
         ikag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+nUIoM+0aHiMZhJpgNsCn4eCKjDIuAVir5KDwfCs6Y=;
        b=ehLDIAVbltucchjybyAAq0kBDFNSoi0AtpIWN5bQOzgy/AKBOte71rIG+srr5RPBxm
         xZ8Me0uBoNaD5SpDGnrZX2LV4pHqVxi0npoBW9R1JkK2Qq6VQRNETvM3n741wZAfoEh+
         IeJ5hu/AsOzL+FlUmAu3UkpZ+SGdxeberGQLGDzd22KUIxbRsVCFERLympZaVljo9FoG
         4+jSga8j9O4bsdoaIwJs/9tTJV++w3u+4TtRT8FyI/0dygOkjiT8oPTVTe+NR66heZ/c
         N/ONWai/C+ai8zdGLcumuuS2KObs+Di5RiCBCpDzWvT7RjRyZA+tG4wJTWHSZFMq4lJz
         o84g==
X-Gm-Message-State: AGRZ1gJs3cZDssjWWs3avGlbL5rtbel/ygMko8Hl9RnoXX5FXSxXEGgF
        1yfejVXigwP1MBgzsgV3Y+FL3mMpjdE=
X-Google-Smtp-Source: AJdET5e7iKdnUOlNtZtEdm+/iiqREU9HHoV7xOjpBVj/qGb9pcAgQHZ/LLa01lw2p7Nq1yCE3/fRgg==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187-v6mr4148176wmf.70.1542135370075;
        Tue, 13 Nov 2018 10:56:10 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y81-v6sm9908268wmd.11.2018.11.13.10.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:56:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stephen & Linda Smith <ischis2@cox.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/3] range-diff doc: add a section about output stability
Date:   Tue, 13 Nov 2018 18:55:56 +0000
Message-Id: <20181113185558.23438-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <xmqqftw73r9a.fsf@gitster-ct.c.googlers.com>
References: <xmqqftw73r9a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The range-diff command is already advertised as porcelain, but let's
make it really clear that the output is completely subject to change,
particularly when it comes to diff options such as --stat. Right now
that option doesn't work, but fixing that is the subject of a later
change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-range-diff.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index f693930fdb..8a6ea2c6c5 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -78,6 +78,23 @@ between patches", i.e. to compare the author, commit message and diff of
 corresponding old/new commits. There is currently no means to tweak the
 diff options passed to `git log` when generating those patches.
 
+OUTPUT STABILITY
+----------------
+
+The output of the `range-diff` command is subject to change. It is
+intended to be human-readable porcelain output, not something that can
+be used across versions of Git to get a textually stable `range-diff`
+(as opposed to something like the `--stable` option to
+linkgit:git-patch-id[1]). There's also no equivalent of
+linkgit:git-apply[1] for `range-diff`, the output is not intended to
+be machine-readable.
+
+This is particularly true when passing in diff options. Currently some
+options like `--stat` can, as an emergent effect, produce output
+that's quite useless in the context of `range-diff`. Future versions
+of `range-diff` may learn to interpret such options in a manner
+specific to `range-diff` (e.g. for `--stat` producing human-readable
+output which summarizes how the diffstat changed).
 
 CONFIGURATION
 -------------
-- 
2.19.1.1182.g4ecb1133ce

