From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v6 4/6] gitweb: limit links to alternate forms of
 project_list to active project_filter
Date: Mon, 30 Jan 2012 21:09:00 +0100
Message-ID: <20120130200900.GE2584@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114557.GB9267@server.brlink.eu>
 <201201301657.12944.jnareb@gmail.com>
 <20120130200355.GA2584@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:08:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrxWx-0003wc-FV
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab2A3UIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:08:43 -0500
Received: from server.brlink.eu ([78.46.187.186]:54115 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307Ab2A3UIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:08:42 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxWr-0005vp-KL; Mon, 30 Jan 2012 21:08:41 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxXA-0001CA-HZ; Mon, 30 Jan 2012 21:09:00 +0100
Content-Disposition: inline
In-Reply-To: <20120130200355.GA2584@server.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189413>

If project_list action is given a project_filter argument, pass that to
TXT and OPML formats.

This way [OPML] and [TXT] links provide the same list of projects as
the projects_list page they are linked from.

Signed-off-by: Bernhard R. Link <brlink@debian.org>

---

Changes since v5:
	add additional description paragraph from Jakub Narebski
---
 gitweb/gitweb.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b895f4c..9299504 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3981,9 +3981,11 @@ sub git_footer_html {
 		}
 
 	} else {
-		print $cgi->a({-href => href(project=>undef, action=>"opml"),
+		print $cgi->a({-href => href(project=>undef, action=>"opml",
+		                             project_filter => $project_filter),
 		              -class => $feed_class}, "OPML") . " ";
-		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
+		print $cgi->a({-href => href(project=>undef, action=>"project_index",
+		                             project_filter => $project_filter),
 		              -class => $feed_class}, "TXT") . "\n";
 	}
 	print "</div>\n"; # class="page_footer"
-- 
1.7.8.3
