Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4BA2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 21:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933124AbdCUVIU (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 17:08:20 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34186 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758194AbdCUVIS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 17:08:18 -0400
Received: by mail-pf0-f175.google.com with SMTP id p189so61685137pfp.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XBC57pSAmvnkV72h25KkcGZ9PTv2Dk7Bz1zn9P6l3TQ=;
        b=ETreLtq9v9gp59LraWFpFwJ4FAiDvr+paCjXWeiBL6fITBYmCbx+bv4HUu9QikaIsA
         HTrhDv0WEwr8VSGTp1JYq/SvqRs3sHOXBgZkQQVAXDCzjjybfJIzJqu3/fRsVohQEexz
         cl5OAAl2Xg17cfb8i/BHn+tyio1IXhRrrNX2zcSrALIYC+dOqQqUF0uIrSA1bsb6vpoc
         zC0DaBuR/YUlXfB5ImM5zoYRqG5/c333582lMvMvx/13L120rUjPC86hlA9iji+0uc6u
         pesLsJk4V78BfIHv/U3tj/uz1ISl0zPkH3U3FDBbOBwEWWdoyqhivqqFtY0BraHPenZO
         zdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XBC57pSAmvnkV72h25KkcGZ9PTv2Dk7Bz1zn9P6l3TQ=;
        b=NcEKp0RBbgam4lVADe9ANwE2cPz4Z7cW0xG5uX29viFykOA/+R7t+8gCzt7O1D1hyl
         1/S6fhtkGH0/YRB2nWNyWpkCJL57tdPrpMMTxT7iL1R7vdL8foI86QSdXAxseTKZw//6
         KNH+wgLQ/TrW39jm6wTp8Cz0TXMEJjvkHOgKbtJ1USjebdoJrrsc+JqoMbZAulGSkd79
         g9vrK4Aw2wcyq6bXAtgrpwA2drUEC+51pCA+mGY/h6Nob+Qs4W56kxlcxX+I+jP69lQS
         Y/KZu39U1B9OiskLB6a8hK9sPO9tGgOpfsM3KjxHi+044FnAXnjtQcjEB9xz7xsN1SD5
         71/Q==
X-Gm-Message-State: AFeK/H06V8GbuYZQQ/rB+lh5RSKJ+xQdAau1GSvm+cDUihtyAitqAU15yvz/mNJkBBNZTFhs
X-Received: by 10.98.87.1 with SMTP id l1mr23263020pfb.92.1490130487001;
        Tue, 21 Mar 2017 14:08:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b114:ae16:71df:23b2])
        by smtp.gmail.com with ESMTPSA id e7sm41616518pgp.2.2017.03.21.14.08.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 14:08:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] t3600: rename test to describe its functionality
Date:   Tue, 21 Mar 2017 14:08:02 -0700
Message-Id: <20170321210802.9675-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.386.gf8442ebc0a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was an oversight in 55856a35b2 (rm: absorb a submodules git dir
before deletion, 2016-12-27), as the body of the test changed without
adapting the test subject.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t3600-rm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 5aa6db584c..1f87781e94 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -658,7 +658,7 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 	test_cmp expect actual
 '
 
-test_expect_success 'rm of a populated nested submodule with a nested .git directory fails even when forced' '
+test_expect_success 'rm of a populated nested submodule with a nested .git directory absorbs the nested git dir' '
 	git reset --hard &&
 	git submodule update --recursive &&
 	(cd submod/subsubmod &&
-- 
2.12.1.386.gf8442ebc0a.dirty

