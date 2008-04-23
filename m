From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git checkout: add -t alias for --track
Date: Thu, 24 Apr 2008 01:04:48 +0200
Message-ID: <20080423230448.GL4012@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 01:06:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joo2G-0007iR-UX
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 01:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYDWXEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 19:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbYDWXEw
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 19:04:52 -0400
Received: from virgo.iok.hu ([193.202.89.103]:34129 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899AbYDWXEu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 19:04:50 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1A9811B250A;
	Thu, 24 Apr 2008 01:04:49 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4947E44659;
	Thu, 24 Apr 2008 01:01:14 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8F1E21190AC5; Thu, 24 Apr 2008 01:04:48 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80272>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Just like 'git checkout -q' is an alias for 'git checkout --quiet', I
often type 'git checkout -t -b newname master', then realize I need
'--track', but in fact '-t' is not used for anything else, so it can be
just a short name for --track.

 Documentation/git-checkout.txt |    2 +-
 builtin-checkout.c             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index e11cddb..a644173 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -47,7 +47,7 @@ OPTIONS
 	by linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
 
---track::
+-t, --track::
 	When creating a new branch, set up configuration so that git-pull
 	will automatically retrieve data from the start point, which must be
 	a branch. Use this if you always pull from the same upstream branch
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 7deb504..1a93d13 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -504,7 +504,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
-		OPT_SET_INT( 0 , "track",  &opts.track, "track",
+		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
 		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
 		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
-- 
1.5.5
