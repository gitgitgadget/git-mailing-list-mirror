Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795246848;
	b=4KCWnHfZ7QymxUVlnOSzscX3COIK4CmhrlvQcPkIXjYKnsQEPfavyJb2fZHoIdKM2E5Y
	 +D+BLH0h00SQk8ZcR1vPIVEhZMoxiyIyvfLb8ueKrU8gSfM5+GjNMF3Y/vSLiZeHzG1XD
	 zfUCY0KezkBfz5+30Gjes9DYLWjnWJ5YhVhfQtDCWYarYaje4YhV1B4MYqPyTeOxC9+Zi
	 9Zd2XkSPMdz6TADRAJG5Mtwvj61jZ+Eeahs3QNbMA3KDMc+siLjaNyzOI9LEqqnLX+8n0
	 CzhkVgwJm3jejmrQu+KhqceGil1dyq1o7TsI7W2rOYhoOt/vwy59UaQlGnWDb1/gxGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795246848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=1Ht6I3AX3ntkzsnqI5YsH+E0lZKJqdgaU3SDz99bStM=;
	b=rLUz07eWMrmGOM699h3gMz3/4ZwEO4u6/73VfdCJioxacqkBp7cF+gFRWqF4TuFz1UvS
	 FcJImAK/clFHHCSrYy2mu3yLA+I/eT9UvlkBTH6cmBiidfpbnaLTI9Hiu9efdeO7cQVW/
	 DPprh1AVSZEJX5vHKb9v+UGOM7DL0WTFF3h/R0MGk0mYxFb+4HTcROTfcyweuS3nKD1GQ
	 nIz60i+bqCn9W26fwsQhx+4M38EnXGq/LF8tiZWvn8EqCtb1hjNBayqeyZ4yHqpEclzpZ
	 3Gk2Jbbu6Vr583vh/TGt1uBwhl1U7PneRtoX3SLAKLyEaUbBjxCuj0v2ZQo7cF2Zj4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vASO899d;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F68606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 07:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06F68606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vASO899d
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b41e5a1719so643562a91.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 23:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795246847; x=1795851647; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1Ht6I3AX3ntkzsnqI5YsH+E0lZKJqdgaU3SDz99bStM=;
        b=vASO899dkqStmnsk+qKgcqoKDjwQZYi5b6xMbkWYsSpQMu3cTv9xZonjpiw4wJlgvI
         8JbYjOat9YUXjA2HYuWhLzp1Lq4GLggbDWXudPEjHjSkdXMLHH+AcHp+vlsEjj5dpqmZ
         uyT2MnEjts5qMJq6BX8hBiKc/03GA8RqhzdV5YYxr+QbwqNbMDDeqe1ci30VSyobwoG1
         zh7pA8DuByX3Y4U8ZK+8Fr9v5H/buRrfqa2k95SImQ56Ko/s1caQgGxN2DYx7eQ2sAsq
         uUIzh2W+1PzRZY1yhSK6sndIR6F83jNuN6BFP4XnHY3DQPxhTiTfgx1fo4LMLY9h097a
         ud/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795246847; x=1795851647;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1Ht6I3AX3ntkzsnqI5YsH+E0lZKJqdgaU3SDz99bStM=;
        b=WN7nPQFJssHiBFFtgWW/fAgQqHHPwwiCQfJGKxuD6Dha8YPFvgwzf+qLIUneyaBtfw
         OaIzWJnwlWPd2G946+YD5hAe8FlXfMihBPfoYOLgMNXwLsHwXQKHwticT4/kkTrK5RKJ
         qwMwVvk2hOxbNIZ95rP9z/2rAki/ZV9j0homAuL6ZUa0d2nqFSbYcV6jxnVqjTxITug4
         A0bLC9qqy7BhAsgJwhtLM7nCr/PHWzM32uXZ4Kt32/4RFGfFooYd5S+/TZKz5iOGfXbZ
         /Py4DtCFWckmw7YWn//TQVEt5OVamAHzs8C7rwY4iZ+kQgcCnV1ISvEYEQbG4sRco7Sa
         BENA==
X-Gm-Message-State: APuU4Z8RcZrWU+YFczljKidk/celcvNPxQ7TqUPdbazjEnzhLzIKJSMD
	6ARWscBuf11TeAlr+GvaBh4RwUzpqChg9K40MJUxRbLVeGObxAlTqU4X9lyi2Q==
X-Gm-Gg: AZFdTZfCV3oMhcTrmccy1yE515KkCwZiDN/JuB2JegNfzbDMcmOuGY3KJloM48npgba
	jxOod8DYsMb0a0XdiOq6UDnS+HZGS93fplhFbFejZYrBp+pzMbsKAKVFbpgXAAmtkx80fO8wqUY
	Y3L1wl8UmbKZHA6OCIIs4v8GcHWS0C8flVDm9kLXFiWHRkTY9V1bqMdX0ShnVpAl6FyEoG481Kb
	25T9i6cDWphFGGSJmQ+l2A9nAdYkGwLRtBUEtcuwj2Y/CVnP8Bh3HwdA8LXAiZcErrDmXv49y4I
	XMwHN6sCpagBuKBvCJQTDeM1Wn5JuJFF3sfn8MAcL0iEXwBaNEdG42VkSZlBRDG/n7Hmm6XES2y
	QxBmDWa2BhoQCOSxx54WNuTVbDgh2kZjN5t2d3snneex3g0sdWxnTSp08RPo4HLFgZpahe/XdVn
	hiYb0Kj1f//aT5YJnw+MvGrwGv5qA6VWBk63E+ZEOGuiCfn7sG1qj8APE6YoTG+vGK2WI+3rjcK
	8ZTl4uv1rAuUrFAE1VOfqMxmho52QgFzciFsctJMdGyhQOpN1i978qZCQW0cb/xlQ6w/i18N2Fg
	2ixvBhEVHIUGi44SzrOCCNZ2MQbikGUQ/gY=
X-Received: by 2002:a17:90b:3912:b0:3aa:6b5d:9fe4 with SMTP id 98e67ed59e1d1-3b41c8e171emr4975276a91.12.1795246847276;
        Fri, 20 Nov 2026 23:40:47 -0800 (PST)
Received: from [127.0.0.1] ([172.171.108.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578d771sm10490232a91.1.2026.11.20.23.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:40:46 -0800 (PST)
Message-Id: <pull.2323.git.1795246845186.gitgitgadget@gmail.com>
From: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 07:40:45 +0000
Subject: [PATCH] fast-import: catch missing data after inline M at EOF
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
Cc: Wonseok Oh <wonseok_oh@korea.ac.kr>,
    Wonseok Oh <marinelay7@gmail.com>

From: Wonseok Oh <marinelay7@gmail.com>

If `M <mode> inline <path>` appears at the end of input,
file_change_m() exits its read loop on EOF without reading a `data`
command. It then puts an uninitialized stack object ID into the tree
and exits 0, leaving a tree entry for a missing blob that `git fsck`
flags.

note_change_n() avoids this by calling parse_and_store_blob() at EOF,
which dies on the missing `data` command. Do the same in
file_change_m(), and add a test.

Signed-off-by: Wonseok Oh <marinelay7@gmail.com>
---
    fast-import: catch missing data after inline M at EOF

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2323%2Fmarinelay%2Ffast-import-inline-eof-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2323/marinelay/fast-import-inline-eof-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2323

 builtin/fast-import.c  |  3 ++-
 t/t9300-fast-import.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index ab5d2a2344..2b271222e1 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2456,8 +2456,9 @@ static void file_change_m(struct fast_import_state *state,
 		if (S_ISDIR(mode))
 			die(_("directories cannot be specified 'inline': %s"),
 				command_buf.buf);
-		while (read_next_command(state) != EOF) {
+		for (;;) {
 			const char *v;
+			read_next_command(state);
 			if (skip_prefix(command_buf.buf, "cat-blob ", &v))
 				parse_cat_blob(state, v);
 			else {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 15f511fb6b..c291b0cf70 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -745,6 +745,22 @@ test_expect_success 'D: verify file6' '
 	test_cmp expect actual
 '
 
+test_expect_success 'D: fail on inline data cut off at end of input' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/D-inline-eof
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	inline data cut off
+	COMMIT
+
+	M 644 inline file
+	INPUT_END
+
+	test_must_fail git fast-import <input 2>err &&
+	test_grep "expected ${SQ}data n${SQ} command" err &&
+	test_must_fail git rev-parse --verify -q refs/heads/D-inline-eof
+'
+
 ###
 ### series E
 ###

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
