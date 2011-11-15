From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/4] sha1_file: don't mix enum with int
Date: Tue, 15 Nov 2011 22:29:39 +0530
Message-ID: <1321376379-31750-5-git-send-email-artagnon@gmail.com>
References: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 18:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQMO7-0002AI-Sn
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 18:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865Ab1KORB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 12:01:29 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:32838 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab1KORB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 12:01:28 -0500
Received: by ggnb2 with SMTP id b2so7655055ggn.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 09:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OiR7EpSUpSfA5vJaENFTEvu7XgSaJgJD3EDCmZ7B5p8=;
        b=v3mMnmUdHvZG59LZfWQptvV/mTsoA3N+9qicjBhzf2lW748uAluTkRVZ0Yb8IDi0Eb
         CcncX8p9SNrLPWhEG6toMBut3t3vSFmwnC0t6CC9WYrJljvU7JPAchBR26SfewrNXjFI
         qBJh2qA/DF5zRLqi5R3l/6RVp3VYH06+9S8dU=
Received: by 10.68.15.232 with SMTP id a8mr60878603pbd.129.1321376487502;
        Tue, 15 Nov 2011 09:01:27 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id f2sm37889376pbg.14.2011.11.15.09.01.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 09:01:26 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185471>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 27f3b9b..869852b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2616,7 +2616,7 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(path, buf, size, &nbuf,
-		                   write_object ? safe_crlf : 0)) {
+		                   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
-- 
1.7.6.351.gb35ac.dirty
