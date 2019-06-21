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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1C31F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfFUWbV (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38142 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfFUWbU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id d17so7813090oth.5
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfRxdb8eKY8MDPI9i3gxFPCVkG++59Jqk+mj8yGT3oo=;
        b=Bv2A6uwasXwGppe2tpnLmtuG80MxAmso2MZKJhA8MWnn2jFUbvE4VOKIWHz2Dzd4Ec
         KwwPwDUiBhX1HMMGhTfn80Ty92+1YVSzOdeIXraUGGn3t7tJsr7R8+vMVcW64VOI+ALW
         hE8W39pfDmo/OWbWSN6dw4tY13X7VIkEaRPScUFoVlNk5Ps+9dfahmh393kwpYMhiyrf
         9Tu0Mc7Q42WjgWDrLVti7b0Zrt2MZNcD0v9Ym35hKJ3gm4hxYYaSC5YM4A3xg07FN0Bz
         DZ2b1Hnwri1OrkC2Yy4wIh7hWizVHK/rVv7p0MsmhT+UdYdlU8Z7ANM/1eoQO59F5BY1
         lBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfRxdb8eKY8MDPI9i3gxFPCVkG++59Jqk+mj8yGT3oo=;
        b=WVlU1Yno8asU62NIaVJ+k2U//OeO3V7ULBu2xkarFZi0kqWbHiVak/5YGD/4Q/l2uo
         6KIzbLF0gJuL+MD7yAu3govtTmITLp+5WisVhpz2kMHUOywXKH0/fl12L7hxc1VTNKNj
         K9HFkvpPQRTpceG0faoDzVxOHnuDM0ZpezlpyoEW38WfyIDvRYX2ha5JcOdYdvZkP9cU
         FSh1Fpo9l+f4WFVmxkCE9m789la74ffBH0h0LXRhEbVJhBMp5hd7cmphabvFMat5OL3A
         km9AaoBD/1hfdMlxQBvNEmO1qVTWYQryVIlD7o2yf6hdDWQftlB+8bVAoklTjhuK7dFZ
         QX2g==
X-Gm-Message-State: APjAAAWx1dZdo2zY25ahIyGQEBAqnxan2BuVQVJCnrruLNVYUucP8+FX
        VX7Juzk4jnCaQcA/A/pgWE+6yvT0654=
X-Google-Smtp-Source: APXvYqxbWlCi1nQte7n2lgl+lEV+cViLmbkJWDAFH1TAB2Sx4dKZhSFdws2vYc15GRFqFEnRKU2+pQ==
X-Received: by 2002:a05:6830:12d6:: with SMTP id a22mr14149030otq.236.1561156279952;
        Fri, 21 Jun 2019 15:31:19 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id h23sm1491394otr.61.2019.06.21.15.31.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/14] completion: bash: remove old compat wrappers
Date:   Fri, 21 Jun 2019 17:31:01 -0500
Message-Id: <20190621223107.8022-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been seven years, probably more than enough time to move on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dba822d0e7..1f9b833913 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3073,18 +3073,6 @@ __git_complete ()
 		|| complete -o default -o nospace -F $wrapper $1
 }
 
-# wrapper for backwards compatibility
-_git ()
-{
-	__git_wrap__git_main
-}
-
-# wrapper for backwards compatibility
-_gitk ()
-{
-	__git_wrap__gitk_main
-}
-
 __git_complete git __git_main
 __git_complete gitk __gitk_main
 
-- 
2.22.0

