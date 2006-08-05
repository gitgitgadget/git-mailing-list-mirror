From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/9] gitweb: Separate input validation and dispatch, add comment about opml action
Date: Sat, 05 Aug 2006 12:55:20 +0200
Organization: At home
Message-ID: <eb1tdd$6kf$1@sea.gmane.org>
References: <200608050036.06490.jnareb@gmail.com> <200608050038.20534.jnareb@gmail.com> <7vu04sghr0.fsf@assigned-by-dhcp.cox.net> <eb0oiu$sj1$1@sea.gmane.org> <44d47813.36251c31.2553.3cf7@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 12:55:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Jo3-0007mO-9j
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 12:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161426AbWHEKyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 06:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161590AbWHEKyu
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 06:54:50 -0400
Received: from main.gmane.org ([80.91.229.2]:6602 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161426AbWHEKyt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 06:54:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G9Jnr-0007kO-1Y
	for git@vger.kernel.org; Sat, 05 Aug 2006 12:54:47 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 12:54:47 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 12:54:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24899>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 58eb5b1..8b53fe6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -71,6 +71,7 @@ if (! -d $git_temp) {
        mkdir($git_temp, 0700) || die_error("Couldn't mkdir $git_temp");
 }
 
+# ======================================================================
 # input validation and dispatch
 our $action = $cgi->param('a');
 if (defined $action) {
@@ -78,6 +79,7 @@ if (defined $action) {
                undef $action;
                die_error(undef, "Invalid action parameter.");
        }
+       # action which does not check rest of parameters
        if ($action eq "opml") {
                git_opml();
                exit;
-- 
1.4.1.1
