Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0221F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfAQNHS (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:07:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33686 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfAQNHS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:07:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so4832188pfb.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rn79Y0i72fGgSlcHdA6EU7uYpdEC0WGoGNQG6WoRWH4=;
        b=nE7KFPjaa8WRD/W9Jmsgx41FkcFNbnvDfrrN5mg/dvmmg/yoUpHBviRiBqgjHmWRdj
         3EsCjsqoym9tifstD9eLIspfkt3sLBKrLsmzY2nsJMh8dcl7yllqMcaijEBTUCigcgPH
         IIUqVT3YNaKpCS0aMQsK3GUhKB35Bvt1/1NB2y7EWBFIn8RBJmZ0uDVbGSaWKKpLeiAH
         dArak9hkC8r4vnOVmnEBwEVB55UKMjCFwOrLCGwGxJsh6VgaUTOIuvXP304GqLJUEB7O
         wWmSoiD0xTVWAPC1xhumPUPk6UrdhEs67c/ztSalY2XKrO1P6ijwgSVbpXvNqTKcGoOx
         wojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rn79Y0i72fGgSlcHdA6EU7uYpdEC0WGoGNQG6WoRWH4=;
        b=geC+y+1t6jHRF1DOV3sdoIO1sy9EOq7P3k59eh/KCScLa10m49tYF6yMdzwrmyjL9p
         2Rjfw1UrMF5Sj4tjJb256CSAPMmTDwU6wD8iVuRT48j2qPgnOPpp/h9+9lCL0KYz35WO
         74t/CYslJkMltM4s4Yb7W7jFMO7Z8WCcbqH2lojerOqaLrG5jzw/t3DxmJymLWTjG6QC
         K6zaL8AAkANDrPvaq4DFplXdCRp6MdvQlPCj2Ijz754GtwXyacutKbART0A9z2r+niqw
         OTw5cIpSGMwZ6wbleUks8QybrGdUWaIr9fsiQE2l6zZc8ZzpYe0MEAHfO7QY+W6URiA4
         HyhA==
X-Gm-Message-State: AJcUukcU2zoz9A/i9ZxVHX+BA80AucSeAvEB5SyNh+c1KkRZ/7XFrQ1e
        ORpDnAjM22URz0faJH0D4xN05wOn
X-Google-Smtp-Source: ALg8bN5ci+9amUkgQydcpGt+D35BQHwEmIG6cLk5E7N/W7WTEPQRx4l6m1QhP7SaWorp8GuJ1a2yOw==
X-Received: by 2002:a63:5a57:: with SMTP id k23mr13286327pgm.5.1547730437596;
        Thu, 17 Jan 2019 05:07:17 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b7sm2801257pga.39.2019.01.17.05.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:07:16 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:07:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/76] diff.h: keep forward struct declarations sorted
Date:   Thu, 17 Jan 2019 20:05:08 +0700
Message-Id: <20190117130615.18732-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.h b/diff.h
index b512d0477a..c872a41344 100644
--- a/diff.h
+++ b/diff.h
@@ -9,16 +9,16 @@
 #include "object.h"
 #include "oidset.h"
 
-struct rev_info;
+struct combine_diff_path;
+struct commit;
+struct diff_filespec;
 struct diff_options;
 struct diff_queue_struct;
-struct strbuf;
-struct diff_filespec;
-struct userdiff_driver;
 struct oid_array;
-struct commit;
-struct combine_diff_path;
 struct repository;
+struct rev_info;
+struct strbuf;
+struct userdiff_driver;
 
 typedef int (*pathchange_fn_t)(struct diff_options *options,
 		 struct combine_diff_path *path);
-- 
2.20.0.482.g66447595a7

