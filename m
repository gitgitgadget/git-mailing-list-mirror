From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 09/14] Avoid including windows.h in winansi.c for MSVC build
Date: Fri, 21 Aug 2009 15:30:41 +0200
Message-ID: <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
 <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
 <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com>
 <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
 <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:32:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUE3-00012X-SQ
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbZHUNbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755287AbZHUNbP
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:15 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:57834 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbZHUNbN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:13 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so637048ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=qX5rOB8v8SZIaUgJI+wmCAYia1cwiOY0hQJbcXn5mQ0=;
        b=dszbwOmaPRl4MNMCu5OVeWIv6oH/dnIA2JMF0RyANcj21tRsYSUKWcYgoLjCvQjVaL
         l9KNwFvsvR+qz4287DLB3WcecgaDlUZbG3zg0g5iqdz6DbhCrU6BN7idSCcgynl9KsQA
         BOc6L3iSCtlb3pooAJ/BgOUq0WgGM1uiLp16U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mXP1S93a2I1FvkHRZ/TVZFozy98m/4LLi24dtOQfUM/sLe24XMnaB1VSCnuH4m1ODL
         DBc06zEJh1q3wuLkBngEqqFeoOqnaWVxfRLmcD0BYTyEQ0pUQulKGEPvgc0B3vACajgG
         i7EvRqvxHyFzAenNCabOJ4+NI8J9Kzyye/oOo=
Received: by 10.210.62.4 with SMTP id k4mr1214849eba.25.1250861474721;
        Fri, 21 Aug 2009 06:31:14 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126714>

From: Frank Li <lznuaa@gmail.com>

compat/msvc.h includes winsock2.h which conflicts with windows.h.
msvc.h also defines the oldest Windows API version required.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/winansi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 9217c24..0d79845 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -2,7 +2,9 @@
  * Copyright 2008 Peter Harris <git@peter.is-a-geek.org>
  */
 
+#ifndef _MSC_VER
 #include <windows.h>
+#endif
 #include "../git-compat-util.h"
 
 /*
-- 
1.6.3.msysgit.0.18.gef407
