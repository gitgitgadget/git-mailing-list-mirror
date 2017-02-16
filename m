Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4199D20136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754953AbdBPLtW (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:49:22 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35850 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754941AbdBPLtT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:49:19 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so1483130pfo.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Va3DKK9aTNzjdoaG2phN6Z+eHjGfT9ap8wx3yOvrog=;
        b=ceMtxRfuhJowZnOliWz2uo0qbIEJrvreWHkYTxafLxH+TXQGU5A8INdB7wL6dWus6v
         /80vIgpeCbJ8WoJg61SobTMGz0hLRV7C2hHT5W1Zr7VIMZADxt2vcn7bdSXKkhLgLHlf
         Y3ie7IcpU2A0UqpcT7gslaScdwcOZ7FfumSFAkRacH9gbOqVPz6sj4FH6jxFKGC7+L2p
         41LdAc2pMZKaWwPfncH5/G8STdoy9DH++dYsZIC+L0p7aOcN15osqrR3SxVCzuP1Slkf
         XSqVUgvBYe84lSe0fWjGPPbkBJ2e1ymMXlX9NLgIwGJ2JqX8s/anjc+R5Cl1D8wtSb7t
         hOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Va3DKK9aTNzjdoaG2phN6Z+eHjGfT9ap8wx3yOvrog=;
        b=t1WVRTJipJ4gnyBYvnCg9IYJK/nKxUjDrQcRx5hOLsNPyObTNQo1cZa6l9hIa66fhq
         s9UD4ffpFyErZ3Y0//TtEiru4EoYDLo8No68Ze+59m02Wo7qdPy3jrkS8DsChWSUKCoP
         M88b4DTs/bXEPllh5Ryis+Ncsnj/GY/cEMWJ/2YS5X49987/eMHm3anmTZS8EV4+HzGS
         lECACjS49yRVIUe3DLbXAyOA+9aDxnXMofg2GieHAqfT1qWHN8/GzjIHCck6fwjvE7YB
         9CgOaEYPGOBtjfvhKAqfZmEt5HJylBCV9zlfszpVIBo/fIv/htS92mTm09GCRjxzfQ++
         5/KA==
X-Gm-Message-State: AMke39lANBxWLhlwddO9S4CD8nT4cOqGbgVq0yaDHAbGrUWOGfj4jdPkD42nnOvkGAhODA==
X-Received: by 10.84.210.33 with SMTP id z30mr2577182plh.79.1487245749123;
        Thu, 16 Feb 2017 03:49:09 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id r16sm13295322pfg.76.2017.02.16.03.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:49:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:49:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 03/16] files-backend: add files_path()
Date:   Thu, 16 Feb 2017 18:48:05 +0700
Message-Id: <20170216114818.6080-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
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

