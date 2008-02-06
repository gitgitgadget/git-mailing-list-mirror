From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH] gitweb: Make use of the $git_dir variable at sub git_get_project_url_list
Date: Wed,  6 Feb 2008 15:15:12 -0200
Message-ID: <1202318112-8223-1-git-send-email-ribas@c3sl.ufpr.br>
Cc: gitster@pobox.com, Bruno Ribas <ribas@c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 18:16:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMnsV-0000OD-R4
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 18:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbYBFRPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 12:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbYBFRPf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 12:15:35 -0500
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:52619 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbYBFRPe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 12:15:34 -0500
Received: from localhost (unknown [189.1.130.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 72779700003E5;
	Wed,  6 Feb 2008 15:15:33 -0200 (BRST)
X-Mailer: git-send-email 1.5.4.24.gce08d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72820>


Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ae2d057..0cb3cb0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1620,7 +1620,7 @@ sub git_get_project_url_list {
 	my $path = shift;
 
 	$git_dir = "$projectroot/$path";
-	open my $fd, "$projectroot/$path/cloneurl"
+	open my $fd, "$git_dir/cloneurl"
 		or return wantarray ?
 		@{ config_to_multi(git_get_project_config('url')) } :
 		   config_to_multi(git_get_project_config('url'));
-- 
1.5.4.23.gef5b9
