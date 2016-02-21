From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v2 2/5] t3034: add rename threshold tests
Date: Sun, 21 Feb 2016 19:59:02 -0300
Message-ID: <1456095545-20201-3-git-send-email-felipegassis@gmail.com>
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
	id 1aXczj-0001sX-4F
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbcBUXAp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 18:00:45 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33367 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbcBUXAn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:00:43 -0500
Received: by mail-qk0-f172.google.com with SMTP id s5so50159235qkd.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CnaxEiP3U5hyuypWRSep0QFeQO0EX/u91rWb015kKY0=;
        b=NJYP4MMHNUsKepisAzrHeh0lZ+Gp4c1jqgw1tgOhLym5bL5LUq/zeqb0/R3ac0d5NX
         rIYQ+l32JrMCo3eEyshr9JHxeDkzrowATC1jOjST8vpshHcyvp1UgsM49YG1oRqHQQA+
         rKErP0LxaDmqHV8qZm216VGmnF3JKjjlQLO/jAY6WpM7CRbBSpAP+/5AESzXxgzl6tVh
         slV4nizBm+Iery+qohbd+KzkYrrYwnYYZH2RDyP4qrCpV4+5ErwSMQStlz1kmfvWBDxE
         1Rj2mUfN90/GhlNygZwKiFUqnAkkum+yHBeM6+E1bJQu/raYCLrzeY/0TBJ/4XmXTC4F
         MWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=CnaxEiP3U5hyuypWRSep0QFeQO0EX/u91rWb015kKY0=;
        b=li4ZwnXUPikesf2GE7XZ1nBoob8bFHySQH8XfdZD+/j7DyFf0gf/zKJC7gNh5BPPNm
         V4q8B4GIQjIaDjHo2gswZAd6U6j1RcyOmcOOUhXz7Ps4Rg8vX9iwAoqmKgoq//ZUTrYc
         hmDJQTSfNa+ZB3PJA/igW5HPGBBCAAVr3PahvOLnT3HcE0CEa3v4yRHonNYrU5Psn7bw
         qxhMVO1UETQb8VGpKCFI7WU3+iO4iX1xg6y4uv4/MnHhd08mJ/rMGwUkpluB9qAxmIgo
         eHxcWFSPSLl5O9S5xSYJj5AXM6KaYjPo0PsfanvVQvQkgM3n1fXdnZdSLLgW92Tb6IPX
         HMiQ==
X-Gm-Message-State: AG10YOSIDWt89Y+xxkdO84ZlYAJWgqU25ye9tma0tRQ4Y1RGOX2jKtud8bujxX7FJpgRRA==
X-Received: by 10.55.77.202 with SMTP id a193mr30548574qkb.48.1456095642896;
        Sun, 21 Feb 2016 15:00:42 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id f83sm9177201qkb.25.2016.02.21.15.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 15:00:42 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456095545-20201-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286835>

10ae752 (merge-recursive: option to specify rename threshold,
2010-09-27) introduced this feature but did not include any tests.

The tests use the new option --find-renames, which replaces the then
introduced and now deprecated option --rename-threshold.

Also update name and description of t3032 for consistency:
"merge-recursive options" -> "merge-recursive space options"

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---

Now this already introduces the final names and descriptions for the te=
sts.

The test for threshold truncation was kept for now. Please confirm whet=
her it is
desirable.

New tests were added at the end to check that invalid arguments to find=
-renames=3D
such as negative and non-numbers error out.

 ...s.sh =3D> t3032-merge-recursive-space-options.sh} |   2 +-
 t/t3034-merge-recursive-rename-options.sh          | 159 +++++++++++++=
++++++++
 2 files changed, 160 insertions(+), 1 deletion(-)
 rename t/{t3032-merge-recursive-options.sh =3D> t3032-merge-recursive-=
space-options.sh} (99%)
 create mode 100755 t/t3034-merge-recursive-rename-options.sh

diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursi=
ve-space-options.sh
similarity index 99%
rename from t/t3032-merge-recursive-options.sh
rename to t/t3032-merge-recursive-space-options.sh
index 4029c9c..b56180e 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-space-options.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
=20
-test_description=3D'merge-recursive options
+test_description=3D'merge-recursive space options
=20
 * [master] Clarify
  ! [remote] Remove cruft
diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
new file mode 100755
index 0000000..7ae7f83
--- /dev/null
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -0,0 +1,159 @@
+#!/bin/sh
+
+test_description=3D'merge-recursive rename options
+
+Test rename detection by examining rename/delete conflicts.
+
+Similarity index:
+R100 a-old a-new
+R075 b-old b-new
+R050 c-old c-new
+R025 d-old d-new
+'
+
+. ./test-lib.sh
+
+get_expected_stages () {
+	git checkout rename -- $1-new &&
+	git ls-files --stage $1-new >expected-stages-undetected-$1 &&
+	sed "s/ 0	/ 2	/" <expected-stages-undetected-$1 \
+		>expected-stages-detected-$1 &&
+	git read-tree -u --reset HEAD
+}
+
+rename_detected () {
+	git ls-files --stage $1-old $1-new >stages-actual-$1 &&
+	test_cmp expected-stages-detected-$1 stages-actual-$1
+}
+
+rename_undetected () {
+	git ls-files --stage $1-old $1-new >stages-actual-$1 &&
+	test_cmp expected-stages-undetected-$1 stages-actual-$1
+}
+
+check_common () {
+	git ls-files --stage >stages-actual &&
+	test_line_count =3D 4 stages-actual
+}
+
+check_find_renames_25 () {
+	check_common &&
+	rename_detected a &&
+	rename_detected b &&
+	rename_detected c &&
+	rename_detected d
+}
+
+check_find_renames_50 () {
+	check_common &&
+	rename_detected a &&
+	rename_detected b &&
+	rename_detected c &&
+	rename_undetected d
+}
+
+check_find_renames_75 () {
+	check_common &&
+	rename_detected a &&
+	rename_detected b &&
+	rename_undetected c &&
+	rename_undetected d
+}
+
+check_find_renames_100 () {
+	check_common &&
+	rename_detected a &&
+	rename_undetected b &&
+	rename_undetected c &&
+	rename_undetected d
+}
+
+test_expect_success setup '
+	cat <<-\EOF >a-old &&
+	aa1
+	aa2
+	aa3
+	aa4
+	EOF
+	sed s/aa/bb/ <a-old >b-old &&
+	sed s/aa/cc/ <a-old >c-old &&
+	sed s/aa/dd/ <a-old >d-old &&
+	git add [a-d]-old &&
+	git commit -m base &&
+	git rm [a-d]-old &&
+	git commit -m delete &&
+	git checkout -b rename HEAD^ &&
+	cp a-old a-new &&
+	sed 1,1s/./x/ <b-old >b-new &&
+	sed 1,2s/./x/ <c-old >c-new &&
+	sed 1,3s/./x/ <d-old >d-new &&
+	git add [a-d]-new &&
+	git rm [a-d]-old &&
+	git commit -m rename &&
+	get_expected_stages a &&
+	get_expected_stages b &&
+	get_expected_stages c &&
+	get_expected_stages d
+'
+
+test_expect_success 'default similarity threshold is 50%' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive HEAD^ -- HEAD master &&
+	check_find_renames_50
+'
+
+test_expect_success 'low rename threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D25 HEAD^ -- HEAD =
master &&
+	check_find_renames_25
+'
+
+test_expect_success 'high rename threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D75 HEAD^ -- HEAD =
master &&
+	check_find_renames_75
+'
+
+test_expect_success 'exact renames only' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D100% HEAD^ -- HEA=
D master &&
+	check_find_renames_100
+'
+
+test_expect_success 'rename threshold is truncated' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D200% HEAD^ -- HEA=
D master &&
+	check_find_renames_100
+'
+
+test_expect_success 'last wins in --find-renames=3D<m> --find-renames=3D=
<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D25 --find-renames=
=3D75 HEAD^ -- HEAD master &&
+	check_find_renames_75
+'
+
+test_expect_success 'assumption for further tests: trivial merge succe=
eds' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --find-renames=3D25 HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --find-renames=3D75 HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --find-renames=3D100% HEAD -- HEAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success '--find-renames rejects negative argument' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D-25 HEAD -- HEAD =
HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success '--find-renames rejects non-numbers' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D0xf HEAD -- HEAD =
HEAD &&
+	git diff --quiet --cached
+'
+
+test_done
--=20
2.7.1.492.gd821b20
