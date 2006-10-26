X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Fix up bogus $stylesheet declarations
Date: Thu, 26 Oct 2006 14:41:25 +0200
Message-ID: <20061026124125.12865.28172.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Thu, 26 Oct 2006 12:41:37 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.10
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30206>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd4Y8-0008Fi-2H for gcvg-git@gmane.org; Thu, 26 Oct
 2006 14:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423468AbWJZMl2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 08:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423471AbWJZMl2
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 08:41:28 -0400
Received: from rover.dkm.cz ([62.24.64.27]:58045 "EHLO rover.dkm.cz") by
 vger.kernel.org with ESMTP id S1423468AbWJZMl1 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 08:41:27 -0400
Received: from [127.0.0.1] (rover [127.0.0.1]) by rover.dkm.cz (Postfix) with
 ESMTP id D934A8BC1E; Thu, 26 Oct 2006 14:41:25 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This seems to be a pre-++ residual declaration and it wasn't good for
anything at all besides flooding the webserver errorlog with "omg, our in
the same scope!!" warnings.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d737b2b..1d91f7f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -51,10 +51,6 @@ our $site_footer = "++GITWEB_SITE_FOOTER
 
 # URI of stylesheets
 our @stylesheets = ("++GITWEB_CSS++");
-our $stylesheet;
-# default is not to define style sheet, but it can be overwritten later
-undef $stylesheet;
-
 # URI of default stylesheet
 our $stylesheet = "++GITWEB_CSS++";
