Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B360E20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfCHJ7D (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:59:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37132 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfCHJ7D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:59:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so13790551pfh.4
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/3vakiw3dAK9/+RV31GV2kESWmKryGtj4oIc3e0SBo=;
        b=nOwEFNyHx2jMawME14fjLS3Rx/NPnxRH8z3nIWAPXl2jyDmD2m9zpZD7e0xbLrsIei
         R9fS5HwyHaUZtibIm/AVaIOlWhTsQ75hRR7/uxT0OVaRpEvNK0IyWzK2bNU0FvdRxeoi
         iT9UQXXefff7GSPGdEV4Gk6ga0mUM/MPHbQ+CGh+41u8ZmE22nHzaF/z5RKMDqXZh0cr
         J3BCq9Fx1AJfLuwofFZv7Pw1OSReTDg+j1r5Ov+34MuN++A0d4tXAkHZv8FsWLAQiRrb
         wUIqESwfj//BJh7bV25ZRivSamIJPDu9PumlG0Q3ihE9AO5iYQobPXizpHCo6RZ38mEK
         1c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/3vakiw3dAK9/+RV31GV2kESWmKryGtj4oIc3e0SBo=;
        b=c7XulH/DfTATc1gXPkJyXSrIa/f8CVQHsGWgv0OK9sAhdIWlMWRgqUGyGW6KvNjIF+
         c0rei+nNzvPCAa+ZUu4rPEHEjsVoCk+l19J3Z/BbqTBCxOZ5shhZUSnOexU2ZBOQcFQC
         yef0/SIKSvq36M/fc4ohXBBU9O+1p2gDIFZLpIdbo8p8v/6ZT8S0pqVmwWPG5XYmMMrW
         xg417sflsNrovnGBsXSNV7GVHRKZVIzke4IJWXmVPN+pJWULEOZXXbjS97aFfNC5m6Uw
         LrG5Z4IWhqxOGPGpDVgtOLhYQ73cSdiQsRQe7fJIeEbCnFTEJSxhRXuLzJkMv9kbQHNc
         D21w==
X-Gm-Message-State: APjAAAXzGRHLb68qYpHql24U039CN1/hFTfhJmXKKNOozVbiEgcZKTNg
        xne24FuGUbzxsTI3AqgHkKI=
X-Google-Smtp-Source: APXvYqy3nNDtkc4VWk50vkQ4Fwfg7Ybk2bkZzc/mWdJr/QKOpAn71B8Kd9l/A2Llp+sVhQJpGAhSIA==
X-Received: by 2002:a63:c00c:: with SMTP id h12mr15916879pgg.423.1552039142705;
        Fri, 08 Mar 2019 01:59:02 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id d16sm9732453pfo.112.2019.03.08.01.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:59:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:58:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 12/21] switch: remove -l
Date:   Fri,  8 Mar 2019 16:57:43 +0700
Message-Id: <20190308095752.8574-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is ancient. Nowadays reflog is enabled by default and
automatically created for new branches. Keep it in git-checkout only.
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4c3f0f6ac7..a731f983c4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1372,7 +1372,6 @@ static struct option *add_common_switch_branch_options(
 	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
@@ -1573,6 +1572,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
+		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
 		OPT_END()
 	};
 	int ret;
-- 
2.21.0.rc1.337.gdf7f8d0522

