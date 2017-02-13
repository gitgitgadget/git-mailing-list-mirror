Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D1B1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 19:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbdBMTVG (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 14:21:06 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34892 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbdBMTVF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 14:21:05 -0500
Received: by mail-wr0-f196.google.com with SMTP id o16so25442600wra.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 11:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=s3bwFHlipbLbE5Xw3NmFXtMdMbNVCId8VHWs6NV5QoI=;
        b=gMz5UMwphMSjKZ7YNKXYrOe5n7RukK2T6re6AjLeIWqMkZAXNgZntlOoYMf8yPTzYk
         PoO/e38bWmr07kO0x0XMRXckyUGFwgs1eLsKkJF8X6RnM3Q7wqgxBfFnR/x0x8DMv5zI
         iorZ2wC6QoqXb5PqwK4byVF4K7azswkHttbOwlnC8SUYgv/OzDTUALrYXoJnk5W2vGqC
         RoM1aEEKNUk2+iBtHrzRKiQNtx0k0LE4BdowloWcsmXo0/hvkjFfLwGvOMbgg9PMff8y
         BpJzN+IZB1C1tk1Go7vK3NpUPfkIumlPqdcEckSIzvyJaVc6P1g1eLiAQUIK196O6vbS
         zSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=s3bwFHlipbLbE5Xw3NmFXtMdMbNVCId8VHWs6NV5QoI=;
        b=m8wRCO8OaG8FFZU1a5ztKC14nL05V2doN/q28prX/Dsei4NBnCkA1LJ/JanW56wpwf
         o/fHf0V4/+OT/o9+vPXqcmxLusK5CNFflmrbPXC3x71i8d5950lgcgZb/EG4w1ZmN9CG
         d8tv3iyLVk0Y7UXsTl9XlRZ2V805SdhRbaetZ2zLlJVWMn6nbe5UsSW4is+6GkFWj2DQ
         S4c305zPyk3WGG2Zbah5iykBMMIFoHzBowBRglrMAXPT+2VYL0eAYyVnw3ke2BR3k179
         HRToBOLir8l5eoShGZi+GEEqT1o5sCU6yssHqbCJlfOdTcVrGqHTz5QJ901uHpvAPHBo
         krzw==
X-Gm-Message-State: AMke39kvVkQdnc91E4KjNd+TE6KdeWXr4nUw2iBvsxqrgADv47iyoa8Fl1IoAVXPf59+7Q==
X-Received: by 10.223.147.225 with SMTP id 88mr21223509wrp.44.1487013663779;
        Mon, 13 Feb 2017 11:21:03 -0800 (PST)
Received: from localhost.localdomain (x4db1019a.dyn.telefonica.de. [77.177.1.154])
        by smtp.gmail.com with ESMTPSA id w127sm6507390wmg.30.2017.02.13.11.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 11:21:03 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] completion: restore removed line continuating backslash
Date:   Mon, 13 Feb 2017 20:20:36 +0100
Message-Id: <20170213192036.10671-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.0.rc1.72.g2f1ba6237
MIME-Version: 1.0
In-Reply-To: <20170203024829.8071-18-szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent commit 1cd23e9e0 (completion: don't use __gitdir() for git
commands, 2017-02-03) rewrapped a couple of long lines, and while
doing so it inadvertently removed a '\' from the end of a line, thus
breaking completion for 'git config remote.name.push <TAB>'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

I wanted this to be a fixup!, but then noticed that this series is
already in next, hence the proper commit message.

I see the last What's cooking marks this series as "will merge to
master".  That doesn't mean that it will be in v2.12, does it?

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 993085af6..f2b294aac 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2086,7 +2086,7 @@ _git_config ()
 	remote.*.push)
 		local remote="${prev#remote.}"
 		remote="${remote%.push}"
-		__gitcomp_nl "$(__git for-each-ref
+		__gitcomp_nl "$(__git for-each-ref \
 			--format='%(refname):%(refname)' refs/heads)"
 		return
 		;;
-- 
2.11.1.499.ge87add2e7

