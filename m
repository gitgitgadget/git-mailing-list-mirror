From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH] sequencer: remove additional blank line
Date: Wed, 18 Apr 2012 23:07:25 +0200
Message-ID: <1334783245-8733-1-git-send-email-ralf.thielow@googlemail.com>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 23:08:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKc6j-00039m-59
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 23:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226Ab2DRVHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 17:07:35 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63973 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab2DRVHe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 17:07:34 -0400
Received: by wejx9 with SMTP id x9so4993656wej.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=2HV9ojmYKmV2ZntMtlaV4jliTiFWdPc3ko7SlnSjVm4=;
        b=ZxG+NsNvIvNFiurfGDjNdFsSAR9tDfdcn2R45AHYlIMDMXu8qh5lnyRvVAvO40PySD
         jneRIVJEFgtG5Fm9FYFUvDgiePuj2kgg/xuARAW5yJy/Vcfn4DNjtqclsWZMgljCyKFL
         02F1EceC8Rb0VqKC2BZu58Uusohry6YHmm2j9g+J/9cstEUYhxI/mggGgLJvn11ZcaHQ
         jT8vy/D3AIWNGAhtfMqLi9z28Cv+HlZcX62NgzfsZlIDCLhMtUuFzlXhnw5xFCLVO1Tw
         Y+wrxWoZeJaIAWbzzES6Mk0DU9hmtFqiCJxVH7KDZ/6+XlWa0BR+W5WG6IYxn3Ppjw5U
         3M8g==
Received: by 10.216.29.197 with SMTP id i47mr2310220wea.45.1334783252813;
        Wed, 18 Apr 2012 14:07:32 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id j3sm266489wiw.1.2012.04.18.14.07.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 14:07:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.170.gac579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195903>

Remove an additional blank line between the
headline and the list of conflicted files after
doing a recursive merge.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
Normally, the list of conflicted files come directly after
the headline like this

    Conflicts:
        folder/file
	...

Without this patch it would looks like this:

    Conflicts:

        folder/file
	...

 sequencer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index a37846a..f6e44b8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -234,7 +234,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 
 	if (!clean) {
 		int i;
-		strbuf_addstr(msgbuf, "\nConflicts:\n\n");
+		strbuf_addstr(msgbuf, "\nConflicts:\n");
 		for (i = 0; i < active_nr;) {
 			struct cache_entry *ce = active_cache[i++];
 			if (ce_stage(ce)) {
-- 
1.7.10.170.gac579
