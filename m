From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] t1500: more 'git rev-parse --git-dir' tests
Date: Sat, 14 Feb 2009 17:16:29 +0100
Message-ID: <1234628189-3635-2-git-send-email-szeder@ira.uka.de>
References: <1234628189-3635-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 17:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYNF1-0002Cu-Ol
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 17:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbZBNQQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 11:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbZBNQQj
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 11:16:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:62881 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbZBNQQj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 11:16:39 -0500
Received: from [127.0.1.1] (p5B130271.dip0.t-ipconnect.de [91.19.2.113])
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis)
	id 0MKxQS-1LYNBw2m5x-0002NC; Sat, 14 Feb 2009 17:16:35 +0100
X-Mailer: git-send-email 1.6.2.rc0.111.g246ed
In-Reply-To: <1234628189-3635-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1/HgNdiXIwwxoSQaaBANRHWtSkDuBFaWwY+2Gs
 Fk5tpckxb02IQa+jVxhFOpD/oXNm377MkrleVEWIrFVEicMqfn
 a1CaGLJNus4Di/CRCyOug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109878>

Extend t1500 with tests of 'git rev-parse --git-dir' when invoked from
other directories of the repository or the work tree.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

  In a separate commit to clearly indicate which test was moved and
  which ones are new.

 t/t1500-rev-parse.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 186792e..48ee077 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -37,17 +37,17 @@ test_rev_parse() {
=20
 ROOT=3D$(pwd)
=20
-test_rev_parse toplevel false false true ''
+test_rev_parse toplevel false false true '' .git
=20
 cd .git || exit 1
-test_rev_parse .git/ false true false ''
+test_rev_parse .git/ false true false '' .
 cd objects || exit 1
 test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
 cd ../.. || exit 1
=20
 mkdir -p sub/dir || exit 1
 cd sub/dir || exit 1
-test_rev_parse subdirectory false false true sub/dir/
+test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git"
 cd ../.. || exit 1
=20
 git config core.bare true
--=20
1.6.2.rc0.81.g79856
