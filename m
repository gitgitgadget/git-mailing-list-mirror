Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B491F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeBILFF (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:05 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46090 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeBILFD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:03 -0500
Received: by mail-pg0-f66.google.com with SMTP id a11so3393664pgu.13
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FCrugdM5T81L0iPcTqAacuPDkTF7VPQaRtFv7Ip+I+o=;
        b=UT5rMenhYA2W2WG5SIh18ilKTlE7xhQMiH6yLAFHSaXL+IOLxHCIDlhp654Q69b9pa
         5m4ecy83ErzD7yvvBeaecy+MNZfI9Ps3d7A8j7fnR7XmQISVrn03i8akL67UEtPMcXeE
         9EPCfMR5nSZQ/tKLIK21XyaaPHsCy7gSovj5fKnnzhp3msoAQQnPqcx23jNVnycEljfg
         sXk513aeLvWbFkhAad77BWANnk9a1vi44Fl/d/VU4UXhRgMfA6gNCBCeeGnAUX5u+mGx
         lWYKaTzxWhIMPzxMdEFZ7uf4f2jN4DXr7AvYB8MxgSP5PN140Kt2Y12Im8uGtHOx3bgd
         9clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FCrugdM5T81L0iPcTqAacuPDkTF7VPQaRtFv7Ip+I+o=;
        b=i9+Qwl3Aec2KkrXiesgJsEGTsvZrD9oBaS2U6cz5aPGo7CS0osy0SnFkZdjQLr8VAn
         Nzu+4dV7SvnGz1hmsQjkvuhF1rm2qj+DZDUOW7HhHAGaX5r5/NoBHbXM+CTCU8ntg17A
         k/7yt8/SYZ3BKQRVbeXvvsA9nv39derSGrwd5i+7JQyHI9EfPmdvB/uv4+zGItxmlNeW
         8gJCo/HXoUz3phBYBDlWRsCu0cPooYUr1mRl2wkoQXHxHuKvnlG7sKXqRkogdM1rwky9
         gOcvqNu3/spKLYsoOXkuzQR49v1BpUpgE1O9p/Vnunp2py/TTBbdZmOBulzSxCnof3Zr
         KOyQ==
X-Gm-Message-State: APf1xPAsy0VAgtfL41UnLxN8i5MbSU9KItoe8+nSLrvMdyFOTen/Ftgg
        jJ+h4qTyQi2IZOdQT4MPEzDbZQ==
X-Google-Smtp-Source: AH8x224Tce5ZqQEDl/tLT2xzrgNdpkJpvWVv6qajST8V1zO2bCrAjDeE0JnjWnvZPDXJ9Qw9jzgnXQ==
X-Received: by 10.99.102.193 with SMTP id a184mr2132737pgc.141.1518174302762;
        Fri, 09 Feb 2018 03:05:02 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id f80sm5560593pfk.155.2018.02.09.03.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:04:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 27/42] completion: use __gitcomp_builtin in _git_mv
Date:   Fri,  9 Feb 2018 18:02:06 +0700
Message-Id: <20180209110221.27224-28-pclouds@gmail.com>
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

The new completable option is --verbose.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/mv.c                           | 3 ++-
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index b88023a733..e3e308d282 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -122,7 +122,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct option builtin_mv_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT__DRY_RUN(&show_only, N_("dry run")),
-		OPT__FORCE(&force, N_("force move/rename even if target exists"), 0),
+		OPT__FORCE(&force, N_("force move/rename even if target exists"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('k', NULL, &ignore_errors, N_("skip move/rename errors")),
 		OPT_END(),
 	};
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b192a5c0a1..bbf8623e3a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1809,7 +1809,7 @@ _git_mv ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--dry-run"
+		__gitcomp_builtin mv
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

