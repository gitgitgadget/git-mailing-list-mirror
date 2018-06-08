Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC2D1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbeFHWmH (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54537 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753225AbeFHWmD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id o13-v6so5695199wmf.4
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qHgsM16Pf6WHuFJflnnW2gkk1K5WKTGD7ev3tx9eR5I=;
        b=M9LSETDoBcPeu2Ossau8oPSCp7MMqb+GPgFkNI3ZydzFxeril3VsiW/j6yA2obhuJb
         eb54IpRZ6OTebtKwWwUPBR5yd1sgRkT7xQQs/rjrkc3ac3QsoJLd53Fxwxx9UGQJwiIL
         JGUUjQlMeVarw37w1g3aLC+j7WEbNy7TfcA49YNpFLmS6XI0puawDQ3pSImLyl8k7Ron
         50kXBTojjQ6mVICaOPXsjkq5Cy3nAip3dhGxL/PzMFi5lVf/izC9pt96Qbwt5HXXbWe/
         Vcz5DYIRJ9FirnBIyRsye0hGeoJ5wC2lstLQFyRkBekGrE2vh46o0w1nV9DfmDEQxcdy
         ZbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qHgsM16Pf6WHuFJflnnW2gkk1K5WKTGD7ev3tx9eR5I=;
        b=Jr7a1FaGPZCiEIFrNCkfBpX/PTzHCDbR8BThIg+bfZNoQdfJ8c49gVBtXWKMWhO/Zo
         Wz9VBUwQ0btJVeIH5iixNRdQR707lJ+r20PogfuqJHSv64ZFEOMVCuz9err7ygfZv0gD
         7RjcYN/ox+M/77DJ0F/bFo6nBX6NGy/WHFxYtkeF8jdHgqXTqWhrsZXleb2XDnCcDBWq
         plHRBGNZ716FwWcqo962U2P1XMk+inpOv7lEsc2pDQprTeEcmk765Y04o8tbImUaGUt1
         LQcyJbumuchapb+zrhNIGQrNpwpXUrfZRJ3SsQA11z1aPWmZHyzxa2U6J7ekyWh9i+ei
         AzdA==
X-Gm-Message-State: APt69E0pwjedVzQASQdp7cd5NytF4vhE6UC9B1J9N0UvCFlL0Rg5+pea
        psrhzU/A4wEQSg8TKWAtaODpeBhv
X-Google-Smtp-Source: ADUXVKJkP6v4gSVrTYt8E9oGUUQ/TKxgDd5v1hVBAr4IeMfFlAgrV8S7unjaqmN38yrlvooCkwoaqg==
X-Received: by 2002:a1c:42d7:: with SMTP id k84-v6mr2558536wmi.159.1528497722023;
        Fri, 08 Jun 2018 15:42:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/20] abbrev tests: test for "git-log" behavior
Date:   Fri,  8 Jun 2018 22:41:25 +0000
Message-Id: <20180608224136.20220-10-avarab@gmail.com>
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

The "log" family of commands does its own parsing for --abbrev in
revision.c, so having dedicated tests for it makes sense.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0014-abbrev.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
index 645bcca1d1..a66051c040 100755
--- a/t/t0014-abbrev.sh
+++ b/t/t0014-abbrev.sh
@@ -203,4 +203,14 @@ do
 	"
 done
 
+for i in $(test_seq 4 40)
+do
+	test_expect_success "log core.abbrev=$i and --abbrev=$i" "
+		git -c core.abbrev=$i log --pretty=format:%h -1 | tr_d_n >log &&
+		test_byte_count = $i log &&
+		git log --abbrev=$i --pretty=format:%h -1 | tr_d_n >log &&
+		test_byte_count = $i log
+	"
+done
+
 test_done
-- 
2.17.0.290.gded63e768a

