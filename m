From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v3 0/6] git-p4 tests, filetypes, shell metacharacters
Date: Sun, 16 Oct 2011 10:42:15 -0400
Message-ID: <20111016144215.GC22144@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 16:42:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFRvC-00056m-Ej
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 16:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557Ab1JPOmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 10:42:33 -0400
Received: from honk.padd.com ([74.3.171.149]:35492 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab1JPOmd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 10:42:33 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 76E361FEA;
	Sun, 16 Oct 2011 07:42:31 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id DC2C8313B8; Sun, 16 Oct 2011 10:42:15 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183715>

This series of six patches has been reviewed on the mailing list
and should be ready for inclusion.  Changes from v2 to v3 are
shell style and compatibility issues helpfully pointed out by
Stefano.

1    - Clean up git-p4 tests, including Junio review comments

2..4 - Handle p4 filetypes better, including Chris's suggested
       utf16 fix

5    - Fix p4 keyword parsing

6    - From Luke: avoid using the shell, so filenames with metacharacters
       are not errantly expanded

Luke Diamand (1):
      git-p4: handle files with shell metacharacters

Pete Wyckoff (5):
      git-p4 tests: refactor and cleanup
      git-p4: handle utf16 filetype properly
      git-p4: recognize all p4 filetypes
      git-p4: stop ignoring apple filetype
      git-p4: keyword flattening fixes

 contrib/fast-import/git-p4     |  287 ++++++++++++++--------
 t/lib-git-p4.sh                |   74 ++++++
 t/t9800-git-p4.sh              |  544 +++++++++++++++++-----------------------
 t/t9801-git-p4-branch.sh       |  233 +++++++++++++++++
 t/t9802-git-p4-filetype.sh     |  108 ++++++++
 t/t9803-git-shell-metachars.sh |   64 +++++
 6 files changed, 903 insertions(+), 407 deletions(-)
 create mode 100644 t/lib-git-p4.sh
 create mode 100755 t/t9801-git-p4-branch.sh
 create mode 100755 t/t9802-git-p4-filetype.sh
 create mode 100755 t/t9803-git-shell-metachars.sh
