Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 21466 invoked by uid 111); 1 Oct 2008 20:12:19 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 01 Oct 2008 16:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbYJAUMM (ORCPT <rfc822;peff@peff.net>);
	Wed, 1 Oct 2008 16:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbYJAUML
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 16:12:11 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:59060 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751092AbYJAUML (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 16:12:11 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 216E22AC8DE; Wed,  1 Oct 2008 22:11:54 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	Petr Baudis <petr.baudis@novartis.com>
Subject: [PATCH] gitweb: Quote non-displayable characters in hex, not octal
Date:	Wed,  1 Oct 2008 22:11:54 +0200
Message-Id: <1222891914-24012-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

For the last 30 years, the mankind uses the octal representation of
characters only in rare cases and most character codes are hardly
recognizable in octal. In contrast, many programmers still know
hexadecimal well and that is also the representation of choice e.g.
for Unicode codepoints.

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index da474d0..1b5aa14 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -775,7 +775,7 @@ sub quot_cec {
 	);
 	my $chr = ( (exists $es{$cntrl})
 		    ? $es{$cntrl}
-		    : sprintf('\%03o', ord($cntrl)) );
+		    : sprintf('\%2x', ord($cntrl)) );
 	if ($opts{-nohtml}) {
 		return $chr;
 	} else {
-- 
tg: (c427559..) t/misc/quot-hex (depends on: vanilla/master)
