Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3952B1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbeAaLIi (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:38 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44056 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeAaLIf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:35 -0500
Received: by mail-pf0-f196.google.com with SMTP id 17so10801994pfw.11
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pts/pvjeRnWBZ8usytYuR0jEYcr2TFee3xAtgD8jphQ=;
        b=QlaYdPiq5hC2M4MX71H5S8KlPK+K3KDgCN7swzRUDWyikxvLT1dfgnMGNQy25hvo7M
         5XVlP1j2LcZZ9HqnANpupKyddLQaqzs8ZEcX2YM5+KVVEJeg8AAGRdg3GvTz0o2xMsbK
         1MBX58+neoFm4rDz8n0M2X+CDwAedExVmSx7a6yOek3K7NYL6K3KGUM7VWv/DAakJ0cs
         VE8XZ/vezZTpKAousfNt+/eWZRwpJ6MKn8lo8uQxSJ6OWjRpImhpQgTKfSQcAsNZg4Je
         p8++6ai+V0Cey5r9k828sOpBe1Qv8mPdN1BzgsRvVvkPVSdFjNMxmW+uuuD4T7EqqtwM
         ePgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pts/pvjeRnWBZ8usytYuR0jEYcr2TFee3xAtgD8jphQ=;
        b=fcjlw7erkJ+AiuNqnXOaNt40yDKBgw6IkMDoAI01Gi8vvCODjZZ87csdF7t0vColXX
         sEfqL9vk6q9k/qa6wCQi5vpBBMdxk5JQ9uMvuS9p3aXgEnHLn9NMDW02jjVIZ/ZVUAjP
         z/LwzPU9XuVw1cTcB0CaA8IB0XKf0WlZeVL+ZoCdh7/E7kryrZR+fY8p2iA1p4hLCFuP
         VmX3NOGquhcyZzQzzJ+Y7DOq2JWWkGccJFIslxFQfi/d7dNchScz6mQ+XeuBoODl0i99
         fmrS+ub5lrUBGd0hqcT/LqFsvhacB2Wr6eS+CvHgjAG+5ByNPptRbaBPPc2hA/g40Vw0
         GwWg==
X-Gm-Message-State: AKwxytfEQi6cv441sb5wgkA8kzfoelpNG8pR0oM6KrM/HZcmREi58Qpr
        qp0vjA2aZXg5J0qFbPWGsYFr7w==
X-Google-Smtp-Source: AH8x224gmBSzZ7WeauhyAGWs7TYIeMe2l7lwAqlCp1iOoIDnMWk+otV/8p67IqsHCOdZfawvUCLvUA==
X-Received: by 2002:a17:902:6ec5:: with SMTP id l5-v6mr28744423pln.443.1517396914635;
        Wed, 31 Jan 2018 03:08:34 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id 62sm34048279pfs.0.2018.01.31.03.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 35/41] completion: use __gitcomp_builtin in _git_reset
Date:   Wed, 31 Jan 2018 18:05:41 +0700
Message-Id: <20180131110547.20577-36-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--intent-to-add
--quiet
--recurse-submodules

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2f3f11451d..a830c9c854 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2671,7 +2671,7 @@ _git_reset ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch --keep"
+		__gitcomp_builtin reset
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

