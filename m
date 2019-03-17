Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC40E20248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfCQMvM (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:51:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46952 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMvM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:51:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id s23so9386920pfe.13
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnDg+SwotJAAj/vLRFEj8yHPhmJM1VM/0ZjnSP77hZs=;
        b=i2T2kRc3+pjqWR+n4raxtAO6ttM/oIKu2kSk1Ib4gHX7o9fdaJbHe8KAtFixfXBjVN
         Bz3bwfLqo4GSwhlIyMCHGdEfZapGmLbTIqdFkxkymOodRXcZogK/vsL48tn7aKAZKmCd
         ZA2ovjGZt99hBTUHITaymrGljIhJ0rqc7S/4AyCzQq4g/nPGhJYlVaC/Nbr/Quhx9WLy
         qYZeYB+tOelgBVqv1ufv+eX+9rED3k9AcRZ+N9TKc/TbuzQEdGa6/bCSOJM2pyADpfxM
         vHhc103NHqcI2/TVJwPQvs78pA2bcHJOISxhAmZOoP3cMbz+wHqCCfSv4M3LVmOXqkaV
         2pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnDg+SwotJAAj/vLRFEj8yHPhmJM1VM/0ZjnSP77hZs=;
        b=PPC1Q9nBKFdXz5zJ4e3GqJxd4DGMZTphkGvggy/i/a3ilsdlwmLL6m7uR3HT7IwieN
         xVmWCAUi0+BchP5Ath5qTV1c/VErIxDIaUgVZQtpbvJrF0QzzLGlyN22+daLHdYoJUj8
         dNdJb6X4eZqO9DQomOo0TRJWxxnw8rusg0SYLRc3n3Qsekf4dHhcMMzLVx+cktXmzPMP
         yNCDjD+1Y9NAC/qFCVYpu6eMJYkaOlNIvQOb7G8PzzBGAm3+aZbwqP9c5Tgk2JpeQeD5
         ig7AOMIo9Hgcr6FNBZ/wjVE2rlB1OSb/XR0ibK3O/uTHaOh8/8kBqapwKNjr9xEj+/uB
         h5uQ==
X-Gm-Message-State: APjAAAUCAXF8xS8OcbgrxC410YlWXKNOgfKORMM1ckxO7HqR5BZ9teKl
        kLW4mEDaan5LoHFwJUPqeeXcUEjY
X-Google-Smtp-Source: APXvYqwGrhrhqv38VsQB294zgMRprOVfE5Yrs2SdDeGWhfWSGu8SBzLUqcdCy+uVl2bvi8gHvTzwGg==
X-Received: by 2002:a62:1147:: with SMTP id z68mr940403pfi.215.1552827071560;
        Sun, 17 Mar 2019 05:51:11 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id y5sm8997484pgv.15.2019.03.17.05.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:51:10 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:51:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 15/26] switch: remove -l
Date:   Sun, 17 Mar 2019 19:49:15 +0700
Message-Id: <20190317124926.17137-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is ancient. Nowadays reflog is enabled by default and
automatically created for new branches. Keep it in git-checkout only.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bd94b04303..85fc60f5f2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1376,7 +1376,6 @@ static struct option *add_common_switch_branch_options(
 	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
@@ -1579,6 +1578,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
+		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
 		OPT_END()
 	};
 	int ret;
-- 
2.21.0.548.gd3c7d92dc2

