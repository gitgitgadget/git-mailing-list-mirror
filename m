Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785FE1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031825AbeBNWW3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:22:29 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45292 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031793AbeBNWWV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:22:21 -0500
Received: by mail-wr0-f193.google.com with SMTP id h9so1466817wre.12
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqSnYHpm6zr+C/p0+JzjtWuXq+cFsEbxHn6ymr1w11Y=;
        b=WLaoWdp1lUikCYaaZCyTgE9fg9FVqPfGpEKQQLtF1eBiyniXoPSe4XaW0kl1yvDLbh
         vn5W2D1IS3UYV1+yNpwy78C6SF1jlQwf29csLoFai7IdVHAq5opBlkOSRVoEvjfNxQpL
         h18QF8wDeBAlIsp1jss/GbORlaHHzfQWNyyChulF7rACdt83Y1shbl61sI9JQJFyQvsc
         ef/SFCj52xI6FZkTliR8b+CGH+aiUcdDZPak2Nn12NNuG+6d5TXlS3EC7bEEW7EtAdDC
         RJAwGddvyDVy6Ikr7X2naX3MORQ78mCmWyv08dRXR1YiK3a2h8JIYVq5ixXH8kG0uZ5k
         dGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqSnYHpm6zr+C/p0+JzjtWuXq+cFsEbxHn6ymr1w11Y=;
        b=FlpRkRAoD1ePnhDkW87HOL3ov15IJ0QX0762zGMLzp48WV1M0x2DVh1R84jH1JTsi1
         Qz8/7YvcPBtT9lyWqmuKZWt2gXm99+OfNlf79sxN+TVFvujCRnbQdem3BEWFHbZsT0ON
         11zCi39zVGuvJ3aBN5nRwlXWuZA2qRZ6teuPw/K7ICwCV+VWxmnY4sVftHuPFTEWs6yU
         M1YZ33tZucNOtHlqa6WJnAN2tNzL7rrNfI5LMouVkouH5FIb9HOTO1VT3CJmpjGOXb0T
         HJN5ekmij0ksKzPY9bCyeu+0vrbJYR04c4lo4aHMAh9L8NDPtAc6EQSC5VFuID9Lk0lH
         1zAg==
X-Gm-Message-State: APf1xPA6d6fvcb/1vcOwvLdRom4OURELUTXaCvetOzAPTI6P+y/598rU
        59t4Zai7ZdbCFRVs7uolHkvCX/QE
X-Google-Smtp-Source: AH8x227+CQKWzB40tGPNh6aHzeNZTpe0A3jUco5Ms6gyatiAe0oFbnXa0RlU88PrjeKe9bjPs5kCjA==
X-Received: by 10.223.208.208 with SMTP id z16mr658308wrh.46.1518646939434;
        Wed, 14 Feb 2018 14:22:19 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a14sm13191356wrf.22.2018.02.14.14.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 14:22:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/8] perl: hard-depend on the File::{Temp,Spec} modules
Date:   Wed, 14 Feb 2018 22:21:46 +0000
Message-Id: <20180214222146.10655-9-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180214222146.10655-1-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since my d48b284183 ("perl: bump the required Perl version to 5.8 from
5.6.[21]", 2010-09-24), we've depended on 5.8, so there's no reason to
conditionally require File::Temp and File::Spec anymore. They were
first released with perl versions v5.6.1 and 5.00405, respectively.

This code was originally added in c14c8ceb13 ("Git.pm: Make File::Spec
and File::Temp requirement lazy", 2008-08-15), presumably to make
Git.pm work on 5.6.0.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git.pm | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 8e02ee2cca..221e827e83 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1324,8 +1324,9 @@ sub _temp_cache {
 }
 
 sub _verify_require {
-	eval { require File::Temp; require File::Spec; };
-	$@ and throw Error::Simple($@);
+	require File::Temp;
+	require File::Spec;
+	return;
 }
 
 =item temp_reset ( FILEHANDLE )
-- 
2.15.1.424.g9478a66081

