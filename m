Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632877;
	b=bsZoR47A2up25lz7muVeqACY5vdMXUjefni24bhWUYZrs9LXxqCWox8VtODDFauNYNyg
	 o/fxGICw1aP1dnHEzu7zTSNegXFFZlL3gOZJyrPly3Qq1VzTN2JUyKpZPvSA9K/Jr99G0
	 iIxwxMWcg0Uezsm2rdm80Aug6gu6yFZQvxtldvD5aslp8trjFKf0PcGc7awd632luvcUf
	 tvNxPHB+29SseJAHRnP7CDxdGEeriP0GifrdOAnTGyJLFF61HWkcawKCtLOMNxkn3YkLT
	 RjPJ3cw3bGKCQVu71U6q81ZUMfNW+cePTPz7UOfQrTElylz8OijSBqSRM1DFhkpUyqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=b2AwxI8m4H8Kw22HlId2KRLRSeA4VvvSzxz/JUPx6Nc=;
	b=JHBh8oDc6RRq46CGA9h9SH6Az7NY1g+yPy1gBnob/Dr0zqsTl5qxDcGZOkqVFtqqbvx/
	 2FYHdfknW5tBZZ4d0FP0Thy4Q2iMpJSTL6xilICnQzP7ZjywZv6JnvnYQX/YlfLTGO7v/
	 kifBoTmG2+iRaP9KKpE3kLou/j37hzfGSoVOHPRJeML5+0AUFZ47YG4cbgmDU0l+s9dQ5
	 G+A8uzYyBRWbKwpUCzIzQ/u4ch7JCJZU7HeCwQaN6zXL29JnnrvHgCT8t5KXEscxspwIN
	 BSBcNghGybo8+3zic2k0K+HUKl7dTOzBHifeVHP80AJCnjdZdeMx3F6P4zHHlojBSKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CXZ/i7M6";
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56814606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56814606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXZ/i7M6
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5365d26ccbdso68520671cf.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 10:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795632876; x=1796237676; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b2AwxI8m4H8Kw22HlId2KRLRSeA4VvvSzxz/JUPx6Nc=;
        b=CXZ/i7M6xk5aF7Xa3zXOJON+bJak+fu1vFB6j/OTuy/Yua1EaRI6bpgTq0Qy0FLIct
         CfarRrPCWaNE5zVQ4dCfTcMLBjtKG5AveX/dFATSNqDv0xIeFRUfG9fY5TI19n1jZNWx
         UWfNkOFJ6NEoGbxgb04Wm+/cSqBS37ZX9xNLX5kTJRLeAKTCUitoSQ9s2JztuSZEXqqq
         q8FTRck5FwUUpgN3p9lNp4deXRbPVWBuHmHDRkaqnKHCcRMmUsWZrzNQy/cgEQQzplm6
         kydQodaULbMA5wonZ8jpvOdfD7XVGwvhzbElOUXwOKjXUvS0NZ0Um0zKda8HJDMVL1E4
         NtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632876; x=1796237676;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b2AwxI8m4H8Kw22HlId2KRLRSeA4VvvSzxz/JUPx6Nc=;
        b=ZDLarHIOFJBAsAgJ0HkH5eLNix07a2WSQcmNq02ajkygdJ0sq359gM6Iw7IWZOs8Gg
         X19eRRcG8z6EkElvS4ZWzANDdK0/Qwwp+qA11UlvJnqA3v1ytgrlCU9UgdfQ515JE2la
         1sQIRVbx8T/TQwxxCGOB/Rlmv6sYZJlwxmjwItdm1TGopCYmgDNeesLt4KZcpFLLEAZB
         3gPPxFY1/yz0DEmXCDePEDY1EzyQbGjO9ItRPW0Ej7NslzkSAjlBaWoOBtjXAWSskt6v
         rQ9LxvoBUioUA+xUh4zHbV6WT29cIQhtYI1vJ1F0BZqlo5qcanrA6HZNgwphbsmydqdM
         urgw==
X-Gm-Message-State: APuU4Z9DHJ14s/yc+Dy91MynCQMClC5AO7b/t736swud42LsCs+LmPU0
	67L4AhjItnQyBRtltiFZHS3mcDx2TcT0jVcXmaablUAKcOaGtARcYeYD8e4M2g==
X-Gm-Gg: AZFdTZf6b+VecuHbx8fTkjHO6Sd+f1dMJTFuR2fGqtM6K9IVMc2SBqyRPcttGjpY4Lo
	Kn3TENBTQrIcTvVp2xv1a/h2djlR520WBabwTnHPaMK7fdo5PGHoiSNywlPvAh7f/TSQHnnmA3S
	xvcMLJWEh0vWdibf2bK6zYqx1nVmZHMltC24um4uUZpy1wOdOtKdov8IlgKCh1Yfe9H8kyGQKT5
	gYzjGzA3S7lQYsuYW3cZOEbLzG9ksNuI9Awnj2ztulr95jo9AD91GmpR6F9mU7Ky62QGhxo+qV9
	mG09HezL2KqkUQdNmwtChAN5A2iiJ9JzqlOmrj6cInzYJGlr/YPh6EjjAk602Dn1HVw1y24eNaX
	03TVIdH8RfHMm4MhPdcQIZzH0xVqy894zFGxjEkcryvWwp4C2hioRxnxrx5NtN4HBjUZzYypVr8
	x15sW7lZEAy3qhAkyfLSWuxv/1PlHvIcjDO4FsqVpkNGg5R5ktFeEcqN7lHhee146wXKB+rG24+
	xBZg1c+302Kg1H68WmdQS85uHBKeo/u3NEx0GrkDcRg0KbU+zaSFjJb6/8EKCJ0/NmhO49TEh4v
	oDX2exiJUSUZk2Xn0CHrIt7Z5n1guQ==
X-Received: by 2002:ac8:5e0e:0:b0:535:cee0:6740 with SMTP id d75a77b69052e-55d76a2071bmr330275411cf.36.1795632876244;
        Wed, 25 Nov 2026 10:54:36 -0800 (PST)
Received: from [127.0.0.1] ([20.55.95.30])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78812968sm162930741cf.9.2026.11.25.10.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:54:35 -0800 (PST)
Message-Id: <pull.2457.git.git.1795632875345.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 18:54:35 +0000
Subject: [PATCH] config: make the suggested "set" command safe to paste
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When "git config" is given "<key>=<value>" as a single argument and
the value contains spaces, the suggested command does not work when
pasted back into a shell:

    $ git config status.comparebranches="@{upstream} @{push}"
    error: missing value to set to the variable 'status.comparebranches=@{upstream} @{push}'
    hint: did you mean "git config set status.comparebranches @{upstream} @{push}"?

The shell splits the value into two arguments and the command fails
with "wrong number of arguments".

Quote the value when it needs it, and put the command on a line of
its own the way other hints show commands, so it can be copied
without the surrounding quotes:

    hint: did you mean:
    hint:
    hint:   git config set status.comparebranches '@{upstream} @{push}'

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    config: make the suggested "set" command safe to paste
    
    When git config <key>=<value> is given a value with spaces, the
    suggested command fails when pasted back into a shell. Quote the value
    when it needs it and put the command on its own line, the way other
    hints show commands:
    
    $ git config status.comparebranches="@{upstream} @{push}"
    error: missing value to set to the variable 'status.comparebranches=@{upstream} @{push}'
    hint: did you mean:
    hint:
    hint: 	git config set status.comparebranches '@{upstream} @{push}'
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2457%2FHaraldNordgren%2Fconfig-set-hint-quote-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2457/HaraldNordgren/config-set-hint-quote-v1
Pull-Request: https://github.com/git/git/pull/2457

 builtin/config.c  | 21 ++++++++++++++++++--
 t/t1300-config.sh | 49 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2554322317..795a5fb136 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -211,6 +211,18 @@ static void check_argc(int argc, int min, int max)
 	exit(129);
 }
 
+static void add_suggested_arg(struct strbuf *buf, const char *arg)
+{
+	struct strbuf quoted = STRBUF_INIT;
+
+	sq_quote_buf_pretty(&quoted, arg);
+	if (strcmp(quoted.buf, arg) && !strchr(arg, '\''))
+		strbuf_addf(buf, "'%s'", arg);
+	else
+		strbuf_addbuf(buf, &quoted);
+	strbuf_release(&quoted);
+}
+
 static NORETURN void die_missing_set_value(const char *arg)
 {
 	const char *last_dot = strrchr(arg, '.');
@@ -218,9 +230,14 @@ static NORETURN void die_missing_set_value(const char *arg)
 	char *prefix = eq ? xstrndup(arg, eq - arg) : NULL;
 
 	if (prefix && git_config_key_is_valid(prefix)) {
+		struct strbuf suggestion = STRBUF_INIT;
+
+		add_suggested_arg(&suggestion, prefix);
+		strbuf_addch(&suggestion, ' ');
+		add_suggested_arg(&suggestion, eq + 1);
 		error(_("missing value to set to the variable '%s'"), arg);
-		advise(_("did you mean \"git config set %s %s\"?"),
-		       prefix, eq + 1);
+		advise(_("did you mean:\n\n\tgit config set %s"), suggestion.buf);
+		strbuf_release(&suggestion);
 	} else if (git_config_key_is_valid(arg)) {
 		error(_("missing value to set to the variable '%s'"), arg);
 	} else {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e3f8064889..796e11000c 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -470,15 +470,47 @@ test_expect_success 'invalid key' '
 '
 
 test_expect_success 'set with 1 arg of "key=value": valid key suggests split form' '
+	cat >expect <<-EOF &&
+	error: missing value to set to the variable ${SQ}pull.rebase=false${SQ}
+	hint: did you mean:
+	hint:
+	hint: 	git config set pull.rebase false
+	EOF
 	test_must_fail git config set pull.rebase=false 2>err &&
-	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
-	test_grep "did you mean .git config set pull\\.rebase false." err
+	test_cmp expect err
 '
 
 test_expect_success 'set with 1 arg of "key=value": implicit form suggests split form' '
+	cat >expect <<-EOF &&
+	error: missing value to set to the variable ${SQ}pull.rebase=false${SQ}
+	hint: did you mean:
+	hint:
+	hint: 	git config set pull.rebase false
+	EOF
 	test_must_fail git config pull.rebase=false 2>err &&
-	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
-	test_grep "did you mean .git config set pull\\.rebase false." err
+	test_cmp expect err
+'
+
+test_expect_success 'set with 1 arg of "key=value": suggestion quotes value with spaces' '
+	cat >expect <<-EOF &&
+	error: missing value to set to the variable ${SQ}status.comparebranches=@{upstream} @{push}${SQ}
+	hint: did you mean:
+	hint:
+	hint: 	git config set status.comparebranches ${SQ}@{upstream} @{push}${SQ}
+	EOF
+	test_must_fail git config status.comparebranches="@{upstream} @{push}" 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'set with 1 arg of "key=value": suggestion keeps shell alias readable' '
+	cat >expect <<-EOF &&
+	error: missing value to set to the variable ${SQ}alias.st=!git status${SQ}
+	hint: did you mean:
+	hint:
+	hint: 	git config set alias.st ${SQ}!git status${SQ}
+	EOF
+	test_must_fail git config alias.st="!git status" 2>err &&
+	test_cmp expect err
 '
 
 test_expect_success 'set with 1 arg of "key=value": invalid key does not suggest split form' '
@@ -494,9 +526,14 @@ test_expect_success 'set with 1 arg: variable name starting with digit is invali
 '
 
 test_expect_success 'set with 1 arg: digit-led section name is valid' '
+	cat >expect <<-EOF &&
+	error: missing value to set to the variable ${SQ}1foo.bar=baz${SQ}
+	hint: did you mean:
+	hint:
+	hint: 	git config set 1foo.bar baz
+	EOF
 	test_must_fail git config set 1foo.bar=baz 2>err &&
-	test_grep "missing value to set to the variable .1foo\\.bar=baz." err &&
-	test_grep "did you mean .git config set 1foo\\.bar baz." err
+	test_cmp expect err
 '
 
 test_expect_success 'set with 1 arg: subsection plus invalid variable name' '

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
gitgitgadget
