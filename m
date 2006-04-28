From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] annotate: display usage information if no filename was given
Date: Fri, 28 Apr 2006 10:41:19 +0200
Message-ID: <20060428084119.GA4313@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 11:48:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZPai-0001WI-Tt
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 11:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWD1Jsp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 05:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWD1Jsp
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 05:48:45 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:35960 "EHLO XSMTP0.ethz.ch")
	by vger.kernel.org with ESMTP id S1030346AbWD1Jsp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Apr 2006 05:48:45 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Fri, 28 Apr 2006 11:48:43 +0200
Received: from spinlock.ch ([129.132.210.92]) by xfe1.d.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Fri, 28 Apr 2006 11:48:43 +0200
Received: (nullmailer pid 5101 invoked by uid 1000);
	Fri, 28 Apr 2006 08:41:19 -0000
To: junkio@cox.net
Mail-Followup-To: junkio@cox.net, git@vger.kernel.org
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.16-rc6 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 28 Apr 2006 09:48:43.0166 (UTC) FILETIME=[EF7D63E0:01C66AA8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19274>


Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>

---

 git-annotate.perl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

ec31877f02673ed1db9d1485ac0065d51cbb7039
diff --git a/git-annotate.perl b/git-annotate.perl
index 9df72a1..bf920a5 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -10,9 +10,10 @@ use warnings;
 use strict;
 use Getopt::Long;
 use POSIX qw(strftime gmtime);
+use File::Basename qw(basename dirname);
 
 sub usage() {
-	print STDERR 'Usage: ${\basename $0} [-s] [-S revs-file] file [ revision ]
+	print STDERR "Usage: ${\basename $0} [-s] [-S revs-file] file [ revision ]
 	-l, --long
 			Show long rev (Defaults off)
 	-t, --time
@@ -23,7 +24,7 @@ sub usage() {
 			Use revs from revs-file instead of calling git-rev-list
 	-h, --help
 			This message.
-';
+";
 
 	exit(1);
 }
@@ -35,7 +36,7 @@ my $rc = GetOptions(	"long|l" => \$longr
 			"help|h" => \$help,
 			"rename|r" => \$rename,
 			"rev-file|S=s" => \$rev_file);
-if (!$rc or $help) {
+if (!$rc or $help or !@ARGV) {
 	usage();
 }
 
-- 
1.3.1.gc4586
