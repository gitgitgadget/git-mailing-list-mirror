Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0C320286
	for <e@80x24.org>; Tue, 12 Sep 2017 11:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbdILLOO (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 07:14:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37383 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdILLON (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 07:14:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id e69so4321106pfg.4
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=6SyKXC2gWDO49CwJfMwxemJHe7y2Pm28wuwfzXxbaog=;
        b=r3cvwq//GgkRpbbXMT6Fv6l/ggCp9bqpu1HcATHyhVS6I/qgTtDttRblj5DuxRP2nR
         S9xiZls+vB8oBsJYdrwC5DHKeoiupVcVHln5gCp7Ghna5IWFSFz8llsoyW0kCohZ6M4r
         mIPQ9iBHjOoGToz/QxZcVWgwub+gg7MqfS2dLqHu3XoELN3DZTq2HRgYrRjsvs2qZ32b
         Zn0zzJJpFvFJz+BXvfO93FARGXjpRYZrtXOSh+D67HRE0qtMQg/y7R0ygLYKY9wWHoiB
         Fr5s4Ba1fs5tuYGNYFxg84JnobIcfYOJ2sNzMG8TLFihqdsnVrAipHFRNZ0QaGe/35fw
         n7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=6SyKXC2gWDO49CwJfMwxemJHe7y2Pm28wuwfzXxbaog=;
        b=KQnvFChKkiwEtcLFoYGaVh1zZqnttUtpEXEFZCMBQfNi7nwWFNCOXerrAEntFrh0OU
         ZkNA00sGj0IhkGfq+kxdXSsvSe10ce1Ita1yb6Qdh8Frp/MPO+mLaaXT2/jLRS9nUNRR
         qTMciMMR4EN5Yn6kBLhCU1wO+XZQv2IAnz83BObiID6cpcNaxph14bUz+/EcEsOJ2nML
         7OTHzQZwCwk7J6z1Sz/MiiiIP1RKKy6THG1hPKTGyn7+SlnwjEHITXHO5m/NMWFNoE08
         qB1wEaeHzSK0kO2ouENORzK8qMeQLLnPmSbTIYpZx+ypqOAU7wvmMv4cTpoiuj2L8s/w
         1N3Q==
X-Gm-Message-State: AHPjjUiyEVGHQef8ZnhlimkxtpDLISTjDluwFjrNEaOmk6epdO8qQVth
        W3pvEHjA+tSC9zfxolfyXw==
X-Google-Smtp-Source: ADKCNb6Mlvlx5e9RZX8eFSzfETJCWS/0/FsOGsiMgFowticqu7RmUuLNTTOty+0cn9XRj/vanY/jvg==
X-Received: by 10.84.231.134 with SMTP id g6mr17189547plk.334.1505214853206;
        Tue, 12 Sep 2017 04:14:13 -0700 (PDT)
Received: from localhost.localdomain ([117.209.138.179])
        by smtp.gmail.com with ESMTPSA id d124sm18847010pfc.42.2017.09.12.04.14.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Sep 2017 04:14:11 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] help: change a message to be more precise
Date:   Tue, 12 Sep 2017 16:44:06 +0530
Message-Id: <20170912111406.6749-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.1006.g90ad9a07c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user tries to use '--help' option on an aliased command
information about the alias is printed as sshown below,

    $ git co --help
    `git co' is aliased to `checkout'

This doesn't seem correct as the user has aliased only 'co' and not
'git co'. This might even be incorrect in cases in which the user has
used an alias like 'tgit'.

    $ tgit co --help
    `git co' is aliased to `checkout'

So, make the message more precise.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index 334a8494a..dbe45c596 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -438,7 +438,7 @@ static const char *check_git_cmd(const char* cmd)
 
 	alias = alias_lookup(cmd);
 	if (alias) {
-		printf_ln(_("`git %s' is aliased to `%s'"), cmd, alias);
+		printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
 		free(alias);
 		exit(0);
 	}
-- 
2.14.1.1006.g90ad9a07c

