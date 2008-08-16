From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation: document the pager.* configuration setting
Date: Sat, 16 Aug 2008 15:38:13 +0200
Message-ID: <1218893893-11242-1-git-send-email-vmiklos@frugalware.org>
References: <7v63q1lkbj.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 15:38:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KULzU-0002e7-3w
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 15:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbYHPNho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 09:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbYHPNhn
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 09:37:43 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:48557 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbYHPNhm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 09:37:42 -0400
Received: from vmobile.example.net (dsl5401C01F.pool.t-online.hu [84.1.192.31])
	by yugo.frugalware.org (Postfix) with ESMTP id 41D631DDC5B;
	Sat, 16 Aug 2008 15:37:40 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 466601A5FBF; Sat, 16 Aug 2008 15:38:13 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <7v63q1lkbj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92546>

It was already documented in RelNotes-1.6.0, but not in the git-config
manual page.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Aug 15, 2008 at 08:17:52PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > Ugh, I just noticed that the example was wrong, because paging for
> > status is disabled by default. Here is a corrected version.
>
> Honestly, I do not think the distinction between your two versions
> matter.
> Do we need a new example there?

That is a frequently asked question on #git (in the past, people asked
how to disable it, now they ask how to enable it), so I thought an
example can be helpful. Also Jeff provided such an example in the commit
message of 4e10738.

If you think it's unnecessary, then just remove that hunk.

> The patch to Documentation/config.txt looks Ok, but I do not think you
> need to say "allows to set your preference".  "Sets your preference"
> would
> be enough.

Fixed. I also noticed that above the documentation uses "Specify" and
not "Specifies" in such a case, so I dropped the "s" here as well.

 Documentation/config.txt     |    5 +++++
 Documentation/git-config.txt |    6 ++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b8ec01c..dc70ba6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -978,6 +978,11 @@ pack.packSizeLimit::
 	can be overridden by the `\--max-pack-size` option of
 	linkgit:git-repack[1].
 
+pager.<cmd>::
+	Set your pager preference for each command, overriding the default. If
+	`\--pager` or `\--no-pager` is specified on the command line, it takes
+	precedence over this option.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 28e1861..c0bc6fa 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -315,6 +315,12 @@ RESET=$(git config --get-color "" "reset")
 echo "${WS}your whitespace color or blue reverse${RESET}"
 ------------
 
+To enable the pager for linkgit:git-status[1]:
+
+------------
+% git config pager.status true
+------------
+
 include::config.txt[]
 
 
-- 
1.6.0.rc0.14.g95f8.dirty
