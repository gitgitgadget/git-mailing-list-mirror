From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sat, 21 Apr 2007 23:22:59 -0700
Message-ID: <7vlkglq664.fsf@assigned-by-dhcp.cox.net>
References: <7vfy71yupd.fsf@assigned-by-dhcp.cox.net>
	<7virbtck12.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 08:23:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfVTf-0003q1-4Q
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 08:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbXDVGXB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 02:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbXDVGXB
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 02:23:01 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:32907 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964810AbXDVGXA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 02:23:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422062300.GTLO1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 02:23:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id q6Nz1W00K1kojtg0000000; Sun, 22 Apr 2007 02:23:00 -0400
X-maint-at: 97317061c6799765c7f2f83d8e3f4f74df469793
X-master-at: 42c4b58059fa9af65e90f2c418bb551e30d1d32f
In-Reply-To: <7virbtck12.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 18 Apr 2007 16:58:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45220>

The latest maintenance release v1.5.1.2 is out.

Tonight's 'master' contains 64-bit index, core subproject
support, and gitattributes (but not the controversial "filter"
part).  As I promised I'd do something about attributes some
time ago (I think it was during v1.5.1 stabilization period), I
am reasonably happy with the state of 'master' right now.  The
other two major topics are also nice, unexpected bonus toward
v1.5.2 from my point of view.

Please expect stabilization cycle for v1.5.2 to start soon.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last
  announcement; these are all contained in v1.5.1.2, the latest
  maintenance release.

 Andrew Ruder (4):
  Update git-archive documentation
  Update git-cherry-pick documentation
  Fix unmatched emphasis tag in git-tutorial
  Update git-config documentation

 Andy Whitcroft (1):
  fix up strtoul_ui error handling

 Eric Wong (1):
  perl: install private Error.pm if the site version is older than our own

 Junio C Hamano (2):
  git-clone: fix dumb protocol transport to clone from pack-pruned ref
  GIT 1.5.1.2

 Sam Vilain (1):
  git-tar-tree: complete deprecation conversion message


* The 'master' branch has these since the last announcement
  in addition to the above.

 Alex Riesen (2):
  Tests for core subproject support
  Simplify calling of CR/LF conversion routines

 Alexandre Julliard (1):
  git.el: Add a commit description to the reflog.

 Aneesh Kumar K.V (1):
  gitview: annotation support

 Brian Gernhardt (1):
  Remove case-sensitive file in t3030-merge-recursive.

 James Bowes (1):
  Document git-check-attr

 Julian Phillips (1):
  refs.c: add a function to sort a ref list, rather then sorting on add

 Junio C Hamano (30):
  git-fetch--tool pick-rref
  git-fetch: use fetch--tool pick-rref to avoid local fetch from alternate
  Add basic infrastructure to assign attributes to paths
  Define 'crlf' attribute.
  Teach 'diff' about 'diff' attribute.
  Fix 'crlf' attribute semantics.
  Fix 'diff' attribute semantics.
  Makefile: add patch-ids.h back in.
  attribute macro support
  Define a built-in attribute macro "binary".
  Change attribute negation marker from '!' to '-'.
  Make sure quickfetch is not fooled with a previous, incomplete fetch.
  Allow more than true/false to attributes.
  merge-recursive: separate out xdl_merge() interface.
  Allow specifying specialized merge-backend per path.
  Add a demonstration/test of customized merge.
  Custom low-level merge driver support.
  Allow the default low-level merge driver to be configured.
  Custom low-level merge driver: change the configuration scheme.
  Allow low-level driver to specify different behaviour during internal merge.
  Fix funny types used in attribute value representation
  Counto-fix in merge-recursive
  Simplify code to find recursive merge driver.
  Documentation: support manual section (5) - file formats.
  Update 'crlf' attribute semantics.
  Document gitattributes(5)
  git-add -u: match the index with working tree.
  Fix bogus linked-list management for user defined merge drivers.
  convert.c: restructure the attribute checking part.
  lockfile: record the primary process.

 Linus Torvalds (21):
  diff-lib: use ce_mode_from_stat() rather than messing with modes manually
  Avoid overflowing name buffer in deep directory structures
  Add 'resolve_gitlink_ref()' helper function
  Add "S_IFDIRLNK" file mode infrastructure for git links
  Teach "fsck" not to follow subproject links
  Teach core object handling functions about gitlinks
  Fix thinko in subproject entry sorting
  Teach directory traversal about subprojects
  Teach git-update-index about gitlinks
  Don't show gitlink directories when we want "other" files
  Teach git list-objects logic not to follow gitlinks
  Teach "git-read-tree -u" to check out submodules as a directory
  Fix gitlink index entry filesystem matching
  Teach git list-objects logic to not follow gitlinks
  Teach "git-read-tree -u" to check out submodules as a directory
  Fix some "git ls-files -o" fallout from gitlinks
  Expose subprojects as special files to "git diff" machinery
  Use proper object allocators for unknown object nodes too
  Clean up object creation to use more common code
  Fix working directory errno handling when unlinking a directory
  Fix a copy-n-paste bug in the object decorator code.

 Nicolas Pitre (27):
  get rid of num_packed_objects()
  make overflow test on delta base offset work regardless of variable size
  add overflow tests on pack offset variables
  compute a CRC32 for each object as stored in a pack
  compute object CRC32 with index-pack
  pack-objects: learn about pack index version 2
  index-pack: learn about pack index version 2
  sha1_file.c: learn about index version 2
  show-index.c: learn about index v2
  pack-redundant.c: learn about index v2
  allow forcing index v2 and 64-bit offset treshold
  validate reused pack data with CRC when possible
  simple random data generator for tests
  use test-genrandom in tests instead of /dev/urandom
  tests for various pack index features
  clean up add_object_entry()
  pack-objects: optimize preferred base handling a bit
  pack-objects: equal objects in size should delta against newer objects
  pack-objects: rework check_delta_limit usage
  pack-objects: clean up list sorting
  pack-objects: get rid of reuse_cached_pack
  pack-objects: get rid of create_final_object_list()
  pack-objects: make in_pack_header_size a variable of its own
  add get_size_from_delta()
  pack-objects: better check_object() performances
  pack-objects: remove obsolete comments
  document --index-version for index-pack and pack-objects

 Shawn O. Pearce (2):
  Contribute a fairly paranoid update hook
  Kill the useless progress meter in merge-recursive
