From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/8] builtin-init-db: use warning() instead of
	fprintf(stderr, "warning: ")
Date: Thu, 19 Feb 2009 13:54:11 +0100
Message-ID: <70fd98a12f76097ba152bc3f1bc929a3b19ec8dd.1235047192.git.vmiklos@frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 13:55:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La8RK-0001K8-6W
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbZBSMyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbZBSMyN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:54:13 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47456 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754514AbZBSMyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:54:12 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id AF9D9580D1;
	Thu, 19 Feb 2009 13:54:12 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 66D27446A6;
	Thu, 19 Feb 2009 13:54:11 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9AFF911B877C; Thu, 19 Feb 2009 13:54:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1235047192.git.vmiklos@frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110689>

---
 builtin-init-db.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index ee3911f..fc63d0f 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -130,8 +130,7 @@ static void copy_templates(const char *template_dir)
 	}
 	dir = opendir(template_path);
 	if (!dir) {
-		fprintf(stderr, "warning: templates not found %s\n",
-			template_dir);
+		warning("templates not found %s", template_dir);
 		return;
 	}
 
@@ -144,8 +143,8 @@ static void copy_templates(const char *template_dir)
 
 	if (repository_format_version &&
 	    repository_format_version != GIT_REPO_VERSION) {
-		fprintf(stderr, "warning: not copying templates of "
-			"a wrong format version %d from '%s'\n",
+		warning("not copying templates of "
+			"a wrong format version %d from '%s'",
 			repository_format_version,
 			template_dir);
 		closedir(dir);
-- 
1.6.1
