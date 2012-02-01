From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] i18n: diff/apply statistics
Date: Thu,  2 Feb 2012 01:22:57 +0800
Message-ID: <1328116977-61458-1-git-send-email-worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>, avarab@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 01 18:23:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsdtx-0002VO-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 18:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab2BARXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 12:23:17 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42738 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab2BARXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 12:23:16 -0500
Received: by ggnh1 with SMTP id h1so717763ggn.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 09:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6wwnep6KzkINcE3qCKMzNa+9oV8+nD+9Pzskxcv9dvY=;
        b=HhjJMmBgAOIObSenVobl1dHj03b27/5jVbidD3ryPXS/9YxPYRROPfi9KqABRqoNfK
         PD3KKNUghRC0ducEbvFbP8ODlD3FJzDOyBk/h+Gn+cCV7SihAOL42ev2rJ4hoNSKwfR0
         H6qUH8XCcgbd4PibM0hOvjVg8LXMLlctkZ7xk=
Received: by 10.50.194.170 with SMTP id hx10mr8189407igc.6.1328116995502;
        Wed, 01 Feb 2012 09:23:15 -0800 (PST)
Received: from localhost.foo.bar ([123.116.240.29])
        by mx.google.com with ESMTPS id z22sm27562123ibg.5.2012.02.01.09.23.09
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 09:23:15 -0800 (PST)
X-Mailer: git-send-email 1.7.9.3.g1fbd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189525>

translate oneline statistics of diff/apply.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/apply.c |    2 +-
 diff.c          |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c24d..e289e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3241,7 +3241,7 @@ static void stat_patch_list(struct patch *patch)
 		show_stats(patch);
 	}
 
-	printf(" %d files changed, %d insertions(+), %d deletions(-)\n", files, adds, dels);
+	printf(_(" %d files changed, %d insertions(+), %d deletions(-)\n"), files, adds, dels);
 }
 
 static void numstat_patch_list(struct patch *patch)
diff --git a/diff.c b/diff.c
index 7e1542..b9115 100644
--- a/diff.c
+++ b/diff.c
@@ -1476,7 +1476,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	}
 	fprintf(options->file, "%s", line_prefix);
 	fprintf(options->file,
-	       " %d files changed, %d insertions(+), %d deletions(-)\n",
+	       _(" %d files changed, %d insertions(+), %d deletions(-)\n"),
 	       total_files, adds, dels);
 }
 
@@ -1507,7 +1507,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 				options->output_prefix_data);
 		fprintf(options->file, "%s", msg->buf);
 	}
-	fprintf(options->file, " %d files changed, %d insertions(+), %d deletions(-)\n",
+	fprintf(options->file, _(" %d files changed, %d insertions(+), %d deletions(-)\n"),
 	       total_files, adds, dels);
 }
 
-- 
1.7.9.3.g1fbd7
