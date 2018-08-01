Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3737C1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 15:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389924AbeHARFD (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 13:05:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40032 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389905AbeHARFC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 13:05:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id y9-v6so7500336wma.5
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDZLWABkLSPGkO9RBR/WRPPUeSRVDZ4YquDcB6hixVE=;
        b=Zqc3RlYdqKKp0fkFjXvJxS2JmoQFK+StCvAEp52OzZgpy3S0hOkpWJnwAIYHVWlZ+R
         XP5tQrWZOoaaqLNSR5AZFSJK06ojgePqaSWD7C7xhiLWRiiBbpKEqHb8lFeq3dmUnLe7
         /mTufjxo1OSVUFQY4r5G5wcBi5SuX+4kRhlE8S8eORDJxo04IlZrDTeRUPt+Peu71Pdj
         qx9kyO+SwafJikQahFZRyyUfxBZnvKYBgJhc0g/lgqZnI/rVUHjqH6ABAmoOb0fGfUUd
         B63i0TAhgYTj1LwoEehGeG03K0Nj8wOn9WplSzPO2vViI+uzpdRtNORE5xwZs7tM9nEc
         XYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDZLWABkLSPGkO9RBR/WRPPUeSRVDZ4YquDcB6hixVE=;
        b=bg9IMnYOS5zybNbJSA0eswwJQ2H80djZmnGrwGW+5e5UCgAwwJWWlz8EHNqTHvuzOE
         LeRU8E+suzipIjoAnmdvSzwapWmyeDTPi6q4H+RGTVuI2npPBtPoSRkHaEXBU6P7XMt1
         znJvss1D2ymz6cF/slGxrRfleaYlpAs/z4J1eq21RZHdZLlG+Wo+YB0q2417712bDNPV
         W9uM7DUQKralst0hf5+ZW3BggiGhJrPcdcxMyxD/UVMRbfXVlS/txlZotFz0dHXZwSQi
         9HpNbi6kUeAVH7r9gvATG7+XVuVBYEsn/UZKOEi6Ck76VZiqRS5jPnewf1aOy/sMURmn
         6rAA==
X-Gm-Message-State: AOUpUlEIXND/AFNaeuHWdGCVZXSrKQMJwgKPs0S6/zM3mGM6GkjMEsx9
        msLupuoLeE6qGvo3NBIzoR1y9p2rpeE=
X-Google-Smtp-Source: AAOMgpe4I7YO5ZdNMAVMyJU3pvECb962yQ/3jlEHJshSO+t28qSMVXAqHc4rExLTNi48puZrwaaXbA==
X-Received: by 2002:a1c:a6cc:: with SMTP id p195-v6mr3306193wme.76.1533136729593;
        Wed, 01 Aug 2018 08:18:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 2-v6sm6324008wmi.17.2018.08.01.08.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 08:18:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, jonathantanmy@google.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] fetch doc: cross-link two new negotiation options
Date:   Wed,  1 Aug 2018 15:18:35 +0000
Message-Id: <20180801151835.9182-3-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180731180248.42787-1-jonathantanmy@google.com>
References: <20180731180248.42787-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users interested in the fetch.negotiationAlgorithm variable added in
42cc7485a2 ("negotiator/skipping: skip commits during fetch",
2018-07-16) are probably interested in the related --negotiation-tip
option added in 3390e42adb ("fetch-pack: support negotiation tip
whitelist", 2018-07-02).

Change the documentation for those two to reference one another to
point readers in the right direction.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 2 ++
 Documentation/fetch-options.txt | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 84f73d7458..dc55ff17e0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1540,6 +1540,8 @@ fetch.negotiationAlgorithm::
 	that never skips commits (unless the server has acknowledged it or one
 	of its descendants).
 	Unknown values will cause 'git fetch' to error out.
++
+See also the `--negotiation-tip` option for linkgit:git-fetch[1].
 
 format.attach::
 	Enable multipart/mixed attachments as the default for
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 2d09f87b4b..8bc36af4b1 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -57,6 +57,9 @@ commits reachable from any of the given commits.
 The argument to this option may be a glob on ref names, a ref, or the (possibly
 abbreviated) SHA-1 of a commit. Specifying a glob is equivalent to specifying
 this option multiple times, one for each matching ref name.
++
+See also the `fetch.negotiationAlgorithm` configuration variable
+documented in linkgit:git-config[1].
 
 ifndef::git-pull[]
 --dry-run::
-- 
2.18.0.345.g5c9ce644c3

