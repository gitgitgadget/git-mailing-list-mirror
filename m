From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 6/8] Makefile: define __sun__ on SunOS
Date: Fri,  5 Jun 2009 18:36:14 -0500
Message-ID: <67hZHClrEWQHxCRdWosE2-yxscBzIn8DiQogVPM7EAgcGyYg61V8vYLxFiW6A4ovZp6SOuP0pDM@cipher.nrlssc.navy.mil>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE28bOBU_EdMUdyv6uENKCaQfOLQjhGBq3kLwxe6mMrfW4HauaUwWt5eM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE26gwuGblUI8bcWLxyoPZhmfzJAibRVMtix-zkRUKYe5Y8R8-GRcIkUI@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 01:36:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCixs-0002dR-R3
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 01:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbZFEXgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 19:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbZFEXgj
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 19:36:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51666 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbZFEXgf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 19:36:35 -0400
Received: by mail.nrlssc.navy.mil id n55NaS15019262; Fri, 5 Jun 2009 18:36:30 -0500
In-Reply-To: <67hZHClrEWQHxCRdWosE26gwuGblUI8bcWLxyoPZhmfzJAibRVMtix-zkRUKYe5Y8R8-GRcIkUI@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Jun 2009 23:36:28.0458 (UTC) FILETIME=[72C008A0:01C9E636]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120844>

From: Brandon Casey <drafnel@gmail.com>

The SUNWspro compiler does not define __sun__ (like GCC does).  A check of
this macro was recently added to detect compilation on SunOS and to modify
the handling of the NO_ICONV and _XOPEN_SOURCE feature macros.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 375cf2a..1239a3c 100644
--- a/Makefile
+++ b/Makefile
@@ -731,7 +731,7 @@ ifeq ($(uname_S),SunOS)
 	endif
 	INSTALL = /usr/ucb/install
 	TAR = gtar
-	BASIC_CFLAGS += -D__EXTENSIONS__
+	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
 endif
 ifeq ($(uname_O),Cygwin)
 	NO_D_TYPE_IN_DIRENT = YesPlease
-- 
1.6.3.1.24.g152f4
