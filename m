From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 05/14] Change regerror() declaration from K&R style to ANSI C (C89)
Date: Fri, 21 Aug 2009 15:30:37 +0200
Message-ID: <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUEB-00012X-1o
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbZHUNbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbZHUNbo
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:44 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:32856 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbZHUNbI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:08 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so637034ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Qj+Zgla75kE7fY5eRfDiJP6Ddi3vv8QTByMryGcbkF8=;
        b=gyvPYzQXSW0MEnPY/o/7N1l1KIN2w8v5QLg5S/3mlAjwxxFiU6E6CGaGkDSQhHYv/v
         vVj0Kq/KBnCtWyLOTc/03bPwzlNpMpQHB2XRKbTLYBsg9DO6wZq6apCwLT0lIFGBvZwO
         w/XGNzhoLTOOlO6kuptImh6nGP64AWLNUOi0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nouQszD4QowSF5W3LBAQGpNwAdrc9cFeSKWwn/4MOEj51reUqIapv9fpIpJl1jmRIx
         4qh7wXV2mn/EvlylX0BmoDLOWkHnr2Q/EkqFq36znNmczNDDZyZM2wv/BH/kSG1a2S9u
         Mkf4WYA7IUSgZtHgbzPOfWot4MPpsN3lHoMsA=
Received: by 10.210.41.10 with SMTP id o10mr1484799ebo.70.1250861470020;
        Fri, 21 Aug 2009 06:31:10 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126723>

From: Frank Li <lznuaa@gmail.com>

The MSVC compiler doesn't like K&R style.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
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
