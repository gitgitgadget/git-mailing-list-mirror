From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] git-svn: Support custom tunnel schemes instead of SSH only
Date: Tue, 26 Mar 2013 22:24:38 +0100
Message-ID: <51521216.2050309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net, Eric Wieser <wieser.eric@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 22:25:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKbN7-0005GO-DH
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 22:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478Ab3CZVZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 17:25:02 -0400
Received: from plane.gmane.org ([80.91.229.3]:45703 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab3CZVZB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 17:25:01 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UKbMu-0004eA-0y
	for git@vger.kernel.org; Tue, 26 Mar 2013 22:25:20 +0100
Received: from p4fc97c64.dip.t-dialin.net ([79.201.124.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 22:25:20 +0100
Received: from sschuberth by p4fc97c64.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 22:25:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p4fc97c64.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219209>

This originates from an msysgit pull request, see:

https://github.com/msysgit/git/pull/58

Signed-off-by: Eric Wieser <wieser.eric@gmail.com>
Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 perl/Git/SVN/Ra.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 049c97b..6a212eb 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -295,7 +295,7 @@ sub gs_do_switch {
 	my $full_url = add_path_to_url( $self->url, $path );
 	my ($ra, $reparented);
 
-	if ($old_url =~ m#^svn(\+ssh)?://# ||
+	if ($old_url =~ m#^svn(\+\w+)?://# ||
 	    ($full_url =~ m#^https?://# &&
 	     canonicalize_url($full_url) ne $full_url)) {
 		$_[0] = undef;
-- 
1.8.1.msysgit.1
