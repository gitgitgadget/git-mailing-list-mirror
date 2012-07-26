From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/2] test-lib: provide case insensitivity as a prerequisite
Date: Thu, 26 Jul 2012 16:19:58 -0700
Message-ID: <7v394e5cv5.fsf_-_@alter.siamese.dyndns.org>
References: <7vboj25dk7.fsf@alter.siamese.dyndns.org>
 <7v7gtq5da3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"Michael J Gruber" <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 01:20:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuXLl-00037Z-6u
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 01:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab2GZXUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 19:20:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab2GZXUB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 19:20:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D0F98CDA;
	Thu, 26 Jul 2012 19:20:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BXWmGQP7HH9POZaSzLJYnp6ZwXY=; b=PduvoA
	YHcgn2Cx8W7/MUm6IvLUUZSRAMbi9khdY8ySfB0QXZFZcTVj6H5iLzJVO01WyGqz
	Ck/kFza+JsJmzbBta3IXLE5/4BsLZRX+Eo/bcihTXn+NIiy2eDthO9kZU8v25JOX
	5sRFJ8qY92D/I9jHbVJBR2USOPmpMrosMBQwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pq3CsdkG15lSDj1U+Rm/0diWPoUY6HNC
	YkZ6uUZWMRrDLGbq1kQbADkl1lSchCsOcnqo54+cbzLGZ3NNUXck3lkBPfcx54y9
	QCorjHkUMi0rz+XeD/IyCRowhAORACUWWzTkwmSDkXu3cmN2iwf4jiZlIDwTzuu/
	QaXh6EHSOEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 449BB8CD8;
	Thu, 26 Jul 2012 19:20:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AF858CD4; Thu, 26 Jul 2012
 19:19:59 -0400 (EDT)
In-Reply-To: <7v7gtq5da3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jul 2012 16:11:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B70C936-D778-11E1-854F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202315>

And on top, Michael's [1/5] would become like this, and [2/5] would
apply unchanged.

-- >8 --
From: Michael J Gruber <git@drmicha.warpmail.net>
Date: Thu, 26 Jul 2012 15:39:53 +0200

Case insensitivity plays a role in several tests and is tested in several
tests. Therefore, move the test from t003 into the test lib and use the
prerequisite in t0003.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/README              |  4 ++++
 t/t0003-attributes.sh | 10 ----------
 t/test-lib.sh         |  6 ++++++
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/README b/t/README
index 4c3ea25..5725607 100644
--- a/t/README
+++ b/t/README
@@ -625,6 +625,10 @@ use these, and "test_set_prereq" for how to define your own.
    Git was compiled with USE_LIBPCRE=YesPlease. Wrap any tests
    that use git-grep --perl-regexp or git-grep -P in these.
 
+ - CASE_INSENSITIVE_FS
+
+   Test is run on a case insensitive file system.
+
 Tips for Writing Tests
 ----------------------
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 51f3045..febc45c 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -123,16 +123,6 @@ test_expect_success 'attribute matching is case insensitive when core.ignorecase
 
 '
 
-test_expect_success 'check whether FS is case-insensitive' '
-	mkdir junk &&
-	echo good >junk/CamelCase &&
-	echo bad >junk/camelcase &&
-	if test "$(cat junk/CamelCase)" != good
-	then
-		test_set_prereq CASE_INSENSITIVE_FS
-	fi
-'
-
 test_expect_success CASE_INSENSITIVE_FS 'additional case insensitivity tests' '
 	test_must_fail attr_check a/B/D/g "a/b/d/*" "-c core.ignorecase=0" &&
 	test_must_fail attr_check A/B/D/NO "a/b/d/*" "-c core.ignorecase=0" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 878d000..52cb32a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -664,6 +664,12 @@ test_lazy_prereq SYMLINKS '
 	ln -s x y 2>/dev/null && test -h y 2>/dev/null
 '
 
+test_lazy_prereq CASE_INSENSITIVE_FS '
+	echo good >CamelCase &&
+	echo bad >camelcase &&
+	test "$(cat CamelCase)" != good
+'
+
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY
-- 
1.7.12.rc0.44.gc69a8ad
