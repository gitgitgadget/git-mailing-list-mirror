From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: Re: [PATCH 2/2] Replace remaining git-* calls in git stash
Date: Thu, 23 Jul 2009 07:13:40 +0200
Message-ID: <20090723051340.GA28934@auto.tuwien.ac.at>
References: <1248206777-6984-1-git-send-email-mkoegler@auto.tuwien.ac.at> <1248206777-6984-2-git-send-email-mkoegler@auto.tuwien.ac.at> <20090723070810.6117@nanako3.lavabit.com> <7vtz14bb3e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTqcv-0005HY-4l
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 07:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbZGWFNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 01:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbZGWFNn
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 01:13:43 -0400
Received: from odin.auto.tuwien.ac.at ([128.130.60.3]:60909 "EHLO
	mail.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbZGWFNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 01:13:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id 45FA2130396F;
	Thu, 23 Jul 2009 07:13:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at odin.auto.tuwien.ac.at
Received: from mail.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (odin.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id okB16jeSarhB; Thu, 23 Jul 2009 07:13:40 +0200 (CEST)
Received: from thor.localdomain (thor.auto.tuwien.ac.at [128.130.60.15])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id 30BD0130396E;
	Thu, 23 Jul 2009 07:13:40 +0200 (CEST)
Received: by thor.localdomain (Postfix, from userid 3001)
	id 262A96800645; Thu, 23 Jul 2009 07:13:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtz14bb3e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123839>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 22, 2009 at 03:35:01PM -0700, Junio C Hamano wrote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
> 
> > Quoting Martin Koegler <mkoegler@auto.tuwien.ac.at>:
> >
> >> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> >> ---
> >
> > Thank you. Even though 'git blame' says I am not responsible for these two (I AM responsible for the one in your other patch)...
> >
> > Acked-by: Nanako Shiraishi <nanako3@lavabit.com>

I got an error from the mailing list for my reworked patch, so I sent
it again as attachment.


--wRRV7LY7NUeQGEoC
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-git-stash-replace-git-XXX-calls.patch"

>From 03fa7d2f6c558b22747f21a76c21adad522e0a5d Mon Sep 17 00:00:00 2001
From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Tue, 21 Jul 2009 21:57:27 +0200
Subject: [PATCH] git stash: replace git-XXX calls
Status: O
Content-Length: 1056
Lines: 40

Replace remaining git-XXX calls with git XXX.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 git-stash.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 531c7c3..03e589f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -203,7 +203,7 @@ apply_stash () {
 		git diff-tree --binary $s^2^..$s^2 | git apply --cached
 		test $? -ne 0 &&
 			die 'Conflicts in index. Try without --index.'
-		unstashed_index_tree=$(git-write-tree) ||
+		unstashed_index_tree=$(git write-tree) ||
 			die 'Could not save index tree'
 		git reset
 	fi
@@ -219,7 +219,7 @@ apply_stash () {
 	then
 		export GIT_MERGE_VERBOSITY=0
 	fi
-	if git-merge-recursive $b_tree -- $c_tree $w_tree
+	if git merge-recursive $b_tree -- $c_tree $w_tree
 	then
 		# No conflict
 		if test -n "$unstashed_index_tree"
@@ -297,7 +297,7 @@ apply_to_branch () {
 	fi
 	stash=$2
 
-	git-checkout -b $branch $stash^ &&
+	git checkout -b $branch $stash^ &&
 	apply_stash --index $stash &&
 	drop_stash $stash
 }
-- 
1.5.6.5


--wRRV7LY7NUeQGEoC--
