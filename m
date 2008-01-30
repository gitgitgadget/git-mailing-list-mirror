From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH] gitweb: Make use of the $git_dir variable at sub git_get_project_description
Date: Wed, 30 Jan 2008 03:37:56 -0200
Message-ID: <1201671476-15725-1-git-send-email-ribas@c3sl.ufpr.br>
Cc: Bruno Ribas <ribas@c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 06:38:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK5eW-00018e-4o
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 06:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbYA3Fh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 00:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753647AbYA3Fh5
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 00:37:57 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:36713 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbYA3Fh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 00:37:56 -0500
Received: from localhost (unknown [201.21.136.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 825C9700003CC;
	Wed, 30 Jan 2008 03:37:55 -0200 (BRST)
X-Mailer: git-send-email 1.5.3.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72025>


Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e29ad0a..157f499 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1606,7 +1606,7 @@ sub git_get_project_description {
 	my $path = shift;
 
 	$git_dir = "$projectroot/$path";
-	open my $fd, "$projectroot/$path/description"
+	open my $fd, "$git_dir/description"
 		or return git_get_project_config('description');
 	my $descr = <$fd>;
 	close $fd;
-- 
1.5.3.8
