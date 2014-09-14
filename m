From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] compat-util: add _DEFAULT_SOURCE define
Date: Sun, 14 Sep 2014 14:33:35 +0900
Message-ID: <1410672815-2555-1-git-send-email-sergey.senozhatsky@gmail.com>
Cc: git@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 07:34:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT2Rs-0001GF-OQ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 07:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbaINFd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 01:33:59 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:60449 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbaINFd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 01:33:58 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so4207405pab.32
        for <git@vger.kernel.org>; Sat, 13 Sep 2014 22:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VBjcwU4X6mTEpeZdH+/7RwBU1bNgaBgxl8jWwpZvKY4=;
        b=h4pzuAT3mSRb8CxxovEHOfXyDAOMNK1ftsWCSYUzsawx8Qi0uiOWZxv/28aX0N02NM
         aNM3V1iozNLbpa5HyBaH03S39Fspw+fjLQrkE5jvvaFFMc+HpLL9dEq6RrMqoaVmrVw0
         vPR8T55KFvUqqr51ilAMT/tXkXQQkeAXHDX5yIbop5MCKv6N8roda1BDnYxI0UhnfnZv
         mnGbXHEPAIw3uPDOixBoT+mtleKriIpt1xrnoy5DWv9q95TzWvAB5o8b4m7KMrzpLFvz
         bnoIIDYWttsVZKoQmNdEd46EfaVJm93u98uCKbO3fBvOJybY0htnWfW9bXzEHM+rbF3Y
         8dRA==
X-Received: by 10.68.131.163 with SMTP id on3mr28565203pbb.38.1410672838289;
        Sat, 13 Sep 2014 22:33:58 -0700 (PDT)
Received: from swordfish.localdomain ([112.168.75.135])
        by mx.google.com with ESMTPSA id fh10sm7902602pdb.71.2014.09.13.22.33.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Sep 2014 22:33:57 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.350.g8b25fe0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256994>

glibc has deprecated the use of _BSD_SOURCE define

  warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"

To make it easier to maintain a cross platform source code, that
warning can be suppressed by _DEFAULT_SOURCE.

Define both _BSD_SOURCE, _DEFAULT_SOURCE and cleanup the build.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 git-compat-util.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4e7e3f8..08a9ee2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -82,6 +82,7 @@
 #define _ALL_SOURCE 1
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
+#define _DEFAULT_SOURCE 1
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
-- 
2.1.0.350.g8b25fe0
