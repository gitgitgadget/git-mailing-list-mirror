From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 0/3] Improve P4Merge mergetool invocation
Date: Sat,  9 Mar 2013 21:20:57 +0200
Message-ID: <1362856860-15205-1-git-send-email-kevin@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
Cc: Kevin Bracey <kevin@bracey.fi>, David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 21:39:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEQYO-0003xW-Ls
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 21:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab3CIUjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 15:39:06 -0500
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:60076 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751369Ab3CIUjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 15:39:05 -0500
X-Greylist: delayed 2399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Mar 2013 15:39:05 EST
Received: from mail173.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 0DD66FF9131
	for <git@vger.kernel.org>; Sat,  9 Mar 2013 20:32:41 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 9 Mar 2013 21:21:21 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 9 Mar 2013 21:21:19 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc3.7.g77aeedb
In-Reply-To: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 10065263693809357022
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -60
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeefucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedtmd
X-Spam-Check: DONE|U 0.500002/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -60
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeefucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217762>

Incorporated comments on the previous patches, and one new patch
addressing a problem I spotted while testing git-merge-one-file.

I couldn't figure out how to use git diff to achieve the effect of the
external diff here - we'd need some alternative to achieve what it does
with the -L option, and I failed to come up with anything remotely elegant.

Kevin Bracey (3):
  mergetools/p4merge: swap LOCAL and REMOTE
  mergetools/p4merge: create a base if none available
  git-merge-one-file: revise merge error reporting

 git-merge-one-file.sh | 38 ++++++++++++--------------------------
 git-sh-setup.sh       | 13 +++++++++++++
 mergetools/p4merge    |  8 ++++++--
 3 files changed, 31 insertions(+), 28 deletions(-)

-- 
1.8.2.rc3.7.g77aeedb
