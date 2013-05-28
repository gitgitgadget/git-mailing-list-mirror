From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/5] test: improve rebase -q test
Date: Tue, 28 May 2013 07:54:30 -0500
Message-ID: <1369745671-22418-5-git-send-email-felipe.contreras@gmail.com>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 14:56:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJSJ-0001ST-QF
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 14:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933939Ab3E1M4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 08:56:38 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:57685 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933913Ab3E1M4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 08:56:37 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so9955627oag.1
        for <git@vger.kernel.org>; Tue, 28 May 2013 05:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gQahvx3zlILjibyMKLGp8HE8KCeHA8Z1Iano44Qmibs=;
        b=oIGttGVqspmjd9uY9JwGERtKgvEUoAjiP/DkOUFPKy5axMrd/aMDBLIHTjL0mkRtgJ
         j+YuTVa5lu/5HI+sNbUQB4SbR5cm7KjFqoymMAf/oshIFpW1nQxRZSNXGusxrhIXZSFf
         y3YCxmG1X4Y7/W4bMe4m1lplNjny5JzzgmQPUiQYlD5Lcdy7lhbAGH1dzBAa1eBrdjlz
         NL54d3gM9H326AYwlHrnwD7sawGVPEieyOGTMZPqfHSO/d2DGU6Jd2omamYnCSb2zEUE
         grCsizhx27s/feGGGqGB6YjOlWmkP1GAK53ffb+C3P7gJIFh9jv5ZBV5HXhXtemmFqNk
         bfFA==
X-Received: by 10.60.145.166 with SMTP id sv6mr20466341oeb.86.1369745797327;
        Tue, 28 May 2013 05:56:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id p3sm26902176oel.0.2013.05.28.05.56.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 05:56:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225638>

Let's show the output so it's clear why it failed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3400-rebase.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b58fa1a..fb39531 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -185,6 +185,7 @@ test_expect_success 'default to @{upstream} when upstream arg is missing' '
 test_expect_success 'rebase -q is quiet' '
 	git checkout -b quiet topic &&
 	git rebase -q master >output.out 2>&1 &&
+	cat output.out &&
 	test ! -s output.out
 '
 
-- 
1.8.3.rc3.312.g47657de
