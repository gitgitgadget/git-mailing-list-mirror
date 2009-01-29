From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Jan 2009, #04; Wed, 28)
Date: Wed, 28 Jan 2009 18:06:12 -0800
Message-ID: <7v1vumkgrv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 03:07:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSMJn-00062U-1w
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 03:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbZA2CGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 21:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbZA2CGT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 21:06:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbZA2CGT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 21:06:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9BDC51D6B6;
	Wed, 28 Jan 2009 21:06:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C34201D69D; Wed,
 28 Jan 2009 21:06:14 -0500 (EST)
X-maint-at: 02322e1619dc537dc48650761f6c9bae883612a7
X-master-at: 8712b3cdb0495f5a56b91cd67e2697412447a886
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69805B76-EDA9-11DD-A0E4-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107612>

Folks at Github found that v1.6.1 clients barf when pushing over git
protocol to v1.6.1 server if (1) the repository pushed into borrows
objects from another repository, and (2) the repository that lends the
objects has updates the pusher does not have.  The 'maint' branch has a
fix for it which 1.6.1.2 will contain when it comes out.

The master has accumulated enough new features; we should start the -rc
freeze soon (with the topics we have in 'next' as of today).


* The 'maint' branch has these fixes since the last announcement.

Johannes Schindelin (2):
  get_sha1_basic(): fix invalid memory access, found by valgrind
  test-path-utils: Fix off by one, found by valgrind

Junio C Hamano (2):
  GIT 1.6.1.1
  send-pack: do not send unknown object name from ".have" to pack-objects


* The 'master' branch has these since the last announcement
  in addition to the above.

Benjamin Kramer (1):
  Ignore test-ctype

Boyd Stephen Smith Jr (2):
  color-words: Support diff.wordregex config option
  Change the spelling of "wordregex".

Clemens Buchacher (2):
  clean up pathspec matching
  remove pathspec_match, use match_pathspec instead

Eric Wong (1):
  git-svn: fix memory leak when checking for empty symlinks

Giuseppe Bilotta (6):
  gitweb: channel image in rss feed
  gitweb: feed generator metadata
  gitweb: rss feed managingEditor
  gitweb: rss channel date
  gitweb: last-modified time should be commiter, not author
  gitweb: check if-modified-since for feeds

Jay Soffian (1):
  git-am: minor cleanups

Johannes Schindelin (7):
  Add color_fwrite_lines(), a function coloring each line individually
  color-words: refactor word splitting and use ALLOC_GROW()
  color-words: change algorithm to allow for 0-character word boundaries
  color-words: take an optional regular expression describing words
  revision walker: include a detached HEAD in --all
  Fix parsing of @{-1}@{1}
  rebase -i --root: fix check for number of arguments

Johannes Sixt (1):
  Windows: Fix intermittent failures of t7701

Junio C Hamano (10):
  checkout: implement "@{-N}" shortcut name for N-th last branch
  bundle: allow the same ref to be given more than once
  interpret_nth_last_branch(): avoid traversing the reflog twice
  Fix reflog parsing for a malformed branch switching entry
  interpret_nth_last_branch(): plug small memleak
  Introduce for_each_recent_reflog_ent().
  Simplify parsing branch switching events in reflog
  http-push.c: style fixes
  rebase -i: correctly remember --root flag across --continue
  tests: Avoid single-shot environment export for shell function invocation

Kjetil Barvik (5):
  lstat_cache(): more cache effective symlink/directory detection
  lstat_cache(): introduce has_symlink_or_noent_leading_path() function
  lstat_cache(): introduce has_dirs_only_path() function
  lstat_cache(): introduce invalidate_lstat_cache() function
  lstat_cache(): introduce clear_lstat_cache() function

Miklos Vajna (1):
  gittutorial: remove misleading note

Nanako Shiraishi (1):
  Mention "local convention" rule in the CodingGuidelines

Serge van den Boom (1):
  Makefile: Make 'configure --with-expat=path' actually work

Sverre Rabbelier (1):
  Allow cloning an empty repository

Ted Pavlic (1):
  make: Remove -pthread on Darwin (it is included by cstdlib).

Teemu Likonen (1):
  diff-options.txt: Fix asciidoc markup issue

Thomas Rast (7):
  color-words: enable REG_NEWLINE to help user
  color-words: expand docs with precise semantics
  color-words: make regex configurable via attributes
  sha1_name: tweak @{-N} lookup
  sha1_name: support @{-N} syntax in get_sha1()
  checkout: implement "-" abbreviation, add docs and tests
  t1505: remove debugging cruft

Vitaly \"_Vi\" Shukela (3):
  git-svn: add --ignore-paths option for fetching
  git-svn: documented --ignore-paths
  git-svn: Add test for --ignore-paths parameter
