From: David Rientjes <rientjes@google.com>
Subject: [PATCH] remove inline iteration variable
Date: Tue, 15 Aug 2006 10:23:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608151022340.26891@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 15 19:23:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD2dS-0001ZH-9s
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 19:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWHORXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 13:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWHORXV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 13:23:21 -0400
Received: from smtp-out.google.com ([216.239.45.12]:31956 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030415AbWHORXU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 13:23:20 -0400
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id k7FHNKpn015957
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 10:23:20 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=AFoR6u3L26P3ShCLZrysfFV0v8PfU5T6JohndfqvPM8vXV5wRPfDvTZqnnn+1QZx5
	JPDBrGeGMWZ0TQbF0TWtA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps76.corp.google.com with ESMTP id k7FHNJgH008387
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 10:23:19 -0700
Received: by localhost (Postfix, from userid 24081)
	id 385C087D71; Tue, 15 Aug 2006 10:23:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 35C3487D70
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 10:23:19 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25468>

Remove unnecessary iteration variable in inline.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-grep.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 93b7e07..6476fe1 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -176,8 +176,8 @@ static void compile_regexp(struct grep_p
 #if DEBUG
 static inline void indent(int in)
 {
-	int i;
-	for (i = 0; i < in; i++) putchar(' ');
+	for (; in > 0; in--)
+		putchar(' ');
 }
 
 static void dump_pattern_exp(struct grep_expr *x, int in)
-- 
1.4.2.rc4.gf615-dirty
