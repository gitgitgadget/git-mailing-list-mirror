From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v3 3/5] t4205 (log-pretty-format): Use `tformat` rather than `format`
Date: Mon, 19 May 2014 19:28:18 +0400
Message-ID: <86529d511be50be2ba1d9cc33575a253a52d1bae.1400513063.git.Alex.Crezoff@gmail.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 17:29:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmPUv-0004NE-Cu
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 17:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbaESP3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 11:29:00 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:39717 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbaESP27 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 11:28:59 -0400
Received: by mail-la0-f53.google.com with SMTP id ec20so4186988lab.40
        for <git@vger.kernel.org>; Mon, 19 May 2014 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xtxigmc44HDnlrXEeGBdON9K8XW+nb9V3rUGZr2ArlY=;
        b=N5LAloKwVoOzjVv0ClcoS9FGwHh1PCXAdfohwLW06IR4ND9N5nnvRLMj553FPn9+R9
         cD0vJ0W4SU/gMDdJ4u3u/RrhVm6hp6MsbPCE+fqtyY9QfY3Vjr728y60AYaJpEyeLGPy
         NeUImsDB0wO3PhQxYM4ND5LQvm9/34f+RG9iA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xtxigmc44HDnlrXEeGBdON9K8XW+nb9V3rUGZr2ArlY=;
        b=jHpeuLDEaWZlWXXAO6jFp0QpE5X80wr+Ve1P5aLT0qdH4QCX6w6e8dNpT6gCX7Y/rq
         paBtB17IhZcdeA0h2jtQkicscm6HkeeyU/deIe+LPtQnRtH56uS7N8lUY0rqMbzI0/xD
         uEynWZT3EZ0tnsw/k1L+oq7VkvIvUcWaInpJ/XnRkaR9jQqrJps+TDEY4j4oSJ7oMulC
         2TCrJFHB2qKUrttubJLgzZ8XaxXkMDrAEmvoMBTLsoeefom89w7qrBKVIn/5L5HdfFZu
         28Xq0g0Npj6KmBVMWjXZVSM8vKuFu16dvtafxQyi+ic0ZrjONrFLrPD3L9GfgYL/DAGQ
         d3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=xtxigmc44HDnlrXEeGBdON9K8XW+nb9V3rUGZr2ArlY=;
        b=haaA/C/16pdA1ayv94YYsZcIpy+4Hssf4G7KZdllObrLZfblmPUD8n0Sn6AEClpJG5
         efWL6uo6bWmzAva/M6fbJQExPRyitNB301+8MsTZqYm90w8zL0Rb748XXiHPRer4ZsW2
         oLjg1dDKmoR95PuAnebgH9pYFmdALTRXTOR/0PYc0uyvJfryqLavLD5TTbKiJONsmTmj
         J6ScJLY01KJpdDBdmylm8HTklx7H87kCplnyB+rparmPUWN5lUfeEGsJiTXX3mjQjm1Z
         yq81k6QgsNksJ+FRPC8MHEF7K4dPSZoXL5jH4SshIGX2YGpmFZ+JJcFaR/05bLGnHv07
         OVBQ==
X-Gm-Message-State: ALoCoQlreVUZNrOuwS3cSzkVXex8NxFSkurIzsIqHmN4VhUJnDPJX+Mz8U/o1DGkBHmm+TQykn6M
X-Received: by 10.152.87.176 with SMTP id az16mr17325747lab.43.1400513337594;
        Mon, 19 May 2014 08:28:57 -0700 (PDT)
Received: from localhost (ppp91-77-214-38.pppoe.mtu-net.ru. [91.77.214.38])
        by mx.google.com with ESMTPSA id mk2sm18033545lbc.8.2014.05.19.08.28.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 May 2014 08:28:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <cover.1400513063.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400513063.git.Alex.Crezoff@gmail.com>
References: <xmqqfvk9a797.fsf@gitster.dls.corp.google.com> <cover.1400513063.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249587>

Use `tformat` to avoid using of `echo` to complete end of line.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 52 +++++++++++--------------------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f5ea3f8..c03a65e 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -144,9 +144,7 @@ test_expect_success 'setup more commits' '
 '
 
 test_expect_success 'left alignment formatting' '
-	git log --pretty="format:%<(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 message two                            Z
 message one                            Z
@@ -157,9 +155,7 @@ EOF
 '
 
 test_expect_success 'left alignment formatting at the nth column' '
-	git log --pretty="format:%h %<|(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%h %<|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 $head1 message two                    Z
 $head2 message one                    Z
@@ -170,9 +166,7 @@ EOF
 '
 
 test_expect_success 'left alignment formatting with no padding' '
-	git log --pretty="format:%<(1)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(1)%s" >actual &&
 	cat <<EOF >expected &&
 message two
 message one
@@ -183,9 +177,7 @@ EOF
 '
 
 test_expect_success 'left alignment formatting with trunc' '
-	git log --pretty="format:%<(10,trunc)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(10,trunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 message ..
 message ..
@@ -196,9 +188,7 @@ EOF
 '
 
 test_expect_success 'left alignment formatting with ltrunc' '
-	git log --pretty="format:%<(10,ltrunc)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 ..sage two
 ..sage one
@@ -209,9 +199,7 @@ EOF
 '
 
 test_expect_success 'left alignment formatting with mtrunc' '
-	git log --pretty="format:%<(10,mtrunc)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(10,mtrunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 mess.. two
 mess.. one
@@ -222,9 +210,7 @@ EOF
 '
 
 test_expect_success 'right alignment formatting' '
-	git log --pretty="format:%>(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%>(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 Z                            message two
 Z                            message one
@@ -235,9 +221,7 @@ EOF
 '
 
 test_expect_success 'right alignment formatting at the nth column' '
-	git log --pretty="format:%h %>|(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%h %>|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 $head1                      message two
 $head2                      message one
@@ -248,9 +232,7 @@ EOF
 '
 
 test_expect_success 'right alignment formatting with no padding' '
-	git log --pretty="format:%>(1)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%>(1)%s" >actual &&
 	cat <<EOF >expected &&
 message two
 message one
@@ -261,9 +243,7 @@ EOF
 '
 
 test_expect_success 'center alignment formatting' '
-	git log --pretty="format:%><(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%><(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 Z             message two              Z
 Z             message one              Z
@@ -274,9 +254,7 @@ EOF
 '
 
 test_expect_success 'center alignment formatting at the nth column' '
-	git log --pretty="format:%h %><|(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%h %><|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 $head1           message two          Z
 $head2           message one          Z
@@ -287,9 +265,7 @@ EOF
 '
 
 test_expect_success 'center alignment formatting with no padding' '
-	git log --pretty="format:%><(1)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%><(1)%s" >actual &&
 	cat <<EOF >expected &&
 message two
 message one
@@ -305,9 +281,7 @@ old_head1=$(git rev-parse --verify HEAD~0)
 
 test_expect_success 'left/right alignment formatting with stealing' '
 	git commit --amend -m short --author "long long long <long@me.com>" &&
-	git log --pretty="format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
 	cat <<EOF >expected &&
 short long  long long
 message ..   A U Thor
-- 
1.9.2-15
