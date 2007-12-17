From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable frozen)
Date: Mon, 17 Dec 2007 00:40:06 -0800
Message-ID: <7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 09:40:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4BWp-0007T7-CI
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 09:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbXLQIkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 03:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbXLQIkX
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 03:40:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbXLQIkV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 03:40:21 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 03D951827;
	Mon, 17 Dec 2007 03:40:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 14E601826;
	Mon, 17 Dec 2007 03:40:13 -0500 (EST)
X-maint-at: 6281f394674bf2db861967da6c2215cfc3fc78af
X-master-at: 6fbe42c7ee99b4cafa792b46a16b0158d305fe29
In-Reply-To: <7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 12 Dec 2007 18:47:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68518>

Sorry for the "\No newline at the end" brown paper bag bug, which
happened soon after -rc0 but now fixed.  Thanks Jeff.

"git diff --check" was inconsistent with the highlighting of whitespace
problems and was harder to use from scripts (which makes it a usability
bug).  Both have been fixed.  Thanks Wincent.

A handful "gitweb" fixes I forgot to apply earlier are now in.  Thanks
Jakub.

A "git commit" regression has been noticed --- the post-commit summary
was inconsistent with what is shown by git-status before making the
commit.  Thanks Daniel.

A workaround for massive commit that exceeds command line limit when
issuing "cvs status list-of-files" has been added.  Thanks Jeff.

Hopefully the final round of clean-up until 1.5.4 in whitespace area ha=
s
been applied.  Thanks Wincent and Bruce.

I am reasonably happy that we are finding and fixing bugs.  Please keep
the fixes, including documentation updates, flowing in.

 * "git -p ls-tree HEAD" in a bare repository is still not fixed.

   http://thread.gmane.org/gmane.comp.version-control.git/68209?focus=3D=
68221
   http://thread.gmane.org/gmane.comp.version-control.git/68209?focus=3D=
68338

 * Hannes says "thread pack-objects" improvements needs a follow-up
   patch; it hasn't been applied here yet.

 * option parser regression fix really needs to be in by -rc1, but I
   just applied the initial round of Pierre's patches today.  See
   "What's cooking" for the list.

I need to coordinate with subsystem people and pull in changes for
gitk, git-gui, user manual and git-svn.

----------------------------------------------------------------
* The 'master' branch has these since the last announcement
  in addition to the above.

Andy Whitcroft (1):
  git-svn: expand handling of From: and Signed-off-by:

Christian Couder (1):
  git-help: add "help.format" config variable.

David S. Miller (1):
  fast-import: fix unalinged allocation and access

Eric Wong (2):
  git-svn: unlink internal index files after operations
  git-svn: handle our top-level path being deleted and later re-added

J. Bruce Fields (8):
  whitespace: fix off-by-one error in non-space-in-indent checking
  whitespace: reorganize initial-indent check
  whitespace: minor cleanup
  whitespace: fix initial-indent checking
  whitespace: more accurate initial-indent highlighting
  whitespace: fix config.txt description of indent-with-non-tab
  builtin-apply: minor cleanup of whitespace detection
  builtin-apply: stronger indent-with-on-tab fixing

Jakub Narebski (2):
  gitweb: disambiguate heads and tags withs the same name
  gitweb: Teach "a=3Dblob" action to be more lenient about blob/file mi=
me
    type

Jeff King (4):
  cvsexportcommit: fix massive commits
  trim_common_tail: brown paper bag fix.
  teach bash completion to treat commands with "--" as a helper
  rename git-browse--help to git-help--browse

Johannes Sixt (1):
  threaded pack-objects: Use condition variables for thread communicati=
on.

Junio C Hamano (15):
  git-commit: squelch needless message during an empty merge
  xdl_diff: identify call sites.
  xdi_diff: trim common trailing lines
  diff --check: minor fixups
  xdiff tail trimming: use correct type.
  commit: allow --amend to reuse message from another commit
  remote: Fix bogus make_branch() call in configuration reader.
  Rename git-browse-help helper to git-browse--help
  Retire git-runstatus for real.
  Start preparing the API documents.
  Update draft release notes for 1.5.4
  Re-re-re-fix common tail optimization
  builtin-commit: fix summary output.
  builtin-commit: make summary output consistent with status
  Documentation/git-submodule: refer to gitmodules(5)

Kristian H=C3=B8gsberg (1):
  Use a strbuf for building up section header and key/value pair string=
s.

Li Hong (1):
  Fix a memory leak

Mike Hommey (8):
  Fix some more memory leaks in http-push.c
  Fix random sha1 in error message in http-fetch and http-push
  Remove the default_headers variable from http-push.c
  Remove a CURLOPT_HTTPHEADER (un)setting
  Avoid redundant declaration of missing_target()
  Use strbuf in http code
  Fix various memory leaks in http-push.c and http-walker.c
  Move fetch_ref from http-push.c and http-walker.c to http.c

Nicolas Pitre (1):
  provide advance warning of some future pack default changes

Petr Baudis (1):
  gitweb: Make config_to_multi return [] instead of [undef]

Shawn Bohrer (1):
  Fix spelling mistakes in user manual

Wincent Colaiuta (6):
  "diff --check" should affect exit status
  Unify whitespace checking
  Make "diff --check" output match "git apply"
  Add tests for "git diff --check" with core.whitespace options
  Use shorter error messages for whitespace problems
  Test interaction between diff --check and --exit-code

anonymous (1):
  Documentation: describe pack idx v2
