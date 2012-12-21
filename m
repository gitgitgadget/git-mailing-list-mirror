From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 4/7] tests: change info messages from yellow/brown to cyan
Date: Thu, 20 Dec 2012 19:12:35 -0800
Message-ID: <1356059558-23479-5-git-send-email-gitster@pobox.com>
References: <1356059558-23479-1-git-send-email-gitster@pobox.com>
Cc: Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 04:13:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlt2u-0000D7-Gu
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 04:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab2LUDMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 22:12:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47603 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080Ab2LUDMt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 22:12:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B5F8A81D;
	Thu, 20 Dec 2012 22:12:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; s=sasl; bh=EQi98LrwmFY0zflmq0OHu9AKQA4=; b=QQU3+yE/
	J0AvDOY13XS7JnXXsYXcKvWZCq5zFrWa9JG/Cwa5RMUSYsji/PkvKWwSHaKxdMZi
	35Z0BBdrzaUzGrs+GQNU/EvDLO+LOoJ8CVk3tmiT4UWq8pRFGlRMd3LSpC0AT8MZ
	Agm8H7EwM8c/v1b0X0bD5PXrD4D+izdPkLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; q=dns; s=sasl; b=FwocoQkzofDQund2VEK5WpPe6B3JqDmP6i
	wmlpz5yMT9sLpYNxgt80Ve/h9RrIvoG587rOsFTgnIAoCccbJKpG9xvU5g74MGuU
	e+op6SxzSDhTgoAKEh5gEftrmnThvUoQqoVIm+9GhiCptSrTCWkEjFTlzsbHdXko
	jRmXDXAkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 093EEA81C;
	Thu, 20 Dec 2012 22:12:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B313A81B; Thu, 20 Dec 2012
 22:12:48 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.225.g8d36ab4
In-Reply-To: <1356059558-23479-1-git-send-email-gitster@pobox.com>
In-Reply-To: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
References: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
X-Pobox-Relay-ID: 4C2E30F0-4B1C-11E2-978F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211948>

From: Adam Spiers <git@adamspiers.org>

Now that we've adopted a "traffic lights" coloring scheme, yellow is
used for warning messages, so we need to re-color info messages to
something less alarmist.  Blue is a universal color for informational
messages; however we are using that for skipped tests in order to
align with the color schemes of other test suites.  Therefore we use
cyan which is also blue-ish, but visually distinct from blue.

This was suggested on the list a while ago and no-one raised any
objections:

    http://thread.gmane.org/gmane.comp.version-control.git/205675/focus=205966

An earlier iteration of this patch used bold cyan, but the point of
this change is to make them less alarming; let's drop the boldness.

Also paint the message to report skipping the whole thing via
GIT_SKIP_TESTS mechanism in the same color as the "info" color
that is used on the final summary line for the entire script.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f32df80..8b75c9a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -186,9 +186,9 @@ then
 		warn)
 			tput setaf 3;; # brown/yellow
 		pass)
-			tput setaf 2;;            # green
+			tput setaf 2;; # green
 		info)
-			tput setaf 3;;            # brown
+			tput setaf 6;; # cyan
 		*)
 			test -n "$quiet" && return;;
 		esac
@@ -584,7 +584,7 @@ for skp in $GIT_SKIP_TESTS
 do
 	case "$this_test" in
 	$skp)
-		say_color skip >&3 "skipping test $this_test altogether"
+		say_color info >&3 "skipping test $this_test altogether"
 		skip_all="skip all tests in $this_test"
 		test_done
 	esac
-- 
1.8.1.rc2.225.g8d36ab4
