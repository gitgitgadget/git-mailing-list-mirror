Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3BF91F403
	for <e@80x24.org>; Tue,  5 Jun 2018 15:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeFEPno (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 11:43:44 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:40152 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeFEPnm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 11:43:42 -0400
Received: by mail-lf0-f45.google.com with SMTP id q11-v6so4323794lfc.7
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L332VTrnguNRWJBGhfGFO92Iw8pRUTSzYMMIxIRTGM0=;
        b=XvmgMdld4vOnKdTgQtNNq5jK2Rj356j5dX02IuGbvABkKin3TrKLUpSMxhl8Jmn1lt
         LRMFytBSNJqFs8bTYg/u/A68l9rU/uIjeK5WENEmAAFLbdTd/lsKCtUvHwypCNlQtdzS
         zVERtojLS6u99kCUd9gtYT4YwtvW/TMPuvUe7tHHkVy/IlsOVNLXEO3CwKnwUCgcp51Z
         w1gFrdz2msGa8CCCsW53IAw6JaMh04YmEOqes84zl8SnEkoGgwe5cgGi6wAoZtK4pI0t
         eEH1D1F8CP1OPulgvp2/ZUset+4Gm1nkLbxw4ButSlYYO13fl1Yhkzpdqdi2LK+9ER4n
         JrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L332VTrnguNRWJBGhfGFO92Iw8pRUTSzYMMIxIRTGM0=;
        b=OBWfalj5b4z7YtFBK4SyPmg6MJOdZkuJlMs6r38rcnLaNcGwgeWYgBv1tRwL0G8MyV
         4Hl76v60O8y486HSQA9Yfn1wfW3ZsviKKg8VvOmYVlp08nNXL6gTlrVH393KExkVj4UO
         6YkjTYfyZIMQlcJ1gZEuuW3DM4zqinPpabChfcqWUE/v0XRuFH1+6+Rv9x2kdq97iVqD
         odHmeDIva4/q9TlGH+ALBRKDsae+G4yAV8IpmT7VXATNyvDO9+lI6P0IN0NzQgjEo4wd
         3vOM5aVGb3lN9aRjZaXZlex//tXoTwonG2dGfvn9mCUf8yYU04SFjzP+U4xJSEfhQRMZ
         ip0Q==
X-Gm-Message-State: ALKqPwekxJZjSesFdMYGAZglF3QIGffXzhNjISwtuyH+8EgMTlTcEcbw
        7GX40T57gm3wHDqkxfQ1n8kk2Q==
X-Google-Smtp-Source: ADUXVKKnb0QwMIGeeIkmtmi2WEbmPCRA2nZuCb0Sz52xWqk0EfbMcmg+g+iqWPBs78pv7vI/78FdEg==
X-Received: by 2002:a2e:cf:: with SMTP id e76-v6mr18452270lji.82.1528213420807;
        Tue, 05 Jun 2018 08:43:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o9-v6sm5161054lfk.2.2018.06.05.08.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 08:43:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/6] unpack-trees: remove 'extern' on function declaration
Date:   Tue,  5 Jun 2018 17:43:29 +0200
Message-Id: <20180605154334.22613-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180605154334.22613-1-pclouds@gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
 <20180605154334.22613-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..534358fcc5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -82,8 +82,8 @@ struct unpack_trees_options {
 	struct exclude_list *el; /* for internal use */
 };
 
-extern int unpack_trees(unsigned n, struct tree_desc *t,
-		struct unpack_trees_options *options);
+int unpack_trees(unsigned n, struct tree_desc *t,
+		 struct unpack_trees_options *options);
 
 int verify_uptodate(const struct cache_entry *ce,
 		    struct unpack_trees_options *o);
-- 
2.18.0.rc0.333.g22e6ee6cdf

