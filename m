From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH] t/t7810-grep.sh: remove duplicate test_config()
Date: Wed,  4 Jun 2014 22:18:18 -0700
Message-ID: <1401945498-26330-1-git-send-email-jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 07:20:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsQ5q-000110-2L
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 07:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbaFEFT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 01:19:59 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:50044 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbaFEFT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 01:19:57 -0400
Received: by mail-pd0-f171.google.com with SMTP id y13so562653pdi.2
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 22:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ugbZN0cWQuXmgoqUbgDC6+gzXjuvvwrauIM1NDXulpo=;
        b=PMgPna/ipAHlvdX9qKL9BRuHEKRVQuV0bwSI4K5oikHGsoHZHIcKbSrh3L2sfk2j/f
         nNLJYjNI7wH9n80SSUGCAQo4vLi0dRzd4vL/OyUxWF2V6VHIGe3F2YIVf0A+snt7QiLm
         dTB+S6RAyh3HaadRwU4VaADBGcMONon8Vxqd0a6n0eEero31y1rva9/Kru1W8uWhZgsl
         nQDTrmqEBiSP8SYwlxWIYAWfbNwb8nVYa9bp2gD8HTW1qYOnLJ0hSd3gil+qmqwUypCi
         MfnvlcNgMFyjxviFdzl4OnVqRJXzfIYAZFMTpK7jA7Q4KFniIi4l+6pMP/3w6DaAiZnu
         +GcQ==
X-Received: by 10.69.25.69 with SMTP id io5mr73766423pbd.22.1401945597315;
        Wed, 04 Jun 2014 22:19:57 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id dd5sm17680338pbc.85.2014.06.04.22.19.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 22:19:56 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 04 Jun 2014 22:19:53 -0700
X-Mailer: git-send-email 2.0.0.153.g79dcccc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250805>

t/t7810-grep.sh had its own test_config() function which served the
same purpose as the one in t/test-lib-functions.sh.  Removed, all tests
pass.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 t/t7810-grep.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 63b3039..40615de 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1096,11 +1096,6 @@ test_expect_success 'grep -E pattern with grep.patternType=fixed' '
 	test_cmp expected actual
 '
 
-test_config() {
-	git config "$1" "$2" &&
-	test_when_finished "git config --unset $1"
-}
-
 cat >expected <<EOF
 hello.c<RED>:<RESET>int main(int argc, const char **argv)
 hello.c<RED>-<RESET>{
-- 
2.0.0.153.g79dcccc
