From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 034/144] t3403-rebase-skip.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:39 -0700
Message-ID: <1395735989-3396-35-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMhi-0007JX-G9
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbaCYI1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:19 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:47690 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbaCYI1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:16 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so129062pad.17
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qfxGvjBuUMLTMRJY+AjspJJ3zusAiHoyR3TmeIUJBP4=;
        b=s04lGIAQlwBbyo65i54jlOJ9DOk8lD7URAo9ZWSXwnZzJ39IBwPja/w+SBpbT8BTRn
         UIeq3SDusDTzimPxx/3bbvIthvL+zNizEZVP1tX2TNA8dd66rGO3B3DAaAOfWBhNBnf3
         h8ajweGYC+ZCIYAEdEfII2wlKX/zr6Mv9QXWuX4hEZP30XAu7ck2Ak0n0onYaWxaKx2a
         B6DVB6kanKuqtPQsTtkIJk40n6eBjgghi/7SZ56ZiKteKKosqOU1gjssXstPNRfdMMoD
         ERBaAKEfHkd7n6MHTZLwMxCxRdAu/inB7xREVPKdeM8ufsrFzZxgONc31OZZMJ7gchsb
         lPkg==
X-Received: by 10.66.227.193 with SMTP id sc1mr76383320pac.102.1395736036045;
        Tue, 25 Mar 2014 01:27:16 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244918>

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
 t/t3403-rebase-skip.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 3968020..1f5122b 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -67,7 +67,7 @@ test_expect_success 'rebase --skip with --merge' '
 '
=20
 test_expect_success 'merge and reference trees equal' '
-	test -z "`git diff-tree skip-merge skip-reference`"
+	test -z "$(git diff-tree skip-merge skip-reference)"
 '
=20
 test_expect_success 'moved back to branch correctly' '
--=20
1.7.10.4
