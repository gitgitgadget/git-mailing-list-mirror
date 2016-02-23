From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 1/3] t3034: add rename threshold tests
Date: Tue, 23 Feb 2016 01:38:43 -0300
Message-ID: <1456202325-6037-2-git-send-email-felipegassis@gmail.com>
References: <1456202325-6037-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 05:41:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY4me-0007PB-0h
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 05:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757282AbcBWElF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 23:41:05 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34720 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757262AbcBWElC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 23:41:02 -0500
Received: by mail-vk0-f53.google.com with SMTP id e185so150559559vkb.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 20:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TRiwCAskcPUYadFasfoMDAoyvdn5H0ElmJ8JORqgJCI=;
        b=wGWHgByQe2OKAY9sCH9phUp+EqHINZsFeYyG5Pu7qpDsIHBKY250P6fM12cjKmxZ1Q
         rVw6ZuNX8yHX7c/XVHJnnBfbgrVes2rNFsWgZ8MszgISo0k4O876QbojSXtBzJ0RX1Db
         yGlr4tAgVx3zBrPLwA8abyzJr0XPGgqTYez41jUdb5IG9cVtChxDnUeyN3CvKDN7tC/Z
         5oxcP4KBqcwLGKtDzRdnmM06QrF1giOX/uDDFP9/Imgy1rKDAqpO06tEZKaeG1CRz1w0
         AqI0e2in6dLOrUVGJGkUhrufq/V7LhsCoO75zhMNf/xHKqExn+Of/T3bGsk0E2rURs5g
         8Htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=TRiwCAskcPUYadFasfoMDAoyvdn5H0ElmJ8JORqgJCI=;
        b=YEjPNTRr6E+a4NfGrUAa1lgd4Ny+E+quVLnZNmgYY/gw6lTN2logdq+efHLHkAJqHm
         bG3yakb4U16RzsAiOsNYOE1ws8FXInESFelVykVr6jqZkq0AO1f3BelEy5id5trRIpa+
         Xke1nmUbrtjWvOH4VeCAAg9D68IXArK7Og3LDBVX7sY6H1zM8laRcNEuJvfBBPlmvPpZ
         97ErwRNGjw7FcQgcsPR5MMyywZlWFGWvEejxPCu6QBaulCGc7Xuwsu4s7SqTUIDDXzXO
         7l06pk2ex+NmxxI0CYwUKS5cRNGBmXWIKqd+ioBdua8hEkvPP+oh5SZ/CYFT1LltxfcU
         O/uA==
X-Gm-Message-State: AG10YOQ9W73bAy59KJ6WbwzLH2LjA+7ezIz5n3cjIOLnf5FVbbwlbeFIIePgX6dynz44Kw==
X-Received: by 10.31.8.142 with SMTP id 136mr6848888vki.14.1456202461644;
        Mon, 22 Feb 2016 20:41:01 -0800 (PST)
Received: from traveller.moon (201-43-158-89.dsl.telesp.net.br. [201.43.158.89])
        by smtp.gmail.com with ESMTPSA id o141sm3772201vkd.19.2016.02.22.20.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 20:41:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456202325-6037-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287011>

10ae752 (merge-recursive: option to specify rename threshold,
2010-09-27) introduced this feature but did not include any tests.

The tests use the new option --find-renames, which replaces the then
introduced and now deprecated option --rename-threshold.

Also update name and description of t3032 for consistency:
"merge-recursive options" -> "merge-recursive space options"

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 ...s.sh =3D> t3032-merge-recursive-space-options.sh} |   2 +-
 t/t3034-merge-recursive-rename-options.sh          | 235 +++++++++++++=
++++++++
 2 files changed, 236 insertions(+), 1 deletion(-)
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
index 0000000..66fee8a
--- /dev/null
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -0,0 +1,235 @@
+#!/bin/sh
+
+test_description=3D'merge-recursive rename options
+
+Test rename detection by examining rename/delete conflicts.
+
+* (HEAD -> rename) rename
+| * (master) delete
+|/
+* base
+
+git diff --name-status base master
+D	0-old
+D	1-old
+D	2-old
+D	3-old
+
+git diff --name-status -M01 base rename
+R025    0-old   0-new
+R050    1-old   1-new
+R075    2-old   2-new
+R100    3-old   3-new
+
+Actual similarity indices are parsed from diff output. We rely on the =
fact that
+they are rounded down (see, e.g., Documentation/diff-generate-patch.tx=
t, which
+mentions this in a different context).
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
+check_threshold_0 () {
+	check_common &&
+	rename_detected 0 &&
+	rename_detected 1 &&
+	rename_detected 2 &&
+	rename_detected 3
+}
+
+check_threshold_1 () {
+	check_common &&
+	rename_undetected 0 &&
+	rename_detected 1 &&
+	rename_detected 2 &&
+	rename_detected 3
+}
+
+check_threshold_2 () {
+	check_common &&
+	rename_undetected 0 &&
+	rename_undetected 1 &&
+	rename_detected 2 &&
+	rename_detected 3
+}
+
+check_exact_renames () {
+	check_common &&
+	rename_undetected 0 &&
+	rename_undetected 1 &&
+	rename_undetected 2 &&
+	rename_detected 3
+}
+
+test_expect_success 'setup 1/2: basic setup' '
+	cat <<-\EOF >3-old &&
+	33a
+	33b
+	33c
+	33d
+	EOF
+	sed s/33/22/ <3-old >2-old &&
+	sed s/33/11/ <3-old >1-old &&
+	sed s/33/00/ <3-old >0-old &&
+	git add [0-3]-old &&
+	git commit -m base &&
+	git rm [0-3]-old &&
+	git commit -m delete &&
+	git checkout -b rename HEAD^ &&
+	cp 3-old 3-new &&
+	sed 1,1s/./x/ <2-old >2-new &&
+	sed 1,2s/./x/ <1-old >1-new &&
+	sed 1,3s/./x/ <0-old >0-new &&
+	git add [0-3]-new &&
+	git rm [0-3]-old &&
+	git commit -m rename &&
+	get_expected_stages 0 &&
+	get_expected_stages 1 &&
+	get_expected_stages 2 &&
+	get_expected_stages 3 &&
+	check_50=3D"false" &&
+	tail=3D"HEAD^ -- HEAD master"
+'
+
+test_expect_success 'setup 2/2: threshold array' '
+	git diff --name-status -M01 HEAD^ HEAD >diff-output &&
+	test_debug "cat diff-output" &&
+	test_line_count =3D 4 diff-output &&
+	grep "R[0-9]\{3\}	\([0-3]\)-old	\1-new" diff-output \
+		>grep-output &&
+	test_cmp diff-output grep-output &&
+	while read status old new
+	do
+		th[${old:0:1}]=3D${status:1}
+	done <diff-output &&
+	test "${th[0]}" -lt "${th[1]}" &&
+	test "${th[1]}" -lt "${th[2]}" &&
+	test "${th[2]}" -lt "${th[3]}" &&
+	test "${th[3]}" =3D 100 &&
+	if [ 50 -le "${th[0]}" ]; then
+		check_50=3Dcheck_threshold_0
+	elif [ 50 -le "${th[1]}" ]; then
+		check_50=3Dcheck_threshold_1
+	elif [ 50 -le "${th[2]}" ]; then
+		check_50=3Dcheck_threshold_2
+	fi &&
+	th[0]+=3D"%" &&
+	th[1]+=3D"%" &&
+	th[2]+=3D"%" &&
+	th[3]+=3D"%"
+'
+
+test_expect_success 'assumption for tests: rename detection with diff'=
 '
+	git diff --name-status -M${th[0]} --diff-filter=3DR HEAD^ HEAD \
+		>diff-output-0 &&
+	git diff --name-status -M${th[1]} --diff-filter=3DR HEAD^ HEAD \
+		>diff-output-1 &&
+	git diff --name-status -M${th[2]} --diff-filter=3DR HEAD^ HEAD \
+		>diff-output-2 &&
+	git diff --name-status -M100% --diff-filter=3DR HEAD^ HEAD \
+		>diff-output-3 &&
+	test_line_count =3D 4 diff-output-0 &&
+	test_line_count =3D 3 diff-output-1 &&
+	test_line_count =3D 2 diff-output-2 &&
+	test_line_count =3D 1 diff-output-3
+'
+
+test_expect_success 'default similarity threshold is 50%' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive $tail &&
+	$check_50
+'
+
+test_expect_success 'low rename threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D${th[0]} $tail &&
+	check_threshold_0
+'
+
+test_expect_success 'medium rename threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D${th[1]} $tail &&
+	check_threshold_1
+'
+
+test_expect_success 'high rename threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D${th[2]} $tail &&
+	check_threshold_2
+'
+
+test_expect_success 'exact renames only' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D100% $tail &&
+	check_exact_renames
+'
+
+test_expect_success 'rename threshold is truncated' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D200% $tail &&
+	check_exact_renames
+'
+
+test_expect_success 'last wins in --find-renames=3D<m> --find-renames=3D=
<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive \
+		--find-renames=3D${th[0]} --find-renames=3D${th[2]} $tail &&
+	check_threshold_2
+'
+
+test_expect_success '--find-renames resets threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive \
+		--find-renames=3D${th[0]} --find-renames $tail &&
+	$check_50
+'
+
+test_expect_success 'assumption for further tests: trivial merge succe=
eds' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --find-renames=3D${th[0]} HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --find-renames=3D${th[2]} HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --find-renames=3D100% HEAD -- HEAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success '--find-renames rejects negative argument' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D-${th[0]} \
+		HEAD -- HEAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success '--find-renames rejects non-numbers' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D0xf \
+		HEAD -- HEAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_done
--=20
2.7.1.492.gd821b20
