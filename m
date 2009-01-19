From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/2] bash completion: move pickaxe options to log
Date: Mon, 19 Jan 2009 22:17:59 +0100
Message-ID: <1232399880-22036-1-git-send-email-trast@student.ethz.ch>
References: <20090119173153.GB14053@spearce.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 22:19:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP1Wm-00074x-Jw
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 22:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbZASVR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 16:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754170AbZASVR6
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 16:17:58 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:2942 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbZASVR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 16:17:57 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Jan 2009 22:17:55 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Jan 2009 22:17:55 +0100
X-Mailer: git-send-email 1.6.1.389.g45b4ee
In-Reply-To: <20090119173153.GB14053@spearce.org>
X-OriginalArrivalTime: 19 Jan 2009 21:17:55.0193 (UTC) FILETIME=[6510B690:01C97A7B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106391>

Move the options --pickaxe-all and --pickaxe-regex to git-log, where
they make more sense than with git-diff.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

Shawn O. Pearce wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > The changes around pickaxe made me "Huh?".  For log pickaxe makes very
> > good sense but for a single diff it doesn't, yet the original seems to
> > have had them only on "git diff" and not on "git log", which feels wrong.
> 
> I agree completely.  The pickaxe stuff in current completion is
> just plain wrong.  I'd like to see it fixed with this cleanup.
> Maybe do it in two parts; fix the pickaxe options to be on log
> and not diff, and then do the cleanup for the common options.

Good point.  Sorry for not noticing in the first place; I was too
focused on just getting git-show completion working ;-)


 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 60497a4..b5d3bbb 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -784,7 +784,7 @@ _git_diff ()
 			--patch-with-stat --name-only --name-status --color
 			--no-color --color-words --no-renames --check
 			--full-index --binary --abbrev --diff-filter=
-			--find-copies-harder --pickaxe-all --pickaxe-regex
+			--find-copies-harder
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --exit-code --quiet --ext-diff
 			--no-ext-diff
@@ -986,6 +986,7 @@ _git_log ()
 			--parents --children --full-history
 			--merge
 			--inter-hunk-context=
+			--pickaxe-all --pickaxe-regex
 			"
 		return
 		;;
-- 
tg: (28da86a..) t/bash-complete-pickaxe (depends on: origin/master)
