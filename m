Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838071F461
	for <e@80x24.org>; Wed,  3 Jul 2019 10:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfGCKsF (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 06:48:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40401 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfGCKsF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 06:48:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so1829300wmj.5
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xg6mTTm5clE7WilKC7HpEb3NdQw0911UJzhqHjBsU3w=;
        b=WjtvQqeyTaIZWXQlm6NhhOvLB/9CuZQpGd6yGXge6UGZ2gwqSk4+T0ysbb07tIz2TL
         N/SXt/Pmd6051rNzkHGtANt+Bi9hZB4EItxQAVQpB1zZYtpABEQG8wr0ZBfau28zSbSK
         RP37hCaNSy/XgyCcFBMfAYVHpVSdBAdf9Z/tQdJC0u04+yDJopMLi050Xq8NKMfmCOz8
         6alZpHcbcmQbnH+mttFjwzwdchKINoz+Re4lRZIrLQF4jZ4MLd5entviNlJyu6PVmHFn
         Ty8Wh9/5jWE9zWcWAoS38MsAhJtieM6VB4RKZFMNpH/RHrptfgzOxe3kQKvvW6b7jmek
         Fdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xg6mTTm5clE7WilKC7HpEb3NdQw0911UJzhqHjBsU3w=;
        b=mtjOqt90S5gNkNx1nEdZOyJf35Q1mE9sYbaZlXOLQ6nUrgj70ttDMGD13QhmqDQppu
         sTLh946mhq4e6f1Oj9n9v1y4jpZrYf8gzQeJkb6lBpjItjFtQHE+ABULQ10Fi8/zVBkD
         nFOYtNEpOpLoKDHncT/Vsp/zLmdyZrFAHtOxtLHHTkdSK1ck89huPwG4X11Av6ZE9Ykv
         QTEUWm6OGgWDaZ8qNC5tdMp8TYVkxMnAhimPSxqyjZ0NEapkZwOtPEhm8IamAibt+BWC
         pYgASqKmjEPS+GQeYGk0GUotxQzFYMVLBtPfq5caRPzTshlsID7d2d+3kkIMfYpAv148
         KWoQ==
X-Gm-Message-State: APjAAAWOTuVrHluFQjGHljPj0xheKQX8rPKxWUUtjBoMjciYMXLgUCYc
        +C9CjQRcawgbmXw4hXC/DHP2in7v
X-Google-Smtp-Source: APXvYqwLL331ahetzpYd3wGVH170xqIgFPTFUf9oMksMEeY2pds1BfwoPtK93WrUOaGjFM8i+RhpXw==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr7098830wmh.134.1562150882843;
        Wed, 03 Jul 2019 03:48:02 -0700 (PDT)
Received: from localhost.localdomain (x4db51bef.dyn.telefonica.de. [77.181.27.239])
        by smtp.gmail.com with ESMTPSA id h84sm2168562wmf.43.2019.07.03.03.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jul 2019 03:48:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] ci: don't update Homebrew
Date:   Wed,  3 Jul 2019 12:47:47 +0200
Message-Id: <20190703104748.32533-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.621.ge52941b842.dirty
In-Reply-To: <20190629170108.GF21574@szeder.dev>
References: <20190629170108.GF21574@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lately our GCC macOS build job on Travis CI has been erroring out
while installing dependencies with:

  +brew link gcc@8
  Error: No such keg: /usr/local/Cellar/gcc@8
  The command "ci/install-dependencies.sh" failed and exited with 1 during .

Now, while gcc@8 is still pre-installed (but not linked) and would be
perfectly usable in the Travis CI macOS image we use [1], it's at
version 8.2.  However, when installing dependencies we first
explicitly run 'brew update', which spends over two minutes to update
itself and information about the available packages, and it learns
about GCC 8.3.  After that point gcc@8 exclusively refers to v8.3,
and, unfortunately, 'brew' is just too dumb to be able to do anything
with the still installed 8.2 package, and the subsequent 'brew link
gcc@8' fails.  (Even 'brew uninstall gcc@8' fails with the same
error!)

Don't run 'brew update' to keep the already installed GCC 8.2 'brew
link'-able.  Note that in addition we have to 'export
HOMEBREW_NO_AUTO_UPDATE=1' first, because 'brew' is so very helpful
that it would implicitly run update for us on the next 'brew install
<pkg>' otherwise.

Disabling 'brew update' has additional benefits:

  - It shaves off 2-3mins from the ~4mins currently spent on
    installing dependencies, and the macOS build jobs have always been
    prone to exceeding the time limit on Travis CI.

  - Our builds won't suddenly break because of the occasional Homebrew
    breakages [2].

The drawback is that we'll be stuck with slightly older versions of
the packages that we install via Homebrew (Git-LFS 2.5.2 and Perforce
2018.1; they are currently at 2.7.2 and 2019.1, respectively).  We
might want to reconsider this decision as time goes on and/or switch
to a more recent macOS image as they become available.

[1] 2000ac9fbf (travis-ci: switch to Xcode 10.1 macOS image,
    2019-01-17)

[2] See e.g. a1ccaedd62 (travis-ci: make the OSX build jobs' 'brew
    update' more quiet, 2019-02-02) or

    https://public-inbox.org/git/20180907032002.23366-1-szeder.dev@gmail.com/T/#+u

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 7f6acdd803..7f546c8552 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -34,7 +34,7 @@ linux-clang|linux-gcc)
 	popd
 	;;
 osx-clang|osx-gcc)
-	brew update >/dev/null
+	export HOMEBREW_NO_AUTO_UPDATE=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
 	test -z "$BREW_INSTALL_PACKAGES" ||
-- 
2.22.0.621.ge52941b842.dirty

