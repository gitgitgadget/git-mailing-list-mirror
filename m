From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 066/144] t5517-push-mirror.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:11 -0700
Message-ID: <1395735989-3396-67-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:32:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMmQ-0004ep-DT
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbaCYIcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:32:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43130 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbaCYI1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:50 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so130844pbb.33
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=i3KHKbLEaXLsaASThihPDvA9Jqnukf7vWakG3iUOdec=;
        b=LWHMkH/4DUVAwXZTwdQ6JqsgmM65t0ANKC18H20LyOlku3Ascap9HU4BQJWJ7MlIDk
         Ls08w//cPk2cDoalt4XnDQtleLXl4dddAeAZ0//JZJkxszwXEqQzdGLHqGxF2WPqshIQ
         TG34FI1XQ3eoSa1bMCWyGfa+IaQm63+NUQe/ycsCWGmZfDnML6YK2Km6FHkGPOhHqCha
         fR2Y1xAHlcuOptUjMJ3A5aAdtyrgcfH74SFHzGVswKAPjVwTekB+talpc7EN4jhbDVsx
         0o7TuLUAJVKuap+heNYQzA3KX/KNJCrqC8xWV6jQe9pDoihQ9wEUggIj9f/9kpvXnxbm
         Whjg==
X-Received: by 10.68.202.194 with SMTP id kk2mr9050087pbc.156.1395736069985;
        Tue, 25 Mar 2014 01:27:49 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244968>

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
 t/t5517-push-mirror.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index 12a5dfb..02f160a 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -4,7 +4,7 @@ test_description=3D'pushing to a mirror repository'
=20
 . ./test-lib.sh
=20
-D=3D`pwd`
+D=3D$(pwd)
=20
 invert () {
 	if "$@"; then
--=20
1.7.10.4
