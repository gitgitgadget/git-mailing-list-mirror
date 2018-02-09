Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D80D1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbeBILDF (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:05 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37032 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbeBILDE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:04 -0500
Received: by mail-pl0-f68.google.com with SMTP id ay8so1317337plb.4
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8S8fC1r9wJJ8CYT0e+xPtM5cfN+XKxupzWiqVj+eCY=;
        b=ezSJApC8VIT4l7OKMLQsyI5mFr2uvRPBnl1dBbO58iaM+LXxUY3Ft8i77kLdPZlbc2
         8naBctlW/pSjGE/nSdIaQwoRuRaL9pER6gjTD3RMHn95nyBDI6GcA5OXfZHwczZUas2t
         DvR3ly70deRnx8e+M8SW8Eo6zrXocX0+1b7bQiBk9r0tasWjHKNBSdsRjlKJvu9sPw5d
         jZeUhKjg4hfBJBeoFVtXd7hhWSTd5IyjRd5J+ZAYcb4kjL44pxFCxorbkvd8NTOti1vu
         1piRW6f+4OiQfuIhxH45BJ2Q2s0SIm4SpjuRlphesvjeCfB+FyNRoi/f0XBt7JJj2D1i
         Nxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8S8fC1r9wJJ8CYT0e+xPtM5cfN+XKxupzWiqVj+eCY=;
        b=OYBcHIGzd04TgwIn/2un+G0krF7MrNfCrYlL817MB7iCWPeXPCRX3p3N5ci0KCTyLV
         dGeGrpG5eCQsSARwYFOa9G0uH6iZSzkqGjYdGGOn0k361PSGdhdZ4P4OK+oW8P2XItvR
         e48ukSXOVWrfJelN5SaMOSdkNgR6f3u2daenuxup5Log80ewEH+jd2D6o/qZedJ2Ljyi
         zHtvfXcAbZvBFeCwz4m9NiN4eWv2K/sHEERMJRWh1X2npYocTO8/b6e//dN33CIfaClZ
         klNNI8VDAuwqhHF7EsTPPkFVs9p+e7d498d9IXPg1KA27sgnsPkhdH0uCqCb1V5hBfl0
         +C8Q==
X-Gm-Message-State: APf1xPBhuNenPN2engf41WEkjrB/SssPVYMOaDiZsyedtAlSrjzuMPgP
        9vLhyywoPGY5hc35m7dloXxFDw==
X-Google-Smtp-Source: AH8x225TTxcw8bHvzqjA8b1z+GtoN1sSjpCDMEhUpTbS9oBW+6N+ITmMaAqoqVcOWvcRcYIDqnfzbQ==
X-Received: by 2002:a17:902:5a3:: with SMTP id f32-v6mr2285473plf.48.1518174183813;
        Fri, 09 Feb 2018 03:03:03 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id w10sm4505358pgc.69.2018.02.09.03.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:03:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:02:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 05/42] completion: use __gitcomp_builtin in _git_add
Date:   Fri,  9 Feb 2018 18:01:44 +0700
Message-Id: <20180209110221.27224-6-pclouds@gmail.com>
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

The new completable options are

--all
--ignore-missing
--ignore-removal
--renormalize
--verbose

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 85e7f26328..1e0bd835fe 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1153,10 +1153,7 @@ _git_add ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--interactive --refresh --patch --update --dry-run
-			--ignore-errors --intent-to-add --force --edit --chmod=
-			"
+		__gitcomp_builtin add
 		return
 	esac
 
-- 
2.16.1.207.gedba492059

