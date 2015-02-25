From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.3.1
Date: Tue, 24 Feb 2015 23:02:26 -0800
Message-ID: <xmqqzj82o4n1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 25 08:02:37 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YQVzQ-0004ym-3N
	for glk-linux-kernel-3@plane.gmane.org; Wed, 25 Feb 2015 08:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbbBYHCb (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 25 Feb 2015 02:02:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751068AbbBYHC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2015 02:02:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46DDF36F79;
	Wed, 25 Feb 2015 02:02:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=8
	cpcjYD9RCgjViojv8ag3c2qZ4U=; b=WKrsQQUsDGiaBDfLW/KT7OC1ZIxrnxChC
	xlbo3CYiptnSH6Bbtf/cNMCa7MMdVOZi9DyZxgHTcpfxTplD7LphkP+zpNA9mJwZ
	IZt2MktP9Qg7p5JjpxYYa2FYCzIS4yH7zNJnom4w8kX66CdmZsHVdvbaTeikTKSY
	hdFht5/zhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=cOJ7yiAl86TYENz9n24iWMDL0uHx/gCYxs4nBzPQz6kElUoYFsvYbHw9
	fsuNTBx9dv2oD0dceNb17lVGrHvnEpxQl6qbhlEx5H8yWG6gTtr7am2VEuZBCpPr
	Qr2+NEmz7olvEMJ5ZjwmZ4jWhd+BE/Rq202E30FfAwytFmNg/MI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D4EB36F78;
	Wed, 25 Feb 2015 02:02:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF66436F75;
	Wed, 25 Feb 2015 02:02:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 42213BB6-BCBC-11E4-8402-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264368>

The latest maintenance release Git v2.3.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.3.1'
tag and the 'maint' branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v2.3.1 Release Notes
========================

Fixes since v2.3
----------------

 * The interactive "show a list and let the user choose from it"
   interface "add -i" used showed and prompted to the user even when
   the candidate list was empty, against which the only "choice" the
   user could have made was to choose nothing.

 * "git apply --whitespace=fix" used to under-allocate the memory
   when the fix resulted in a longer text than the original patch.

 * "git log --help" used to show rev-list options that are irrelevant
   to the "log" command.

 * The error message from "git commit", when a non-existing author
   name was given as value to the "--author=" parameter, has been
   reworded to avoid misunderstanding.

 * A broken pack .idx file in the receiving repository prevented the
   dumb http transport from fetching a good copy of it from the other
   side.

 * The documentation incorrectly said that C(opy) and R(ename) are the
   only ones that can be followed by the score number in the output in
   the --raw format.

 * Fix a misspelled conditional that is always true.

 * Code to read branch name from various files in .git/ directory
   would have misbehaved if the code to write them left an empty file.

 * The "git push" documentation made the "--repo=<there>" option
   easily misunderstood.

 * After attempting and failing a password-less authentication
   (e.g. kerberos), libcURL refuses to fall back to password based
   Basic authentication without a bit of help/encouragement.

 * Setting diff.submodule to 'log' made "git format-patch" produce
   broken patches.

 * "git rerere" (invoked internally from many mergy operations) did
   not correctly signal errors when told to update the working tree
   files and failed to do so for whatever reason.

 * "git blame HEAD -- missing" failed to correctly say "HEAD" when it
   tried to say "No such path 'missing' in HEAD".

Also contains typofixes, documentation updates and trivial code clean-ups.

----------------------------------------------------------------

Changes since v2.3.0 are as follows:

Alexander Kuleshov (1):
      add -i: return from list_and_choose if there is no candidate

Doug Kelly (2):
      t4255: test am submodule with diff.submodule
      format-patch: ignore diff.submodule setting

Jeff King (7):
      git-compat-util: add xstrdup_or_null helper
      builtin/apply.c: use xstrdup_or_null instead of null_strdup
      builtin/commit.c: use xstrdup_or_null instead of envdup
      use xstrdup_or_null to replace ternary conditionals
      dumb-http: do not pass NULL path to parse_pack_index
      read_and_strip_branch: fix typo'd address-of operator
      do not check truth value of flex arrays

Jonathan Nieder (1):
      rerere: error out on autoupdate failure

Junio C Hamano (6):
      apply.c: typofix
      apply: make update_pre_post_images() sanity check the given postlen
      apply: count the size of postimage correctly
      Documentation: what does "git log --indexed-objects" even mean?
      diff-format doc: a score can follow M for rewrite
      Git 2.3.1

Lukas Fleischer (1):
      blame.c: fix garbled error message

Michael J Gruber (2):
      commit: reword --author error message
      git-push.txt: document the behavior of --repo

brian m. carlson (1):
      remote-curl: fall back to Basic auth if Negotiate fails
