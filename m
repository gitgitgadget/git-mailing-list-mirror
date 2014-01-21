From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 00/11] git p4 tests and a few bug fixes
Date: Tue, 21 Jan 2014 18:16:37 -0500
Message-ID: <1390346208-9207-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 00:16:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kYy-0001Hh-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbaAUXQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jan 2014 18:16:52 -0500
Received: from honk.padd.com ([74.3.171.149]:46529 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbaAUXQw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:16:52 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 5B8F87112;
	Tue, 21 Jan 2014 15:16:51 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 729C6200F7; Tue, 21 Jan 2014 18:16:48 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240790>

Most of this is work on tests for git p4.

Patch 03 is a regression fix, found and narrowed down thanks to
much work by Damien G=C3=A9rard.  But it is obscure enough that I'm
not proposing it for a maintenance release.

There are a couple other behavior fixes, but again, these
are quite minor and can wait for the next release.

Pete Wyckoff (11):
  git p4 test: wildcards are supported
  git p4 test: ensure p4 symlink parsing works
  git p4: work around p4 bug that causes empty symlinks
  git p4 test: explicitly check p4 wildcard delete
  git p4 test: is_cli_file_writeable succeeds
  git p4 test: run as user "author"
  git p4 test: do not pollute /tmp
  git p4: handle files with wildcards when doing RCS scrubbing
  git p4: fix an error message when "p4 where" fails
  git p4 test: examine behavior with locked (+l) files
  git p4 doc: use two-line style for options with multiple spellings

 Documentation/git-p4.txt           |   6 +-
 git-p4.py                          |  17 +++--
 t/lib-git-p4.sh                    |  23 +++++-
 t/t9802-git-p4-filetype.sh         |  83 +++++++++++++++++++++
 t/t9805-git-p4-skip-submit-edit.sh |   6 +-
 t/t9807-git-p4-submit.sh           |   2 +-
 t/t9809-git-p4-client-view.sh      |  16 ++--
 t/t9812-git-p4-wildcards.sh        |  50 +++++++++++++
 t/t9813-git-p4-preserve-users.sh   |  38 ++++------
 t/t9816-git-p4-locked.sh           | 145 +++++++++++++++++++++++++++++=
++++++++
 10 files changed, 342 insertions(+), 44 deletions(-)
 create mode 100755 t/t9816-git-p4-locked.sh

--=20
1.8.5.2.320.g99957e5
