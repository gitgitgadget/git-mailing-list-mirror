From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 049/144] t4119-apply-config.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:54 -0700
Message-ID: <1395735989-3396-50-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMi2-0007gS-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbaCYI1f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:35 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:56963 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbaCYI1c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:32 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so130720pdb.28
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V+6YOva5AiAUdvcbP3cYRvMz5WUXTv9lexCuwmPLy1E=;
        b=xAYS1/BR6ZPU1zrdvDVQ01iKPI26d1rWAze/kYU9OU/UxWS2vaysedbPFDY5PBT2QH
         TPPIlPuIq+uI1ouZR8sygzwKHL87gLHb2FRvp7XNw6/sg3uCmjeExUJZAib1sc6PrSyf
         2W4kKvqJInmMYOVcDH18VXIM3Wy2bVniKPqqyDWbVdJ3ar3ecdeOWiKzzg5sXHZhBK7n
         w+vJd/wOdmZ0kErQXhYCqPsfD4ed5zMgp4z+Sz2Qpcitb4gDcgDABG745GH29+iJSll5
         Me0YMF9RcxDOsWNW7a1+2VROBi9mB/rxDOO7cm6bktfUTCDfmK+9kfXIaeO9tnM/nkS0
         Rpnw==
X-Received: by 10.68.212.10 with SMTP id ng10mr78390493pbc.95.1395736052229;
        Tue, 25 Mar 2014 01:27:32 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244923>

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
 t/t4119-apply-config.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index 3d0384d..c393be6 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -68,7 +68,7 @@ test_expect_success 'apply --whitespace=3Dstrip from =
config' '
 	check_result sub/file1
 '
=20
-D=3D`pwd`
+D=3D$(pwd)
=20
 test_expect_success 'apply --whitespace=3Dstrip in subdir' '
=20
--=20
1.7.10.4
