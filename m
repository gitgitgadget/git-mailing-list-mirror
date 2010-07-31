From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] t1011 (sparse checkout): style nitpicks
Date: Fri, 30 Jul 2010 20:05:40 -0500
Message-ID: <20100731010540.GC5817@burratino>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
 <20100730013534.GB2182@burratino>
 <AANLkTi=3pX=k=Pf5SnWt8s=hbvwAXcZdmcqP_+kgCyE5@mail.gmail.com>
 <20100730195022.GB2448@burratino>
 <20100731010439.GB5817@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 03:06:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of0XR-0006NW-KM
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 03:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065Ab0GaBGx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 21:06:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58752 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab0GaBGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 21:06:52 -0400
Received: by iwn7 with SMTP id 7so1854473iwn.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 18:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1z3rCtYdNRvRLUJGN66HWOAfEZKUUFmY4o0q8gezT/0=;
        b=VWydV6bE1dQQxGpMdfaePJRvSvjSl3tOmMMdxUb5eCothwCwAdqBE553mounX10gIF
         LsT1T3wajYw+pvDU5LR4JTi6WEJu9iEL36QjqMq3nOQOrWwSjUHFfM3BCtVYf4zN3o8v
         M5KY6cfB0jQP/5ODaKqc8HBfK1UkYcUYpqNTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IM0XKpwvbGgOfJXfjZH/pHDijSroUDWnrU9CApZDOnGVbJJ/aTFerY5L0KAxM+v9DK
         e9rqm+KoK649PNWU1cKxOpVBYehGog3OInrhhowBhAeos+x6YyuZ9qwJP2w+Y9SyKDf1
         ElzJU8x8XuyiDXDis9G4Oi1E0vXnq4bjAQQA8=
Received: by 10.231.36.134 with SMTP id t6mr2654571ibd.128.1280538410091;
        Fri, 30 Jul 2010 18:06:50 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm2469409ibb.14.2010.07.30.18.06.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 18:06:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100731010439.GB5817@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152279>

The exit status of "git ls-files" in

	test -z "$(git ls-files sub/added)"

is ignored.  So redirect output to a file and compare to an
empty file with test_cmp instead.

While changing that, tweak the rest of the script to more closely
follow the test style guide.  Guarding setup commands with
test_expect_success makes it easy to see the scope in which some
particular data is used; removal of whitespace after >redirection
operators is just for consistency.

Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh |  108 ++++++++++++++++++--------=
-------
 1 files changed, 59 insertions(+), 49 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 885578a..2955071 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -1,16 +1,30 @@
 #!/bin/sh
=20
-test_description=3D'sparse checkout tests'
+test_description=3D'sparse checkout tests
+
+* (tag: removed, master) removed
+| D	sub/added
+* (HEAD, tag: top) modified and added
+| M	init.t
+| A	sub/added
+* (tag: init) init
+  A	init.t
+'
=20
 . ./test-lib.sh
=20
-cat >expected <<EOF
-100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
-100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	sub/added
-EOF
 test_expect_success 'setup' '
+	cat >expected <<-\EOF &&
+	100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	sub/added
+	EOF
+	cat >expected.swt <<-\EOF &&
+	H init.t
+	H sub/added
+	EOF
+
 	test_commit init &&
-	echo modified >> init.t &&
+	echo modified >>init.t &&
 	mkdir sub &&
 	touch sub/added &&
 	git add init.t sub/added &&
@@ -20,26 +34,22 @@ test_expect_success 'setup' '
 	git commit -m removed &&
 	git tag removed &&
 	git checkout top &&
-	git ls-files --stage > result &&
+	git ls-files --stage >result &&
 	test_cmp expected result
 '
=20
-cat >expected.swt <<EOF
-H init.t
-H sub/added
-EOF
 test_expect_success 'read-tree without .git/info/sparse-checkout' '
 	git read-tree -m -u HEAD &&
-	git ls-files --stage > result &&
+	git ls-files --stage >result &&
 	test_cmp expected result &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expected.swt result
 '
=20
 test_expect_success 'read-tree with .git/info/sparse-checkout but disa=
bled' '
-	echo > .git/info/sparse-checkout
+	echo >.git/info/sparse-checkout
 	git read-tree -m -u HEAD &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test -f init.t &&
 	test -f sub/added
@@ -47,9 +57,9 @@ test_expect_success 'read-tree with .git/info/sparse-=
checkout but disabled' '
=20
 test_expect_success 'read-tree --no-sparse-checkout with empty .git/in=
fo/sparse-checkout and enabled' '
 	git config core.sparsecheckout true &&
-	echo > .git/info/sparse-checkout &&
+	echo >.git/info/sparse-checkout &&
 	git read-tree --no-sparse-checkout -m -u HEAD &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test -f init.t &&
 	test -f sub/added
@@ -57,101 +67,101 @@ test_expect_success 'read-tree --no-sparse-checko=
ut with empty .git/info/sparse-
=20
 test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
 	git config core.sparsecheckout true &&
-	echo > .git/info/sparse-checkout &&
+	echo >.git/info/sparse-checkout &&
 	test_must_fail git read-tree -m -u HEAD &&
-	git ls-files --stage > result &&
+	git ls-files --stage >result &&
 	test_cmp expected result &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test -f init.t &&
 	test -f sub/added
 '
=20
-cat >expected.swt <<EOF
-S init.t
-H sub/added
-EOF
 test_expect_success 'match directories with trailing slash' '
+	cat >expected.swt-noinit <<-\EOF &&
+	S init.t
+	H sub/added
+	EOF
+
 	echo sub/ > .git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
 	git ls-files -t > result &&
-	test_cmp expected.swt result &&
+	test_cmp expected.swt-noinit result &&
 	test ! -f init.t &&
 	test -f sub/added
 '
=20
-cat >expected.swt <<EOF
-H init.t
-H sub/added
-EOF
 test_expect_failure 'match directories without trailing slash' '
-	echo init.t > .git/info/sparse-checkout &&
-	echo sub >> .git/info/sparse-checkout &&
+	echo init.t >.git/info/sparse-checkout &&
+	echo sub >>.git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expected.swt result &&
 	test ! -f init.t &&
 	test -f sub/added
 '
=20
-cat >expected.swt <<EOF
-H init.t
-S sub/added
-EOF
 test_expect_success 'checkout area changes' '
-	echo init.t > .git/info/sparse-checkout &&
+	cat >expected.swt-nosub <<-\EOF &&
+	H init.t
+	S sub/added
+	EOF
+
+	echo init.t >.git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
-	git ls-files -t > result &&
-	test_cmp expected.swt result &&
+	git ls-files -t >result &&
+	test_cmp expected.swt-nosub result &&
 	test -f init.t &&
 	test ! -f sub/added
 '
=20
 test_expect_success 'read-tree updates worktree, absent case' '
-	echo sub/added > .git/info/sparse-checkout &&
+	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
 	git read-tree -m -u HEAD^ &&
 	test ! -f init.t
 '
=20
 test_expect_success 'read-tree updates worktree, dirty case' '
-	echo sub/added > .git/info/sparse-checkout &&
+	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
-	echo dirty > init.t &&
+	echo dirty >init.t &&
 	git read-tree -m -u HEAD^ &&
 	grep -q dirty init.t &&
 	rm init.t
 '
=20
 test_expect_success 'read-tree removes worktree, dirty case' '
-	echo init.t > .git/info/sparse-checkout &&
+	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f top &&
-	echo dirty > added &&
+	echo dirty >added &&
 	git read-tree -m -u HEAD^ &&
 	grep -q dirty added
 '
=20
 test_expect_success 'read-tree adds to worktree, absent case' '
-	echo init.t > .git/info/sparse-checkout &&
+	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f removed &&
 	git read-tree -u -m HEAD^ &&
 	test ! -f sub/added
 '
=20
 test_expect_failure 'read-tree adds to worktree, dirty case' '
-	echo init.t > .git/info/sparse-checkout &&
+	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f removed &&
 	mkdir sub &&
-	echo dirty > sub/added &&
+	echo dirty >sub/added &&
 	git read-tree -u -m HEAD^ &&
 	grep -q dirty sub/added
 '
=20
 test_expect_success 'read-tree --reset removes outside worktree' '
-	echo init.t > .git/info/sparse-checkout &&
+	>empty &&
+	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f top &&
 	git reset --hard removed &&
-	test -z "$(git ls-files sub/added)"
+	git ls-files sub/added >result &&
+	test_cmp empty result
 '
=20
 test_done
--=20
1.7.2.1.544.ga752d.dirty
