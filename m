Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 15862 invoked by uid 107); 2 Jun 2009 20:35:30 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 02 Jun 2009 16:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbZFBUfQ (ORCPT <rfc822;peff@peff.net>);
	Tue, 2 Jun 2009 16:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbZFBUfP
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 16:35:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:46001 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbZFBUfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 16:35:14 -0400
Received: by fg-out-1718.google.com with SMTP id d23so943980fga.17
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 13:35:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=50FyOGvOQdRyoNlQkLC7mZAigpv7MONZbrL4ZUifZ5k=;
        b=PE9BSthNxc7nrMGVeftKYnAhOWbaSyuWFG7aN2tz/+My4SGfuv8TTwSa3Q8PJlIb7l
         aJ2nXFFdzA1IqCPidzr4rzZBY6Thp6khDTBGhxYXKs6MqAlzUSx3Z1SIXGOzCMNAFop7
         fDst5tom89TTysR5opbzH2xzMikeqiXTZTpqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QkHDZZSiSNtFY+NgG2ezNCwhGo6Aer1OTQimlfuX9hjtsrW6gRYiynGQknhSXFthq/
         BfhyKRtlbHTVEkvdOs+RB9xdJDjx3khZ5TG5B2royR3l8wO5J/t4I4M6vKGTOwUImKJl
         BFRe5Thmfftm8WAmJL8APnktUXQJ1RY6GnUTA=
Received: by 10.86.59.2 with SMTP id h2mr223395fga.73.1243974914303;
        Tue, 02 Jun 2009 13:35:14 -0700 (PDT)
Received: from localhost (drsd-4db365ef.pool.einsundeins.de [77.179.101.239])
        by mx.google.com with ESMTPS id 4sm14845288fgg.28.2009.06.02.13.35.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 13:35:13 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Subject: [TopGit PATCH] help: use pager
Date:	Tue,  2 Jun 2009 22:35:12 +0200
Message-Id: <1243974912-3310-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.2.2.463.g124d4
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tg.sh b/tg.sh
index 8c174fb..4185ba2 100644
--- a/tg.sh
+++ b/tg.sh
@@ -269,7 +269,8 @@ do_help()
 		echo "TopGit v$TG_VERSION - A different patch queue manager"
 		echo "Usage: tg [-r REMOTE] ($cmds|help) ..."
 	elif [ -r "@cmddir@"/tg-$1 ] ; then
-		@cmddir@/tg-$1 -h || :
+		setup_pager
+		@cmddir@/tg-$1 -h 2>&1 || :
 		echo
 		if [ -r "@sharedir@/tg-$1.txt" ] ; then
 			cat "@sharedir@/tg-$1.txt"
-- 
tg: (b725fc9..) bw/use-pager-for-help-output (depends on: master)
