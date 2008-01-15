From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] ls-remote: add -t and -h options.
Date: Tue, 15 Jan 2008 21:34:54 +0100
Message-ID: <20080115203454.GU29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:35:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsVX-00032a-6q
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbYAOUfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbYAOUfL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:35:11 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48374 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbYAOUfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:35:09 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JEsUw-0008KZ-Mv
	from <vmiklos@frugalware.org>; Tue, 15 Jan 2008 21:35:08 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9383711901F9; Tue, 15 Jan 2008 21:34:54 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-0.5 required=5.9 tests=BAYES_20 autolearn=no SpamAssassin version=3.2.3
	-0.5 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.1215]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70555>

These options are listed in the manpage (aliases for --tags/--heads) but they
were not handled.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Alternatively, if it's too late to introduce new options, I think we should
remove these options from the manpage, but I prefer the current fix.

 builtin-ls-remote.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index c2caeea..6dd31d1 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -54,11 +54,11 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 				uploadpack = arg + 7;
 				continue;
 			}
-			if (!strcmp("--tags", arg)) {
+			if (!strcmp("--tags", arg) || !strcmp("-t", arg)) {
 				flags |= REF_TAGS;
 				continue;
 			}
-			if (!strcmp("--heads", arg)) {
+			if (!strcmp("--heads", arg) || !strcmp("-h", arg)) {
 				flags |= REF_HEADS;
 				continue;
 			}
-- 
1.5.4.rc3.4.g16335-dirty
