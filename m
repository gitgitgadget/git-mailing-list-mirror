From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: [PATCH] builtin-show-branch.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 18:36:36 -0600
Message-ID: <5d46db230802081636j37d97750u1b7a677633e15f71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:37:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNdiR-000815-At
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 01:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284AbYBIAgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 19:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbYBIAgi
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 19:36:38 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:16320 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586AbYBIAgh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 19:36:37 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4246063wxd.4
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 16:36:36 -0800 (PST)
Received: by 10.150.195.21 with SMTP id s21mr5586016ybf.87.1202517396537;
        Fri, 08 Feb 2008 16:36:36 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Fri, 8 Feb 2008 16:36:36 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 343237919dd1f3a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73175>

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 builtin-show-branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 6dc835d..3f60f32 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -535,7 +535,7 @@ static void append_one_rev(const char *av)

 static int git_show_branch_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "showbranch.default")) {
+	if (value && !strcmp(var, "showbranch.default")) {
 		if (default_alloc <= default_num + 1) {
 			default_alloc = default_alloc * 3 / 2 + 20;
 			default_arg = xrealloc(default_arg, sizeof *default_arg * default_alloc);
-- 
1.5.4.36.g9af61
