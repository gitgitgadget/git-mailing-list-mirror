From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] config.c: fix a compiler warning
Date: Wed, 16 Apr 2014 16:13:53 +0200
Organization: <)><
Message-ID: <20140416141353.GA9676@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 16:19:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaQgg-0001mX-Nw
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 16:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161285AbaDPOTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 10:19:37 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54933 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161077AbaDPOTg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 10:19:36 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Apr 2014 10:19:36 EDT
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 15BB51C00AD
	for <git@vger.kernel.org>; Wed, 16 Apr 2014 16:13:54 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3GEDroS009681
	for <git@vger.kernel.org>; Wed, 16 Apr 2014 16:13:53 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3GEDr7P009680
	for git@vger.kernel.org; Wed, 16 Apr 2014 16:13:53 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246333>

Date: Thu, 10 Apr 2014 16:37:15 +0200

This change fixes a gcc warning when building msysGit.
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 314d8ee..0b7e4f8 100644
--- a/config.c
+++ b/config.c
@@ -572,7 +572,7 @@ static void die_bad_number(const char *name, const char *value)
 
 int git_config_int(const char *name, const char *value)
 {
-	int ret;
+	int ret = 0;
 	if (!git_parse_int(value, &ret))
 		die_bad_number(name, value);
 	return ret;
@@ -580,7 +580,7 @@ int git_config_int(const char *name, const char *value)
 
 int64_t git_config_int64(const char *name, const char *value)
 {
-	int64_t ret;
+	int64_t ret = 0;
 	if (!git_parse_int64(value, &ret))
 		die_bad_number(name, value);
 	return ret;
-- 
1.9.2.msysgit.0.154.g978f18d
