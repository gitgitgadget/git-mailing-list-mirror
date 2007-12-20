From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix thinko in checking for commit message emptiness
Date: Fri, 21 Dec 2007 00:48:49 +0100
Message-ID: <20071220234849.GF3052@steel.home>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org> <20071220233324.GB3052@steel.home> <20071220233539.GC3052@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 00:50:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5V8o-0001fK-3N
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 00:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302AbXLTXsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 18:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755600AbXLTXsx
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 18:48:53 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:11928 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649AbXLTXsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 18:48:51 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTvznCE=
Received: from tigra.home (Fca98.f.strato-dslnet.de [195.4.202.152])
	by post.webmailer.de (klopstock mo47) (RZmta 14.6)
	with ESMTP id K03c9fjBKJHNp2 ; Fri, 21 Dec 2007 00:48:50 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E7BDA277AE;
	Fri, 21 Dec 2007 00:48:49 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id CC7BC56D22; Fri, 21 Dec 2007 00:48:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071220233539.GC3052@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69028>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Sorry. It must be late. It it must have been late yesterday
and still is today.

 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 1356d20..eae7661 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -436,7 +436,7 @@ static int message_is_empty(struct strbuf *sb, int start)
 	int eol, i;
 
 	if (verbatim_message && sb->len)
-		return 1;
+		return 0;
 
 	/* See if the template is just a prefix of the message. */
 	strbuf_init(&tmpl, 0);
-- 
1.5.4.rc1.33.gbd32b
