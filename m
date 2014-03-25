From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 101/144] t9105-git-svn-commit-diff.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:46 -0700
Message-ID: <1395735989-3396-102-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:29:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMjN-0000rO-2W
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbaCYI2w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:52 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:50145 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaCYI21 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:27 -0400
Received: by mail-pa0-f52.google.com with SMTP id rd3so126582pab.25
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TMZdVbXmUPWlMMBL83qNT+tj2QP17wGxT6C2JPkfWMA=;
        b=bXb61V4q1PN43ZUc8fkmGtOzE3d6z7D9kykUXOmd+Fz3CV7UKcV/sc7m/fzyYeFH/z
         Ke9VkXUuR+dV0XrHUe8AHFxZP/9VFhFMpKxsSPwzYWzfftNTZCm0/5UY9hFmQx5LTfhY
         HJ+qBnZupMzirfpQa4fChfA7Cj2oTFPrXHIlL27mq/gf15MmRZYt20BsHQxBdrH3mUGw
         KfIR2nB6hSu2XDz3v+vzZkTG/JDQAkOiKgWh0sdntqP2ewCxCvO7N1AGSNgdUn4gHuvk
         shSSyCfUzi2oKo5sjk2K6fzhY/3/iJnEoaVYRmWnqA+NcFMssC7xmph7jjC5JgaV1t6C
         4JOw==
X-Received: by 10.68.90.132 with SMTP id bw4mr14312773pbb.136.1395736107129;
        Tue, 25 Mar 2014 01:28:27 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244944>

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
 t/t9105-git-svn-commit-diff.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-di=
ff.sh
index 5d0afea..6ed5f74 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -18,8 +18,8 @@ test_expect_success 'initialize repo' '
 	git commit -a -m "another"
 	'
=20
-head=3D`git rev-parse --verify HEAD^0`
-prev=3D`git rev-parse --verify HEAD^1`
+head=3D$(git rev-parse --verify HEAD^0)
+prev=3D$(git rev-parse --verify HEAD^1)
=20
 # the internals of the commit-diff command are the same as the regular
 # commit, so only a basic test of functionality is needed since we've
--=20
1.7.10.4
