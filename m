From: Adam Tkac <atkac@redhat.com>
Subject: [PATCH] Don't pass "--xhtml" to hightlight in gitweb.perl script.
Date: Thu, 27 Jan 2011 13:51:51 +0100
Message-ID: <20110127125151.GA19072@traged.englab.brq.redhat.com>
References: <20110126171118.GA867@traged.englab.brq.redhat.com>
 <m339ofbb9t.fsf@localhost.localdomain>
 <7vaainjq7f.fsf@alter.siamese.dyndns.org>
 <20110127120323.GA3416@traged.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jochen Schmitt <Jochen@herr-schmitt.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 13:52:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiRKz-0008B9-KE
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 13:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab1A0Mw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 07:52:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20728 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab1A0Mw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 07:52:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p0RCprk3016689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 27 Jan 2011 07:51:53 -0500
Received: from localhost (dhcp-25-165.brq.redhat.com [10.34.25.165])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p0RCpqGT026697;
	Thu, 27 Jan 2011 07:51:52 -0500
Content-Disposition: inline
In-Reply-To: <20110127120323.GA3416@traged.englab.brq.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165578>

The "--xhtml" option is supported only in highlight < 3.0. There is no option
to enforce (X)HTML output format compatible with both highlight < 3.0 and
highlight >= 3.0. However default output format is HTML so we don't need to
explicitly specify it.

Signed-off-by: Adam Tkac <atkac@redhat.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1025c2f..0779f12 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3468,7 +3468,7 @@ sub run_highlighter {
 	close $fd;
 	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
 	          quote_command($highlight_bin).
-	          " --xhtml --fragment --syntax $syntax |"
+	          " --fragment --syntax $syntax |"
 		or die_error(500, "Couldn't open file or run syntax highlighter");
 	return $fd;
 }
-- 
1.7.3.5
