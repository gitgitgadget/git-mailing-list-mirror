From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: Solaris needs HAVE_ALLOCA_H for alloca()
Date: Fri, 19 Jun 2009 10:10:39 -0500
Message-ID: <rIbngkOg09-z417RR6vnxtaWRxZPW0C76uXa4_JzMol0RO1rkm5yNuoSLJ-0CLFvD_NocmuiasU@cipher.nrlssc.navy.mil>
References: <7vy6rpmeqh.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 17:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHfkM-0000yN-W8
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 17:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbZFSPLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 11:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbZFSPLJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 11:11:09 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52676 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbZFSPLI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 11:11:08 -0400
Received: by mail.nrlssc.navy.mil id n5JFAlOM019328; Fri, 19 Jun 2009 10:10:47 -0500
In-Reply-To: <7vy6rpmeqh.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Jun 2009 15:10:46.0921 (UTC) FILETIME=[1F916790:01C9F0F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121902>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


Junio C Hamano wrote:

> ----------------------------------------------------------------
> [New Topics]
> * jk/use-our-regexp (Tue Jun 16 15:08:21 2009 -0400) 2 commits
>  - Makefile: use compat regex on Solaris
>  - Makefile: refactor regex compat support

Please squash this on top of 'Makefile: use compat regex on Solaris'.

There is special handling in compat/regex/regex.c for the GNU compiler
to define alloca to __builtin_alloca, but the native compiler must include
alloca.h which happens when HAVE_ALLOCA_H is defined.

thanks,
-brandon


 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 3bd0c08..bbc26e8 100644
--- a/Makefile
+++ b/Makefile
@@ -753,7 +753,7 @@ ifeq ($(uname_S),SunOS)
 	endif
 	INSTALL = /usr/ucb/install
 	TAR = gtar
-	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
+	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__ -DHAVE_ALLOCA_H
 endif
 ifeq ($(uname_O),Cygwin)
 	NO_D_TYPE_IN_DIRENT = YesPlease
-- 
1.6.3.1.24.g152f4
