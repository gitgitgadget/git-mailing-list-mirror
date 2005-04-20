From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 0/3] introduce GIT_CACHE_DIRECTORY to plumbing
Date: Tue, 19 Apr 2005 21:32:06 -0700
Message-ID: <mailbox-1370-1113971526-282751@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Apr 20 06:28:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO6oj-0007VI-4M
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 06:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVDTEcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 00:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVDTEcK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 00:32:10 -0400
Received: from guft.superlucidity.net ([63.224.205.130]:22415 "EHLO
	mail.guft.org") by vger.kernel.org with ESMTP id S261352AbVDTEcH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 00:32:07 -0400
Received: (qmail 1375 invoked by uid 5006); 19 Apr 2005 21:32:06 -0700
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The first patch introduces the GIT_CACHE_DIRECTORY to the C plumbing.
Without this patch, the index file and its lock are always placed
in './.git'.  Scripts wishing to run these commands from a different 
working directory can use this support to override the cache directory.

The second patch renames the DB_ENVIRONMENT symbols to match.  Note,
the name changes came from an off-list comment from Linus, after my
sendpatches script accidentally bombed him with a half dozen copies of
the init-db patch series summary.  His comment inspired these last two.

The third patch renames SHA1_FILE_DIRECTORY as GIT_OBJECT_DIRECTORY,
to match the "GIT_CACHE_DIRECTORY" name introduced in the first patch.
This was done last and seperately so it can be applied after a little
bit of notice.  We're not at a point of need to be backwards compatible.

This require my latest init-db cleanups be applied first, otherwise
you will get a rejection in init-db.c.

There are 3 patches in this series:
        [PATCH 1/3] add GIT_CACHE_DIRECTORY support
        [PATCH 2/3] rename object directory symbols
        [PATCH 3/3] rename SHA1_FILE_DIRECTORY
