Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795091F462
	for <e@80x24.org>; Tue, 21 May 2019 17:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfEURuY (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 13:50:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35706 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfEURuW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 13:50:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so30689917edr.2
        for <git@vger.kernel.org>; Tue, 21 May 2019 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CYXLfruxX9xahrZuMhbh7ZEw2pmkRyjITmjyZ4jRIC4=;
        b=MLJPxT3d5YGgri4y2I70nmXxuVlNgQIRURRsiC3CnFgvnX2UbOsjcTTAbktA7aXPY9
         v/zo6hch7+X/K70BpQdWs4kDdMbE3WMuan/zOQw4gJT8eZqAaqZlk9GPZOUy58eGaTsv
         lnEgHYieg2MeCudLz4vQtw8gqIM7jiNOWIdGIfpi4iFsGoC2l0Svl5wxY19cnanQmN/t
         cNQxjmlUsAVe9NDi7td2tUGajHofKGThijhU+0r27UkPYqslnSjDaMPDIBGKfFtiMmKI
         G3Uho8mlh5aywxb4nXHsCPKPLHNpI4niiuBWDyS5SGds3N/+Wo5UOnMSmWk/FQ1cNABW
         cfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CYXLfruxX9xahrZuMhbh7ZEw2pmkRyjITmjyZ4jRIC4=;
        b=hypx2XWTZCmkmF2AZl9MAMEXwNzqTNxAa1ZWaO/To2wwhPvK9PQQ8vlD7z+dYajtxb
         II20cmcPv+uPVbMzDGhxon3/wahe7uW3YpqwEFjzTzEqMdGCCNIj03001exX+Vssmcko
         A9ArNBzuHX+RqAaIrfBePTSbN2RNDcLKe2BWoPUpE1TA0FKAdCKNFMFWoi/aQAJ6V+YA
         k4VTbekAO61FIYnc89yL0uafNRiGs4G7UTzaZIjrOTMV9VgJQDE1KkolwoRPWIlDuPEK
         2mh8u5YdRjHaHmq4aMY8wOKu85DX/C8517u10ptW7u8dHgO5pniYCJuUDVBGM8V+x5rO
         iLsA==
X-Gm-Message-State: APjAAAVyxZ9aSXWTXGVTQGZrzhkxSDYSQT3wOh20HGPDeVL36kXQdu3u
        /ni0lPD1WPAAuCGMe8VR5GXaunpM
X-Google-Smtp-Source: APXvYqzDN3FAn69hdwZuxZE8TEp68ZZOtRHSJOazDi7ndOBcEYezOIJptyr1RGOTI3LZn1Di3/eoVw==
X-Received: by 2002:a50:9952:: with SMTP id l18mr85076755edb.150.1558461021461;
        Tue, 21 May 2019 10:50:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm6404822eda.41.2019.05.21.10.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 10:50:21 -0700 (PDT)
Date:   Tue, 21 May 2019 10:50:21 -0700 (PDT)
X-Google-Original-Date: Tue, 21 May 2019 17:50:18 GMT
Message-Id: <f5fa20d2a33e0cacc649c86b540d7d8eeff30a45.1558461018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.221.git.gitgitgadget@gmail.com>
References: <pull.221.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] bisect--helper: verify HEAD could be parsed before
 continuing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 06f5608c14e6 (bisect--helper: `bisect_start` shell function partially
in C, 2019-01-02), we introduced a call to `get_oid()` and did not check
whether it succeeded before using its output.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e7325fe37f..1fbe156e67 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -570,7 +570,10 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	write_file(git_path_bisect_start(), "%s\n", start_head.buf);
 
 	if (no_checkout) {
-		get_oid(start_head.buf, &oid);
+		if (get_oid(start_head.buf, &oid) < 0) {
+			retval = error(_("invalid ref: '%s'"), start_head.buf);
+			goto finish;
+		}
 		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
 			       UPDATE_REFS_MSG_ON_ERR)) {
 			retval = -1;
-- 
gitgitgadget
