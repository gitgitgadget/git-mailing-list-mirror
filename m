Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B5C1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 09:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfFTJzj (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 05:55:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38476 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfFTJzj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 05:55:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so1371574pfa.5
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 02:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipfBxGnjPJNpJXelyM6Q/qLGCyUDjEvkfaB5DkDYjJ8=;
        b=BHpINkymTWHbObbV0rExcKngxxF8JP348ApXV/izQz/cY28WVyJSiJw5Gq1HEc5zMH
         t4BbMtY/AiFn0GagEKfE+9MfCNSftWTch625YXvxNilkyQuF8fd8Cq5Zcx7Cvr5+gANE
         cmLAoPwtffPwTlLHxv+YLwRYJnSabpYzSGoyYiFw8t2GWO+mz8dpD5XXSOy6LdDBYF3z
         0QfMUT8kNwCl3dUwGzvFwPTOpilS2fayDM+8O7FFFdkKgqprSTcek4R5EgGIIMTilYyk
         gJQQ+4BAri0qWTcIpM6HYxVjaZpqteVJ9tpz4dvbFwVocwbAQ471ZjO4ecaelKipRy14
         4IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipfBxGnjPJNpJXelyM6Q/qLGCyUDjEvkfaB5DkDYjJ8=;
        b=R2SwX1a+KgDU07+6kHvgJP8wfLgfv6sH3y4l9ACdZdR60LWobZv40w2XFmnTWqQUpX
         4Aaexk1i5y+WSWjGkmd8SDOfy50i9vs7++1f+CVW+BVh2VWmYDKL1nat5B6O4WMr8c7D
         6yt887URdbOapSRTy8TSfZ+D//I/8gVH4N+lBv1B6ipRFUL2aNFhFmtCFia+q11UJtc8
         2sU48UbR8qM41o5PM1gtodDoF+bJ+BkV1MHX62zmp0wTDr1Bz7Xlw198UPyaKto+EG77
         N3xg97BhDQ7x6WXu15wAG97u9cg5pTOpx5xYCipcpjAChvP5L5mkHt7ZGzITWwGLdyyu
         Xj6w==
X-Gm-Message-State: APjAAAV9J+I5KxlD68WRLMkd8G+8zmBNcXUbI4iAtbj10PYUOnUFWfe6
        qy1oQsC7EzjPFvwE/iXxHGvso+qY
X-Google-Smtp-Source: APXvYqxMbdi1oQccz+jKRpYTom+m9Ox3pIHfe/viyFRGN1L6At4VdRL7DYXXgWmDE90EJEpelXTPOg==
X-Received: by 2002:a17:90a:fa18:: with SMTP id cm24mr2157060pjb.120.1561024538543;
        Thu, 20 Jun 2019 02:55:38 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id b135sm20716050pfb.44.2019.06.20.02.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:55:38 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Jun 2019 16:55:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/4] switch: allow to switch in the middle of bisect
Date:   Thu, 20 Jun 2019 16:55:21 +0700
Message-Id: <20190620095523.10003-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190620095523.10003-1-pclouds@gmail.com>
References: <20190620095523.10003-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In c45f0f525d (switch: reject if some operation is in progress,
2019-03-29), a check is added to prevent switching when some operation
is in progress. The reason is it's often not safe to do so.

This is true for merge, am, rebase, cherry-pick and revert, but not so
much for bisect because bisecting is basically jumping/switching between
a bunch of commits to pin point the first bad one. git-bisect suggests
the next commit to test, but it's not wrong for the user to test a
different commit because git-bisect cannot have the knowledge to know
better.

For this reason, allow to switch when bisecting (*). I considered if we
should still prevent switching by default and allow it with
--ignore-in-progress. But I don't think the prevention really adds
anything much.

If the user switches away by mistake, since we print the previous HEAD
value, even if they don't know about the "-" shortcut, switching back is
still possible.

The warning will be printed on every switch while bisect is still
ongoing, not the first time you switch away from bisect's suggested
commit, so it could become a bit annoying.

(*) of course when it's safe to do so, i.e. no loss of local changes and
stuff.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bed79ae595..f884d27f1f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1326,9 +1326,7 @@ static void die_if_some_operation_in_progress(void)
 		      "Consider \"git revert --quit\" "
 		      "or \"git worktree add\"."));
 	if (state.bisect_in_progress)
-		die(_("cannot switch branch while bisecting\n"
-		      "Consider \"git bisect reset HEAD\" "
-		      "or \"git worktree add\"."));
+		warning(_("you are switching branch while bisecting"));
 }
 
 static int checkout_branch(struct checkout_opts *opts,
-- 
2.22.0.rc0.322.g2b0371e29a

