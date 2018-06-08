Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3C1B1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeFHWmD (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38002 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbeFHWmB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so6249891wmf.3
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owxwpJHq2zmv23Q0XwM58yS+KlTrBZKbtW2v4aoIYGQ=;
        b=WVLnL37Bo2xmHmnelcvMAAk+LlO/H0PpTD3A4VU8DZOUd+pmcpSuWlAUPNDwf/SSw4
         6hHnJhB+54T02Z3D6BL4OyVk18lyYCxy7/K/8foZVegYOI/lhsOxVa1hWjrakq5JuxvH
         XpzEma60DPLzs5YAgJFBSOeJS7Elv2kJOO1yoeHL3R7SvkdxnPJ/jR62vSCwOayHf8Zx
         cz1ta2A6W3BKutxgnoF3X1kjKnyfU+E+nXpPmdzFlBT0UlDylTILBE5pKlyxCCdTROK9
         Ild4Z7YkgKlt/ErGBBZR53y8UiKxEJdOSV9TWqY9rmePAqMiQWuJSaBXxbYV5LG3PGz6
         SnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owxwpJHq2zmv23Q0XwM58yS+KlTrBZKbtW2v4aoIYGQ=;
        b=YX0vXNPBuSOBE9334045SE+JCG7moVSKxPjgOeLj7Q3GEt3/JIRXr2q/s/jB03QqvF
         k4E0q/nHzbYKpOV23rbGuF4GEPhpgK5i/s/2gyzBxBx54t5qWYo4aHpZ9AMghI8mqoIV
         tylnfvNYOHHXT21ke3Dta9EXelhXKL4UNtDfGsYjLPB9a+ksR1yHNSJd6RDEtStast9E
         qPajuI41d8oxDNtvwzEncZMz4r5MojNtQ434c+yEvvK4NcPmQgGrUSI+7qYxHLSzOweI
         Hww4MP9cRdNws6kYvsqUm4Brs/YHoYD95HAdVayz8gNc4LYQ8UK1jWwoY7PudmOpu7Hu
         9M0A==
X-Gm-Message-State: APt69E2zdWjgdXQKCBFFpxaeaRJ+o8K2O5dFP5CzH+TgxPD31hwmq0hQ
        FPMQ9Qt/zT4udLP5lN1qULRZgE/i
X-Google-Smtp-Source: ADUXVKKObXNVCb247NfmqjNOgN3FTGUbXQlnsSk/mM8ofssFXrqRJGlagHkwo7qhD+AKS8LmS457iA==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr2741675wmd.133.1528497719688;
        Fri, 08 Jun 2018 15:41:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:41:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/20] abbrev tests: test "git branch" behavior
Date:   Fri,  8 Jun 2018 22:41:23 +0000
Message-Id: <20180608224136.20220-8-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0014-abbrev.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
index 934c54a96b..d8b060d922 100755
--- a/t/t0014-abbrev.sh
+++ b/t/t0014-abbrev.sh
@@ -168,4 +168,14 @@ do
 	"
 done
 
+for i in $(test_seq 4 40)
+do
+	test_expect_success "branch core.abbrev=$i and --abbrev=$i" "
+		git -c core.abbrev=$i branch -v | cut_tr_d_n_field_n 3 >branch &&
+		test_byte_count = $i branch &&
+		git branch --abbrev=$i -v | cut_tr_d_n_field_n 3 >branch &&
+		test_byte_count = $i branch
+	"
+done
+
 test_done
-- 
2.17.0.290.gded63e768a

