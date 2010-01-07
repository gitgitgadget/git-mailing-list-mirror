From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH] mingw: enable NO_PYTHON
Date: Thu,  7 Jan 2010 22:52:39 +0100
Message-ID: <1262901159-1436-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Jan 07 22:53:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT0I5-0000ci-Of
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 22:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794Ab0AGVxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 16:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435Ab0AGVxF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 16:53:05 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:35406 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab0AGVxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 16:53:01 -0500
Received: by ewy19 with SMTP id 19so11287636ewy.21
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 13:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=551UQFEhuGEj+rORzKAMCFs3MnfIx85pg/Pq383fDYc=;
        b=mPJdCW9UkBihCg9mRWa70gwaFJy0oSUzRfou3IfcvfkV26ca/yDdcNXkqsIFdxU21r
         aGJmRTOBGV9A/H4i3eE3B+1pKQG65gXM9X8OmbCrgGV460a+9F48VB01r0dKihw944xv
         3Xnlg8fMgjfIt9zDMMkD/cdp0vPt45g+yr0mA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qdgwP8VpQAZGfYcLJBd61wLVmW/00YC3ZK3c331dPhIkGpj4vq/PMZa1xLSTK3Fh7B
         Mrtz1v2YQXQfHFVmiS753YghgmbfzUfZr8cJjfX7xzQloRhcnUv8lbM47IAKjgHOkEvR
         0Dzvxx0wlMCaXUZXKxttbsonwcQSrZNkx8RK8=
Received: by 10.213.100.168 with SMTP id y40mr3087016ebn.28.1262901180360;
        Thu, 07 Jan 2010 13:53:00 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 15sm15414106ewy.4.2010.01.07.13.52.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 13:52:59 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1372.g025e4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136388>

Python is not commonly installed on Windows machines, so
we should disable it there by default.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

This patch is against Junio's current master, and enables
msysgit to compile upstream git again after Sverre's addition
of the python remote-helpers (2fe40b6).

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 1c7668a..a2780a2 100644
--- a/Makefile
+++ b/Makefile
@@ -1028,6 +1028,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	BLK_SHA1 = YesPlease
 	NO_INET_PTON = YesPlease
 	NO_INET_NTOP = YesPlease
+	NO_PYTHON = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o
-- 
1.6.6.95.g82b1b.dirty
