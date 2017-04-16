Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1814B20D09
	for <e@80x24.org>; Sun, 16 Apr 2017 22:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbdDPWVq (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 18:21:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34381 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbdDPWVo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 18:21:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id z129so3870452wmb.1
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CIYHn5i5UdP8FeejUbmZ+jUQHAS2ZqfcU25GP16+p5U=;
        b=i9dXOn/axforefFb/Gti8eU2hO/KOUjucNIHGSEO+R8OoWnGkT/wtgQYlQ/hTbjPEr
         orvCPdkhy1SGFNYhBUCiKrrSHUkCI1Ly3Fx9wEt5gq44vHj1y04SbHo84vvibcSWQAZd
         Oig2Vc/SvQZGWsFZS9u/biJURDKClpT6SOYz2EWB+4N4vfuyGCJm9kUbw8IGIGYDmT8R
         jySIRfz5qc8CZBG3oqeubj5esAxnRpNuYahUtUY2LHatapwvxzUc+6Y/SW/IAzIyG5hU
         EZ05T4oHkcSNPBJj6dGQYZJU50kxyDJhKia82nProK68o/zJMLCRJPy1MFVd59DXpisF
         UwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CIYHn5i5UdP8FeejUbmZ+jUQHAS2ZqfcU25GP16+p5U=;
        b=N/jCT9lKlqQFpzEvQwKJDKTJSOOg3nP5eSGuG4WyMIktPzyGg186lAf8n+1oRcq8mg
         cc6o5t+9GY/fJ0e+j4wF6p3LoytcktgWz7l7GromEzUC17nUbZWeDR6qJodFSI9I4drC
         A1YSR/pBUuJsx9ftwMzWlA8tooixudz3hM00Uetp+Tk88o8YpvKWCEMCPbVn1PAnIj+5
         Nkyow4/+3+CebvolAhDwtC+zEmTOFEslFbnPkzNwZcrtnQ2lEgFzxQwqweoz4D/UFGdC
         p2kgHh6jqLPME51PDeBwFms5y93+Q3Aae0At/8w5Im6lefk/fz1G9zVgn3fPpXMh8pCM
         rXaQ==
X-Gm-Message-State: AN3rC/4lpXoVtofysx1Fnet4LprKrzvj7HQ1s1rDArMs030/nWXMHWrc
        84hNu+3Sx/cL9g==
X-Received: by 10.28.169.15 with SMTP id s15mr6454404wme.2.1492381297892;
        Sun, 16 Apr 2017 15:21:37 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o9sm8045022wmd.4.2017.04.16.15.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 15:21:37 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] pack-objects: fix buggy warning about threads under NO_PTHREADS=YesPlease
Date:   Sun, 16 Apr 2017 22:21:01 +0000
Message-Id: <20170416222102.2320-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170416222102.2320-1-avarab@gmail.com>
References: <20170416222102.2320-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a buggy warning about threads under NO_PTHREADS=YesPlease. Due to
re-using the delta_search_threads variable for both the state of the
"pack.threads" config & the --threads option setting "pack.threads"
but not supplying --threads would trigger the warning for both
"pack.threads" & --threads.

Solve this bug by resetting the delta_search_threads variable in
git_pack_config(), it might then be set by --threads again and be
subsequently warned about, as the test I'm changing here asserts.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 4 +++-
 t/t5300-pack-object.sh | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 84af7c2324..905465e91f 100644
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
index 6bb6a8981b..50e1ae87a4 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -445,8 +445,7 @@ test_expect_success !PTHREADS,!GETTEXT_POISON 'pack-objects --threads=N or pack.
 	git -c pack.threads=2 pack-objects --stdout --all </dev/null >/dev/null 2>err &&
 	cat err &&
 	grep ^warning: err >warnings &&
-	test_line_count = 2 warnings &&
-	grep "no threads support, ignoring --threads" err &&
+	test_line_count = 1 warnings &&
 	grep "no threads support, ignoring pack\.threads" err &&
 	git -c pack.threads=2 pack-objects --threads=4 --stdout --all </dev/null >/dev/null 2>err &&
 	grep ^warning: err >warnings &&
-- 
2.11.0

