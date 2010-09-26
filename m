From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 09/15] t5602 (clone-remote-exec): add missing &&
Date: Sun, 26 Sep 2010 17:14:33 -0600
Message-ID: <1285542879-16381-10-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00Pw-0005ch-KL
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758334Ab0IZXNY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:24 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37370 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758249Ab0IZXNV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:21 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1087690pvg.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vq+e950ZSBzGo7SJRkohqoxBX4C7f//PufOQgrY0Dcg=;
        b=fr0MpMt5pNMJptiGz6PFzXC/AVQcjpwQat6IsjXhMIJKpTszj+yb1RxYIqk4uJVdPy
         8Jb2D0X9LDetLYbLT6qvLKJDZo4ZK/vOFQ/dbNS0v4qTWbDDY4C7wIJ0fUOC+R4iOL38
         8Z52jFoxaIpXViRJULy7T5XFzUX9Sw7rFkhY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FkkJWhYx4tV7pKuog2SblLVHF85jyEvaNMK4QsDj4M+D8mReADv9QzNWFC7hstRItE
         W1P3QrIJIO6dRXhsDN2T/DPCIHFnccctcCIkk8oUl/cwDld7hNS04zvFxrFGNxunnlVh
         YqQXfvfRmb2yEJcNFJzNSsIVwr0ZLkL32rv5E=
Received: by 10.114.74.7 with SMTP id w7mr7382511waa.3.1285542801531;
        Sun, 26 Sep 2010 16:13:21 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157273>

Also add a couple test_must_fail invocations where needed.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5602-clone-remote-exec.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.s=
h
index deffdae..6aa6e0d 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -5,21 +5,21 @@ test_description=3Dclone
 . ./test-lib.sh
=20
 test_expect_success setup '
-	echo "#!/bin/sh" > not_ssh
-	echo "echo \"\$*\" > not_ssh_output" >> not_ssh
-	echo "exit 1" >> not_ssh
+	echo "#!/bin/sh" > not_ssh &&
+	echo "echo \"\$*\" > not_ssh_output" >> not_ssh &&
+	echo "exit 1" >> not_ssh &&
 	chmod +x not_ssh
 '
=20
 test_expect_success 'clone calls git upload-pack unqualified with no -=
u option' '
-	GIT_SSH=3D./not_ssh git clone localhost:/path/to/repo junk
-	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected
+	GIT_SSH=3D./not_ssh test_must_fail git clone localhost:/path/to/repo =
junk &&
+	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
=20
 test_expect_success 'clone calls specified git upload-pack with -u opt=
ion' '
-	GIT_SSH=3D./not_ssh git clone -u ./something/bin/git-upload-pack loca=
lhost:/path/to/repo junk
-	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''=
" >expected
+	GIT_SSH=3D./not_ssh test_must_fail git clone -u ./something/bin/git-u=
pload-pack localhost:/path/to/repo junk &&
+	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''=
" >expected &&
 	test_cmp expected not_ssh_output
 '
=20
--=20
1.7.3.95.g14291
