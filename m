From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/5] test-lib: filesystem prerequisites
Date: Thu, 26 Jul 2012 15:39:52 +0200
Message-ID: <cover.1343309173.git.git@drmicha.warpmail.net>
References: <5001B82B.1060201@web.de>
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 15:40:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuOIT-0004BS-LI
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 15:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735Ab2GZNkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 09:40:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59457 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751049Ab2GZNkA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2012 09:40:00 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 90D8420B90;
	Thu, 26 Jul 2012 09:39:59 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 26 Jul 2012 09:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=CB4uTsOhh9k1Ar2j+U2lhU249
	pI=; b=BowPzQm6Cm5CWzQIKiV3Qo+LilDWyUcIlX0LuUzlG8Jb0PZi/Bhyb+4yA
	cLDstLdqUc63PzECXIQ94kpIDQ7HYZmDsn342dGQlkNkXRedtpscLKYdk2pA67+y
	HI4eQ2DrL9nT+/1/pm6+bWGTgGa74HPOT4qgNhc3pfvHmQOl3s=
X-Sasl-enc: CTeFXfyZyW3XmjOmKNi4GZU4rdBLA19ph5Booo+7ip0t 1343309999
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2A7CE8E011D;
	Thu, 26 Jul 2012 09:39:59 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc0.198.gd66b616
In-Reply-To: <5001B82B.1060201@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202263>

This mini series provides and makes use of test prerequisites for
case insensitivity, symlinks and unicode conversion.

SYMLINKS existed before but was not used in t0050.
CASE_INSENSITIVE_FS was defined in t0003 rather than test-lib (and redone in
t0050).
UTF8_NFD_TO_NFC did not exist but was redone in two ways in two tests.

After this series, all 3 are defined in test-lib and used in the various tests.

Michael J Gruber (5):
  test-lib: provide case insensitivity as a prerequisite
  t0050: use the CASE_INSENSITIVE_FS test prereq
  t0050: use the SYMLINKS test prereq
  test-lib: provide UTF8 behaviour as a prerequisite
  t3910: use the SYMLINKS test prereq

 t/README                     |   9 ++
 t/t0003-attributes.sh        |  10 --
 t/t0050-filesystem.sh        |  64 ++++------
 t/t3910-mac-os-precompose.sh | 281 +++++++++++++++++++++----------------------
 t/test-lib.sh                |  24 ++++
 5 files changed, 189 insertions(+), 199 deletions(-)

Really (-w), it is this besides the tab removals:

 t/README                     |  9 +++++++++
 t/t0003-attributes.sh        | 10 ----------
 t/t0050-filesystem.sh        | 62 ++++++++++++++++++++------------------------------------------
 t/t3910-mac-os-precompose.sh | 25 +++++++------------------
 t/test-lib.sh                | 24 ++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 70 deletions(-)

-- 
1.7.12.rc0.198.gd66b616
