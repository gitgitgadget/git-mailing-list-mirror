From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: [PATCH] commit.c: guard config parser from value=NULL
Date: Sat, 9 Feb 2008 14:16:10 -0600
Message-ID: <5d46db230802091216h40f88f06r20ebb84de6717af6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 21:16:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNw7y-0005iH-Lr
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 21:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbYBIUQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 15:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755467AbYBIUQM
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 15:16:12 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:34032 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbYBIUQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 15:16:11 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4365375wxd.4
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 12:16:10 -0800 (PST)
Received: by 10.151.26.12 with SMTP id d12mr5948633ybj.74.1202588170634;
        Sat, 09 Feb 2008 12:16:10 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Sat, 9 Feb 2008 12:16:10 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73259>

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 config.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 498259e..8247e88 100644
--- a/config.c
+++ b/config.c
@@ -407,12 +407,12 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}

-	if (!strcmp(var, "user.name")) {
+	if (value && !strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
 	}

-	if (!strcmp(var, "user.email")) {
+	if (value && !strcmp(var, "user.email")) {
 		strlcpy(git_default_email, value, sizeof(git_default_email));
 		return 0;
 	}
-- 
1.5.4.36.g9af61
