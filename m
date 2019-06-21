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
	by dcvr.yhbt.net (Postfix) with ESMTP id AF62F1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 10:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfFUKS2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 06:18:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37774 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFUKS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 06:18:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so6009772wme.2
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRctIvxPgB9PE0jpv4WdLCspT34W7igX1nCADTy4g68=;
        b=d5bY0gLNGnfdWvUNe2/OpN1VOyyFiCGiE+1vsuRztaIzfEoPjWXyuq3nj2JL/Jfihc
         bEAQSdq1J+XitmcOANDWQ3jlF72nW8/McJdudSnSfu1j+spnVNgIX9HPxkqQxOiCF+SL
         /RmehYLK3IQF56JUpVXT05GJt7iBJaC5+qoe+OYLVqwAnHWFP8ChwQa0ImXS7+oRxsFy
         9F1nWbiBCIpA3UFf1RS+IdlKSgWIiK6w5dljUovbKVhyR+C7Xr69gtUeUUZPcQqdQ1g5
         Duk9y+JF4FNqaEgJY/FAk2czoGSTahrjiPYUN8+8jIkkccoRC+cwc5dEf94W+lSlH2kt
         t0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRctIvxPgB9PE0jpv4WdLCspT34W7igX1nCADTy4g68=;
        b=lp9V6JNlbq6diJtOBS6g7qSz1icfZ6ZjhA+01WpBG740aStcGBK81blaHtz3dbl13b
         0mX29CBmSJefMwblQoX3/QByw7El6WPLD9KEjtg+QP7o5RD9FYlM1/KShuOUqETNUngE
         j45puWXgMDmjx2Nj+0DQS+0EED5Cc4bptrTa8HLTtjoPxmOAT/mJQvkM0oIqsI1nlaVf
         DqeTZrCJ8W0AEEr76+wanEXF0Kj+vsqOsHYf+mrJmL6vhvcASPkhBY6h3zMEK7/s87zT
         OOJ1opdOY2n4huKlMyBILfr22ZorULFWJELj0TVr2dqUZk3pIRuMRbSIeGUFStB+kD4t
         ZsAA==
X-Gm-Message-State: APjAAAWkwRCL2EByukshv37Rcg9Sj9qnMPoxjsWH9Wk1sZUf3sRUKthL
        HNgP0XjFXJ9l2Q8dHWC8SJNAxBO6af8=
X-Google-Smtp-Source: APXvYqwV2LKMKmaNoJmjEFEFmXk0Whxw1+hJED2o7E1LGt6m4Pc2UuKhYFN4sLoAfSwX1A8Yy5h0SA==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr3503920wmc.159.1561112305152;
        Fri, 21 Jun 2019 03:18:25 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y184sm1878193wmg.14.2019.06.21.03.18.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 03:18:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/8] config tests: simplify include cycle test
Date:   Fri, 21 Jun 2019 12:18:05 +0200
Message-Id: <20190621101812.27300-2-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190620210915.11297-1-avarab@gmail.com>
References: <20190620210915.11297-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify an overly verbose test added in 9b25a0b52e ("config: add
include directive", 2012-02-06). The "expect" file was never used, and
by using .gitconfig it's not as intuitive to reproduce this manually
with "-d" as some other tests, since HOME needs to be set in the
environment.

Also remove the use of test_i18ngrep added in a769bfc74f ("config.c:
mark more strings for translation", 2018-07-21) in favor of overriding
the GIT_TEST_GETTEXT_POISON value.

Using the i18n test wrappers hasn't been needed since my
6cdccfce1e ("i18n: make GETTEXT_POISON a runtime option", 2018-11-08).
As a follow-up change to the yet-to-be-added t0017-env-helper.sh will
show, doing it this way can hide a regression when combined with
trace2's early config reading. That early config reading was added in
bce9db6de9 ("trace2: use system/global config for default trace2
settings", 2019-04-15).

So let's remove the testing for that potential regression here, I'll
instead add it explicitly to t0017-env-helper.sh in a follow-up
change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1305-config-include.sh | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 579a86b7f8..6b388ba2d0 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -310,20 +310,13 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icas
 '
 
 test_expect_success 'include cycles are detected' '
-	cat >.gitconfig <<-\EOF &&
-	[test]value = gitconfig
-	[include]path = cycle
-	EOF
-	cat >cycle <<-\EOF &&
-	[test]value = cycle
-	[include]path = .gitconfig
-	EOF
-	cat >expect <<-\EOF &&
-	gitconfig
-	cycle
-	EOF
-	test_must_fail git config --get-all test.value 2>stderr &&
-	test_i18ngrep "exceeded maximum include depth" stderr
+	git init --bare cycle &&
+	git -C cycle config include.path cycle &&
+	git config -f cycle/cycle include.path config &&
+	test_must_fail \
+		env GIT_TEST_GETTEXT_POISON= \
+		git -C cycle config --get-all test.value 2>stderr &&
+	grep "exceeded maximum include depth" stderr
 '
 
 test_done
-- 
2.22.0.455.g172b71a6c5

