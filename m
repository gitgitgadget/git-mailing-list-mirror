From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v7 3/5] t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
Date: Wed, 26 Jun 2013 14:19:48 +0400
Message-ID: <21a6f94ba53a1e130fd2153af46aae7467f6e0b5.1372240999.git.Alex.Crezoff@gmail.com>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 26 12:20:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urmpu-0002wu-CP
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 12:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab3FZKUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 06:20:17 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:57390 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab3FZKUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 06:20:13 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so1386484lbd.4
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 03:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=OQLVd0TLilP99mfJofmc39WBbBmPHu4FIrNRqH4ujvo=;
        b=HYffPrMdz0gJo8xxpVqmYllmIHnsCECzHlMzvxsIjTNKVm1fiW8snqsO87fpdKraVd
         cW1fg+w0oKUQGkGdlvuxtBsntIZUyBihE3VCDOPL1Dgv+x+8msBjL231xuP+Q+UdQ4nI
         ODsnCD6LfSxvmKxNDjJ6bw9CHx0WlazaeaQ20=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=OQLVd0TLilP99mfJofmc39WBbBmPHu4FIrNRqH4ujvo=;
        b=aKIGI7cDfNkHhr9WqcMtR20SbpOKCezEIUxxwpvA5iNvfrdOJOkkZgvsnHP8+XUThr
         6bwBPI6SgpUEcV02NDYWBUtd8aeLFu2XxkEBjzsV5o0vvEYrkdxpYYW5UenbwbH9cc6h
         E4zPvN0pC/O/jqTZgSY8Vms3DnhKNbko4ReorvD9B45nTwP4+GPNm5rz/9ZzKUmvQkof
         QGOydR15Ug9Mrq0LFzkIMSD52Bldj1p33+8x448as1uaEma4ORoRXELbAGq662zGoBAq
         Sy6WpAety5hfIx2itkLdkmzhFSYinj//gprPx4xN4AG0WgGIUMxvKLun5JUN3mTe2xlp
         LqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=OQLVd0TLilP99mfJofmc39WBbBmPHu4FIrNRqH4ujvo=;
        b=HI1qVhn8beI9eVxiUIFTf4xcZnJ8L/PvgEQO+r3Pd8+6a3BfYvldClmA43j2FaZyTt
         SSrk4m9kH5KQq4HZejUOLiyhZNhp4nj8jGFLgnBOYsZPxPuYgYk1gyrp7UnWliA2cCnd
         fu8gv8CKCXU1AuW4S0KhxemxyYWkvf1/w4ZgUFkoqPLhxpuau0irHuviiU9AIzBRrlT5
         8w+9mCLSq7zNISemI8M/6ZzK4tNjc8go59w4vAJyufCeqje0j3idqi4anOcqVRI65p+2
         UVoeHKTcAR9fTHrchUmOzes+8JxintU/iCx8iLpcbm7DUb8nNgpvtb+vPvcNfVC4vOfs
         iTXA==
X-Received: by 10.112.5.199 with SMTP id u7mr1792875lbu.67.1372242012034;
        Wed, 26 Jun 2013 03:20:12 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id y5sm10508829lae.2.2013.06.26.03.20.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Jun 2013 03:20:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372240998.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372240998.git.Alex.Crezoff@gmail.com>
References: <cover.1372149305.git.Alex.Crezoff@gmail.com> <cover.1372240998.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQnz4jAEQp2+Kkxw96/+Z+Lx/mmIbkvY76mJpfI59Ca0PzWT0MUXdSnbjWWDpBrIfi7V2UOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229037>

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
1.8.3.1.15.g5c23c1e
