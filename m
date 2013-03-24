From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 1/3] contrib/subtree: stop explicitly using a bash shell
Date: Sun, 24 Mar 2013 19:37:41 +0000
Message-ID: <1364153863-27437-2-git-send-email-pcampbell@kemitix.net>
References: <1364153863-27437-1-git-send-email-pcampbell@kemitix.net>
Cc: greened@obbligato.org, Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 20:38:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJqkg-00016y-HK
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 20:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631Ab3CXTiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 15:38:05 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:61164 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab3CXTiD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 15:38:03 -0400
Received: by mail-we0-f181.google.com with SMTP id p43so4602532wea.40
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 12:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=TRCFzuVFDdFZtbAJHq8BLHC0GLY6Yrs1GQynN3qKDBI=;
        b=Rka3o8Ezp8h2/Hrd1WExvqi9i9XfRV+laMDyGYTXf0VlA/4O8kn5cYMF2iZUbWjE9P
         6CuKO036Zi2NGPqY7pajqMk6c2yX0Vdl3Q8sYebNZQbdx9/IV5iKYBCnrDulsYwOcfxJ
         JeRHdneY+p3QIrWya/RC9TAE+s8cYhQq7vrWV5biHCEwf8ijO+8ERts0ZN9rYJhBqBAB
         zf1odqryMGqRrXWx+wUkW9NeaPK3IUBTwYacmpnCO92fpH63xRLmSQT97OfZgW7lfIf9
         pL1FeJ1dQL4x/OJ7eUuarScQzX8SqD+4OrPPZmH3bXv6So0TMkq2eww3/ywXIkwOah0y
         KuqA==
X-Received: by 10.180.11.148 with SMTP id q20mr13258439wib.18.1364153882601;
        Sun, 24 Mar 2013 12:38:02 -0700 (PDT)
Received: from coyote.home (host-2-102-87-178.as13285.net. [2.102.87.178])
        by mx.google.com with ESMTPS id ek4sm23825220wib.11.2013.03.24.12.38.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 12:38:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364153863-27437-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQncFLXy99aBQbOlNDdD1XmErmIpFNPMkgjOMbmayzpDC9r+hn+lMjxqKixLAo9UGQaE43M1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218968>

Don't explicitly use the Bash shell but allow the system to provide a
hopefully POSIX compatible shell at /bin/sh.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---

Only the system's I was able to test this on (Debian squeeze) /bin/sh is
the dash shell.

 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8a23f58..5701376 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # git-subtree.sh: split/join git repositories in subdirectories of this one
 #
-- 
1.8.2
