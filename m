From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.3.2
Date: Fri, 28 Jun 2013 15:28:01 -0700
Message-ID: <7vzju9lvke.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Jun 29 00:28:22 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Ush9S-0007n7-3L
	for glk-linux-kernel-3@plane.gmane.org; Sat, 29 Jun 2013 00:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab3F1W2H (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 28 Jun 2013 18:28:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63307 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab3F1W2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jun 2013 18:28:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 285CF2C242;
	Fri, 28 Jun 2013 22:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=y
	sApwbvzl7dEaD0LfGF2QzXao5c=; b=asSEL1FC/xmRF6qJW0GpSDRTkdK58Iu4q
	q75e0RhUm6IbxdUxHAYcLsZA7M2S74H+0T7F3bCfWPLsyZja3BCmzlwL8Q9QUkYO
	GjoK9pK212lXOpOJ5XqDc+gVpdUMvbgWLTL41gvKTEIimY2SWK2IvLPkst9Iwya8
	NutOXaJP+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=aVrzK9HePLWjbal5ojG3OVLEQDw9aPZDtysdRdrp7yNUVrLHKGxj3Hzu
	IQ3LpdIuJTrJo+r4XDYbogkbnO4H7b7FFrg5FpkyRbMqTAWkm1p8R3G6Z4EiYlYr
	/Uv5vY1uhB6K0TPq33x1dvTR1qNlWDl9qpF+H1xiIxg2NwUejac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C7362C241;
	Fri, 28 Jun 2013 22:28:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B1302C240;
	Fri, 28 Jun 2013 22:28:03 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF36DD0E-E041-11E2-8824-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229245>

The latest maintenance release Git v1.8.3.2 is now available at the
usual places.  It contains fixes that have already been applied to
the 'master' branch for 1.8.4.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

4a6585dd81a542e7803e5f54a5c85b1c1a5869aa  git-1.8.3.2.tar.gz
adffaa379e1994fc6d6cb6491aed680ad6bb37ad  git-htmldocs-1.8.3.2.tar.gz
5ce8c00fe9e2755c67d29b2f2135fc8c4202fc1f  git-manpages-1.8.3.2.tar.gz

The following public repositories all have a copy of the v1.8.3.2
tag and the maint branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs.

Git v1.8.3.2 Release Notes
==========================

Fixes since v1.8.3.1
--------------------

 * Cloning with "git clone --depth N" while fetch.fsckobjects (or
   transfer.fsckobjects) is set to true did not tell the cut-off
   points of the shallow history to the process that validates the
   objects and the history received, causing the validation to fail.

 * "git checkout foo" DWIMs the intended "upstream" and turns it into
   "git checkout -t -b foo remotes/origin/foo". This codepath has been
   updated to correctly take existing remote definitions into account.

 * "git fetch" into a shallow repository from a repository that does
   not know about the shallow boundary commits (e.g. a different fork
   from the repository the current shallow repository was cloned from)
   did not work correctly.

 * "git subtree" (in contrib/) had one codepath with loose error
   checks to lose data at the remote side.

 * "git log --ancestry-path A...B" did not work as expected, as it did
   not pay attention to the fact that the merge base between A and B
   was the bottom of the range being specified.

 * "git diff -c -p" was not showing a deleted line from a hunk when
   another hunk immediately begins where the earlier one ends.

 * "git merge @{-1}~22" was rewritten to "git merge frotz@{1}~22"
   incorrectly when your previous branch was "frotz" (it should be
   rewritten to "git merge frotz~22" instead).

 * "git commit --allow-empty-message -m ''" should not start an
   editor.

 * "git push --[no-]verify" was not documented.

 * An entry for "file://" scheme in the enumeration of URL types Git
   can take in the HTML documentation was made into a clickable link
   by mistake.

 * zsh prompt script that borrowed from bash prompt script did not
   work due to slight differences in array variable notation between
   these two shells.

 * The bash prompt code (in contrib/) displayed the name of the branch
   being rebased when "rebase -i/-m/-p" modes are in use, but not the
   plain vanilla "rebase".

 * "git push $there HEAD:branch" did not resolve HEAD early enough, so
   it was easy to flip it around while push is still going on and push
   out a branch that the user did not originally intended when the
   command was started.

 * "difftool --dir-diff" did not copy back changes made by the
   end-user in the diff tool backend to the working tree in some
   cases.
