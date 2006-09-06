From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7/7] gitweb: Set page to 0 if it is not defined, in git_history
Date: Wed,  6 Sep 2006 15:08:11 +0200
Message-ID: <11575480921132-git-send-email-jnareb@gmail.com>
References: <200609061504.40725.jnareb@gmail.com> <1157548091229-git-send-email-jnareb@gmail.com> <11575480912922-git-send-email-jnareb@gmail.com> <11575480922090-git-send-email-jnareb@gmail.com> <11575480922634-git-send-email-jnareb@gmail.com> <11575480921279-git-send-email-jnareb@gmail.com> <11575480922345-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 06 15:09:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKx8k-0005m3-VI
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 15:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWIFNIX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 09:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWIFNIW
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 09:08:22 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:42219 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750860AbWIFNIS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 09:08:18 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k86D6r0k031871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Sep 2006 15:06:53 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k86D8CWI008431;
	Wed, 6 Sep 2006 15:08:12 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k86D8CV8008430;
	Wed, 6 Sep 2006 15:08:12 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11575480922345-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26527>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index be4db08..edded74 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3153,6 +3153,9 @@ sub git_history {
 	if (!defined $hash_base) {
 		$hash_base = git_get_head_hash($project);
 	}
+	if (!defined $page) {
+		$page = 0;
+	}
 	my $ftype;
 	my %co = parse_commit($hash_base);
 	if (!%co) {
-- 
1.4.2
