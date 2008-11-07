From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] t5400: expect success for denying deletion
Date: Fri, 7 Nov 2008 17:09:55 -0500
Message-ID: <20081107220955.GA16058@coredump.intra.peff.net>
References: <20081107220730.GA15942@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:11:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZXu-0000Oi-1O
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbYKGWJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbYKGWJ6
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:09:58 -0500
Received: from peff.net ([208.65.91.99]:1423 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987AbYKGWJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:09:57 -0500
Received: (qmail 2818 invoked by uid 111); 7 Nov 2008 22:09:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Nov 2008 17:09:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2008 17:09:55 -0500
Content-Disposition: inline
In-Reply-To: <20081107220730.GA15942@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100348>

Commit a240de11 introduced this test and the code to make it
successful.

Signed-off-by: Jeff King <peff@peff.net>
---
Reading over the mailing list postings which led to a240de11, I think it
is simply a case that Jan didn't fully understand what expect_failure
meant (it means "this is a test that is currently broken, but we hope to
fix in the future", and not anything to do with the test_must_fail in
the test itself).

 t/t5400-send-pack.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 6fe2f87..da69f08 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -103,7 +103,7 @@ unset GIT_CONFIG GIT_CONFIG_LOCAL
 HOME=`pwd`/no-such-directory
 export HOME ;# this way we force the victim/.git/config to be used.
 
-test_expect_failure \
+test_expect_success \
 	'pushing a delete should be denied with denyDeletes' '
 	cd victim &&
 	git config receive.denyDeletes true &&
-- 
1.6.0.3.866.gc189b
