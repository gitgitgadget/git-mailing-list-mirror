From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] test_must_fail: compare exit_code using integer -eq operator
Date: Wed, 25 Nov 2015 22:05:24 +0000
Message-ID: <565630A4.7070205@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:06:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1iCm-0003Um-4M
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 23:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbbKYWGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 17:06:23 -0500
Received: from avasout07.plus.net ([84.93.230.235]:54820 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbbKYWGW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 17:06:22 -0500
Received: from [10.0.2.15] ([146.200.5.254])
	by avasout07 with smtp
	id ly5S1r0045UqX4q01y5T91; Wed, 25 Nov 2015 22:05:28 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=JN/GyJ+b c=1 sm=1 tr=0
 a=GKs3PHufgjMgxBavMeQJCg==:117 a=GKs3PHufgjMgxBavMeQJCg==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=3E6HSm8yC7VWkkp8pwcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281747>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

Can we squash this into your fixup?

ATB,
Ramsay Jones

 t/test-lib-functions.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 85aeaf9..2bb639e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -605,22 +605,22 @@ test_must_fail () {
 	esac
 	"$@"
 	exit_code=$?
-	if test $exit_code = 0 && ! test_list_contains "$_test_ok" success
+	if test $exit_code -eq 0 && ! test_list_contains "$_test_ok" success
 	then
 		echo >&2 "test_must_fail: command succeeded: $*"
 		return 1
-	elif test $exit_code = 141 && test_list_contains "$_test_ok" sigpipe
+	elif test $exit_code -eq 141 && test_list_contains "$_test_ok" sigpipe
 	then
 		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192
 	then
 		echo >&2 "test_must_fail: died by signal: $*"
 		return 1
-	elif test $exit_code = 127
+	elif test $exit_code -eq 127
 	then
 		echo >&2 "test_must_fail: command not found: $*"
 		return 1
-	elif test $exit_code = 126
+	elif test $exit_code -eq 126
 	then
 		echo >&2 "test_must_fail: valgrind error: $*"
 		return 1
-- 
2.6.0
