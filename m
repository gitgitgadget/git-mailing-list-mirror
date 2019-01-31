Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE651F453
	for <e@80x24.org>; Thu, 31 Jan 2019 09:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfAaJYB (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 04:24:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46265 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730723AbfAaJYA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 04:24:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so1197743ply.13
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 01:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MiGlz7yML3Of/Q9/vxefjQoH0PBW04lWbmhpe//w+xg=;
        b=aIb5atAvzIFZligrNVzsECSnh8VNwSBLPSYjNHOAvWaB3Jwu8aREEbPGiFyvxKqV1r
         obqjercd8EPgetjzoNYeVxZJBqtsCrQeLyA9fg5oUNv2frjhaGJE7yZCAs7x5sKbmEi0
         PPoxUiHGJBi6dlF+zjypk16CtoKi3lOLQew2GrnIm5UGYh3b+cibMNC+INpYr1tmbFY8
         cxol0AnbB1jWAgjRoF3dcTQgL7z0quilFhSG4kRHJAw4RGrmanIXqjFhHmkc5PlnEtr5
         cBFFei7L7Px69zEWPfbzl2hNMClyF/qUugxxgutUQF1PbzRSUTzTwMuz4G6cJVx3wnEz
         4mcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MiGlz7yML3Of/Q9/vxefjQoH0PBW04lWbmhpe//w+xg=;
        b=Npjgwci9vHG9R9r/WTYha95MCRp9o2OGv+WKMlxJxJlUS6dbOAnXMt0AzqnIyAjqMB
         1xu93gZvs7u1NaJnaqwS/2mvYJVgYHDlxDl2/EtZQqVWuqA4uF9DBUOM6als+vaJz3wb
         3gtDeAe3XywZI/aODcrOIBCRfmdsM31N0yStfxHqiCH7CIw1pkfSOd+CNJQZX+m0/vHS
         LhDwCTS9L2fnCobkWlqQID6pN/nq3rtUWTo7ZpBBpkFPXl16XKN+oFSVhO2AVKDOezVn
         rAHlQZ0KkWqLiHQ5uEv9dRKn/r0dYCNMZJy93NUSBRRBitE3v4ppGArue2rswKz4gO6U
         MvbQ==
X-Gm-Message-State: AJcUukdj5RCQx03s0oMA9lYdnV/JOhO1PaixNReOWEjUkXhkZRkT5AeW
        NpopphV625XAXSLyFdhmAaHY/ZN7
X-Google-Smtp-Source: ALg8bN4g2dAwOO55qJg3mS/VqW3glxIY6QNrBSDStA4QBdWh3+xw2acbt9yRJpZ2AZviWMa9XQzU0g==
X-Received: by 2002:a17:902:aa4c:: with SMTP id c12mr33838112plr.48.1548926639754;
        Thu, 31 Jan 2019 01:23:59 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h128sm6583160pgc.15.2019.01.31.01.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 01:23:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 31 Jan 2019 16:23:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] help: align the longest command in the command listing
Date:   Thu, 31 Jan 2019 16:23:49 +0700
Message-Id: <20190131092349.11469-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"longest" is used to determine how many extra spaces we need to print
to keep the command description aligned. For the longest command, we
should print no extra space instead of one, or we'll get unaligned
output like this (notice the "checkout" line):

    grow, mark and tweak your common history
       branch     List, create, or delete branches
       checkout    Switch branches or restore working tree files
       commit     Record changes to the repository
       diff       Show changes between commits, commit and ...
       merge      Join two or more development histories together
       rebase     Reapply commits on top of another base tip
       tag        Create, list, delete or verify a tag ...

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 help.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index ff05fd22df..520c9080e8 100644
--- a/help.c
+++ b/help.c
@@ -85,7 +85,8 @@ static void print_command_list(const struct cmdname_help *cmds,
 		if (cmds[i].category & mask) {
 			size_t len = strlen(cmds[i].name);
 			printf("   %s   ", cmds[i].name);
-			mput_char(' ', longest > len ? longest - len : 1);
+			if (longest > len)
+				mput_char(' ', longest - len);
 			puts(_(cmds[i].help));
 		}
 	}
-- 
2.20.1.682.gd5861c6d90

