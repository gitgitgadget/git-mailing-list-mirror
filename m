From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 16/48] merge-recursive: Make BUG message more legible by adding a newline
Date: Wed,  8 Jun 2011 01:30:46 -0600
Message-ID: <1307518278-23814-17-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDI-0005pC-NE
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab1FHH3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:30 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:37577 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866Ab1FHH31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:27 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so191910pxi.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=siJMQ4jIMJxaen0nDOTKZObLNrrUviBLiWn7F+7Pxm8=;
        b=OCXsraw/8MopqKZENtNYa+E+cMYEj/n5QPhiJd+eR6BCFcr9OkiNy3cKplktWBGXky
         vst+uP8ua2zjT0u2RvstMukb8tNzxhNpqoD6KyJv8ULr7TuG48lm6vGlLRvwZEJEvcdr
         tKspZLWf0HKNSRlQnyrm2eBCmbN7yBtQbeoRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NgKEs8EQQl0VaRqrtM2XfFfoxo+3fFNn5BnfG/8BMvMpMxCv6egIwZat+/lhZYJC9r
         qMoWYydBtld49oNfUwvtsOifACs6nXYg2oj2z/gXAEF8Tr+rLbvfXdprWUaBPNqD1PHt
         fzJlUyvGWyYLVuLCsJgmaQWaP7NANF+Sfbde0=
Received: by 10.68.10.105 with SMTP id h9mr593353pbb.108.1307518167561;
        Wed, 08 Jun 2011 00:29:27 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.25
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175306>

Hopefully no one ever hits this error except when making large changes to
merge-recursive.c and debugging...

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index db9ba19..3fcd0a5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -230,7 +230,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
 			if (ce_stage(ce))
-				fprintf(stderr, "BUG: %d %.*s", ce_stage(ce),
+				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
 		}
 		die("Bug in merge-recursive.c");
-- 
1.7.6.rc0.62.g2d69f
