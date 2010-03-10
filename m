From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] Do not strip empty lines / trailing spaces from a commit
 message template
Date: Wed, 10 Mar 2010 16:57:11 +0100
Message-ID: <4B97C157.4020806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 10 16:57:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpOI2-000074-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 16:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab0CJP5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 10:57:37 -0500
Received: from lo.gmane.org ([80.91.229.12]:50452 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756766Ab0CJP5g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 10:57:36 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NpOHv-0008WD-Ed
	for git@vger.kernel.org; Wed, 10 Mar 2010 16:57:35 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 16:57:35 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 16:57:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141906>

Templates should be just that: Forms that the user fills out, and forms
have blanks. If people are attached to not having extra whitespace in the
editor, they can simply clean up their templates.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index f4c7344..8a68dd3 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -584,7 +584,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (fp == NULL)
 		die_errno("could not open '%s'", git_path(commit_editmsg));
 
-	if (cleanup_mode != CLEANUP_NONE)
+	if (cleanup_mode != CLEANUP_NONE && strcmp(hook_arg1, "template"))
 		stripspace(&sb, 0);
 
 	if (signoff) {
-- 
1.7.0.2.msysgit.0.8.g888e.dirty
