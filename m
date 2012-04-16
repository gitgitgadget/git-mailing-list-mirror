From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v3 5/7] t4052: Add tests to illustrate issues with restrictive COLUMNS
Date: Mon, 16 Apr 2012 03:44:53 -0700
Message-ID: <1334573095-32286-6-git-send-email-lucian.poston@gmail.com>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 12:47:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjTG-0000o1-Hw
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab2DPKre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 06:47:34 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46920 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab2DPKrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 06:47:33 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so6192020pbc.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4862FIAZGwdLIrb2D7gfCFUCOhZ3Zd5SbKpM9+3zmNQ=;
        b=gMu5f1BWHoCxC72Q4ASiz/2bmZjxnUO/MRkGFt4ppRz1vIJpi5/ABVcDk/i1mP+p1M
         mI9YcXxbrWc+7qVz0fC6BMjANF3S31yz9pvejxS52eWsRi04p8ao41+1RET80PVV+TbU
         hojJXQt4ctaKkVsSugamjxpZvTkHr6izFNFgsBUcUkllM3xTqBvxnqvjicD/RChR1R0R
         LLLADnOzlafIIrjU+Fu3MfJDr/0THHX+a+qaH7ETqhqNU//1KmXLFWURNtzeBmpBDk8z
         YCi/bzm/YoS3Zc3MFw5O82wgatLckvkA/31dcB44oJw10oaZyRwaLH+64BiYXfR9cEkQ
         i4cA==
Received: by 10.68.201.6 with SMTP id jw6mr27472509pbc.92.1334573253023;
        Mon, 16 Apr 2012 03:47:33 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id oh2sm10793051pbb.45.2012.04.16.03.47.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 03:47:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195616>


Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 t/t4052-stat-output.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index d748e5e..6cac95b 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -284,6 +284,34 @@ respects expect200 show --stat
 respects expect200 log -1 --stat
 EOF
 
+cat >expect1 <<'EOF'
+ ...aaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+EOF
+cat >expect1-graph <<'EOF'
+|  ...aaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+EOF
+while read verb expect cmd args
+do
+	test_expect_success "$cmd $verb prefix greater than COLUMNS (big change)" '
+		COLUMNS=1 git $cmd $args >output
+		grep " | " output >actual &&
+		test_cmp "$expect" actual
+	'
+
+	test "$cmd" != diff || continue
+
+	test_expect_success "$cmd --graph $verb prefix greater than COLUMNS (big change)" '
+		COLUMNS=1 git $cmd $args --graph >output
+		grep " | " output >actual &&
+		test_cmp "$expect-graph" actual
+	'
+done <<\EOF
+ignores expect80 format-patch -1 --stdout
+respects expect1 diff HEAD^ HEAD --stat
+respects expect1 show --stat
+respects expect1 log -1 --stat
+EOF
+
 cat >expect <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
-- 
1.7.3.4
