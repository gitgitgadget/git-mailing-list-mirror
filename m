Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875531F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbeCXHZT (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:25:19 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46612 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeCXHZR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:25:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id j68-v6so21349836lfg.13
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+M/0/oYiRJxNpCluntdYs0tbDIUdkXwm1P7iOXaIc28=;
        b=nAFUmUGC8YKQinySP9rNADsKdvTLY8+X7Mpk6C7IBwdXYDQswT98SX3LgsIOl3NZTb
         uMWwQsacQWJskLoQkJ3RNqQh1IPOT+C6Ry5kGzhdBXUmcYwO30YU1TNVOXgOMAzPtKRm
         i+YpnT5kq5bkiAkhhSknPnzw6LMwcVV2o7Gf3Hij/k//Wk4MwswPNKZAO3O/5GqLDzC4
         9aQk2Ud838GJu0hVlQPR2pIYFxZwqx2IyjEWtKaz+yEA8ZewerVJRinwxnGYHWfvFBWl
         M8CfPKMHGHHfC9YRXdUYElFKoafBxDDB8QpenVrGZs1Hu48oqH+l/RprAVn1oK5PZzch
         L97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+M/0/oYiRJxNpCluntdYs0tbDIUdkXwm1P7iOXaIc28=;
        b=i/yj11qL39VPU28QT3r0tmPrm6Z/pd75vmoYNi5i/1+vNtArIzh7CBLMg+ltwHnQXA
         qqTp8LtuOZBcmA77QD1ZyFCABiKOaH6yegjFEiWqZek9mETFU56GnPiXfhhmfF6uyRHE
         0KRlP3uTGq5nPTl8AMiye+ah9/oYvrsMUg/T4lFbnaoDhqx7Ys5vmlwd4juSg/6YRz4B
         Vtda+svE16WGlndoAFYX2EUfqMM4zrmwhxfyMPpdV4mS0IIIF9qjozLT3CMGExvUXvKl
         JNChy1ZXjWyFEMe2d2gS2V1vIDFi/RNFBpYEDGAWCT1J4GnJKGQvJHua/b1Gn5urOJ9b
         +JaA==
X-Gm-Message-State: AElRT7GSYxYU24dpC0xyz/F//gskCV0fKnJyAXmPgpttz/wquVjtxYZl
        LxWineaZmL+sQmi4I9ZqQgw=
X-Google-Smtp-Source: AG47ELtwsttRulHEDwqjuFMPKqxlLWXvVC8yGBaIxrmSBEaOl4yBGVJdaRZ6c7VGAqtQ4hazJWKoUA==
X-Received: by 10.46.137.203 with SMTP id c11mr22083178ljk.61.1521876316656;
        Sat, 24 Mar 2018 00:25:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b67-v6sm2684028lfh.26.2018.03.24.00.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:25:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 1/7] t7700: have closing quote of a test at the beginning of line
Date:   Sat, 24 Mar 2018 08:25:01 +0100
Message-Id: <20180324072507.21059-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324072507.21059-1-pclouds@gmail.com>
References: <20180316192745.19557-1-pclouds@gmail.com>
 <20180324072507.21059-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The closing quote of a test body by convention is always at the start
of line.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7700-repack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 6061a04147..38247afbec 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -194,7 +194,7 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
 	git repack -a -d &&
 	git cat-file -t $H1
-	'
+'
 
 test_done
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

