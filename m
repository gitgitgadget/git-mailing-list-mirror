From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 1/2] use 'test ...' instead of '[ ... ]'
Date: Tue,  6 Jan 2015 17:57:50 -0500
Message-ID: <1420585071-28973-2-git-send-email-rhansen@bbn.com>
References: <xmqq8uhfpw3s.fsf@gitster.dls.corp.google.com>
 <1420585071-28973-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, rhansen@bbn.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 06 23:58:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8d4i-0000WP-Jy
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 23:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbbAFW6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 17:58:03 -0500
Received: from smtp.bbn.com ([128.33.1.81]:23786 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbbAFW6A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 17:58:00 -0500
Received: from socket.bbn.com ([192.1.120.102]:35308)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Y8d4Z-00023q-K0; Tue, 06 Jan 2015 17:57:59 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 63A5A402DD
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1420585071-28973-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262107>

(see Documentation/CodingGuidelines)

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/test-lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9acdc88..3670eed 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -184,10 +184,10 @@ export _x05 _x40 _z40 LF u200c
 # This test checks if command xyzzy does the right thing...
 # '
 # . ./test-lib.sh
-[ "x$ORIGINAL_TERM" != "xdumb" ] && (
+test "x$ORIGINAL_TERM" != "xdumb" && (
 		TERM=$ORIGINAL_TERM &&
 		export TERM &&
-		[ -t 1 ] &&
+		test -t 1 &&
 		tput bold >/dev/null 2>&1 &&
 		tput setaf 1 >/dev/null 2>&1 &&
 		tput sgr0 >/dev/null 2>&1
@@ -684,7 +684,7 @@ test_done () {
 		then
 			error "Can't use skip_all after running some tests"
 		fi
-		[ -z "$skip_all" ] || skip_all=" # SKIP $skip_all"
+		test -z "$skip_all" || skip_all=" # SKIP $skip_all"
 
 		if test $test_external_has_tap -eq 0
 		then
-- 
2.2.1
