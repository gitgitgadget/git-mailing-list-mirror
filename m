From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 046/144] t4038-diff-combined.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:51 -0700
Message-ID: <1395735989-3396-47-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:34:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMo7-0006ft-JM
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbaCYId6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:33:58 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34512 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbaCYI13 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:29 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so130758pdi.19
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fjMaXQXPDXYxPtSMCymHVedih3W7Z/Da7WlUnBizqDE=;
        b=WK5S0aTCAl29Ethz0NeceBuNrPvrPQm1DKjAA9nnRqF8C0Q+oKmeMcqUZ9hHd7uV3b
         ekinpXvM8wEb6p8Oog6b+JAPVX1Dwia/V0XLsmuW2JQM31PcZHOupgpQTmk/vf11iRoa
         bV4NaWGvFsSplMfZCFagJmdneowZb1SKMLO6QOjVSCpmIlPh2plOB6AqzFK/zT+GuIHY
         WQe5fUVV1cjIPs0eo7NkCHgSjVN4xqQ3sYcm/1sMBfCSaJaTYneECHXlXPD5675Hw8y8
         UovUrkEjQLv8Tey4vlD9LPDB2WlkESRp798SplR8wWnBJNKsacR1DkS2uLB2o3URf+Ns
         uA0A==
X-Received: by 10.66.226.145 with SMTP id rs17mr8517689pac.144.1395736049284;
        Tue, 25 Mar 2014 01:27:29 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244980>

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
 t/t4038-diff-combined.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 1019d7b..41913c3 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -94,7 +94,7 @@ test_expect_success 'setup for --cc --raw' '
 	blob=3D$(echo file | git hash-object --stdin -w) &&
 	base_tree=3D$(echo "100644 blob $blob	file" | git mktree) &&
 	trees=3D &&
-	for i in `test_seq 1 40`
+	for i in $(test_seq 1 40)
 	do
 		blob=3D$(echo file$i | git hash-object --stdin -w) &&
 		trees=3D"$trees$(echo "100644 blob $blob	file" | git mktree)$LF"
--=20
1.7.10.4
