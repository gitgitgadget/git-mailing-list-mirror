From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/9] gitweb: die_error first (optional) parameter is HTTP status
Date: Sat, 05 Aug 2006 12:56:04 +0200
Organization: At home
Message-ID: <eb1tep$6kf$2@sea.gmane.org>
References: <200608050036.06490.jnareb@gmail.com> <200608050038.20534.jnareb@gmail.com> <7vu04sghr0.fsf@assigned-by-dhcp.cox.net> <eb0oiu$sj1$1@sea.gmane.org> <44d47813.36251c31.2553.3cf7@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 13:05:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Jxt-0000yW-Ln
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161481AbWHELFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161593AbWHELFF
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:05:05 -0400
Received: from main.gmane.org ([80.91.229.2]:55736 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161481AbWHELFE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 07:05:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G9Jxm-0000w2-7o
	for git@vger.kernel.org; Sat, 05 Aug 2006 13:05:02 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:05:02 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24902>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8b53fe6..6feec28 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -68,7 +68,7 @@ our $git_version = qx($GIT --version) =~
 
 $projects_list ||= $projectroot;
 if (! -d $git_temp) {
-       mkdir($git_temp, 0700) || die_error("Couldn't mkdir $git_temp");
+       mkdir($git_temp, 0700) || die_error(undef, "Couldn't mkdir $git_temp");
 }
 
 # ======================================================================
@@ -1658,7 +1658,7 @@ sub git_blob_plain {
        }
        my $type = shift;
        open my $fd, "-|", $GIT, "cat-file", "blob", $hash
-               or die_error("Couldn't cat $file_name, $hash");
+               or die_error(undef, "Couldn't cat $file_name, $hash");
 
        $type ||= git_blob_plain_mimetype($fd, $file_name);
 
-- 
1.4.1.1
