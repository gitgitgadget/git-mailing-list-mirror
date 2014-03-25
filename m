From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 078/144] t5900-repo-selection.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:23 -0700
Message-ID: <1395735989-3396-79-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:32:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMm4-0004DJ-Mb
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbaCYIaj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:30:39 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:41396 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbaCYI2D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:03 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so123976pab.40
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sXmRsFX5xqcK4tS5tuBd4H1ndppYPDqqRq34b7tlMko=;
        b=iRSRvxQLcaQMNuKi9Fkxmd+OHeFkGulLtbuiz0VG53D15LvxwnJQwu+BeqW2Q0U4QZ
         kVw/R2xhMKvVuUKex4BjIgIqv0pbhe82PheI9u4xQso+6JXcIjvx40PxiNL8toO1Phqu
         BQCR3npj1HI1wwaqYS+/rBXZTLZYpV3X9VVVjLaMBnhJd77tYbk0WDQ+6f3njlB7n79S
         uaS40kFl6YtR/vwRZLGIUIXl8VFysBUwPS9vzqnZouXhxPs9YAyL6B3vwOtvaqLo+TCT
         LMzdH4Ysy2gLFox7DGCBLPYl6eaPR4ATyGCszNooh/z6/6eOdt7l30dVMzbLGYN8g+Ps
         kz/w==
X-Received: by 10.66.144.200 with SMTP id so8mr78159931pab.15.1395736082912;
        Tue, 25 Mar 2014 01:28:02 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244964>

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
 t/t5900-repo-selection.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5900-repo-selection.sh b/t/t5900-repo-selection.sh
index 3d5b418..14e59c5 100755
--- a/t/t5900-repo-selection.sh
+++ b/t/t5900-repo-selection.sh
@@ -15,7 +15,7 @@ make_tree() {
 make_bare() {
 	git init --bare "$1" &&
 	(cd "$1" &&
-	 tree=3D`git hash-object -w -t tree /dev/null` &&
+	 tree=3D$(git hash-object -w -t tree /dev/null) &&
 	 commit=3D$(echo "$1" | git commit-tree $tree) &&
 	 git update-ref HEAD $commit
 	)
--=20
1.7.10.4
