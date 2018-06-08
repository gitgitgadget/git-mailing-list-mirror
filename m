Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87371F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeFHWmk (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39782 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753247AbeFHWmF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so6242196wmc.4
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/VelICxfAJLo9jH0LnhAPrwVUbfkO0bkW4Jg47TUfp8=;
        b=fxjKZItbYqXOWyGjvqFxD97ei6o8jT0aQRfsPTbCe028qnTrwhM+TNTc0Xvo1sIDzl
         kInt2BxLtE9RAIZ+/ybUCtMe9SXgZSuBr94xhVkLgJ7Uumgix6InIWzUczcAkUKm77Bn
         gC1KNJ92dQhu+F8Y+zMMC7lKmr2BluRxsdCIwhtEDj+WJOLpNJWanzlLquYMXwstQjPD
         //Rh2gbom8d+zpUkp5iNIhQQDa/NhIWkBURkCT3FBD6FgnaoPepdXPgCn+Yxx3QcNvwh
         f/YjZ9cO9RmP+OAJ6Lkqwd9c9gpYPUptGhAgtOuF77bEJIZT1ErEMjLhRkIIYFpBAgrJ
         INTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VelICxfAJLo9jH0LnhAPrwVUbfkO0bkW4Jg47TUfp8=;
        b=V4U8c70azPOX7n0dSL6OMWbjNQAbO+yy7YmHDxhGgupRlnyquy/nVKnqblfRWA6uzo
         yENXzqv/DjnOHQtT4rvAldCp4u73XY93yS1tsGkLWjKpyJapywDCx2WeEqz7QIPPbRJM
         V4I7J5GG4Zwd8repoOCwqRpv6BY4DCwVQsoj25G0Y3RSpQ9BESWpDbmUlhoMHTOrlIph
         KQRaEhVntCU3NCFJc7v6d1Mg/yxKrmTEz8DjyzjcGAE1BPp99EAijzbALNcjUqErXVkD
         il91YQiBCJ/Pj2RyWXl32A+zIEptUIJQKG4nNmfq/gpqOrxTGXpn1//1Yn15ibhRC5ph
         veRA==
X-Gm-Message-State: APt69E1i+mMMK4TtX7K2JtLtr5hFQlZ1nN00RzL9M7s0bbPhfAUZnSu6
        pHTtO7heXKrMsmmm2/IZ9tOHaiEt
X-Google-Smtp-Source: ADUXVKJWn+dIokOuNuZpuDgmxSGS+KizZ81A3w+IGym1l4KAW1PnyGDVnTsO5TalZQ+SJiB7rQW0iA==
X-Received: by 2002:a1c:6803:: with SMTP id d3-v6mr2856714wmc.70.1528497724341;
        Fri, 08 Jun 2018 15:42:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/20] abbrev tests: test for plumbing behavior
Date:   Fri,  8 Jun 2018 22:41:27 +0000
Message-Id: <20180608224136.20220-12-avarab@gmail.com>
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

The "git-{ls-files,ls-tree,show-ref}" commands all have in common that
the core.abbrev variable is ignored, and only --abbrev works. This is
intentional since these are all plumbing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0014-abbrev.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
index 783807475f..5a99cbe434 100755
--- a/t/t0014-abbrev.sh
+++ b/t/t0014-abbrev.sh
@@ -244,4 +244,36 @@ do
 	"
 done
 
+for i in $(test_seq 4 40)
+do
+	test_expect_success "ls-files core.abbrev=$i and --abbrev=$i" "
+		git -c core.abbrev=$i ls-files --stage A.t | cut_tr_d_n_field_n 2 >ls-files &&
+		test_byte_count = 40 ls-files &&
+		git ls-files --abbrev=$i --stage A.t | cut_tr_d_n_field_n 2 >ls-files &&
+		test_byte_count = $i ls-files
+	"
+done
+
+for i in $(test_seq 4 40)
+do
+	test_expect_success "ls-tree core.abbrev=$i and --abbrev=$i" "
+		git -c core.abbrev=$i ls-tree HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
+		test_byte_count = 40 ls-tree &&
+		git ls-tree --abbrev=$i HEAD A.t | cut -f 1 | cut_tr_d_n_field_n 3 >ls-tree &&
+		test_byte_count = $i ls-tree
+	"
+done
+
+for i in $(test_seq 4 40)
+do
+	test_expect_success "show-ref core.abbrev=$i and --abbrev=$i" "
+		git -c core.abbrev=$i show-ref --hash refs/heads/master | tr_d_n >show-ref &&
+		test_byte_count = 40 show-ref &&
+		git show-ref --hash --abbrev=$i refs/heads/master | tr_d_n >show-ref &&
+		test_byte_count = $i show-ref &&
+		git show-ref --hash=$i refs/heads/master | tr_d_n >show-ref &&
+		test_byte_count = $i show-ref
+	"
+done
+
 test_done
-- 
2.17.0.290.gded63e768a

