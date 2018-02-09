Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69681F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeBILDq (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:46 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:51391 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeBILDp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:45 -0500
Received: by mail-it0-f66.google.com with SMTP id p139so10461019itb.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WOyWFPGb8zAkIgSjNN17fO4UdVVI7qzyiR0ZNY518fg=;
        b=s1iGDxRVJpsuZZc6Jhvkvmt3qqeCv3egtJS/MypV4h1dPeL4ldT6e7s1QrfNxtrc4I
         notvtosXJSlSgbJkP4XPxS9IwJwv805DDuxQFLYMBeYgEM3W3HDAV5U05d65om5dx4jC
         f1rpKr7Sy+IRbhDl9+GselPYfK2lpfuXqLue8tUohvrQTuPtCP0RCbjQ2+o7/i/tsbwD
         yhNCOZfwIEliGmVpVaZsBIx81Z32klc0jgr6PZ13aGl/LUr7sI7AQ1MzYaZeNMNqFSde
         hkIWpCXUVJdC8OOVWvB1En+M13aEBIzMb0uxfAPzdyJ8im3dh7FZilzZs2FspRcokLj/
         yhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WOyWFPGb8zAkIgSjNN17fO4UdVVI7qzyiR0ZNY518fg=;
        b=HHhzQxQtM146Y8Yj66NwXhhNlI0WO/sN9f9kHyfjNRo+nI7vtm1vR/kFeSuYobSjZy
         sT16E4AX2Zqyakaa8pYswl9ac7cJJmGTcalow9V0oGXjlJN4oi7xnt3ARQWx/yxgL3Tp
         9Y+NNX91mwKE+8loNmaTyNQy92fpyQXHAyUqHyp77//EelQcDHH8pr3OyU/xcL0Twyjs
         Hku8CXratMEPS6gOeEJJXL9aYLk9rbQMY1ns5z016EkWwoog3gvQ9F4OWJrk6AP8sg+X
         CeW3q7tv6quG8/YXvvmnb1JoHxKiNnKTav3KBd143JleXVaSxNpPEQR+9mcKqH4X1SMn
         N+BA==
X-Gm-Message-State: APf1xPAimuWS+hDkeuxzNL7AOQVnvPOQbI62awyb36uA/x8bwutFA0OB
        LyR7pwn/IGjT7zn2Dw6CZvZBfQ==
X-Google-Smtp-Source: AH8x226yoivl6DAeeK04Ybcf2dRE7IIo4Pbc6xvylGBEAfKOWJuQu7wr6uJrCraapDjj64m03XXj3g==
X-Received: by 10.36.5.4 with SMTP id 4mr2890469itl.138.1518174225201;
        Fri, 09 Feb 2018 03:03:45 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id k66sm1252047itd.8.2018.02.09.03.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:03:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:03:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 13/42] completion: use __gitcomp_builtin in _git_commit
Date:   Fri,  9 Feb 2018 18:01:52 +0700
Message-Id: <20180209110221.27224-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new comletable options are:

--branch
--gpg-sign
--long
--no-post-rewrite
--null
--porcelain
--status

--allow-empty is no longer completable because it's a hidden option
since 4741edd549 (Remove deprecated OPTION_BOOLEAN for parsing arguments
- 2013-08-03)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6afab02a4c..0350350079 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1353,16 +1353,7 @@ _git_commit ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--all --author= --signoff --verify --no-verify
-			--edit --no-edit
-			--amend --include --only --interactive
-			--dry-run --reuse-message= --reedit-message=
-			--reset-author --file= --message= --template=
-			--cleanup= --untracked-files --untracked-files=
-			--verbose --quiet --fixup= --squash=
-			--patch --short --date --allow-empty
-			"
+		__gitcomp_builtin commit "--no-edit --verify"
 		return
 	esac
 
-- 
2.16.1.207.gedba492059

