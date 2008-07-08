From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH/RFC] git-request-pull: replace call to deprecated peek-remote
Date: Wed, 09 Jul 2008 00:32:15 +0100
Message-ID: <4873F8FF.70607@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 19:42:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGdgE-0004eO-6c
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 19:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbYGIRlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 13:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbYGIRlP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 13:41:15 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:3140 "EHLO
	anchor-post-30.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751953AbYGIRlO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2008 13:41:14 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.67)
	id 1KGdfF-0003SO-1i; Wed, 09 Jul 2008 17:41:13 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87899>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

I don't even recall how I noticed this ...

Only very lightly tested, but since git-peek-remote and
git-ls-remote are implemented in git.c as synonyms, it should
be quite safe ...


 git-request-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 068f5e0..073a314 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -26,7 +26,7 @@ merge_base=`git merge-base $baserev $headrev` ||
 die "fatal: No commits in common between $base and $head"
 
 url=$(get_remote_url "$url")
-branch=$(git peek-remote "$url" \
+branch=$(git ls-remote "$url" \
 	| sed -n -e "/^$headrev	refs.heads./{
 		s/^.*	refs.heads.//
 		p
-- 
1.5.6
