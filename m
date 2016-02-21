From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v2 3/5] t3034: test option to disable renames
Date: Sun, 21 Feb 2016 19:59:03 -0300
Message-ID: <1456095545-20201-4-git-send-email-felipegassis@gmail.com>
References: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 00:00:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXczj-0001sX-SX
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbcBUXAq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 18:00:46 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35108 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbcBUXAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:00:45 -0500
Received: by mail-qk0-f170.google.com with SMTP id o6so50245352qkc.2
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 15:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zXmGRIJ1ZH92tLrut7EeRMCWeZ/NwEKPka0oP1BTVCU=;
        b=GjB+vSrjjlz2ajMZVovhg7AV8OxMnXVFM3jOBKUaT6p+CpQJkbsOnuzV43Qs5B0Ubm
         Jq1qXjtJ0YkZF1ehccygdP377WrAgfbDUtfEYlbkca1M93PTq8OX8w1+957svpsckx2O
         BA3LrVgnwL432Da6jUT8i5fMmIV1IMl/eyeCfSdB21uJU/CMMeqE4N41zQFqH4cM5Dym
         /IgN5RzhZjLx9d8E3dLGFCFWSpjQJHU9VCD9Pxe9hu5mXbSVjSb31/BCF8qlBNrM3MY0
         l3zvSaoFEu60RtEJvK0YSm8nqWByj5BhZVXwRv/OsnfKDj9BJQUFyo86x9WchgIxAnaz
         aqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=zXmGRIJ1ZH92tLrut7EeRMCWeZ/NwEKPka0oP1BTVCU=;
        b=gci2Z8BqBTY+TmN8XJO2J4S9/ZWUprUorthqT7lNCHfNpyR9f5XxEIzFZTZNB4EDpq
         9jPqeZLtEPRvgG93x8F8l1GlS4QAPhcQrfibxUzqXrswPP83w34vn2IQKEoT55dC/a7c
         OnD3n7V0m4UdUrPCP0e10tlHwruY+4VaPCy/GLf9u9lnEq9ubM45WTfh7WklHYVsXuur
         RDvc+NFkxRXkBjimYcr9WIOIx7vwHRaGJ11VkzCQjDRBDJewLMVxfrk4zDUE1bymTfQu
         4wb9GfW5fuWXfzw0O7OMxoteqGwE8lqx0S9mqFnghVQbGika0a/XRnFl4Vgzhlj/hMNC
         9Tfg==
X-Gm-Message-State: AG10YOR6IuhF2fLcK52LgiCkCjVkTM8i0fV6YEHWkL2wedow0OYEWLxDGNNdTpVji2pvvQ==
X-Received: by 10.55.24.141 with SMTP id 13mr19586204qky.45.1456095645093;
        Sun, 21 Feb 2016 15:00:45 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id f83sm9177201qkb.25.2016.02.21.15.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 15:00:44 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286834>

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 t/t3034-merge-recursive-rename-options.sh | 28 +++++++++++++++++++++++=
+++++
 1 file changed, 28 insertions(+)

diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
index 7ae7f83..a459236 100755
--- a/t/t3034-merge-recursive-rename-options.sh
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -68,6 +68,14 @@ check_find_renames_100 () {
 	rename_undetected d
 }
=20
+check_no_renames () {
+	check_common &&
+	rename_undetected a &&
+	rename_undetected b &&
+	rename_undetected c &&
+	rename_undetected d
+}
+
 test_expect_success setup '
 	cat <<-\EOF >a-old &&
 	aa1
@@ -126,12 +134,30 @@ test_expect_success 'rename threshold is truncate=
d' '
 	check_find_renames_100
 '
=20
+test_expect_success 'disabled rename detection' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --no-renames HEAD^ -- HEAD master &&
+	check_no_renames
+'
+
 test_expect_success 'last wins in --find-renames=3D<m> --find-renames=3D=
<n>' '
 	git read-tree --reset -u HEAD &&
 	test_must_fail git merge-recursive --find-renames=3D25 --find-renames=
=3D75 HEAD^ -- HEAD master &&
 	check_find_renames_75
 '
=20
+test_expect_success 'last wins in --no-renames --find-renames' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --no-renames --find-renames HEAD^ =
-- HEAD master &&
+	check_find_renames_50
+'
+
+test_expect_success 'last wins in --find-renames --no-renames' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --find-renames --no-renames HEAD^ -- HEAD master =
&&
+	check_no_renames
+'
+
 test_expect_success 'assumption for further tests: trivial merge succe=
eds' '
 	git read-tree --reset -u HEAD &&
 	git merge-recursive HEAD -- HEAD HEAD &&
@@ -141,6 +167,8 @@ test_expect_success 'assumption for further tests: =
trivial merge succeeds' '
 	git merge-recursive --find-renames=3D75 HEAD -- HEAD HEAD &&
 	git diff --quiet --cached &&
 	git merge-recursive --find-renames=3D100% HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --no-renames HEAD -- HEAD HEAD &&
 	git diff --quiet --cached
 '
=20
--=20
2.7.1.492.gd821b20
