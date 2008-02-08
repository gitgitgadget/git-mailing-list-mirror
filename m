From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-gc.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 15:26:18 +0100
Message-ID: <20080208142618.GW25954@genesis.frugalware.org>
References: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 15:27:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNUCA-0006F2-PX
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 15:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622AbYBHO0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 09:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756694AbYBHO0g
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 09:26:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55740 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756360AbYBHO0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 09:26:35 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JNUBQ-0006RJ-UK
	from <vmiklos@frugalware.org>; Fri, 08 Feb 2008 15:26:34 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8313F11901C5; Fri,  8 Feb 2008 15:26:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.0
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.0 required=5.9 tests=BAYES_50 autolearn=no SpamAssassin version=3.2.3
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4861]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73093>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-gc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index ac34788..ad4a75e 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -37,7 +37,7 @@ static const char *argv_rerere[] = {"rerere", "gc", NULL};
 static int gc_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "gc.packrefs")) {
-		if (!strcmp(value, "notbare"))
+		if (value && !strcmp(value, "notbare"))
 			pack_refs = -1;
 		else
 			pack_refs = git_config_bool(var, value);
-- 
1.5.4
