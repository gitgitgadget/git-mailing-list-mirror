From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: [PATCH] imap-send.c: guard config parser from value=NULL
Date: Sat, 9 Feb 2008 14:18:13 -0600
Message-ID: <5d46db230802091218y406ee25bo3a1b93f917407ee3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 21:18:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNw9x-0006HQ-C3
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 21:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbYBIUSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 15:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbYBIUSP
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 15:18:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:35328 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541AbYBIUSP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 15:18:15 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4365639wxd.4
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 12:18:13 -0800 (PST)
Received: by 10.150.177.20 with SMTP id z20mr5947817ybe.118.1202588293561;
        Sat, 09 Feb 2008 12:18:13 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Sat, 9 Feb 2008 12:18:13 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73260>

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 imap-send.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index a429a76..a8f430e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1258,7 +1258,7 @@ git_imap_config(const char *key, const char *val)

 	if (!strcmp( "folder", key )) {
 		imap_folder = xstrdup( val );
-	} else if (!strcmp( "host", key )) {
+	} else if (val && !strcmp( "host", key )) {
 		{
 			if (!prefixcmp(val, "imap:"))
 				val += 5;
-- 
1.5.4.36.g9af61
