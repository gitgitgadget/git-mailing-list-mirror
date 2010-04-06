From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] notes.h: declare bit field as unsigned to silence compiler complaints
Date: Tue,  6 Apr 2010 10:11:44 -0500
Message-ID: <pIMfUMS04cynaZmaHBNeBVGGMD789MBMOhj6YUu46YwbNLLHfoeciOmaLmNtocB_WbS14hwuQVI@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 06 17:12:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzASI-00023T-UX
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 17:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab0DFPMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 11:12:38 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38522 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab0DFPMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 11:12:37 -0400
Received: by mail.nrlssc.navy.mil id o36FBujD022527; Tue, 6 Apr 2010 10:11:56 -0500
X-OriginalArrivalTime: 06 Apr 2010 15:11:56.0574 (UTC) FILETIME=[7F4ADBE0:01CAD59B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144146>

From: Brandon Casey <drafnel@gmail.com>

The IRIX MIPSPro compiler complains like this:

   cc-1107 c99: WARNING File = notes.h, Line = 215
     A signed bit field has a length of 1 bit.

           int suppress_default_notes:1;
               ^

'unsigned' is what was intended, so lets make it so.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 notes.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/notes.h b/notes.h
index ee65bd1..9f59277 100644
--- a/notes.h
+++ b/notes.h
@@ -212,7 +212,7 @@ void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 struct string_list;
 
 struct display_notes_opt {
-	int suppress_default_notes:1;
+	unsigned int suppress_default_notes:1;
 	struct string_list *extra_notes_refs;
 };
 
-- 
1.6.6.2
