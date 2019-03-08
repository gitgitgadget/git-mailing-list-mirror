Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE1120248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfCHKRs (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:17:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47047 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfCHKRs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:17:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so13821826pfh.13
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EKgHzIYEWWbRPKsAxyMoLYv00IFdaIumDQwgyFnoUDQ=;
        b=oxsOJWErDppqkIcJ8OVBbzibjOsdXPw4fgnk6Qoo1QEv0R1GaPRwwu5DWUMy2bkPPz
         2BgrV5cjA8UApYOAFVxMkM7ZXpNh0fOD4sC1fiu9sJKzLkzHFaZN6sSV7oqE0Vhc3wlS
         5ztjKRrpyYmahK3xKxX+7cbpPCPrLbxhdDQ6sxi0A2asnVE0V9PvRoVX/kN95xHTYazT
         /NQnkBFoVOZxjIYwBURR497BmAKfraTKGUiafNX9xVBA2AwtVkxJzfgm8Zk38CBg1zSC
         ENK2zmtSh74nlGT8RAoca7YObItdi/6jTx+aIqie5tmKJuiORQ4+Qhu52lTJDhwmKR/1
         wU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKgHzIYEWWbRPKsAxyMoLYv00IFdaIumDQwgyFnoUDQ=;
        b=HRkBD5oBH49zoaKdceHyo8JSJAG7i4yp/8LktkO1lIKq88m9/1kof7aCnmRsC+S0Sk
         rSSoDMx9WBwS5aK+OyCwUIpePa9P3H2TTXIKhGC6M1prDt8Uu31TNUQjubM9QUbbuCdk
         iZSjIbRwf8bUtW7Wv+5P7k9kfVoLOwzk6mAxUyR5kYvbXxGLSmMnUK2Z6jpZiliu2L4+
         jHEh+YoblS1HCoX0BuIpyLBNCweIyjZfDsUvvddK9mMdtgKC9+p2X0L2SJ53TKJKCi6j
         eh+p7UV4swLxirCP1KD9cjugTO0KV2IiDeGqlAPtTE6TJw4c7U3zYgQGY4ontRmxfCUM
         PEGQ==
X-Gm-Message-State: APjAAAUGwWshVayOPD5xjNes9laWt/kCIHp4PSxrhATKinDCyCPx64Dv
        o6XSO2sTMmQV71sDKoMvI4cwHv3o
X-Google-Smtp-Source: APXvYqzIssvQRz2H97odEO0to83lB6TYDmHpMbsl8lBsnsVXbDd6kzm9kVvk2xCPnV5Wrptjr49UwA==
X-Received: by 2002:a17:902:8b8b:: with SMTP id ay11mr18105494plb.162.1552040267104;
        Fri, 08 Mar 2019 02:17:47 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id e21sm17787259pfh.45.2019.03.08.02.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 02:17:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 17:17:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 09/11] t: add tests for restore
Date:   Fri,  8 Mar 2019 17:16:53 +0700
Message-Id: <20190308101655.9767-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308101655.9767-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/lib-patch-mode.sh               |  12 ++++
 t/t2070-restore.sh (new +x)       |  77 ++++++++++++++++++++++
 t/t2071-restore-patch.sh (new +x) | 105 ++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)

diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
index 06c3c91762..cfd76bf987 100644
--- a/t/lib-patch-mode.sh
+++ b/t/lib-patch-mode.sh
@@ -2,28 +2,40 @@
 
 . ./test-lib.sh
 
+# set_state <path> <worktree-content> <index-content>
+#
+# Prepare the content for path in worktree and the index as specified.
 set_state () {
 	echo "$3" > "$1" &&
 	git add "$1" &&
 	echo "$2" > "$1"
 }
 
+# save_state <path>
+#
+# Save index/worktree content of <path> in the files _worktree_<path>
+# and _index_<path>
 save_state () {
 	noslash="$(echo "$1" | tr / _)" &&
 	cat "$1" > _worktree_"$noslash" &&
 	git show :"$1" > _index_"$noslash"
 }
 
+# set_and_save_state <path> <worktree-content> <index-content>
 set_and_save_state () {
 	set_state "$@" &&
 	save_state "$1"
 }
 
+# verify_state <path> <expected-worktree-content> <expected-index-content>
 verify_state () {
 	test "$(cat "$1")" = "$2" &&
 	test "$(git show :"$1")" = "$3"
 }
 
+# verify_saved_state <path>
+#
+# Call verify_state with expected contents from the last save_state
 verify_saved_state () {
 	noslash="$(echo "$1" | tr / _)" &&
 	verify_state "$1" "$(cat _worktree_"$noslash")" "$(cat _index_"$noslash")"
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
new file mode 100755
index 0000000000..df91bf54bc
--- /dev/null
+++ b/t/t2070-restore.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+
+test_description='restore basic functionality'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit first &&
+	echo first-and-a-half >>first.t &&
+	git add first.t &&
+	test_commit second &&
+	echo one >one &&
+	echo two >two &&
+	echo untracked >untracked &&
+	echo ignored >ignored &&
+	echo /ignored >.gitignore &&
+	git add one two .gitignore &&
+	git update-ref refs/heads/one master
+'
+
+test_expect_success 'restore without pathspec is not ok' '
+	test_must_fail git restore &&
+	test_must_fail git restore --source=first
+'
+
+test_expect_success 'restore -p without pathspec is fine' '
+	echo q >cmd &&
+	git restore -p <cmd
+'
+
+test_expect_success 'restore a file, ignoring branch of same name' '
+	cat one >expected &&
+	echo dirty >>one &&
+	git restore one &&
+	test_cmp expected one
+'
+
+test_expect_success 'restore a file on worktree from another branch' '
+	test_when_finished git reset --hard &&
+	git cat-file blob first:./first.t >expected &&
+	git restore --source=first first.t &&
+	test_cmp expected first.t &&
+	git cat-file blob HEAD:./first.t >expected &&
+	git show :first.t >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'restore a file in the index from another branch' '
+	test_when_finished git reset --hard &&
+	git cat-file blob first:./first.t >expected &&
+	git restore --source=first --index first.t &&
+	git show :first.t >actual &&
+	test_cmp expected actual &&
+	git cat-file blob HEAD:./first.t >expected &&
+	test_cmp expected first.t
+'
+
+test_expect_success 'restore a file in both the index and worktree from another branch' '
+	test_when_finished git reset --hard &&
+	git cat-file blob first:./first.t >expected &&
+	git restore --source=first --index --worktree first.t &&
+	git show :first.t >actual &&
+	test_cmp expected actual &&
+	test_cmp expected first.t
+'
+
+test_expect_success 'restore --index uses HEAD as source' '
+	test_when_finished git reset --hard &&
+	git cat-file blob :./first.t >expected &&
+	echo index-dirty >>first.t &&
+	git add first.t &&
+	git restore --index first.t &&
+	git cat-file blob :./first.t >actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
new file mode 100755
index 0000000000..46ebcb2413
--- /dev/null
+++ b/t/t2071-restore-patch.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+
+test_description='git restore --patch'
+
+. ./lib-patch-mode.sh
+
+test_expect_success PERL 'setup' '
+	mkdir dir &&
+	echo parent >dir/foo &&
+	echo dummy >bar &&
+	git add bar dir/foo &&
+	git commit -m initial &&
+	test_tick &&
+	test_commit second dir/foo head &&
+	set_and_save_state bar bar_work bar_index &&
+	save_head
+'
+
+# note: bar sorts before dir/foo, so the first 'n' is always to skip 'bar'
+
+test_expect_success PERL 'saying "n" does nothing' '
+	set_and_save_state dir/foo work head &&
+	test_write_lines n n | git restore -p &&
+	verify_saved_state bar &&
+	verify_saved_state dir/foo
+'
+
+test_expect_success PERL 'git restore -p' '
+	set_and_save_state dir/foo work head &&
+	test_write_lines n y | git restore -p &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success PERL 'git restore -p with staged changes' '
+	set_state dir/foo work index &&
+	test_write_lines n y | git restore -p &&
+	verify_saved_state bar &&
+	verify_state dir/foo index index
+'
+
+test_expect_success PERL 'git restore -p --source=HEAD' '
+	set_state dir/foo work index &&
+	# the third n is to get out in case it mistakenly does not apply
+	test_write_lines n y n | git restore -p --source=HEAD &&
+	verify_saved_state bar &&
+	verify_state dir/foo head index
+'
+
+test_expect_success PERL 'git restore -p --source=HEAD^' '
+	set_state dir/foo work index &&
+	# the third n is to get out in case it mistakenly does not apply
+	test_write_lines n y n | git restore -p --source=HEAD^ &&
+	verify_saved_state bar &&
+	verify_state dir/foo parent index
+'
+
+test_expect_success PERL 'git restore -p handles deletion' '
+	set_state dir/foo work index &&
+	rm dir/foo &&
+	test_write_lines n y | git restore -p &&
+	verify_saved_state bar &&
+	verify_state dir/foo index index
+'
+
+# The idea in the rest is that bar sorts first, so we always say 'y'
+# first and if the path limiter fails it'll apply to bar instead of
+# dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
+# the failure case (and thus get out of the loop).
+
+test_expect_success PERL 'path limiting works: dir' '
+	set_state dir/foo work head &&
+	test_write_lines y n | git restore -p dir &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success PERL 'path limiting works: -- dir' '
+	set_state dir/foo work head &&
+	test_write_lines y n | git restore -p -- dir &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
+	set_state dir/foo work head &&
+	# the third n is to get out in case it mistakenly does not apply
+	test_write_lines y n n | git restore -p --source=HEAD^ -- dir &&
+	verify_saved_state bar &&
+	verify_state dir/foo parent head
+'
+
+test_expect_success PERL 'path limiting works: foo inside dir' '
+	set_state dir/foo work head &&
+	# the third n is to get out in case it mistakenly does not apply
+	test_write_lines y n n | (cd dir && git restore -p foo) &&
+	verify_saved_state bar &&
+	verify_state dir/foo head head
+'
+
+test_expect_success PERL 'none of this moved HEAD' '
+	verify_saved_head
+'
+
+test_done
-- 
2.21.0.rc1.337.gdf7f8d0522

