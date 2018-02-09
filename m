Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FD91F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeBILFQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:16 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38849 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeBILEs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:48 -0500
Received: by mail-pg0-f66.google.com with SMTP id l18so3398111pgc.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaacT6BUf6Hvv7sGO9sAK/ZMCA+TfDM3g4PQSBquPJQ=;
        b=QjyMSzl2SdESvhzYdZkzg2j/yCbOu/45YTbApMre12+/8j61CGzIut5nbY04eBQ7A7
         jgWNTO0Vtm6PJ+YAXjyUAlUy0ual3HjmCSYZvqrcspLX+udG+tlykKt8ByrS8vhVHCCQ
         qeZI5+bJySzRy1lsg5FtaVbS0KLjJ9fwA6l/Dgs8/MkGFJZtggQx46hJsYxrxQ7x++Kr
         E35glCwq5hCb487Ko/gu7WlMzoTNevND2nCbi0XTqdbrj5gQ4UwzfEaVWLYLOqyq/Aa1
         bx36E9qFdkg90vqb9KTw0a3n8AkuV/EDSYK106fHVb/SqZxo21zzWxUUyQfLoWaCRnlv
         j81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaacT6BUf6Hvv7sGO9sAK/ZMCA+TfDM3g4PQSBquPJQ=;
        b=oOD+heRQTs4E8UTt9gdwlgpwO9US/99Koo8g6lVc+rMdDfvdpjzQVvieF6AZpDrDE7
         J7uAD5CjJ0+B1GDwJxqAlmm2ZTNYSUshDCPsCcn/6D5W870k/UfYh87C9blcyKb3raMP
         qs9+lnnyS4Dg1ucyClxm3esdeIBaFcJrvreTnOSoj95oDyWGUzw7ba9FRH0viKuc5qnV
         UpzbsC3SozEMW6S0t79wuJ+gAA1gt0QcDwJVFvZFuuCw5st1IdNe915hpxOkFpApQLhy
         MzI1QfitaPRS9xBNHTfKcuhHGbOhS7wMJf6AAP9Dp1GwjIhTXOdLV0/Wp4uUK19mrwiN
         DbOA==
X-Gm-Message-State: APf1xPD/df8tr5LJsTs/C0vBUzSQc/BNTeB6SVLKVql5ABkZpxxgh+rl
        9oeeIF5itKzFSp8ZI9UM1gHpCw==
X-Google-Smtp-Source: AH8x226agKKgonrRSnWNNPentMLDstKG0PeTkRJ3qjn3C8k8tXzYrGhxtpKsg1wRmrV+hGQH5w3/fQ==
X-Received: by 10.98.211.218 with SMTP id z87mr2507984pfk.54.1518174287740;
        Fri, 09 Feb 2018 03:04:47 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id a6sm4316274pgq.56.2018.02.09.03.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:04:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:04:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 24/42] completion: use __gitcomp_builtin in _git_ls_remote
Date:   Fri,  9 Feb 2018 18:02:03 +0700
Message-Id: <20180209110221.27224-25-pclouds@gmail.com>
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

The new completable options are --quiet and --upload-pack=.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/ls-remote.c                    | 5 +++--
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index c4be98ab9e..540d56429f 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -60,8 +60,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
-		OPT_SET_INT(0, "exit-code", &status,
-			    N_("exit with exit code 2 if no matching refs are found"), 2),
+		OPT_SET_INT_F(0, "exit-code", &status,
+			      N_("exit with exit code 2 if no matching refs are found"),
+			      2, PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "symref", &show_symref_target,
 			 N_("show underlying ref in addition to the object pointed by it")),
 		OPT_END()
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1ea06b6e17..e22ea60bc8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1630,7 +1630,7 @@ _git_ls_remote ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--heads --tags --refs --get-url --symref"
+		__gitcomp_builtin ls-remote
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

