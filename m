From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH v2 05/14] Change regerror() definition from K&R style to ANSI C (C89)
Date: Fri, 21 Aug 2009 22:10:57 +0200
Message-ID: <0123e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
References: <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	Marius Storm-Olsen <mstormo@gmail.com>
To: lznuaa@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 21 22:11:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeaSG-0005JO-HK
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 22:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbZHUULL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbZHUULL
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 16:11:11 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:45756 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbZHUULK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 16:11:10 -0400
Received: by ewy3 with SMTP id 3so935658ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GyQL4ROJrbxiltkWMZfXdaxio5xar27dlVfMWp+KTs4=;
        b=JLV9VrLz+PJ4S/GFBipFCR8pE6410urSEgDlj34EibKnAH0pw8JSvB1pHXzoxqmPmu
         ehMF9oB4E6+mjzD46ENfK/b3wVAImPXwI9cJc6Wgt43t00NLfz2h2nxokTK/3nI7hD92
         4Jb8fO3IWjYFiacLCltgU9zRb3sh+8TfWSuzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JAzNjeDB3hdK2F8qKDcWP4i69U9BbN/NXjYryX7aOP6EnFUo0/6f2iErlOqOG2X5xN
         HciakRYrS5t75dogTQXY0jonrM9+pVqgCvqGNZjbD9RA0A+f5jrYXn4xAHVVGgyhhvjm
         UzBRJLcvk8UGXY2SNzo5cUDW49oerfpVnB6Ug=
Received: by 10.210.135.1 with SMTP id i1mr1959338ebd.48.1250885471197;
        Fri, 21 Aug 2009 13:11:11 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 5sm3704973eyf.58.2009.08.21.13.11.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 13:11:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126747>

From: Frank Li <lznuaa@gmail.com>

The MSVC headers typedef errcode as int, and thus confused the
compiler in the K&R style definition. ANSI style deconfuses it.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 Frank, like this one better?

 compat/regex/regex.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 5ea0075..67d5c37 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -4852,11 +4852,8 @@ regexec (preg, string, nmatch, pmatch, eflags)
    from either regcomp or regexec.   We don't use PREG here.  */
 
 size_t
-regerror (errcode, preg, errbuf, errbuf_size)
-    int errcode;
-    const regex_t *preg;
-    char *errbuf;
-    size_t errbuf_size;
+regerror(int errcode, const regex_t *preg,
+	 char *errbuf, size_t errbuf_size)
 {
   const char *msg;
   size_t msg_size;
-- 
1.6.3.msysgit.0.18.gef407
