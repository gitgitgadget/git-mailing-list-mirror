Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90381F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfFUWbP (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37549 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfFUWbO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so7815899otp.4
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d6glZen2FHhNpBd7NuG5ucGaYIH6Wvhl9FFVY2AGf4o=;
        b=Ebm+TcTLtYv0T7kjTJzkfahf2Pt6BzJ6wlMZp7rG8L6XzwkHw0tY1m+OL1uyD4Eivb
         zv4F8ZGUShCNwSzXLYPwBitFA8YdWSVhG7UM1f73oS8xMe6tHhtu7HvymN1RcxE/nzvB
         V1YZsv8sXkXzQzO8LREx1fstMynZ/0h2CTSO8Okxy0KD8iHnCSQ0xOMorLhx0s2GVodt
         k0TfTeVrw6xEYCkG6zLaDFT/Aj0BHoplw8VOPXEsob02CUMDi7LhYEDyk62uWDdRMAd7
         YdIQOwtGuzi7QsG7MCZNsU69rdY/WZO+lfteDlVrYQMsmw+UTpcAeP3mKKWNjWbkFcqR
         SRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d6glZen2FHhNpBd7NuG5ucGaYIH6Wvhl9FFVY2AGf4o=;
        b=NvlIFNmL6g7Yo+jZND7b2gTXi2KvWKhkdV/kyWZIL7tvoQ854jpNhlrvhZLMzE0D5v
         2pmkIW0rnvoN6LKOQwb0eNG5Fd+Y15AaQot8lRAl6lklz15Ntoz981mWKteLu3P/j6um
         cEsZU3wlSwfstDEUQjbPIoJqr310xSxEOb03Px7b2RLc7tEAJ4UyeakIBfAa5vEEOX9a
         cSEE4ERzyfPDBiAu+5jSw8fjYeuWhcpYGwDnI97Hy6cNEhgkYB4m4FirBMcOjphHhFi6
         XlOSSzEXSnqVVX6tR90cFLxNSGg55ji/FwUW31eKE2sT9LtO3ct1PYoZ6PzNDlwXWRwX
         JimA==
X-Gm-Message-State: APjAAAV42+TUl9lJaB7wyIz7gJWvCbEfIMPAXADQBWqHl1ZkNmhu2HEW
        vMhbQuUe5v42nrVPyHbbqv2lu9vjSXs=
X-Google-Smtp-Source: APXvYqx4eZH2KwoEc3Vv/GhUZf7h7+iKLDk72bBBT/4jVIuAz5hhPkRF7jJ/huSYuHPPB1bkYGLPog==
X-Received: by 2002:a9d:2969:: with SMTP id d96mr4549712otb.85.1561156273421;
        Fri, 21 Jun 2019 15:31:13 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id a4sm1466196otp.72.2019.06.21.15.31.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:12 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Mark Lodato <lodato@google.com>
Subject: [PATCH 03/14] completion: remove zsh hack
Date:   Fri, 21 Jun 2019 17:30:56 -0500
Message-Id: <20190621223107.8022-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't want to override the 'complete()' function in zsh, which can be
used by bashcomp.

Reported-by: Mark Lodato <lodato@google.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 contrib/completion/git-completion.zsh  | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a65d5956c1..676b19a983 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3066,6 +3066,7 @@ __git_func_wrap ()
 # This is NOT a public function; use at your own risk.
 __git_complete ()
 {
+	test -n "$ZSH_VERSION" && return
 	local wrapper="__git_wrap${2}"
 	eval "$wrapper () { __git_func_wrap $2 ; }"
 	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 034cfa9e8f..aade33ec9f 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -16,12 +16,6 @@
 #
 #  fpath=(~/.zsh $fpath)
 
-complete ()
-{
-	# do nothing
-	return 0
-}
-
 zstyle -T ':completion:*:*:git:*' tag-order && \
 	zstyle ':completion:*:*:git:*' tag-order 'common-commands'
 
-- 
2.22.0

