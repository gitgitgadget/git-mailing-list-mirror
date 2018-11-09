Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFD11F453
	for <e@80x24.org>; Fri,  9 Nov 2018 10:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeKIT6O (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 14:58:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39507 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKIT6O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 14:58:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id b13so1267857wrx.6
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 02:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+nUIoM+0aHiMZhJpgNsCn4eCKjDIuAVir5KDwfCs6Y=;
        b=VihBJLzT0IHdo28E9mvZ+WHi2W1DQqB9MLr2ckdGmt7im0RoU2vXdoqztxlg3UlPy/
         wAwnpMZNhbEXFSkU0QJEoNidAKpdHo5DdoKzcVE9yLclOw+dss6mhbGcsEZUzcSExln/
         CrpPvtiwMt6Jh4VpVY9UCE9RPOoBy3/f33esy/1l/jE8knmE+CgBz6/6/qb6TNS9Uv0s
         LdmGQ4ufGLIy3KaZ/r7/GV2le0YYEFjpkFk/0BfGtg0Xt1IUSV/HcpNjeAWJB/KJHZGF
         63bmudMGXVNs0w0R6e8/IEhi8PptqeANfv4t5+ho9GFvHQuxNO8WHHszfswPB39U0wRE
         vmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+nUIoM+0aHiMZhJpgNsCn4eCKjDIuAVir5KDwfCs6Y=;
        b=puh2mQ+ubVU/cy5p4fmRvwIR7BTZ47lwUsRrYRejIRiI4oqjFyBeNxS6ctLvgXS6pg
         QsX3pVNaJYQnN6uWJsDUS1E8FpBpG5y4ZcCKYSfa9buWwBAApTkkYC4z41pYLgf5Wsnm
         g15ZI60HKAHJzGKG8qEpH1Ct68Y3a7cKkoHy66NdZcs+gBaFsdJOOcY1BG1sZWSE4lez
         jZ+/Vk4/wPGlmFos4Ic9FflaHeGRmXmYPxjKGjPEuPXLcGo6+PHvYkIduwOyZICJf7t0
         Xb88NDXGAimcaIdO5Mfy4/XdUxkFu+VFSczeJ/2Qw1oXlPV9e8g4+L6bEo3AsdVJ7jQM
         Lwkw==
X-Gm-Message-State: AGRZ1gL3Tx4Pscrmd1db/PZbJpHaboTVrp3AdmeGjPgsjg2uiHqBoKcZ
        vXLO/c6ZJ6nQuceS2Uf/8E9AQKSvQRk=
X-Google-Smtp-Source: AJdET5fs8lY5JO5DadnizpqBT3GhVnHw2hXz9fr6rEhMmF9rFq2Ardch0X81KIldFX24TNFefmlGdw==
X-Received: by 2002:adf:da41:: with SMTP id r1-v6mr5307211wrl.129.1541758697193;
        Fri, 09 Nov 2018 02:18:17 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h4-v6sm5662020wrt.76.2018.11.09.02.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 02:18:16 -0800 (PST)
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
Subject: [PATCH v4 1/3] range-diff doc: add a section about output stability
Date:   Fri,  9 Nov 2018 10:18:01 +0000
Message-Id: <20181109101803.3038-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181107122202.1813-3-avarab@gmail.com>
References: <20181107122202.1813-3-avarab@gmail.com>
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

