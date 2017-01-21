Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0291F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 21:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdAUV7t (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 16:59:49 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38714 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751424AbdAUV7j (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jan 2017 16:59:39 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3FF46280B0;
        Sat, 21 Jan 2017 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485035966;
        bh=Np78hdsRSfuH6iEcl0hzFrQq4STQxTWsvBbU73baXI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jK6piSq7wFelzDmAsCABiNjxEcEbrlWjvVn2Kcopn+NylBgrgDRGmdWsVjY1yxjh+
         mnsFMH8LfdymAvCvSUD7VGkOMUAwqTsBJRaBDazbyLefPJVErGX/MUp4c1B5IA67kR
         remAQz+iG3ZpL4AcFbTf4tq00FL4ru7vgYZ+pvgSCjPcrm8EoiKjaWiB0sMBWsXfsQ
         K261J+1eYaT3oXRM9rIKD9U2Drd5FDHOGfBHwc3rbFl1NITNBudWnItRSglnzTtR0m
         PRzpkqZS6tOIqOSMgBRcvxv+X1N0gEUk160aNIh3r5uX0rEix+zKnd5UMiDhHXXUF2
         XGV6JiajDA1YKdk3lMm5Xspzi5s3035Rxt1fF6w5otbsBOmM/bOukq6tUQvQkgGoSW
         GK3C4GyFrNjbxnflvgSqxszbRc7al7YqqsSkM87sxBRmcs/R9Hhm9dGe9suvvfs2mQ
         PvQvlIut7TyVCQrTRiOxmF0J6l9n8PMDdIgj1QH3hmkIz3eb6Pz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH 4/7] Documentation: sort sources for gitman.texi
Date:   Sat, 21 Jan 2017 21:59:09 +0000
Message-Id: <20170121215912.246691-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170121215912.246691-1-sandals@crustytoothpaste.net>
References: <20170121215912.246691-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorting the sources makes it easier to compare the output using diff.
In addition, it aids groups creating reproducible builds, as the order
of the files is no longer dependent on the file system or other
irrelevant factors.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a9fb497b8..6e6c82409 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -373,7 +373,7 @@ user-manual.pdf: user-manual.xml
 
 gitman.texi: $(MAN_XML) cat-texi.perl
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
+	($(foreach xml,$(sort $(MAN_XML)),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
 		--to-stdout $(xml) &&) true) > $@++ && \
 	$(PERL_PATH) cat-texi.perl $@ <$@++ >$@+ && \
 	rm $@++ && \
