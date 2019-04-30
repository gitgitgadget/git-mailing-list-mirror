Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877481F45F
	for <e@80x24.org>; Tue, 30 Apr 2019 12:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfD3Mhj (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 08:37:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35943 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfD3Mhi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 08:37:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id o4so8890184wra.3
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SpxPfQklDxEqtA/fmfK+FLcQcuRu/F8DzkrLtlOLq3U=;
        b=gl9rzKEpG/7V+UpM/ARFnVVf90KgSfAN9axTLR5iPt05nUrW2BRuJtN1nCww2BqL9l
         eDhEJ3Y6i9WzafqzQz8av97sPRIyTjd4dZjChgP8cXwtk9sCEm9a33+TPQuJqSe6xcdh
         pRev2aZKY8RkfjRmlgfoyHEcg1LTMvFwqix41IfsyYyrBHGcxQAWKkDvdDz1kSmVX4av
         ap62uum6jHllTLuaxlVBQ+MG3TvhXaUJ6+u5Xiag05Fuf1Qbl0UkUXT6E1psTGp9WUQ+
         ELRvip5GO+PyLCwG4eVClg1YnKsnq5sr60zH3SGMm485vwxkJROtMmV5cXDhJPNl5gWc
         XKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SpxPfQklDxEqtA/fmfK+FLcQcuRu/F8DzkrLtlOLq3U=;
        b=s7f6PoP6DDxKcY/HeTT7yx7dq2X0fulcOYyPoCEITrW7SD2S6TM6TGZZ0e778wVbTt
         V5qdvWDFngJHdEdVKQiks8uuEyAZL4gRk+8vLWTSOfsTcvSqpfeec62lPn36c22nM6aM
         d3jvVK9ds7e1GAaFjQj0YkVD10+Tni1oE3rhJJSLPLfvLG2ZDE69/UXvr7gNLO2GMulH
         5AyguqDX9U6JXFaMywaOu7gnpwY8mnMo/O98ALeqUhE+FpLe0ZBjmqaSDotalMN00GNd
         a13wv/d+siR6Jxr0zOpMVT8mIQyCE9VxcmPZ2TEOFYtnT/Br3bQfjyu/0bbk0tMUejk2
         1pKw==
X-Gm-Message-State: APjAAAUchvKoTxgqcxxROlacubfJowI0uy6YKJHj5MFc+s8PDy44XTsI
        6k70e1/I5WM9o6+RVBPZqMf5A/nZ
X-Google-Smtp-Source: APXvYqxGtSc9JRDuiyoBSRx6YSio+yllJE6RG7Z7u4AHXy26BXJMloyvWY6HDrkY4RDD1eN0k2qG8w==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr6461852wrq.23.1556627857074;
        Tue, 30 Apr 2019 05:37:37 -0700 (PDT)
Received: from localhost.localdomain (x4dbd75f4.dyn.telefonica.de. [77.189.117.244])
        by smtp.gmail.com with ESMTPSA id o6sm70279690wre.60.2019.04.30.05.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Apr 2019 05:37:36 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, Lars Schneider <larsxschneider@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] ci: install 'libsvn-perl' instead of 'git-svn'
Date:   Tue, 30 Apr 2019 14:37:24 +0200
Message-Id: <20190430123724.16150-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.1181.g24122a4251
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since e7e9f5e7a1 (travis-ci: enable Git SVN tests t91xx on Linux,
2016-05-19) some of our Travis CI build jobs install the 'git-svn'
package, because it was a convenient way to install its dependencies,
which are necessary to run our 'git-svn' tests (we don't actually need
the 'git-svn' package itself).  However, from those dependencies,
namely the 'libsvn-perl', 'libyaml-perl', and 'libterm-readkey-perl'
packages, only 'libsvn-perl' is necessary to run those tests, the
others arent, not even to fulfill some prereqs.

So update 'ci/install-dependencies.sh' to install only 'libsvn-perl'
instead of 'git-svn' and its additional dependencies.

Note that this change has more important implications than merely not
installing three unnecessary packages, as it keeps our builds working
with Travis CI's Xenial images.  In our '.travis.yml' we never
explicitly specified which Linux image we want to use to run our Linux
build jobs, and so far they have been run on the default Ubuntu 14.04
Trusty image.  However, 14.04 just reached its EOL, and Travis CI has
already began the transition to use 16.04 Xenial as the default Linux
build environment [1].  Alas, our Linux Clang and GCC build jobs can't
simply 'apt-get install git-svn' in the current Xenial images [2],
like they did in the Trusty images, and, consequently, fail.
Installing only 'libsvn-perl' avoids this issue, while the 'git svn'
tests are still run as they should.

[1] https://blog.travis-ci.com/2019-04-15-xenial-default-build-environment

[2] 'apt-get install git-svn' in the Xenial image fails with:

      The following packages have unmet dependencies:
       git-svn : Depends: git (< 1:2.7.4-.)
      E: Unable to correct problems, you have held broken packages.

    The reason is that both the Trusty and Xenial images contain the
    'git' package installed from 'ppa:git-core/ppa', so it's
    considerably newer than the 'git' package in the corresponding
    standard Ubuntu package repositories.  The difference is that the
    Trusty image still contains these third-party apt repositories, so
    the 'git-svn' package was installed from the same PPA, and its
    version matched the version of the already installed 'git'
    package.  In the Xenial image, however, these third-party
    apt-repositories are removed (to reduce the risk of unrelated
    interference and faster 'apt-get update') [3], and the version of
    the 'git-svn' package coming from the standard Ubuntu package
    repositories doesn't match the much more recent version of the
    'git' package installed from the PPA, resulting in this dependecy
    error.

    Adding back the 'ppa:git-core/ppa' package repository would solve
    this dependency issue as well, but since the troublesome package
    happens to be unnecessary, not installing it in the first place is
    better.

[3] https://docs.travis-ci.com/user/reference/xenial/#third-party-apt-repositories-removed

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 52a44c690a..7f6acdd803 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -12,7 +12,7 @@ case "$jobname" in
 linux-clang|linux-gcc)
 	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
 	sudo apt-get -q update
-	sudo apt-get -q -y install language-pack-is git-svn apache2
+	sudo apt-get -q -y install language-pack-is libsvn-perl apache2
 	case "$jobname" in
 	linux-gcc)
 		sudo apt-get -q -y install gcc-8
-- 
2.21.0.1181.g24122a4251

