Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067039;
	b=QqWQCNhF0qkPCVpODdhBrXP6l9ReQtkULVoKZmRcRmPS85IwbsVfekeQWVlmFS1CawV3
	 WoJTIT/eO34B7SQj2+pvun7XUtvT4BWOa4DbTaVWv40RUNQly/mxjGXRna5oSgtIxBlmF
	 7xdZ+74tz3rP7mZFLo4kQXW8q7rVNrbwXa+OQImL5Ixu0FmEVXHEz6tiDRLPKhDlZnR0s
	 9QV4LhoO4SO73k78+bPATqeAekqCOrStakANfj70iB56el2wSwDkSEbsaU9XImiJCimkf
	 U1whtd5C7dKYhczpcd2hT+yArXMdXX6tkNmpNQR14TJ0osO+6780jy/V6JBU7r3Uorw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=WXWBh2yCYzxwcsaq38V0SgxjAEG7903dPnuFBpVvc7g=;
	b=pl1/G/Cm2j87eg23iylJ5Kd+Jo0BHc8NfG/naglpi9tkSNFSVGvMy+NelWuegcZqmOAS
	 qjfULshKKrXyZdQO4hK/vs/JTsj/fBVhVrEX4At6KUN6bWb0NZtXLp9w8rRZaK6UKU/tf
	 Z8wQVaoPB6SF7g6jazLCvWfkUhrqgKIyXNO5qRjprRL0bYqAtsjsqcy8yvmLBs7wMrCzG
	 H6X1XDzce+Aq+gy2jSgmJmUO2tMriRg16jAHpr3LKAXPJ89pxVt8VkpxK6KvqIasyRqGC
	 WA0YT6Biah2MFXlTUzZAbY/j1zNomCr4ApkmR6ew/aH03pFuWeYS2Q2IgKghL81BJvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yWOrEebe;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B57606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 05:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78B57606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yWOrEebe
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53644b28706so26085601cf.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067038; x=1795671838; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WXWBh2yCYzxwcsaq38V0SgxjAEG7903dPnuFBpVvc7g=;
        b=yWOrEebeSrjQ52/ewmLVC0c3sPfToRmB+KWO3sW3iDHzp1lcb0mxtJYLO34azISIGO
         AmNoP2y+1jvGmET2KeG/zsqQFCVdk2GquDBhUWSc6TflnFTDEJbDjcfW81Z0dsuHG1rW
         a/xd4mpMQ/YrG26D1RVFZPOETCcWKceuC03VXMwtVhCY3SzhTxMUxCG6MUWeOVcSYGt8
         QUklLZDHT0aqTk95HaXZ04e2tbd2FbAnq5TMGsF4ajT2BWmGsKPx8f3isln32AIenzY9
         tbQyhmK55kBJd8zSv8O8ybm/XUL+N/i0z6vHT0IdqIe6jBqNZkax+Z+dUjYAF9OOSkuk
         IU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067038; x=1795671838;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXWBh2yCYzxwcsaq38V0SgxjAEG7903dPnuFBpVvc7g=;
        b=aaeCrfMtt4G+drzfCQNCk9FcqpSnuRzw4RSnPRIE8dZ32+85CB305n0q7yu13q38C1
         QiZhavqCfvBLS2VCtoalc3gMRmGYlY+2NCzzXT1rEPEIvl+7Hz9Ea/OL+9heCh/2n1ZM
         PWByaEGcDr9WucKQ3g5z3yjoWXzFKO1OI5ehnFGrQXJCM7Kh5IGs8oXOmMPnBEFFN4uT
         mtBfdzJesp08yaB8+FFWz587La5dF/iZZjOY7o/dReoGJH1aIPr13TrgLuVBBQ+1WXKO
         rmsYYgPltvyrIp6CmOXPQqATlfBDw9jQFcL1lDyGvJr+iogdlaZVj0I95K3NTuof6Giu
         IW4w==
X-Gm-Message-State: APuU4Z9oA8tSmp8mTdYU1vhbTV1RtSoMojYteIe3jGa8wWbX7fjNmVXP
	WyUS0uniYXpUE6RULpPFhVgbgjMuUEn+J9v2hiwsoKsDjrQ92GNciDKoPLvTHexN
X-Gm-Gg: AYBFou3SWyawhUL86P9RMilDzASuGZj86ZaoQKw5jAWYtmY7G6ue/31+aHzBnv6lCfH
	2pE4xAM+k7vScuw4jwUz37MLpW7YpnzEkwwqvR+8H+V3h/g30XTHZfoYLFpWnK4GM+0ZtctQNdE
	cySy0wKQjPwsnQeBd3uPUJBlDhdhmHbc2hHSwPtUQbeUMs8Ey1xbYxM0MtDzkCPYdBfjOcGpeEj
	cE8YGfv/b31NDfAB8j+TyIo8W3pR1tc2sbVsm1hpZHqUmpjFGCv8Hf/q133fOhCBBFpYWG/SqBI
	fYy0LWcZJgyTNvx0dH47aRYRbdI6IY4ndJWFaZ4tG2q53V9x8Hpe8aAcTQEv/pbwCMKuJFV2pDV
	XdWbls/ez3bL7IqNHIZW8+5q3XC6MAKXYlJHmovfEciU6IbVlEYqEgonTZc4j+sVkjaE/g2L/b6
	6gruViViK9B3ikLBqa9KWd5KX1PWLp6JqJOmqDPS9acfoXpwiH8KOh20fCD+Xapb1lwwXur+R01
	i3TcWvQq6fYhUgXcc3FGXkVxtSns5VryeJtx7RYiW7f/LsW6EaYhqW9LKyyY784oS5mxvWp6Qpt
	tSWNNSCi+BHdjfFLctq8T2sDwPPQep/6zg==
X-Received: by 2002:a05:622a:9d0:20b0:535:a5f7:d588 with SMTP id d75a77b69052e-55d5a694445mr62079851cf.66.1795067038454;
        Wed, 18 Nov 2026 21:43:58 -0800 (PST)
Received: from [127.0.0.1] ([52.240.174.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d66bb7125sm16603731cf.16.2026.11.18.21.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 21:43:57 -0800 (PST)
Message-Id: <pull.2318.v2.git.1795067037014.gitgitgadget@gmail.com>
In-Reply-To: <pull.2318.git.1795026168007.gitgitgadget@gmail.com>
References: <pull.2318.git.1795026168007.gitgitgadget@gmail.com>
From: "Maik Riechert via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Nov 2026 05:43:56 +0000
Subject: [PATCH v2] diff-lib: skip leading path check for fsmonitor-valid
 entries
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Josip Sokcevic <sokcevic@google.com>,
    Maik Riechert <letmaik@outlook.com>,
    Maik Riechert <letmaik@outlook.com>

From: Maik Riechert <letmaik@outlook.com>

Since 4f3d6d0261 (fsmonitor: skip lstat deletion check during git
diff-index, 2021-03-17), check_removed() does not lstat() entries
that fsmonitor says are unchanged. But it still calls
has_symlink_leading_path() for them, which lstat()s the directories
leading up to each path.

That check is there to notice a leading directory that was replaced
by a symlink. fsmonitor would have reported such a change, and
refresh_fsmonitor() would have cleared CE_FSMONITOR_VALID for every
entry below it, so we would not get here. preload_index() already
trusts the flag this way and skips these entries altogether.

The S_ISDIR() check that follows cannot trigger either: the mode
comes from the index, and gitlinks are never marked valid.

So return as soon as fake_lstat() has filled in the stat data.

The first new test checks the shortcut itself by replacing a parent
directory with a symlink without telling fsmonitor. The other two make
sure we still notice when fsmonitor does report that directory, with
and without a trailing slash, since nothing else checks for it now.

On Linux, with 100,000 files (ten per directory), a hook that
reports nothing and a warm cache, "git diff HEAD" goes from 57ms to
26ms.

Signed-off-by: Maik Riechert <letmaik@outlook.com>
---
    diff-lib: skip leading path check for fsmonitor-valid entries
    
    Changes since v1:
    
     * Dropped the stat_err variable and called lstat() directly in the if()
       condition (suggested by Junio).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2318%2Fletmaik%2Fdiff-lib-fsmonitor-leading-path-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2318/letmaik/diff-lib-fsmonitor-leading-path-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2318

Range-diff vs v1:

 1:  22f99f7189 ! 1:  4f8cbd869d diff-lib: skip leading path check for fsmonitor-valid entries
     @@ Commit message
          Signed-off-by: Maik Riechert <letmaik@outlook.com>
      
       ## diff-lib.c ##
     -@@ diff-lib.c: static int check_removed(const struct cache_entry *ce, struct stat *st)
     +@@
     +  */
     + static int check_removed(const struct cache_entry *ce, struct stat *st)
       {
     - 	int stat_err;
     +-	int stat_err;
     ++	if (ce->ce_flags & CE_FSMONITOR_VALID)
     ++		return fake_lstat(ce, st);
       
      -	if (!(ce->ce_flags & CE_FSMONITOR_VALID))
      -		stat_err = lstat(ce->name, st);
      -	else
      -		stat_err = fake_lstat(ce, st);
     -+	if (ce->ce_flags & CE_FSMONITOR_VALID)
     -+		return fake_lstat(ce, st);
     -+
     -+	stat_err = lstat(ce->name, st);
     - 	if (stat_err < 0) {
     +-	if (stat_err < 0) {
     ++	if (lstat(ce->name, st) < 0) {
       		if (!is_missing_file_error(errno))
       			return -1;
     + 		return 1;
      
       ## t/t7519-status-fsmonitor.sh ##
      @@ t/t7519-status-fsmonitor.sh: do


 diff-lib.c                  |  9 +++-----
 t/t7519-status-fsmonitor.sh | 44 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 086476bd77..b644154397 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -41,13 +41,10 @@
  */
 static int check_removed(const struct cache_entry *ce, struct stat *st)
 {
-	int stat_err;
+	if (ce->ce_flags & CE_FSMONITOR_VALID)
+		return fake_lstat(ce, st);
 
-	if (!(ce->ce_flags & CE_FSMONITOR_VALID))
-		stat_err = lstat(ce->name, st);
-	else
-		stat_err = fake_lstat(ce, st);
-	if (stat_err < 0) {
+	if (lstat(ce->name, st) < 0) {
 		if (!is_missing_file_error(errno))
 			return -1;
 		return 1;
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 93973ed25a..6c9df9f333 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -336,6 +336,50 @@ do
 	done
 done
 
+# Create a repository whose only entry, dir1/tracked, is marked valid
+# by an fsmonitor hook that reports no changes, then replace dir1 with
+# a symlink to a directory that has the same contents.
+setup_symlinked_leading_dir () {
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	mkdir repo/dir1 &&
+	: >repo/dir1/tracked &&
+	git -C repo add dir1/tracked &&
+	git -C repo commit -m initial &&
+	test_hook -C repo --setup fsmonitor-test <<-\EOF &&
+	printf "last_update_token\0"
+	EOF
+	git -C repo config core.fsmonitor .git/hooks/fsmonitor-test &&
+	git -C repo update-index --refresh --force-write-index &&
+	echo "h dir1/tracked" >expect &&
+	git -C repo ls-files -f >actual &&
+	test_cmp expect actual &&
+	mv repo/dir1 repo/dir2 &&
+	ln -s dir2 repo/dir1
+}
+
+# Like "status" above, diff-index should trust fsmonitor and not look
+# for symlinks in leading directories that it was not told about.
+test_expect_success SYMLINKS "diff-index doesn't detect unreported symlinked directories" '
+	setup_symlinked_leading_dir &&
+	git -C repo diff-index --name-status HEAD >actual &&
+	test_must_be_empty actual
+'
+
+for report in dir1 dir1/
+do
+	test_expect_success SYMLINKS "diff-index detects symlinked directory reported as $report" '
+		setup_symlinked_leading_dir &&
+		test_hook -C repo --clobber fsmonitor-test <<-EOF &&
+		printf "last_update_token\0"
+		printf "$report\0"
+		EOF
+		printf "D\tdir1/tracked\n" >expect &&
+		git -C repo diff-index --name-status HEAD >actual &&
+		test_cmp expect actual
+	'
+done
+
 # test that splitting the index doesn't interfere
 test_expect_success 'splitting the index results in the same state' '
 	write_integration_script &&

base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
-- 
gitgitgadget
