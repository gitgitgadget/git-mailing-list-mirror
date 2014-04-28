From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 10/12] MINGW: config.mak.uname: drop USE_NED_ALLOCATOR
Date: Mon, 28 Apr 2014 17:51:35 +0400
Message-ID: <1398693097-24651-11-git-send-email-marat@slonopotamus.org>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:58:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wem56-0003Vx-H0
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841AbaD1N6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:58:47 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:39649 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbaD1N61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:58:27 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyL-0004qo-HE; Mon, 28 Apr 2014 17:51:53 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247342>

nedalloc was initially added in f0ed82 to fix slowness of standard WinXP
memory allocator. Since WinXP is EOLed, this point is no longer valid.

The actual reason behind this commit is incompatibility of malloc.c.h
with MinGW-W64 headers. Alternative solution implies updating nedalloc
to something newer.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 2 --
 1 file changed, 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 4883fd5..3fea7a8 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -342,7 +342,6 @@ ifeq ($(uname_S),Windows)
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
-	# USE_NED_ALLOCATOR = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
@@ -492,7 +491,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
-	USE_NED_ALLOCATOR = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
-- 
1.9.1
