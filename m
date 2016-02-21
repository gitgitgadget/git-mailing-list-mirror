From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v2 4/5] t3034: test deprecated interface
Date: Sun, 21 Feb 2016 19:59:04 -0300
Message-ID: <1456095545-20201-5-git-send-email-felipegassis@gmail.com>
References: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 00:00:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXczm-0001wH-N0
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbcBUXAu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 18:00:50 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34192 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbcBUXAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:00:48 -0500
Received: by mail-qk0-f182.google.com with SMTP id x1so50116311qkc.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 15:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qDkGU5aG5uH91MvNFYjSYe+WRcw6Ka4hT6d+Ei+El3w=;
        b=XTekXL0vHtrtX/LIVODTQ8crVmIEVUtpQBxCF6elWpWbVEmd2h3X83l2bnyaRza8/j
         +gZoy+P5x4OaDbZBYkUG0Gqn9HXEigI2ih83y1oPvbwiGhP/FQGR9vnt3/uBdby3eQ9x
         jMr7zqIT4eLCWj/lfWuZUG8C4ynJ+VKgg2YYvE2em9HZJggUc8t8ZpzVcRajsijyewig
         ZS9Acyfhnk7gFWbjlkC2pmMKZVLaYP3zMGZCxNfJQ4CI5hYi1cP2ArLc58Gg+dIPlMTr
         h/4WyL54PKV/yvdcCGS2Ehat+aPEjd9bgcsO+4hi8wS5Ra8IZuspzK4xBCg3/JcIiWyG
         0Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=qDkGU5aG5uH91MvNFYjSYe+WRcw6Ka4hT6d+Ei+El3w=;
        b=JHnsQstq9mxbQ9zp3aq8hmyJCovp3Yqj4DSTBiTxZUigySyGicAHeusIsm70xx1+hd
         jR0LiPfrvupp2NdyxzclNgpu3B1YMMuCtZZNFthJyT8oX/tnwdSo7ZkAQhdr5IhhzJsy
         K90UcIekF/cSynhjAXc27Xf8MdhS+/3wn4+BosJKaiD0AY5YqksPqKiMzclU3Wi2yFRf
         PlF6lFRHGeeP1hnHG6TaEieSM5cpT0AF/Uja30o2BzfXuZOH6AxsJ7ePYXvvR2GNFS1y
         3zXUH93AZMwzMAOqgzDL54TkapydnewuRT32wnhsTYVVwky4rjFl3Atf6om9kJ3Cpvvz
         86Yw==
X-Gm-Message-State: AG10YOQksXo6ub904Jw744cAhzUpzDc66VEdyH6RvGmPWjkUh0VmpYoM/5n4RNcQ8grS4g==
X-Received: by 10.55.82.214 with SMTP id g205mr30647166qkb.72.1456095647822;
        Sun, 21 Feb 2016 15:00:47 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id f83sm9177201qkb.25.2016.02.21.15.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 15:00:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286837>

--find-renames=3D and --rename-threshold=3D should be aliases.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---

Now includes tests with invalid arguments to --rename-threshold=3D

 t/t3034-merge-recursive-rename-options.sh | 42 +++++++++++++++++++++++=
++++++++
 1 file changed, 42 insertions(+)

diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
index a459236..d4f9742 100755
--- a/t/t3034-merge-recursive-rename-options.sh
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -184,4 +184,46 @@ test_expect_success '--find-renames rejects non-nu=
mbers' '
 	git diff --quiet --cached
 '
=20
+test_expect_success 'rename-threshold=3D<n> is a synonym for find-rena=
mes=3D<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D25 HEAD^ -- H=
EAD master &&
+	check_find_renames_25
+'
+
+test_expect_success 'last wins in --no-renames --rename-threshold=3D<n=
>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --no-renames --rename-threshold=3D=
25 HEAD^ -- HEAD master &&
+	check_find_renames_25
+'
+
+test_expect_success 'last wins in --rename-threshold=3D<n> --no-rename=
s' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --rename-threshold=3D25 --no-renames HEAD^ -- HEA=
D master &&
+	check_no_renames
+'
+
+test_expect_success '--rename-threshold=3D<n> rejects negative argumen=
t' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D-25 HEAD -- H=
EAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success '--rename-threshold=3D<n> rejects non-numbers' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D0xf HEAD -- H=
EAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success 'last wins in --rename-threshold=3D<m> --find-rena=
mes=3D<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D25 --find-ren=
ames=3D75 HEAD^ -- HEAD master &&
+	check_find_renames_75
+'
+
+test_expect_success 'last wins in --find-renames=3D<m> --rename-thresh=
old=3D<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D75 --rename-thres=
hold=3D25 HEAD^ -- HEAD master &&
+	check_find_renames_25
+'
+
 test_done
--=20
2.7.1.492.gd821b20
