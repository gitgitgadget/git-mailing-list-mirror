Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0891F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbeFHWml (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40444 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeFHWmC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id n5-v6so6228538wmc.5
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4fQkB37GuNhTcJKM39yBHjzVc7ahTZkfvE8uqOAogY=;
        b=PrR3oSaMGWej9BosPNFrI4u0ifYU7zEzpvfc58+qWTGbf51CNUDc/FVd2kvkRXtrxE
         V+3vddnN9Vra4+sLI3p7td7J4kb/umOq7hbND4ez5SiCbaYI2CkTQGNu3O+e5fFdOyG0
         vF+OktOcLmfefEM65kESstIlAohSXPq9tOLzBc4wAKxw5C55JcRweYfazWG7oCjjR/Ge
         JY2NBD9qTYmO/GcP5PMnBb+DgwIu6A6a2Qp+TtqmJl+wDOzqKPfOf/zJwEvdrKi5uejN
         G+4seXyvOekdQZNAnDv7ST5qfG51vpeKUpWB+Jv6MkPMmH68LIK2y/Jymj67/q6/IQoJ
         gqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4fQkB37GuNhTcJKM39yBHjzVc7ahTZkfvE8uqOAogY=;
        b=QolMqooujISX7/uAFjKOlELPvL5mArmJAtLmQIDue1njRut45F0z3PlgqvBjiFHVR7
         gsSdBy3JVK6RnH6VOKM+YPBsy+2oj74CERBuAwL9MuKdcOQLNtE1+KvFuxRyFMyusXut
         BU+kdLeAgYXGw+Ng/0iwc76URLBKGBTUytFqZh4PeoOslXRpwqDK1v7sUtSBmsm8nYu/
         YJra2xIymzNYftM18a6iWCJthePrgRrSFDTxqDu3yWyJJdGuq3isJFmY+HnKjfqs/YWQ
         8q+Ev0H8YZRIUfh1/bmWp6uub90ywIp6sZS/GVC0O3wHz2vm2VAdtKJioNTEHX94+ZM5
         Pncg==
X-Gm-Message-State: APt69E0cCy5ITGyjtgcm42wKZs8eBgnf7QPCLTI5f9l4kQoLL+p8I6iP
        pgHzGA9t7TKodwkjVnSQt7pjd9F7
X-Google-Smtp-Source: ADUXVKKVutO8gOJxx+bm4KvlWLTisPpCbmTPQNcjiaaV7K02yWPAuR2EJnsP0lyWl+U2+FwDswItQQ==
X-Received: by 2002:a1c:168c:: with SMTP id 134-v6mr2679963wmw.53.1528497720840;
        Fri, 08 Jun 2018 15:42:00 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/20] abbrev tests: test for "git-describe" behavior
Date:   Fri,  8 Jun 2018 22:41:24 +0000
Message-Id: <20180608224136.20220-9-avarab@gmail.com>
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

The only thing out of the ordinary with git-describe is the --abbrev=0
special-case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0014-abbrev.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
index d8b060d922..645bcca1d1 100755
--- a/t/t0014-abbrev.sh
+++ b/t/t0014-abbrev.sh
@@ -16,6 +16,10 @@ nocaret() {
 	sed 's/\^//'
 }
 
+sed_g_tr_d_n() {
+	sed 's/.*g//' | tr_d_n
+}
+
 test_expect_success 'setup' '
 	test_commit A &&
 	git tag -a -mannotated A.annotated &&
@@ -178,4 +182,25 @@ do
 	"
 done
 
+test_expect_success 'describe core.abbrev and --abbrev special cases' '
+	# core.abbrev=0 behaves as usual...
+	test_must_fail git -c core.abbrev=0 describe &&
+
+	# ...but --abbrev=0 is special-cased to print the nearest tag,
+	# not fall back on "4" like git-log.
+	echo A.annotated >expected &&
+	git describe --abbrev=0 >actual &&
+	test_cmp expected actual
+'
+
+for i in $(test_seq 4 40)
+do
+	test_expect_success "describe core.abbrev=$i and --abbrev=$i" "
+		git -c core.abbrev=$i describe | sed_g_tr_d_n >describe &&
+		test_byte_count = $i describe &&
+		git describe --abbrev=$i | sed_g_tr_d_n >describe &&
+		test_byte_count = $i describe
+	"
+done
+
 test_done
-- 
2.17.0.290.gded63e768a

