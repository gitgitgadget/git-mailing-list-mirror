Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08461F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeBILDa (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:30 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:36343 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeBILDa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:30 -0500
Received: by mail-io0-f196.google.com with SMTP id l17so9232420ioc.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYor8u/cgQrUJooHAF2TKNq0/k9zbxuJp+2aHyhkluc=;
        b=AuageCOOpFJhMm7HCT3rdZhIDQ1ELkAwEaoOFUZ4GPKitjZNgjNxNx1aDPkaNcEaP3
         UMviqJXRM+qKdUUsXdkd6KPEVzX/cxJ/7Ok7sst3+s0YUigUkW0tGf6yjULcsZB1YSYA
         i79BD2/12dtl/pmbUrQT5lr0JRuF3YvkPWWVWODVvHcBQ7WmyDUF0vO9JkKMwLoxiUbS
         DgtgSaY3IKlPqgvSfL8c/aSL21uGVqNh8QSEFVVPSQKc9lfT7sfvOixYteHXpSp9loXq
         5rhDYNIJzFvUdN43nOw3OVv+xnhhTNEpE9CyodXLdGcLsFUlXfSZVuPBpC1+neYcFvoP
         xm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYor8u/cgQrUJooHAF2TKNq0/k9zbxuJp+2aHyhkluc=;
        b=X5MU9F4vN5gbPJJ6aWp2KlRr4TvmAiLZ+1tXIHUcOC8LAUPKLoaOb4I+PHDQrE6sd7
         fiFrhfJUDukn8CYInLq5y+SX8ZatMJ/D4eVGP4EvJTZuWLkUxX1QBnhkm6t5Yab7ZSIc
         oxKhO2AYKG/eI9UBE7Bd0H7lkNFe4/Y5syQQAXT2sul5Z7P6Zxp9dnGRtxoLhqlhJp/e
         vlLqSM14EnEyYqf0JeCaqNels0CNVJkqWQ222A0DwOSUDD5luOuOwYezfMYr2C4CnhJN
         fdFioYd6l3niOTmYTDv1Q0if952PUq7XEnS2JNfOv5DDNHOD0yqAVI6skVNmOJLCj7qk
         veng==
X-Gm-Message-State: APf1xPBidGpIUN+us1qTZEgZbkEA5OMu0wA6O7Z3bfvbBJBy8Y7ZMEeu
        /5Nc8dcCM17/lrnLXxBstq/eCA==
X-Google-Smtp-Source: AH8x2255vlDEPZKGoO9rJHh+R1jlUxWaLqxBIc9aelVMALHi06KWHk4OLAdHAQP4r8AC+blEJyPxOA==
X-Received: by 10.107.130.25 with SMTP id e25mr2838737iod.245.1518174209383;
        Fri, 09 Feb 2018 03:03:29 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id l5sm2726603itl.27.2018.02.09.03.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:03:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:03:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 10/42] completion: use __gitcomp_builtin in _git_cherry_pick
Date:   Fri,  9 Feb 2018 18:01:49 +0700
Message-Id: <20180209110221.27224-11-pclouds@gmail.com>
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

The new completable options are:

--allow-empty
--allow-empty-message
--ff
--gpg-sign
--keep-redundant-commits
--strategy-option

In-progress options like --continue will be part of --git-completion-helper
then filtered out by _git_cherry_pick() unless the operation is in
progress. This helps keep marking of these operations in just one place.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7e312f95e9..068def9f6b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1283,16 +1283,19 @@ _git_cherry ()
 	__git_complete_refs
 }
 
+__git_cherry_pick_inprogress_options="--continue --quit --abort"
+
 _git_cherry_pick ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
-		__gitcomp "--continue --quit --abort"
+		__gitcomp "$__git_cherry_pick_inprogress_options"
 		return
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "--edit --no-commit --signoff --strategy= --mainline"
+		__gitcomp_builtin cherry-pick "" \
+			"$__git_cherry_pick_inprogress_options"
 		;;
 	*)
 		__git_complete_refs
-- 
2.16.1.207.gedba492059

