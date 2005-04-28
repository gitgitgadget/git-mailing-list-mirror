From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [1/5] Consider a blob to be parsed
Date: Thu, 28 Apr 2005 01:04:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504280100360.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504280055180.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 07:00:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR18C-00073Z-61
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 07:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVD1FFM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVD1FFM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:05:12 -0400
Received: from iabervon.org ([66.92.72.58]:47876 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261985AbVD1FE7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 01:04:59 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DR1Cr-0001E0-00; Thu, 28 Apr 2005 01:04:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504280055180.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

We don't parse blobs at all, so any that we've got are as parsed as
they're going to get. Don't make fsck-cache mark them.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: blob.c
===================================================================
--- 89fdfd09b281fdf5071bc13a30ef683bd6851b61/blob.c  (mode:100644 sha1:3d99b93f020d84c5410c2b1056f2d7446b647d1e)
+++ 40a5a5657d67569bdc0e37b8ea2b76ec42824604/blob.c  (mode:100644 sha1:2fad8a5eb4c553190736870519f65c265dfb8526)
@@ -12,6 +12,7 @@
 		memset(ret, 0, sizeof(struct blob));
 		created_object(sha1, &ret->object);
 		ret->object.type = blob_type;
+		ret->object.parsed = 1;
 		return ret;
 	}
 	if (obj->parsed && obj->type != blob_type) {

