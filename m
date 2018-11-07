Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32AD11F453
	for <e@80x24.org>; Wed,  7 Nov 2018 12:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeKGVwY (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 16:52:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34292 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeKGVwY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 16:52:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so17199186wre.1
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 04:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAHmT/pcpYgzabZuc/D3S28CNtgxEYZt4O5b1uHRwi0=;
        b=U8WAY9f1KF2ER7LQwBQvXRB5yHrqH7P/4R8QK9mKtAxhvrl44TAGO2zH/FUsy/7tOR
         0W4/ithgaJk1L1JqUPCz1I5OEtXmzKoI6kmAZoFYoRIkx5M8HeHkR+QaDt+mCI9eC5kX
         ctcgrST8iir/D1hVZLSfwSvUC9vXzAsVwxYOFY03udrTFMhr+Kb+9QDBT7BwAF2LNil5
         ZUduyvZQOUc99WJwG0ASn6FO4byzpuZVDH217bdPZ6AHsFkOb3pRxuLIMZ0wFwMSoqTi
         yIEbiAFPTYQwM7khchLOYsroHgAHHG5F8vtiUg9URhtBMC+C7i9SlqZwhM7m7jkBoQ9V
         I+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAHmT/pcpYgzabZuc/D3S28CNtgxEYZt4O5b1uHRwi0=;
        b=H7mrnWvsqPOzvrIylMn+hh6PGUjjg9EcAhd8XBw+vDbVGSChDnJD8S4bjPOdNhHveu
         go+U4/kPI5Zl4uPgcOpSjB9PPYf+PSpDYtNm6TSr0eZkYPE3xw1CDUQg0WT1bE0Cenoo
         7KCjhW7YQDr45RNxHYKbeGJQZwg7rPTpshh5PiZFHbrsW4M+Km7/QkApFR6iHyfeLRIP
         qlj7BocHcZKhSMK2AXx9PvJSroPnpsspFBhfUVdX6LpiJ3CjykNc9wyf6akbwNYhaZER
         PWZNIRcr4RrswHz0GrpMsXyKvWJ+3tBA1rZpYx/NdX3kliCdh6aVTxWoNahIWLrM/S88
         x5nw==
X-Gm-Message-State: AGRZ1gI/6sFf2EIwc8Ypm2R+/2SlzV6Q0h+avAkeU1Ijpv4nDw6H6MHr
        BigedHhcTsGzoxI31lW46c10ad/6HUY=
X-Google-Smtp-Source: AJdET5dHgM31fKl23b6wX8ymvBLIO+JycahY4gm3/5+sW3l7ep/sES3U6XCFITCyrYvhh2A73mRTDQ==
X-Received: by 2002:adf:f748:: with SMTP id z8-v6mr1717408wrp.237.1541593333618;
        Wed, 07 Nov 2018 04:22:13 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y21-v6sm550936wma.36.2018.11.07.04.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 04:22:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/2] range-diff doc: add a section about output stability
Date:   Wed,  7 Nov 2018 12:22:01 +0000
Message-Id: <20181107122202.1813-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet>
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
index f693930fdb..bbd07a9be8 100644
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
+options like `--stat` can as an emergent effect produce output that's
+quite useless in the context of `range-diff`. Future versions of
+`range-diff` may learn to interpret such options in a manner specifc
+to `range-diff` (e.g. for `--stat` summarizing how the diffstat
+changed).
 
 CONFIGURATION
 -------------
-- 
2.19.1.930.g4563a0d9d0

