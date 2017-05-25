Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96CF1209FD
	for <e@80x24.org>; Thu, 25 May 2017 19:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036754AbdEYTrw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34726 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970177AbdEYTrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id d127so55401584wmf.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQWnLKNWhyTp7Nc77ZC/TbdN/LUk9101kJEBIodtHTg=;
        b=fHSRtlRSrzs93r1PI0DBSR83wuJ4EopNI/UwjxUu2WNCZK20RpPun4DUdYbLzEyzwU
         ntSc/9T8kf62PhKZXwJO4faIbhrPfImFVPjTFCHlYTmVq+BrOFmL5bwEvlGGh1OnCgtq
         BqmmpvxaqyneK3Ud/RojuasoK3MeQqS/qPZmHJPrbnMDxSrbvI5NcyQ91ie9bIKqZs1K
         rg7biO5uunKPmWve8hmQoBMtYJVjebeDdEjBS2I77ja5hvhQUiiG7Rn+Is3xd96fDsoK
         OdZN4zd6on6NbKcxAz6k/rfL8ysursXzrUMx9tyK2JB+m88EO0bDm7pf9xxr5BD5+eA0
         YVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQWnLKNWhyTp7Nc77ZC/TbdN/LUk9101kJEBIodtHTg=;
        b=aAYkTQX8/poXidOIIb+huga4P8iy/H0AQdfDtgtrV+RtTD1Dx+d+dbi/R6tcs1CWb5
         MOBblvqtPoqw6dBFltUWI2mXp9Jbzm7NX7hVL6s42H2q/1c8PvkfaaSPqe2hgkir38LL
         8pq2eM8/7476w8z6U5QBMuFDwFVOnUbVDv0MKMVeAft0+sefHPkqgOd8AYUHXdLpWDZU
         EBgSe6inIH5jyO9lyf7LdICHN97g8uw+8ixUQxikEBnmNLpy8r4BzKnoTNJECFHAyYSy
         QjU1aqv+KnMdNCJTtaHxH9xzGjSu8qoCpfWGGkoXEa27AY/Z/3ur75r145AQmyyWex0b
         XkLg==
X-Gm-Message-State: AODbwcBjSetZaerp2YFcHUYXbmQ1DvO7Moso/E7HKxSe3T1iOOpf6g2t
        4R4HnJ+a4/QKCw==
X-Received: by 10.223.152.9 with SMTP id v9mr28460962wrb.8.1495741651090;
        Thu, 25 May 2017 12:47:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:47:30 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 29/31] pack-objects: fix buggy warning about threads
Date:   Thu, 25 May 2017 19:45:33 +0000
Message-Id: <20170525194535.9324-30-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a buggy warning about threads under NO_PTHREADS=YesPlease. Due to
re-using the delta_search_threads variable for both the state of the
"pack.threads" config & the --threads option, setting "pack.threads"
but not supplying --threads would trigger the warning for both
"pack.threads" & --threads.

Solve this bug by resetting the delta_search_threads variable in
git_pack_config(), it might then be set by --threads again and be
subsequently warned about, as the test I'm changing here asserts.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 4 +++-
 t/t5300-pack-object.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9b4ba8a80d..efa21a15dd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2472,8 +2472,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			die("invalid number of threads specified (%d)",
 			    delta_search_threads);
 #ifdef NO_PTHREADS
-		if (delta_search_threads != 1)
+		if (delta_search_threads != 1) {
 			warning("no threads support, ignoring %s", k);
+			delta_search_threads = 0;
+		}
 #endif
 		return 0;
 	}
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 6ed23ee1d2..9c68b99251 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -447,7 +447,7 @@ test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.
 
 	git -c pack.threads=2 pack-objects --stdout --all </dev/null >/dev/null 2>err &&
 	grep ^warning: err >warnings &&
-	test_must_fail test_line_count = 1 warnings &&
+	test_line_count = 1 warnings &&
 	grep -F "no threads support, ignoring pack.threads" err &&
 
 	git -c pack.threads=2 pack-objects --threads=4 --stdout --all </dev/null >/dev/null 2>err &&
-- 
2.13.0.303.g4ebf302169

