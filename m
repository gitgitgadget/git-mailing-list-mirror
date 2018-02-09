Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612461F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeBIUcw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:32:52 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37667 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeBIUcu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:50 -0500
Received: by mail-wr0-f195.google.com with SMTP id k32so2967960wrk.4
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=H2ky4/zyJdp/1HOFHBkgk1fnsJrt6y6l6cHnKMNfxtk=;
        b=MG77ivb1dmDC78auvFkvog/0Vv0SddIFTqc8V5JWT2GOlUD5JWgXDGQx3LSC5TaADE
         zoIF1XKc5DO2KU1BkxwXkaKGBZQ6GFf55rwtIjZy70TIke+7PDXgC/X4evh4y+/Mjgrm
         a3xStYz5aTuT8w5NlUQjlEQaBIjkSMKnHsbl0LVtgXZNCnQUa4KzpWNfadUDZjowgPlQ
         qlJjEmDmPxnHNVoVZ/lpvE7v88/H0riTWr1ohQe8HJTNAhjPc1Rg0c0JptFsRC0W0GTN
         B6mn9TiRa22vo7EGDiznLgPgTYuC8/v1pitwNqbsJwR9fe9JLn0F2K8JkOQhdob9MSdJ
         N5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H2ky4/zyJdp/1HOFHBkgk1fnsJrt6y6l6cHnKMNfxtk=;
        b=NxwKe0GnaCW+8uRwJIGK66VEcCncXxa0XBgoz0DuSN/droMyvI9JhAY0qu77qVAYBh
         GegriunwlLL8MtSmp5WxC0r9kjCmkSZrTlTaiEV20Qhwgu9xukThuAlEiN7ip5/bdQFv
         vg6iy/oe9ds9EOSMp9bEknMOQw778azhezpttRtOTKaOd6qVN0Bqf151W3Kdo5a8BZv6
         ql9yaK/WSq4UYmKBo2kv5PQwdVksm2oKFhL6Y7GVbc5r31J95OvfD2vjkinWPzrUE5v8
         GrrqGeSo5HWVXA41ahCNx+5Vvccy2Jum5MK+5Dy7G2GpovALdlenprBB3Aewuqayk+PC
         le9A==
X-Gm-Message-State: APf1xPBKtsAe4WV4i9+GwHCc2AVOCJ+QV/qI2mfthNZBUeJUhQusmPsF
        Ikf4Mj20WAtrE0nu6FNVYU/owVcr
X-Google-Smtp-Source: AH8x225bxmpEu+jXjJvoPDNTJw8hG/JH1mZD5LbSsYc9KFAs3izsXodFWGyJG0146JKllEZm4x394Q==
X-Received: by 10.223.129.202 with SMTP id 68mr3847815wra.4.1518208368614;
        Fri, 09 Feb 2018 12:32:48 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/17] fetch tests: test --prune and refspec interaction
Date:   Fri,  9 Feb 2018 20:32:07 +0000
Message-Id: <20180209203216.11560-9-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the interaction between explicitly provided refspecs
and fetch.prune.

There's no point in adding this boilerplate to every combination of
unset/false/true, it's instructive and sufficient to show that no
matter if the variable is unset, false or true the refspec on the
command-line overrides any configuration variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index fad65bd885..dacdb8759c 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -609,6 +609,10 @@ test_configured_prune () {
 test_configured_prune unset unset kept   kept   ""
 test_configured_prune unset unset kept   kept   "--no-prune"
 test_configured_prune unset unset pruned kept   "--prune"
+test_configured_prune unset unset kept   pruned \
+	"--prune origin refs/tags/*:refs/tags/*"
+test_configured_prune unset unset pruned pruned \
+	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 test_configured_prune false unset kept   kept   ""
 test_configured_prune false unset kept   kept   "--no-prune"
@@ -625,6 +629,10 @@ test_configured_prune unset false pruned kept   "--prune"
 test_configured_prune false false kept   kept   ""
 test_configured_prune false false kept   kept   "--no-prune"
 test_configured_prune false false pruned kept   "--prune"
+test_configured_prune false false kept   pruned \
+	"--prune origin refs/tags/*:refs/tags/*"
+test_configured_prune false false pruned pruned \
+	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 test_configured_prune true  false kept   kept   ""
 test_configured_prune true  false pruned kept   "--prune"
@@ -641,6 +649,10 @@ test_configured_prune false true  pruned kept   "--prune"
 test_configured_prune true  true  pruned kept   ""
 test_configured_prune true  true  pruned kept   "--prune"
 test_configured_prune true  true  kept   kept   "--no-prune"
+test_configured_prune true  true  kept   pruned \
+	"--prune origin refs/tags/*:refs/tags/*"
+test_configured_prune true  true  pruned pruned \
+	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.15.1.424.g9478a66081

