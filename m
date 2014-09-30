From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.1.2
Date: Tue, 30 Sep 2014 13:22:59 -0700
Message-ID: <xmqq4mvosvrw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Sep 30 22:23:22 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1XZ3x8-0000T0-S0
	for glk-linux-kernel-3@plane.gmane.org; Tue, 30 Sep 2014 22:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbaI3UXF (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 30 Sep 2014 16:23:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51938 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbaI3UXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2014 16:23:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F66F3FE95;
	Tue, 30 Sep 2014 16:23:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	p07ayM0YsXkdgxeME6ZwEgtC4w=; b=XtLKRyOkX7NuJSrBujZHVLUbujPRRfL1a
	ZYKsT72xbJFfWhcPkqdmaaECaDmEpDYteI6m5mP2vGlYC4obH7vBgBew45CfN/sr
	Pb+00FwXu8O+dOeJu2irZXSq/e7id9zNbdpJJQPygf0PJcuhgrbzJ6IeyW5g5J7l
	oNlQBUado4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=IHIGIHcQ676wcksz1qEnojZm+nd2zokjsfsefyEBnIXI1x0HDnOFjBRT
	eCJbv7EAbVqQ2UfFa+UKKol1QLNWyERz6V4raFP3KsPHjvYc37UG6y80xK3+GiYI
	DVhwcnU4MuGhPEIL60VM9U00kSV2Hydo2Nr79VwIHH6oP9U+/uc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 762423FE94;
	Tue, 30 Sep 2014 16:23:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E04873FE91;
	Tue, 30 Sep 2014 16:23:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 939B3F1A-48DF-11E4-B6FB-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257679>

The latest maintenance release Git v2.1.2 is now available at the
usual places.  With this, v2.1.x has all the important fixes that
have been already applied to the 'master' front for the next feature
release.  It also contains some updates to German translation.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.1.2'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v2.1.2 Release Notes
========================

 * "git push" over HTTP transport had an artificial limit on number of
   refs that can be pushed imposed by the command line length.

 * When receiving an invalid pack stream that records the same object
   twice, multiple threads got confused due to a race.

 * An attempt to remove the entire tree in the "git fast-import" input
   stream caused it to misbehave.

 * Reachability check (used in "git prune" and friends) did not add a
   detached HEAD as a starting point to traverse objects still in use.

 * "git config --add section.var val" used to lose existing
   section.var whose value was an empty string.

 * "git fsck" failed to report that it found corrupt objects via its
   exit status in some cases.

----------------------------------------------------------------

Changes since v2.1.1 are as follows:

Jeff King (5):
      send-pack: take refspecs over stdin
      index-pack: fix race condition with duplicate bases
      fsck: exit with non-zero status upon error from fsck_obj()
      config: avoid a funny sentinel value "a^"
      fsck: return non-zero status on missing ref tips

Junio C Hamano (1):
      Git 2.1.2

Max Kirillov (1):
      reachable.c: add HEAD to reachability starting commits

Maxim Bublis (2):
      t9300: test filedelete command
      fast-import: fix segfault in store_tree()

Phillip Sz (2):
      l10n: de.po: change Email to E-Mail
      l10n: de.po: use comma before "um"

Ralf Thielow (1):
      po/TEAMS: add new member to German translation team

Sergey Organov (2):
      Documentation/git-rebase.txt: -f forces a rebase that would otherwise be a no-op
      Documentation/git-rebase.txt: <upstream> must be given to specify <branch>

Tanay Abhra (1):
      make config --add behave correctly for empty and NULL values
