Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1CF21F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 07:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJGOpq (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 10:45:46 -0400
Received: from mx.mylinuxtime.de ([195.201.174.144]:52008 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeJGOpq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 10:45:46 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Oct 2018 10:45:45 EDT
Received: from leda.eworm.de (tmo-109-100.customers.d1-online.com [80.187.109.100])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 501F0A7530;
        Sun,  7 Oct 2018 09:31:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 501F0A7530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1538897474; bh=3U+GlRvoAEKDisUoz38fSaJ5nIhzcdnv30ewdPtg7fw=;
        h=From:To:Cc:Subject:Date;
        b=gGMoL9B5BoR3MfkWIz1BweMCqMB7PVPTAprN0GzSwrRewc9p0cEQZyg0MA27PFo9i
         4L4mgf5aIciqIXP0xiZCnXos2SrISKj5KEPYN9eHLH7/fm7M92TJy3rtR4GuSB3Oy+
         LL/O2JFSCIivO4+siGoKu5FetNiLabgKrb/UjS9E=
Received: by leda.eworm.de (Postfix, from userid 1000)
        id 537DA1026C7; Sun,  7 Oct 2018 09:30:42 +0200 (CEST)
From:   Christian Hesse <list@eworm.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] subtree: add build targets 'man' and 'html'
Date:   Sun,  7 Oct 2018 09:30:36 +0200
Message-Id: <20181007073036.30643-1-list@eworm.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=smtp-only@eworm.de smtp.mailfrom=eworm@leda.eworm.de
X-Rspamd-Server: mx
X-Stat-Signature: 979p1myg45ngadthemoaustxs7edejjk
X-Rspamd-Queue-Id: 501F0A7530
X-Spamd-Result: default: False [1.78 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_DN_ALL(0.00)[];
         RCPT_COUNT_TWO(0.00)[2];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-2.79)[-0.930,0];
         FORGED_SENDER(0.30)[list@eworm.de,eworm@leda.eworm.de];
         RCVD_TLS_LAST(0.00)[];
         ASN(0.00)[asn:3320, ipnet:80.187.0.0/16, country:DE];
         FROM_NEQ_ENVFROM(0.00)[list@eworm.de,eworm@leda.eworm.de];
         BAYES_HAM(-0.63)[82.35%];
         RCVD_COUNT_TWO(0.00)[2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Hesse <mail@eworm.de>

We have targets 'install-man' and 'install-html', let's add build
targets as well.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 contrib/subtree/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 5c6cc4ab2c..6906aae441 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -59,6 +59,10 @@ $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
 
 doc: $(GIT_SUBTREE_DOC) $(GIT_SUBTREE_HTML)
 
+man: $(GIT_SUBTREE_DOC)
+
+html: $(GIT_SUBTREE_HTML)
+
 install: $(GIT_SUBTREE)
 	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
 	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(gitexecdir)
