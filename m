From: =?UTF-8?q?Maur=C3=ADcio=20C=20Antunes?= 
	<mauricio.antunes@gmail.com>
Subject: [PATCH] hg-to-git: --allow-empty-message in git commit
Date: Sat, 20 Jul 2013 13:33:20 -0300
Message-ID: <1374338000-5043-1-git-send-email-mauricio.antunes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stelian Pop <stelian@popies.net>,
	=?UTF-8?q?Maur=C3=ADcio=20C=20Antunes?= 
	<mauricio.antunes@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 18:40:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0aCs-000096-DN
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 18:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab3GTQk0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 12:40:26 -0400
Received: from mail-ye0-f181.google.com ([209.85.213.181]:53360 "EHLO
	mail-ye0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab3GTQkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 12:40:25 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jul 2013 12:40:25 EDT
Received: by mail-ye0-f181.google.com with SMTP id g12so1607856yee.26
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=OwqBnZQFWd6UrFwq+6v8U/VFY8s79r6ThlHi2JOko80=;
        b=SZeChibAYbhYrQ9k9GZIvKP/qgthbSgM1dEKKXBtShvqnjvxaNz0f+Vuk5RY15pk/1
         W4VC4bQ7W7Qopm/06FVZRKRjTh+xjcKiiNXFD1I5RW6WULt7Ti4Cw5aM2QxlK+LHlRtz
         eEIS3gLgCrgnz1W9y+kcB1qG4esd/Jo9Qx1arFB/J+dqmdmk8DyMhWxh0iN9Uem/hrE0
         14Wm4AoazWUM1LXv5YY7QJkwsP30KTlA5fe3t0XojBkZ6KMDaQN0vLHlvnu9a6xm96LD
         4tbLi0rFbUHKnQG6NUa/GM1v1SDkUspbluQEcDTH0aUR24quGKJhVKFHp2nQee4F7kjS
         WXpQ==
X-Received: by 10.236.155.105 with SMTP id i69mr10993481yhk.159.1374338019697;
        Sat, 20 Jul 2013 09:33:39 -0700 (PDT)
Received: from localhost.localdomain ([187.39.191.10])
        by mx.google.com with ESMTPSA id a62sm28615945yhk.4.2013.07.20.09.33.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 09:33:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230899>

Do not fail to import mercurial commits with empty commit messages.

Signed-off-by: Maur=C3=ADcio C Antunes <mauricio.antunes@gmail.com>
---
 contrib/hg-to-git/hg-to-git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-g=
it.py
index 232625a..60dec86 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -225,7 +225,7 @@ for cset in range(int(tip) + 1):
     os.system('git ls-files -x .hg --deleted | git update-index --remo=
ve --stdin')
=20
     # commit
-    os.system(getgitenv(user, date) + 'git commit --allow-empty -a -F =
%s' % filecomment)
+    os.system(getgitenv(user, date) + 'git commit --allow-empty --allo=
w-empty-message -a -F %s' % filecomment)
     os.unlink(filecomment)
=20
     # tag
--=20
1.8.3.3
