Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA581F51C
	for <e@80x24.org>; Sat, 26 May 2018 06:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031132AbeEZGsP (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 02:48:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40311 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932664AbeEZGsN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 02:48:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id x2-v6so12318519wmh.5
        for <git@vger.kernel.org>; Fri, 25 May 2018 23:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+kSkP0U90yIqxmr9gXWrSuuhaWSEd0q90heraZ0YYk=;
        b=f7f4WJf3pGBGSqUzzDUHb3GutJBWOyc0xJcAUgVzeK4E7sONEgGh9iyxmm0uFdPF7v
         5wEUBf0Xh8atvyeDjaXv+DctqhuJXN/+VUdfGRcb/Pd6O67f8qn+sEYf1JOV85OrYEkY
         CtcaJrje0tnd4I2qpoliykOyf/5cUQ4RhoS8CBve++sDVL3zj7R0JlMx/rlRef+AWFKF
         H7lRJPDwSTUfio3ZPWwGy5VxCxnM4Ef2PnsvsxCETg7eqhWaSbNTHgycUs8EKaHI4xj8
         xFnzFL4fGEk/6vS5BA7vBSK8R+4Bf/sXhHsrbDbxiImlQ5ZUhvu7Uy9QQP002+KBcWaK
         5zTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+kSkP0U90yIqxmr9gXWrSuuhaWSEd0q90heraZ0YYk=;
        b=SY9+ciW9kYNIC0vn0yYqVh6DYvgQpLU0ZdfyVcitTS/8z4AohfmpsUYZJXTGpByDIO
         tvUkMQQCU2cjE5DqaGMtmnpQQTG9OEgRieWKCMtpZHWt1Wtb64zWVjMNHZRGD0fXqeLo
         dbQuwuNjQTu6h2IiBy718Gk1BGqBIa3YxjOivxyNCxX3kJxgGfiUy776bGyVifXZO9DB
         bx1IKE0/qdJmGfHOAmlFldsSFsBoikdPhaHby5TwAlowv6RKCFIUMESQvaoiGa3QDe55
         H3AJEIpyRf8kxLutgw8I3T+w4bIhJE5XJnV51IjHHLzoFQsZfOp5DKiy51+AEsFC94Bo
         V0ng==
X-Gm-Message-State: ALKqPwe/hvwAEuI2rmYjvZzfyLjsfqNxuEfZq/ln4hGB+Si7n0GH9AFk
        4nszY/3Sh+NTCo6xETdHJTRoUtiw
X-Google-Smtp-Source: ADUXVKJn+f2Nz+BvF4eKlaAV582d6oc8kanQ3vP8wxpERsm3lSVtcbw1DM48Sjw5/TvDOek3RJtvNQ==
X-Received: by 2002:a1c:dca:: with SMTP id 193-v6mr3516815wmn.36.1527317292016;
        Fri, 25 May 2018 23:48:12 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id e4-v6sm1180963wrq.4.2018.05.25.23.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 May 2018 23:48:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Subject: [PATCH] t990X: use '.git/objects' as 'deep inside .git' path
Date:   Sat, 26 May 2018 08:47:45 +0200
Message-Id: <20180526064745.20199-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.1181.g093e983b05.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests t9902-completion.sh and t9903-bash-prompt.sh each have tests
that check what happens when we are "in the '.git' directory" and
when we are "deep inside the '.git' directory".

To test the case when we are "deep inside the '.git' directory" the
test scripts used to perform a `cd .git/refs/heads`.

As there are plans to implement other ref storage systems, let's
use '.git/objects' instead of '.git/refs/heads' as the "deep inside
the '.git' directory" path.

This makes it clear to readers that these tests do not depend on
which ref backend is used.

The internals of the loose refs backend are still tested in
t1400-update-ref.sh.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t9902-completion.sh  | 2 +-
 t/t9903-bash-prompt.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 36deb0b123..a28640ce1a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -181,7 +181,7 @@ test_expect_success '__git_find_repo_path - cwd is a .git directory' '
 test_expect_success '__git_find_repo_path - parent is a .git directory' '
 	echo "$ROOT/.git" >expected &&
 	(
-		cd .git/refs/heads &&
+		cd .git/objects &&
 		__git_find_repo_path &&
 		echo "$__git_repo_path" >"$actual"
 	) &&
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 8f5c811dd7..c3b89ae783 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -148,7 +148,7 @@ test_expect_success 'prompt - inside .git directory' '
 test_expect_success 'prompt - deep inside .git directory' '
 	printf " (GIT_DIR!)" >expected &&
 	(
-		cd .git/refs/heads &&
+		cd .git/objects &&
 		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
-- 
2.17.0.1181.g093e983b05.dirty

