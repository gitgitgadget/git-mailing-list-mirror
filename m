Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E421F42D
	for <e@80x24.org>; Fri, 25 May 2018 19:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968101AbeEYT2i (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 15:28:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46703 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967998AbeEYT21 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 15:28:27 -0400
Received: by mail-wr0-f195.google.com with SMTP id x9-v6so10940728wrl.13
        for <git@vger.kernel.org>; Fri, 25 May 2018 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jp/w/z9uc5U1Lr9pUGanxu5SIavv2MUg61oEZXFzSRg=;
        b=kGiFJtXncFxW/jOuHNrbDlg/h6RNMZDJJjr2mopQ921qvNRFJOlL1ujSzoytbJMMeS
         5vgzObVQmJY3pAyeAZWV4CnfovPDpokHrk4v5fGXv/qxDO2Oa+kllTNl7Dh9vTrqba/+
         wxt2Wmv1BzA4MSF5kttKxpdYgPocjpXOUydTmCBRsCWa3PHqahAczXJryj5y0gi6iU5N
         WHncCFLellZSsAZ2u7zCdlJdc1mIy2UxUDNpaAPc5OilJQLkn/Y/aH0lvrQE4q5YmXy5
         V8bu0x7Qbmf2dsjPAB28V07364EvvjgV3TmQRzZlrKPpKPnkvBluPPA02PJUo8lOmCoJ
         Cm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jp/w/z9uc5U1Lr9pUGanxu5SIavv2MUg61oEZXFzSRg=;
        b=iQauFeEFeituF3yxDghgQ9YEogUbKRn4GMtQ336FcXnTCQowaXtowGwDhgRfZxz48w
         iBPDuMKjpQtzghq3oi9ZGDiSru+rOOMukEIIxo2gN+f6C4B0i2kDf6PUZn9lwZPPTDuK
         CM1DkcGkni/FMGUfxsHHRzzx6MkmjLEZZO4ion+/s/5+++LsD6HEixD6bwXxl9K43j46
         0FDFdPGG9A4CmE9sN44gUty2yoRC1xWcsHiHKOYEcFGXwhuKwwYvFeGcFjHJ5Etkixm3
         Ku6gMil6hzDS5lsMXatv/QTR5X9b2PzfvwKUcQQvZDdzmCO7FlwL0WeEmsRioscZqicp
         ltkQ==
X-Gm-Message-State: ALKqPweUIU8FhXG8HhFeE26/uVf1XfTIyWlsteNDYKEVyngLxRPKbM1u
        LRmysyvRFVtgn89JZwzFRe9SKjOQ
X-Google-Smtp-Source: AB8JxZqe+VQPiHrFtD6Skc5Pj5c9OKkVmcTuXfaydWP+mRRO1d+R5h8nZwBQMeUBxOsrfDOH0mrYsQ==
X-Received: by 2002:adf:9a54:: with SMTP id z78-v6mr3075863wrb.235.1527276505840;
        Fri, 25 May 2018 12:28:25 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a69-v6sm7276518wma.7.2018.05.25.12.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 May 2018 12:28:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] config doc: elaborate on what transfer.fsckObjects does
Date:   Fri, 25 May 2018 19:28:09 +0000
Message-Id: <20180525192811.25680-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
In-Reply-To: <20180524193516.28713-1-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing documentation led the user to believe that all we were
doing were basic reachability sanity checks, but that hasn't been true
for a very long time. Update the description to match reality, and
note the caveat that there's a quarantine for accepting pushes, but
not for fetching.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af7311e73f..71b3805b4e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3341,8 +3341,16 @@ transfer.fsckObjects::
 	Defaults to false.
 +
 When set, the fetch or receive will abort in the case of a malformed
-object or a broken link. The result of an abort are only dangling
-objects.
+object or a link to a nonexistent object. In addition, various other
+issues are checked for, including legacy issues (see `fsck.<msg-id>`),
+and potential security issues like the existence of a `.GIT` directory
+(see the release notes for v2.2.1 for details). Other sanity and
+security checks may be added in future releases.
++
+On the receiving side, failing fsckObjects will make those objects
+unreachable, see "QUARANTINE ENVIRONMENT" in
+linkgit:git-receive-pack[1]. On the fetch side, malformed objects will
+instead be left unreferenced in the repository.
 
 transfer.hideRefs::
 	String(s) `receive-pack` and `upload-pack` use to decide which
-- 
2.17.0.290.gded63e768a

