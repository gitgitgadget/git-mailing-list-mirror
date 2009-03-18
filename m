From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Mar 2009, #05; Tue, 17)
Date: Tue, 17 Mar 2009 22:41:30 -0700
Message-ID: <7vd4cfmlpx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 06:43:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjoYt-0001ZR-JI
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 06:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbZCRFlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 01:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbZCRFlh
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 01:41:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbZCRFlg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 01:41:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4BECD7048;
	Wed, 18 Mar 2009 01:41:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8EFF17046; Wed,
 18 Mar 2009 01:41:32 -0400 (EDT)
X-maint-at: 6f55ee4317681a5639ff364d2f0a352bde064269
X-master-at: e986ceb05a118944d2638fba4cd09678c1afa6b3
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 70DD4324-137F-11DE-9F65-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113580>

Notable topics graduated are Jay's "git remote" improvements, Kjetil's
"git checkout" optimization, and Ren=C3=A9's "git grep --color".

Post 1.6.2 cycle seems to be nicely progressing, and with another mass
graduation like this hopefully we can go into pre-release freeze for th=
e
next release fairly soon.

* The 'master' branch has these since the last announcement
  in addition to what are already in v1.6.2.1.

Alex Riesen (1):
  disable post-checkout test on Cygwin

Benjamin Kramer (1):
  Fix various dead stores found by the clang static analyzer

Brian Gernhardt (2):
  Create USE_ST_TIMESPEC and turn it on for Darwin
  Makefile: Set compiler switch for USE_NSEC

Chris Johnsen (2):
  git-push.txt: describe how to default to pushing only current branch
  Documentation: remove extra quoting/emphasis around literal texts

Daniel Barkalow (1):
  Give error when no remote is configured

Emil Sit (1):
  config.txt: Describe special 'none' handling in core.gitProxy.

Jay Soffian (18):
  move duplicated get_local_heads() to remote.c
  move duplicated ref_newer() to remote.c
  move locate_head() to remote.c
  remote: simplify guess_remote_head()
  remote: make copy_ref() perform a deep copy
  remote: let guess_remote_head() optionally return all matches
  remote: make match_refs() copy src ref before assigning to peer_ref
  remote: make match_refs() not short-circuit
  string-list: new for_each_string_list() function
  builtin-remote: refactor duplicated cleanup code
  builtin-remote: remove unused code in get_ref_states
  builtin-remote: rename variables and eliminate redundant function cal=
l
  builtin-remote: make get_remote_ref_states() always populate
    states.tracked
  builtin-remote: fix two inconsistencies in the output of "show <remot=
e>"
  builtin-remote: teach show to display remote HEAD
  builtin-remote: add set-head subcommand
  builtin-remote: new show output style
  builtin-remote: new show output style for push refspecs

Jeff King (5):
  test scripts: refactor start_httpd helper
  add basic http clone/fetch tests
  refactor find_ref_by_name() to accept const list
  remote: make guess_remote_head() use exact HEAD lookup if it is avail=
able
  ls-files: require worktree when --deleted is given

Johannes Schindelin (2):
  rsync transport: allow local paths, and fix tests
  winansi: support ESC [ K (erase in line)

Johannes Sixt (1):
  recv_sideband: Bands #2 and #3 always go to stderr

Junio C Hamano (6):
  builtin-remote.c: no "commented out" code, please
  Not all systems use st_[cm]tim field for ns resolution file timestamp
  grep: cast printf %.*s "precision" argument explicitly to int
  read-tree A B C: do not create a bogus index and do not segfault
  Remove total confusion from git-fetch and git-push
  Update draft release notes to 1.6.3

Kjetil Barvik (17):
  lstat_cache(): small cleanup and optimisation
  lstat_cache(): generalise longest_match_lstat_cache()
  lstat_cache(): swap func(length, string) into func(string, length)
  unlink_entry(): introduce schedule_dir_for_removal()
  create_directories(): remove some memcpy() and strchr() calls
  write_entry(): cleanup of some duplicated code
  write_entry(): use fstat() instead of lstat() when file is open
  show_patch_diff(): remove a call to fstat()
  lstat_cache(): print a warning if doing ping-pong between cache types
  check_updates(): effective removal of cache entries marked CE_REMOVE
  fix compile error when USE_NSEC is defined
  make USE_NSEC work as expected
  verify_uptodate(): add ce_uptodate(ce) test
  write_index(): update index_state->timestamp after flushing to disk
  Record ns-timestamps if possible, but do not use it without USE_NSEC
  checkout bugfix: use stat.mtime instead of stat.ctime in two places
  Revert "lstat_cache(): print a warning if doing ping-pong between cac=
he
    types"

Michael J Gruber (1):
  git-branch.txt: document -f correctly

Miklos Vajna (1):
  Tests: use test_cmp instead of diff where possible

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  grep: prefer builtin over external one when coloring results

Petr Kodl (2):
  MinGW: a helper function that translates Win32 API error codes
  MinGW: a hardlink implementation

Ren=C3=A9 Scharfe (6):
  grep: micro-optimize hit collection for AND nodes
  grep: remove grep_opt argument from match_expr_eval()
  grep: add pmatch and eflags arguments to match_one_pattern()
  grep: color patterns in output
  grep: add support for coloring with external greps
  pickaxe: count regex matches only once

Stephen Boyd (1):
  git-send-email.txt: describe --compose better

Thomas Rast (2):
  send-email: respect in-reply-to regardless of threading
  send-email: test --no-thread --in-reply-to combination
