From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 09/10] t/t9601-cvsimport-vendor-branch.sh: Add a PERL prerequisite
Date: Fri, 13 Aug 2010 20:40:12 +0000
Message-ID: <1281732013-18284-10-git-send-email-avarab@gmail.com>
References: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 22:42:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok14j-000837-3a
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068Ab0HMUlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:41:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58892 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab0HMUlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:41:16 -0400
Received: by eyg5 with SMTP id 5so488096eyg.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=iJGzGkmmKL9X/W7sE+znqC5RCXaYecCIrntHySpZS5M=;
        b=P8AGc7EibXS2jnA51dobPxNU29NKfd2VYV0IBu7NVXcWTFl498OxyEh7R54RQuqtNi
         oZqqdDU6Ds3Z/t9hJgqMNQgSlNrjfX5Eo3GahlNdqX3AMHqF71gvlhRZ95OR4lfw1T7o
         FhH8HOIXMvCQnuNRlvsyA1eiTb3IApuNEQKjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sKD9x4Cs68xLOkbcxe8pqAeDGPdyI/8tBgAeV+jbCnBfh/w7LUpbuTgj9yxd+H8mvp
         bKoCybNgeysdBU+VAUkWUhbpVj7EaGD5kZAmVAh9QToUkZwYtm77I3z2hDzTFCbMuHJz
         HkS1HQSRlItL9nur85rTOCslwbi54LOuC0eao=
Received: by 10.216.1.6 with SMTP id 6mr1779836wec.24.1281732075028;
        Fri, 13 Aug 2010 13:41:15 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1838298wej.46.2010.08.13.13.41.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:41:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.gf2379
In-Reply-To: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153503>

Change this test to declare a PERL prerequisite. These tests use the
-p switch, so they implicitly depend on Perl code, but nothing was
declaring this.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t9601-cvsimport-vendor-branch.sh |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-ven=
dor-branch.sh
index 3afaf56..71178e2 100755
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -34,50 +34,52 @@
 test_description=3D'git cvsimport handling of vendor branches'
 . ./lib-cvs.sh
=20
-CVSROOT=3D"$TEST_DIRECTORY"/t9601/cvsroot
-export CVSROOT
+test_expect_success PERL 'setup CVSROOT' '
+	CVSROOT=3D"$TEST_DIRECTORY"/t9601/cvsroot &&
+	export CVSROOT
+'
=20
-test_expect_success 'import a module with a vendor branch' '
+test_expect_success PERL 'import a module with a vendor branch' '
=20
 	git cvsimport -C module-git module
=20
 '
=20
-test_expect_success 'check HEAD out of cvs repository' 'test_cvs_co ma=
ster'
+test_expect_success PERL 'check HEAD out of cvs repository' 'test_cvs_=
co master'
=20
-test_expect_success 'check master out of git repository' 'test_git_co =
master'
+test_expect_success PERL 'check master out of git repository' 'test_gi=
t_co master'
=20
-test_expect_success 'check a file that was imported once' '
+test_expect_success PERL 'check a file that was imported once' '
=20
 	test_cmp_branch_file master imported-once.txt
=20
 '
=20
-test_expect_failure 'check a file that was imported twice' '
+test_expect_failure PERL 'check a file that was imported twice' '
=20
 	test_cmp_branch_file master imported-twice.txt
=20
 '
=20
-test_expect_success 'check a file that was imported then modified on H=
EAD' '
+test_expect_success PERL 'check a file that was imported then modified=
 on HEAD' '
=20
 	test_cmp_branch_file master imported-modified.txt
=20
 '
=20
-test_expect_success 'check a file that was imported, modified, then im=
ported again' '
+test_expect_success PERL 'check a file that was imported, modified, th=
en imported again' '
=20
 	test_cmp_branch_file master imported-modified-imported.txt
=20
 '
=20
-test_expect_success 'check a file that was added to HEAD then imported=
' '
+test_expect_success PERL 'check a file that was added to HEAD then imp=
orted' '
=20
 	test_cmp_branch_file master added-imported.txt
=20
 '
=20
-test_expect_success 'a vendor branch whose tag has been removed' '
+test_expect_success PERL 'a vendor branch whose tag has been removed' =
'
=20
 	test_cmp_branch_file master imported-anonymously.txt
=20
--=20
1.7.2.1.338.gf2379
