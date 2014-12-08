From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 0/5] git-glossary
Date: Mon,  8 Dec 2014 16:38:54 +0100
Message-ID: <cover.1418052470.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 16:39:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0PC-0000ST-Pf
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 16:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbaLHPjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 10:39:03 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38474 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751880AbaLHPjB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 10:39:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 3784820C84
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 10:39:01 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 08 Dec 2014 10:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id; s=smtpout; bh=SAgg21cZo9TAMfzIBglKDDzhKOw=; b=PtU4w
	ywEP2BATfOHquM52Yv0PAZEpHD+Pihw2XIrfihFpDeNYTJ8QNRueOto4OVxxQI/n
	7PQWzSCTqHXFayOBsSGbaTh7bXYvrfU+yvZRJJsm5kltq8FUS80cGfrFnZHMBsCn
	SwEr693yYVnTYCgcWd4ojEwhiC1AR+tTmTcYtI=
X-Sasl-enc: hydX0awHzpDPiC+UQ3Ph8WyzGRTzJgDnisfDcjxBAU2r 1418053140
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CC822C00281;
	Mon,  8 Dec 2014 10:39:00 -0500 (EST)
X-Mailer: git-send-email 2.2.0.345.g7041aac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261046>

More and more people use Git in localised setups, which usually means
mixed localisation setups - not only, but also because of our English
man pages.

Here's an attempt at leveraging our current infrastructure for helping
those poor mixed localisation folks. The idea is to keep the most
important iterms in the glossary and translate at least these.

1/5: generate glossary term list automatically from gitglossary.txt
2/5: introduce git-glossary command which helps with lookups
3/5: introduce git-glossary.txt, the man page for the command
4/5: git.pot update
5/5: sample de.po update

Without 4/5 and 5/5, a few terms from the glossary can be translated
already by coincidence with localised messages from some git commands.

Michael J Gruber (5):
  glossary.h: generate a glossary list from the Makefile
  glossary: introduce glossary lookup command
  glossary: man page
  l10n: git-glossary
  l10n: de: git-glossary

 .gitignore                     |    2 +
 Documentation/git-glossary.txt |   48 ++
 Makefile                       |    8 +-
 builtin.h                      |    1 +
 builtin/glossary.c             |  104 +++
 command-list.txt               |    1 +
 generate-glossary.sh           |    8 +
 git.c                          |    1 +
 po/de.po                       | 1382 ++++++++++++++++++++++++----------------
 po/git.pot                     | 1362 +++++++++++++++++++++++----------------
 10 files changed, 1839 insertions(+), 1078 deletions(-)
 create mode 100644 Documentation/git-glossary.txt
 create mode 100644 builtin/glossary.c
 create mode 100755 generate-glossary.sh

-- 
2.2.0.345.g7041aac
