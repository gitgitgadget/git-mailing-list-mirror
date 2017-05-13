Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 264D020188
	for <e@80x24.org>; Sat, 13 May 2017 23:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758852AbdEMXQm (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:42 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36784 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758798AbdEMXQg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:36 -0400
Received: by mail-qk0-f195.google.com with SMTP id y128so12509134qka.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ez/44xm3UAaN1Rc/9O0aq12mszsXbdcwX1KL6wShc9Q=;
        b=JMKC5XfT2ka3dYm/g99MysB478Q5pZGEA5uM+JEr/vv1mO8nH4ATEE0OERsvSwS9aY
         aYnkXiV20jC9ABitNAqWnGb+fpM8GUDO2zKWmpQ5N/JfBRtDHb6aRuL4tTXu0q9xTZNK
         cob5xmCvPz0ri1ai0hrk23JMi3HmvTLbjBEGRViIxyN1/PTdLPNjiOiLVvmdayO/5tw2
         7v8unuPz2WYTYZXVFSdqJhdyMW5y/Voj7o6L8y5UdC5J8Q9mSNxur4GziYyDAyHrrJ/n
         SfKNvsNEPfqmfXCsfw97hMXxTPUlXFgGH1QbkJri0eFX9qIIbYWx9ZN0F8eDvYxfZN61
         m7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ez/44xm3UAaN1Rc/9O0aq12mszsXbdcwX1KL6wShc9Q=;
        b=EYRitIs8AWkCH2L2KNos8ezypnyTHwUQ6rLRLFlakpWK5ZHwZ2FgkoAqKNtgYlMx0J
         XHVBKxLZ/WWeTKDBJ69DTYNoDl/SZGbrTTGWczdo0STYKytVJHzm/iOXCBXXkEzwgmzZ
         yHk3FnL9vLjKKVjRljIM4RjjxQTgwc9McpsLRQzNBHxddcqfjp+eGXli+IlZw1s1RVqn
         ojF/+NCYfKCo1c2QtFf7sU6SsAUka93T8bDOe9irjwO9+heEGcJXngD1lAC87R/+tplg
         J5ShrKYlAkpMP0r+DcglTyMVcDNOjKtkVZplIzLc7upeHkfPy5yxHGqa07uRDryTYZu6
         aTPA==
X-Gm-Message-State: AODbwcBCfUEIVrKWalREdl/FTnk3qT3p0pTiZ5mRomdoYrgjRY4KMUp3
        nTV2P8P5PfTnew==
X-Received: by 10.55.181.194 with SMTP id e185mr1253162qkf.195.1494717395867;
        Sat, 13 May 2017 16:16:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/29] perf: emit progress output when unpacking & building
Date:   Sat, 13 May 2017 23:14:55 +0000
Message-Id: <20170513231509.7834-16-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the t/perf/run output so that in addition to the "Running N
tests" heading currently being emitted, it also emits "Unpacking $rev"
and "Building $rev" when setting up the build/$rev directory & when
building it, respectively.

This makes it easier to see what's going on and what revision is being
tested as the output scrolls by.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/run | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index b61024a830..beb4acc0e4 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -24,6 +24,7 @@ run_one_dir () {
 
 unpack_git_rev () {
 	rev=$1
+	echo "=== Unpacking $rev in build/$rev ==="
 	mkdir -p build/$rev
 	(cd "$(git rev-parse --show-cdup)" && git archive --format=tar $rev) |
 	(cd build/$rev && tar x)
@@ -37,6 +38,7 @@ build_git_rev () {
 			cp "../../$config" "build/$rev/"
 		fi
 	done
+	echo "=== Building $rev ==="
 	(
 		cd build/$rev &&
 		if test -n "$GIT_PERF_MAKE_COMMAND"
-- 
2.11.0

