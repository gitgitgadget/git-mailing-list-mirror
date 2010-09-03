From: WOLfgang Schricker <news@wols.org>
Subject: [RFC PATCH] gitweb.perl: tags snapshot link
Date: Fri, 03 Sep 2010 13:42:16 +0200
Message-ID: <i5qmuo$ice$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 03 15:20:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrWBj-00024J-MO
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 15:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab0ICNUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 09:20:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:39123 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007Ab0ICNUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 09:20:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OrWBY-0001uL-3Z
	for git@vger.kernel.org; Fri, 03 Sep 2010 15:20:04 +0200
Received: from p4fd0392e.dip.t-dialin.net ([79.208.57.46])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 15:20:04 +0200
Received: from news by p4fd0392e.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 15:20:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4fd0392e.dip.t-dialin.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100806 Gentoo/2.0.6 SeaMonkey/2.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155247>

Hello,

I missed a snapshot link in my local repo:
====
tags
====
	tag | commit | shortlog | log | *snapshot*

I found this threads

<http://kerneltrap.org/mailarchive/git/2009/11/8/15785/thread>
<http://thread.gmane.org/gmane.comp.version-control.git/132366>

and the code for "Smarter snapshot names" in 'gitwep.perl'.

My gitweb.perl-1.7.2.2.patch for "activating":


--- gitweb.perl.orig	2010-08-20 01:44:47.000000000 +0200
+++ gitweb.perl	2010-09-03 13:20:40.000000000 +0200
@@ -4909,6 +4909,10 @@
 		} elsif ($tag{'reftype'} eq "blob") {
 			print " | " . $cgi->a({-href => href(action=>"blob_plain", hash=>$tag{'refid'})}, "raw");
 		}
+        my $snapshot_links = format_snapshot_links($tag{'fullname'});
+        if (defined $snapshot_links) {
+            print " | " . $snapshot_links;
+        }
 		print "</td>\n" .
 		      "</tr>";
 	}

-- 
Regards
*WOL* fgang *S* chricker
