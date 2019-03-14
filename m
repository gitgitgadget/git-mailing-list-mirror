Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ECDE20248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfCNMfD (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:35:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50567 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfCNMfC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:35:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id x7so2804105wmj.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5NrsLsVGVoc8FeFrZjYyWQIpmPIbiuwhdb5AhRsdiI=;
        b=BcDTnbuG1GjoR1R8iuksSOdx1rPtiBgO0bPVoSUIgPxIhiikuz83vnkUGOKRYUzQru
         ohe79vXi3cHg2mspLPq6dX4mHUCIgP52cX0ltyW10JZMc7SjQnuIV/2KrAx9ahTuM19T
         t+6PDa5v6ZKUSmIJ8yH4zF8HuTiEYn7dNThfu4fsK53jzi0hioCyJlzI2LMG7MwynBaG
         7gEm1LwpITJ6MjreWFw3PKXaxbUMSHv/aSLRYW+HQMF8H0p8QzCgR3nQA731a+otNWgu
         x84Ix6zvjz44I8aJwY0hLLnTPJ0t/1KaGY8CYaC0Fmd1svGMKVcmrQwG3bT83FmzAxRE
         Mb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5NrsLsVGVoc8FeFrZjYyWQIpmPIbiuwhdb5AhRsdiI=;
        b=aEtkn8xRze2pq34w1Z0DiAnOtv4JqIkPRF6BenBzC41Z90+to6w8gtDLmfJVLMnWdB
         rVWYQPGgeZddRS6W7TzczzKHSYYVfWrdwK4n4Gev+sJVihhvasV9B1Dv1SElLQ2VseH3
         k6prB98u+Lk1I2oczSDRnhvO0BU3WswXguLbXQxU5t2xwbwM4lxv9IEMa6tstm5jXC0i
         nqt5XSsltAs1L40gVcL+8Ku/yu+kmzclWG0iB9Mb3/DD8gJh+UOHn+PBaEdc+67tVWsN
         WumRIgZwdmStsM1bO47zDMNxokRlZjfXQwBhSztH2TmcIfJf4fgu1oF/cdkj/sXmqDYW
         tmgw==
X-Gm-Message-State: APjAAAWHvbyPMeyqjvSj88BWOdT/8RMJJWEKAIIRr91+km48da+TEQy7
        zRLyPFztCO5mL177EaE50Vr2bsNMClM=
X-Google-Smtp-Source: APXvYqws0yNN5vPZQB8f+Sq2h/rCPCOtSo6OTNaRVxmONBkFHC2HcDuVKcY+XiOgDxSi+yv6d6eLzw==
X-Received: by 2002:a7b:cd03:: with SMTP id f3mr2399051wmj.130.1552566899972;
        Thu, 14 Mar 2019 05:34:59 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p6sm42374095wre.63.2019.03.14.05.34.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 05:34:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/7] reflog: exit early if there's no work to do
Date:   Thu, 14 Mar 2019 13:34:37 +0100
Message-Id: <20190314123439.4347-6-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190313235439.30439-1-avarab@gmail.com>
References: <20190313235439.30439-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When gc.reflogExpire and gc.reflogExpireUnreachable are set to "never"
and --stale-fix isn't in effect (covered by the first part of the "if"
statement being modified here) we can exit early without pointlessly
looping over all the reflogs.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c  | 7 +++++++
 t/t1410-reflog.sh | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4d3430900d..d95c77ca0e 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -606,6 +606,13 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			putchar('\n');
+	} else if (!cb.cmd.expire_total && !cb.cmd.expire_unreachable) {
+		/*
+		 * If we're not expiring anything and not dropping
+		 * stale entries, there's no point in even opening the
+		 * reflogs, since we're guaranteed to do nothing.
+		 */
+		return 0;
 	}
 
 	if (do_all) {
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 42f5ac9ed9..b98827f082 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -235,7 +235,9 @@ test_expect_success 'gc.reflogexpire=never' '
 	test_config gc.reflogexpire never &&
 	test_config gc.reflogexpireunreachable never &&
 
-	git reflog expire --verbose --all &&
+	git reflog expire --verbose --all >output &&
+	test_line_count = 0 output &&
+
 	git reflog refs/heads/master >output &&
 	test_line_count = 4 output
 '
-- 
2.21.0.360.g471c308f928

