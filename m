From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: [PATCH] connect.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 18:35:31 -0600
Message-ID: <5d46db230802081635v2b250aa5i173a1cfba0c06d81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:36:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNdhS-0007hC-7y
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 01:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbYBIAff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 19:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754386AbYBIAff
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 19:35:35 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:62135 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbYBIAfe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 19:35:34 -0500
Received: by wr-out-0506.google.com with SMTP id c48so3846178wra.23
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 16:35:31 -0800 (PST)
Received: by 10.150.186.12 with SMTP id j12mr24794ybf.172.1202517331702;
        Fri, 08 Feb 2008 16:35:31 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Fri, 8 Feb 2008 16:35:31 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 9b5b05ea468a0667
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73174>

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 connect.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index 3aefd4a..90315ff 100644
--- a/connect.c
+++ b/connect.c
@@ -363,7 +363,7 @@ static int rhost_len;

 static int git_proxy_command_options(const char *var, const char *value)
 {
-	if (!strcmp(var, "core.gitproxy")) {
+	if (value && !strcmp(var, "core.gitproxy")) {
 		const char *for_pos;
 		int matchlen = -1;
 		int hostlen;
-- 
1.5.4.36.g9af61
