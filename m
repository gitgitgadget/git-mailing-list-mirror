X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	SUBJ_ALL_CAPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.4
Date: Tue, 14 Nov 2006 23:43:17 -0800
Message-ID: <7vr6w5noiy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 15 Nov 2006 07:43:30 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31425>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkFQd-0007y2-7b for gcvg-git@gmane.org; Wed, 15 Nov
 2006 08:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965419AbWKOHnW convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006 02:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965983AbWKOHnW
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 02:43:22 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:18090 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S965419AbWKOHnT
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006
 02:43:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115074319.ZZBN18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 02:43:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mvjQ1V00U1kojtg0000000; Wed, 15 Nov 2006
 02:43:25 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The latest feature release GIT 1.4.4 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.4.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.4-1.$arch.rpm	(RPM)

Quite a lot of changes during the last month.

 - pack-refs, along with a lot of internal clean-up of the code
   that deal with refs, is in.  A repository with many tags
   would benefit from packing and pruning them.  Currently dumb
   transports are not capable of fetching from a repository that
   has packed and pruned its refs, so please keep that in mind.
   Hopefully we will get an update for dumb transports shortly.

 - git native transport can now keep transferred packs without
   exploding it into loose objects.  Also "git repack" can be
   told to keep "historical" packs from getting repacked by
   marking them with .keep file.  Docmentation update is
   probably needed.

 - git-blame can now detect line movements across files.  No, it
   is not called git-pickaxe.

 - a lot of gitweb and git-svn updates.

----------------------------------------------------------------

Changes since v1.4.3 are as follows:

Alan Chandler:
      Gitweb - provide site headers and footers

Alex Riesen:
      merge-recursive implicitely depends on trust_executable_bit

Alexandre Julliard:
      git.el: Added a function to open the current file in another wind=
ow.
      git.el: Added functions for moving to the next/prev unmerged file=
=2E
      git.el: Include MERGE_MSG in the log-edit buffer even when not co=
mmitting a merge.
      git.el: Move point after the log message header when entering log=
-edit mode.
      pack-refs: Store the full name of the ref even when packing only =
tags.
      prune-packed: Fix uninitialized variable.

Andy Parkins:
      git-clone documentation didn't mention --origin as equivalent of =
-o
      Make filenames line up in git-status output
      Minor grammar fixes for git-diff-index.txt
      Remove uneccessarily similar printf() from print_ref_list() in bu=
iltin-branch

Andy Whitcroft:
      cvsimport: move over to using git-for-each-ref to read refs.
      git-for-each-ref: improve the documentation on scripting modes

Aneesh Kumar K.V:
      gitweb: Remove extra "/" in path names for git_get_project_list

Christian Couder:
      Add pack-refs and show-ref test cases.
      Add [-s|--hash] option to Linus' show-ref.
      Check that a tag exists using show-ref instead of looking for the=
 ref file.
      Clean up "git-branch.sh" and add remove recursive dir test cases.
      Documentation: add git in /etc/services.
      Documentation: add upload-archive service to git-daemon.
      Document git-show-ref [-s|--hash] option.
      Do not create tag leading directories since git update-ref does i=
t.
      Fix a remove_empty_dir_recursive problem.
      Fix show-ref usage for --dereference.
      Remove --syslog in git-daemon inetd documentation examples.
      Uncomment test case: git branch c/d should barf if branch c exist=
s.
      Use git-update-ref to delete a tag instead of rm()ing the ref fil=
e.
      Use Linus' show ref in "git-branch.sh".
      When creating branch c/d check that branch c does not already exi=
sts.

Dennis Stosberg:
      lock_ref_sha1_basic does not remove empty directories on BSD
      Remove bashism from t3210-pack-refs.sh
      Bash completion support for aliases

Dmitry V. Levin:
      git-clone: define die() and use it.

Edgar Toernig:
      Use memmove instead of memcpy for overlapping areas

Eric Wong:
      git-send-email: do not pass custom Date: header
      git-svn: avoid printing filenames of files we're not tracking
      git-svn: don't die on rebuild when --upgrade is specified
      git-svn: fix dcommit losing changes when out-of-date from svn
      git-svn: fix symlink-to-file changes when using command-line svn =
1.4.0

Gerrit Pape:
      Set $HOME for selftests

J. Bruce Fields:
      Make prune also run prune-packed
      Documentation: updates to "Everyday GIT"

Jakub Narebski:
      diff-format.txt: Combined diff format documentation supplement
      diff-format.txt: Correct information about pathnames quoting in p=
atch format
      Documentation: Transplanting branch with git-rebase --onto
      Documentation: Update information about <format> in git-for-each-=
ref
      gitweb: Add "next" link to commitdiff view
      gitweb: Add '..' (up directory) to tree view if applicable
      gitweb: Better git-unquoting and gitweb-quoting of pathnames
      gitweb: Better support for non-CSS aware web browsers
      gitweb: Check git base URLs before generating URL from it
      gitweb: Do not esc_html $basedir argument to git_print_tree_entry
      gitweb: Filter out commit ID from @difftree in git_commit and git=
_commitdiff
      gitweb: Get rid of git_print_simplified_log
      gitweb: Improve git_print_page_path
      gitweb: Move git_get_last_activity subroutine earlier
      gitweb: New improved patchset view
      gitweb: Output also empty patches in "commitdiff" view
      gitweb: Print commit message without title in commitdiff only if =
there is any
      gitweb: Secure against commit-ish/tree-ish with the same name as =
path
      gitweb: Use character or octal escape codes (and add span.cntrl) =
in esc_path
      gitweb: Use git-for-each-ref to generate list of heads and/or tag=
s
      gitweb: Use --no-commit-id in git_commit and git_commitdiff
      gitweb: Use 's' regexp modifier to secure against filenames with =
LF
      gitweb: Whitespace cleanup - tabs are for indent, spaces are for =
align (2)

Jan Harkes:
      Continue traversal when rev-list --unpacked finds a packed commit=
=2E

Jeff King:
      wt-status: use simplified resolve_ref to find current branch
      gitignore: git-pack-refs is a generated file.
      gitignore: git-show-ref is a generated file.
      git-pickaxe: work properly in a subdirectory.
      Fix git-runstatus for repositories containing a file named HEAD

Jim Meyering:
      Don't use $author_name undefined when $from contains no /\s</.
      git-clone: honor --quiet
      xdiff/xemit.c (xdl_find_func): Elide trailing white space in a co=
ntext header.

Johannes Schindelin:
      Fix git-update-index --again
      show-branch: mark active branch with a '*' again
      Turn on recursive with --summary
      link_temp_to_file: call adjust_shared_perm() only when we created=
 the directory

Johannes Sixt:
      test-lib.sh: A command dying due to a signal is an unexpected fai=
lure.
      Catch errors when writing an index that contains invalid objects.

Jonas Fonseca:
      Add man page for git-show-ref
      git-update-index(1): fix use of quoting in section title

Junio C Hamano:
      Add callback data to for_each_ref() family.
      Add git-for-each-ref: helper for language bindings
      adjust_shared_perm: chmod() only when needed.
      apply: handle "traditional" creation/deletion diff correctly.
      blame.c: move code to output metainfo into a separate function.
      blame.c: whitespace and formatting clean-up.
      blame: Document and add help text for -f, -n, and -p
      branch: work in subdirectories.
      cherry is built-in, do not ship git-cherry.sh
      Clean-up lock-ref implementation
      combine-diff: a few more finishing touches.
      combine-diff: fix hunk_comment_line logic.
      combine-diff: honour --no-commit-id
      core.logallrefupdates create new log file only for branch heads.
      core.logallrefupdates thinko-fix
      daemon: do not die on older clients.
      delete_ref(): delete packed ref
      diff --numstat
      Documentation: clarify refname disambiguation rules.
      Documentation: fix git-format-patch mark-up and link it from git.=
txt
      Documentation: move blame examples
      Documentation: note about contrib/.
      Documentation/SubmittingPatches: 3+1 !=3D 6
      Document git-pack-refs and link it to git(7).
      Fix refs.c;:repack_without_ref() clean-up path
      Fix t1400-update-ref test minimally
      for-each-ref: "creator" and "creatordate" fields
      fsck-objects: adjust to resolve_ref() clean-up.
      GIT 1.4.3-rc1
      GIT 1.4.4
      GIT 1.4.4-rc2
      git-annotate: fix -S on graft file with comments.
      git-annotate: no need to exec blame; it is built-in now.
      git-blame: add internal statistics to count read blobs.
      git-blame --porcelain
      git-blame: --show-name (and -f)
      git-blame: --show-number (and -n)
      git-branch: remove D/F check done by hand.
      git-cvsserver: read from git with -z to get non-ASCII pathnames.
      git-diff/git-apply: make diff output a bit friendlier to GNU patc=
h (part 1)
      git-fetch: adjust to packed-refs.
      git-fetch: do not look into $GIT_DIR/refs to see if a tag exists.
      git-pack-refs --all
      git-pack-refs --prune
      git-pickaxe: allow -Ln,m as well as -L n,m
      git-pickaxe: allow "-L <something>,+N"
      git-pickaxe: blame rewritten.
      git-pickaxe: cache one already found path per commit.
      git-pickaxe -C: blame cut-and-pasted lines.
      git-pickaxe: do not confuse two origins that are the same.
      git-pickaxe: do not keep commit buffer.
      git-pickaxe: fix nth_line()
      git-pickaxe: fix origin refcounting
      git-pickaxe: get rid of wasteful find_origin().
      git-pickaxe: improve "best match" heuristics
      git-pickaxe: introduce heuristics to avoid "trivial" chunks
      git-pickaxe: -L /regexp/,/regexp/
      git-pickaxe -M: blame line movements within a file.
      git-pickaxe: optimize by avoiding repeated read_sha1_file().
      git-pickaxe: pagenate output by default.
      git-pickaxe: refcount origin correctly in find_copy_in_parent()
      git-pickaxe: rename detection optimization
      git-pickaxe: re-scan the blob after making progress with -C
      git-pickaxe: re-scan the blob after making progress with -M
      git-pickaxe: retire pickaxe
      git-pickaxe: simplify Octopus merges further
      git-pickaxe: split find_origin() into find_rename() and find_orig=
in().
      git-pickaxe: swap comparison loop used for -C
      git-pickaxe: tighten sanity checks.
      git-pickaxe: WIP to refcount origin structure.
      git-repack: repo.usedeltabaseoffset
      git-send-email: do not drop custom headers the user prepared
      git-send-email: real name with period need to be dq-quoted on Fro=
m: line
      git-status: quote LF in its output
      gitweb: do not give blame link unconditionally in diff-tree view
      gitweb: fix disabling of "forks"
      gitweb: fix unmatched div in commitdiff
      gitweb: make leftmost column of blame less cluttered.
      gitweb: minimally fix "fork" support.
      gitweb: prepare for repositories with packed refs.
      gitweb: protect blob and diff output lines from controls.
      gitweb: protect commit messages from controls.
      gitweb: spell "blame --porcelain" with -p
      gitweb: use blame --porcelain
      gitweb: use for-each-ref to show the latest activity across branc=
hes
      grep --all-match
      Introduce a new revision set operator <rev>^!
      link_temp_to_file: don't leave the path truncated on adjust_share=
d_perm failure
      lock_ref_sha1_basic: remove unused parameter "plen".
      lock_ref_sha1(): check D/F conflict with packed ref when creating=
=2E
      lock_ref_sha1(): do not sometimes error() and sometimes die().
      Make git-send-email detect mbox-style patches more readily
      merge: loosen overcautious "working file will be lost" check.
      merge-recursive: adjust to loosened "working file clobbered" chec=
k
      merge-recursive: make a few functions static.
      merge-recursive: use abbreviated commit object name.
      pack-objects: document --delta-base-offset option
      pack-refs: call fflush before fsync.
      pack-refs: do not pack symbolic refs.
      pack-refs: fix git_path() usage.
      pack-refs: use lockfile as everybody else does.
      pager: default to LESS=3DFRS
      pager: default to LESS=3DFRSX not LESS=3DFRS
      path-list: fix path-list-insert return value
      quote.c: ensure the same quoting across platforms.
      receive-pack: call setup_ident before git_config
      Refer to git-rev-parse:Specifying Revisions from git.txt
      ref locking: allow 'foo' when 'foo/bar' used to exist but not any=
more.
      ref-log: allow ref@{count} syntax.
      ref-log: fix D/F conflict coming from deleted refs.
      refs: minor restructuring of cached refs data.
      Revert 954a6183756a073723a7c9fd8d2feb13132876b0
      Revert "send-pack --keep: do not explode into loose objects on th=
e receiving end."
      revision traversal: --unpacked does not limit commit list anymore=
=2E
      RPM package re-classification.
      send-pack --keep: do not explode into loose objects on the receiv=
ing end.
      sha1_name.c: avoid compilation warnings.
      show-ref --hash=3Dlen, --abbrev=3Dlen, and --abbrev
      Surround "#define DEBUG 0" with "#ifndef DEBUG..#endif"
      symbolit-ref: fix resolve_ref conversion.
      t3200: git-branch testsuite update
      t6022: ignoring untracked files by merge-recursive when they do n=
ot matter
      Teach receive-pack about ref-log
      teach revision walker about --all-match.
      Tell between packed, unpacked and symbolic refs.
      tests: merge-recursive is usable without Python
      update a few Porcelain-ish for ref lock safety.
      Update cherry documentation.
      update-ref: -d flag and ref creation safety.

Karl Hasselstr=C3=B6m:
      git-vc: better installation instructions
      ignore-errors requires cl

Lars Hjemli:
      Fix typo in show-index.c
      Fix usagestring for git-branch
      Make git-branch a builtin
      Fix show-ref usagestring

Linus Torvalds:
      Add "git show-ref" builtin command
      Teach "git checkout" to use git-show-ref
      Start handling references internally as a sorted in-memory list
      Add support for negative refs
      Make ref resolution saner
      Enable the packed refs file format
      git-apply: prepare for upcoming GNU diff -u format change.
      Allow '-' in config variable names
      git push: add verbose flag and allow overriding of default target=
 repository

Luben Tuikov:
      gitweb: blame: print commit-8 on the leading row of a commit-bloc=
k
      gitweb: blame: Mouse-over commit-8 shows author and date
      gitweb: blame porcelain: lineno and orig lineno swapped
      git-revert with conflicts to behave as git-merge with conflicts
      gitweb: esc_html() author in blame

Martin Waitz:
      gitweb: start to generate PATH_INFO URLs.
      gitweb: warn if feature cannot be overridden.

Matthew Wilcox:
      Add --dry-run option to git-send-email

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
      Reject hexstring longer than 40-bytes in get_short_sha1()
      Add revspec documentation for ':path', ':[0-3]:path' and git-desc=
ribe

Nicolas Pitre:
      introduce delta objects with offset to base
      teach git-unpack-objects about deltas with offset to base
      teach git-index-pack about deltas with offset to base
      make git-pack-objects able to create deltas with offset to base
      make pack data reuse compatible with both delta types
      let the GIT native protocol use offsets to delta base when possib=
le
      zap a debug remnant
      allow delta data reuse even if base object is a preferred base
      index-pack: compare only the first 20-bytes of the key.
      reduce delta head inflated size
      add the capability for index-pack to read from a stream
      enable index-pack streaming capability
      make index-pack able to complete thin packs.
      add progress status to index-pack
      mimic unpack-objects when --stdin is used with index-pack
      enhance clone and fetch -k experience
      index-pack: minor fixes to comment and function name
      missing small substitution
      pack-objects doesn't create random pack names
      make git-push a bit more verbose
      Allow pack header preprocessing before unpack-objects/index-pack.
      git-fetch can use both --thin and --keep with fetch-pack now
      improve fetch-pack's handling of kept packs
      have index-pack create .keep file more carefully
      remove .keep pack lock files when done with refs update
      git-pack-objects progress flag documentation and cleanup

OGAWA Hirofumi:
      gitk: Fix nextfile() and add prevfile()

Petr Baudis:
      Fix broken sha1 locking
      Fix buggy ref recording
      gitweb: Document features better
      gitweb: Fix search form when PATH_INFO is enabled
      bisect reset: Leave the tree in usable state if git-checkout fail=
ed
      gitweb: Fix setting $/ in parse_commit()
      gitweb: Restore object-named links in item lists
      gitweb: Make search type a popup menu
      gitweb: Do not automatically append " git" to custom site name
      gitweb: Show project's README.html if available
      xdiff: Match GNU diff behaviour when deciding hunk comment worthi=
ness of lines
      gitweb: Support for 'forks'
      gitweb: Fix up bogus $stylesheet declarations
      Nicer error messages in case saving an object to db goes wrong

Rene Scharfe:
      git-archive --format=3Dzip: use default version ID
      git-archive --format=3Dzip: add symlink support
      git-merge: show usage if run without arguments
      Built-in cherry
      Make git-cherry handle root trees
      git-cherry: document limit and add diagram

Robert Shearman:
      git-rebase: Use --ignore-if-in-upstream option when executing git=
-format-patch.
      git-rebase: Add a -v option to show a diffstat of the changes ups=
tream at the start of a rebase.
      git-rebase: Use --ignore-if-in-upstream option when executing git=
-format-patch.

Robin Rosenberg:
      Mention that pull can work locally in the synopsis
      Swap the porcelain and plumbing commands in the git man page
      Rework cvsexportcommit to handle binary files for all cases.

Ryan Anderson:
      Remove git-annotate.perl and create a builtin-alias for git-blame

Santi B=C3=A9jar:
      fetch: Misc output cleanup
      merge and resolve: Output short hashes and .. in "Updating ..."
      Documentation for the [remote] config

Sasha Khapyorsky:
      git-svnimport.perl: copying directory from original SVN place
      git-svnimport: support for partial imports

Sean Estabrooks:
      Add --global option to git-repo-config.

Sergey Vlasov:
      git-send-email: Document support for local sendmail instead of SM=
TP server
      git-send-email: Read the default SMTP server from the GIT config =
file

Shawn Pearce:
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
      Use column indexes in git-cvsserver where necessary.
      Allow short pack names to git-pack-objects --unpacked=3D.
      Only repack active packs by skipping over kept packs.
      Teach git-index-pack how to keep a pack file.
      Remove unused variable in receive-pack.
      Move deny_non_fast_forwards handling completely into receive-pack=
=2E
      Teach receive-pack how to keep pack files based on object count.

Tero Roponen:
      remove an unneeded test

Tuncer Ayaz:
      git-fetch.sh printed protocol fix

