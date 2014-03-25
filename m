From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 076/144] t5700-clone-reference.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:21 -0700
Message-ID: <1395735989-3396-77-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:30:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMky-0002q9-7t
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbaCYIal convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:30:41 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:47911 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbaCYI2B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:01 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so133720pdj.9
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=afuis7DJzUbpEHlpQ/UOq+eN4Rtz+iNl4s2VDN9x+ko=;
        b=WqJRYUZb9Ig5oYlf5gSgAm64PE840mCWx5iGuiur0DU4oa5whBXceEP2ycguoriVgi
         Ec9eAXV7zg1lVDcbpuM4SsULMQm1GzxwmwUz+t5/RFSJ9uV3QBxFhfWmi5gCTZlgNusB
         PjEBxmnf5245+AStSHKtJ3JkyTygbbfCSZU1+cMbPD6W+C1R52s1zjtjF87FMWvSRD6Z
         j06yFhom0nxpcC01nBIBNleAle/EljdQYziF5f/N6WiqdskWOSahWpwe/7y4KCDDerY9
         IqDXVTTqi6TNGStpZXxkQT4mboVEBnuiaL9FFmHd0xrNJbNQz5SRAkb/LuLSGii78Xd2
         Nj4A==
X-Received: by 10.68.224.195 with SMTP id re3mr76805886pbc.93.1395736081018;
        Tue, 25 Mar 2014 01:28:01 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244958>

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
 t/t5700-clone-reference.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 6537911..571aee4 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -6,7 +6,7 @@
 test_description=3D'test clone --reference'
 . ./test-lib.sh
=20
-base_dir=3D`pwd`
+base_dir=3D$(pwd)
=20
 U=3D$base_dir/UPLOAD_LOG
=20
--=20
1.7.10.4
