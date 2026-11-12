Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504874;
	b=XOCfDh1ynK1KS7otZJ+NKXzUWUm0xQDUB+OfaHARdNb7i+i4/uSeIZWJvcF5jkyjK0yx
	 5ySsopYTtMz0S1bV69i02QUvhv60rSXMTlPImtc2it5vVRYVxVDw2LdCMwGtm1nDInPUH
	 kFGQwghO1EDpCngjwxxEljOxEIZjpRbFulxM/qY/LFN0jpvPwc0yjmulF2vKcTY9wodPS
	 kTdPqdpLfdmXE/qoqBtwAhqMT8CIz+M0KiHMemwif+5Gan1pO7hsNSP1IoJ+heAe6caGQ
	 O/habunVjkBh9dg/jeMA33sDnPYewjqDW2zUcAgV30fdZ8RqhVkkD0M3AAFWuBGTYMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=5PY5Azniuv+mPwBwtXzdWRWbLH9xMYnDu4CQ9Ev3B/M=;
	b=nKFJsAjMwHVwmaoVB0VSxMQ+tXn5P8WXqswL4sZSn3tmaknWgrvYMPckxwsH3FEMhtOS
	 17DT7M5tvRRfezlJ1O3w6tDKMDAML6q4zGsxKJHBNHd2SBQ+yl7kSPJ4sMYKxibUrsmzm
	 c2XKoP983LymleR6NphQq6UWvRjvPkd5rM5AYbTeWBb+nvPxdNfxBJV5UVJaznNs2kk7P
	 RgzE/F0hHOFG56BS6r/Vdp4Q0WVIYa5crLCktUSHxaQ253mCYIoY9alMI+kExJz6pNJaT
	 AKSJpv2z18fbF5rgKsdWhnFI+D0sHGeRlL956q1wdx2oYFXzWHX3WNlDjN/fKDeHNMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b3sM62v+;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39077606DF06
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39077606DF06
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b3sM62v+
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-491846221ffso655f8f.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504873; x=1795109673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5PY5Azniuv+mPwBwtXzdWRWbLH9xMYnDu4CQ9Ev3B/M=;
        b=b3sM62v+9cp71dNfjev8ttCIdvvMktl4CV6OaRyT+YGOhz4YOPr7Rc3cXGMwCro1Au
         WotU/YaZgXI0OYUvTWtcXhn13Y8zgnNN3jwoOKHkIkzRAFn9EFQEbVZRvEObrr35uIdw
         uYBMvrxcvDpYSCp+GDCjxGP/aW3udUbPKeEOHlDMeCiRPKlW0W11R421z1Pe1Bj9MWmW
         BdzQN2/nxYL5mIUZQdG4Npiq5UU6jU8TO5mjS4s8+tE5p2fG/JIhdEBRTXKFaTGC5zYh
         +Wt1YBTus5oqX1T85EV00DdtxiBJ5uXzgvyOobZbzunf9LhZrhAHu7zQU7y0VfXfVU/W
         1vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504873; x=1795109673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5PY5Azniuv+mPwBwtXzdWRWbLH9xMYnDu4CQ9Ev3B/M=;
        b=LhMOK8MVir3wVmXcoIM3RbU3RDTM7HcGXRNa2uAIbnmCZCw/tsKx2xECHEmzZoRplI
         KkunHdSRf4+cdWQDsLbzPk8N5Xg3YJ21Wg0A5jbyZQZE87zt/BVi0pNkjbtF4Jrw2A5Z
         rQuWRuDT6coQJpQkq9NNkEW9O3nW1ZhWGg5OpoVIZVJbYDkyzjwJG4BQ/j6VhiyLp52V
         46ypmXT4PwYiFZNWa0Hv7wjj3YgZ8ciL6bYqOJeKwelS45kpkf7TZOrdr4Z065AD7yFX
         3WmUV5NBMieHnmfvJhP7UYREj2w7ufRzWWKmuGUwg+WyipefW1kCFdkLxgSZYfOg4yWH
         FdBA==
X-Gm-Message-State: APuU4Z/RCSWOEYlMkOlK9i/LsfKs110jhU7P6aXb+7WgE+n7RvyA6VTa
	RxtkDBe8R4Go+Yx6UBXNep4xSmszrv4pAxMWYVHSAhFpHQXwgArInqzkkcwOZg==
X-Gm-Gg: AYBFou1JUn34+ziOsJs+mOQDV6KVzjKNCSKRLbbpzfdkwnnPtlqMaoSrTyMlNeLim4k
	ADrtKPkv3wLiEDBHAPDFtFgM2AWT9w9fb2PzwAXwPW/xyYfMf+Nvj8RhDKM/S35TWJ9UUL8A6Gl
	mWPvg7HvEWHmtf3MGa9bFmNkTJ3tcV3HLIKR2ID5ppOtSxEW1Bi4zpEZS61CDHmgA7hNBYradm2
	2IMZ/NXd1nnBa0vpqdqhpreNSuBCCwmCEMJhMXWp+p2h3VyLhIP5Nlks9qT4MxDgqmvHgcyE4ns
	ExdzZj5EBBpQNajhfVrx6YnN2pFAtHxh/1XekqhbDvdRMBxc0V65v6x4A7IX+Q2QyWZnh2/LJvM
	+Ea6PjtAmP3w54S9R7yRmahC9SyOdswCh91Amfqw4kB3LB8UJVx4f8OeKY75aQj4kyL/M5lZVRt
	vmmN2obX0OOXeAnG5FG9MBM+F0cltJ/dMe70gx7t38MDk3mpg3O8sb6vgCKBCGTfKkwQTeetGS1
	fVXNqDnXNxgW4D1y+gb4apESDoUDvQmsSnEbtgiFayhA0EjscD4er2/XsddI43IhbFzbjallGz8
	8Je1mVJlFh7HsRTfLQKg2Z273z1MYPKjZC7I5rz7Ltn5yb0Z1MjSByI4tw9c6nDYa+nZ
X-Received: by 2002:a05:6000:4a07:b0:48e:f47:273c with SMTP id ffacd0b85a97d-49c6d7340famr242524f8f.8.1794504872519;
        Thu, 12 Nov 2026 09:34:32 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:32 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:17 +0100
Subject: [PATCH v2 17/20] t9300: make the stream tests self-contained
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-kn-fast-import-tests-1-v2-17-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5522; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=iwGPl5g3tv4LtrBPB5lF0rlg3QvqefucJXARWtGSnq8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JMiQaxKmeypdtacR//6LgAuCBZMqE/Cm
 HepVeK4LHiidYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiTAAoJED7VnySO
 Rox/SCIL/30w3zcJt9zqio1IJea8jOnKnwsg9B5N8rCLMq5WAJb055MUELAiOV9piybAdSA7kZn
 NL1IrP2OGytxYzXZkCRWLLbYdnGwxivaUF7mKsN8FQQw5hqINrF2zNy6AGPn5oCpGuJqIypLCAS
 x5EZ+s8IPxn/H9x4DSNjCEf+t8srd70XrM1y3H2i737K302nfgpEW6kzDeToQhO0k2O7KGGEgaH
 hmJD/vzg7X1KmT7hOitN8XZPovmqsdmO78Z0CWUgTpE32GriyMPMBjD36gGXS9o7J2biBLrGxDM
 IapOcaJitqabn367R6r+mHkgbTD/e2iqciCg0xK9CK12F0BYLXre3NcF0xVuwZ1kNIaKnJSb9Ff
 IHpSWiENhZcj/WveCnKQAT7fSH1vzbGVUAjP5pkoBfiSMvYtotansOp8Wmd6puP8bGlTT+8Rr1k
 urgdCsoOGB4dLsVjMA+0DKa0f+uD92V0MOO0/wZUYPGErokxO7/47bKtIkE/zOUCFrT3s+ACfe6
 zQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series R' which
check empty and truncated streams, the 'quiet' option and the 'done'
feature to make them independent of state from previous tests.

'empty stream succeeds' no longer needs to configure
'fastimport.unpackLimit', as that was moved to the first test needing it
by an earlier commit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 154 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 101 insertions(+), 53 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5f84c66ac4..45720ed003 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -38,11 +38,23 @@ echo "$@"'
 ###
 
 test_expect_success 'empty stream succeeds' '
-	git fast-import </dev/null
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		git fast-import </dev/null
+	)
 '
 
 test_expect_success 'truncated stream complains' '
-	echo "tag foo" | test_must_fail git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "tag foo" | test_must_fail git fast-import
+	)
 '
 
 test_expect_success 'A: create pack from stdin' '
@@ -3428,58 +3440,82 @@ test_expect_success PIPE 'R: print staged blob within commit' '
 '
 
 test_expect_success 'R: quiet option results in no stats being output' '
-	cat >input <<-EOF &&
-	option git quiet
-	blob
-	data 3
-	hi
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
+		cat >input <<-EOF &&
+		option git quiet
+		blob
+		data 3
+		hi
 
-	git fast-import 2>output <input &&
-	test_must_be_empty output
+		EOF
+
+		git fast-import 2>output <input &&
+		test_must_be_empty output
+	)
 '
 
 test_expect_success 'R: feature done means terminating "done" is mandatory' '
-	echo feature done | test_must_fail git fast-import &&
-	test_must_fail git fast-import --done </dev/null
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo feature done | test_must_fail git fast-import &&
+		test_must_fail git fast-import --done </dev/null
+	)
 '
 
 test_expect_success 'R: terminating "done" with trailing gibberish is ok' '
-	git fast-import <<-\EOF &&
-	feature done
-	done
-	trailing gibberish
-	EOF
-	git fast-import <<-\EOF
-	done
-	more trailing gibberish
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		git fast-import <<-\EOF &&
+		feature done
+		done
+		trailing gibberish
+		EOF
+		git fast-import <<-\EOF
+		done
+		more trailing gibberish
+		EOF
+	)
 '
 
 test_expect_success 'R: terminating "done" within commit' '
-	cat >expect <<-\EOF &&
-	OBJID
-	:000000 100644 OBJID OBJID A	hello.c
-	:000000 100644 OBJID OBJID A	hello2.c
-	EOF
-	git fast-import <<-EOF &&
-	commit refs/heads/done-ends
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<EOT
-	Commit terminated by "done" command
-	EOT
-	M 100644 inline hello.c
-	data <<EOT
-	Hello, world.
-	EOT
-	C hello.c hello2.c
-	done
-	EOF
-	git rev-list done-ends |
-	git diff-tree -r --stdin --root --always |
-	sed -e "s/$OID_REGEX/OBJID/g" >actual &&
-	test_cmp expect actual
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		cat >expect <<-\EOF &&
+		OBJID
+		:000000 100644 OBJID OBJID A	hello.c
+		:000000 100644 OBJID OBJID A	hello2.c
+		EOF
+		git fast-import <<-EOF &&
+		commit refs/heads/done-ends
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<EOT
+		Commit terminated by "done" command
+		EOT
+		M 100644 inline hello.c
+		data <<EOT
+		Hello, world.
+		EOT
+		C hello.c hello2.c
+		done
+		EOF
+		git rev-list done-ends |
+		git diff-tree -r --stdin --root --always |
+		sed -e "s/$OID_REGEX/OBJID/g" >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'R: die on unknown option' '
@@ -3615,19 +3651,31 @@ test_expect_success 'R: blob bigger than threshold' '
 '
 
 test_expect_success 'R: --git-completion-helper does not read from stdin' '
-	find .git/objects/pack -name "tmp_pack_*" >before &&
-	echo garbage | git fast-import --git-completion-helper >out &&
-	test_grep -e "--date-format=" out &&
-	find .git/objects/pack -name "tmp_pack_*" >after &&
-	test_cmp before after
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		find .git/objects/pack -name "tmp_pack_*" >before &&
+		echo garbage | git fast-import --git-completion-helper >out &&
+		test_grep -e "--date-format=" out &&
+		find .git/objects/pack -name "tmp_pack_*" >after &&
+		test_cmp before after
+	)
 '
 
 test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
-	find .git/objects/pack -name "tmp_pack_*" >before &&
-	echo garbage | git fast-import --git-completion-helper-all >all &&
-	test_grep -e "--allow-unsafe-features" all &&
-	find .git/objects/pack -name "tmp_pack_*" >after &&
-	test_cmp before after
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		find .git/objects/pack -name "tmp_pack_*" >before &&
+		echo garbage | git fast-import --git-completion-helper-all >all &&
+		test_grep -e "--allow-unsafe-features" all &&
+		find .git/objects/pack -name "tmp_pack_*" >after &&
+		test_cmp before after
+	)
 '
 
 ###

-- 
2.56.GIT

