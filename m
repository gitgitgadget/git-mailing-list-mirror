Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9ACA1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762532AbdDSLC0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:02:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34592 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762528AbdDSLCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:02:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id g23so3206307pfj.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8xO8f7a401qnuvsqjS0fzKdWM5EIhuCptO5Nv0mKe4=;
        b=jkkChHW9/eRanlsdSKQNwurJl6tfKQJEkw6SQ+wC2zkCbt6lNF0fLNpjrZ6+wQPaOu
         0FQHuF8PrF5rS2EWnfLQloUIkjubGqa1EiwzZJwnOUMcJb1bkHkmo4PeCnsbIFALv9v2
         y1EDlHlRe37w6dN3nACInL7kSFw1fmyKseJ0JcOnKiGar/qhzk1HG2zWj+FXxPSwemLh
         rUuHA6Bk0WMqaNNN0K7rxtVgBSQxuNqlEn+jnAi148AKcoExMo9WtnenLg+0IEmBM1w1
         LYKv3cuEQ5K3RhqYtnvxoHYhSVrZCxJv0HhyF4BWl4AUY8iEReoGgzpd3TwaacILl8CE
         s32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8xO8f7a401qnuvsqjS0fzKdWM5EIhuCptO5Nv0mKe4=;
        b=pTDdHEAmJ+veUwninSdGYKQc3a0WnK4/4fA7+l0Fg9HkumlyzhSCUSMpxLnLCbNgkj
         hfLVphnko/JIxGnkOQElia0S7A5SVBKVgqmEpRb3TYREq1uj/dqQ+wQAwkMZC+/oPn/t
         yykW62R3SnLWRaJBC9dVzxW+rwpNdzS7yzWXZDog0edjCVNBggoZ15F3CtoPlson52iO
         BdKJBPp4EttoiL1EUEJHxo79sd5Yjrtf0JF9IRzqCq5NxCdPD82GLXDKOPcAArV1xTYD
         +mbhsf6zshCxBLftpBXVqvyu+efehHcTx0qXtVrx9q3yz693NIcUtTMu1OOMsl6gAMhm
         5R0w==
X-Gm-Message-State: AN3rC/7r8sTj+A/z7bKGx8iYfX6KXlxl3DSdLqNELNcllXMjccu0cEIX
        Q6iNDONa1QCdAQ==
X-Received: by 10.98.51.6 with SMTP id z6mr2483655pfz.197.1492599744578;
        Wed, 19 Apr 2017 04:02:24 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id j73sm3974043pfe.108.2017.04.19.04.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:02:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:02:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 04/12] refs.c: refactor get_submodule_ref_store(), share common free block
Date:   Wed, 19 Apr 2017 18:01:37 +0700
Message-Id: <20170419110145.5086-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170419110145.5086-1-pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 5d31fb6bcf..5902a3d9e5 100644
--- a/refs.c
+++ b/refs.c
@@ -1570,19 +1570,16 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 	refs = lookup_ref_store_map(&submodule_ref_stores, submodule);
 	if (refs)
-		return refs;
+		goto done;
 
 	strbuf_addstr(&submodule_sb, submodule);
 	ret = is_nonbare_repository_dir(&submodule_sb);
-	strbuf_release(&submodule_sb);
 	if (!ret)
-		return NULL;
+		goto done;
 
 	ret = submodule_to_gitdir(&submodule_sb, submodule);
-	if (ret) {
-		strbuf_release(&submodule_sb);
-		return NULL;
-	}
+	if (ret)
+		goto done;
 
 	/* assume that add_submodule_odb() has been called */
 	refs = ref_store_init(submodule_sb.buf,
@@ -1590,6 +1587,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
 
+done:
 	strbuf_release(&submodule_sb);
 	return refs;
 }
-- 
2.11.0.157.gd943d85

