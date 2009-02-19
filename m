From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 5/8] builtin-rm: use warning() instead of fprintf(stderr,
	"warning: ")
Date: Thu, 19 Feb 2009 13:54:31 +0100
Message-ID: <dde5b527fe5d5dc668ce65c46713a3abdd33ea20.1235047192.git.vmiklos@frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 13:56:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La8Rd-0001TZ-Gn
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbZBSMye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755219AbZBSMyd
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:54:33 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47460 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516AbZBSMyc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:54:32 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 78EDB580D1;
	Thu, 19 Feb 2009 13:54:32 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 355EF446A6;
	Thu, 19 Feb 2009 13:54:31 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 669F811B877C; Thu, 19 Feb 2009 13:54:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1235047192.git.vmiklos@frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110690>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-rm.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index c11f455..269d608 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -59,8 +59,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 
 		if (lstat(ce->name, &st) < 0) {
 			if (errno != ENOENT)
-				fprintf(stderr, "warning: '%s': %s",
-					ce->name, strerror(errno));
+				warning("'%s': %s", ce->name, strerror(errno));
 			/* It already vanished from the working tree */
 			continue;
 		}
-- 
1.6.1
