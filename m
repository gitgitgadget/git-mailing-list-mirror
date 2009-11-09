From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/24] Show usage string for 'git show-index -h'
Date: Mon,  9 Nov 2009 09:04:55 -0600
Message-ID: <1257779104-23884-15-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfB-0002nn-S1
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbZKIOzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755643AbZKIOzh
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:37 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64393 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726AbZKIOze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:34 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179582ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PcTGMFsSasc3uUCk5DnaN2GQ4fSAPLAJYHe1EoqKzAY=;
        b=VBUYJH27WAF59pX2fCqr0tA+TK8IGiv9b1T5oCeR+ZA2032BKP4NhGRWpHCziVKUpd
         mrHQuZiI27l22UsDziQqiebi4j7E1Vyv0yFct6le6BYhRrnQRshuD7YKlNmXHGqKFI6B
         65JNY+oHdm7OsC4FBTZb/pBMmBbsdloJ+1Uus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l34HLn7JgvWr8m8GCChjvABftU5Oy/O4d3OObV4IuQVnD70iY7ri1a4WrYZXsfPvlJ
         mRAZkENEW05jpcDR1/ThA5OHrWE8KxZvBlez+lhtGJjwqDNlBwRREGvzZC+o4wgUqOXy
         U4roTItk6Z5ezd0uNpItnXl5lsIVPJ7si5lLo=
Received: by 10.216.93.17 with SMTP id k17mr2550267wef.31.1257778539495;
        Mon, 09 Nov 2009 06:55:39 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:38 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132474>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 show-index.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/show-index.c b/show-index.c
index 45bb535..63f9da5 100644
--- a/show-index.c
+++ b/show-index.c
@@ -1,6 +1,9 @@
 #include "cache.h"
 #include "pack.h"
 
+static const char show_index_usage[] =
+"git show-index < <packed archive index>";
+
 int main(int argc, char **argv)
 {
 	int i;
@@ -8,6 +11,8 @@ int main(int argc, char **argv)
 	unsigned int version;
 	static unsigned int top_index[256];
 
+	if (argc != 1)
+		usage(show_index_usage);
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
 		die("unable to read header");
 	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
-- 
1.6.5.2
