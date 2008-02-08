From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] archive-tar.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 15:26:02 +0100
Message-ID: <20080208142602.GV25954@genesis.frugalware.org>
References: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 15:26:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNUBs-00069P-B6
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 15:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756390AbYBHO0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 09:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756360AbYBHO0V
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 09:26:21 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36805 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395AbYBHO0U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 09:26:20 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JNUBA-0006PJ-GI
	from <vmiklos@frugalware.org>; Fri, 08 Feb 2008 15:26:18 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B5C2A11901BD; Fri,  8 Feb 2008 15:26:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.1 required=5.9 tests=BAYES_05 autolearn=no SpamAssassin version=3.2.3
	-1.1 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0248]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73092>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 archive-tar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index e1bced5..30aa2e2 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -222,7 +222,7 @@ static void write_global_extended_header(const unsigned char *sha1)
 static int git_tar_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "tar.umask")) {
-		if (!strcmp(value, "user")) {
+		if (value && !strcmp(value, "user")) {
 			tar_umask = umask(0);
 			umask(tar_umask);
 		} else {
-- 
1.5.4
