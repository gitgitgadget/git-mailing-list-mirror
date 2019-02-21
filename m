Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A521F453
	for <e@80x24.org>; Thu, 21 Feb 2019 19:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfBUT3E (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 14:29:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53942 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfBUT3D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 14:29:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id e74so10088199wmg.3
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 11:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j5D9OoOe0Xr2OQHa2pYMKmHQkJXZW/yqiXHHgMpb3Cc=;
        b=ontvspfKgi9EOcHcLvrk60xfsH2nPgnnRUS9r03G3t9dedRFCiIW10ku+o1P0loK79
         8roA9SpErfXEkdGelSymmF04HWTzn4gfsK/8r6vskA8kyX0p/lt6yH/pvttN2rNjEOB1
         JsnLOgBeXcyeGgJeFZgUPi3qqSRLjbko5ZD4COfroMWY/IZLwFSicCBj7ylfnSP22qOy
         96hdYmWoWOmTORFPOn4LotJzSgxUJOxFfCD1eaP6qjnG0o+oDqu++vLItmfhBVhG6rIg
         y3AfyIFhWMse1l5wkbhpV1fzIvddKp0AOQbb+/iE0j/yzutxK5otYwHhvFQAzOJ3jDFT
         bwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5D9OoOe0Xr2OQHa2pYMKmHQkJXZW/yqiXHHgMpb3Cc=;
        b=ZpUVwDPRt+lumr5e8D3HQgW96AbC4h++5BnNwE7Km6aLHcaLkXbY3nUnNk68wF8jwn
         X05BmRBkopBUPju3aR8kDI9Sc0vdtqg7GSVdelW8r5IF4yYJ83be8KhuAbnilXqGfjda
         U+e0PisSPTgVEohaJkBpvXLqqiHLyAUy+9K5m57mg55X5nonMqUTG1fGKL6l86XbqH2p
         HVGGw2rOcLnaP0Ydxa9EE+C4Uz/Epy91La7i38APm2Q/PENH6cX7joC3jeVExXqm0isi
         T86TTH+mDgF1yjf7tyx4TyND6V5iTtM9jx7604alM5hDiOSoVa+ztDKcn0EkOttHUCSk
         MSOA==
X-Gm-Message-State: AHQUAub8KD1rfHFKF6xlVV3ES6mN/opz21JCB5LmpPMk1wKkriSYIsYE
        bMxLheyLocu/UFfxc/jzwg5aArj+
X-Google-Smtp-Source: AHgI3IZ0qP1QWicd6YoxnGn03sznYwsLGBHxn5J77YtXspKCDcvNbzc8a4xtFdgMMyFiZja51T1tuQ==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr63540wmd.89.1550777341101;
        Thu, 21 Feb 2019 11:29:01 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm35237429wrq.58.2019.02.21.11.29.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 11:29:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Staudt <koraktor@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] tests: fix unportable "\?" and "\+" regex syntax
Date:   Thu, 21 Feb 2019 20:28:48 +0100
Message-Id: <20190221192849.6581-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix widely supported but non-POSIX basic regex syntax introduced in
[1] and [2]. On GNU, NetBSD and FreeBSD the following works:

    $ echo xy >f
    $ grep 'xy\?' f; echo $?
    xy
    0

The same goes for "\+". The "?" and "+" syntax is not in the BRE
syntax, just in ERE, but on some implementations it can be invoked by
prefixing the meta-operator with "\", but not on OpenBSD:

    $ uname -a
    OpenBSD obsd.my.domain 6.2 GENERIC#132 amd64
    $ grep --version
    grep version 0.9
    $ grep 'xy\?' f; echo $?
    1

Let's fix this by moving to ERE syntax instead, where "?" and "+" are
universally supported:

    $ grep -E 'xy?' f; echo $?
    xy
    0

1. 2ed5c8e174 ("describe: setup working tree for --dirty", 2019-02-03)
2. c801170b0c ("t6120: test for describe with a bare repository",
   2019-02-03)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6120-describe.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index ee5b03ee18..2b883d8174 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -146,7 +146,7 @@ check_describe A-* HEAD
 test_expect_success 'describe works from outside repo using --git-dir' '
 	git clone --bare "$TRASH_DIRECTORY" "$TRASH_DIRECTORY/bare" &&
 	git --git-dir "$TRASH_DIRECTORY/bare" describe >out &&
-	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+$" out
+	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+$" out
 '
 
 check_describe "A-*[0-9a-f]" --dirty
@@ -156,7 +156,7 @@ test_expect_success 'describe --dirty with --work-tree' '
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
 	) &&
-	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+$" out
+	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+$" out
 '
 
 test_expect_success 'set-up dirty work tree' '
@@ -170,7 +170,7 @@ test_expect_success 'describe --dirty with --work-tree (dirty)' '
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
 	) &&
-	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+-dirty$" out
+	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+-dirty$" out
 '
 
 check_describe "A-*[0-9a-f].mod" --dirty=.mod
@@ -180,7 +180,7 @@ test_expect_success 'describe --dirty=.mod with --work-tree (dirty)' '
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty=.mod >"$TRASH_DIRECTORY/out"
 	) &&
-	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+.mod$" out
+	grep -E "^A-[1-9][0-9]?-g[0-9a-f]+.mod$" out
 '
 
 test_expect_success 'describe --dirty HEAD' '
-- 
2.21.0.rc0.258.g878e2cd30e

