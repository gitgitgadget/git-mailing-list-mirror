From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH] diff-options: make --patch a synonym for -p
Date: Thu,  6 May 2010 23:42:44 +0100
Message-ID: <1273185764-9907-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 00:43:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA9mn-0001gm-Mr
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab0EFWnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:43:13 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:45933 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632Ab0EFWnM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:43:12 -0400
Received: by wwb39 with SMTP id 39so401420wwb.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=5poUuLvMmxYfg3/Bx3khrIQ9tqgjcabzIyKMKTGi1s4=;
        b=bIM98uMcvF08lzC97LkrgVuVbq7xK2T6i4qgTmHxYO6HtV02X7hrHhsejhffjXorgo
         lQnZ9+ugJiTBx/HznYZ/3n24hdbZVCgkTwsMwPEeh/t4oEAd1SpmuLytZycAEhcfWm4Y
         z02EidU75F7k4bCOsdzph+QqkNcWEejAWTGpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=R/PWqnWKJGJkE3RYqEkgBjrsWU6DrOPRKNNPavTtJ9g4a5OGifyvaB5ER+uY3tEhlK
         n8W4qtqduuyEApGKxbXwXuSgtTk4ihvp48FeSmc+8viyaHnEv38wTHNcrCwKwCyT4IoV
         N63TpQDOsMQRyuQzjeNX+Uek+2ocPv80e8FPM=
Received: by 10.227.134.16 with SMTP id h16mr4839653wbt.69.1273185790426;
        Thu, 06 May 2010 15:43:10 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id r29sm10576230wbv.9.2010.05.06.15.43.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 15:43:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.12.ga6018.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146508>

Here we simply make --patch a synonym for -p, whose mnemonic was "patch"
all along.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/diff-options.txt |    1 +
 diff.c                         |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c9c6c2b..4a96859 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -21,6 +21,7 @@ endif::git-format-patch[]
 ifndef::git-format-patch[]
 -p::
 -u::
+--patch::
 	Generate patch (see section on generating patches).
 	{git-diff? This is the default.}
 endif::git-format-patch[]
diff --git a/diff.c b/diff.c
index d0ecbc3..8ea9f97 100644
--- a/diff.c
+++ b/diff.c
@@ -2722,7 +2722,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	const char *arg = av[0];
 
 	/* Output format options */
-	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
+	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch"))
 		options->output_format |= DIFF_FORMAT_PATCH;
 	else if (opt_arg(arg, 'U', "unified", &options->context))
 		options->output_format |= DIFF_FORMAT_PATCH;
-- 
1.7.1.rc1.12.ga6018.dirty
