Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619288;
	b=EnLytAyiuTTgcgxn3IzRDsSfXDP8mGIRJg2KmSahXpyg5nNk6O52oWrguOWpYziaaSAU
	 hhEcBG2yuRnnZ0xA/uDwtjITHYntRhAL89csN/F4zXiDmoZV24U3GKQNM6jCRetCD/7EN
	 oONZulDWZekIkjgX2sFBOisPPvkGVIQkRVWmrNiGc4ua3q4VymSr2dRzOn3QYRAp5wk5u
	 1FYgfgijnOByNI0mLE7fh4+3AKHFS0mD/FVRJijzNEJrCzv3+eNMBLhqm+RYgAX2/HpqH
	 wRgZralsbbKxdQDNMlVcE0GJgUPvYdxuWvMR3Hw2E3QJj3KW6+aErJwbdyb8/esLYXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0SpyFhAfZ3dGNxeNWl5ISg1XaSDxfPs0xGR2lvbgrow=;
	b=wXlPci3tSPOkqWt5dyERfP7DgEIIVy51iwuUVaghWHLXqSwYducImJKZe1E6qJq4iAz1
	 aOWqKoPsRAn5M9wh5haGi+Rsy5+ioyOEq5/iDxnqpoWYG3DL55pxOoB0VXhP5eml4EL/p
	 9xx5BsCb71xcmtwz8pyrkXFe23yK6xG6Jwh6XW1bgk7ETbbjAdInCXkNLMxhYcODKYuio
	 dPKqHD8WuEDI3iLJY2CV/jiHv03VSYg31+RE6nGEqHqwv8NZWMZW11mJxgo8lkryegK5T
	 364xDQTslj52qJlSmtFKprk1jVVTrL6NO3d9F8CSvFbBkLTHgH9IpYROCpF7qGI4yyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vrqy5Ita;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C7606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 01:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB1C7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vrqy5Ita
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso10875095e9.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 17:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794619286; x=1795224086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SpyFhAfZ3dGNxeNWl5ISg1XaSDxfPs0xGR2lvbgrow=;
        b=Vrqy5Ita9BmXmTakISvTcGWAobsi4Ls/7P7IlV+iXRfk6d54mAAmz3TgM3GI+I8Yfd
         fO4g0IUdVdJzHuOD5oKIEg6wH9mj0PJoIp2q3Tg3HWNoYZqQIwgjsMOdAI4H1xtPOS2J
         j/5oM/0mvo/T61h3lU2KxkhPJzLCBOrOYgzXloSrCnYLRWBd6yeLcqVpY06jBZzhAoVr
         eyIfCNEiSbY4sdqwUTKu+oMJLyWDrZXA2+PPRL7al8fRTLJsaEE1xnMCvkrHoNO1ure/
         23STLfYSa2bJdbul+hozrg0WueSN7E18YyyI/o/et8DSYB1JF2JvKt4AWPd7icdu7bOd
         Yl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794619286; x=1795224086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0SpyFhAfZ3dGNxeNWl5ISg1XaSDxfPs0xGR2lvbgrow=;
        b=xzCrl3yy3znf5LbH3KODJXcGPaykV8I4VacWjMa7GN2dwuZ0BtR84eXOEh3Yz8Gzby
         uVIevYx3kG1l/G/ZzP3I5SJApU2UdaDBmSgXpAeobwO0omEXcyX32SVSOdFYtX4LHVrz
         TIlyY7+N6vMnNfK3PqotmtFyj9t+3KSuX0r+dTxQ1bcqte3iipImY5UMxZuFSaa7prgL
         9gUAXVmBlu8afU7ORdNAN4ErU9m615YTmpEoj8YEeuOaYM+MXuewYuNPnycII24xLTyc
         46lwmT4th4pGTNL/NJnyEe0ZvK0EFCkiGgHhnFdxTzjL54JbPnwxXbn3b9gegiLnmdlM
         1Yfw==
X-Gm-Message-State: APuU4Z/JLzGxbv1hEbTavLqv/1Oq/15kpriAflDwL+hvUt7kJm72r095
	/NmdqxMSraLFT2w2ZxKmQW5/6NG3AE1bAfP5G8g/Layn4f6iPxIOyqCGHYsPYdqSHbg=
X-Gm-Gg: AYBFou0jC2E/tLR6oG0ZNZEd2j+OoXWyMdEPh6Pmyxnta9PbOUOFGebo1iXMi0ghmmp
	ryLdzEFm1vRaQXSV56b31InMV82SYvNiC7ZfkVtQnEzTtljNsdEpkrcoRO7Bm3oWgj2JPKT/T16
	kUwQz/rTHpQie6fSHpDynBR4xl85wvhmQL2iuy7Np/J745p4TRFSbelilTltQ/gLfQ/EuCNGC7A
	NIjMyhu9P9tYz79vtPKNUN/wxlUSqgOFMe1dXlsNcjiCUjiR9VNoUhtpGplBNGy/G+bFsO9srdi
	BRfWYYvUsZZcB7NZK0pusgs3Yw17XbFdfc4WWcH4RKDweCVwLVaWy8QSbqIt/Iln228/3IeJ8r+
	of6bQyAQEsZCTEGhXgKyWo7EeAscfwrVDmgvSSaecwucaN1UZ5F6wcKuEQwvGv/VMMJCZre7Ist
	F1gxlQDIgU1lSDAlFE0x/dZ7vY9+Wdsmq5imMqIEX8I/ssebCV2o7gqBm03+qjAt3pLM0EAiZWt
	n8SB/R9QvDsYJ1wYuKnWVRGL6Cb/Sk0pn2Zs/YdmxJdX8Q1v7+uHjVRurr5+vRciybW8e9/brZ2
	hwdEERdZoJqWVtN5kr4Zoc8cwl6VLyGe3mMP3lyxeSmLOHkLiH0UoyaEj+MsOtK9a539A5c8Jeq
	9Ac7aEGsn/+Kj+te0JD0uJoe5kO3/l/eAPziV2hxqMzWbRzUKdqRgH34=
X-Received: by 2002:a05:600d:4:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4bb55a82203mr77893745e9.28.1794619286236;
        Fri, 13 Nov 2026 17:21:26 -0800 (PST)
Received: from HP ([102.0.122.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm97277455e9.13.2026.11.13.17.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 17:21:25 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	jackrawlings2011@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v2 2/2] apply: reject new and deleted files that have both names
Date: Sat, 14 Nov 2026 04:20:55 +0300
Message-ID: <20261114012055.127905-2-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261114012055.127905-1-tangajoris@gmail.com>
References: <20261107195429.96842-1-tangajoris@gmail.com>
 <20261114012055.127905-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git writes "new file mode" or "deleted file mode" before the "---"
and "+++" lines. The "new file mode" line sets is_new. Then
gitdiff_oldname() leaves old_name empty for "--- /dev/null".

When the "---" line comes first, is_new is still 0. So
gitdiff_verify_name() takes the name on that line as old_name. For
"--- /dev/null" this gives "dev/null", because one leading directory
is stripped. The "new file mode" line then sets is_new. The result is
a new file that also has an old name. "git apply --check" dies on it,
on the same assertion in check_preimage(). In the same way,
"+++ /dev/null" before "deleted file mode" gives a deleted file with
a new name. "git apply -R" dies on that one.

d70e9c5c8c (apply: check git diffs for mutually exclusive header
lines, 2017-06-27) made apply report other conflicting header lines,
instead of leaving them to an assertion. Do the same here. After the
header is read, reject a new file that has an old name. Reject a
deleted file that has a new name too.

Git always writes the mode line first, so patches made by Git are not
affected. A patch with
"+++ /dev/null" before "deleted file mode" used to apply without -R.
It is now rejected too.

Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
 apply.c                    | 20 ++++++++++++++++++++
 t/t4133-apply-filenames.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/apply.c b/apply.c
index c5d4fe7887..0fa6a15a65 100644
--- a/apply.c
+++ b/apply.c
@@ -1466,6 +1466,26 @@ int parse_git_diff_header(struct strbuf *root,
 			      *linenr);
 		return -128;
 	}
+	if (patch->is_new > 0 && patch->old_name) {
+		if (patch_input_file)
+			error(_("git diff header for new file %s names an old file %s at %s:%d"),
+			      patch->new_name, patch->old_name,
+			      patch_input_file, *linenr);
+		else
+			error(_("git diff header for new file %s names an old file %s (line %d)"),
+			      patch->new_name, patch->old_name, *linenr);
+		return -128;
+	}
+	if (patch->is_delete > 0 && patch->new_name) {
+		if (patch_input_file)
+			error(_("git diff header for deleted file %s names a new file %s at %s:%d"),
+			      patch->old_name, patch->new_name,
+			      patch_input_file, *linenr);
+		else
+			error(_("git diff header for deleted file %s names a new file %s (line %d)"),
+			      patch->old_name, patch->new_name, *linenr);
+		return -128;
+	}
 	patch->is_toplevel_relative = 1;
 	return offset;
 }
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 751a01f92f..ff48e68da0 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -146,4 +146,35 @@ test_expect_success 'name the empty "diff --git" line in the error' '
 	reject_empty_git_header later_line.diff 3
 '
 
+for old in /dev/null a/f
+do
+	test_expect_success "reject \"--- $old\" before \"new file mode\"" '
+		cat >old_before_new.diff <<-EOF &&
+		diff --git a/f b/f
+		--- $old
+		+++ b/f
+		new file mode 100644
+		@@ -0,0 +1 @@
+		+1
+		EOF
+		test_must_fail git apply --check old_before_new.diff 2>err &&
+		test_grep "header for new file f names an old file" err
+	'
+done
+
+test_expect_success 'reject "+++ /dev/null" before "deleted file mode"' '
+	cat >new_before_delete.diff <<-\EOF &&
+	diff --git a/f b/f
+	--- a/f
+	+++ /dev/null
+	deleted file mode 100644
+	@@ -1 +0,0 @@
+	-1
+	EOF
+	test_must_fail git apply --check new_before_delete.diff 2>err &&
+	test_grep "header for deleted file f names a new file" err &&
+	test_must_fail git apply --check -R new_before_delete.diff 2>err &&
+	test_grep "header for deleted file f names a new file" err
+'
+
 test_done
-- 
2.43.0

