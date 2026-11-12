Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504873;
	b=b7qd6BqBdKiB2Tc/j2QRaxPWeRbKUwT38grFHA/EzXDsas0g1wmYWRkxvuNXO5oJaF7J
	 bnrCnb3l2XUJiJVQoLCNbw034g0g5dDpj1iJIrIWM6vD8T+eFEOZlQYj8MUtdyaIz39AS
	 Yvx9TCeBpO34fCbiBahDL8SvBIIu63zQ+BZwbOxnH/Z025zCQ9SBQ8pAfMQHp311KulVE
	 PVJiL0l5cz3FSrEG4Io6lrVw79ZUJ351bkmcG0JsRNRcMdXWs20UF2QIXG2ZlOl9bUy1z
	 7WvMATf0HrOpkTYCqGpoz645gBbkw+BzQDW5pJGwNu5zsEOEt1CViajfl7JyWoGVVEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=kxOjQpsArWEUDqdSQPjmp5x2dsQQgbk6+cHeM9PSw/s=;
	b=sSFn4bmxQ5i09vG71VKkV/Joz22Ux8rkGztajgdJEEOW93q/KFiaYp0iV3RAblEvxV+R
	 PA1N7WK4vsMlNF82sKMSy44M1rIssW71EpINM6KPRBjejcDmcbfAsSc84PvkZeF+ue/ka
	 OBATAFhsroEXrCfhHyqFhsHG2YoL4civlzTvKMRO1Y7BFWf9e4U9qmlgiMzvfs7EeLPRA
	 VIGeF+xPDXzPRWudUP7VI3BFAY4L9bv0zjShj2Lm5UxIVVY3TnxkQreVRu31BEEEUn/9V
	 YCXwmyrbmlUHmUJSaPTYHfoVoewVN6L2hrRpK0vV8koK/0E68s3pWjNu+3AW6e8GOqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+KMhOYo;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2960A3821
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5F2960A3821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+KMhOYo
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-491971ac844so1825f8f.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504871; x=1795109671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxOjQpsArWEUDqdSQPjmp5x2dsQQgbk6+cHeM9PSw/s=;
        b=S+KMhOYoFGbvKOkjqQApkJFtPPls+a9FmChI7oBWKzF7YJypjrbWyENAsh+KiVSqad
         JVPCS48zcFdU9gQt9a1OWLWphPbunDqqB2XSAO7XBhMr1vN9NNviRapgVKgflh0aYnaw
         y6twfhEyPoTtGWmKjbHxV/XvJc/gKDmkJD+K3+Z/WLIDnzmKTDnmCB5QDKF7B+sxPV7p
         YLiB7TAAy8mgApAHuMdSDxyIZRLhWvMnARTeJ9afmjBsdDpgBmQ4MvdXeixhFDqintLc
         TGHdNPx1VwucH1snqagxfhyQlgYR21FbbN4Vt1X3GbdbN1N4geAFRagxEca4BjbeKq5I
         tY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504871; x=1795109671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxOjQpsArWEUDqdSQPjmp5x2dsQQgbk6+cHeM9PSw/s=;
        b=CZCpXlW/AzYIWNH+lOdY6DlBu1xtwo1ATA8Imd2ukHxfC4mtOYMA4NtgC+9oYdhe0g
         qfkeKwLd/cVlvwI+0Fn40p1cZyNPbb2QMUyxnE4x7q6svbguKGN+N3exDQpkQ4Bj02hQ
         +t9euOcXLPtr1JGTJAg0od0IwprZBW1JH0j0BxbDhssaYsthVDGatr2gY64UPYHpUXqn
         xSfIVrqyaeCbsirSvDHR3Z9tIQpqFo1KNB86+jWJfVVdOIG4C4F9uOAolOg/+79BINC8
         VcCqsuVlfRVB8uptpS6aCNJpqGuxI8D3dgsxmHDaB/rSC8n6tYgid19OBil2iXtSMjsi
         mq0w==
X-Gm-Message-State: APuU4Z9Njfz4ocmSBymYnbwRv5y5lylxC3xY0kGk2Lq7rSEI9H83QDvu
	/AEsMgldy1vnkqr5sDypMvVrlxOGUuCLGNc/lGdrco0vQdLOo0Ttsa5vOum4nA==
X-Gm-Gg: AYBFou1EkNl5skQcesB59/hbYaCSf7Z2rFRcVzQEoDz+fs/H5C7JNRwv/eF+6uDysxt
	a0+DGsWX6pICTR7imM/6frR9rKyNCOlehFFWipPjoY0pNTDqUhEjhI1ORgU9zx4UipnIh6OzqHz
	yAYlaqDasJ4bjQ06DZtGd7JVlrhXlxrxd7UEH3uQlnUHNs6MDOh/WNoXoWOIWafR8eQL1C28/OW
	6wGPHPifnOIJP0T4+BgD5oTJYDwuU5N+DviFcUUa+M4dfj7uqD3I14xudqx/9m6hY/iz7sHPek6
	CM8Zgvn/uiEj5klX75CK0o+BEevf4yoxD+CaymOGW2SqFXxGwwrh8/Ttp2kavIEYNBSXBVcltOf
	PvlzMMgm2L/GBDRKFeLuKIYlYjbXpjILqo7wKHcQLisQXJbkjVTNAfsMhPU4vaZUFDyFvaU6Kub
	44jyb8cfRqrbTWoQz1SCsWujNAPxNhXNSdh0pN3C8E/E6iWdFRx4WB6PUMRm7EekqGKuRP7yLu8
	FSODfycg8yLbJOdghGl8fe+71g/BsfyCi4yYmYnCtgQg/piYXV4nBPGp557zxUFAD3KE/SDSNp0
	TOiE9xb4+GqUHHEykbB6Km07qCmniPbAL4iCGjcx61x7DZFwlVFuIU8VBZcxaoGj2zaB
X-Received: by 2002:a05:6000:4201:b0:490:9fe2:6a37 with SMTP id ffacd0b85a97d-49c70ed8f15mr154851f8f.17.1794504870795;
        Thu, 12 Nov 2026 09:34:30 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:29 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:15 +0100
Subject: [PATCH v2 15/20] t9300: make the cat-blob tests self-contained
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
Message-Id: <20261112-kn-fast-import-tests-1-v2-15-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11239;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=sMVIGJx+7L5xtkkxf7RVDTdJ4duBghoyPFf5075wMNg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JKroAyDtWzE5FpHxmdL4pxJOl3Vwc2zc
 yIQEVSAMEs5fIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiSAAoJED7VnySO
 Rox/miwL/inqENHRYyZscYCqmbGYiGVJePv45SqIRuTSKZDaqAZ9OaEINH/bnaaID6aKwMTsBhl
 Ho84YrtCWz8hAgSYbYcgA4fCEH1aVQQrBqAmtPa3Xt6GNllc6x0B2sdyH+azGOdhqtOwSfDi0Qr
 vvnU1CSlrGnH1zEdr2MMXHYHoXp8eKTdsT9xjBLgaX/fnpCsxwaMnHxqxa6Pspstpv3bygi7nBv
 0fpeIP69vUUp3RuYLQq0V4dRLo6d73cEZkrqDjlDlKGiOW3pzaHYBDaqUx8cvhr5uZjGCFymL4v
 dIxOkNN0S7jFIiHaSGbfMseRicM1EKOEahLG/0yDujprHvCM5W55GwEq2qWTGA4AmyiBaVpfxwM
 6hGWEQX96EZG/BDKx8oHm1wkq3ujaFfJyDaPIqu8kLFl7f5V5mj29CXZLZ50hPv527uwmfXOS6S
 212kZ179HmjrfnYO+jzX7MXhPwNmN+pq6CrH1vjr9NkUou5d8IkcIc4DWZ3b+CWtRiJeDqquL28
 vY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the cat-blog tests to make
them independent of state from previous tests.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 428 ++++++++++++++++++++++++++++---------------------
 1 file changed, 242 insertions(+), 186 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 7b755d8de1..0dc71648ca 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3048,87 +3048,117 @@ test_expect_success 'R: cat-blob-fd must be a nonnegative integer' '
 '
 
 test_expect_success !MINGW 'R: print old blob' '
-	blob=$(echo "yes it can" | git hash-object -w --stdin) &&
-	cat >expect <<-EOF &&
-	${blob} blob 11
-	yes it can
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	echo "cat-blob $blob" |
-	git fast-import --cat-blob-fd=6 6>actual &&
-	test_cmp expect actual
+		blob=$(echo "yes it can" | git hash-object -w --stdin) &&
+		cat >expect <<-EOF &&
+		${blob} blob 11
+		yes it can
+
+		EOF
+		echo "cat-blob $blob" |
+		git fast-import --cat-blob-fd=6 6>actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success !MINGW 'R: in-stream cat-blob-fd not respected' '
-	echo hello >greeting &&
-	blob=$(git hash-object -w greeting) &&
-	cat >expect <<-EOF &&
-	${blob} blob 6
-	hello
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	git fast-import --cat-blob-fd=3 3>actual.3 >actual.1 <<-EOF &&
-	cat-blob $blob
-	EOF
-	test_cmp expect actual.3 &&
-	test_must_be_empty actual.1 &&
-	git fast-import 3>actual.3 >actual.1 <<-EOF &&
-	option cat-blob-fd=3
-	cat-blob $blob
-	EOF
-	test_must_be_empty actual.3 &&
-	test_cmp expect actual.1
+		echo hello >greeting &&
+		blob=$(git hash-object -w greeting) &&
+		cat >expect <<-EOF &&
+		${blob} blob 6
+		hello
+
+		EOF
+		git fast-import --cat-blob-fd=3 3>actual.3 >actual.1 <<-EOF &&
+		cat-blob $blob
+		EOF
+		test_cmp expect actual.3 &&
+		test_must_be_empty actual.1 &&
+		git fast-import 3>actual.3 >actual.1 <<-EOF &&
+		option cat-blob-fd=3
+		cat-blob $blob
+		EOF
+		test_must_be_empty actual.3 &&
+		test_cmp expect actual.1
+	)
 '
 
 test_expect_success !MINGW 'R: print mark for new blob' '
-	echo "effluentish" | git hash-object --stdin >expect &&
-	git fast-import --cat-blob-fd=6 6>actual <<-\EOF &&
-	blob
-	mark :1
-	data <<BLOB_END
-	effluentish
-	BLOB_END
-	get-mark :1
-	EOF
-	test_cmp expect actual
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "effluentish" | git hash-object --stdin >expect &&
+		git fast-import --cat-blob-fd=6 6>actual <<-\EOF &&
+		blob
+		mark :1
+		data <<BLOB_END
+		effluentish
+		BLOB_END
+		get-mark :1
+		EOF
+		test_cmp expect actual
+	)
 '
 
 test_expect_success !MINGW 'R: print new blob' '
-	blob=$(echo "yep yep yep" | git hash-object --stdin) &&
-	cat >expect <<-EOF &&
-	${blob} blob 12
-	yep yep yep
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	git fast-import --cat-blob-fd=6 6>actual <<-\EOF &&
-	blob
-	mark :1
-	data <<BLOB_END
-	yep yep yep
-	BLOB_END
-	cat-blob :1
-	EOF
-	test_cmp expect actual
+		blob=$(echo "yep yep yep" | git hash-object --stdin) &&
+		cat >expect <<-EOF &&
+		${blob} blob 12
+		yep yep yep
+
+		EOF
+		git fast-import --cat-blob-fd=6 6>actual <<-\EOF &&
+		blob
+		mark :1
+		data <<BLOB_END
+		yep yep yep
+		BLOB_END
+		cat-blob :1
+		EOF
+		test_cmp expect actual
+	)
 '
 
 test_expect_success !MINGW 'R: print new blob by sha1' '
-	blob=$(echo "a new blob named by sha1" | git hash-object --stdin) &&
-	cat >expect <<-EOF &&
-	${blob} blob 25
-	a new blob named by sha1
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	git fast-import --cat-blob-fd=6 6>actual <<-EOF &&
-	blob
-	data <<BLOB_END
-	a new blob named by sha1
-	BLOB_END
-	cat-blob $blob
-	EOF
-	test_cmp expect actual
+		blob=$(echo "a new blob named by sha1" | git hash-object --stdin) &&
+		cat >expect <<-EOF &&
+		${blob} blob 25
+		a new blob named by sha1
+
+		EOF
+		git fast-import --cat-blob-fd=6 6>actual <<-EOF &&
+		blob
+		data <<BLOB_END
+		a new blob named by sha1
+		BLOB_END
+		cat-blob $blob
+		EOF
+		test_cmp expect actual
+	)
 '
 
-test_expect_success 'setup: big file' '
+setup_big_file () {
 	(
 		echo "the quick brown fox jumps over the lazy dog" >big &&
 		for i in 1 2 3
@@ -3138,153 +3168,179 @@ test_expect_success 'setup: big file' '
 			exit
 		done
 	)
-'
+}
 
 test_expect_success 'R: print two blobs to stdout' '
-	blob1=$(git hash-object big) &&
-	blob1_len=$(wc -c <big) &&
-	blob2=$(echo hello | git hash-object --stdin) &&
-	{
-		echo ${blob1} blob $blob1_len &&
-		cat big &&
-		cat <<-EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-		${blob2} blob 6
-		hello
+		setup_big_file &&
+		blob1=$(git hash-object big) &&
+		blob1_len=$(wc -c <big) &&
+		blob2=$(echo hello | git hash-object --stdin) &&
+		{
+			echo ${blob1} blob $blob1_len &&
+			cat big &&
+			cat <<-EOF
 
-		EOF
-	} >expect &&
-	{
-		cat <<-\END_PART1 &&
-			blob
-			mark :1
-			data <<data_end
-		END_PART1
-		cat big &&
-		cat <<-\EOF
-			data_end
-			blob
-			mark :2
-			data <<data_end
+			${blob2} blob 6
 			hello
-			data_end
-			cat-blob :1
-			cat-blob :2
-		EOF
-	} |
-	git fast-import >actual &&
-	test_cmp expect actual
+
+			EOF
+		} >expect &&
+		{
+			cat <<-\END_PART1 &&
+				blob
+				mark :1
+				data <<data_end
+			END_PART1
+			cat big &&
+			cat <<-\EOF
+				data_end
+				blob
+				mark :2
+				data <<data_end
+				hello
+				data_end
+				cat-blob :1
+				cat-blob :2
+			EOF
+		} |
+		git fast-import >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success PIPE 'R: copy using cat-file' '
-	expect_id=$(git hash-object big) &&
-	expect_len=$(wc -c <big) &&
-	echo $expect_id blob $expect_len >expect.response &&
-
-	rm -f blobs &&
-
-	mkfifo blobs &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
 	(
-		export GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE &&
-		cat <<-\EOF &&
-		feature cat-blob
-		blob
-		mark :1
-		data <<BLOB
-		EOF
-		cat big &&
-		cat <<-\EOF &&
-		BLOB
-		cat-blob :1
-		EOF
+		cd repo &&
 
-		read blob_id type size <&3 &&
-		echo "$blob_id $type $size" >response &&
-		test_copy_bytes $size >blob <&3 &&
-		read newline <&3 &&
+		setup_big_file &&
+		expect_id=$(git hash-object big) &&
+		expect_len=$(wc -c <big) &&
+		echo $expect_id blob $expect_len >expect.response &&
 
-		cat <<-EOF &&
-		commit refs/heads/copied
-		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-		data <<COMMIT
-		copy big file as file3
-		COMMIT
-		M 644 inline file3
-		data <<BLOB
-		EOF
-		cat blob &&
-		echo BLOB
-	) 3<blobs |
-	git fast-import --cat-blob-fd=3 3>blobs &&
-	git show copied:file3 >actual &&
-	test_cmp expect.response response &&
-	test_cmp big actual
+		rm -f blobs &&
+
+		mkfifo blobs &&
+		(
+			export GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE &&
+			cat <<-\EOF &&
+			feature cat-blob
+			blob
+			mark :1
+			data <<BLOB
+			EOF
+			cat big &&
+			cat <<-\EOF &&
+			BLOB
+			cat-blob :1
+			EOF
+
+			read blob_id type size <&3 &&
+			echo "$blob_id $type $size" >response &&
+			test_copy_bytes $size >blob <&3 &&
+			read newline <&3 &&
+
+			cat <<-EOF &&
+			commit refs/heads/copied
+			committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+			data <<COMMIT
+			copy big file as file3
+			COMMIT
+			M 644 inline file3
+			data <<BLOB
+			EOF
+			cat blob &&
+			echo BLOB
+		) 3<blobs |
+		git fast-import --cat-blob-fd=3 3>blobs &&
+		git show copied:file3 >actual &&
+		test_cmp expect.response response &&
+		test_cmp big actual
+	)
 '
 
 test_expect_success PIPE 'R: print blob mid-commit' '
-	rm -f blobs &&
-	echo "A blob from _before_ the commit." >expect &&
-	mkfifo blobs &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
 	(
-		exec 3<blobs &&
-		cat <<-EOF &&
-		feature cat-blob
-		blob
-		mark :1
-		data <<BLOB
-		A blob from _before_ the commit.
-		BLOB
-		commit refs/heads/temporary
-		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-		data <<COMMIT
-		Empty commit
-		COMMIT
-		cat-blob :1
-		EOF
+		cd repo &&
 
-		read blob_id type size <&3 &&
-		test_copy_bytes $size >actual <&3 &&
-		read newline <&3 &&
+		rm -f blobs &&
+		echo "A blob from _before_ the commit." >expect &&
+		mkfifo blobs &&
+		(
+			exec 3<blobs &&
+			cat <<-EOF &&
+			feature cat-blob
+			blob
+			mark :1
+			data <<BLOB
+			A blob from _before_ the commit.
+			BLOB
+			commit refs/heads/temporary
+			committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+			data <<COMMIT
+			Empty commit
+			COMMIT
+			cat-blob :1
+			EOF
 
-		echo
-	) |
-	git fast-import --cat-blob-fd=3 3>blobs &&
-	test_cmp expect actual
+			read blob_id type size <&3 &&
+			test_copy_bytes $size >actual <&3 &&
+			read newline <&3 &&
+
+			echo
+		) |
+		git fast-import --cat-blob-fd=3 3>blobs &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success PIPE 'R: print staged blob within commit' '
-	rm -f blobs &&
-	echo "A blob from _within_ the commit." >expect &&
-	mkfifo blobs &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
 	(
-		exec 3<blobs &&
-		cat <<-EOF &&
-		feature cat-blob
-		commit refs/heads/within
-		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-		data <<COMMIT
-		Empty commit
-		COMMIT
-		M 644 inline within
-		data <<BLOB
-		A blob from _within_ the commit.
-		BLOB
-		EOF
+		cd repo &&
 
-		to_get=$(
-			echo "A blob from _within_ the commit." |
-			git hash-object --stdin
-		) &&
-		echo "cat-blob $to_get" &&
+		rm -f blobs &&
+		echo "A blob from _within_ the commit." >expect &&
+		mkfifo blobs &&
+		(
+			exec 3<blobs &&
+			cat <<-EOF &&
+			feature cat-blob
+			commit refs/heads/within
+			committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+			data <<COMMIT
+			Empty commit
+			COMMIT
+			M 644 inline within
+			data <<BLOB
+			A blob from _within_ the commit.
+			BLOB
+			EOF
 
-		read blob_id type size <&3 &&
-		test_copy_bytes $size >actual <&3 &&
-		read newline <&3 &&
+			to_get=$(
+				echo "A blob from _within_ the commit." |
+				git hash-object --stdin
+			) &&
+			echo "cat-blob $to_get" &&
 
-		echo deleteall
-	) |
-	git fast-import --cat-blob-fd=3 3>blobs &&
-	test_cmp expect actual
+			read blob_id type size <&3 &&
+			test_copy_bytes $size >actual <&3 &&
+			read newline <&3 &&
+
+			echo deleteall
+		) |
+		git fast-import --cat-blob-fd=3 3>blobs &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'R: quiet option results in no stats being output' '

-- 
2.56.GIT

