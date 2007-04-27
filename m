From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Fix few 'use of undefined value' warnings
Date: Fri, 27 Apr 2007 18:43:53 +0200
Message-ID: <20070427164352.396.54191.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 18:44:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhTY6-00038A-EJ
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 18:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbXD0Qnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 12:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756075AbXD0Qnz
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 12:43:55 -0400
Received: from rover.dkm.cz ([62.24.64.27]:42765 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756072AbXD0Qny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 12:43:54 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 30BD28B9B3;
	Fri, 27 Apr 2007 18:43:53 +0200 (CEST)
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45728>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b67ce41..b51103e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1038,6 +1038,7 @@ sub git_get_hash_by_path {
 		or die_error(undef, "Open git-ls-tree failed");
 	my $line = <$fd>;
 	close $fd or return undef;
+	$line or return undef;
 
 	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
 	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/;
@@ -1057,6 +1058,7 @@ sub git_get_project_description {
 	open my $fd, "$projectroot/$path/description" or return undef;
 	my $descr = <$fd>;
 	close $fd;
+	$descr or return undef;
 	chomp $descr;
 	return $descr;
 }
@@ -1208,6 +1210,7 @@ sub git_get_last_activity {
 	     'refs/heads') or return;
 	my $most_recent = <$fd>;
 	close $fd or return;
+	$most_recent or return;
 	if ($most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
 		my $timestamp = $1;
 		my $age = time - $timestamp;
