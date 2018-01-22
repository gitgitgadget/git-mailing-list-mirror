Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311D21F404
	for <e@80x24.org>; Mon, 22 Jan 2018 13:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeAVNcy (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 08:32:54 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35339 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeAVNcp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 08:32:45 -0500
Received: by mail-wr0-f194.google.com with SMTP id g38so8660537wrd.2
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 05:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qamKWnwSkSekllVVcrolORLWt44LVYRBAY75axwiQRo=;
        b=ITFAE3IrZGSD+Gx6Hc3/HEcYYAmp/TzutnxmjEyvg0VA5fA5tiJgs+1BEM7RQop5wX
         P7RCc01KCorpNDSsiqp9aCmMbcnZ4BFe3jTBfp2jSNRAQWAEgINeC5uuMkJZlRmAVB/T
         JFZYni2PcO5R1gnyEyK4cI6+YfsGeFw3+zxj7Z2Qr7Y0iwjgdGnVO7U0qIR3k7IxmsyG
         lDX0PgS+POPukgfLEWtDcpb2OPopl6IwLwbsPz6kg2aPdHgsKi4lZI7TvXiEG9thMdTn
         o30j5j4HSfjBWtQxpdB5Z1oP+9Qrz/9uvpfKpyGwvYxRJcqnvlugQKalPK6VFmTShuMA
         z2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qamKWnwSkSekllVVcrolORLWt44LVYRBAY75axwiQRo=;
        b=bJyff//xPzfp7+463ts7W0GHsd9cZ+p6EkGpCyWMZbhJaxgpjC/CvKEHAVjD1tCksv
         lAKvlHQvq1TdU0RBq7Wu1zqJnDzvErexRyr5DAGrRgTyX3ajd6BrAY/yuMSxjBaZLcL1
         8cYp2FDhMrfCx7q4DCdY8d5znIAvIrAHboBKp+2EeVJTc/v3qy+3yNa2qgGIDU17ZBc0
         SETPgsn7Dbyv0MAR4rsp4SMaHGrcAM6NaKJIqmrHhYzARwGyTSzUROtYh8diLwNO0LQD
         RT5TMqwQDKkRS9FlNYuq0X5KiJjn5iEsRgY7QPKg+S6g5ovDD4mqLUekWW+NU9fJgecC
         tqoQ==
X-Gm-Message-State: AKwxytdy+LGv6bN8U7b4YtcKcQy25FP7oZkox3U1kTF/VhvLzJe2C8ft
        U64cYoBl2qjYBt2ysqV6Ik4=
X-Google-Smtp-Source: AH8x224qpwg2NqIIyO6sb1LHZXPULQ/MnPA0WwflNzMCTOm5FJXZ5cHtNGq0Nraup2W5TZ/wEeJJqA==
X-Received: by 10.223.173.4 with SMTP id p4mr6087049wrc.182.1516627964340;
        Mon, 22 Jan 2018 05:32:44 -0800 (PST)
Received: from localhost.localdomain (x590e64ec.dyn.telefonica.de. [89.14.100.236])
        by smtp.gmail.com with ESMTPSA id c54sm24284520wrg.68.2018.01.22.05.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jan 2018 05:32:43 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/5] travis-ci: don't repeat the path of the cache directory
Date:   Mon, 22 Jan 2018 14:32:18 +0100
Message-Id: <20180122133220.18587-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.80.gc0eec9753d
In-Reply-To: <20180122133220.18587-1-szeder.dev@gmail.com>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
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
the container in an environment variable.  Furthermore, use the
variable in the container only if it's set, to prevent errors when
someone is running or debugging the Docker build locally, because in
that case the variable won't be set as there won't be any Travis CI
cache.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh        | 7 ++++---
 ci/run-build-and-tests.sh | 2 +-
 ci/run-linux32-build.sh   | 6 +++---
 ci/run-linux32-docker.sh  | 5 ++++-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 07f27c7270..1efee55ef7 100755
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
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index d3a094603f..30790e258d 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,7 +5,7 @@
 
 . ${0%/*}/lib-travisci.sh
 
-ln -s $HOME/travis-cache/.prove t/.prove
+ln -s "$cache_dir/.prove" t/.prove
 
 make --jobs=2
 make --quiet test
diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index 248183982b..c9476d6598 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -25,10 +25,10 @@ CI_USER=$USER
 test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER)
 
 # Build and test
-linux32 --32bit i386 su -m -l $CI_USER -c '
+linux32 --32bit i386 su -m -l $CI_USER -c "
 	set -ex
 	cd /usr/src/git
-	ln -s /tmp/travis-cache/.prove t/.prove
+	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
 	make --jobs=2
 	make --quiet test
-'
+"
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 4f191c5bb1..15288ea2cf 100755
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
 
-- 
2.16.1.80.gc0eec9753d

