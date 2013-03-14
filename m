From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] t2003: modernize style
Date: Thu, 14 Mar 2013 20:00:50 +0000
Message-ID: <faa93685db024ab3ab196093bc72100cd488ad5f.1363291173.git.john@keeping.me.uk>
References: <7vehfhyjgv.fsf@alter.siamese.dyndns.org>
 <cover.1363291173.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 21:01:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGELT-0003Hw-FM
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 21:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426Ab3CNUBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 16:01:20 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:38506 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab3CNUBT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 16:01:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 6FE58161E53A;
	Thu, 14 Mar 2013 20:01:19 +0000 (GMT)
X-Quarantine-ID: <4UWBRw4ETiWh>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4UWBRw4ETiWh; Thu, 14 Mar 2013 20:01:19 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A60BF161E529;
	Thu, 14 Mar 2013 20:01:07 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.rc2.4.g7799588
In-Reply-To: <cover.1363291173.git.john@keeping.me.uk>
In-Reply-To: <cover.1363291173.git.john@keeping.me.uk>
References: <cover.1363291173.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218162>

- Description goes on the test_expect_* line
- Open SQ of test goes on the test_expect_* line
- Closing SQ of test goes on its own line
- Use TAB for indent

Also remove three comments that appear to relate to the development of
the patch before it was committed.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t2003-checkout-cache-mkdir.sh | 143 ++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 73 deletions(-)

diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index 02a4fc5..63fd0a8 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -12,85 +12,82 @@ the GIT controlled paths.
 
 . ./test-lib.sh
 
-test_expect_success \
-    'setup' \
-    'mkdir path1 &&
-    echo frotz >path0 &&
-    echo rezrov >path1/file1 &&
-    git update-index --add path0 path1/file1'
+test_expect_success 'setup' '
+	mkdir path1 &&
+	echo frotz >path0 &&
+	echo rezrov >path1/file1 &&
+	git update-index --add path0 path1/file1
+'
 
-test_expect_success SYMLINKS \
-    'have symlink in place where dir is expected.' \
-    'rm -fr path0 path1 &&
-     mkdir path2 &&
-     ln -s path2 path1 &&
-     git checkout-index -f -a &&
-     test ! -h path1 && test -d path1 &&
-     test -f path1/file1 && test ! -f path2/file1'
+test_expect_success SYMLINKS 'have symlink in place where dir is expected.' '
+	rm -fr path0 path1 &&
+	mkdir path2 &&
+	ln -s path2 path1 &&
+	git checkout-index -f -a &&
+	test ! -h path1 && test -d path1 &&
+	test -f path1/file1 && test ! -f path2/file1
+'
 
-test_expect_success \
-    'use --prefix=path2/' \
-    'rm -fr path0 path1 path2 &&
-     mkdir path2 &&
-     git checkout-index --prefix=path2/ -f -a &&
-     test -f path2/path0 &&
-     test -f path2/path1/file1 &&
-     test ! -f path0 &&
-     test ! -f path1/file1'
+test_expect_success 'use --prefix=path2/' '
+	rm -fr path0 path1 path2 &&
+	mkdir path2 &&
+	git checkout-index --prefix=path2/ -f -a &&
+	test -f path2/path0 &&
+	test -f path2/path1/file1 &&
+	test ! -f path0 &&
+	test ! -f path1/file1
+'
 
-test_expect_success \
-    'use --prefix=tmp-' \
-    'rm -fr path0 path1 path2 tmp* &&
-     git checkout-index --prefix=tmp- -f -a &&
-     test -f tmp-path0 &&
-     test -f tmp-path1/file1 &&
-     test ! -f path0 &&
-     test ! -f path1/file1'
+test_expect_success 'use --prefix=tmp-' '
+	rm -fr path0 path1 path2 tmp* &&
+	git checkout-index --prefix=tmp- -f -a &&
+	test -f tmp-path0 &&
+	test -f tmp-path1/file1 &&
+	test ! -f path0 &&
+	test ! -f path1/file1
+'
 
-test_expect_success \
-    'use --prefix=tmp- but with a conflicting file and dir' \
-    'rm -fr path0 path1 path2 tmp* &&
-     echo nitfol >tmp-path1 &&
-     mkdir tmp-path0 &&
-     git checkout-index --prefix=tmp- -f -a &&
-     test -f tmp-path0 &&
-     test -f tmp-path1/file1 &&
-     test ! -f path0 &&
-     test ! -f path1/file1'
+test_expect_success 'use --prefix=tmp- but with a conflicting file and dir' '
+	rm -fr path0 path1 path2 tmp* &&
+	echo nitfol >tmp-path1 &&
+	mkdir tmp-path0 &&
+	git checkout-index --prefix=tmp- -f -a &&
+	test -f tmp-path0 &&
+	test -f tmp-path1/file1 &&
+	test ! -f path0 &&
+	test ! -f path1/file1
+'
 
-# Linus fix #1
-test_expect_success SYMLINKS \
-    'use --prefix=tmp/orary/ where tmp is a symlink' \
-    'rm -fr path0 path1 path2 tmp* &&
-     mkdir tmp1 tmp1/orary &&
-     ln -s tmp1 tmp &&
-     git checkout-index --prefix=tmp/orary/ -f -a &&
-     test -d tmp1/orary &&
-     test -f tmp1/orary/path0 &&
-     test -f tmp1/orary/path1/file1 &&
-     test -h tmp'
+test_expect_success SYMLINKS 'use --prefix=tmp/orary/ where tmp is a symlink' '
+	rm -fr path0 path1 path2 tmp* &&
+	mkdir tmp1 tmp1/orary &&
+	ln -s tmp1 tmp &&
+	git checkout-index --prefix=tmp/orary/ -f -a &&
+	test -d tmp1/orary &&
+	test -f tmp1/orary/path0 &&
+	test -f tmp1/orary/path1/file1 &&
+	test -h tmp
+'
 
-# Linus fix #2
-test_expect_success SYMLINKS \
-    'use --prefix=tmp/orary- where tmp is a symlink' \
-    'rm -fr path0 path1 path2 tmp* &&
-     mkdir tmp1 &&
-     ln -s tmp1 tmp &&
-     git checkout-index --prefix=tmp/orary- -f -a &&
-     test -f tmp1/orary-path0 &&
-     test -f tmp1/orary-path1/file1 &&
-     test -h tmp'
+test_expect_success SYMLINKS 'use --prefix=tmp/orary- where tmp is a symlink' '
+	rm -fr path0 path1 path2 tmp* &&
+	mkdir tmp1 &&
+	ln -s tmp1 tmp &&
+	git checkout-index --prefix=tmp/orary- -f -a &&
+	test -f tmp1/orary-path0 &&
+	test -f tmp1/orary-path1/file1 &&
+	test -h tmp
+'
 
-# Linus fix #3
-test_expect_success SYMLINKS \
-    'use --prefix=tmp- where tmp-path1 is a symlink' \
-    'rm -fr path0 path1 path2 tmp* &&
-     mkdir tmp1 &&
-     ln -s tmp1 tmp-path1 &&
-     git checkout-index --prefix=tmp- -f -a &&
-     test -f tmp-path0 &&
-     test ! -h tmp-path1 &&
-     test -d tmp-path1 &&
-     test -f tmp-path1/file1'
+test_expect_success SYMLINKS 'use --prefix=tmp- where tmp-path1 is a symlink' '
+	rm -fr path0 path1 path2 tmp* &&
+	mkdir tmp1 &&
+	ln -s tmp1 tmp-path1 &&
+	git checkout-index --prefix=tmp- -f -a &&
+	test -f tmp-path0 &&
+	test ! -h tmp-path1 &&
+	test -d tmp-path1 &&
+	test -f tmp-path1/file1
+'
 
 test_done
-- 
1.8.2.rc2.4.g7799588
