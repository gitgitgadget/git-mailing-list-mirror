Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3801F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeFHWmy (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55851 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbeFHWl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:41:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so5723011wmh.5
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQuWJeuo25Zr6NFcvNNcfaZSY2FzwG/kwFrjdbiWLg8=;
        b=hfj0b8kiqMZ1zKuhHCS9FJZkYeobVmh/j0qewOpIGpJ6ZQUBdNUcHOUowj5tQNTAkT
         +aClyjjYM+lpBtf6Lb/YV3OZTKNo7cjWVPYEx3pRIC3v1C5WZDCKKBAy3/z0IUjDAP3/
         BKCb2JwbBMMBR7i9Chu3O2W07R254iHJClQmSVsE8tz0sRXSFVRL/l08ym2Wb6PAvrII
         B0NTMI2SBIiqhEcMEE4SuY4sSDNhQFbSOC4J3GbJiTKbkjdELRqF5M2BHZeUleS/w3DS
         +woNv+gfbx/I99cnmn/64vCrWLY16u+dbTeGuaM+HLXefMl78d1++qoeDjNFgUVp59/T
         jw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQuWJeuo25Zr6NFcvNNcfaZSY2FzwG/kwFrjdbiWLg8=;
        b=SuFzVi65UOSf/Q0yTv8+7QajHwoQpn8grePNLx9l/y28VDtJK7jIbfzYHCYccqJ6Ix
         2sq8PeHP0ivns0oJuezCFexa2QyCJ7kefBuplege3cjzocWpNcI7SVwlgQFRlVUN++8Q
         9x3vepavPd1ww2W1UMrN7rflskdgcyfERNJ9hZ3ucb4W+wEpp2AWvlFd/m8xl0GtsRxY
         MMncmAEJXxYywgTpb/Bzz7uhXyqOQII0i5W48o9PK7JnVVuj/Vfixe++ww8GMiGqa6Q/
         pkHyZ3DEriE242uRlJtsmVgp5J2CWeJxpUIaOgYZQAjln9DaYmY6ke6melq0Fr0Ppp26
         YcsA==
X-Gm-Message-State: APt69E2lGL2I2X6p4eHDO12Lbji8eHqQwCpbTHuztzpIbAq3UA9+NoQq
        z6+uRoXUrHVEX+JwxsH6v/ZlUnP9
X-Google-Smtp-Source: ADUXVKIkToIcNd5Gso6pioYb+mwKEPmliJny++yTflpKcF+5XNzB2CNUCup0dimLRIwPW9ZS5uQWNA==
X-Received: by 2002:a1c:b484:: with SMTP id d126-v6mr2677658wmf.0.1528497717209;
        Fri, 08 Jun 2018 15:41:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:41:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/20] abbrev tests: test "git-blame" behavior
Date:   Fri,  8 Jun 2018 22:41:21 +0000
Message-Id: <20180608224136.20220-6-avarab@gmail.com>
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

Add tests showing how "git-blame" behaves. As noted in an earlier
change there's a behavior difference between core.abbrev=40 and
--abbrev=40.

Let's also assert that neither way of changing the abbreviation length
modifies the porcelain output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0014-abbrev.sh | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
index 1c60f5ff93..77f15d5b0b 100755
--- a/t/t0014-abbrev.sh
+++ b/t/t0014-abbrev.sh
@@ -12,6 +12,10 @@ cut_tr_d_n_field_n() {
 	cut -d " " -f $1 | tr_d_n
 }
 
+nocaret() {
+	sed 's/\^//'
+}
+
 test_expect_success 'setup' '
 	test_commit A &&
 	git tag -a -mannotated A.annotated &&
@@ -115,4 +119,48 @@ do
 	"
 done
 
+for i in $(test_seq 4 40)
+do
+	for opt in --porcelain --line-porcelain
+	do
+		test_expect_success "blame $opt ignores core.abbrev=$i and --abbrev=$i" "
+			git -c core.abbrev=$i blame $opt A.t | head -n 1 | cut_tr_d_n_field_n 1 >blame &&
+			test_byte_count = 40 blame &&
+			git blame $opt --abbrev=$i A.t | head -n 1 | cut_tr_d_n_field_n 1 >blame &&
+			test_byte_count = 40 blame
+		"
+	done
+
+
+	test_expect_success "blame core.abbrev=$i and --abbrev=$i with boundary" "
+		# See the blame documentation for why this is off-by-one
+		git -c core.abbrev=$i blame A.t | cut_tr_d_n_field_n 1 | nocaret >blame &&
+		test_byte_count = $i blame &&
+		git blame --abbrev=$i A.t | cut_tr_d_n_field_n 1 | nocaret >blame &&
+		if test $i -eq 40
+		then
+			test_byte_count = 39 blame
+		else
+			test_byte_count = $i blame
+		fi
+	"
+
+	test_expect_success "blame core.abbrev=$i and --abbrev=$i without boundary" "
+		git -c core.abbrev=$i blame B.t | cut_tr_d_n_field_n 1 | nocaret >blame &&
+		if test $i -eq 40
+		then
+			test_byte_count = $i blame
+		else
+			test_byte_count = \$(($i + 1)) blame
+		fi &&
+		git blame --abbrev=$i B.t | cut_tr_d_n_field_n 1 | nocaret >blame &&
+		if test $i -eq 40
+		then
+			test_byte_count = $i blame
+		else
+			test_byte_count = \$(($i + 1)) blame
+		fi
+	"
+done
+
 test_done
-- 
2.17.0.290.gded63e768a

