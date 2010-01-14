From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/18] rebase -i: Remove dead code
Date: Thu, 14 Jan 2010 06:54:41 +0100
Message-ID: <affe8160c091f8f329b4bbc16d7c9641b1483296.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgb-0002Vo-2T
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab0ANFz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489Ab0ANFzU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:20 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58584 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab0ANFzR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:17 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bH001912;
	Thu, 14 Jan 2010 06:55:13 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136934>

This branch of the "if" is only executed if $no_ff is empty, which
only happens if $1 was not '-n'.  (This code has been dead since
1d25c8cf82eead72e11287d574ef72d3ebec0db1.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index fba8fb6..c6174bb 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -169,7 +169,6 @@ pick_one () {
 	if test -z "$no_ff" -a "$current_sha1" = "$parent_sha1"
 	then
 		output git reset --hard $sha1
-		test "a$1" = a-n && output git reset --soft $current_sha1
 		sha1=$(git rev-parse --short $sha1)
 		output warn Fast-forward to $sha1
 	else
-- 
1.6.6
