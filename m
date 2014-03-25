From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 024/144] t1100-commit-tree-options.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:29 -0700
Message-ID: <1395735989-3396-25-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:37:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMrM-0002Hn-Gs
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbaCYIhT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:37:19 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:44983 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbaCYI1G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:06 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so131372pbc.16
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+xJqkOCHoiiFbubSwKpOk1y7eBVtpUTW73cT5W6PLsU=;
        b=N0iPCxeG3lS6b446VkrTP+N5469DgEMZ7o62tRFrZpan0zMbDs1vxlAtsPMUa/3DPR
         8PRF117GlqG0z6fHpQLHDvDX83s2uVSkpHattGwB+frC3AzsHX5763mrXG/Dv4Rsjv43
         e2d6K0P7Ps1hmgNAcag93V9u4WXCOl4qV/CTJqXUW9cSYRk6Guz7Tkv2Zc0RbvJOivrP
         Xe7We6n8TvjYi0m/6rCftmQAvx+P31hNyMfJKzvegwLBYlGO0oLWXOewZi9wNxnwLei1
         4zm24CPCVnqmWX0uvziyWfiWKTlV9IPFubJ4vXnqeJ2Om7l9RnrK5eEynvgPq6ZutxMj
         UGtg==
X-Received: by 10.66.156.137 with SMTP id we9mr77889960pab.30.1395736026041;
        Tue, 25 Mar 2014 01:27:06 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245004>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t1100-commit-tree-options.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-optio=
ns.sh
index f8457f9..b7e9b4fc 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -35,11 +35,11 @@ test_expect_success \
      GIT_COMMITTER_NAME=3D"Committer Name" \
      GIT_COMMITTER_EMAIL=3D"committer@email" \
      GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
-     TZ=3DGMT git commit-tree `cat treeid` >commitid 2>/dev/null'
+     TZ=3DGMT git commit-tree $(cat treeid) >commitid 2>/dev/null'
=20
 test_expect_success \
     'read commit' \
-    'git cat-file commit `cat commitid` >commit'
+    'git cat-file commit $(cat commitid) >commit'
=20
 test_expect_success \
     'compare commit' \
--=20
1.7.10.4
