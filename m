Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3444E1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 13:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeDFNP1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 09:15:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53382 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeDFNP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 09:15:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id p9so3451893wmc.3
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 06:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TXM8jt6x1rri/yyixEtBxS9hVnwJcWSiyA+lay/9PBo=;
        b=UMLieIT5jx73F5Y4FmI3hCT/0QQKJvpGW8iUR+69QPkQQ8AmOcUMMTNLE7ezY985Wf
         bE59Sac5RWEoVh3RMlH0KFIu05sAd7qB1+xLlGcruWIx8oDrwpyBFjbJtzwLMAjmycur
         MOFOantwAlRij+sJV4u2i0RgygrOLR0o0Ia4RIJvrIbdmOxSAPnPfldGJKBP8Cdplk86
         PnabcfiLlaLsP1X6uA+OOR4Ks2JlzY5qPkeQCZ01WnMbJDo5T54VGTuajVPJ+VGBtn21
         kb42UYs4Dp58mRvbMGHA2aa90sVzhOtQC2PtOfpgGZy18H0PmCfpp7JFYVrnAOTtZWxw
         MYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TXM8jt6x1rri/yyixEtBxS9hVnwJcWSiyA+lay/9PBo=;
        b=WKGGjwvlht3eD8svB6JcKWLTDzimBYYSz6kg80L7V/zqL9ju+c9DRlsblIov0P821S
         BypS6E2TMbcMDwOXX705PY3y7NH/AKoJ1UeOAgJRms6JdV4fblOQ9bsc71Tzya37vy6k
         IdE3cglNFRsyUz5Z627pWkDynrEXYZ83dE0vcH3ySdBhMiJ76MFhghg9bmdNGH9WRSkW
         jso3dr0YleimjUQvmLw6erhg+eJ2BxlVZW/TSbYl1XG2GwiCTlO23sOS5LLEI3pXNJXf
         eKC5K6dnNVB/NceBAVeKV81zLsQYaXUAFjpwwo4m3bLv3nOYUx2EMpdwnKr0OdABcZz7
         bzgA==
X-Gm-Message-State: ALQs6tBAqkIj6rNTOvd+ltwk6T0MginRH7v+3vx5Q6zj2/Ab+uYqihwa
        /kIDunswqmJEVUMfYkI7+zufDdt7
X-Google-Smtp-Source: AIpwx4+4KNN7buCPGlcuoNha2bBBZ0quRgjmybtPds9ilByAAL7Ctz2GnpnPvLiCTZhXBwkdQcsBbw==
X-Received: by 10.28.126.20 with SMTP id z20mr12933005wmc.152.1523020524300;
        Fri, 06 Apr 2018 06:15:24 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s15sm8827911wrg.28.2018.04.06.06.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 06:15:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Joseph Mingrone <jrm@ftfl.ca>,
        garga@FreeBSD.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] git-svn: avoid warning on undef readline()
Date:   Fri,  6 Apr 2018 13:15:14 +0000
Message-Id: <20180406131514.740-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565
In-Reply-To: <86h8oobl36.fsf@phe.ftfl.ca>
References: <86h8oobl36.fsf@phe.ftfl.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code in Git.pm that sometimes calls chomp() on undef to only do
so the value is defined.

This code has been chomping undef values ever since it was added in
b26098fc2f ("git-svn: reduce scope of input record separator change",
2016-10-14), but started warning due to the introduction of "use
warnings" to Git.pm in my f0e19cb7ce ("Git.pm: add the "use warnings"
pragma", 2018-02-25) released with 2.17.0.

Since this function will return undef in those cases it's still
possible that the code using it will warn if it does a chomp of its
own, as the code added in b26098fc2f ("git-svn: reduce scope of input
record separator change", 2016-10-14) might do, but since git-svn has
"use warnings" already that's clearly not a codepath that's going to
warn.

See https://public-inbox.org/git/86h8oobl36.fsf@phe.ftfl.ca/ for the
original report.

Reported-by: Joseph Mingrone <jrm@ftfl.ca>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 16ebcc612c..6b6079c456 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -554,7 +554,7 @@ sub get_record {
 	my ($fh, $rs) = @_;
 	local $/ = $rs;
 	my $rec = <$fh>;
-	chomp $rec if defined $rs;
+	chomp $rec if defined $rs and defined $rec;
 	$rec;
 }
 
-- 
2.17.0.rc1.321.gba9d0f2565

