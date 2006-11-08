X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Tue, 07 Nov 2006 19:21:24 -0800
Message-ID: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 03:21:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-maint-at: 0623421b0beb5dc4bbe4eb598275e2a608226dec
X-master-at: baf0bfcb4b335438e9359835f2c27cccf20e54a3
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31112>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghe0J-0007rM-RO for gcvg-git@gmane.org; Wed, 08 Nov
 2006 04:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753976AbWKHDV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 22:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753985AbWKHDV0
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 22:21:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52620 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1753976AbWKHDVZ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 22:21:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061108032125.ZONF13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Tue, 7
 Nov 2006 22:21:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id k3M11V01h1kojtg0000000; Tue, 07 Nov 2006
 22:21:02 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Executive Summary.

[maint]

  I might do a 1.4.3.5 with the accumulated stuff, but the
  stablization cycle for v1.4.4 has started tonight, so it may
  not be worth the effort, unless something more pressing comes
  along.

[master]

  Three topics that have been cooking in 'next' have been
  merged, I've tagged the tip as v1.4.4-rc1.

   - Nico and Shawn's keep-pack work;

   - Loosening of bogusly overstrict 'a working tree file will
     be overwritten by the merge' check;

   - git-pickaxe.

[next]

  This now is almost empty, and I'd like to keep it that way
  until v1.4.5 final.  IOW, I'd be happier if people sent in
  only obviously correct fixes to 'master' than seeing the next
  greatest feature ;-).

  By the way, do people mind if I start to rewind and rebase
  'next' after every feature release (i.e. tagged release is
  made after 'master')?  I do not feel a strong need for it, and
  'git log --no-merges master..next' will show emptiness
  eventually, but being able to restart from clean slate after a
  release would be somewhat nice.

[pu]

  Johannes's shallow clone work now should rebase cleanly on top
  of 'master' although I haven't done so yet.  As he said
  himself the series is waiting for people who have needs for
  such a feature to raise hands.

  The part #2 of git-diff/git-apply change has a slight backward
  compatibility issue, and until everybody who is affected is
  upgraded to v1.4.3 (which has already prepared us for this
  change) we cannot push it out to 'master'.  It adjusts the
  diff output header for files with SP in their names to what
  GNU patch accepts.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

   Alex Riesen (1):
      merge-recursive implicitely depends on trust_executable_bit

   Andy Parkins (2):
      Minor grammar fixes for git-diff-index.txt
      git-clone documentation didn't mention --origin as equivalent of -o

   Jakub Narebski (1):
      Documentation: Transplanting branch with git-rebase --onto

   Jeff King (1):
      Fix git-runstatus for repositories containing a file named HEAD

   Johannes Schindelin (1):
      link_temp_to_file: call adjust_shared_perm() only when we created the directory

   Junio C Hamano (2):
      apply: handle "traditional" creation/deletion diff correctly.
      adjust_shared_perm: chmod() only when needed.

   Shawn O. Pearce (3):
      Use ULONG_MAX rather than implicit cast of -1.
      Remove SIMPLE_PROGRAMS and make git-daemon a normal program.
      Remove unsupported C99 style struct initializers in git-archive.

   Tero Roponen (1):
      remove an unneeded test

* The 'master' branch has these since the last announcement.

   Alex Riesen (1):
      merge-recursive implicitely depends on trust_executable_bit

   Alexandre Julliard (5):
      pack-refs: Store the full name of the ref even when packing only tags.
      git.el: Added functions for moving to the next/prev unmerged file.
      git.el: Added a function to open the current file in another window.
      git.el: Move point after the log message header when entering log-edit mode.
      git.el: Include MERGE_MSG in the log-edit buffer even when not committing a merge.

   Andy Parkins (3):
      Remove uneccessarily similar printf() from print_ref_list() in builtin-branch
      Minor grammar fixes for git-diff-index.txt
      git-clone documentation didn't mention --origin as equivalent of -o

   Aneesh Kumar K.V (1):
      gitweb: Remove extra "/" in path names for git_get_project_list

   Eric Wong (2):
      git-svn: avoid printing filenames of files we're not tracking
      git-svn: don't die on rebuild when --upgrade is specified

   Jakub Narebski (4):
      gitweb: Use git-for-each-ref to generate list of heads and/or tags
      gitweb: Output also empty patches in "commitdiff" view
      gitweb: Better support for non-CSS aware web browsers
      Documentation: Transplanting branch with git-rebase --onto

   Jeff King (2):
      git-pickaxe: work properly in a subdirectory.
      Fix git-runstatus for repositories containing a file named HEAD

   Johannes Schindelin (1):
      link_temp_to_file: call adjust_shared_perm() only when we created the directory

   Junio C Hamano (40):
      git-pickaxe: blame rewritten.
      git-pickaxe -M: blame line movements within a file.
      git-pickaxe -C: blame cut-and-pasted lines.
      git-pickaxe: pagenate output by default.
      git-pickaxe: fix nth_line()
      git-pickaxe: improve "best match" heuristics
      git-pickaxe: introduce heuristics to avoid "trivial" chunks
      git-pickaxe: do not keep commit buffer.
      git-pickaxe: do not confuse two origins that are the same.
      git-pickaxe: get rid of wasteful find_origin().
      git-pickaxe: swap comparison loop used for -C
      merge: loosen overcautious "working file will be lost" check.
      merge-recursive: use abbreviated commit object name.
      merge-recursive: make a few functions static.
      merge-recursive: adjust to loosened "working file clobbered" check
      t6022: ignoring untracked files by merge-recursive when they do not matter
      send-pack --keep: do not explode into loose objects on the receiving end.
      git-pickaxe: WIP to refcount origin structure.
      git-pickaxe: allow -Ln,m as well as -L n,m
      git-pickaxe: refcount origin correctly in find_copy_in_parent()
      git-pickaxe: tighten sanity checks.
      Revert "send-pack --keep: do not explode into loose objects on the receiving end."
      git-pickaxe: split find_origin() into find_rename() and find_origin().
      git-pickaxe: cache one already found path per commit.
      Introduce a new revision set operator <rev>^!
      for-each-ref: "creator" and "creatordate" fields
      apply: handle "traditional" creation/deletion diff correctly.
      git-pickaxe: rename detection optimization
      git-pickaxe: simplify Octopus merges further
      git-pickaxe: re-scan the blob after making progress with -M
      git-pickaxe: re-scan the blob after making progress with -C
      git-pickaxe: fix origin refcounting
      cherry is built-in, do not ship git-cherry.sh
      git-blame: add internal statistics to count read blobs.
      git-pickaxe: optimize by avoiding repeated read_sha1_file().
      adjust_shared_perm: chmod() only when needed.
      Document git-pack-refs and link it to git(7).
      git-pickaxe: -L /regexp/,/regexp/
      git-pickaxe: allow "-L <something>,+N"
      GIT 1.4.3-rc1

   Linus Torvalds (2):
      Allow '-' in config variable names
      git push: add verbose flag and allow overriding of default target repository

   Nicolas Pitre (14):
      enable index-pack streaming capability
      make index-pack able to complete thin packs.
      add progress status to index-pack
      mimic unpack-objects when --stdin is used with index-pack
      enhance clone and fetch -k experience
      index-pack: minor fixes to comment and function name
      missing small substitution
      make git-push a bit more verbose
      Allow pack header preprocessing before unpack-objects/index-pack.
      git-fetch can use both --thin and --keep with fetch-pack now
      improve fetch-pack's handling of kept packs
      have index-pack create .keep file more carefully
      remove .keep pack lock files when done with refs update
      git-pack-objects progress flag documentation and cleanup

   Petr Baudis (1):
      gitweb: Support for 'forks'

   Sean Estabrooks (1):
      Add --global option to git-repo-config.

   Shawn O. Pearce (11):
      Added completion support for git-branch.exe.
      Added bash completion support for git-reset.
      Use ULONG_MAX rather than implicit cast of -1.
      Remove SIMPLE_PROGRAMS and make git-daemon a normal program.
      Remove unsupported C99 style struct initializers in git-archive.
      Added missing completions for show-branch and merge-base.
      Only load .exe suffix'd completions on Cygwin.
      Bash completion support for remotes in .git/config.
      Take --git-dir into consideration during bash completion.
      Support bash completion on symmetric difference operator.
      Remove more sed invocations from within bash completion.

   Shawn Pearce (5):
      Allow short pack names to git-pack-objects --unpacked=.
      Only repack active packs by skipping over kept packs.
      Teach git-index-pack how to keep a pack file.
      Remove unused variable in receive-pack.
      Teach receive-pack how to keep pack files based on object count.

   Tero Roponen (1):
      remove an unneeded test


* The 'next' branch, in addition, has these.

   Junio C Hamano:
      upload-pack: stop the other side when they have more roots than we do.


* The 'pu' branch, in addition, has these.

   Johannes Schindelin (6):
      Build in shortlog
      upload-pack: no longer call rev-list
      support fetching into a shallow repository
      allow cloning a repository "shallowly"
      allow deepening of a shallow repository
      add tests for shallow stuff

   Junio C Hamano (6):
      git-branch -a: show both local and remote tracking branches.
      git-commit: show --summary after successful commit.
      para-walk: walk n trees, index and working tree in parallel
      git-diff/git-apply: make diff output a bit friendlier to GNU patch (part 2)
      rev-list --left-right
      blame and pickaxe: --show-stats for easier optimization work.

