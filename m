From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 025/144] t1401-symbolic-ref.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:30 -0700
Message-ID: <1395735989-3396-26-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:37:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMrA-00024D-7y
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbaCYIhC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:37:02 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:34646 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbaCYI1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:07 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so132384pbc.27
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=q9fA0sK5n/e3E3Choa8ypfjp+p9DqnhVXTCOID/3sgc=;
        b=an1QhtodW/ZY0sr5a1SR6s+/PyIONs/s9fp+vCcZg1Mi2xLHo5410mYG4zR1c7CZsD
         NeF8TOi16Qjfpsi3jjXCgGlPFntO6XXGJHYkzRmE7HBE9exuUGIDyHxl1C2LHlLahtGX
         SnrnsxqgIqbhx2TwLwUZL8nYW+oiwaT3aSqF5B86V7xGySJEv/kJlYEkD3VmhYn27TE4
         sxX2MwOjrFHIewgli/89ZsskIFaW+U+3Jvf28L6YS0DyuyIXAF/EiOauN+w/Dpqt2EHB
         PWG3BVpzl9fWwO5zKCa696MXa7YDyL/R8ZrnnFs3TNVkKj5hCH8eFTsdBnOBkpVWNU/P
         MhuA==
X-Received: by 10.66.164.36 with SMTP id yn4mr76841072pab.25.1395736027176;
        Tue, 25 Mar 2014 01:27:07 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245002>

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
 t/t1401-symbolic-ref.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 36378b0..6ea8985 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -29,7 +29,7 @@ reset_to_sane
=20
 test_expect_success 'symbolic-ref refuses bare sha1' '
 	echo content >file && git add file && git commit -m one &&
-	test_must_fail git symbolic-ref HEAD `git rev-parse HEAD`
+	test_must_fail git symbolic-ref HEAD $(git rev-parse HEAD)
 '
 reset_to_sane
=20
--=20
1.7.10.4
