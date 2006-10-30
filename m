X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: esc_html() author in blame
Date: Mon, 30 Oct 2006 12:37:54 -0800 (PST)
Message-ID: <20061030203755.5021.qmail@web31810.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 30 Oct 2006 20:43:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=G5WBmaRWFU0pLHhHHLY+T3B9gvv5P56vT3d4d7fDJuds7nXoYoH2ZRcndln8sc/kCg9FEw20m0GX9x/xIyO9FPtGyB/bTIIVLGTDwioFEAkFjQJbpLjezK3viowZWJ+Ptw4eds+7N6md4oOhtJgZ8HQUvKpm0IwoHkNgwxQ0zXc=  ;
X-YMail-OSG: cCtRhwcVM1nDqAA7QAg6NiaoHQ.GaRkS5VB3KmCva4h2sk0Ih4hPncPrm8XmcoI.EdOnZsbJeyGCnIuP.BnugigZc8oRASwr0JtyqpIlFRaz8kpe8XevGq4bqzHnKkMk3dzz1.nJfSTxUw--
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30521>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gedtf-0004Xd-TH for gcvg-git@gmane.org; Mon, 30 Oct
 2006 21:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932478AbWJ3Uh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 15:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWJ3Uh6
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 15:37:58 -0500
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:14008 "HELO
 web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP id S932466AbWJ3Uh5
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 15:37:57 -0500
Received: (qmail 5025 invoked by uid 60001); 30 Oct 2006 20:37:55 -0000
Received: from [64.215.88.90] by web31810.mail.mud.yahoo.com via HTTP; Mon,
 30 Oct 2006 12:37:54 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Blame fails for example on
block/ll_rw_blk.c at v2.6.19-rc3.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c52e19d..177efd3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2751,7 +2751,7 @@ HTML
 		print "<tr class=\"$rev_color[$current_color]\">\n";
 		if ($group_size) {
 			print "<td class=\"sha1\"";
-			print " title=\"$author, $date\"";
+			print " title=\"". esc_html($author) . ", $date\"";
 			print " rowspan=\"$group_size\"" if ($group_size > 1);
 			print ">";
 			print $cgi->a({-href => href(action=>"commit",
-- 
1.4.3.3.g1e64f-dirty
