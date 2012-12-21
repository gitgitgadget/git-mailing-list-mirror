From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 7/7] tests: paint unexpectedly fixed known breakages in
 bold red
Date: Thu, 20 Dec 2012 19:12:38 -0800
Message-ID: <1356059558-23479-8-git-send-email-gitster@pobox.com>
References: <1356059558-23479-1-git-send-email-gitster@pobox.com>
Cc: Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 04:13:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlt36-0000Og-EP
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 04:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab2LUDNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 22:13:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47715 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167Ab2LUDM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 22:12:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A55F6A834;
	Thu, 20 Dec 2012 22:12:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; s=sasl; bh=MVP4IPQElXceNXKuuGySk/cY1qE=; b=P5/ggGqw
	awyPHqnEiOcJ5rEhhwq9TYa78cBQ2huyETO0w5xeUUjFpLS5UIuP1ZA5p9FJifH7
	ENum16sHpke+o30412Eb6PBB+XUx4BsFUsJb5lUIbG8jw2BcjrDRSfqQXjD7Dr+B
	3v5okbzekkVcbKi5R59QnKr4BclJhnY9Bmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; q=dns; s=sasl; b=EoEMgeBhOv3QVBHPPhw6dc3XRmgOFzF5fo
	XaP1/G1H1PPyQ5+eGfgc0zksrWDgAc2YnIsWXudP5bWrwCH3I67P14KIWZZCt0LM
	FRGxbUDTUmqy9NHj7JuJ5Yl1DKK5R6RL65Qkh75kWJQMEwuw5BIuChdJlXKjiYOS
	xp7f+8N6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94249A833;
	Thu, 20 Dec 2012 22:12:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAF4DA830; Thu, 20 Dec 2012
 22:12:54 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.225.g8d36ab4
In-Reply-To: <1356059558-23479-1-git-send-email-gitster@pobox.com>
In-Reply-To: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
References: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
X-Pobox-Relay-ID: 5011B17E-4B1C-11E2-AC42-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211949>

From: Adam Spiers <git@adamspiers.org>

Change color of unexpectedly fixed known breakages to bold red.  An
unexpectedly passing test indicates that the test code is somehow
broken or out of sync with the code it is testing.  Either way this is
an error which is potentially as bad as a failing test, and as such is
no longer portrayed as a pass in the output.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0000-basic.sh | 30 ++++++++++++++++++++++++------
 t/test-lib.sh    | 13 +++++++++----
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 384b0ae..8973d2c 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -145,13 +145,31 @@ test_expect_success 'pretend we have fixed a known breakage' "
 	test_done
 	EOF
 	check_sub_test_lib_test passing-todo <<-\\EOF
-	> ok 1 - pretend we have fixed a known breakage # TODO known breakage
-	> # fixed 1 known breakage(s)
-	> # passed all 1 test(s)
+	> ok 1 - pretend we have fixed a known breakage # TODO known breakage vanished
+	> # 1 known breakage(s) vanished; please update test(s)
 	> 1..1
 	EOF
 "
 
+test_expect_success 'pretend we have fixed one of two known breakages (run in sub test-lib)' "
+	run_sub_test_lib_test partially-passing-todos \
+		'2 TODO tests, one passing' <<-\\EOF &&
+	test_expect_failure 'pretend we have a known breakage' 'false'
+	test_expect_success 'pretend we have a passing test' 'true'
+	test_expect_failure 'pretend we have fixed another known breakage' 'true'
+	test_done
+	EOF
+	check_sub_test_lib_test partially-passing-todos <<-\\EOF
+	> not ok 1 - pretend we have a known breakage # TODO known breakage
+	> ok 2 - pretend we have a passing test
+	> ok 3 - pretend we have fixed another known breakage # TODO known breakage vanished
+	> # 1 known breakage(s) vanished; please update test(s)
+	> # still have 1 known breakage(s)
+	> # passed all remaining 1 test(s)
+	> 1..3
+	EOF
+"
+
 test_expect_success 'pretend we have a pass, fail, and known breakage' "
 	test_must_fail run_sub_test_lib_test \
 		mixed-results1 'mixed results #1' <<-\\EOF &&
@@ -199,10 +217,10 @@ test_expect_success 'pretend we have a mix of all possible results' "
 	> #	false
 	> not ok 8 - pretend we have a known breakage # TODO known breakage
 	> not ok 9 - pretend we have a known breakage # TODO known breakage
-	> ok 10 - pretend we have fixed a known breakage # TODO known breakage
-	> # fixed 1 known breakage(s)
+	> ok 10 - pretend we have fixed a known breakage # TODO known breakage vanished
+	> # 1 known breakage(s) vanished; please update test(s)
 	> # still have 2 known breakage(s)
-	> # failed 3 among remaining 8 test(s)
+	> # failed 3 among remaining 7 test(s)
 	> 1..10
 	EOF
 "
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8b75c9a..30a0937 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -278,7 +278,7 @@ test_failure_ () {
 
 test_known_broken_ok_ () {
 	test_fixed=$(($test_fixed+1))
-	say_color "" "ok $test_count - $@ # TODO known breakage"
+	say_color error "ok $test_count - $@ # TODO known breakage vanished"
 }
 
 test_known_broken_failure_ () {
@@ -373,13 +373,18 @@ test_done () {
 
 	if test "$test_fixed" != 0
 	then
-		say_color pass "# fixed $test_fixed known breakage(s)"
+		say_color error "# $test_fixed known breakage(s) vanished; please update test(s)"
 	fi
 	if test "$test_broken" != 0
 	then
 		say_color warn "# still have $test_broken known breakage(s)"
-		msg="remaining $(($test_count-$test_broken)) test(s)"
+	fi
+	if test "$test_broken" != 0 || test "$test_fixed" != 0
+	then
+		test_remaining=$(( $test_count - $test_broken - $test_fixed ))
+		msg="remaining $test_remaining test(s)"
 	else
+		test_remaining=$test_count
 		msg="$test_count test(s)"
 	fi
 	case "$test_failure" in
@@ -393,7 +398,7 @@ test_done () {
 
 		if test $test_external_has_tap -eq 0
 		then
-			if test $test_count -gt 0
+			if test $test_remaining -gt 0
 			then
 				say_color pass "# passed all $msg"
 			fi
-- 
1.8.1.rc2.225.g8d36ab4
