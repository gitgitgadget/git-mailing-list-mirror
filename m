Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497148;
	b=3AuPfzVbLLFSeRWee63uPeVm2bmQrFDvE6So3Oz+Z8FiFI0iIJiwLB12CjrfWHdeB1gI
	 kBj6WdqXo42EjepskHWVEroIZ9nT1tRuCHY/diplY12B7/6yfuj6gIOS8eUcwc3/lLhMx
	 rLyxQn71OevM2DTRjATrJ09YeQOfsnxxIP7VVr9RcU0AVE+YnzhWF+025iwinXSDjSKHS
	 9CURO5/AAHU/3jL4i2gEzrhRK3yg6pjdL0SDkbXgUMwwAdESYZbJ+IgGEMhGF6hyAC6T1
	 qSp12IchP/ZS/1nYJjQQ7cxtKXheRUIcCNrBSnxBTA/XhWhPNLRb5Vk04/MhMvaR+8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=u3KeMjCzjuQwrlO+85WwFhkW95mgWqkO/cWg3CFu8mE=;
	b=HpIGfcnxAWoYuiYVcDm0LfbX2qCOw8ASYS9sL6Uzfq7h+geGJKcsN72+EM+FBq7iDV5h
	 gTy+hTIohpHBnh3ykH0Yc6IGVj/SjrFxiaWthpB9/ehkRR71NlR18vspoeUJ1ZHx5W4Qb
	 tva28f6PvIc8jT0IkT91vpnhWM8Uw1xVA6zzRflqnmWR0CSebB+qBXxTcDu1BOy0GyxJw
	 U3hgFrTFy4O9U7tfoKr55XnTPBKhJUh/td6vGkWY4l1DQtoe4Hwxcf9ZrNhHDvs1oNrD+
	 LmvcWn8P4mZe37LOKuJ2sOHKjwxf8rqWSGvsS+vjyR5uJNwH09n8OuRMCTvp8/Wpu+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EYY34AMt;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE4606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 05:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BAE4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EYY34AMt
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so2284744a91.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 21:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795497148; x=1796101948; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u3KeMjCzjuQwrlO+85WwFhkW95mgWqkO/cWg3CFu8mE=;
        b=EYY34AMtxfOVO461p2aF1R3Sv9j403aN0gdh2w9N6wo0CDSxcE5Px9smWzrmfBUVjR
         OxYwZ2SFFMr0S1VhgMalLgFnnPuPyU8BrKLMzN1jPCc5qoAdTyFHYQjqy/sV4Y6CVlM6
         Al4cbvjP+xwDHshLvRGa6TURiHIOb0FuV3CEVrZB/9hf0xXQgojFX5FMtYGxvYCiDcZy
         UWk+3fJJt0QaqydoyyXNcE4dBeOdCs4STWnl6OIy/3l+kp5DlS3XuzPRfkmeTsuxiR6e
         Azt1UcBHvu5pRYP6RU6wGapA+dAFPZWsvw6iRkmJkMb/AewIp49auVoUVYR3I0rrSJ7t
         +ChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795497148; x=1796101948;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3KeMjCzjuQwrlO+85WwFhkW95mgWqkO/cWg3CFu8mE=;
        b=LmvBRvqToipRs03WKFoB9m9vek9l9RkG8ge5EdO5id9UvCIWwy1/F+ATQZBMCpHmgG
         nDpx1kLdT37QXd1WXFLNDixHjoXhmazRLbyUNXWowJWG42/yjjoapkDfrcb0J+kJ1Yge
         zeDVUANMM575EW0t8bVOwO6/bxF0EplNHl4GUAzmpP1KzcXpVwnowHDlcErJ/53Pyv6e
         DU4ez+b+ClBU/CDt8+D8zOJFkpMsGDRWWHn1FI0S7thvuPFE+zZ+e1N2zoLP0NPoxjFA
         oWdjQwIcFVTASwPenZYgwzgvT751YkKxaJ80DM5KuX6dp2Xnl6YQ0wqaThp019p21cUG
         zlaQ==
X-Gm-Message-State: APuU4Z9uU0b5pxZWLQSyHJCNwVqpRnHVRLKINt00/r+DAovk8HheG78O
	66lfQxlu+5HbFCvQSn5DVPGfZ6bHnqhfhVOrPz0Je3RttoKdGFb1UlDkmch5uA==
X-Gm-Gg: AZFdTZdUTpQ+AvBqFvalGSSNp/1U5rjd6bNooWAHLTL0quJ/FWxaX4fWlI4sRzuV3zy
	CBj/spOkzAhV46z3gnbX/rgyVWptr68I0nt/aQtpo05DXngsBFln+AiD5NQjh+S2g3+P5yCwtSz
	bgomo9fTpWjQA75AibDlPzxrjmWmdY6GavWxNbYe9rpw4wXkE7kWWNG5tJprN8FhqD56oEyzYo9
	XMGqepDbxKd/RNbe2u9Dad8xT72/uvCG8mjQkQ4tXn4Far7BeIF7v5UFYhHB8WVCY8BpqpL+pHR
	H1U/Be6aIP/rBDkZDSbkvyzOX3Ky2BeMrfD1ueAOOXMLm2RPiVEu2mDKSSnIHctRyg7dX9IGe3a
	8oHAj6n6ZEw36yTM5R1I9G4kctDsQBL06h/9/Y8C2CiZt0qh6cnRhpZo72Wsc1ZPCKdFJy9KbvC
	nlyTzhAJmboSiWrM44CAt87SvRBo1363Rq9QAhQE8lMwPrVXmwzlM/t9H5yPxyYulD7yYqW8UMk
	kxzIT3SKjVfQqFlCAbIN41FDrMkHPnY5ZzJ4InNJ0fwSYAauwSMa1bdJjzOZEjQHBDcWyVivJeQ
	TCZDUJorfW8NdSMohVtAckQV+76hoZUKODC9Neyxas5lptb1LxwmmY//dczl5+/MsiyHjgWvp+r
	t7lOys/lm
X-Received: by 2002:a17:90b:2fcd:b0:3b4:1acc:75ae with SMTP id 98e67ed59e1d1-3b41c929f8cmr12279926a91.28.1795497147641;
        Mon, 23 Nov 2026 21:12:27 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-192.us-west-2.compute.amazonaws.com. [3.42.157.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm10542162a91.9.2026.11.23.21.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 21:12:27 -0800 (PST)
Message-Id: <pull.2323.v2.git.1795497145494.gitgitgadget@gmail.com>
In-Reply-To: <pull.2323.git.1795246845186.gitgitgadget@gmail.com>
References: <pull.2323.git.1795246845186.gitgitgadget@gmail.com>
From: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 05:12:25 +0000
Subject: [PATCH v2] fast-import: die on EOF after an inline M command
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

After "M <mode> inline <path>", fast-import expects a "data" command.
If the input ends there, file_change_m() leaves its read loop without
reading any data and writes an uninitialized object ID into the tree.
fast-import then exits 0, and "git fsck" reports a missing blob.

Die when read_next_command() returns EOF in that loop, just as
parse_data() already dies on any command other than "data".

Signed-off-by: Wonseok Oh <marinelay7@gmail.com>
---
    fast-import: die on EOF after an inline M command
    
    Changes since v1:
    
     * Check the return value of read_next_command() and die on EOF, and add
       a test for it. As Junio pointed out, v1 ignored the return value and
       looped forever when the input ended with a "cat-blob" line without a
       trailing newline.
     * Reword the commit message to drop the inaccurate comparison with
       note_change_n().

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2323%2Fmarinelay%2Ffast-import-inline-eof-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2323/marinelay/fast-import-inline-eof-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2323

Range-diff vs v1:

 1:  3917798a22 ! 1:  1736db5ae9 fast-import: catch missing data after inline M at EOF
     @@ Metadata
      Author: Wonseok Oh <marinelay7@gmail.com>
      
       ## Commit message ##
     -    fast-import: catch missing data after inline M at EOF
     +    fast-import: die on EOF after an inline M command
      
     -    If `M <mode> inline <path>` appears at the end of input,
     -    file_change_m() exits its read loop on EOF without reading a `data`
     -    command. It then puts an uninitialized stack object ID into the tree
     -    and exits 0, leaving a tree entry for a missing blob that `git fsck`
     -    flags.
     +    After "M <mode> inline <path>", fast-import expects a "data" command.
     +    If the input ends there, file_change_m() leaves its read loop without
     +    reading any data and writes an uninitialized object ID into the tree.
     +    fast-import then exits 0, and "git fsck" reports a missing blob.
      
     -    note_change_n() avoids this by calling parse_and_store_blob() at EOF,
     -    which dies on the missing `data` command. Do the same in
     -    file_change_m(), and add a test.
     +    Die when read_next_command() returns EOF in that loop, just as
     +    parse_data() already dies on any command other than "data".
      
          Signed-off-by: Wonseok Oh <marinelay7@gmail.com>
      
     @@ builtin/fast-import.c: static void file_change_m(struct fast_import_state *state
      -		while (read_next_command(state) != EOF) {
      +		for (;;) {
       			const char *v;
     -+			read_next_command(state);
     ++			if (read_next_command(state) == EOF)
     ++				die(_("expected 'data n' command, found end of input"));
       			if (skip_prefix(command_buf.buf, "cat-blob ", &v))
       				parse_cat_blob(state, v);
       			else {
     @@ t/t9300-fast-import.sh: test_expect_success 'D: verify file6' '
      +	test_grep "expected ${SQ}data n${SQ} command" err &&
      +	test_must_fail git rev-parse --verify -q refs/heads/D-inline-eof
      +'
     ++
     ++test_expect_success 'D: fail on unterminated cat-blob after inline M at end of input' '
     ++	blob=$(echo hello | git hash-object -w --stdin) &&
     ++	cat >input <<-INPUT_END &&
     ++	commit refs/heads/D-inline-cat-blob-eof
     ++	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
     ++	data <<COMMIT
     ++	inline data cut off after cat-blob
     ++	COMMIT
     ++
     ++	M 644 inline file
     ++	INPUT_END
     ++	printf "cat-blob %s" "$blob" >>input &&
     ++
     ++	test_must_fail git fast-import <input >out 2>err &&
     ++	test_grep "expected ${SQ}data n${SQ} command" err &&
     ++	test_must_fail git rev-parse --verify -q refs/heads/D-inline-cat-blob-eof
     ++'
      +
       ###
       ### series E


 builtin/fast-import.c  |  4 +++-
 t/t9300-fast-import.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index ab5d2a2344..0a0f5a91a5 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2456,8 +2456,10 @@ static void file_change_m(struct fast_import_state *state,
 		if (S_ISDIR(mode))
 			die(_("directories cannot be specified 'inline': %s"),
 				command_buf.buf);
-		while (read_next_command(state) != EOF) {
+		for (;;) {
 			const char *v;
+			if (read_next_command(state) == EOF)
+				die(_("expected 'data n' command, found end of input"));
 			if (skip_prefix(command_buf.buf, "cat-blob ", &v))
 				parse_cat_blob(state, v);
 			else {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 15f511fb6b..29da93be1d 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -745,6 +745,40 @@ test_expect_success 'D: verify file6' '
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
+test_expect_success 'D: fail on unterminated cat-blob after inline M at end of input' '
+	blob=$(echo hello | git hash-object -w --stdin) &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/D-inline-cat-blob-eof
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	inline data cut off after cat-blob
+	COMMIT
+
+	M 644 inline file
+	INPUT_END
+	printf "cat-blob %s" "$blob" >>input &&
+
+	test_must_fail git fast-import <input >out 2>err &&
+	test_grep "expected ${SQ}data n${SQ} command" err &&
+	test_must_fail git rev-parse --verify -q refs/heads/D-inline-cat-blob-eof
+'
+
 ###
 ### series E
 ###

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
