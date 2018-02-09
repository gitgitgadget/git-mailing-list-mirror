Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D411F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBILGA (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:06:00 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36731 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeBILF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:59 -0500
Received: by mail-pg0-f67.google.com with SMTP id j9so2326568pgv.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gvUOugIrCQeT4Le0na+oHtLI1NX28xe/ZfqZudJ6XP0=;
        b=La+QJoQe2R+rc0XZ+XfYsJ7z7qexnGy5JYGAOLegKDUSCrKQNMC6A7k88y8DTeNl12
         Hj1yqNVd0/LR+tOsVJ+BRhHPpGhsMqCcSwEw+GXUmJgZ2TdJcwf6HjYm3P8/jwe8XIKS
         0dc5P3TKVBDbOaWVsw1sc8z3GtK9oURq4IVL5c7+ZSDKPQjwcAjoAcaTEq0fus4lRM45
         X5GRuqU/hkIIJQsdut54DNlrf57TwcFFqmFcvm5bB8Vrijkp5PeN0wSN20TyB4M2TsQY
         oE1p1HAZyvM2OtX4f4f/bzFCE9twDCnIqwANGByWD6D7euuD5dD1MolDgk5wZXNcklYC
         QbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gvUOugIrCQeT4Le0na+oHtLI1NX28xe/ZfqZudJ6XP0=;
        b=m2Lt2dz6L054VbuadA/0OGeroJgxDfGbG7XxzqSokRXmjmW7/ODqqTfrdECRl765Rb
         LT50Iw9+vSJsau64kHTIhIxZuyl/0qgPAbsOASuJSlzXS9r671WCQ0OJq2driVgThdJU
         z/4FQZOXSYMzbSt2+8d7SWxkWOwIf15mh3hkOMa9wamfSZBcPeCKfp/lWxNPWHwhJIHl
         qZjaPrTuWQ2VQySbAjukkm3WkIxKook9Q2U663cYvt+w9dZmwlSYyd9efWe7KvQMWxID
         N4LHjF1tynGsy6uEFx9dNYa3uEDkhQn9QRixV34NRZVCqsjJ0fQaLkYcNhxqyly0vUQt
         VB7A==
X-Gm-Message-State: APf1xPDtggyB+OLLhrrdufwVM2tRwBoZ+OBRNkyOXPBO810qtaXu6uh0
        EvTPtCE+njjVZsS2Dy+HlMfPZg==
X-Google-Smtp-Source: AH8x227x7y3QZFQ9HggjHldf101ZeuR+k+cVjLcd6HPPWqGa+ebV1cGw+mRVNQ0V2++mgiM7BeRD3g==
X-Received: by 10.98.72.206 with SMTP id q75mr2495042pfi.219.1518174359153;
        Fri, 09 Feb 2018 03:05:59 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id q62sm5764398pfd.48.2018.02.09.03.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 38/42] completion: use __gitcomp_builtin in _git_show_branch
Date:   Fri,  9 Feb 2018 18:02:17 +0700
Message-Id: <20180209110221.27224-39-pclouds@gmail.com>
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

No new completable options!

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 30a51c5015..7d58969efb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2773,12 +2773,7 @@ _git_show_branch ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--all --remotes --topo-order --date-order --current --more=
-			--list --independent --merge-base --no-name
-			--color --no-color
-			--sha1-name --sparse --topics --reflog
-			"
+		__gitcomp_builtin show-branch "--no-color"
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

