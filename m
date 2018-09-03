Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD5D1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeICTKM (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:10:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42382 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTKM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so922854wrr.9
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xD9Xh+WDbwZKB6DRrIh3bpDDyNvNOhY9estOOSEjAxY=;
        b=mJ+aDw0uc6p4UKkkpn/7nkx1dbvwrGJrVKou98QLV8fQOWmGNrnENvTo1+fhaTLgUr
         6aVaQvu3lICaEpLjeraFg9MnSQibq+hc98sWztnyd7Vl4GYPK27Bx6Fa/IZSR7x68n3a
         uhSqk9q5+ggYhXUoqH7jpz33CEIgcwygHTm4T03pyeI+aQWjh4sHyhuVAWEgVeNnIl4K
         PP6VCNlzE76wZ50KHRXj4xCRWRin/Kj9AOZurBX8nZKQFQksRsSQSCJiLpxgagCSkW+H
         5jT4qRryfq3BYI0Fr9gWyrW80XDK+Igx3RnsbPjzG64o2zyNbZI4zcpRM0IKKoTLTVzb
         mkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xD9Xh+WDbwZKB6DRrIh3bpDDyNvNOhY9estOOSEjAxY=;
        b=rOU1PkKqmSCcrsyfOzHuoCVepWio8X8oIhcQUHrGEase1QJtJF34qDAYsq76iV9VAa
         irD7KPyixOAhg7b4W/iROec9KwTdsQIrPiBkMvVIUMSMDR/AHyo15LNViNS7zs1Zybbs
         KdH5GO/TYDJeFxLY2vrFkyfRPn6hSLoLYDPADPzufqzki5Lx0EBESrDcDzWSCGOzf6JX
         8oXo9Xzgo1m35rOo4KnwvjpofdSzEqCcyfEue5w6d/UgWSFB7muDnTf5jVHJ6nRo00bN
         sMidRpp9mVPL4rXRyTe0pkYx9vG2lUaO70AjtDdW+n1tT+LiYZSrpiNwel4lJ1TuljhB
         f80Q==
X-Gm-Message-State: APzg51AohRc61CRquRNn9v6SLtPAS6+Q1hnKO4EVC7+WQoj66Em3HFsT
        XlU1k5pRqFt0mpsktQVsqaG1uDQ0
X-Google-Smtp-Source: ANB0Vda8ylMinC9gXfIU2G6q08aE+v383ymaHM84OoezbovWcXXS/Ot055+XidYSgZvT2AmXDmCriw==
X-Received: by 2002:adf:82b4:: with SMTP id 49-v6mr18260257wrc.252.1535986180465;
        Mon, 03 Sep 2018 07:49:40 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e133-v6sm23841649wma.33.2018.09.03.07.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:49:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/10] fsck tests: setup of bogus commit object
Date:   Mon,  3 Sep 2018 14:49:19 +0000
Message-Id: <20180903144928.30691-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
References: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several fsck tests used the exact same git-hash-object output, but had
copy/pasted that part of the setup code. Let's instead do that setup
once and use it in subsequent tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5504-fetch-receive-strict.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 62f3569891..6d268f3327 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -133,6 +133,10 @@ committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 This commit object intentionally broken
 EOF
 
+test_expect_success 'setup bogus commit' '
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)"
+'
+
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
 	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
@@ -142,7 +146,6 @@ test_expect_success 'fsck with invalid or bogus skipList input' '
 '
 
 test_expect_success 'push with receive.fsck.skipList' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
@@ -169,7 +172,6 @@ test_expect_success 'push with receive.fsck.skipList' '
 '
 
 test_expect_success 'fetch with fetch.fsck.skipList' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	refspec=refs/heads/bogus:refs/heads/bogus &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
@@ -204,7 +206,6 @@ test_expect_success 'fsck.<unknownmsg-id> dies' '
 '
 
 test_expect_success 'push with receive.fsck.missingEmail=warn' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
@@ -232,7 +233,6 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 '
 
 test_expect_success 'fetch with fetch.fsck.missingEmail=warn' '
-	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	refspec=refs/heads/bogus:refs/heads/bogus &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
-- 
2.19.0.rc1.350.ge57e33dbd1

