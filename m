From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sat, 03 Nov 2007 20:52:52 -0700
Message-ID: <7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 04:57:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoWcO-0003FU-Sx
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 04:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757103AbXKDDxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 23:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbXKDDxF
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 23:53:05 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:54199 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660AbXKDDxD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Nov 2007 23:53:03 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B2A112EF;
	Sat,  3 Nov 2007 23:53:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E759191FF2;
	Sat,  3 Nov 2007 23:53:21 -0400 (EDT)
X-maint-at: f45e867b1a60a2023c18719888bb52965ade7192
X-master-at: e3d6d56f1c2097f13a427e158638e5e0918e5705
In-Reply-To: <7vodeecyni.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 31 Oct 2007 22:39:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63340>

* The 'maint' branch has these fixes since the last announcement.

Brad King (1):
  cvsexportcommit: fix for commits that do not have parents

Jakub Narebski (1):
  gitweb: Update config file example for snapshot feature in
      gitweb/INSTALL

Jonas Fonseca (1):
  Remove escaping of '|' in manpage option sections

Jonathan del Strother (1):
  Fixing path quoting in git-rebase

Kristian H=C3=B8gsberg (1):
  Remove unecessary hard-coding of EDITOR=3D':' VISUAL=3D':' in some te=
st
      suites.

Ralf Wildenhues (1):
  git-clone.txt: Improve --depth description.

Sergei Organov (3):
  git-filter-branch.txt: fix a typo.
  git-format-patch.txt: fix explanation of an example.
  Documentation: quote commit messages consistently.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.  Notable topics are:

  - fork-exec removal from MinGW work.
  - the first batch of parse-options.
  - terse progress display.

Short log follows.

Alex Riesen (2):
  Rework make_usage to print the usage message immediately
  Do no colorify test output if stdout is not a terminal

Blake Ramsdell (1):
  transport.c: squelch a gcc 4.0.1 complaint about an uninitialized
      variable

Emil Medve (1):
  Fixed a command line option type for builtin-fsck.c

Gerrit Pape (1):
  git-diff.txt: add section "output format" describing the diff
      formats

James Bowes (1):
  gc: use parse_options

Johannes Schindelin (2):
  Add tests for parse-options.c
  parse-options: Allow abbreviated options when unambiguous

Johannes Sixt (14):
  Change git_connect() to return a struct child_process instead of a
      pid_t.
  Use start_command() in git_connect() instead of explicit fork/exec.
  Use start_command() to run content filters instead of explicit
      fork/exec.
  Use run_command() to spawn external diff programs instead of
      fork/exec.
  Use start_comand() in builtin-fetch-pack.c instead of explicit
      fork/exec.
  Have start_command() create a pipe to read the stderr of the child.
  upload-pack: Use start_command() to run pack-objects in
      create_pack_file().
  Add infrastructure to run a function asynchronously.
  Use the asyncronous function infrastructure in
      builtin-fetch-pack.c.
  upload-pack: Move the revision walker into a separate function.
  upload-pack: Run rev-list in an asynchronous function.
  t0021-conversion.sh: Test that the clean filter really cleans
      content.
  Avoid a dup2(2) in apply_filter() - start_command() can do it for
      us.
  Use the asyncronous function infrastructure to run the content
      filter.

Jonas Fonseca (1):
  Update manpages to reflect new short and long option aliases

Kristian H=C3=B8gsberg (5):
  Enable wt-status output to a given FILE pointer.
  Enable wt-status to run against non-standard index file.
  Introduce entry point add_interactive and add_files_to_cache
  Export rerere() and launch_editor().
  Port builtin-add.c to use the new option parser.

Nicolas Pitre (16):
  more compact progress display
  cope with multiple line breaks within sideband progress messages
  pack-objects: no delta possible with only one object in the list
  pack-objects.c: fix some global variable abuse and memory leaks
  fix const issues with some functions
  fix for more minor memory leaks
  prune-packed: don't call display_progress() for every file
  make struct progress an opaque type
  relax usage of the progress API
  add throughput to progress display
  add throughput display to index-pack
  add some copyright notice to the progress display code
  add throughput display to git-push
  return the prune-packed progress display to the inner loop
  make sure throughput display gets updated even if progress doesn't
      move
  Show total transferred as part of throughput progress

Pierre Habouzit (17):
  Add a simple option parser.
  parse-options: be able to generate usages automatically
  parse-options: make some arguments optional, add callbacks.
  Add shortcuts for very often used options.
  parse-options: allow callbacks to take no arguments at all.
  Make builtin-rm.c use parse_options.
  Make builtin-mv.c use parse-options
  Make builtin-branch.c use parse_options.
  Make builtin-describe.c use parse_options
  Make builtin-revert.c use parse_options.
  Make builtin-update-ref.c use parse_options
  Make builtin-symbolic-ref.c use parse_options.
  Make builtin-for-each-ref.c use parse-opts.
  Make builtin-fsck.c use parse_options.
  Make builtin-count-objects.c use parse_options.
  Make builtin-name-rev.c use parse_options.
  Make builtin-pack-refs.c use parse_options.

Scott R Parish (7):
  "git" returns 1; "git help" and "git help -a" return 0
  remove unused/unneeded "pattern" argument of list_commands
  "current_exec_path" is a misleading name, use "argv_exec_path"
  list_commands(): simplify code by using chdir()
  use only the $PATH for exec'ing git commands
  include $PATH in generating list of commands for "help -a"
  shell should call the new setup_path() to setup $PATH

Shawn O. Pearce (3):
  Change 'Deltifying objects' to 'Compressing objects'
  Teach prune-packed to use the standard progress meter
  Stop displaying "Pack pack-$ID created." during git-gc

Steffen Prohaska (3):
  mergetool: use path to mergetool in config var
      mergetool.<tool>.path
  mergetool: add support for ECMerge
  mergetool: avoid misleading message "Resetting to default..."
