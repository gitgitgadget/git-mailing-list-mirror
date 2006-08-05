From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 8/9] gitweb: PATH_INFO=/ means no project
Date: Sat, 05 Aug 2006 13:16:03 +0200
Organization: At home
Message-ID: <eb1uk7$8ti$4@sea.gmane.org>
References: <200608050036.06490.jnareb@gmail.com> <200608050038.20534.jnareb@gmail.com> <7vu04sghr0.fsf@assigned-by-dhcp.cox.net> <eb0oiu$sj1$1@sea.gmane.org> <44d47813.36251c31.2553.3cf7@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 13:35:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9KQu-0005PU-88
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWHELfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbWHELfE
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:35:04 -0400
Received: from main.gmane.org ([80.91.229.2]:6812 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161193AbWHELfD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 07:35:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G9KQo-0005Op-1A
	for git@vger.kernel.org; Sat, 05 Aug 2006 13:35:02 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:35:02 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24912>

Prepared for refactoring input validation.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 013bfe7..2e1a2ba 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -86,8 +86,8 @@ if (defined $action) {
 }
 
 our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
-if (defined $project) {
-       $project =~ s|^/||; $project =~ s|/$||;
+$project =~ s|^/||; $project =~ s|/$||;
+if (defined $project && $project) {
        if (!validate_input($project)) {
                die_error(undef, "Invalid project parameter");
        }
-- 
1.4.1.1
