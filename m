Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1F242095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdCRCHS (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:07:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36690 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdCRCHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:07:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id r137so6499713pfr.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9b06WBWUPiCHkBPRtqfGmmGmeRYZgI1X8OEhpXqlZXM=;
        b=vW+HkYnZLREVlE68ebc2wa4bHu93DmOKz6azoq4poihQ8WrlNcdoT+7MdmoVG8XZbt
         IwtdtprrNEVvQFPHO/u18I3WbkSWR+LmrzSIcOk3cC5XfkQA4+kVwpSsBTAdOr6qORK1
         jC7qW9KoKLtW3241bR9/ztnRtTzWnLosaom1MiKbMCdF99NLeBQemSeoFvZpbeHq9+nD
         rwRLtwBRC2DzydWjDckzhoHWrqmS+fgMYcjIP5BJdIwXZ6sDFCgosEqFYn9jqnhF1v38
         vywY72OW0zgpUM+z+N4xOEAPSgwiDQfAm9fqPazfMhFV1jO7quIe8IM61KfxgghoJ6wY
         rPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9b06WBWUPiCHkBPRtqfGmmGmeRYZgI1X8OEhpXqlZXM=;
        b=gDZf/TFkg7dA7psG/ExqGxVWhpeHAXHVIiJDmLEOH+COwvYbB4cx1dsCSuH7ym97yP
         LnvHwa5OUchidt0ZhRVNJsY9T5NR7qxxu1SY0asBGzO0JpayKL+59gkTk9tSHot9TKJp
         83O7CxUEF4LLNwh6V9Q8EJoXNOIuXFxrkA3CJ0N7VNKGNGVbDEDdA4uxqhaC9z6hzdD4
         P3V/tdBBcnB2r4JLYvgTuAhksa3PqRHSWWV5FDDprkbNfrV+ZHZxBnaRmvSe0hYNuDTQ
         UoYkipmLPF2fQQ0Z2fCdrF90SeJdS5vPpdyyHdFUWoqQH8iIqFs6RZr2xC6OwFLHUpw3
         6+9w==
X-Gm-Message-State: AFeK/H2yZXpGSBr2607cgVK/zt3WsDZPSdhVEqniC9N+Sg9fnv9V5N4WbF3pmLpAtWhGdQ==
X-Received: by 10.84.173.228 with SMTP id p91mr23634234plb.121.1489802785334;
        Fri, 17 Mar 2017 19:06:25 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id c64sm6897583pfc.83.2017.03.17.19.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:06:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:06:19 +0700
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
Subject: [PATCH v6 23/27] refs: delete pack_refs() in favor of refs_pack_refs()
Date:   Sat, 18 Mar 2017 09:03:33 +0700
Message-Id: <20170318020337.22767-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only has one caller, not worth keeping just for convenience.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-refs.c | 2 +-
 refs.c              | 5 -----
 refs.h              | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 39f9a55d16..b106a392a4 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -17,5 +17,5 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	};
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
-	return pack_refs(flags);
+	return refs_pack_refs(get_main_ref_store(), flags);
 }
diff --git a/refs.c b/refs.c
index 5ea28ae128..77a39f8b17 100644
--- a/refs.c
+++ b/refs.c
@@ -1605,11 +1605,6 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags)
 	return refs->be->pack_refs(refs, flags);
 }
 
-int pack_refs(unsigned int flags)
-{
-	return refs_pack_refs(get_main_ref_store(), flags);
-}
-
 int refs_peel_ref(struct ref_store *refs, const char *refname,
 		  unsigned char *sha1)
 {
diff --git a/refs.h b/refs.h
index 37f4aa8bd5..1a07f9d86f 100644
--- a/refs.h
+++ b/refs.h
@@ -297,7 +297,6 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
  * flags: Combination of the above PACK_REFS_* flags.
  */
 int refs_pack_refs(struct ref_store *refs, unsigned int flags);
-int pack_refs(unsigned int flags);
 
 /*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
-- 
2.11.0.157.gd943d85

