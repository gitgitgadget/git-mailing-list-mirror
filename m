From: Elijah Newren <newren@gmail.com>
Subject: [WIP PATCH 06/10] Add a comment pointing out a bug
Date: Mon, 21 Mar 2011 12:31:00 -0600
Message-ID: <1300732264-9638-7-git-send-email-newren@gmail.com>
References: <1300732264-9638-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:25:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jml-0000RW-TT
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab1CUSYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:24:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62978 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab1CUSYt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:24:49 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so5291756vws.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=66NcguW9kBrHDqy+l8rIpqdyyXTuc0iTzkj6I1LQ2ns=;
        b=uj297iP2tXuYSix+Evs2uJixznxjdNFBoq2YHtqGNjjBHExIwHrrz+KxWosNBCu3JC
         WLzWqRuOJDcUeixhHeoxmT5ssFmorVAielpGY0g9sVKAN+QOQ6yc2Em/pj8vVNo43/KV
         5cvXJMy0HPnq+bgTXvlFckmVIPkYmCYk4l5IY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=N9UtX2clwO422ZGZotrL9Qho0Bm2zq+O6/2rI/+35IoeYOll0KZEaPnI4WIsv58t6r
         ccUovk69CMhu7j/Cg9C16m9R2ymxQJtURvPVtP6O9pBPjPLIYe0R+6rGmBfYTOsetxCs
         K4BzWPeTvqBU8NWPV+UxDOeGMVBQfWyZEUgE4=
Received: by 10.220.122.39 with SMTP id j39mr1280132vcr.82.1300731889072;
        Mon, 21 Mar 2011 11:24:49 -0700 (PDT)
Received: from localhost6.localdomain6 (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b6sm1507291vci.0.2011.03.21.11.24.47
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:24:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
In-Reply-To: <1300732264-9638-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169627>

---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7a04ca7..544c504 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1064,7 +1064,7 @@ static int process_renames(struct merge_options *o,
 							      ren1->dst_entry,
 							      ren2->dst_entry);
 			} else {
-				remove_file(o, 1, ren1_src, 1);
+				remove_file(o, 1, ren1_src, 1);  // BAD
 				update_stages_and_entry(ren1_dst,
 							ren1->dst_entry,
 							ren1->pair->one,
-- 
1.7.4
