Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120DC1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 09:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbfJVJ5G (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 05:57:06 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:40779 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJVJ5G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 05:57:06 -0400
Received: by mail-pf1-f169.google.com with SMTP id x127so10325093pfb.7
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 02:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O23p6oENYogdSJs0JS/z7G7k9GghNw7NjEwcYZ9/UDE=;
        b=Qy4kRapd1tyAjDtCnf8gWL4Bl7WmiCpgwQ0FHk/csegXOnLoEvnoreWeyUoZEg0cmB
         L2YQ+la9S7JZ1w89xYmUe61umxhJXwOYtJsY4Q9ouagCLoO5B4ytNXpkDPxLL682AyB0
         J4g52O4lmoyS1mYkNgUr+OPD7M+XKAsyQzJ7HMKNa723VSotaSTpRZ/mrF9JXw3JoYus
         uzJOQ3qGUNkJ1vROfb/F7fLfFqU56x9seh6h8LEY1hjWb4cS60u5nmiesjRKFY923ltM
         NCK29lB5/CFFp+4jeaXEtLi2///9uVvRKhvleGemTZeUTisL1VnabYBjRplnh3g6neBK
         SbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O23p6oENYogdSJs0JS/z7G7k9GghNw7NjEwcYZ9/UDE=;
        b=bDqUz/Y97xG3iYLGjCknpSj4g45gCevpRCIxfzq6Nkj2JZPs+piXvQeMxgR/U5jZxp
         IuQJHXJ4CW+4MFYZwTEr6MrNyWhuyZ6ztPwJHpfJFQ5RoS6UJ7Fjyrl0YAfa4eAyyD68
         5uyaFFy/Qr9gxnJ7LBTnJEisGlAAToy8Fx8uY8cZ4rSvrKjKxTsRjPpqqNhxRBT5vPzf
         5f1dnvh4ay7QWNUQHHY1bL8QjRN8/l0SKdSl+7KRHB82fhaUq6fjiqqFb+S/D0KPIh4t
         i7XruGW/sznYrNRz8OCkKql2lcR5udIiLd0ZM2uFWAgyjWeALfosmSscv/q9WE/Io8sg
         vt+g==
X-Gm-Message-State: APjAAAXCcHlrWXjS8yIVFh49J0cmeOTtuCSaHCFJgFUtNCgpmgktOOsj
        xaH1c7aH1X+mEANY25eQW1RgqqNz
X-Google-Smtp-Source: APXvYqyc29JVyJu3W1yx4EkjUdgL1amiYv+y4q2Z7gUs5HRUeeaUxM0FGrsbczNGDdb19KhmMzj4zw==
X-Received: by 2002:a63:29c1:: with SMTP id p184mr2765296pgp.174.1571738224644;
        Tue, 22 Oct 2019 02:57:04 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id f33sm1446795pgl.33.2019.10.22.02.57.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 02:57:03 -0700 (PDT)
Date:   Tue, 22 Oct 2019 02:57:01 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] t7419: change test_must_fail to ! for grep
Message-ID: <6b788f92d2ef6f6cdaf6ea9f2bbe448ce19b2f58.1571737787.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to t/README, test_must_fail() should only be used to test for
failure in Git commands. Replace the invocations of
`test_must_fail grep` with `! grep`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
*sigh* Here's another cleanup patch for 'dl/submodule-set-branch'. It's
inspired by Eric Sunshine's comments on the t5520 patchset from earlier.
It's definitely not urgent, though, and can wait for v2.25.0.

 t/t7419-submodule-set-branch.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index c4b370ea85..fd25f786a3 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -34,7 +34,7 @@ test_expect_success 'submodule config cache setup' '
 
 test_expect_success 'ensure submodule branch is unset' '
 	(cd super &&
-		test_must_fail grep branch .gitmodules
+		! grep branch .gitmodules
 	)
 '
 
@@ -54,7 +54,7 @@ test_expect_success 'test submodule set-branch --branch' '
 test_expect_success 'test submodule set-branch --default' '
 	(cd super &&
 		git submodule set-branch --default submodule &&
-		test_must_fail grep branch .gitmodules &&
+		! grep branch .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		a
@@ -80,7 +80,7 @@ test_expect_success 'test submodule set-branch -b' '
 test_expect_success 'test submodule set-branch -d' '
 	(cd super &&
 		git submodule set-branch -d submodule &&
-		test_must_fail grep branch .gitmodules &&
+		! grep branch .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
 		a
-- 
2.24.0.rc0.197.g0926ab8072

