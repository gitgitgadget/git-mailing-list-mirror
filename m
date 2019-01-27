Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35D91F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfA0Agr (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:36:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33385 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0Agq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:36:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so5700504pgu.0
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SahaEHnsnPz/zBhUk3zwfrtrsjNNSrLb4UaDduqUjJQ=;
        b=pp/Z5j4idr231Jn+E0oFXZbnos+F2cqEAHc8L96PW9b1/moHrDZhYe0Mgi4TUNys6/
         +7JcGlkGtFTWZi4/Hl2ISr2x3XNwKRphh/OwQWzLnRctADEfA+B1nDEfCm3dqfYArrMZ
         wEn1+VPVfzPHJNoW9vjZuKFsAmfY2K9pPGfC+QgQ1nkFbp0aVexQ/L9B9S6wzD+iWRWL
         n2W0jU6FhbM2Qd3NUs+SlhyKkQqNYVC6gmqMqFOIZ/t3RUglIK6AqzweXn0PqAhgDU2N
         uRCoQvpoA5yV/rxwMWXndskzl+y60GfcOKaARy2DBjVWavmhH0IR0JXQ/HiIWGWLnRap
         jH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SahaEHnsnPz/zBhUk3zwfrtrsjNNSrLb4UaDduqUjJQ=;
        b=iqlt8KeKG5RcWq9mK4Mz6u4mEyCK5CDfHzxXeqoZdO1CyJpgNiW+Q1cD9Y42rsSWnD
         pv6KlIfGObY04tx1Jw0KJxKLVuoZXI5GVSCUI7IRWd3GRKHPSdl52fyw3VFe9PtAvzeY
         UHjfZKzYgDbQViWeMWhriPsaL1Fgk+nmBWClA025HRxnNsAll0c0WxLfO7ZG20KxrIVr
         +tOawQmu0klz0mCwQNG7gVROM9NHJJPg+u32eaVWeo4dzjlZNjTwl53wlBc0VPEqUX46
         hy4v6ThcmvQe2O2LDZ/ka2/M0nC7vCqghvawvMYRqsK87uA1//eUcI5V6hNdnOx6jtWj
         2Wyw==
X-Gm-Message-State: AJcUukcWLSCI6ah5CpBOTZArNz/sUYGCClJRdrZzIJwCeAh3VY0EMgNw
        tJOcbvqS/O/F2ox5nrd5Q8mFJ8TL
X-Google-Smtp-Source: ALg8bN6aqQ2voS/Qs0OsgkvAtQnfv9veh7fHmLPW7TWYVWUJCOrBTaiY6bjfHxAHzyjRI6jWHAInQA==
X-Received: by 2002:a63:cf02:: with SMTP id j2mr15194961pgg.113.1548549406019;
        Sat, 26 Jan 2019 16:36:46 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id z10sm40726233pfg.120.2019.01.26.16.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:36:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:36:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/14] diff.h: keep forward struct declarations sorted
Date:   Sun, 27 Jan 2019 07:35:29 +0700
Message-Id: <20190127003535.28341-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190127003535.28341-1-pclouds@gmail.com>
References: <20190127003535.28341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.20.1.560.g70ca8b83ee

