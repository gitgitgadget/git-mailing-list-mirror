From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sun, 28 May 2006 23:44:06 -0700
Message-ID: <7vac919vpl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 08:44:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkbU7-0005nB-LQ
	for gcvg-git@gmane.org; Mon, 29 May 2006 08:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWE2GoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 02:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWE2GoI
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 02:44:08 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48376 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751145AbWE2GoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 02:44:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060529064406.LJGP19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 May 2006 02:44:06 -0400
To: git@vger.kernel.org
X-maint-at: be0c7e069738fbb697b0719f2252107261c9340e
X-master-at: cd01d9445de1bbca8952c7ee16941f5fa10747f5
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20925>

* The 'master' branch has these since the last announcement.
  This is a fairly big update.

 - git-apply takes notice of beginning and end of file as
   context (Catalin Marinas, Linus and me)
      apply: treat EOF as proper context.
      apply: force matching at the beginning.

 - gitview updates (Aneesh Kumar K.V)

 - git-mailinfo updates (Eric W. Biederman and me)
      Make read_one_header_line return a flag not a length.
      Move B and Q decoding into check header.
      Refactor commit messge handling.
      In handle_body only read a line if we don't already have one.
      More accurately detect header lines in read_one_header_line
      Allow in body headers beyond the in body header prefix.
      mailinfo: skip bogus UNIX From line inside body
      mailinfo: More carefully parse header lines in read_one_header_line()

 - format-patch --start-number (Johannes Schindelin and me)
      cache-tree: replace a sscanf() by two strtol() calls
      Fix crash when reading the empty tree
      git-format-patch --start-number <n>
      built-in format-patch: various fixups.
      format-patch: -n and -k are mutually exclusive.

 - ls-remote rsync:// fix (me)
      ls-remote: fix rsync:// to report HEAD

   * This should fix clone over rsync:// (which is deprecated
     but anyway).

 - cache-tree optimization for apply & write-tree sequence (me,
      Johannes, Dennis Stosberg)
      read-cache/write-cache: optionally return cache checksum SHA1.
      Add cache-tree.
      Update write-tree to use cache-tree.
      Invalidate cache-tree entries for touched paths in git-apply.
      Use cache-tree in update-index.
      Add test-dump-cache-tree
      cache-tree: protect against "git prune".
      index: make the index file format extensible.
      Teach fsck-objects about cache-tree.
      cache-tree: sort the subtree entries.
      test-dump-cache-tree: report number of subtrees.
      update-index: when --unresolve, smudge the relevant cache-tree entries.
      read-tree: teach 1 and 2 way merges about cache-tree.
      read-tree: teach 1-way merege and plain read to prime cache-tree.
      cache_tree_update: give an option to update cache-tree only.
      test-dump-cache-tree: validate the cached data as well.
      cache-tree.c: typefix
      fsck-objects: mark objects reachable from cache-tree
      Fix test-dump-cache-tree in one-tree disappeared case.
      read-tree: invalidate cache-tree entry when a new index entry is added.
      cache-tree: a bit more debugging support.
      fsck-objects: do not segfault on missing tree in cache-tree
      fix git-write-tree with cache-tree on BE64

    * I've held onto this too long but haven't seen breakage.
      This should make cycles of "apply & write-tree" faster by
      15-20%.

 - documentation (Jeff King)
      cat-file: document -p option

 - cvsimport Perl backward compatibility (Jeff King)
      cvsimport: avoid "use" with :tag

 - build fixes (Jim Meyering, Martin Waitz)
      Don't write directly to a make target ($@).
      Documentation/Makefile: remove extra /
      Add instructions to commit template.

 - "git-clone --template" (me)
      Let git-clone to pass --template=dir option to git-init-db.

 - various fixes and cleanups (Linus, Martin Waitz, Petr Baudis,
   Shawn Pearce, me)
      builtin-rm: squelch compiler warnings.
      fetch.c: remove an unused variable and dead code.
      git-fetch: avoid using "case ... in (arm)"
      bogus "fatal: Not a git repository"
      t1002: use -U0 instead of --unified=0
      Fix "--abbrev=xyz" for revision listing
      Don't use "sscanf()" for tree mode scanning
      Call builtin ls-tree in git-cat-file -p
      Built git-upload-tar should be ignored.

 - rev-list --objects memory leak fix (Linus)
      Fix memory leak in "git rev-list --objects"

 - cvsexportcommit fixups (Yann Dirson)
      Do not call 'cmp' with non-existant -q flag.
      Document current cvsexportcommit limitations.
      Make cvsexportcommit create parent directories as needed.


* The 'next' branch, in addition, has these.

 - portability of tests across different bourne flavors (Eric Wong)
      t3300-funny-names: shell portability fixes
      tests: Remove heredoc usage inside quotes
      t5500-fetch-pack: remove local (bashism) usage.
      t6000lib: workaround a possible dash bug

   * I think these are OK to push out to "master".

 - read-tree/write-tree --prefix from bind commit series (me)
      read-tree: --prefix=<path>/ option.
      write-tree: --prefix=<path>
      read-tree: reorganize bind_merge code.

   * I think these are OK to push out to "master".

 - avoid wasted work in fetch-pack when receiving side has more
   roots than the sender (me).
      fetch-pack: give up after getting too many "ack continue"

   * While this would not hurt, it is a client-side hack.  To
     fix the problem properly, the server side needs to become a
     bit smarter.

 - tree parser reorganization (Linus)
      Add raw tree buffer info to "struct tree"
      Make "tree_entry" have a SHA1 instead of a union of object pointers
      Switch "read_tree_recursive()" over to tree-walk functionality
      Remove "tree->entries" tree-entry list from tree parser

   * This looks good; I would like to cook this for a while in
     "next", and mark its graduation with 1.4.0 release.

 - test fix for http-fetch segfault (Sean Estabrooks)

   * Status?

 - ref-log (Shawn Pearce)
      Improve abstraction of ref lock/write.
      Convert update-ref to use ref_lock API.
      Log ref updates to logs/refs/<ref>
      Support 'master@2 hours ago' syntax
      Fix ref log parsing so it works properly.
      General ref log reading improvements.
      Added logs/ directory to repository layout.
      Force writing ref if it doesn't exist.
      Log ref updates made by fetch.
      Change 'master@noon' syntax to 'master@{noon}'.
      Correct force_write bug in refs.c
      Change order of -m option to update-ref.
      Include ref log detail in commit, reset, etc.
      Create/delete branch ref logs.
      Enable ref log creation in git checkout -b.
      Verify git-commit provides a reflog message.
      Test that git-branch -l works.

   * I think these are OK to push out to "master" in that it
     does not seem to cause regression, but I haven't used this
     change for real work.  Impressions?


* The 'pu' branch, in addition, has these.

 - $HOME/.gitrc (Petr Baudis)
      Read configuration also from ~/.gitrc

   * I like this but it breaks the tests big time.  Not "next"
     material yet, unfortunately.
