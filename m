From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 038/144] t3905-stash-include-untracked.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:43 -0700
Message-ID: <1395735989-3396-39-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMhp-0007QX-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbaCYI1X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:23 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:55769 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbaCYI1V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:21 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so126810pdj.40
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vy5PZ3JwTOg2a5kbkYAK0/x4EStjPB681M326piWe1Q=;
        b=rCPntKSabsv906T0IyBDMaonyCMD3NWOCcuV0T14WF7L0oYUvoG0k+XgyTTBgMN8rP
         HLX1erS9H57f06Okj2E/XvpsPCZCNbEh1ecYXkrlOu9YTZCVTL6lttCjBXIXqyX6zb5o
         tAijc0FwuHEHsm5DbJrlqbVsBB6D2roI8LQMvytZ3ai6CHSTuPZ0WYrlD0n1GALnYpu7
         dyB2WKry9vQVeSYZsMBt1RM8UimbgnkipLmkDe4M0MW/k7YJzNZIY0EzwMG3Yzm4JIhK
         xoP+54GgwokyoZ7loFbxmkSHgiWSfQqhv5QKRO+7SsR01Z55hDB3toPBmEi8Ka6vxgFS
         WE7A==
X-Received: by 10.68.172.37 with SMTP id az5mr14366909pbc.139.1395736040786;
        Tue, 25 Mar 2014 01:27:20 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244919>

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
 t/t3905-stash-include-untracked.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include=
-untracked.sh
index a5e7e6b..f372fc8 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -96,8 +96,8 @@ test_expect_success 'stash pop after save --include-u=
ntracked leaves files untra
 	git stash pop &&
 	git status --porcelain >actual &&
 	test_cmp expect actual &&
-	test "1" =3D "`cat file2`" &&
-	test untracked =3D "`cat untracked/untracked`"
+	test "1" =3D "$(cat file2)" &&
+	test untracked =3D "$(cat untracked/untracked)"
 '
=20
 git clean --force --quiet -d
--=20
1.7.10.4
