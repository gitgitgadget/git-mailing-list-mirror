From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 085/144] t6132-pathspec-exclude.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:30 -0700
Message-ID: <1395735989-3396-86-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:29:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMk6-0001o2-FO
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbaCYI2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:13 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:51846 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbaCYI2L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:11 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so134314pbb.11
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GOmYKbWRsowWGULApmSwWsDmWhyuRKfJs6Vg89uowGM=;
        b=B8IGOxruCb/qgor7u1KVPNwczuTpBK7Jk5d170baniQybxT0tQaDdxdsdyg6KUHSQL
         3ejvQKeVE83mwL4hK66zrTzyWJmjGx6ohxbFQ3l4zvaGN2VXIIGz8bEeD1OsNnc4RSiN
         N48xe1gzdDXX7nbfyZykhj0BP11XAblypTno0l33b4SqsjkdwfE+mUbjEXAVHemju8TJ
         2Hepm6KAMOsq9weFs/UePSqM0gXEzpJ/D20Ff8AnlaQMBuhiZwW78ezCRZLoZDPNV6S/
         lrmTpvi6VQGd1gDEM0vYdz1L1sx3cDTPLp4CdAmEaqWEWXgrnfRn9Tb8dkWnDhvFpyFL
         r0Nw==
X-Received: by 10.66.233.99 with SMTP id tv3mr22943739pac.97.1395736090289;
        Tue, 25 Mar 2014 01:28:10 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244951>

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
 t/t6132-pathspec-exclude.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 62049be..801afae 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -7,7 +7,7 @@ test_description=3D'test case exclude pathspec'
 test_expect_success 'setup' '
 	for p in file sub/file sub/sub/file sub/file2 sub/sub/sub/file sub2/f=
ile; do
 		if echo $p | grep /; then
-			mkdir -p `dirname $p`
+			mkdir -p $(dirname $p)
 		fi &&
 		: >$p &&
 		git add $p &&
--=20
1.7.10.4
