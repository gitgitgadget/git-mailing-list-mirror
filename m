From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] fixup! t5528-push-default.sh: add helper functions
Date: Mon, 23 Apr 2012 09:45:37 -0700
Message-ID: <xmqqvckqjt1q.fsf_-_@junio.mtv.corp.google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-4-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqipgqlass.fsf@junio.mtv.corp.google.com>
	<vpqobqil9ml.fsf@bauges.imag.fr>
	<xmqq8vhml8z7.fsf@junio.mtv.corp.google.com>
	<xmqqzka2jt64.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:45:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMMOX-0000t2-2U
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab2DWQpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 12:45:40 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:61253 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab2DWQpj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 12:45:39 -0400
Received: by faaa19 with SMTP id a19so155162faa.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 09:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=9NzJ3gTAbwSYjyzsswmlyedKw0A3yyBcashvlL7oIpY=;
        b=cLDD/2re2BoDDg2UnJjBRaehQapj4LicppItMZYZC6+EXJLJh6kXIq4CkeYXj7x4va
         C1tSIw5RD86YvMAESk1jdvjiY/PCc/HmviT/pXw7fmK7w0Bk5AWwutH1ow6ZlDj9EM6S
         IkK2rMKiI1a+XRY3qUoqM3bSXFoWBMwpfvn9EsTrQwoe5MeGbbEyUV9tRFyOU5SjFSOP
         k+FVnjmIblVupHnlJ08IkPWXXLNmFCr3mHqhae4nnWUOSZ9pzA5gzKZ1CV6PhGR4i0uk
         XYE25/hAOGbZUVUmomcQS+qlUqy6cO1rI7DoYSi7yEysmOhtKEFhnbFwCNBs92JMnhv0
         l95w==
Received: by 10.14.188.12 with SMTP id z12mr3946903eem.8.1335199538451;
        Mon, 23 Apr 2012 09:45:38 -0700 (PDT)
Received: by 10.14.188.12 with SMTP id z12mr3946882eem.8.1335199538310;
        Mon, 23 Apr 2012 09:45:38 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si10338470eef.1.2012.04.23.09.45.38
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 09:45:38 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 2003C5C0050;
	Mon, 23 Apr 2012 09:45:38 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 695D8E120A; Mon, 23 Apr 2012 09:45:37 -0700 (PDT)
In-Reply-To: <xmqqzka2jt64.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Apr 2012 09:42:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkfF1k61f5H08dkgAsx0p8aN30tOcLgGNDA4lI8n/iJOnAK3kThc838kQjyPuSowRartcFnvGKQ2zR7kYiA0NtGxk3koBXuyNsmwCrBK/AAQq2cNN7WVotyAFAzdV4X0OrEv6Psbz15ATsQRPNHPUNBiqDRf5eRL6lre7qQ7lC00CIjkEQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196147>

Please eyeball the change to test_push_failure(); I think it is correct
to use the same "log --no-walk" to prepare expect and actual, but I may
have missed something.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5528-push-default.sh |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 43dec43..4a7d7fe 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup bare remotes' '
 # $1 = local revision
 # $2 = remote revision (tested to be equal to the local one)
 check_pushed_commit () {
-	git log -1 --format='%h %s' >expect &&
+	git log -1 --format='%h %s' "$1" >expect &&
 	git --git-dir=repo1 log -1 --format='%h %s' "$2" >actual &&
 	test_cmp expect actual
 }
@@ -39,11 +39,11 @@ test_push_failure () {
 		test_might_fail git --git-dir=repo1 \
 			log --no-walk --format='%h %s' "$@" >expect
 	fi &&
-	test_must_fail git -c push.default="$1" &&
+	test_must_fail git -c push.default="$push_default" push &&
 	if test $# -gt 0
 	then
 		test_might_fail git --git-dir=repo1 \
-			log -1 --format='%h %s' "$@" >actual
+			log --no-walk --format='%h %s' "$@" >actual
 	fi &&
 	test_cmp expect actual
 }
@@ -61,7 +61,7 @@ test_expect_success '"upstream" does not push on unconfigured remote' '
 	test_unconfig branch.master.remote &&
 	test_config push.default upstream &&
 	test_commit three &&
-	test_push_failure upstream master
+	test_push_failure upstream --all
 '
 
 test_expect_success '"upstream" does not push on unconfigured branch' '
@@ -70,7 +70,7 @@ test_expect_success '"upstream" does not push on unconfigured branch' '
 	test_unconfig branch.master.merge &&
 	test_config push.default upstream
 	test_commit four &&
-	test_push_failure upstream master
+	test_push_failure upstream --all
 '
 
 test_expect_success '"upstream" does not push when remotes do not match' '
-- 
1.7.10.376.g4eb25
