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
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F7E1F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFUWbS (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38135 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFUWbR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so7812977oth.5
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3wNVDSlcvLahwcBHvW1EWHcHUefUg887W6V18J+PVN8=;
        b=vgjqIPxzOxxuI4tWd9rQhEkyduFW+QfwXJoSQO6fMEyXEt2a21j0FjO/oLU8W478qy
         zc/r6emm8CYxo97kXueZOZw96fxYCn8k1viWLbhCfbEh4/6IoH+znRy6J/PrIcsvTZrF
         4VIEWzrt4EZRWQY52rxGRzv36cZ9HTu+RKGn66FUOqvnr8K3tzuoIDMsmgG18n4Ow/As
         Q+zNwUGB4GtZQd7xyko05S+KKB0wIMg0GaZ3gGBPkm3UL6xoIQRvRlbPf5pR0JcCkGhY
         KKqfxAt/6LN6N57WWfjBqwCO9Blxl/vJy+LxuugSJVYEO+nyFyin+S9UWOhY/rT+tfrb
         c6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3wNVDSlcvLahwcBHvW1EWHcHUefUg887W6V18J+PVN8=;
        b=S4c1Qispw8/aaQgzKhWsr85d0nHaDlYEvsEZ5D8MDWyV6YIbhGqR/ZcsX31oOA+qmC
         gzLoRSn+gV3j9/ypaJXWMSq+NSAZSK9CG9xjrQ9TQUml+MqKvxvtlo87NtXLqAbWnYsI
         xdA+SAgKlZyGS2+GDbUINDYZRLomiOVWH7GNYkNE90UxjqLvKCIe9skmCE2H/tkp6DP6
         E99ZNEWXP+yJ7HkCJaze211vdC9xALglhJpNZMrZNadBWyEbGXFtAeqlP0etm2HiUNn6
         cdWb3O3ynl1/RKNUJa9eHY/mya4xLzMXVzLXrxLC3pk9cGSuHY7qpjsHL52yBtL5WfrL
         5HzA==
X-Gm-Message-State: APjAAAXDOWpqHCPBg5H9MWJD95CrSmWo3MN7LjF348TmBjQaEQigEA4R
        qVBJmJ6ZCNPphHrUjGGZg70BSUfdzsI=
X-Google-Smtp-Source: APXvYqxnma1qry164iKAiEpydNFjx2gQtJrO77y7Wij0GcbQjOzkL+cKLMn1kiWLb7oZwNYbFaLmpA==
X-Received: by 2002:a9d:76d2:: with SMTP id p18mr7947674otl.309.1561156276218;
        Fri, 21 Jun 2019 15:31:16 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id 98sm1447325otd.5.2019.06.21.15.31.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/14] completion: prompt: fix color for Zsh
Date:   Fri, 21 Jun 2019 17:30:58 -0500
Message-Id: <20190621223107.8022-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need PROMPT_COMMAND in Zsh; we are already using %F{color} %f,
which in turn use %{ and %}, which are the equivalent of Bash's
\[ and \].

We can use as many colors as we want and output directly into PS1
(or RPS1) without the risk of buffer wrapping issues.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 983e419d2b..b57a9c96cb 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -88,7 +88,7 @@
 # If you would like a colored hint about the current dirty state, set
 # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
 # the colored output of "git status -sb" and are available only when
-# using __git_ps1 for PROMPT_COMMAND or precmd.
+# using __git_ps1 for PROMPT_COMMAND in Bash, but always available in Zsh.
 #
 # If you would like __git_ps1 to do nothing in the case when the current
 # directory is set up to be ignored by git, then set
@@ -506,9 +506,11 @@ __git_ps1 ()
 
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
 
-	# NO color option unless in PROMPT_COMMAND mode
-	if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-		__git_ps1_colorize_gitstring
+	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
+	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
+		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
+			__git_ps1_colorize_gitstring
+		fi
 	fi
 
 	b=${b##refs/heads/}
-- 
2.22.0

