Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0D5A1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeAaLHy (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:54 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33362 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbeAaLHw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:52 -0500
Received: by mail-pf0-f194.google.com with SMTP id t5so12254859pfi.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KsousQNwLgw4ZYGYx5/02c9/O3JOAog8m92CKxEcm3M=;
        b=WZPTUMHVeOfxElYWIoAnsJJLwP6yET6QbCkQTnZrqONIeB/sgoI5dGVQ4jJnse4s4t
         aHg4811ga2Ug71Vi+sJJNAed3ZfKGeVKztu9p/ie2OhEFztWes7I3qqOYPdjCm4IqVYE
         5FRdiXy8DKiJMu/eZiuU1Z4MBEB4ngOHBGQaYg1zqSu16dLhNEstaeNxt9QwYa8+H3YN
         1d/3V0/Nqa+dLZSiEmuyGEWH2bN9Zpe+KCvyO8e0GsGQpHpmdwFg09wrWYkuSDefGJRo
         kU7pYhVe7/WlLB7RLfhaslBh7vzW3gdp0KnvCiUr6KkSlnQ5i8cqQg71XIi37rhsqw0X
         iNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KsousQNwLgw4ZYGYx5/02c9/O3JOAog8m92CKxEcm3M=;
        b=LO41QamoCqBFLUG6T5lJ4u8bueCFyFLgK3TwOYnF0DOXfFayHhHlYkovbt6lCRTc2u
         oM4QltNNTa5X4cZOFyS71gkoxE0jp95uTgr9LNJA/Lyy7mMzWqV46YbxLhtKjL+fMWU6
         X35QsPA9sOeNjB2t2iDuFV16YLJvYqeEZ2KsjsDzctzYYYYNxyOcvK2SfCNj/JIoYFpn
         zNSPzHE0JY/GjS0adLGPj17t7n3Lq5u8P00hhC4apNBvW3ogS8dy/JG5ynCsSyOC+IXr
         4jBVJnK2TbAe3/LuQhQb5A86NWwP0gH7T+bzSPcHREnqf4lzjTYYm2mI73NEjp7Av5Jj
         EoIw==
X-Gm-Message-State: AKwxytcw42OIVTWGfUJC0qxYZDAL2hU67ZwO6R6dAxD25a056OPqJ5rb
        Lb5orBf4jdDwCVuGwVqIJE2twA==
X-Google-Smtp-Source: AH8x227dRShoiKa8vKAEOXvArqMQO+aJB5DghXHiMJvBZCkke2M1ti5JL+Eej9eG//bxlyv3zvWMYQ==
X-Received: by 2002:a17:902:6988:: with SMTP id l8-v6mr27984162plk.394.1517396871630;
        Wed, 31 Jan 2018 03:07:51 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id l64sm32724573pfg.62.2018.01.31.03.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 25/41] completion: use __gitcomp_builtin in _git_merge
Date:   Wed, 31 Jan 2018 18:05:31 +0700
Message-Id: <20180131110547.20577-26-pclouds@gmail.com>
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

New completable options are:

--allow-unrelated-histories
--message=
--overwrite-ignore
--signoff
--strategy-option=
--summary
--verify

The variable $__git_merge_options remains because _git_pull() still
needs it. It will soon be gone after _git_pull() is updated.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f1eb37fbff..52baa7869f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1754,8 +1754,13 @@ _git_merge ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "$__git_merge_options
-			--rerere-autoupdate --no-rerere-autoupdate --abort --continue"
+		__gitcomp_builtin merge "--rerere-autoupdate
+				--no-rerere-autoupdate
+				--no-commit --no-edit --no-ff
+				--no-log --no-progress
+				--no-squash --no-stat
+				--no-verify-signatures
+				"
 		return
 	esac
 	__git_complete_refs
-- 
2.16.1.205.g271f633410

