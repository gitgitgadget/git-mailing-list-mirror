From: conrad.irwin@gmail.com
Subject: [PATCH v3 2/3] Allow git commit --interactive with paths
Date: Fri,  6 May 2011 23:00:00 -0700
Message-ID: <1304748001-17982-3-git-send-email-conrad.irwin@gmail.com>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
Cc: Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 08:00:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIaYt-0006H7-Vt
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 08:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab1EGGAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 02:00:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46834 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab1EGGAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 02:00:11 -0400
Received: by pzk9 with SMTP id 9so1707238pzk.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 23:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=RQ7zHrQE37zzkVFpcYcH5GiJ4UfiRiFV5vK8h0kZhS4=;
        b=XfVmNiTufHVhl65az92lYxPYzdogFvxKpKunzYEwpYjnlr+TdzOzqsiawZFgDDtX99
         iJzoJEC+jGKkHdfSCQc8rRIr0LU5PEe5cGMAKGRbdE1oDSQPrS+UAgrK/ISBnfnG4oN+
         s5/BAlhBbyHvnFuvNZ/onq3ULPqcibsfvtX7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RmuDJ8M4gQkR1XpJf6wK3hL/VYOiDpytVS1tpg/5E3ZuOwfhZnlnHTyPTQqdan4b7Y
         m9BgodZJwGVcIhOBgpga2Q6stV+/PNYSQbP1zKTW6llcc8mM7NJSZmh1OC2toCfmsWZ3
         KidoBXJ78V/1rfdBEkxvRG4ZaXqVygZEwRmzM=
Received: by 10.68.63.69 with SMTP id e5mr5851626pbs.307.1304748009937;
        Fri, 06 May 2011 23:00:09 -0700 (PDT)
Received: from scarlatti.dunvegan.biz (c-69-181-44-79.hsd1.ca.comcast.net [69.181.44.79])
        by mx.google.com with ESMTPS id a5sm2083810pbd.66.2011.05.06.23.00.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 May 2011 23:00:08 -0700 (PDT)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.75)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1QIaYg-0004gp-Rh; Fri, 06 May 2011 23:00:06 -0700
X-Mailer: git-send-email 1.7.5.188.g4817
In-Reply-To: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173034>

From: Conrad Irwin <conrad.irwin@gmail.com>

Make git commit --interactive feel more like git add --interactive by
allowing the user to restrict the list of files they have to deal with.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 builtin/commit.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 636aea6..7707af8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1084,8 +1084,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (all && argc > 0)
 		die(_("Paths with -a does not make sense."));
-	else if (interactive && argc > 0)
-		die(_("Paths with --interactive does not make sense."));
 
 	if (null_termination && status_format == STATUS_FORMAT_LONG)
 		status_format = STATUS_FORMAT_PORCELAIN;
-- 
1.7.5.188.g4817
