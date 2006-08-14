From: David Rientjes <rientjes@google.com>
Subject: [PATCH 18/28] diff.c cleanup
Date: Mon, 14 Aug 2006 13:34:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141333430.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:34:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj8o-0000lG-Sv
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbWHNUe2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbWHNUe2
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:34:28 -0400
Received: from smtp-out.google.com ([216.239.45.12]:41366 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932731AbWHNUe1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:34:27 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id k7EKYOld026987
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:34:24 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=LmrQJCxd7M2u/atzmW8HK+P331yobe9ickWMM6aHuF3brrvVH5OuAiZl6g8nrROlx
	ePsllemSn30Vfi04r+9Pw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps78.corp.google.com with ESMTP id k7EKYGao024096
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:34:18 -0700
Received: by localhost (Postfix, from userid 24081)
	id 71B8F87D71; Mon, 14 Aug 2006 13:34:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 6F06087D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:34:16 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25399>

Removes conditional return.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 diff.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 8861b85..2327e60 100644
--- a/diff.c
+++ b/diff.c
@@ -904,9 +904,7 @@ static int mmfile_is_binary(mmfile_t *mf
 	long sz = mf->size;
 	if (FIRST_FEW_BYTES < sz)
 		sz = FIRST_FEW_BYTES;
-	if (memchr(mf->ptr, 0, sz))
-		return 1;
-	return 0;
+	return !!memchr(mf->ptr, 0, sz);
 }
 
 static void builtin_diff(const char *name_a,
-- 
1.4.2.g89bb-dirty
