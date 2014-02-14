From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v5 0/9] add --gpg-sign to rebase and pull
Date: Fri, 14 Feb 2014 19:51:44 +0000
Message-ID: <1392407513-37443-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 20:52:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOoP-0003AC-PH
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbaBNTw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:52:27 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51928 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752800AbaBNTwA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Feb 2014 14:52:00 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7F00E2807A;
	Fri, 14 Feb 2014 19:51:57 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.rc3.1008.gd08b47c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242137>

This series was posted to the list some time back.  This is a re-send of
Nicolas Vigier's work with an additional patch that adds --gpg-sign to
pull as well, as well as the fixes that Junio suggested in review for
v3 and a typo noted in the v4 series.

There is also one additional merge call that was not previously given a
signature option that is now provided one as of v4.  I believe this was an
oversight, so I fixed it.

Nicolas Vigier (8):
  cherry-pick, revert: add the --gpg-sign option
  git-sh-setup.sh: add variable to use the stuck-long mode
  am: parse options in stuck-long mode
  am: add the --gpg-sign option
  rebase: remove useless arguments check
  rebase: don't try to match -M option
  rebase: parse options in stuck-long mode
  rebase: add the --gpg-sign option

brian m. carlson (1):
  pull: add the --gpg-sign option.

 Documentation/git-am.txt          |  6 +++-
 Documentation/git-cherry-pick.txt |  7 ++++-
 Documentation/git-rebase.txt      |  4 +++
 Documentation/git-revert.txt      |  6 +++-
 builtin/revert.c                  |  2 ++
 contrib/git-resurrect.sh          |  1 +
 git-am.sh                         | 26 ++++++++++------
 git-instaweb.sh                   |  1 +
 git-pull.sh                       | 13 +++++++-
 git-quiltimport.sh                |  1 +
 git-rebase--am.sh                 |  8 +++--
 git-rebase--interactive.sh        | 39 ++++++++++++++++--------
 git-rebase--merge.sh              |  2 +-
 git-rebase.sh                     | 62 +++++++++++++++++++++------------------
 git-request-pull.sh               |  1 +
 git-sh-setup.sh                   |  2 ++
 sequencer.c                       | 11 +++++++
 sequencer.h                       |  2 ++
 18 files changed, 135 insertions(+), 59 deletions(-)

-- 
1.9.0.rc3.1008.gd08b47c.dirty
