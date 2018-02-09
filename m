Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1776E1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeBILFZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:25 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34483 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeBILFY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:24 -0500
Received: by mail-pl0-f67.google.com with SMTP id q17so1327390pll.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vLrCOLYCsNuek2qw68jPhsHg/Gi+Wx06hvkZB0JOZ4=;
        b=sokZpAJTHVTpeXntggDWg/jXYqly0RJctZlO7pRSAnKmDFawjfziBLZgY9BKbhz/Zw
         l6MElp/URZuMTNuG260zjbjfbx+smPs+EOsEh3ZUs5taLSOUPpFCAEZt7P6LdoY48ckk
         xp25Vk7JHkSkzxEHrRUiPx1I+OTFz0UOrSAUT6oFn4EGeQXDn4jKp4jDRhtlRMpv7OSt
         pk0B/7/PBgdV7Xf/0tFDasVDwJi8USBJwbsnboJUKNcOR308un1RUdyAGQficooU3HDA
         A+ahaaxkY7ucaotNX+1MgEMAt+nbT3rfcpHU26tWPKd6Nv2U/Cs+Z71f4cbd/1Ob7XOU
         Co0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vLrCOLYCsNuek2qw68jPhsHg/Gi+Wx06hvkZB0JOZ4=;
        b=crvfjAINHtqn+eIpTdSUfc8WGX4HkObWk7L4NcRemf2oRavkoC5prt/5PJbj2tIE0/
         FSSyRhsRVgI7fawgaIRehI21qVYBi0aznfOCRsHzC9uupU0QPzOaDcOaX3zIJNLwXSb6
         vpskQR0MgA5mE5b9p4osgTlAmd6nT36yIDfBtT6glrEKjQalhrUMXgF+toF0bh4bvZeD
         Ef1UzV8Rz61MvPkr0X4hh/8mvEl5AVFzoohuipmow6bFw0ebxbBEi644maQWkaOoEjRt
         7KGkOpnKAKbjybG6KXdWU2i4NBE7EXMN63BZWAQ7p+9Nytz1ws4YxvFoHcyNny52uhd7
         kIkg==
X-Gm-Message-State: APf1xPCTVswJsN0IKQkjb9Mvi6Y2kq9G/3vJgU4JW5d89yIQklxBPUg0
        z0u0btDa9bLxYcoILalZO7VN0g==
X-Google-Smtp-Source: AH8x225aL5flfVb63BPWckqSsa/Lzhqlq3yjIVUILYWB+QT3zwnPOW0eIOBK6707+TbWv2pKVDT97Q==
X-Received: by 2002:a17:902:8601:: with SMTP id f1-v6mr2274958plo.380.1518174323427;
        Fri, 09 Feb 2018 03:05:23 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id d82sm7741556pfk.166.2018.02.09.03.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 31/42] completion: use __gitcomp_builtin in _git_push
Date:   Fri,  9 Feb 2018 18:02:10 +0700
Message-Id: <20180209110221.27224-32-pclouds@gmail.com>
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

--atomic
--exec=
--ipv4
--ipv6
--no-verify
--porcelain
--progress
--push-option
--signed

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/push.c                         | 2 +-
 contrib/completion/git-completion.bash | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 1c28427d82..013c20d616 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -548,7 +548,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "check|on-demand|no",
 			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
-		OPT_BOOL( 0 , "thin", &thin, N_("use thin pack")),
+		OPT_BOOL_F( 0 , "thin", &thin, N_("use thin pack"), PARSE_OPT_NOCOMPLETE),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", N_("receive pack program")),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", N_("receive pack program")),
 		OPT_BIT('u', "set-upstream", &flags, N_("set upstream for git pull/status"),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 697fca0c4b..d8d9e8f0de 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1928,12 +1928,7 @@ _git_push ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--all --mirror --tags --dry-run --force --verbose
-			--quiet --prune --delete --follow-tags
-			--receive-pack= --repo= --set-upstream
-			--force-with-lease --force-with-lease= --recurse-submodules=
-		"
+		__gitcomp_builtin push
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

