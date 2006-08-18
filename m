From: David Rientjes <rientjes@google.com>
Subject: [PATCH] make sha1_sort inline
Date: Thu, 17 Aug 2006 22:30:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608172229070.25827@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 18 07:31:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDwwq-0006kH-0d
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 07:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWHRFaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 01:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWHRFaw
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 01:30:52 -0400
Received: from smtp-out.google.com ([216.239.45.12]:13036 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964799AbWHRFaw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 01:30:52 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id k7I5UnQF031881
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 22:30:49 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=v/XOt0iznWt8MBBAT2y59ICIYFQjbBhnJboAVewcP2y6GyznIrGMeQMViLRJZlyTw
	Fej4TQuVx2pKgGf0bp8YQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps35.corp.google.com with ESMTP id k7I5UkwC007343
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 22:30:46 -0700
Received: by localhost (Postfix, from userid 24081)
	id 2A9B087D71; Thu, 17 Aug 2006 22:30:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 25FDA87D70
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 22:30:46 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25629>

Inlines sha1_sort as discussed in previous thread.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-pack-objects.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index f19f0d6..b7ba558 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -929,7 +929,8 @@ static struct object_entry **create_sort
 	return list;
 }
 
-static int sha1_sort(const struct object_entry *a, const struct object_entry *b)
+static inline int sha1_sort(const struct object_entry *a,
+			    const struct object_entry *b)
 {
 	return hashcmp(a->sha1, b->sha1);
 }
-- 
1.4.2.rc4.gd070-dirty
