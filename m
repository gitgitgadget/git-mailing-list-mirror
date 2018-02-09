Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60EA1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBILGF (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:06:05 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38816 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeBILGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:06:04 -0500
Received: by mail-pl0-f66.google.com with SMTP id 13so1321046plb.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BkfPwdXkxwGLqKiWzmEgWl1qchONtcK5hiaQmn4pvoE=;
        b=qX4/Br1O+RtXykQfsVyiYihfwVqaAN5vEjLFnMT1GwFyMFQoBzL2dNkFgY4tNopC3q
         3D+I3lEkrJolwQS9IO3SOU2Rrg9CyuZaofHlXW5hu/Wsb6W9IYEzALyyQJaB0Q1qKPO0
         8M7Pf6Md9d4Z+3AzVwoqei0uAZOVSOmLfX39Fjj53x24mSXBx8JjYnd77XlWNSDHBqLk
         ZDbB8oGIaLu3G9vQCSkAukA68clQwIjcwtx05eMul0Q1tDXUVwoxglrgnnEWygsNduY4
         ZwaT89cTL/rkuYd39ftiZruX0kg2H0cj6f6wTwoy7W2JZ+fQirOP8wLCs0mRVbtz0sOC
         BQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BkfPwdXkxwGLqKiWzmEgWl1qchONtcK5hiaQmn4pvoE=;
        b=pCHb/GkqERG5G/0pq2BWubuPPcOdbWrPYTRjzO3+LHmPPd2D4qq71I0JPOSydKERin
         cGPw//5C17iog6rS0IsvAdl92eXroNB7UgVxT/Pw8eTTAbNSvAU2pxKzoEC5JGHZ/Pvh
         DaqrgVrnZzWsIbHVOOFzQ1dxBpvgQuf1MNgzRBpLWSLSKjU+26kOOJL4HbYyutyiJsNl
         1I5q3d5R21CEhAtEGW/SUNB82r2XiBqFk2Rmai4uhbUTvNX0Ab1VQio6+e/oFRdtQimn
         B7oG4jNTY5peUN5d7XQS8jO7VUxALHZJ+6G/VtopKmqkbQZtc4tRBkmddnIhZoE4PQWN
         kLjg==
X-Gm-Message-State: APf1xPA0pu3uJhK5naXRxL+TePyRoPZcxAH9JQhnOWX0V872PVlYNMAD
        g/zhFZYWMFWUNPWVLOTZHSiHGw==
X-Google-Smtp-Source: AH8x226pbcMdp0EwFPpalx6EAwPGmag7P2dmvhJzuH/hXKeOe2os1XFb73h+gDIFxBkeXIwPfO1rvQ==
X-Received: by 2002:a17:902:b43:: with SMTP id 61-v6mr2246834plq.127.1518174364363;
        Fri, 09 Feb 2018 03:06:04 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id t25sm6652362pfk.162.2018.02.09.03.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:06:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 39/42] completion: use __gitcomp_builtin in _git_status
Date:   Fri,  9 Feb 2018 18:02:18 +0700
Message-Id: <20180209110221.27224-40-pclouds@gmail.com>
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

The new completable options are --null and --show-stash.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7d58969efb..7724ce7808 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2066,11 +2066,7 @@ _git_status ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--short --branch --porcelain --long --verbose
-			--untracked-files= --ignore-submodules= --ignored
-			--column= --no-column
-			"
+		__gitcomp_builtin status "--no-column"
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

