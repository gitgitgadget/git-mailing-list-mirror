Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC4B1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeBILDP (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:15 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37007 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeBILDO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:14 -0500
Received: by mail-pg0-f65.google.com with SMTP id o1so3397703pgn.4
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PwNXTtZ1+tE4PBrd6Bz7pfA1x/AFsNUUwvqpDxPOz/M=;
        b=ugqFqnrjzknOoyhBi1XOG1JVvgDj4BNlCD/Igme3OmqdU6QYrMkTQV6d+pWisp2wiv
         AOSm+8DJgAGH2glVWiVj8y2Y0Nn5XErYM+KZ/WjhQfSWrSHwL4Oh52HOkLoCx1cBaHob
         iCyUNrlTC/5fNTn0QVp6nRfG3yMonqtuwH9BrmeGVPZzATMclyKES49LY3VWVwlMhZ/l
         aI7IWlWUZj1GU5jOb/uXSukulilVeQjfpjE4OIPHIqEIaFkOkLUaMoCoAlpH8AHtqWFQ
         wBx217c1lJtetayeFBqiJNOO5cf8I5Z8vqKWCiS1uzrjpn9zSuW5sJUWC/EX5et3baYT
         O7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PwNXTtZ1+tE4PBrd6Bz7pfA1x/AFsNUUwvqpDxPOz/M=;
        b=kAd5f2P502wKzeNEMpaFcxwdQKRtEyce9hO99G/hdTOsA26DOALlw5o04c+oXkjDXS
         lU8wPsMBpBWNv81hMa6fgKEmqNjSsQVjXTlnhj54+WjKpzTelLS5oIC5QLBp1eLaLT0B
         PdJ6WfNtD3HCUpzXSqOmmWRU7WgTEX5kcKPsAnY+NzX9kWj2pB0/ZAyouEy+tHqdh7lg
         jAip7/abSj5BLdMcmE6DWCZpKQWJb2vfgf74czlraXLjsPBAHtIVTi40N0LCQs1reH2O
         c1SVCBtarojrbzrj17PZHUJ1skPCS4PQlLf5Y4tO8JAc25/v4m2jQ8IASOfrk4qJpokQ
         9ogw==
X-Gm-Message-State: APf1xPAgU9NJ7pr+x4V+OEIFi5xWYqAo9ddW93EXfh66ovIhbMdtniXI
        VB81LQ3zJ9bsvs9twsy2/0WHsQ==
X-Google-Smtp-Source: AH8x226FqAG+KbFG4NXUA799wWHuQprqdk5QUypycbJm+Nil8NrMkSh681t4LYQJ/jIiMVEwGNZMYg==
X-Received: by 10.98.59.197 with SMTP id w66mr2468839pfj.7.1518174193714;
        Fri, 09 Feb 2018 03:03:13 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id q10sm7798066pfl.106.2018.02.09.03.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:03:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:03:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 07/42] completion: use __gitcomp_builtin in _git_apply
Date:   Fri,  9 Feb 2018 18:01:46 +0700
Message-Id: <20180209110221.27224-8-pclouds@gmail.com>
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

--3way
--allow-overlap
--build-fake-ancestor=
--directory
--exclude
--include

--index-info is no longer completable but that's because it's renamed to
--build-fake-ancestor in 26b2800768 (apply: get rid of --index-info in
favor of --build-fake-ancestor - 2007-09-17)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c                                | 5 +++--
 contrib/completion/git-completion.bash | 9 +--------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index 321a9fa68d..65eb37e6a4 100644
--- a/apply.c
+++ b/apply.c
@@ -4943,8 +4943,9 @@ int apply_parse_options(int argc, const char **argv,
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &state->cached,
 			N_("apply a patch without touching the working tree")),
-		OPT_BOOL(0, "unsafe-paths", &state->unsafe_paths,
-			N_("accept a patch that touches outside the working area")),
+		OPT_BOOL_F(0, "unsafe-paths", &state->unsafe_paths,
+			   N_("accept a patch that touches outside the working area"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "apply", force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &state->threeway,
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index eba482eb9c..2fd3fc999e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1134,14 +1134,7 @@ _git_apply ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--stat --numstat --summary --check --index
-			--cached --index-info --reverse --reject --unidiff-zero
-			--apply --no-add --exclude=
-			--ignore-whitespace --ignore-space-change
-			--whitespace= --inaccurate-eof --verbose
-			--recount --directory=
-			"
+		__gitcomp_builtin apply
 		return
 	esac
 }
-- 
2.16.1.207.gedba492059

