Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85E6D1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 21:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeC0Vjf (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 17:39:35 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34114 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeC0Vjd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 17:39:33 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so249433plq.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4T85SFIzUUxs8//m+Bn7gt56Xtcm+66m/G2z2GrQWcg=;
        b=mpETKqwrviCm66m17Fg/y93z0QN/RWs7c6zccSRM+3uu0hQ+ttTYCApZRmG1/npy2J
         OBDrCNhxBkm4MoCnjPymGl3Su/9tATr/TaOV6/jyJeuMgQW2GOmWXjLD6JUC+x5WS6Yt
         pl9KUCYIQIIzaVNuOmThkGE7UL8AiYR5FEaudFD0g6Tf/8vGsFp5n+tafzBGZzCHXTz/
         woyxpvnKRKknChOn+NAShTY76MxzlJxHs3Do0iECc+Qo73q3zjxg7+avMhdfNfBDiBFK
         P0kjabmzsZxFYRdaINvD8/q+kp2OKhjx2EOosJVDZvJ7RRexhyDFTCNMC67m92z+ryXO
         IoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4T85SFIzUUxs8//m+Bn7gt56Xtcm+66m/G2z2GrQWcg=;
        b=a+Qb7xmcEmP0bXY1fOI8i52JzLqcvBprZbKfvly8l/YTxKrjzo87rJmLoTZT9IOCgt
         7LIkkV/PZDHsAKSASK2I8Rf9LQaH/M0mxVmTsUrRGDJWKa+eU3ss+C3Fhze1ttRfQCxK
         0gN0gFrQM76Ab/uPAjB/6MRvni8xWgqe81rkjRrXO9tN1tliMiX4FLH63TrK7UgOSVRO
         cm5lNjfFrhqkn5vxrYlwaUoeO6eGgqq7UOH3/97W+w1DJ3a+DO9pIWm07D8pqbhNQfJn
         26FmPeZ+7K2Jbd/MJrAalaVD1xg+oVHblt8remd9Jnr9F52Ia/n0aMpFs4X1Is+ihK9B
         4MKQ==
X-Gm-Message-State: AElRT7FCFzE58w9tYO0C5JPLhKh2QzU4OVEXT1eaBQAGv793o6EdPPnI
        SjnlX9EMLzq2TvcMEiXDahZj6rYvI3M=
X-Google-Smtp-Source: AIpwx4/DL9OqlgbyHEvNl7mW9JWb6Xklt5sW4ls87kuXH44VFumRhG3xqlxWbqEJZasXLONFG4+Pfg==
X-Received: by 2002:a17:902:5a87:: with SMTP id r7-v6mr924933pli.173.1522186772885;
        Tue, 27 Mar 2018 14:39:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j185sm4002935pgc.79.2018.03.27.14.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 14:39:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     seanwbehan@riseup.net, bmwill@google.com, hvoigt@hvoigt.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] submodule.h: drop declaration of connect_work_tree_and_git_dir
Date:   Tue, 27 Mar 2018 14:39:14 -0700
Message-Id: <20180327213918.77851-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180327213918.77851-1-sbeller@google.com>
References: <20180327213918.77851-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function connect_work_tree_and_git_dir is declared in both submodule.h
and dir.h, such that one of them is redundant. As the function is
implemented in dir.c, drop the declaration from submodule.h

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/submodule.h b/submodule.h
index 9589f13127..e5526f6aaa 100644
--- a/submodule.h
+++ b/submodule.h
@@ -105,7 +105,6 @@ extern int push_unpushed_submodules(struct oid_array *commits,
 				    const char **refspec, int refspec_nr,
 				    const struct string_list *push_options,
 				    int dry_run);
-extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 /*
  * Given a submodule path (as in the index), return the repository
  * path of that submodule in 'buf'. Return -1 on error or when the
-- 
2.17.0.rc1.321.gba9d0f2565-goog

