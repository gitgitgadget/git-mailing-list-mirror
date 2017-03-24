Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA5C1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965629AbdCXSmL (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:42:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36231 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965044AbdCXSmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:42:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id x124so2253236wmf.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+ZohHEG7lcXTHh5LdACmdeoZ/Nyuyy/Mu3ku1p06kQ=;
        b=ON+H+u6Y0ZblAx0BkX9cX4Ej9wsxHjcLhIOfjLIxDkuCh9+V/P2RK4t13lHgV9vsk0
         R6yQUH+tZ6I74GPANaQv48868CEBcHHlC7GHqKGWWpQBx8k4hPl6DOR88n7K/IQhI6po
         FEAq2L/hVTXbnqQE6Gsa6CqTTwuWooCxJkX60w3/120PaqsJ9dRxWsjz8FdMd5vFI4Ht
         jhDgv+NWB71yZlXboEIclEeZSCAfVP9got4iobKOh5wCkre63yalT/Kn9x7tqFI3HDTC
         FTwhDOooHd0Qkdmw68m/b2M8aP5uNVKUBCQ1t6cO77Qqu2FtklLNWC0W13f/9NsFXmHt
         UXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+ZohHEG7lcXTHh5LdACmdeoZ/Nyuyy/Mu3ku1p06kQ=;
        b=VwbOZSwu1rySn7x/5/q+SHPiNGPrFH3ZUieWWs2MGb+w8aqOhUZWLWNPr/CAIhP9nO
         ZEnBzYLddnOukbpwc1GETStZEHPIOROQpaRqT4GHSp9a/Z87yxfibLl7JQN83db+FEhk
         JPhbgYvViNKK/l9P0kmh00ErsPIa6UgP/SkVmuAuvQhCv3ZIYZLm6qRGQPWSRwJRaJd2
         D0t1dl4SqlRBMXjaitjO07T925kN0swo4gwHSwq9U5lW1AfTB31RYecjZUCW+Bm0TfFj
         SmWLyBDVqW3XjgmDh+ZIIYPzJSP9omNe3k3fb0jqKPjSPfeOyB7o6UlmBeTNuM3B61Du
         r33w==
X-Gm-Message-State: AFeK/H2cnYUFXPTb4KRft4i6lj9vL2pfq73MtfABy5yMD1FapIJxFRK7anBlbrVPvvSHGg==
X-Received: by 10.28.87.6 with SMTP id l6mr4352620wmb.109.1490380893577;
        Fri, 24 Mar 2017 11:41:33 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:32 -0700 (PDT)
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
Subject: [PATCH v4 07/16] tag tests: fix a typo in a test description
Date:   Fri, 24 Mar 2017 18:40:50 +0000
Message-Id: <20170324184059.5374-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
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

