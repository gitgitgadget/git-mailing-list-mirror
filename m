From: Jonas Fonseca <fonseca@diku.dk>
Subject: Seeing various mode changes on cygwin
Date: Sat, 8 Oct 2005 20:00:23 +0200
Message-ID: <20051008180023.GC28875@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 08 20:00:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOIzy-0001QO-RY
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 20:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVJHSA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 14:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVJHSAZ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 14:00:25 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:49885 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932133AbVJHSAZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2005 14:00:25 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id B176E6E263E; Sat,  8 Oct 2005 20:00:12 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 4C4826E1E2A
	for <git@vger.kernel.org>; Sat,  8 Oct 2005 20:00:12 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id D349B60F95; Sat,  8 Oct 2005 20:00:23 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9845>

Hi,

It seems that git on cygwin still have a few problems. I've experienced it both
when cloning with git and Cogito. It seems that cygwin overrides the previous
modes and sets the executable bit. git-reset doesn't fix it. Can this even be
fixed then?

A few examples below ...

jonas@cygwin /usr/local/dev/git/git
$ git reset
Documentation/sort_glossary.pl: needs update
t/lib-read-tree-m-3way.sh: needs update
t/t4109-apply-multifrag.sh: needs update
t/t4110-apply-scan.sh: needs update
t/t6000lib.sh: needs update
t/t6101-rev-parse-parents.sh: needs update
templates/hooks--applypatch-msg: needs update
templates/hooks--commit-msg: needs update
templates/hooks--post-commit: needs update
templates/hooks--post-update: needs update
templates/hooks--pre-applypatch: needs update
templates/hooks--pre-commit: needs update
templates/hooks--update: needs update

jonas@cygwin /usr/local/dev/git/git
$ git diff
diff --git a/Documentation/sort_glossary.pl b/Documentation/sort_glossary.pl
old mode 100644
new mode 100755
diff --git a/t/lib-read-tree-m-3way.sh b/t/lib-read-tree-m-3way.sh
old mode 100755
new mode 100644
diff --git a/t/t4109-apply-multifrag.sh b/t/t4109-apply-multifrag.sh
old mode 100644
new mode 100755
diff --git a/t/t4110-apply-scan.sh b/t/t4110-apply-scan.sh
old mode 100644
new mode 100755
diff --git a/t/t6000lib.sh b/t/t6000lib.sh
old mode 100755
new mode 100644
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
old mode 100644
new mode 100755
diff --git a/templates/hooks--applypatch-msg b/templates/hooks--applypatch-msg
old mode 100644
new mode 100755
diff --git a/templates/hooks--commit-msg b/templates/hooks--commit-msg
old mode 100644
new mode 100755
diff --git a/templates/hooks--post-commit b/templates/hooks--post-commit
old mode 100644
new mode 100755
diff --git a/templates/hooks--post-update b/templates/hooks--post-update
old mode 100644
new mode 100755
diff --git a/templates/hooks--pre-applypatch b/templates/hooks--pre-applypatch
old mode 100644
new mode 100755
diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
old mode 100644
new mode 100755
diff --git a/templates/hooks--update b/templates/hooks--update
old mode 100644
new mode 100755

jonas@cygwin /usr/local/dev/git/cogito
$ cg diff debian/
diff --git a/debian/helper-scripts/make-orig.tgz
b/debian/helper-scripts/make-orig.tgz
old mode 100644
new mode 100755
diff --git a/debian/helper-scripts/make-package
b/debian/helper-scripts/make-package
old mode 100644
new mode 100755
diff --git a/debian/helper-scripts/make-test
b/debian/helper-scripts/make-test
old mode 100644
new mode 100755

jonas@cygwin /usr/local/dev/elinks/0.11
$ cg diff
diff --git a/config/config.guess b/config/config.guess
old mode 100644
new mode 100755
diff --git a/config/config.sub b/config/config.sub
old mode 100644
new mode 100755
diff --git a/contrib/conv/w3m2links.awk.in b/contrib/conv/w3m2links.awk.in
old mode 100644
new mode 100755
diff --git a/contrib/lua/bm-to-elinks-bookmarks.lua b/contrib/lua/bm-to-elinks-bookmarks.lua
old mode 100644
new mode 100755
diff --git a/contrib/wipe-out-ssl.awk b/contrib/wipe-out-ssl.awk
old mode 100644
new mode 100755
diff --git a/debian/elinks.postinst b/debian/elinks.postinst
old mode 100644
new mode 100755
diff --git a/debian/elinks.preinst b/debian/elinks.preinst
old mode 100644
new mode 100755
diff --git a/debian/elinks.prerm b/debian/elinks.prerm
old mode 100644
new mode 100755
diff --git a/po/gen_translations_stats.sh b/po/gen_translations_stats.sh
old mode 100644
new mode 100755

-- 
Jonas Fonseca
