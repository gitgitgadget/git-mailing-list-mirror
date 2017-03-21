Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04BC42095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757135AbdCUNBT (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:01:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34233 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757096AbdCUNAv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id u132so2774441wmg.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+ZohHEG7lcXTHh5LdACmdeoZ/Nyuyy/Mu3ku1p06kQ=;
        b=iDLcsDaDltzi8WSf3lioZ7REeyFvWMLbXa8iXlcBzZPGD/+XgNwW/JzwUbr1RMUrTU
         4iQFxFa0wlofvytD0QxKzcIDhbuOPsrX4lTM68+kzhd00HEaxmj8RxG5f4GDby1Rfoow
         r0V02CWyPMUs/4uLjrYwvqhK/XiuwCPpjJTrfd9k2ZvrEIA8ZX4FRKsj28buvs2zIOWK
         No6w9RVvQPz7SFMIE0w3jy723/VROHa0yXgHiSotQE9XqWhBIjHW0Z4tdqs1u3Eg3vwG
         O6fwRvbvYnlnJ/EJ5r6RcwIjJqguu0+DkGl0WJ6Pujh/kDjqHYdTsWh+gplptGfsH/vC
         Cmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+ZohHEG7lcXTHh5LdACmdeoZ/Nyuyy/Mu3ku1p06kQ=;
        b=nenGZkdO+EM2Vi45la6uMSJxolOHc33/mFWbDpYBhv5IacAoEdaSf8CmFcnQaB57vg
         Uy7eTSBr6kpliq7vxa4L7OGXGcLpu394Pi9hoU6d7yWJCCAysUo2v9LAMbAjiitMkYjV
         HbZAtX63gTWTTMfzISUyERCavb3lLXbSoljkxRy5726xbXJ37XTlwvSlrZinxn3xH+vJ
         rXlrM+E2TmEBAW2mTgQ5x/sU4CvqCmQyxadpULZS+WDD24fVlx1KUauO8WSNj+Hb9Aa3
         YnuJT8cMf4Mi23VV1o1P7fgxdX90E9Ri8UtN0+xIyQ5v/aOagjEY0O/05EPPFerf6P3a
         a2Og==
X-Gm-Message-State: AFeK/H1BgR2ljDm+CESWw3q4X3AVNpvp9vYZyknENeN4ZIQCcLzH9ZvMyoWIS6/Ifm0YqA==
X-Received: by 10.28.234.71 with SMTP id i68mr2877548wmh.81.1490101215675;
        Tue, 21 Mar 2017 06:00:15 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.06.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 06:00:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/16] tag tests: fix a typo in a test description
Date:   Tue, 21 Mar 2017 12:58:52 +0000
Message-Id: <20170321125901.10652-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "suceed" to "succeed" in a test description. The typo has been
here since the code was originally added in commit ef5a6fb597 ("Add
test-script for git-tag", 2007-06-28).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7004-tag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 830eff948e..63ee2cf727 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -136,7 +136,7 @@ test_expect_success \
 	'test $(git tag -l mytag) = mytag'
 
 test_expect_success \
-	'listing tags using a non-matching pattern should suceed' \
+	'listing tags using a non-matching pattern should succeed' \
 	'git tag -l xxx'
 
 test_expect_success \
-- 
2.11.0

