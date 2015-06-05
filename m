From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.4.3
Date: Fri, 05 Jun 2015 13:50:33 -0700
Message-ID: <xmqqiob1riau.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri Jun 05 22:50:47 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Z0yZg-000728-1H
	for glk-linux-kernel-3@plane.gmane.org; Fri, 05 Jun 2015 22:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbbFEUuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 5 Jun 2015 16:50:39 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37795 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbFEUuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jun 2015 16:50:35 -0400
Received: by igbsb11 with SMTP id sb11so23435962igb.0;
        Fri, 05 Jun 2015 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=MffJuGnPAaYvtTnFVw+Rbdgv2jeWZwdHLIor6Y3GbFs=;
        b=EApygIxMipKjpeekGWcLtCfsqjYChjAqDhCohIB/OURUXSt8mrO0mBYO43Hqes971J
         8+6eRaiEYzsJnpGJMzO/12iXOuHFoOx98L6mdIQtthZQwqIw5A3nl9wkaLUmSu4tIK+E
         tajUHIBSdMfR8JnaausPVVYw7Y6fOf/LNyeRbDtOR6PWIfYltlusrNs7MOl8wY3vyd+i
         r6rStQmymd3BI+/+GYsQFQaw6FPJLDWwsvqWxJRvCRCATjxm3l2qkgtiFHZFVvE1XTBL
         H2hYxaW5PlfFmoVFb+Mly7FyUYFfnj614Cz0J2FgWDv925s9373a+iv4x+tBiR9Lenec
         F2bQ==
X-Received: by 10.50.39.105 with SMTP id o9mr147164igk.39.1433537435215;
        Fri, 05 Jun 2015 13:50:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d0d:eed3:5800:fefa])
        by mx.google.com with ESMTPSA id ij7sm2043084igb.18.2015.06.05.13.50.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 13:50:34 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270893>

The latest maintenance release Git v2.4.3 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.4.3'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.4.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.4.3
------------------

 * Error messages from "git branch" called remote-tracking branches as
   "remote branches".

 * "git rerere forget" in a repository without rerere enabled gave a
   cryptic error message; it should be a silent no-op instead.

 * "git pull --log" and "git pull --no-log" worked as expected, but
   "git pull --log=3D20" did not.

 * The pull.ff configuration was supposed to override the merge.ff
   configuration, but it didn't.

 * The code to read pack-bitmap wanted to allocate a few hundred
   pointers to a structure, but by mistake allocated and leaked memory
   enough to hold that many actual structures.  Correct the allocation
   size and also have it on stack, as it is small enough.

 * Various documentation mark-up fixes to make the output more
   consistent in general and also make AsciiDoctor (an alternative
   formatter) happier.

 * "git bundle verify" did not diagnose extra parameters on the
   command line.

 * Multi-ref transaction support we merged a few releases ago
   unnecessarily kept many file descriptors open, risking to fail with
   resource exhaustion.

 * The ref API did not handle cases where 'refs/heads/xyzzy/frotz' is
   removed at the same time as 'refs/heads/xyzzy' is added (or vice
   versa) very well.

 * The "log --decorate" enhancement in Git 2.4 that shows the commit
   at the tip of the current branch e.g. "HEAD -> master", did not
   work with --decorate=3Dfull.

 * There was a commented-out (instead of being marked to expect
   failure) test that documented a breakage that was fixed since the
   test was written; turn it into a proper test.

 * core.excludesfile (defaulting to $XDG_HOME/git/ignore) is supposed
   to be overridden by repository-specific .git/info/exclude file, but
   the order was swapped from the beginning. This belatedly fixes it.

 * The connection initiation code for "ssh" transport tried to absorb
   differences between the stock "ssh" and Putty-supplied "plink" and
   its derivatives, but the logic to tell that we are using "plink"
   variants were too loose and falsely triggered when "plink" appeared
   anywhere in the path (e.g. "/home/me/bin/uplink/ssh").

 * "git rebase -i" moved the "current" command from "todo" to "done" a
   bit too prematurely, losing a step when a "pick" did not even start.

 * "git add -e" did not allow the user to abort the operation by
   killing the editor.

 * Git 2.4 broke setting verbosity and progress levels on "git clone"
   with native transports.

 * Some time ago, "git blame" (incorrectly) lost the convert_to_git()
   call when synthesizing a fake "tip" commit that represents the
   state in the working tree, which broke folks who record the history
   with LF line ending to make their project portabile across
   platforms while terminating lines in their working tree files with
   CRLF for their platform.

 * Code clean-up for xdg configuration path support.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.4.2 are as follows:

Danny Lin (1):
      branch: do not call a "remote-tracking branch" a "remote branch"

=46redrik Gustafsson (1):
      Documentation: clarify how "git commit" cleans up the edited log =
message

Jean-Noel Avila (1):
      doc: fix unmatched code fences

Jeff King (14):
      sha1_file: squelch "packfile cannot be accessed" warnings
      t/lib-httpd.sh: skip tests if NO_CURL is defined
      add: check return value of launch_editor
      doc: fix unmatched code fences in git-stripspace
      doc: fix misrendering due to `single quote'
      doc: fix unquoted use of "{type}"
      doc: fix hanging "+"-continuation
      doc: fix length of underlined section-title
      doc/add: reformat `--edit` option
      doc: convert \--option to --option
      doc: drop backslash quoting of some curly braces
      doc: put example URLs and emails inside literal backticks
      doc: convert AsciiDoc {?foo} to ifdef::foo[]
      rerere: exit silently on "forget" when rerere is disabled

Junio C Hamano (7):
      t0302: "unreadable" test needs POSIXPERM
      fmt-merge-msg: plug small leak of commit buffer
      ignore: info/exclude should trump core.excludesfile
      tests: skip dav http-push tests under NO_EXPAT=3DNoThanks
      log: decorate HEAD with branch name under --decorate=3Dfull, too
      log: do not shorten decoration names too early
      Git 2.4.3

Michael Haggerty (30):
      t1404: new tests of ref D/F conflicts within transactions
      is_refname_available(): revamp the comments
      is_refname_available(): avoid shadowing "dir" variable
      is_refname_available(): convert local variable "dirname" to strbu=
f
      entry_matches(): inline function
      report_refname_conflict(): inline function
      struct nonmatching_ref_data: store a refname instead of a ref_ent=
ry
      is_refname_available(): use dirname in first loop
      ref_transaction_commit(): use a string_list for detecting duplica=
tes
      refs: check for D/F conflicts among refs created in a transaction
      verify_refname_available(): rename function
      verify_refname_available(): report errors via a "struct strbuf *e=
rr"
      lock_ref_sha1_basic(): report errors via a "struct strbuf *err"
      lock_ref_sha1_basic(): improve diagnostics for ref D/F conflicts
      rename_ref(): integrate lock_ref_sha1_basic() errors into ours
      ref_transaction_commit(): provide better error messages
      ref_transaction_commit(): delete extra "the" from error message
      reflog_expire(): integrate lock_ref_sha1_basic() errors into ours
      write_ref_to_lockfile(): new function, extracted from write_ref_s=
ha1()
      commit_ref_update(): new function, extracted from write_ref_sha1(=
)
      rename_ref(): inline calls to write_ref_sha1() from this function
      ref_transaction_commit(): inline call to write_ref_sha1()
      ref_transaction_commit(): remove the local flags variable
      ref_transaction_commit(): fix atomicity and avoid fd exhaustion
      write_ref_to_lockfile(): new function, extracted from write_ref_s=
ha1()
      commit_ref_update(): new function, extracted from write_ref_sha1(=
)
      rename_ref(): inline calls to write_ref_sha1() from this function
      ref_transaction_commit(): inline call to write_ref_sha1()
      ref_transaction_commit(): remove the local flags variable
      ref_transaction_commit(): fix atomicity and avoid fd exhaustion

Mike Hommey (1):
      clone: call transport_set_verbosity before anything else on the n=
ewly created transport

Patrick Steinhardt (5):
      bundle: verify arguments more strictly
      git-verify-pack.txt: fix inconsistent spelling of "packfile"
      git-unpack-objects.txt: fix inconsistent spelling of "packfile"
      pack-protocol.txt: fix insconsistent spelling of "packfile"
      doc: fix inconsistent spelling of "packfile"

Paul Tan (13):
      git-credential-store: support multiple credential files
      git-credential-store: support XDG_CONFIG_HOME
      t0302: test credential-store support for XDG_CONFIG_HOME
      path.c: implement xdg_config_home()
      attr.c: replace home_config_paths() with xdg_config_home()
      dir.c: replace home_config_paths() with xdg_config_home()
      credential-store.c: replace home_config_paths() with xdg_config_h=
ome()
      git-commit: replace use of home_config_paths()
      git-config: replace use of home_config_paths()
      path.c: remove home_config_paths()
      pull: handle --log=3D<n>
      pull: make pull.ff=3Dtrue override merge.ff
      pull: parse pull.ff as a bool or string

Phil Hord (1):
      rebase -i: redo tasks that die during cherry-pick

Ren=C3=A9 Scharfe (1):
      pack-bitmaps: plug memory leak, fix allocation size for recent_bi=
tmaps

Stefan Beller (5):
      update-ref: test handling large transactions properly
      t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
      update-ref: test handling large transactions properly
      t7004: rename ULIMIT test prerequisite to ULIMIT_STACK_SIZE
      subdirectory tests: code cleanup, uncomment test

Torsten B=C3=B6gershausen (1):
      blame: CRLF in the working tree and LF in the repo

brian m. carlson (3):
      connect: simplify SSH connection code path
      t5601: fix quotation error leading to skipped tests
      connect: improve check for plink to reduce false positives
