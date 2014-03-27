From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] Documentation/submodule: Fix submodule.<name> -> .<path> typos
Date: Thu, 27 Mar 2014 14:06:20 -0700
Message-ID: <f86f6b48f1c840d50d00c591a296821e0a18ee0d.1395954229.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 22:09:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTHYL-0001tW-69
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 22:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681AbaC0VIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 17:08:51 -0400
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:56096
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755086AbaC0VIu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 17:08:50 -0400
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id ikUU1n0050EZKEL5El8pqo; Thu, 27 Mar 2014 21:08:49 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id il8o1n002152l3L3Ml8oZW; Thu, 27 Mar 2014 21:08:49 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.140])
	by odin.tremily.us (Postfix) with ESMTPS id 872A110DDBF1;
	Thu, 27 Mar 2014 14:08:47 -0700 (PDT)
Received: (nullmailer pid 28400 invoked by uid 1000);
	Thu, 27 Mar 2014 21:06:28 -0000
X-Mailer: git-send-email 1.9.1.352.gd393d14.dirty
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1395954529;
	bh=IFQ5OBmMb6Asl6P9yB1lVRIqUBywOb+lbNrOV03eVU8=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=r4iyf6ffPV5FVn1xNkt01h4hyz6gbRkgGxulv0QfZl3rWn3tnvrc+wE9MPO+cwRBZ
	 iq566OS8dI6MyWlnTwbq5S/T+ceerWqILY9CqrkE0/1X19tC+Rc24luZDWuZPmR8Jw
	 OKOCHQBDbOko2u5AI627HjG+YbelkDsbJJ61FK9vZSUaAkhqNuFzZ8d907i+OKAbTG
	 +FDG3RbplSnEgdRH7XFw3bE3PRdOEwZlXMLGgsQwjLsmq+ViCDGgKalIfh3VN/lnN6
	 dsu1HXpU/YJmgDaCVfjCTUQYpewntWpWVdRC7/Ku/Bhw+jjtiFcLanYr/T3Qz+ObaW
	 eNYXF7YJjgYEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245327>

The transition from submodule.<path>.* to submodule.<name>.* happened
in 73b0898d (Teach "git submodule add" the --name option, 2012-09-30),
which landed in v1.8.1-rc0 on 2012-12-03.  The first
submodule.<path>.branch reference landed a short time later in
b9289227 (submodule add: If --branch is given, record it in
.gitmodules, 2012-12-19), and I was probably just not aware of
73b0898d.  The second submodule.<path>.branch reference landed in
23d25e48 (submodule: explicit local branch creation in module_clone,
2014-01-26), and is just a copy paste error.  This commit updates both
references to the current submodule.<name>.branch.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: W. Trevor King <wking@tremily.us>
---
This patch is against master, because 23d25e48 hasn't landed in maint
yet.  If you want, I can split this into two patches, one against
maint fixing the b9289227 typo and another against master fixing the
23d25e48 typo.

 Documentation/git-submodule.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 46c1eeb..77588b0 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -162,7 +162,7 @@ update::
 +
 For updates that clone missing submodules, checkout-mode updates will
 create submodules with detached HEADs; all other modes will create
-submodules with a local branch named after `submodule.<path>.branch`.
+submodules with a local branch named after `submodule.<name>.branch`.
 +
 For updates that do not clone missing submodules, the submodule's HEAD
 is only touched when the remote reference does not match the
@@ -247,7 +247,7 @@ OPTIONS
 -b::
 --branch::
 	Branch of repository to add as submodule.
-	The name of the branch is recorded as `submodule.<path>.branch` in
+	The name of the branch is recorded as `submodule.<name>.branch` in
 	`.gitmodules` for `update --remote`.
 
 -f::
-- 
1.9.1.352.gd393d14.dirty
