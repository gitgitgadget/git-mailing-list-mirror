From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/4] git-p4: paths for p4
Date: Fri,  9 Dec 2011 18:48:13 -0500
Message-ID: <1323474497-14339-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 00:48:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZAB1-0006nf-8r
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab1LIXsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:48:22 -0500
Received: from honk.padd.com ([74.3.171.149]:43989 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209Ab1LIXsW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:48:22 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 6B65FEE;
	Fri,  9 Dec 2011 15:48:21 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 06715313BB; Fri,  9 Dec 2011 18:48:17 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.4.gc2b11.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186705>

There are two problems associated with how we set up paths for
use by p4, fixed in this series.  Each fix is accompanied by
another patch that is the unit test.

There is a break in the sequence in the t98* patches here, but
that is on purpose to avoid collision with new tests from other
in-flight patches.

1-2:
    in submit, create clientPath if it does not exist

3-4:
    in clone, make sure p4 sees an absolute path

Gary Gibbons (2):
  git-p4: ensure submit clientPath exists before chdir
  git-p4: use absolute directory for PWD env var

Pete Wyckoff (2):
  git-p4: submit test for auto-creating clientPath
  git-p4: test for absolute PWD problem

 contrib/fast-import/git-p4 |    9 ++++++-
 t/t9807-submit.sh          |   38 ++++++++++++++++++++++++++++++++++
 t/t9808-chdir.sh           |   49 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 2 deletions(-)
 create mode 100755 t/t9807-submit.sh
 create mode 100755 t/t9808-chdir.sh

-- 
1.7.8.rc4.42.g8317d
