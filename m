Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FFCC20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965853AbcKJUf0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:26 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35924 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965572AbcKJUfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:22 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so152175890pfz.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cfCtky/Mmi6FPk7ZRVSAgzM1Pa+DPRbkerxTKXZUhAE=;
        b=I7PUbG2oOwL6AZBAl5ggVHMCFuLQZP4TjSu9ZMhMO6HOzJ4P6HnWhY4frFRjcER38p
         ngOQ/4MPUddMySBkk2UqZA/iWspKnU2tB8AK0DtVcAE4yhejVUCyEOK8XrqsfvkQ+a15
         y21xeoOSsLLOS1LvxnRESnDNUqJv5WkzpLnH5IZ22ajXUhwfyc2IjvV11XABFxTSebEs
         2hGJJNczRHkppLlKW1ynIfa6CI+xgQN2XAjdFqpzLAqBLXjlhWRAHIjnN69BzU2UII7z
         r1ebwt/2kdpgiLZ9b7h1hDoGfZRKTStjtHnTYNYTzT8JTeIp7YVzD/A8uMNwdVoS1Nwn
         aHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cfCtky/Mmi6FPk7ZRVSAgzM1Pa+DPRbkerxTKXZUhAE=;
        b=R8wHS3nAnSvlHECayVwxdPd1KJG9iTxSmrU6BGHqE0V5S3C+AVpzK8ptsxUt88+Dzk
         xPZB5lJpmV3M1JywU5elBYW9B5TYDpJ4zTJ2us6lxPVCEP17ch9/RzesJXwgKfPkc5TT
         WlPxxfm15YtSKKsNGZYGP9ajSDueFcPUcVNIj+lRZp0fFKOQ7f5un6fbJ4Pw1Q7gaVuB
         8rxVl8+Q+QEry4Im0jVcm4CLjooVlA8TUrWmy29mgT26Z8v5b/EN68hocznDapJBvywv
         CED7GQJ5viR1Mb77xQXPfSkjRFYJ6ZAq5KDEFAfF0ivyazxyYCuHZVd2caa8WdWbOepN
         r9eA==
X-Gm-Message-State: ABUngvdKyCcB7A5Zqih7aTJ5zggtx5lxHufUOuq/hmD7w4LVq+TzzxShN09U6Gl8blVQquZk
X-Received: by 10.98.160.29 with SMTP id r29mr13578176pfe.103.1478810121351;
        Thu, 10 Nov 2016 12:35:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id z3sm9285861paw.48.2016.11.10.12.35.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:20 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 35/35] completion: clone can initialize specific submodules
Date:   Thu, 10 Nov 2016 12:34:28 -0800
Message-Id: <20161110203428.30512-36-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf..90eb772 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1138,6 +1138,7 @@ _git_clone ()
 			--single-branch
 			--branch
 			--recurse-submodules
+			--init-submodule
 			"
 		return
 		;;
-- 
2.10.1.469.g00a8914

