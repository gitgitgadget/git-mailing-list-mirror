From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 11] gitweb: Show project descriptions with utf-8 characters in project list correctly
Date: Sun, 30 Jul 2006 17:47:22 +0200
Message-ID: <200607301747.25589.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com> <200607301613.49947.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 17:47:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7DVx-0001Hf-Vm
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 17:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWG3PrX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 11:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWG3PrX
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 11:47:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:37012 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932348AbWG3PrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 11:47:22 -0400
Received: by ug-out-1314.google.com with SMTP id m3so392114ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 08:47:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hnfgq+QV0mHRKyodpq1s4rKcjdJ9bRuTJH/IkGuthyRmYz5PUoITfEHcU42p33iJ3O0YnwOQrKi6FzRbyw6bslicMAa4kZyS7YdI4kZXHtQ4zmkZnEXuCNudwbRPuoY0CMMAeCTcq/W5O8L+7+I+oezaNLAauOtkda3MVOYQXts=
Received: by 10.67.119.13 with SMTP id w13mr1625901ugm;
        Sun, 30 Jul 2006 08:47:20 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id u1sm2591331uge.2006.07.30.08.47.19;
        Sun, 30 Jul 2006 08:47:20 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607301613.49947.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24460>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This supersedes previous patch.

 gitweb/gitweb.cgi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 3884ffd..1befa7d 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -988,7 +988,7 @@ sub git_project_list {
 		}
 		$alternate ^= 1;
 		print "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary"), -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
-		      "<td>$pr->{'descr'}</td>\n" .
+		      "<td>" . esc_html($pr->{'descr'}) . "</td>\n" .
 		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
 		print "<td class=\"". age_class($pr->{'commit'}{'age'}) . "\">" . $pr->{'commit'}{'age_string'} . "</td>\n" .
 		      "<td class=\"link\">" .
-- 
1.4.0
