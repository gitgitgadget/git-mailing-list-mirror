Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 882C81F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBILEW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:04:22 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33066 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBILEV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:21 -0500
Received: by mail-pl0-f65.google.com with SMTP id t4so1327281plo.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdInl7T++eySPoclh9vwe40WuhcYytAGwPprp0V/lcc=;
        b=buDKwJ4EPNHYrfPUWzkik5ZPHMqRIQiXMnUw8nwjU79l/tneyeRgRnlhx/dKqYeb0A
         lnN5uqQo5+vVVPzCHwRDOEaguWVrFWlg+m39UBIKT42fezVVfkoylfKrsC0FMJPuV3Vd
         PkIvphkoQWqmkzAfFJS0NEvLKzylHRSsHrqkCSVuhGFiYkuogV5QRBYThyDZS9Ky+5TK
         jrY5KeWa6t/NosvzFij/Bn1HHhndJGr/AW4eSCW3R4zo2/RDEINe4gHmKaenkkmRrqbj
         4QGj35ivVwmNVg9WeAtF+OZKqhCaz9e4smbhTzEHCnSHrtF1kYuPxFeDung6xJMjhjNb
         bfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LdInl7T++eySPoclh9vwe40WuhcYytAGwPprp0V/lcc=;
        b=i3mNn5hJvo9hAz1qqeT70h/q5dgqtxr3viKrQXyBAuV5+7H7bNpgKdTBeqULBozeCs
         A399I+DqgP9LB/2ORPNwaCFrITAmG0nQAcod9v32yMP9idEclC/lDAQcjpCBbAaGgF+j
         UyBBncmn2846cbqwiSP1LEzBmKAFcCHEB9BMPdzLqeDuy58wQJrATcNx0rqzAF2ciTvX
         WTi43XD9NIjaTa6z1D6KxJ6iOEkRCHgClSvFvD96vtxucHup9YqGVZI4QppXxZtdHfqx
         QhpZNZk69OyfwN8nFiv+VtepAdw+dA61h0soz/NOZRD0PG3NR+koTdmopTdzaFpwkhS5
         UDsg==
X-Gm-Message-State: APf1xPDxNK2SX4H1UJPILfJdsTayFoSlDtqSF5DFkvV/IhjATxF3YlTt
        oItaPe3NKZMU0YqQoU7UKIZzhw==
X-Google-Smtp-Source: AH8x225IF+8JjDIqJ4dDk1POlDAnm7FsVObpBRDvY55X8S/hgt2dLf3FndT4hVIjmocM2tUOsLjmbg==
X-Received: by 2002:a17:902:6d09:: with SMTP id s9-v6mr2256460plk.176.1518174261330;
        Fri, 09 Feb 2018 03:04:21 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id c1sm4642715pfa.119.2018.02.09.03.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:04:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:04:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 19/42] completion: use __gitcomp_builtin in _git_gc
Date:   Fri,  9 Feb 2018 18:01:58 +0700
Message-Id: <20180209110221.27224-20-pclouds@gmail.com>
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

The new completable option is --quiet.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/gc.c                           | 7 +++++--
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3c5eae0edf..7fc5c16254 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -360,8 +360,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			N_("prune unreferenced objects"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
-		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
-		OPT_BOOL(0, "force", &force, N_("force running gc even if there may be another gc running")),
+		OPT_BOOL_F(0, "auto", &auto_gc, N_("enable auto-gc mode"),
+			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL_F(0, "force", &force,
+			   N_("force running gc even if there may be another gc running"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 340e2414ff..79e9f69d52 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1509,7 +1509,7 @@ _git_gc ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--prune --aggressive"
+		__gitcomp_builtin gc
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

