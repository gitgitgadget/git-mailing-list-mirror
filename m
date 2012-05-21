From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/7] merge-recursive: free some string lists
Date: Mon, 21 May 2012 16:56:05 +0200
Message-ID: <20120521145610.1911.82257.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 17:10:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWUFr-0003PA-VN
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 17:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab2EUPKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 11:10:33 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:39457 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab2EUPKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 11:10:33 -0400
Received: from [127.0.1.1] (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9E1A1A62DE;
	Mon, 21 May 2012 17:10:26 +0200 (CEST)
X-git-sha1: 3c43170a45e7ffaa29bfe4f503d8aeef62be5502 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198108>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 merge-recursive.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 680937c..9c3570a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1856,7 +1856,9 @@ int merge_trees(struct merge_options *o,
 		string_list_clear(re_merge, 0);
 		string_list_clear(re_head, 0);
 		string_list_clear(entries, 1);
-
+		free(re_merge);
+		free(re_head);
+		free(entries);
 	}
 	else
 		clean = 1;
-- 
1.7.10.2.555.g6528037
