X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sat, 18 Nov 2006 14:24:36 -0800
Message-ID: <7v64dcbdgb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 22:24:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-maint-at: e3d457fb59f71dd40d24c82f48625a24492907d4
X-master-at: e3d457fb59f71dd40d24c82f48625a24492907d4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31803>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlYc5-0008DA-Vd for gcvg-git@gmane.org; Sat, 18 Nov
 2006 23:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753888AbWKRWYi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 17:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbWKRWYi
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 17:24:38 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:47492 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1753888AbWKRWYh
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 17:24:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118222436.VDCV9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 17:24:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oNQ81V00W1kojtg0000000; Sat, 18 Nov 2006
 17:24:08 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Executive Summary

 - 'maint' and 'master' are the same, since we are still in
   "v1.4.4 fix" mood right now.  A maintenance release v1.4.4.1
   should follow soonish.

 - 'next' has a few 'these are obviously the right things to me
   but I want a bit of cheering-up before pushing them out, and
   they can wait until the dust settles after early fixes to
   v1.4.4 anyway' changes.

 - 'pu' has the shallow clone WIP and a half-finished rewrite of
   git branch in C, both by Johannes.  Both needs a bit more
   polishing and confidence building before going into 'next',
   and given the recent discussion of enhancing branch
   management for pulls/pushes, it might be easier to drop the
   latter for now.

   I should also bring Shawn's piecemeal-mmap into 'pu'; I've
   looked at his code and it mostly looked sane.

----------------------------------------------------------------

* The 'maint' branch has these fixes since v1.4.4 release.  The
  'master' is the same as 'maint' right now.

  Alexandre Julliard:
    gitweb: Put back shortlog instead of graphiclog in the project list.

  Jim Meyering:
    Run "git repack -a -d" once more at end, if there's 1MB or more of
    not-packed data.

  Johannes Schindelin:
    Seek back to current filepos when mmap()ing with NO_MMAP

  Junio C Hamano:
    git-checkout: do not allow -f and -m at the same time.
    git-checkout: allow pathspec to recover lost working tree directory
    convert-objects: set _XOPEN_SOURCE to 600

  Linus Torvalds:
    git-pull: allow pulling into an empty repository
    "git fmt-merge-msg" SIGSEGV

  Petr Baudis:
    Fix git-for-each-refs broken for tags
    git-apply: Documentation typo fix
    Documentation: Define symref and update HEAD description

  Rene Scharfe:
    sparse fix: non-ANSI function declaration
    sparse fix: Using plain integer as NULL pointer
    git-apply: slightly clean up bitfield usage
    Document git-runstatus

* The 'next' branch, in addition, has these.

  Junio C Hamano
     upload-pack: stop the other side when they have more roots than we do.
     apply --numstat: mark binary diffstat with - -, not 0 0
     pack-objects: tweak "do not even attempt delta" heuristics


* The 'pu' branch, in addition, has these.

   Alexandre Julliard (1):
      Shallow clone: do not ignore shallowness when following tags

   Jakub Narebski (1):
      gitweb: New improved formatting of chunk header in diff

   Johannes Schindelin (6):
      upload-pack: no longer call rev-list
      support fetching into a shallow repository
      allow cloning a repository "shallowly"
      allow deepening of a shallow repository
      add tests for shallow stuff
      Build in shortlog

   Junio C Hamano (11):
      git-branch -a: show both local and remote tracking branches.
      git-commit: show --summary after successful commit.
      para-walk: walk n trees, index and working tree in parallel
      git-diff/git-apply: make diff output a bit friendlier to GNU patch (part 2)
      rev-list --left-right
      blame: --show-stats for easier optimization work.
      gitweb: steal loadavg throttle from kernel.org
      We should make sure that the protocol is still extensible.
      Why does it mean we do not have to register shallow if we have one?
      Why didn't we mark want_obj as ~UNINTERESTING in the old code?
      shallow clone: unparse and reparse an unshallowed commit

