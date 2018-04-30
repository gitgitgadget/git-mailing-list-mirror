Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D3C215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755166AbeD3WIN (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:08:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51353 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755086AbeD3WIK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:08:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id j4so15534109wme.1
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gfke0ZrISNngvgmy4mIcNY/504/KohfTd2vBl18E6e0=;
        b=gPHcOzz3RU8do/MDMyGtDIhVRnBsCNYpGBPPyABqotJGeaexoIQ7/jMVWT1ybxojUd
         o51aJS6pA+Pt6nMSN0kGF7sObUqyMRLoueSotU9kegtWU5SKU9w4hdb0j3RTfbXRoLK4
         +xuQjUryNydC4vq1I0IkjlwSrRnZ5s4ddxJqpSPnZDyAoQEOFLQQwqOdvpZlxIh/HLaA
         rNE34CPBuObMhe4tFVd/SLhpXt5Smkf+Rwhjh8jxGgtaxbAwfPsAPs1l19zstUXkQ0iE
         HAMaqwg4RLMrgV/xEujaxy9cxaOcCk0EyqKH4G2bP5D04SLLDEpa3gIjS2EKNJacrw1Y
         BygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gfke0ZrISNngvgmy4mIcNY/504/KohfTd2vBl18E6e0=;
        b=OWGsb6/MFOdAzkOXoq8Ak/gRpY2VgaNtjtESeAgku10N9y12r/3nfyYRErJrEcMgzF
         QDKSAUB/1z/JkWEEVe6dmBUpZo219xccbm2RKQDR38HRIhe/vBRwyEPyEZiHHaNkEhZM
         QZoIuJkqjWBZgekI0er6qTX5ZO2afIVHBEjH/erH+5uVEbSHaXDvGVoL2rmLdrSXoO+D
         gTAXTqws6KxdgIkZX+7mODFmkPV7evHPD52FJDWsCmQfaeQ2rxqi6Hjp0QTq+ojs+/0I
         QK/MLkhXLLftMdteNSn83YdwXScT58IbfSsuohE/8hQwQwgOKohLbcVhQV/f7oj5uu/W
         5AEw==
X-Gm-Message-State: ALQs6tDV7acZPNyopXNYXniKuim35ysMYUnWq7lC1FFsBGXuUmmX63Oo
        UrR6lfu6+1TqGEqodmFmGL7ra7aP
X-Google-Smtp-Source: AB8JxZrMcGT0wxEgjjVXYkyBSTUH6iWlU5YdZiSrJabztMYXpB3Y4+jc8goKeeEn42VopbRNQAcK9g==
X-Received: by 10.28.109.151 with SMTP id b23mr8761087wmi.86.1525126088703;
        Mon, 30 Apr 2018 15:08:08 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l53-v6sm24014633wrc.80.2018.04.30.15.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 15:08:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 9/9] config doc: document core.disambiguate
Date:   Mon, 30 Apr 2018 22:07:34 +0000
Message-Id: <20180430220734.30133-10-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core.disambiguate variable was added in
5b33cb1fd7 ("get_short_sha1: make default disambiguation
configurable", 2016-09-27) but never documented.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..6fee67c12d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -910,6 +910,20 @@ core.abbrev::
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
 
+core.disambiguate::
+	If Git is given a SHA-1 that's ambigous it'll suggest what
+	objects you might mean. By default it'll print out all
+	potential objects with that prefix regardless of their
+	type. This setting, along with the `^{<type>}` peel syntax
+	(see linkgit:gitrevisions[7]), allows for narrowing that down.
+
++
+Is set to `none` by default, can also be `commit` (peel syntax:
+`$sha1^{commit}`), `commitish` (commits and tags), `tree` (peel:
+`$sha1^{tree}`), `treeish` (everything except blobs), `blob` (peel:
+`$sha1^{blob}`) or `tag` (peel: `$sha1^{tag}`). The peel syntax will
+override any config value.
+
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
 	Tells 'git add' to continue adding files when some files cannot be
-- 
2.17.0.290.gded63e768a

