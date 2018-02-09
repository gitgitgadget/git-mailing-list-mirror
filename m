Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D121F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeBILFC (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:02 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45811 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeBILE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:58 -0500
Received: by mail-pg0-f66.google.com with SMTP id m136so3397584pga.12
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/YfSOjEttbdxxRr2AameZ/a6I9MquDmQQcalvR2xrc=;
        b=kqs4ybdaRY3h218QLYjzpLv0cQGpWyPnmdbn37nGBhPNTQkZtHvB+2NLvKj8F4HQx6
         HrJ8BsDaQXpJTMdV5JRnwGW81qQnI8a7C+A6RE1KMaXgBqWjr/Yhb9a11RDRRvcQMTfQ
         Jfv36wmL5xoOCPURrJdL6IZRvlFnPOvPSskhAmxOsQFmyeU2tjvuH/bIbYmPUFMlGLWc
         7v7BWnS0bF1PlVleYh5+Ne6DRUa0jLoK6mxf8zfF2tePOYVuAGyjvBtnYIK+f09IP7f6
         Ex1TYDGCKp33zMlxB5818DuUtOhofnM65+2dEUIhLQm9gMYhUM5gok/uFhkSraE4Ek0F
         u7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/YfSOjEttbdxxRr2AameZ/a6I9MquDmQQcalvR2xrc=;
        b=AWNXO9LAcXiDCwiX6gpyoQ39gykyg40OrscUYzQUzEQ/5mo9oc016wQItvdMBCQ1sz
         R4MzshFqxbG155SovPa6GseHx99LUsvs3Zpe+p1U2MaCLpPv8MP6NiBrLG3SSRdehYfK
         C4kIatF6kZpthZJrYILmsRwceGPwE+8iLr/1qnnfWrCglGCAgf+NADm2WtZRF5Dy4f5v
         bYkIHVPweZysOGtuCAmRGk/aiuZv3RtQFLs88HN4AX/S5OIol9A/BxRLKSaUauCk0+i3
         vH5bAVoL2j755+HxWDHiGXzKY5z1NdxqoCYArvCJ+L/SkSqV1Eyh8T/edozoXuZmOBlx
         qfdQ==
X-Gm-Message-State: APf1xPCYGgwa8Dy6jeyV/k+J7T860Bi61iHRw1bX5hc0u5dKBy92sxV1
        O2TwhJck80zi0XH6SBIjzUrlXg==
X-Google-Smtp-Source: AH8x227cbrGgr99wV3gjU3SsNKbFQ9e4G4KEwuadrGnz3cQOlCWHUZhJXKwWCN9Yha1CwyYALDOQMA==
X-Received: by 10.99.96.200 with SMTP id u191mr2105577pgb.252.1518174297813;
        Fri, 09 Feb 2018 03:04:57 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 203sm5909371pfa.110.2018.02.09.03.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:04:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:04:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 26/42] completion: use __gitcomp_builtin in _git_merge_base
Date:   Fri,  9 Feb 2018 18:02:05 +0700
Message-Id: <20180209110221.27224-27-pclouds@gmail.com>
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

The new completion option is --all.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4f598820cd..b192a5c0a1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1798,7 +1798,7 @@ _git_merge_base ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--octopus --independent --is-ancestor --fork-point"
+		__gitcomp_builtin merge-base
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

