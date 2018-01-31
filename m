Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83591F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbeAaLIU (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:20 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45675 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeAaLIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:17 -0500
Received: by mail-pg0-f67.google.com with SMTP id m136so9751899pga.12
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AX++B35coSflJNgfFRWznmgsGNO1ECp7QpXMDJITRqE=;
        b=do/jX7Qp1dE3B8zs/DZQDvAGyW4VaKntp9qzVbZxoKTdUn+WW2dE5tWw/EfK7B5jpY
         rubCAkJFatBamDnu8rF+jMlkHyA3/pOYF7xDgGl6oZLm7iTJjS2TpVEXYCxFdrTs9+m1
         jYM6MIo4+XJNRBP9clT3wpBho94EfZvZgNcBbIRaFuUH0Y0njziPr0PhgduALnhDTBxc
         gK3qjbp+nU7mh63s1l6CX7yR2WAGUOi762EIJztz2D9XWEPdvwAvFNfjh7OXQoI8YjOb
         NIupw0qGLU8WVO0jQy1QeI3S0U5A3QEw3dhCXSdKHxQQ/qVYz8HYT7P3nB5VcevWNK5x
         gVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AX++B35coSflJNgfFRWznmgsGNO1ECp7QpXMDJITRqE=;
        b=VHiQ0y1xf3qjkv7qTaQZDYAWm1qBG3ORe9WieWGNkAAKLWzqgRch2am2XdGKszcxW+
         zBver+RZU//2E3KL80Uw/Yn2CNIgv2sKoCmTwnG4ZW4lvFOmN2IxGbP2gNWASnAzNDoW
         8ma0p+XChVHr0SSFgetaxcP3xpokHaSja7Tfc89wtawU9EZ1KhlsyO03grbzHxbmYWOH
         Clkz7WlU32TozMJ0zhGoDgIEZZalngflz4qCVaE8iaiTUM53X9+m/sJ4KaBrpNI4Hg+f
         GXFbvlWHXbEzb+EY/IFJ7TauzNJMYsK/F7bqt4oUbfXiIbIIpY1kgjJy0wA58VDiVDUz
         h/og==
X-Gm-Message-State: AKwxytdUzmZJhByhYiL/wKDNx7YuMpkPQ0o79f/+YgD4xHjfBJmhZbTd
        hz/w8clVmBQ06XbWR7srSzLErA==
X-Google-Smtp-Source: AH8x224rVZGkqTSMfPjOyOhELokjanWO8/jSlbOra8A8QEjrTJxJNZFMh7Ve4ikWefT4Y9+9XmMqpQ==
X-Received: by 10.99.104.131 with SMTP id d125mr23310967pgc.125.1517396897025;
        Wed, 31 Jan 2018 03:08:17 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id q13sm24325874pgp.76.2018.01.31.03.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:16 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 31/41] completion: use __gitcomp_builtin in _git_push
Date:   Wed, 31 Jan 2018 18:05:37 +0700
Message-Id: <20180131110547.20577-32-pclouds@gmail.com>
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
index 225507b751..8233dede74 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1914,12 +1914,7 @@ _git_push ()
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
2.16.1.205.g271f633410

