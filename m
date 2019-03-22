Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773F420248
	for <e@80x24.org>; Fri, 22 Mar 2019 23:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfCVXXM (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 19:23:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41943 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfCVXXM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 19:23:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id w30so4425205qta.8
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 16:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJihAWDQTLYbxPzuhbE4TElWGnCFpWOhxwA6JVS/bgg=;
        b=s5ZLRoeaGlB85210uZDHW+xWFIj1Eanq7XFM5Gou+deQe56bvPkQwxBBGvtKEIm1Tq
         cmnHDbtAG1BcNr6HAF+IuF4/KW8veanlU79lEMjTXyNO3bia3jJTNMVg5j0SJExJY5wE
         uPKKNiJJWdfVJ25uuelUtQcywzBjL77T/oruK3uhaCBMzzCVXDxLyQ9u6/Qv+Dlr44Eg
         WRvKjv0b2gnXOOqb68qWBpCUxpXf++wqdE2vUuYbHdDlu7af+LiIB4/1IjzaEhzfxs3g
         UBvMh16otVoCGItHFkKjnE4wehnm6oF1f7dtxMAxBavx3PPFLDvP3KT1UA2v2LxnthTc
         uZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJihAWDQTLYbxPzuhbE4TElWGnCFpWOhxwA6JVS/bgg=;
        b=Q1isV2ZRLv0k/BVCOgbQE6VmR+/aJuC9o6WpN4PfrTdhJPdBjn/fw4LiA8WF+kjRp/
         YZ9feZ/0u7bk+oC+3oo/5+8cMgoDycK0HeEEN93jheBjFT6XRDzB9f0CmUQMXYg5Z4El
         61h5/tkAo8htVs7xa63F3uB1Co0IyvhQLQzIrY0fSWeXduod7/x6DylQ27BOKaTqmEd/
         vuv+/lSiBEM3xnyVHZq6gS01yKCfhIT2Xn1d2yZ6MeVrXuTOK4U0wCK+wOmcppq5Fs8T
         0pMTfCwVOIi+1NwnrxK+BnuA4guJOXdI8ZlEO/a+aMx2+4PCiN4ufB8HrLfXuuSlftG0
         XQQw==
X-Gm-Message-State: APjAAAVdIMcrcQMRaDoyd581T0VWepes02GcgZQOorWLcSZ3QJmKSNdg
        gkIA3uquWKy0/qmOIVl5sJdxB13K/Ew=
X-Google-Smtp-Source: APXvYqxeLt7hFCNQqqPubJz7PL5KUY/q2eJOqhImN48sV9q9qjyM7Q3FXQnrGHRXkwf39uxzlKHRfw==
X-Received: by 2002:a0c:d808:: with SMTP id h8mr10529076qvj.245.1553296990500;
        Fri, 22 Mar 2019 16:23:10 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id i68sm5002765qkf.42.2019.03.22.16.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 16:23:09 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v4 7/7] clone: Replace strcmp by fspathcmp
Date:   Fri, 22 Mar 2019 20:22:37 -0300
Message-Id: <20190322232237.13293-8-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322232237.13293-1-matheus.bernardino@usp.br>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the use of strcmp by fspathcmp at copy_or_link_directory, which
is more permissive/friendly to case-insensitive file systems.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Suggested-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4ee45e7862..763ad5e31f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -439,7 +439,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		}
 
 		/* Files that cannot be copied bit-for-bit... */
-		if (!strcmp(iter->relative_path, "info/alternates")) {
+		if (!fspathcmp(iter->relative_path, "info/alternates")) {
 			copy_alternates(src, dest, src_repo);
 			continue;
 		}
-- 
2.20.1

