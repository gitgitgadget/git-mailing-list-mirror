From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 18/19] Add tests for sparse checkout
Date: Thu, 20 Aug 2009 20:47:12 +0700
Message-ID: <1250776033-12395-19-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
 <1250776033-12395-7-git-send-email-pclouds@gmail.com>
 <1250776033-12395-8-git-send-email-pclouds@gmail.com>
 <1250776033-12395-9-git-send-email-pclouds@gmail.com>
 <1250776033-12395-10-git-send-email-pclouds@gmail.com>
 <1250776033-12395-11-git-send-email-pclouds@gmail.com>
 <1250776033-12395-12-git-send-email-pclouds@gmail.com>
 <1250776033-12395-13-git-send-email-pclouds@gmail.com>
 <1250776033-12395-14-git-send-email-pclouds@gmail.com>
 <1250776033-12395-15-git-send-email-pclouds@gmail.com>
 <1250776033-12395-16-git-send-email-pclouds@gmail.com>
 <1250776033-12395-17-git-send-email-pclouds@gmail.com>
 <1250776033-12395-18-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81O-0007ZS-PC
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbZHTNtG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbZHTNtF
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:49:05 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:62823 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693AbZHTNtD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:49:03 -0400
Received: by mail-px0-f196.google.com with SMTP id 34so3269349pxi.4
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jQoMQjZQxe/+gNFFXwlIhh2YXqb7M6HlDoyXh68Mn3I=;
        b=UBemdXQeSobe33jdRfxlG0xPrFh/r8DvVfCmMMPSjRT5AnRKTDE9NhMFp1kU1X3dRy
         1u9kzGkzVuWaDeTyf0A/351qxtryRvpwz1aP7sVjgPC4J4PTcZlGrtU81HlxBeybiz/R
         8lO8kFRK1MYKjEB4QimTyknfuIXyHwdHJ8l64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CHyFFDb94gtHMt2pS76dwslIBZqNu1ljTSbADTBrW7fX92rPUT5DSceVerV697ZyIm
         k28OwKvaaHPlTpimUcP5QDAy9zfArgvIErvdkwo51RNE446VUDJf0v3IJf/LntgPqF4b
         mz77Ghz12GIRdTuEcEI5q5T8oqav3exzqIttw=
Received: by 10.115.87.33 with SMTP id p33mr9189093wal.101.1250776143996;
        Thu, 20 Aug 2009 06:49:03 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 20sm186426pzk.13.2009.08.20.06.48.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:48:53 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-18-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126640>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1009-read-tree-sparse-checkout.sh |  154 ++++++++++++++++++++++++++=
++++++++
 1 files changed, 154 insertions(+), 0 deletions(-)
 create mode 100755 t/t1009-read-tree-sparse-checkout.sh

diff --git a/t/t1009-read-tree-sparse-checkout.sh b/t/t1009-read-tree-s=
parse-checkout.sh
new file mode 100755
index 0000000..2192f5a
--- /dev/null
+++ b/t/t1009-read-tree-sparse-checkout.sh
@@ -0,0 +1,154 @@
+#!/bin/sh
+
+test_description=3D'sparse checkout tests'
+
+. ./test-lib.sh
+
+cat >expected <<EOF
+100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	sub/added
+EOF
+test_expect_success 'setup' '
+	test_commit init &&
+	echo modified >> init.t &&
+	mkdir sub &&
+	touch sub/added &&
+	git add init.t sub/added &&
+	git commit -m "modified and added" &&
+	git tag top &&
+	git rm sub/added &&
+	git commit -m removed &&
+	git tag removed &&
+	git checkout top &&
+	git ls-files --stage > result &&
+	test_cmp expected result
+'
+
+cat >expected.swt <<EOF
+H init.t
+H sub/added
+EOF
+test_expect_success 'read-tree without .git/info/sparse-checkout' '
+	git read-tree -m -u HEAD &&
+	git ls-files --stage > result &&
+	test_cmp expected result &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result
+'
+
+test_expect_success 'read-tree with .git/info/sparse-checkout but disa=
bled' '
+	echo > .git/info/sparse-checkout
+	git read-tree -m -u HEAD &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test -f init.t &&
+	test -f sub/added
+'
+
+test_expect_success 'read-tree --no-sparse-checkout with empty .git/in=
fo/sparse-checkout and enabled' '
+	git config core.sparsecheckout true &&
+	echo > .git/info/sparse-checkout &&
+	git read-tree --no-sparse-checkout -m -u HEAD &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test -f init.t &&
+	test -f sub/added
+'
+
+cat >expected.swt <<EOF
+S init.t
+S sub/added
+EOF
+test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
+	git config core.sparsecheckout true &&
+	echo > .git/info/sparse-checkout &&
+	git read-tree -m -u HEAD &&
+	git ls-files --stage > result &&
+	test_cmp expected result &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test ! -f init.t &&
+	test ! -f sub/added
+'
+
+cat >expected.swt <<EOF
+S init.t
+H sub/added
+EOF
+test_expect_success 'match directories with trailing slash' '
+	echo sub/ > .git/info/sparse-checkout &&
+	git read-tree -m -u HEAD &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test ! -f init.t &&
+	test -f sub/added
+'
+
+cat >expected.swt <<EOF
+H init.t
+H sub/added
+EOF
+test_expect_failure 'match directories without trailing slash' '
+	echo init.t > .git/info/sparse-checkout &&
+	echo sub >> .git/info/sparse-checkout &&
+	git read-tree -m -u HEAD &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test ! -f init.t &&
+	test -f sub/added
+'
+
+cat >expected.swt <<EOF
+H init.t
+S sub/added
+EOF
+test_expect_success 'checkout area changes' '
+	echo init.t > .git/info/sparse-checkout &&
+	git read-tree -m -u HEAD &&
+	git ls-files -t > result &&
+	test_cmp expected.swt result &&
+	test -f init.t &&
+	test ! -f sub/added
+'
+
+test_expect_success 'read-tree updates worktree, absent case' '
+	echo sub/added > .git/info/sparse-checkout &&
+	git checkout -f top &&
+	git read-tree -m -u HEAD^ &&
+	test ! -f init.t
+'
+
+test_expect_success 'read-tree updates worktree, dirty case' '
+	echo sub/added > .git/info/sparse-checkout &&
+	git checkout -f top &&
+	echo dirty > init.t &&
+	git read-tree -m -u HEAD^ &&
+	grep -q dirty init.t &&
+	rm init.t
+'
+
+test_expect_success 'read-tree removes worktree, dirty case' '
+	echo init.t > .git/info/sparse-checkout &&
+	git checkout -f top &&
+	echo dirty > added &&
+	git read-tree -m -u HEAD^ &&
+	grep -q dirty added
+'
+
+test_expect_success 'read-tree adds to worktree, absent case' '
+	echo init.t > .git/info/sparse-checkout &&
+	git checkout -f removed &&
+	git read-tree -u -m HEAD^ &&
+	test ! -f sub/added
+'
+
+test_expect_success 'read-tree adds to worktree, dirty case' '
+	echo init.t > .git/info/sparse-checkout &&
+	git checkout -f removed &&
+	mkdir sub &&
+	echo dirty > sub/added &&
+	git read-tree -u -m HEAD^ &&
+	grep -q dirty sub/added
+'
+
+test_done
--=20
1.6.3.GIT
