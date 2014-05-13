From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] Documentation: mention config sources for @{upstream}
Date: Tue, 13 May 2014 11:46:57 -0700
Message-ID: <a1a8ae41b7969f1f8a2b5a42fe7d63eadb15ef4a.1400006756.git.wking@tremily.us>
Cc: "W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 13 20:47:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkHjt-0003fa-Qi
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 20:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbaEMSrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 14:47:41 -0400
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:53982
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753192AbaEMSrk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 14:47:40 -0400
Received: from omta16.westchester.pa.mail.comcast.net ([76.96.62.88])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id 1T1U1o0071uE5Es5AWnfH3; Tue, 13 May 2014 18:47:39 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta16.westchester.pa.mail.comcast.net with comcast
	id 1Wne1o00B152l3L3cWneni; Tue, 13 May 2014 18:47:39 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.140])
	by odin.tremily.us (Postfix) with ESMTPS id 76BFC11B4B20;
	Tue, 13 May 2014 11:47:37 -0700 (PDT)
Received: (nullmailer pid 15706 invoked by uid 1000);
	Tue, 13 May 2014 18:47:00 -0000
X-Mailer: git-send-email 1.9.1.353.gc66d89d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1400006859;
	bh=nTgZpAftjPupwJpkeYhWRrO5HIOLaSrpu/GvhxwoS68=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=uLN7HF4hkyo+rNkPDjcqKJnOYjRR2nHOoEQtgCTkD7M5v9mxMuOG/CHaLEOD8YUjm
	 wLqgavY6eoOpyWOqqwvM5t7LWkwck3oABHlRObluf16bVB0I/FykWB1AZxCasZTAbu
	 PL6g4jBxZ1Nt5r8/cfGaw2pTFr0vOUQEVoi/2R8cKyZsM+NffBo+gbRB1+lwPdga0w
	 Y1rlbHvM24pPj8xwY9ed2PUYm7ws/lhVOaYjritAPxMXng9pL/pUuAbAwnpzZM4sxx
	 jG8yr7Vcg6Ze2OLWmTOoD8r4CCcJWmNgZ7lYtK0KUX7pWp5hv33CK8152UEKjkmNeB
	 dv+jFBoxr09Tw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248802>

The earlier documentation made vague references to "is set to build
on".  Flesh that out with references to the config settings, so folks
can use git-config(1) to get more detail on what @{upstream} means.
For example, @{upstream} does not care about remote.pushdefault or
branch.<name>.pushremote.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/revisions.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 5a286d0..0796118 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -94,7 +94,9 @@ some output processing may assume ref names in UTF-8.
 '<branchname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
   The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
   refers to the branch that the branch specified by branchname is set to build on
-  top of.  A missing branchname defaults to the current one.
+  top of (configured with `branch.<name>.remote` and
+  `branch.<name>.merge`).  A missing branchname defaults to the
+  current one.
 
 '<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
-- 
1.9.1.353.gc66d89d
