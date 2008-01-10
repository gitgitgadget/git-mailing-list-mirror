From: Florian La Roche <laroche@redhat.com>
Subject: [PATCH] gitweb: Change feeds from commit to commitdiff output.
Date: Thu, 10 Jan 2008 14:09:00 +0100
Message-ID: <20080110130900.GA9395@dudweiler.stuttgart.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 10 14:10:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCxAY-0004U0-Kb
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 14:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbYAJNJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 08:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbYAJNJe
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 08:09:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38005 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbYAJNJd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 08:09:33 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m0AD92aA012890;
	Thu, 10 Jan 2008 08:09:02 -0500
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0AD91LD024120;
	Thu, 10 Jan 2008 08:09:01 -0500
Received: from dudweiler.stuttgart.redhat.com (dudweiler.stuttgart.redhat.com [10.32.5.60])
	by pobox.stuttgart.redhat.com (8.13.1/8.13.1) with ESMTP id m0AD90Yg025756;
	Thu, 10 Jan 2008 08:09:00 -0500
Received: from dudweiler.stuttgart.redhat.com (localhost.localdomain [127.0.0.1])
	by dudweiler.stuttgart.redhat.com (8.13.8/8.13.8) with ESMTP id m0AD91LY009406;
	Thu, 10 Jan 2008 14:09:01 +0100
Received: (from laroche@localhost)
	by dudweiler.stuttgart.redhat.com (8.13.8/8.13.8/Submit) id m0AD90us009403;
	Thu, 10 Jan 2008 14:09:00 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70068>

[PATCH] gitweb: Change feeds from commit to commitdiff output.

Change feeds from displaying the commit to displaying the commitdiff
output. This way the patches are shown directly and code review is
done more easily via watching feeds.

Signed-off-by: Florian La Roche <laroche@redhat.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6256641..0db83c0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5566,7 +5566,7 @@ XML
 			or next;
 
 		# print element (entry, item)
-		my $co_url = href(-full=>1, action=>"commit", hash=>$commit);
+		my $co_url = href(-full=>1, action=>"commitdiff", hash=>$commit);
 		if ($format eq 'rss') {
 			print "<item>\n" .
 			      "<title>" . esc_html($co{'title'}) . "</title>\n" .
-- 
1.5.3.8
