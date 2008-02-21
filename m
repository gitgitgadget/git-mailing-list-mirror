From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Teach git-grep --name-only as synonym for -l
Date: Wed, 20 Feb 2008 23:23:39 -0500
Message-ID: <20080221042339.GA3195@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 05:24:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS2yp-00021I-Ow
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 05:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbYBUEXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 23:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754384AbYBUEXo
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 23:23:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45146 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbYBUEXn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 23:23:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JS2y1-0004dL-GU; Wed, 20 Feb 2008 23:23:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2682320FBAE; Wed, 20 Feb 2008 23:23:40 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74592>

I expected git grep --name-only to give me only the file names,
much as git diff --name-only only generates filenames.  Alas the
option is -l, which matches common external greps but doesn't match
other parts of the git UI.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-grep.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 9180b39..f4f4ecb 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -578,6 +578,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp("-l", arg) ||
+		    !strcmp("--name-only", arg) ||
 		    !strcmp("--files-with-matches", arg)) {
 			opt.name_only = 1;
 			continue;
-- 
1.5.4.2.232.g08e5
