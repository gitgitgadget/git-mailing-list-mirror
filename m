Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9E5B20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934098AbdBQOFQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:05:16 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33553 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933832AbdBQOFN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:05:13 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so4180275pfg.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Va3DKK9aTNzjdoaG2phN6Z+eHjGfT9ap8wx3yOvrog=;
        b=NBh7Dw1xPmUvMIWVwI5PqdWX5zvk7UGs/T41fObuukTYr95hihs8qrgbtsuaNkyWUO
         oZdGiDTo5IVQW41otc3kJzqx/vCEbup2w3F2XjpIdCDVCa1XNKtTelCfIgGgLPkUKdDh
         jH1VHTH6QOP7p7/acvhJwsNsGu8uS7f4iVc81TrW1PK6Gxxc14sWxQu7jGeF9VRpf82R
         9TA7UveAfoJXFk1eNwTyAPAh3DEatUIF/XYMQUk/N7eMvO3/+AEA2mj3JhgeCtOJpKRx
         Ih8PE4u11Ck8UDGIh7vthzT82imZCcSqr7g3jf2ICYsyhbfApz5HYCNKgmAXFhRzLwDo
         ThAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Va3DKK9aTNzjdoaG2phN6Z+eHjGfT9ap8wx3yOvrog=;
        b=uobhp95pOgKhmzKN80l5Qa5oQZcUuRlcpnxULgiTm6n1ckrStwzEvIf+6Z71oferc0
         2RMQM6eZj++v/VZ9pDJLiWqY59MU6AvkmElRh0tvvGFu1qk9A3Szh+jqzJAfByJ4oOnT
         vTaH8wHd/Zw3rVBlq2+hWfQwHun9zWDVcOHURN16/6cou8cWBmlRCyQMJp9O8rFcDzst
         zZ4kDqdk+3/D7k9j/qNY00kCA2f3knFIj1NOmSeH0TnrRGAuVSIDyIhxoh933gsavF22
         478jkMuXyItjAa2LPSv9ssirZQg1A/vsD9Q3Z6SUAg2TkPET20xVc8MkJ/qqWu9MW6vC
         TWcA==
X-Gm-Message-State: AMke39nXiPjIX7tr4jjODe0vw/xkGerxz9KiWEDP/DFSv5OV0AD1OyjHXN09j1hXOTfo1Q==
X-Received: by 10.84.238.195 with SMTP id l3mr11624327pln.180.1487340312890;
        Fri, 17 Feb 2017 06:05:12 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id l22sm20132994pgc.43.2017.02.17.06.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:05:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:05:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 03/16] files-backend: add files_path()
Date:   Fri, 17 Feb 2017 21:04:23 +0700
Message-Id: <20170217140436.17336-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be the replacement for both git_path() and git_path_submodule()
in this file. The idea is backend takes a git path and use that,
oblivious of submodule, linked worktrees and such.

This is the middle step towards that. Eventually the "submodule" field
in 'struct files_ref_store' should be replace by "gitdir". And a
compound ref_store is created to combine two files backends together,
one represents the shared refs in $GIT_COMMON_DIR, one per-worktree. At
that point, files_path() becomes a wrapper of strbuf_vaddf().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f0c878b92..abb8a95e0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -930,6 +930,24 @@ struct files_ref_store {
 /* Lock used for the main packed-refs file: */
 static struct lock_file packlock;
 
+__attribute__((format (printf, 3, 4)))
+static void files_path(struct files_ref_store *refs, struct strbuf *sb,
+		       const char *fmt, ...)
+{
+	struct strbuf tmp = STRBUF_INIT;
+	va_list vap;
+
+	va_start(vap, fmt);
+	strbuf_vaddf(&tmp, fmt, vap);
+	va_end(vap);
+	if (refs->submodule)
+		strbuf_git_path_submodule(sb, refs->submodule,
+					  "%s", tmp.buf);
+	else
+		strbuf_git_path(sb, "%s", tmp.buf);
+	strbuf_release(&tmp);
+}
+
 /*
  * Increment the reference count of *packed_refs.
  */
-- 
2.11.0.157.gd943d85

