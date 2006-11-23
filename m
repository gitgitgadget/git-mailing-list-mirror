X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 22 Nov 2006 18:49:58 -0800
Message-ID: <7vwt5mnag9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 02:50:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-maint-at: e945f95157c2c515e763ade874931fc1eb671a0b
X-master-at: e945f95157c2c515e763ade874931fc1eb671a0b
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32116>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn4fF-0007AD-Qn for gcvg-git@gmane.org; Thu, 23 Nov
 2006 03:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757284AbWKWCuF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 21:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757283AbWKWCuF
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 21:50:05 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13471 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1757281AbWKWCuC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 21:50:02 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061123024959.HYXP18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 22
 Nov 2006 21:49:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id q2q71V0011kojtg0000000; Wed, 22 Nov 2006
 21:50:07 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The 'maint' and 'master' are at the same commit; a maintenance
release v1.4.4.1 has been cut.

A handful enhancements that have been cooking in 'next' will
start graduating to 'master' shortly; as usual, they won't be
in the future v1.4.4.x maintenance series.

 * gitweb updates.

 * shortlog is now built-in.

 * enhance packed-refs file to optimize "show-ref -d".

 * retire merge-recursive-old.

 * shallow clone.

----------------------------------------------------------------

* The 'next' branch, in addition to what are in 'master', has these.

   Andy Parkins (2):
      Improve git-prune -n output
      Add support to git-branch to show local and remote branches

   Jakub Narebski (7):
      gitweb: Protect against possible warning in git_commitdiff
      gitweb: Buffer diff header to deal with split patches + git_patchset_body refactoring
      gitweb: Default to $hash_base or HEAD for $hash in "commit" and "commitdiff"
      gitweb: New improved formatting of chunk header in diff
      gitweb: Add an option to href() to return full URL
      gitweb: Refactor feed generation, make output prettier, add Atom feed
      gitweb: Finish restoring "blob" links in git_difftree_body

   Johannes Schindelin (5):
      Build in shortlog
      shortlog: do not crash on parsing "[PATCH"
      shortlog: read mailmap from ./.mailmap again
      shortlog: handle email addresses case-insensitively
      shortlog: fix "-n"

   Junio C Hamano (9):
      upload-pack: stop the other side when they have more roots than we do.
      adjust_shared_perm: chmod() only when needed.
      apply --numstat: mark binary diffstat with - -, not 0 0
      pack-objects: tweak "do not even attempt delta" heuristics
      Store peeled refs in packed-refs file.
      remove merge-recursive-old
      git-merge: make it usable as the first class UI
      git-diff/git-apply: make diff output a bit friendlier to GNU patch (part 2)
      Store peeled refs in packed-refs (take 2).

   Nicolas Pitre (1):
      builtin git-shortlog is broken


* The 'pu' branch, in addition, has these.

   Alexandre Julliard (1):
      Shallow clone: do not ignore shallowness when following tags

   Johannes Schindelin (5):
      upload-pack: no longer call rev-list
      support fetching into a shallow repository
      allow cloning a repository "shallowly"
      allow deepening of a shallow repository
      add tests for shallow stuff

   Junio C Hamano (10):
      git-commit: show --summary after successful commit.
      para-walk: walk n trees, index and working tree in parallel
      rev-list --left-right
      merge: allow merging into a yet-to-be-born branch.
      blame: --show-stats for easier optimization work.
      gitweb: steal loadavg throttle from kernel.org
      We should make sure that the protocol is still extensible.
      Why does it mean we do not have to register shallow if we have one?
      Why didn't we mark want_obj as ~UNINTERESTING in the old code?
      shallow clone: unparse and reparse an unshallowed commit

