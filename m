Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15602D836D
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981429; cv=none; b=lH7BPLyMMakdNMCfhc+iwKbhNVWZym4WS5k+UKPqZcE/5xZqJSW1IlRcAAHx/N0aXFdBx4dBiKgBJUZqLP41yhJDF/lVJ7Hm+n6CDbPtIv0hgVNJrOQ3wNhoip+x5NUUWtFPl+/+dAYCXV/GP/eYQ0EuA74YgqeoexPTsiQOghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981429; c=relaxed/simple;
	bh=VsGZs1xc4VMuqI6TwlDDW4zdJbePs7Z4NdHSs1eLHFw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L5x4+kzhwKqWOUD0Ncp+tRPlJUfTQDBnTmG4+UXfBA6KEUQzwrpEqOwaBfPK6wX8FCdfe+QjS2wVdI4jzhAQULud8m9VEqz2raAQgidzy6b9UUHHHXFrjG9lnqYZTVCOhmEs44hlGmBmz3OGKQX3wMybJ34TX13LTG8lNHgpD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZagwsVI; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZagwsVI"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ba3ffd54dbso814025085a.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981426; x=1766586226; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ytsUbO1xNh5qa25u/Ghm8+Up5uA4i9FvBDQ2IaMIyM=;
        b=hZagwsVI2dCJxsVr6C7eBsz647Y8k1tIQmrDEEI/UE/sNkORbvXqSHEC6gU8OZExPI
         J4rtnuJ0+bl3TJFlVpaBC5rH42wXvM/eIxBbGMh1IXeiME0iktZkfE+dWp5QvIkmqJGz
         YgpHCTRM3nwNB+pQ5kIruy58yFsbLOO2PS3Qdn9osywJS+O76Es+nbSJX6IvllYiFtuD
         zHGaXYLaikQ3QXIN6HQ8+WlweEfqB2uxchbpiB/f9ySiAMlE9sw6eapW+3ncM5iXy/58
         abr2kUJZ25jU2XlHeLedteUae6ZpEx8uj1JP8sTopTdsSf6VtzmxqtiZRWrwAb5B80fw
         vEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981426; x=1766586226;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ytsUbO1xNh5qa25u/Ghm8+Up5uA4i9FvBDQ2IaMIyM=;
        b=VweYhfqW7ZrpKUDgYtOlggq6GSDnXPQfKiaXZkcE1boONcXa8vUl+PBJGAwT7zmDB6
         bvYJ5YmmMth6pGS6yw8pzbeRiXBBJj8kaeYAmTQnUlwBcNPIwLqmv6IxnLTPppgnAWHC
         HGd6IpX22rADSFKHI8g+sjJsL0ZqssJnVH9DndK0iTquFwsyFz/qRzaUGEx3W1YS6U4V
         /3M0YXwx8J9xZPS0SmOPK5b86vvzTv8OurUVCf9RvWt8MuXlYIiKT4lqe1qce6P45xN7
         3e5mhVFXY3aHnmpqeAhXQV7Vfvo9u4S5eUNNe2WEPOJGsW66Dw8+wDtt/yWg04vNaFy7
         EfNQ==
X-Gm-Message-State: AOJu0YxtkSVjc6XjIbR/X8kNluP6XHcXk2lI4ZS7/MfQKIJBjzJFBzUZ
	rWBxrgJ/xdB8JxLQ3h0ahgidXWLuZmgEjKbHFxQSpSwl+lkuNQgcZxmnVOJLwfz0xd8=
X-Gm-Gg: AY/fxX4r+qFa74IpovwbjPBI3pBavllBJTPAuN+GisKgNOmQPgU6c+mYOX/0nOocLqf
	e8V/P4c7VsxaAg+m1fsEIo9o9YdPhlfXMptS//9p2zEzUESXXof+FnHYCqqkZSq8DtGM0IqOG2b
	0RM0Oe/ocZhaCaZe6FGiW+cl0SG9YKzgEdtVjGa91Q6Cl+lmIrGmCj3lzY4Noz5r377vJyw4U2e
	91eUolInbMu90DmJkd4LoZDFccc8YkcZqoo1edV87TBLwcTqziSXzJ7SYCXogu696yAoPcWVkSN
	alZwzaTW3NOMfMisquPAbT/x7DJ0OK4nBEUvvN2fzU+6D7m+p8tMxl+6qUBYqmoQgvBTA2fPlcv
	TlsOzfXnrp3T1zLlaASAgOI9fPup3RRjg8Pww5gegdKdL96wP5gfEgUiRgqQcdTKmUpsEbBnVmh
	vQS3ZBDZdLshFrPg==
X-Google-Smtp-Source: AGHT+IHh4IcU0F9pwRi8IxhZRwEdm0GOiEV+wUZelNysHx1bqtdLJ+557oK7dCVKuJH0dmaNNAiYCA==
X-Received: by 2002:a05:620a:1922:b0:8a3:cd9e:e3fd with SMTP id af79cd13be357-8bb398d81bdmr2212677685a.9.1765981426134;
        Wed, 17 Dec 2025 06:23:46 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be30d86a2dsm411105885a.15.2025.12.17.06.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:23:45 -0800 (PST)
Message-Id: <8d7047655933592939dd1395f5b1ead595cee4ee.1765981422.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:23:39 +0000
Subject: [PATCH v2 1/4] sideband: mask control characters
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Andreas Schwab <schwab@linux-m68k.org>,
    Ondrej Pohorelsky <opohorel@redhat.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The output of `git clone` is a vital component for understanding what
has happened when things go wrong. However, these logs are partially
under the control of the remote server (via the "sideband", which
typically contains what the remote `git pack-objects` process sends to
`stderr`), and is currently not sanitized by Git.

This makes Git susceptible to ANSI escape sequence injection (see
CWE-150, https://cwe.mitre.org/data/definitions/150.html), which allows
attackers to corrupt terminal state, to hide information, and even to
insert characters into the input buffer (i.e. as if the user had typed
those characters).

To plug this vulnerability, disallow any control character in the
sideband, replacing them instead with the common `^<letter/symbol>`
(e.g. `^[` for `\x1b`, `^A` for `\x01`).

There is likely a need for more fine-grained controls instead of using a
"heavy hammer" like this, which will be introduced subsequently.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sideband.c                          | 17 +++++++++++++++--
 t/t5409-colorize-remote-messages.sh | 12 ++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index 02805573fa..fc1805dcf8 100644
--- a/sideband.c
+++ b/sideband.c
@@ -65,6 +65,19 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 		list_config_item(list, prefix, keywords[i].keyword);
 }
 
+static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
+{
+	strbuf_grow(dest, n);
+	for (; n && *src; src++, n--) {
+		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
+			strbuf_addch(dest, *src);
+		else {
+			strbuf_addch(dest, '^');
+			strbuf_addch(dest, *src == 0x7f ? '?' : 0x40 + *src);
+		}
+	}
+}
+
 /*
  * Optionally highlight one keyword in remote output if it appears at the start
  * of the line. This should be called for a single line only, which is
@@ -80,7 +93,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 	int i;
 
 	if (!want_color_stderr(use_sideband_colors())) {
-		strbuf_add(dest, src, n);
+		strbuf_add_sanitized(dest, src, n);
 		return;
 	}
 
@@ -113,7 +126,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		}
 	}
 
-	strbuf_add(dest, src, n);
+	strbuf_add_sanitized(dest, src, n);
 }
 
 
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 516b22fd96..f4712f4161 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -99,4 +99,16 @@ test_expect_success 'fallback to color.ui' '
 	grep "<BOLD;RED>error<RESET>: error" decoded
 '
 
+test_expect_success 'disallow (color) control sequences in sideband' '
+	write_script .git/color-me-surprised <<-\EOF &&
+	printf "error: Have you \\033[31mread\\033[m this?\\n" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
+	test_commit need-at-least-one-commit &&
+	git clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >decoded &&
+	test_grep ! RED decoded
+'
+
 test_done
-- 
gitgitgadget

