From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: [PATCH] builtin-gc.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 19:12:06 -0600
Message-ID: <5d46db230802081712n5c8ff291x3c0bad8a29030be9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 02:13:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNeH6-0008Ik-Dh
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 02:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615AbYBIBMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 20:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755674AbYBIBMM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 20:12:12 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:37785 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573AbYBIBML (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 20:12:11 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4255257wxd.4
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 17:12:06 -0800 (PST)
Received: by 10.150.150.3 with SMTP id x3mr5595558ybd.23.1202519526871;
        Fri, 08 Feb 2008 17:12:06 -0800 (PST)
Received: by 10.150.199.5 with HTTP; Fri, 8 Feb 2008 17:12:06 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: a89f83fe7c25c97e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73180>

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
 builtin-gc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index ac34788..ad4a75e 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -37,7 +37,7 @@ static const char *argv_rerere[] = {"rerere", "gc", NULL};
 static int gc_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "gc.packrefs")) {
-		if (!strcmp(value, "notbare"))
+		if (value && !strcmp(value, "notbare"))
 			pack_refs = -1;
 		else
 			pack_refs = git_config_bool(var, value);
-- 
1.5.4.36.g9af61
