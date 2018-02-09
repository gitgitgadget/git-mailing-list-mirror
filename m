Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190531F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbeBILDA (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:00 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38565 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbeBILC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:02:59 -0500
Received: by mail-pl0-f65.google.com with SMTP id 13so1317346plb.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PX3XYTZj1futRUZ1Isfq5Nx65/RH2YI6f5TtBMRfrAI=;
        b=S3xujRt6BNRRS6MntOP/90NIegFYXNww+bu+fg9vChZ6tDJWYlv9hTvcuCCsw+d7ju
         Rllb3wv224ltQLmW3hI6eEt/Tvu6WLGVIruDx/Gjm+sFzLMo/Q4Efc1VjqVJFoTWtJtz
         AoLGeFSiGlpJmz+YN1N26jm7WELN5jYbq2UasYyTji1o8tO1Q+vhycdC/6SgaHoL7GDD
         p+RdAjaEM//ieArjXQJctOYHZBL4iGmDUN0up3kAyys2/KRiz6bAd1behaWxsX7qNac+
         W36WrugBXMCPfAMCyYQBoLq4hbIpojbIhdyFLg26V99iGxLv3yEiuYz06AFO0irljuh4
         W4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PX3XYTZj1futRUZ1Isfq5Nx65/RH2YI6f5TtBMRfrAI=;
        b=f4eR4H0lKWH79NljVhWXKtBo06UMPiBy+kzboqJ4+rC7tSNYTqLJ/m/6iFY5fFfrHc
         trC9716dwJ7OWdY6zBcCjso049dAmbSlk6FnoPkvxdYQxPpnacdi605ZNPZ/v6fwDpWn
         Oka/54zz9FVzWG8e5VQUochNF+ekrWTJvtejQB8GsHOLZomuYvo9tY9PWSxoD0Ow6oCO
         IHveQ9rTHD8miJ0x1MYXxXFFCUb0DEcLb5Rde3E+fElwxOxOlyxAC5KD/Rit2dUnWefb
         VnScy2XzOc/csU37QW2VxMRodxylCN8iPjS8HjvdmX3lYbl7HglG1aQ+Slch8b1XE3Gg
         Y6aA==
X-Gm-Message-State: APf1xPAYLG577BiokOmyZkNQ4X0tUXU6aV5fb9kKi1X8SJwfP6I4cqH+
        3l4jxPQCiu4kBPT3hq3qLnUWVw==
X-Google-Smtp-Source: AH8x224ii6R0qbb6X/vaIIhqc7fL0r9jrjpPZpYL/LVagGwexAsM9SVjvlnzVrY1vh3lky1wDYquKg==
X-Received: by 2002:a17:902:8691:: with SMTP id g17-v6mr2255971plo.446.1518174178791;
        Fri, 09 Feb 2018 03:02:58 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id w2sm4183930pgm.59.2018.02.09.03.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:02:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:02:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 04/42] git-completion.bash: introduce __gitcomp_builtin
Date:   Fri,  9 Feb 2018 18:01:43 +0700
Message-Id: <20180209110221.27224-5-pclouds@gmail.com>
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

This is a __gitcomp wrapper that will execute

    git ... --git-completion-helper

to get the list of completable options. The call will be made only
once and cached to avoid performance issues, especially on Windows.

__gitcomp_builtin() allows callers to change its output a bit by adding
some more options, or removing some.

- Current --git-completion-helper for example does not output --no-foo
  form, this has to be added manually by __gitcomp_builtin() callers
  when necessary

- Some options from --git-completion-helper should only be available in
  certain conditions (e.g. --continue and friends). __gitcomp_builtin()
  callers can remove them if the conditions are not met.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5..85e7f26328 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -280,6 +280,39 @@ __gitcomp ()
 	esac
 }
 
+# This function is equivalent to
+#
+#    __gitcomp "$(git xxx --git-completion-helper) ..."
+#
+# except that the output is cached. Accept 1-3 arguments:
+# 1: the git command to execute, this is also the cache key
+# 2: extra options to be added on top (e.g. negative forms)
+# 3: options to be excluded
+__gitcomp_builtin ()
+{
+	# spaces must be replaced with underscore for multi-word
+	# commands, e.g. "git remote add" becomes remote_add.
+	local cmd="$1"
+	local incl="$2"
+	local excl="$3"
+
+	local var=__gitcomp_builtin_"${cmd/-/_}"
+	local options
+	eval "options=\$$var"
+
+	if [ -z "$options" ]; then
+		# leading and trailing spaces are significant to make
+		# option removal work correctly.
+		options=" $(__git ${cmd/_/ } --git-completion-helper) $incl "
+		for i in $excl; do
+			options="${options/ $i / }"
+		done
+		eval "$var=\"$options\""
+	fi
+
+	__gitcomp "$options"
+}
+
 # Variation of __gitcomp_nl () that appends to the existing list of
 # completion candidates, COMPREPLY.
 __gitcomp_nl_append ()
-- 
2.16.1.207.gedba492059

