Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026170;
	b=jSAP2LS7k5L/e6BlX5nRsEXX1xU/BR0gbVqb0N57mIkeASC3FtN9AS+zXGKvSunYfXC6
	 k1guFHllPNYqjDgttDqOyJDja1zGVdIMFnryzz6JgFrqQtv1TpqQdVmdPhxzFpd0OqUDn
	 bwl/0xWLpztDxseGrj2Y5Z/fu565JQVpfk85g5dRRnQFUXnu6wWFer5BN0k2ny+T6Szne
	 ufhgH9rXLQtqbjEfmFQIjpB1U0CU82Usc4p7dQJNjXHJrLAhxYPVPwNVa2X0QdbRg2m6m
	 Fd7YtOLNlwBmkVcurvaHek6G/X23ddq7upe/wxD9Nm6vtICs29QgV/Q/vMspLXu4O8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=8n7lN4m/oZUwSPzvS3T+6OgISH0is1mLXjRGrDp5210=;
	b=NvZzSJ/OO2SGR/FPzGdeF1AV1896ecCZO6JvmKLtlGeg4t7Ok9euXjuleoFoO4Gz8t/M
	 7GnW7ADgI5fcvoJnC8TLm+wmdkaOOr4qohDuIdoTC3n4YNX8uO9rPZhqh1CR89OTxDFzr
	 N1eX+AJf5PG2Qsv5SxT6XIrBN1jpDTZDdlmEFSB4kEmE+J65iG33Qt5eKTJZ11dr+DjJ6
	 9OeHT5KoqkXc3iLr7jC0lf4Of/65dyQsGhxrUcBXWs7fEp+Wb5Q38xrMIW2rggvn722B3
	 SBiEnW9gP+8kQbepl8tI3Pe4sREXRdJbO8L+1oWC8ccfs8Ah3DsJDO095/jCmUhyJNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0xofcpQo;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC1606A325
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 18:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ADC1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0xofcpQo
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-55c48582654so12836151cf.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795026169; x=1795630969; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8n7lN4m/oZUwSPzvS3T+6OgISH0is1mLXjRGrDp5210=;
        b=0xofcpQoVyJOxooSwI/nlhfMDgX8XdG0TnqmBlU8FT4kqIlaJFQdTPS47BxabuCwL1
         u2lmR0FPfmWkPVzIPv7X9fsgnOwR9UhLbserB5t5B/WONRaUfejHxQD50oAaiaW3vd5b
         iodxpvfV7IJRE4gFDJHIwBoZgEo85NYkP977FLt+54IUVQ/8xGuCI+h0kjC2GsvZUL7F
         RuQpXf9NX88tQKdQt0Psyge6KcifWrjbiezIrzHWlUrmaQWaTqcjkJgs04kse1szCAQE
         fZgVYhFqV164fIEtPDp38N5RmjaEepxWHYJ8LXFCUupIgyRERPa9HBRiPINKEwz8in7h
         dV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795026169; x=1795630969;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8n7lN4m/oZUwSPzvS3T+6OgISH0is1mLXjRGrDp5210=;
        b=0otG2CloZ646eL4Ia7Ju0JyOMOKVGhbep3q4o2P+P+9P8TLujLcCFhhNNSwbNPogux
         QcaI/1VeRq3yRs59N+CFJQTv2iXYIAhTLKEaKGOB3d9l4WXu4VSmA8usffgVa040orC1
         hJrTS4eUOoi0nMBmbZb+GA/b03pfvv6s+Nxodtya+zXUpnZDWb6703hT0gWf5xVVO3Wr
         kfvcbO1KVOc08uEwKSJMypmohj5vHGTNQuOA3SqRLjBYOYpp/bxBc1WvA2N5p/SpikUe
         IZFFa86MNr+Y1zO2H8sADCt8OCb+2pVYT98q5jM4MyVDap8tzAXySgnLgc08FkMPWHBp
         DP7Q==
X-Gm-Message-State: APuU4Z9+ZZcthb1PmKNwUC0RE+b8b1fy36nBgFsIZed5g8IVbeakLthB
	FHHhTHiTCuAUWS6+COXga2gSuEGPPIlnTgzTGaqVKbW4uApuGSG/NCS0cCrAZg==
X-Gm-Gg: AYBFou3GC89f103QZdr+jFHjwojn5regUXqg/iKN6A1hgZPIEcWFWZD3JbzOYYm50bq
	WmwD1j+z490y9YxR4Mp/vdD/k/S8RFwcl4arWK0SZSdOXTay1oMJ8O1NjVuyp2FzWFqFKdM4NkN
	KDJoXopYcEmnlsx7YK2fQKtbvJgHatNXWFr9g0lNXDil9pBANmhrro3dt7pehNuOTwYbccbbA2S
	PgQgK//Mu3vEIGjTk6tUf1z57KBA7aNHauBE58c3DfqXRBRtJymbRXeuEfwh0ESvaqVK1pMAulA
	FXVBgFc7QlAEk7wHRnAyybz8U+i8YWQWEZiNpTfd3XbuZZVXERtzX/1scgwZ3RPvWbqURKr+Fvt
	m92m7UMdo581Ca6idvjwqsgrSQJGvasx8znlDkwtl7sCENHdTlZWlOgFBcNiB2dPDquqaroG7Px
	rOENhglaM5l13P2om/RDdDU3hxiHXu8Q6fkPrtl5VPAFFpabNFeAxvZ/4YEkRsPrIAxeA0P+rq6
	wJZYh64/CpLoAMH6AyqGIocWtPLlTKlzyNPIEzyHkRtRdZsoUid1Anty0tDVVxoAkWENmr50Ywi
	maH0p9wkfKoNTIBJwS5Ay/uZlEsMiX4=
X-Received: by 2002:ac8:5c92:0:b0:55c:fa5a:b233 with SMTP id d75a77b69052e-55d5a62d441mr59505091cf.43.1795026169099;
        Wed, 18 Nov 2026 10:22:49 -0800 (PST)
Received: from [127.0.0.1] ([20.49.15.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d66c4a4e9sm5305911cf.25.2026.11.18.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 10:22:48 -0800 (PST)
Message-Id: <pull.2318.git.1795026168007.gitgitgadget@gmail.com>
From: "Maik Riechert via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Nov 2026 18:22:47 +0000
Subject: [PATCH] diff-lib: skip leading path check for fsmonitor-valid entries
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2318%2Fletmaik%2Fdiff-lib-fsmonitor-leading-path-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2318/letmaik/diff-lib-fsmonitor-leading-path-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2318

 diff-lib.c                  |  8 +++----
 t/t7519-status-fsmonitor.sh | 44 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 086476bd77..3730e04149 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -43,10 +43,10 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 {
 	int stat_err;
 
-	if (!(ce->ce_flags & CE_FSMONITOR_VALID))
-		stat_err = lstat(ce->name, st);
-	else
-		stat_err = fake_lstat(ce, st);
+	if (ce->ce_flags & CE_FSMONITOR_VALID)
+		return fake_lstat(ce, st);
+
+	stat_err = lstat(ce->name, st);
 	if (stat_err < 0) {
 		if (!is_missing_file_error(errno))
 			return -1;
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
