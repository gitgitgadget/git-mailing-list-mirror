From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] notes.c: remove inappropriate call to return
Date: Thu, 18 Mar 2010 10:03:43 -0500
Message-ID: <FMCfttz0yXy1PiW0rQs7llBXL-J_qvqMmKHhFzRD_pqpDVu1DBh0TUAi68oer0RcT3kMvGDNHiQ@cipher.nrlssc.navy.mil>
References: <m6P-Qdljqt7xCgOUC581DdkndLOwc9aVqzGi_vEsC8UeEeGnpREXOnx-fSQIkTfaqsh9HzzlXIM@cipher.nrlssc.navy.mil>
Cc: johan@herland.net, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 18 16:07:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsHHt-0003bF-4G
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 16:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab0CRPFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 11:05:04 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33381 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab0CRPFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 11:05:03 -0400
Received: by mail.nrlssc.navy.mil id o2IF3nHj004963; Thu, 18 Mar 2010 10:03:49 -0500
In-Reply-To: <m6P-Qdljqt7xCgOUC581DdkndLOwc9aVqzGi_vEsC8UeEeGnpREXOnx-fSQIkTfaqsh9HzzlXIM@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Mar 2010 15:03:48.0676 (UTC) FILETIME=[36A24840:01CAC6AC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142476>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Heh, I guess it's ok to call 'return' in a function returning
void, but it shouldn't be passed an argument. :)

-brandon


 notes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/notes.c b/notes.c
index a4f9926..07941b7 100644
--- a/notes.c
+++ b/notes.c
@@ -893,7 +893,7 @@ void remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 	assert(t->initialized);
 	hashcpy(l.key_sha1, object_sha1);
 	hashclr(l.val_sha1);
-	return note_tree_remove(t, t->root, 0, &l);
+	note_tree_remove(t, t->root, 0, &l);
 }
 
 const unsigned char *get_note(struct notes_tree *t,
-- 
1.6.6.2
