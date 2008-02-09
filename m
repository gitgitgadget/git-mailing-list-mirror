From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: [PATCH] archive-tar.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 18:37:22 -0600
Message-ID: <5d46db230802081637i3197b923ka0b779cf582031e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:38:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNdjE-0008E1-43
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 01:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131AbYBIAhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 19:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbYBIAhY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 19:37:24 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:16615 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbYBIAhX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 19:37:23 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4246244wxd.4
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 16:37:22 -0800 (PST)
Received: by 10.150.121.2 with SMTP id t2mr5585861ybc.130.1202517442038;
        Fri, 08 Feb 2008 16:37:22 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Fri, 8 Feb 2008 16:37:22 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: e3799fc9f3921f38
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73176>

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 archive-tar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index e1bced5..30aa2e2 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -222,7 +222,7 @@ static void write_global_extended_header(const
unsigned char *sha1)
 static int git_tar_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "tar.umask")) {
-		if (!strcmp(value, "user")) {
+		if (value && !strcmp(value, "user")) {
 			tar_umask = umask(0);
 			umask(tar_umask);
 		} else {
-- 
1.5.4.36.g9af61
