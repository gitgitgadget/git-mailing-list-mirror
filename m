From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/18] rebase -i: Use "test -n" instead of "test ! -z"
Date: Thu, 14 Jan 2010 06:54:43 +0100
Message-ID: <8f2d7bbf4aee7e0e7bfb1b32843430c3cb3b0e11.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIhP-0002mp-On
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551Ab0ANFz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755306Ab0ANFzW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:22 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58590 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab0ANFzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:20 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bJ001912;
	Thu, 14 Jan 2010 06:55:15 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136949>

It is a tiny bit simpler.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3b65cdf..6dbc64e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -158,7 +158,7 @@ pick_one () {
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
 		pick_one_preserving_merges "$@" && return
-	if test ! -z "$REBASE_ROOT"
+	if test -n "$REBASE_ROOT"
 	then
 		output git cherry-pick "$@"
 		return
-- 
1.6.6
