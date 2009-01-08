From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH, resend] git-status -v: colored diff when color.ui is set
Date: Thu, 8 Jan 2009 19:53:05 +0100
Message-ID: <200901081953.05427.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 20:17:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL01s-0000ph-Pn
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 19:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761628AbZAHSwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 13:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761564AbZAHSwy
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 13:52:54 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:49718 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761616AbZAHSwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 13:52:51 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 18CA5F6518BA;
	Thu,  8 Jan 2009 19:52:51 +0100 (CET)
Received: from [89.59.114.169] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LKzzu-0001aU-00; Thu, 08 Jan 2009 19:52:51 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19C4CteAEVPHQBhnd/m7tooUKGBjuLvO5DrexaT
	+fZevFKlKoWbsArvXYAaB0aIcK5tXldzOgpkAIANbLmfAD/iTp
	kCBIBXSoEtbZMQRGcCVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104951>

When using "git status -v", the diff output wasn't colored, even though
color.ui was set. Only when setting color.diff it worked.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 builtin-commit.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 2d90f74..7cf227a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -866,6 +866,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (wt_status_use_color == -1)
 		wt_status_use_color = git_use_color_default;
 
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
+
 	argc = parse_and_validate_options(argc, argv, builtin_status_usage, prefix);
 
 	index_file = prepare_index(argc, argv, prefix);
-- 
1.6.1.35.g0c23
