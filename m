From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3 (take 2)] gitweb: Add link to "project_index" view to "project_list" page
Date: Fri, 15 Sep 2006 11:11:33 +0200
Message-ID: <200609151111.33942.jnareb@gmail.com>
References: <200609150453.42231.jnareb@gmail.com> <200609150459.27708.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 15 11:11:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO9j7-0006uR-3W
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 11:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWIOJLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 05:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWIOJLJ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 05:11:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:50551 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750825AbWIOJLI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 05:11:08 -0400
Received: by ug-out-1314.google.com with SMTP id o38so141875ugd
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 02:11:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UWgAqykWd2ku5J1mpUherracUYsjplrUs3Xf5OaG1DHV8HDT/3zsPJu+CFbQxN2w6RHT05OKd/kkL+rlKZp9/e5bKC3SVPRW5/kgfgV8QuPTuN/+y5N8FpP0X4kNX2geaocuuecUvgbeswQukyAvQS3tDy1Ac3ofYnBkMWK+emU=
Received: by 10.67.97.18 with SMTP id z18mr5330171ugl;
        Fri, 15 Sep 2006 02:11:07 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id e33sm204732ugd.2006.09.15.02.11.06;
        Fri, 15 Sep 2006 02:11:07 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609150459.27708.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27072>

Add link to "project_index" view as [TXT] beside link to "opml" view,
(which is marked by [OPML]) to "project_list" page.

While at it add alternate links for "opml" and "project_list" to HTML
header for "project_list" view.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Corrected alternate links (dumb error while copy'n'paste).

 gitweb/gitweb.perl |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e900713..3079531 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1255,6 +1255,13 @@ EOF
 		printf('<link rel="alternate" title="%s log" '.
 		       'href="%s" type="application/rss+xml"/>'."\n",
 		       esc_param($project), href(action=>"rss"));
+	} else {
+		printf('<link rel="alternate" title="%s projects list" '.
+		       'href="%s" type="text/plain; charset=utf-8"/>'."\n",
+		       $site_name, href(project=>undef, action=>"project_index"));
+		printf('<link rel="alternate" title="%s projects logs" '.
+		       'href="%s" type="text/x-opml"/>'."\n",
+		       $site_name, href(project=>undef, action=>"opml"));
 	}
 	if (defined $favicon) {
 		print qq(<link rel="shortcut icon" href="$favicon" type="image/png"/>\n);
@@ -1309,7 +1316,9 @@ sub git_footer_html {
 		              -class => "rss_logo"}, "RSS") . "\n";
 	} else {
 		print $cgi->a({-href => href(project=>undef, action=>"opml"),
-		              -class => "rss_logo"}, "OPML") . "\n";
+		              -class => "rss_logo"}, "OPML") . " ";
+		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
+		              -class => "rss_logo"}, "TXT") . "\n";
 	}
 	print "</div>\n" .
 	      "</body>\n" .
-- 
1.4.2
