From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] Rename the 'fredrik' merge strategy to 'recursive'.
Date: Tue, 13 Sep 2005 08:22:26 +0200
Message-ID: <20050913062226.GA9101@c165.ib.student.liu.se>
References: <20050912212601.GB6644@c165.ib.student.liu.se> <7v1x3u7xtk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 08:23:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EF4Bs-0005gB-2k
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 08:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVIMGWe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 02:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVIMGWe
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 02:22:34 -0400
Received: from [85.8.31.11] ([85.8.31.11]:25217 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932359AbVIMGWd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 02:22:33 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 94F4C4115; Tue, 13 Sep 2005 08:27:29 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EF4BW-0002by-00; Tue, 13 Sep 2005 08:22:26 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1x3u7xtk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8460>

On Mon, Sep 12, 2005 at 02:58:31PM -0700, Junio C Hamano wrote:
> Thanks.  Will apply.
> 
> One request before we hit 0.99.7 (this Saturday) when the name
> will be cast in stone is to christen it better than 'fredrik'
> which was what I did as a tentative measure.  Otherwise we would
> regret when you come up with another merge algorithm with
> different pros-and-cons with the current one.


I have thought about that too. Is 'git-merge-recursive.py' a good
enough name?

- Fredrik


Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 .gitignore             |    2 +-
 Makefile               |    2 +-
 git-merge-recursive.py |    0 
 git-merge.sh           |    4 ++--
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename git-merge-fredrik.py => git-merge-recursive.py (100%)

7d5637d2df86406b4f8f3f96cbea57d977231470
diff --git a/.gitignore b/.gitignore
--- a/.gitignore
+++ b/.gitignore
@@ -43,10 +43,10 @@ git-mailinfo
 git-mailsplit
 git-merge
 git-merge-base
-git-merge-fredrik
 git-merge-index
 git-merge-octopus
 git-merge-one-file
+git-merge-recursive
 git-merge-resolve
 git-merge-stupid
 git-mktag
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -83,7 +83,7 @@ SCRIPT_PERL = \
 	git-rename.perl git-shortlog.perl
 
 SCRIPT_PYTHON = \
-	git-merge-fredrik.py
+	git-merge-recursive.py
 
 # The ones that do not have to link with lcrypto nor lz.
 SIMPLE_PROGRAMS = \
diff --git a/git-merge-fredrik.py b/git-merge-recursive.py
similarity index 100%
rename from git-merge-fredrik.py
rename to git-merge-recursive.py
diff --git a/git-merge.sh b/git-merge.sh
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -12,9 +12,9 @@ usage () {
     die "git-merge [-n] [-s <strategy>]... <merge-message> <head> <remote>+"
 }
 
-# all_strategies='resolve fredrik stupid octopus'
+# all_strategies='resolve recursive stupid octopus'
 
-all_strategies='fredrik octopus resolve stupid'
+all_strategies='recursive octopus resolve stupid'
 default_strategies='resolve octopus'
 use_strategies=
 
