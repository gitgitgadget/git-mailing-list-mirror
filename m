From: David Michael <fedora.dm0@gmail.com>
Subject: [PATCH 4/4] Declare that HP NonStop systems require strings.h
Date: Fri, 14 Dec 2012 14:57:04 -0500
Message-ID: <CAEvUa7mSOe6gs8JqkewYV=CXt78Y68nTFbFEfEOuCzaV5-DO8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 20:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjbNu-0006fe-QQ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 20:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256Ab2LNT5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 14:57:06 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:58000 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab2LNT5F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 14:57:05 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so4499282vby.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 11:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=kVMax3UaTyHyVDjio9jaq1rEuJjqqg+8NHqObUcGcOY=;
        b=Q9JLuACsHjocGC/iuFftJZ1g0mt23Lj6RHa/Z8XuYn1svmFSUvhsPGXMPjb8ITR8jl
         T7+Sn4xivBcQGLqkia/UbUZMhi94sUZ7K6ndnM6wZXuod8yEJlE8GAs3i2hSTthOYZQw
         gMjtpofKh6FZ1zsiTl3bD3UDjiYA23es54Wf7X6gMqtJsuIP2W1iWuDYlYIXbCtCQJYT
         oUoZCbaHQqnSZoICpepDbCsRG2VjrbDRYsVfANEGG9tgfUphuigpbSXa2TAMRemYZJ8R
         59yNpaAyqMqCSP04RWks1lHMERiYc3/A3Lbz+AXmBEXqkboTeRPUHQaA2v2lQVHzYok0
         pKnQ==
Received: by 10.52.176.202 with SMTP id ck10mr3400835vdc.42.1355515024977;
 Fri, 14 Dec 2012 11:57:04 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Fri, 14 Dec 2012 11:57:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211503>

This platform previously included strings.h automatically.  However, the
build system now requires an explicit option to do so.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index fb78f7f..e84b0cb 100644
--- a/Makefile
+++ b/Makefile
@@ -1357,6 +1357,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
     # Added manually, see above.
     NEEDS_SSL_WITH_CURL = YesPlease
     HAVE_LIBCHARSET_H = YesPlease
+    HAVE_STRINGS_H = YesPlease
     NEEDS_LIBICONV = YesPlease
     NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
     NO_SYS_SELECT_H = UnfortunatelyYes
--
1.7.11.7
