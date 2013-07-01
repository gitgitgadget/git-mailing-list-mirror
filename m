From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v8 3/5] t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
Date: Tue,  2 Jul 2013 03:19:02 +0400
Message-ID: <aac80dbfcddb20ad3fe1745d6e54da638772ed7c.1372719264.git.Alex.Crezoff@gmail.com>
References: <cover.1372719264.git.Alex.Crezoff@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 01:19:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtnNn-0007Lt-2X
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 01:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625Ab3GAXTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 19:19:30 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:54392 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab3GAXTU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 19:19:20 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so4868974lab.23
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 16:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=W1bKLmQy0j6+zaWs2XUN00mG2eMp11iBs1ayA7FCesE=;
        b=FBnNnY3RD0Ew5cQZAYJJ++WMnHUj62d64VCCHdHD/BI7YfA7qWdn1WRNvoFUdemd7G
         G2WM5bwT9rV1WTbBCT0hv+RAFEU4NWQm6J8pdIX18oLkTLpvJ5WBe+tEmCvADDz3krp0
         wvl4AQvoO+ncwXIrwdp32onYeLaGBKQBlc7p8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=W1bKLmQy0j6+zaWs2XUN00mG2eMp11iBs1ayA7FCesE=;
        b=XtVTOE060Mc2CBh+XzrOEqtDvP0IPhbZQWjxQrh6IskPDp76VXw4rZqNbdN70eJF2N
         maTxbNMG8dCimAnZKQlDi0EISXbd2PLr5V445mZo9b1BvlRcj198ziVMyv0sVJDT2N/1
         HSwtru7q8+OS40GccLdNu6FWGrAKQxQmN/IGLR4c1U7rMNiyeQCnb0tW9wOQ9XNSB/uM
         qbCw08AaUKazg3+pubZYCk8y0+moCOtE/ubDVAWV/9VGfphcpeVszeunDEebKpX5EGaI
         FytmQqbFcKlTVvquXSJoEuByTrq4M9Gg9dabCOlPZjcshQ/FnfDSKu6bodGCTlG7QGYf
         //0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=W1bKLmQy0j6+zaWs2XUN00mG2eMp11iBs1ayA7FCesE=;
        b=ClLcBvrWsYQTxbmplGU3kXNKJMyhbQHg+q+BGHye5Gg3ygzRElNbFHJfF4AGU48JhA
         SQiD2MR4/HA5FbMZxC2v/4awuR/rxHGNEwPcCAYEEImtu2RJxpVLQ1eq5UFMb3+VFSuc
         +WVZhrMm+5d3ErDksk9V7ue8j2eXJ/y0J4+OFyf0kQycvmtcINYOZuRTIE2F8DbT/WIf
         aNF3mMwODYt7fddS3XBf0Butry/pYe4XzTGUCSHJ4Cof/SvDjv+VDxGlsGWwAzwRwmDI
         rkVrRtw/UHLCk81SedxFj7xEUUwD0t+Si6ucu0n8vlzhZgDg1r0+lLkdOcKjsTzqC88q
         ABvw==
X-Received: by 10.112.97.132 with SMTP id ea4mr3315670lbb.80.1372720759099;
        Mon, 01 Jul 2013 16:19:19 -0700 (PDT)
Received: from localhost (ppp91-77-20-158.pppoe.mtu-net.ru. [91.77.20.158])
        by mx.google.com with ESMTPSA id g7sm8054896lae.6.2013.07.01.16.19.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jul 2013 16:19:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.16.gce2c52e
In-Reply-To: <cover.1372719264.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372719264.git.Alex.Crezoff@gmail.com>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com> <cover.1372719264.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQn0f/UFeXtiet/eZBk1i7iolgajuIZw3z1cWFkI1BOtX+VMmy6LOmG2u+TDjZRfQjhR4pIo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229353>

The expected SHA-1 digests are always available in variables. Use
them instead of hardcoding.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 48 +++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 26fbfde..73ba5e8 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -101,7 +101,11 @@ test_expect_failure 'NUL termination with --stat' '
 
 test_expect_success 'setup more commits' '
 	test_commit "message one" one one message-one &&
-	test_commit "message two" two two message-two
+	test_commit "message two" two two message-two &&
+	head1=$(git rev-parse --verify --short HEAD~0) &&
+	head2=$(git rev-parse --verify --short HEAD~1) &&
+	head3=$(git rev-parse --verify --short HEAD~2) &&
+	head4=$(git rev-parse --verify --short HEAD~3)
 '
 
 test_expect_success 'left alignment formatting' '
@@ -117,18 +121,18 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting at the nth column' '
-	git log --pretty="format:%h %<|(40)%s" >actual &&
+test_expect_success 'left alignment formatting at the nth column' "
+	git log --pretty='format:%h %<|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
-fa33ab1 message two                    Z
-7cd6c63 message one                    Z
-1711bf9 add bar                        Z
-af20c06 initial                        Z
+$head1 message two                    Z
+$head2 message one                    Z
+$head3 add bar                        Z
+$head4 initial                        Z
 EOF
 	test_cmp expected actual
-'
+"
 
 test_expect_success 'left alignment formatting with no padding' '
 	git log --pretty="format:%<(1)%s" >actual &&
@@ -195,18 +199,18 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_success 'right alignment formatting at the nth column' '
-	git log --pretty="format:%h %>|(40)%s" >actual &&
+test_expect_success 'right alignment formatting at the nth column' "
+	git log --pretty='format:%h %>|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
-fa33ab1                      message two
-7cd6c63                      message one
-1711bf9                          add bar
-af20c06                          initial
+$head1                      message two
+$head2                      message one
+$head3                          add bar
+$head4                          initial
 EOF
 	test_cmp expected actual
-'
+"
 
 test_expect_success 'right alignment formatting with no padding' '
 	git log --pretty="format:%>(1)%s" >actual &&
@@ -234,18 +238,18 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_success 'center alignment formatting at the nth column' '
-	git log --pretty="format:%h %><|(40)%s" >actual &&
+test_expect_success 'center alignment formatting at the nth column' "
+	git log --pretty='format:%h %><|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
-fa33ab1           message two          Z
-7cd6c63           message one          Z
-1711bf9             add bar            Z
-af20c06             initial            Z
+$head1           message two          Z
+$head2           message one          Z
+$head3             add bar            Z
+$head4             initial            Z
 EOF
 	test_cmp expected actual
-'
+"
 
 test_expect_success 'center alignment formatting with no padding' '
 	git log --pretty="format:%><(1)%s" >actual &&
-- 
1.8.3.1.16.gce2c52e
