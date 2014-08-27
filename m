From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH 2/2] read_index_unmerged(): remove unnecessary loop index adjustment
Date: Wed, 27 Aug 2014 21:48:12 +0200
Message-ID: <1409168892-11345-2-git-send-email-jsorianopastor@gmail.com>
References: <xmqqy4ubi1ty.fsf@gitster.dls.corp.google.com>
 <1409168892-11345-1-git-send-email-jsorianopastor@gmail.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 21:49:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMjDR-0007u7-Uf
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbaH0TtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:49:05 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:48709 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964818AbaH0TtD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:49:03 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so683575wgh.34
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 12:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7RXha0Bp1RcxVx0LlmAH2w1bkbjXqNaJPr8YcU8B82M=;
        b=eznmbMjHZhX9u5C6oTGWpfvH3qAUL0VgdjpZPsMyDAzaCcCg1WYokMrNZVp1gCtCh5
         l1KcsRzA10ieVzLnpeibe8HRfvP6fefzPmEJALUYj2WpIKVYs5vJZpsaH5Z17hiie+w0
         fRVpzx+J4VUr+/Cn5adWpT7n+uoVA/QpuUV/6CZEGQgihrJknBliLT/OUIpozfisioP2
         3/yXNf4vVwoyGrAsWyLZ6+AowmNHwGdPI2PAZk+5HAEFPYNCTXEA6mjgx1FKkbcOojnJ
         6dIZmwVf/6nIDTBNFkXGrY6gXFQU0z6iV01Oo+pSLWhdyw9Xmblvh5yMD9SrzUg7LBb6
         Gyjw==
X-Received: by 10.180.211.71 with SMTP id na7mr28737354wic.14.1409168942466;
        Wed, 27 Aug 2014 12:49:02 -0700 (PDT)
Received: from localhost.localdomain (4.Red-88-3-38.dynamicIP.rima-tde.net. [88.3.38.4])
        by mx.google.com with ESMTPSA id fx10sm42629wib.10.2014.08.27.12.49.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Aug 2014 12:49:01 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.2.g7bc378e.dirty
In-Reply-To: <1409168892-11345-1-git-send-email-jsorianopastor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256036>

Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
---
 read-cache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 1cdb762..39fca8c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1971,7 +1971,6 @@ int read_index_unmerged(struct index_state *istate)
 		if (add_index_entry(istate, new_ce, 0))
 			return error("%s: cannot drop to stage #0",
 				     new_ce->name);
-		i = index_name_pos(istate, new_ce->name, len);
 	}
 	return unmerged;
 }
-- 
2.0.4.2.g7bc378e.dirty
