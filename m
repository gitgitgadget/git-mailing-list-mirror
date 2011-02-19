From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 0/8] git-p4 fixes and enhancements
Date: Sat, 19 Feb 2011 08:17:53 -0500
Message-ID: <1298121481-7005-1-git-send-email-pw@padd.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 14:18:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqmhp-0001Jr-WB
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab1BSNSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:18:36 -0500
Received: from honk.padd.com ([74.3.171.149]:51182 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753904Ab1BSNSS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:18:18 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id F0F7A20AB;
	Sat, 19 Feb 2011 05:18:15 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E11DF319B2; Sat, 19 Feb 2011 08:18:06 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167277>

This is the second submission of git-p4 fixes and enhancements.
The first of these 8 patches adds a test script.  The rest
fix problems with git-p4 and add small featurest-p4: test script

	git-p4: fix key error for p4 problem
	git-p4: add missing newline in initial import message
	git-p4: accommodate new move/delete type in p4
	git-p4: reinterpret confusing p4 message
	git-p4: better message for "git-p4 sync" when not cloned
	git-p4: decode p4 wildcard characters
	git-p4: support clone --bare

 contrib/fast-import/git-p4 |   60 ++++++++++++++++++++++-----
 t/t9800-git-p4.sh          |  100 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+), 11 deletions(-)

Changes from v1.

    Includes acks from Tor Arvid for 3, 4, 6, 8.
    Includes review changes from Junio on 1, and from Tor Arvid
    on 7.

1/8: test script

    Review comments from Junio.

    1.  Beautify icky p4 and p4d existence check.

    2.  Remove p4d initialization sleep.  It binds and listens
	to the port nicely before daemonizing.


7/8: decode p4 wildcard characters

    Tor Arvid points out that windows cannot have * in filenames.
    This is not something I can test, but at least avoid the situation
    on that platform.
