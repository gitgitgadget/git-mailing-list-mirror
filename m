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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C36F1F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfFUWbV (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41596 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFUWbT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so5759133oia.8
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmY+RZVTbVliZl9osV3W5bONsETFN3QAnBi1k8sTKJY=;
        b=jYHaPxPVE7n3mGsnLPm2L0uD23E40+FizHgnAN3ixNkyjSenx1cdjjcGzyaNJ1oP0T
         gNW1U3J3ZZBP/g69wlGLkmJYjQ15CTuwu44AOwAWzTst7zbkKhCwTDKcr9qAgxqXWccZ
         zQ5QpsAJLSknF2e+ZYHPOcW3h94I0FDwH96aHfoWTPWZykul7/UdkMlWVJXd03NFgVVg
         h4EWCKp2sMgLWaMJrN7JCQONsrt900XGpaowpgtyax1GLQ5qEor8Nn3Qgy/X1JQ1Z2Uc
         PS0flTXAuS9JD+CL+R9s+2x04gOdlTTg0tNgaivIAKPANhhigblHQ+G3yW0QFQ0T/QDq
         9H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmY+RZVTbVliZl9osV3W5bONsETFN3QAnBi1k8sTKJY=;
        b=A4mbRA1ItcuNgpCn5NYU4pmxntL1mvft+r0luRcvNNzsAxjC9ZUXLtUbqxSLh8kVXA
         4n35Sdc9lPqHmxixSB7j3znXN0VAaVjsF8ZbGZ52bYfcZbLh0006ejiyL9psAuvxiSkX
         v37EVTRIUWKWIS/Nt0Pj/ZjrLoB596giRY2vmqcowhFLwk+HqR5uXXTTPiHZVAU8NZU1
         aT2wbIBnfC06r1dCTzWqlozGLf9lekJVcP1zdt75DM4q1835+GSti0e4vfktfTSQi2DU
         ddx/tnmuGr4AhsHP7f38guF+rj5P175+e9VE8c9+rBdwqeAep/FXCtwVFfxgZ4x5SRP7
         +Dfg==
X-Gm-Message-State: APjAAAUXnjQuE+/EQ9nyPu08SqhsplU+K4KHXFxRF0NWZwIe6YD40pZE
        5fpb3vBGv03JBarymUpjKvP1c46lzSA=
X-Google-Smtp-Source: APXvYqwBIOr1FranjQU/0I4ZDNa13n//2f0OwTo/0eCZZer07tw03kJfTHHIwvW1kEzXeCQjiUdXuA==
X-Received: by 2002:aca:318c:: with SMTP id x134mr4082032oix.125.1561156278745;
        Fri, 21 Jun 2019 15:31:18 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id f5sm1432583otl.51.2019.06.21.15.31.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:18 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/14] completion: zsh: update installation instructions
Date:   Fri, 21 Jun 2019 17:31:00 -0500
Message-Id: <20190621223107.8022-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0e5ed7cca3 wrongly changed the extension of the bash script
to .zsh. The extension doesn't really matter, but it confuses people.

I've changed the text to make it clear that your zsh script goes to
~/.zsh/_git, and the bash script to ~/.contrib/completion/git-completion.bash (or wherever
you want).

Also, update the default locations of the system bash-completion,
including the default bash-completion location for user scripts, and the
recommended way to find the system location (with pkg-config)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 2801f2f7c8..7f614d5854 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -4,17 +4,19 @@
 #
 # Copyright (c) 2012-2013 Felipe Contreras <felipe.contreras@gmail.com>
 #
-# You need git's bash completion script installed somewhere, by default it
-# would be the location bash-completion uses.
-#
-# If your script is somewhere else, you can configure it on your ~/.zshrc:
-#
-#  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
-#
 # The recommended way to install this script is to copy to '~/.zsh/_git', and
 # then add the following to your ~/.zshrc file:
 #
 #  fpath=(~/.zsh $fpath)
+#
+# You need git's bash completion script installed. By default it will use
+# bash-completion's script.
+#
+# If your bash completion script is somewhere else, you can configure it on
+# your ~/.zshrc:
+#
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
+#
 
 zstyle -T ':completion:*:*:git:*' tag-order && \
 	zstyle ':completion:*:*:git:*' tag-order 'common-commands'
@@ -25,9 +27,10 @@ if [ -z "$script" ]; then
 	local e
 	locations=(
 		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
-		'/etc/bash_completion.d/git' # fedora, old debian
-		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
-		'/usr/share/bash-completion/git' # gentoo
+		"$HOME/.local/share/bash-completion/completions/git"
+		"$(pkg-config --variable=completionsdir bash-completion)"/git
+		'/usr/share/bash-completion/completions/git'
+		'/etc/bash_completion.d/git' # old debian
 		)
 	for e in $locations; do
 		test -f $e && script="$e" && break
-- 
2.22.0

