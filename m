Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B7B1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 17:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeA2RRa (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 12:17:30 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36132 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeA2RR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 12:17:28 -0500
Received: by mail-wr0-f194.google.com with SMTP id d9so8093639wre.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 09:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HPB+aBHsvFX2C4Cgpe9o2+QzMuL29V53LrAefwNRRI=;
        b=lnwzUFT+nzrHpweY810HFJCk4SnaNvjEtaDHMds0xNJLoJv5aBsZzHKGNPyWo1kCsZ
         HJG6ahbGRKGf5k4/yOF4E5X7cGw1roKrPCCZ6DbbAgjk/s4DRWCOv5ypUNBI8hgXzdp+
         UZ4sAB9XCfia4bFWyPWiMhRz7C2ImMWYcf8tPgRHfSWp+927ZVARIM4oSpfXKDTd9ulG
         M9LiWTzLzMopHuX4uGwJfgWu4HmNGWEj/6iXJ1iO90UaScF+Ky1NIiOZnn4jbw8bERm0
         Sdn1zLX5fk46qFExePAaecRk1d5YLSTVKdnmfglTS7n+FM7wYZ4TNNN0sfWRXvDThfKC
         yYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HPB+aBHsvFX2C4Cgpe9o2+QzMuL29V53LrAefwNRRI=;
        b=qL5+n0s3hQBIwvjaqeAsgYKEqZPJCuqoKuiiSvM1lcDPdS8fGqYypwTWQFS9TBgCqj
         YliwV1bh/9fZdOx20Pd7kLlf1miX5cCZAoOhOIDgHp2BODbqow+V2A26nF/NL2/w5cMc
         g5WuG/0UFAyf7mKxOdB7V7Nw2yyT5916sNMzrpXD9lNJkKAeQxYqF0rSc0oQ5CYvkFSW
         mgd4iEFd9B7kD04NYer1RQXvFuE8LWl7LA2ZGi84c47nHnEdnLPAIAA539HExrRD0mOK
         LlrvZsZcA9dZbH7SL+xCCdfuCVKZ7sgnCccOL530SGDnoolW2SUqnAtTMtH0HS8Z1+5I
         KRZw==
X-Gm-Message-State: AKwxytctFJ3xiRNI/KBjuMvsiF9eWFJSikDCDOtCDVabIwQBuw+kCyrb
        +6U2/x5iYl//+kKfxGl90w8=
X-Google-Smtp-Source: AH8x227PTB7hlcqimX4xh0L8rNuyTA0iXbmsDRp+0Zl/c7+Q3Y3d6ETeErL6tOlgmakOqTPc2scWmA==
X-Received: by 10.223.182.165 with SMTP id j37mr7653826wre.85.1517246246974;
        Mon, 29 Jan 2018 09:17:26 -0800 (PST)
Received: from localhost.localdomain (x590c5617.dyn.telefonica.de. [89.12.86.23])
        by smtp.gmail.com with ESMTPSA id p21sm4050876wmc.28.2018.01.29.09.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jan 2018 09:17:26 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 3/5] travis-ci: don't repeat the path of the cache directory
Date:   Mon, 29 Jan 2018 18:17:11 +0100
Message-Id: <20180129171713.17471-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180129171713.17471-1-szeder.dev@gmail.com>
References: <20180129171713.17471-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of our 'ci/*' scripts repeat the name or full path of the Travis
CI cache directory, and the following patches will add new places
using that path.

Use a variable to refer to the path of the cache directory instead, so
it's hard-coded only in a single place.

Pay extra attention to the 32 bit Linux build: it runs in a Docker
container, so pass the path of the cache directory from the host to
the container in an environment variable.  Note that an environment
variable passed this way is exported inside the container, therefore
its value is directly available in the 'su' snippet even though that
snippet is single quoted.  Furthermore, use the variable in the
container only if it's been assigned a non-empty value, to prevent
errors when someone is running or debugging the Docker build locally,
because in that case the variable won't be set as there won't be any
Travis CI cache.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh       | 7 ++++---
 ci/run-linux32-build.sh  | 2 +-
 ci/run-linux32-docker.sh | 5 ++++-
 ci/run-tests.sh          | 3 ++-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 07f27c727..1efee55ef 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -21,8 +21,6 @@ skip_branch_tip_with_tag () {
 	fi
 }
 
-good_trees_file="$HOME/travis-cache/good-trees"
-
 # Save some info about the current commit's tree, so we can skip the build
 # job if we encounter the same tree again and can provide a useful info
 # message.
@@ -83,7 +81,10 @@ check_unignored_build_artifacts ()
 # and installing dependencies.
 set -ex
 
-mkdir -p "$HOME/travis-cache"
+cache_dir="$HOME/travis-cache"
+good_trees_file="$cache_dir/good-trees"
+
+mkdir -p "$cache_dir"
 
 skip_branch_tip_with_tag
 skip_good_tree
diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index 248183982..d020b762c 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -28,7 +28,7 @@ test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER)
 linux32 --32bit i386 su -m -l $CI_USER -c '
 	set -ex
 	cd /usr/src/git
-	ln -s /tmp/travis-cache/.prove t/.prove
+	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
 	make --jobs=2
 	make --quiet test
 '
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 4f191c5bb..15288ea2c 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -11,6 +11,8 @@ docker pull daald/ubuntu32:xenial
 # $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
 # root@container:/# /usr/src/git/ci/run-linux32-build.sh
 
+container_cache_dir=/tmp/travis-cache
+
 docker run \
 	--interactive \
 	--env DEVELOPER \
@@ -18,8 +20,9 @@ docker run \
 	--env GIT_PROVE_OPTS \
 	--env GIT_TEST_OPTS \
 	--env GIT_TEST_CLONE_2GB \
+	--env cache_dir="$container_cache_dir" \
 	--volume "${PWD}:/usr/src/git" \
-	--volume "${HOME}/travis-cache:/tmp/travis-cache" \
+	--volume "$cache_dir:$container_cache_dir" \
 	daald/ubuntu32:xenial \
 	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
 
diff --git a/ci/run-tests.sh b/ci/run-tests.sh
index 22355f009..deba73d9b 100755
--- a/ci/run-tests.sh
+++ b/ci/run-tests.sh
@@ -5,7 +5,8 @@
 
 . ${0%/*}/lib-travisci.sh
 
-ln -s $HOME/travis-cache/.prove t/.prove
+ln -s "$cache_dir/.prove" t/.prove
+
 make --quiet test
 
 check_unignored_build_artifacts
-- 
2.16.1.158.ge6451079d

