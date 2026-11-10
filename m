Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311419;
	b=OSvY4DwaDnVnDBBMiiifg3XIFEqv2wV4NYYPQhd3S8/enQNEzO5FtXPsboVGVGQTeqk5
	 o7L4ul0lNQWrKicCYikTUSUXIfz6LwsdH/FSlXLj3ggS2QHPid2aeaKxT8LcEXzUQeteO
	 xB8sDDw4ioeGlW4S7owxe68W8E1oXgUM0UHilywHcNl0FCxFvnOpRG9/sbK8064Vq5zc3
	 s7YIQ8FdwpTTc07wp633AVZ8C1Ishpx3HyIsTocGM3j9f8rBXdb9/ZWtP05XqPTP/7p/y
	 apvyOyK4xEjMQnMlf4DvZJsgLWAqZn3CeSUqaWMM+T/8hxRNUwseEM7qMFstyanSTPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=XaZ7WEGQFvRPJiQc1c+9d6PlGGGmnnU7TkIb2zDdRY0=;
	b=wmGw7/BHyKuspR7gpbuLL3hQRSmPdur+QGnb15ZH30A1rpcposZIax7bFynb1AmuXXOp
	 quIm1h2HSMSEU7KVMFj2leeKphxKjJBCc+VUGBA2vKmdphdHOHrvSBx4Smjo2VZaP0v+W
	 Fo9vEVnlhu9vQIpKiWk7ksvFQs5UgnfSRjvLriEr9B30Nmi77CssN44mY4D2rktB/Rqvi
	 bxyPJuFdj+IhjZX5Hv4nkJnIZQWJshhh1Jzl5CLwrcL9XKVH1/8IoQgcZV55XqKXOhMT0
	 dQ+XopmqlXb++rubvya6KVg1bsTCMc8mNT0y4v09xEb118m7WhN+C9cOp9vZztMtDGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U3V9UMKI;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D08606C636
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22D08606C636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U3V9UMKI
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so20162715e9.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311417; x=1794916217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XaZ7WEGQFvRPJiQc1c+9d6PlGGGmnnU7TkIb2zDdRY0=;
        b=U3V9UMKI/FICnAw7jstVhLlbGeva1QWcBrF6mC8CaaTzkCFhVamsiO1w+y4pDZOQy5
         SXcsZJI9C0uY8nPrnkpf2qe+2gXxQuu8Xpt7Yzkpy72I2ruIe03oz2fupEskRxR/ykng
         xIurlNZ38f8+TBXctEYtA2g2QmPVVL9XYzY7R/AZMAptPieTkse3rzWKuzbNIkbi80lf
         G01znp4WPdEIQ02htTE1qd8O+lSjci7KSnMi7+eCOAZXD1CCEpVUSHZoIQ94cJ7Wy7DS
         RTYSWZ6HEsj0UuoTki9aUKBJRR5kxWaPZG3DPR4m42MZoUUUsHkPYUFetve3vYgWI36I
         T2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311417; x=1794916217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XaZ7WEGQFvRPJiQc1c+9d6PlGGGmnnU7TkIb2zDdRY0=;
        b=kujOM+Nm+krMZ1OngDcYo8F/TVE8yDcJ2c3ElP1XcKiw4m4LI7PdIR34HawMDrBffg
         CNu9FpGPzpdeVHlYRFbzU0+2NVrQGG6WKS4V3jpoAzS0Ox2HIV/nogyL2a+JSG23ULDk
         FCKg+VtGFCcKZAiYaEGlqpSNVMxgHZFFRANVW5nXiKnnmSQC7Nni9GUuGM1hxN/KS1AT
         79BlltUZx3gSX/Zhel90VqxnWmVxn6KPyoUwYSovTulL0puDBsBwuCcJl6JQQmc5HAxG
         5LpB8J2SEX2r0rC+K22W8iM0firdhcSkhMAHUInsDZojqn5aWETZYqrSWsk09PPVXAuq
         x6oA==
X-Gm-Message-State: APuU4Z/HWH+qIGpuAHFtZ5kwuP5ZzwWMzWR0aKbcyVQL7ixNplR4jf5y
	9pli9oCie8c+sQEurSH9fBZ9ZMYB8x4u2Wha7LvH1v7Vh6WWyhZgh9dYm91rmQ==
X-Gm-Gg: AYBFou2bd/WkmO8gtcadMKPmbZynaOnWbYUyutWFxgKv3jAE0199XVVquQG2x3ojwh7
	9KenB8ptjOerEadIuXUb95ZOs6loTAXabW2binu6ruhQYShVT2Ei0w4OeYV51bvjVtHDeDGQ69A
	I70bQNSlKxBrSgvMXrD41UB8iWBiSWhggKpYdbMlZwv5xat+s0kVKFist1akfK+UD2lWeWRJfkV
	hrkFvr9u0upz6zc8nihIGKbRQ4OV+sYf3b51esiL0b6vCDVkGOEzOBlYDtYCLrx4QdDtTjXAnYC
	1VUvefI1aRfLsT+SIMbjQS+BmCF3hl93cTUfkjQiXB+vZntx9O355zKNy5cWxvDQrBjnfNPsNpv
	5ns+Lce1Y77j0Q8vJ0nIduedexfEc7D3ww1vezzPlGljUpf57QHDRlyNrxPNosIeqydMt2KxspH
	bBjzScGLayIzafjCvJysiHTDyv/FKjvI3xUHg3gVnuqK0FnFO9+A7cFRNSU9Zflk16e7eX+n2vH
	7n3p3Z5Hkwq03pjyubWhI2gn4/tuHf+bgnZuvcetUMeyhOBwbENQjNqpXCXPH6NwtnMJCXgaGg3
	dUOJTAyRA3zMySNGuzr5y+b4+8lJZSsHCBICBWJRyNki3ek66pEfakaaK704MFgngGE=
X-Received: by 2002:a05:600c:8588:b0:4a2:cbe:bebc with SMTP id 5b1f17b1804b1-4ba0234cf6cmr29896355e9.23.1794311417332;
        Tue, 10 Nov 2026 03:50:17 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:17 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:50:03 +0100
Subject: [PATCH 18/20] t9300: make the get-mark and encoding tests
 self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-18-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4822; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=gqVUOiXsp8wZoxYGzhCfUC9XSTfdVjGexyALmepIVfo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOl6e2HL+t1Qjp1TJ/Gg1/CYpvpc5b7tt
 vnLAFVQjQ6llYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTpAAoJED7VnySO
 Rox/9wQL/3zQ5+eRzB9s2vKW6E1jwkJm91oS7UfnOh2FfLLUcyPK13FiJRppQIjDEKkp1PkjPNQ
 iLYphn/EVN3j1yPsFczGfrdbixAP/PzkGaGibioMN3gtOOeAEL1Q5Y5R4+gFee412a88vCrCo8/
 1PdN9GjjaKzqSsP+c0In9M5Dk94R2dD+nrEoFRAPfxchvDWTlEGbqCjSB6jj/uMS8NAnaOnPrJk
 yiS64DGMT+3EsHL2nv7dGl9wy21x3iaEA7SL43oTJ6eEBLV00U7JEDuMO9XLWkEMC2JdZLxS3MV
 5sMnvGy9TxpOrSragC2e25sd6nbFAWKKL8S0baekl2GcqVPAun25O6jXBOgtBR9NVGqhT54C0Bn
 8dJHv6SqbO5hmOxV3wQoEuNtwtcUZF5njkyYO3XXKwupTsxnuO8NLIqleoCEpeGAO7SvYrrh2zk
 FrL65MApDrANLZ0o1rHFSIXqiCXCSoj4qcvgC7m75N7CbrhquBn2NvBxxrqGkeC7sp9t9Xn26/6
 DY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series W' and 'X:
handling encoding' to make them independent of state from previous
tests.

The 'W' tests read the 'W-input' file written at the top level of the
script, which is not in the new repository. Turn it into a 'w_input()'
function which prints the stream.

'X: replace ref that becomes useless is removed' changes its working
directory and doesn't change back, so the tests after it, run in that
repository. Move the 'cd' into the subshell, and cleanup when the test
completes.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 81 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index c719b2115e..09cd2c5bf3 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -4503,7 +4503,8 @@ test_expect_success PIPE 'V: checkpoint updates tags after tag' '
 ### series W (get-mark and empty orphan commits)
 ###
 
-cat >>W-input <<-W_INPUT_END
+w_input () {
+	cat <<-W_INPUT_END
 	commit refs/heads/W-branch
 	mark :1
 	author Full Name <user@company.tld> 1000000000 +0100
@@ -4512,28 +4513,53 @@ cat >>W-input <<-W_INPUT_END
 	Intentionally empty commit
 	LFsget-mark :1
 	W_INPUT_END
+}
 
 test_expect_success !MINGW 'W: get-mark & empty orphan commit with no newlines' '
-	sed -e s/LFs// W-input | tr L "\n" | git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		w_input | sed -e s/LFs// | tr L "\n" | git fast-import
+	)
 '
 
 test_expect_success !MINGW 'W: get-mark & empty orphan commit with one newline' '
-	sed -e s/LFs/L/ W-input | tr L "\n" | git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		w_input | sed -e s/LFs/L/ | tr L "\n" | git fast-import
+	)
 '
 
 test_expect_success !MINGW 'W: get-mark & empty orphan commit with ugly second newline' '
-	# Technically, this should fail as it has too many linefeeds
-	# according to the grammar in fast-import.txt.  But, for whatever
-	# reason, it works.  Since using the correct number of newlines
-	# does not work with older (pre-2.22) versions of git, allow apps
-	# that used this second-newline workaround to keep working by
-	# checking it with this test...
-	sed -e s/LFs/LL/ W-input | tr L "\n" | git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Technically, this should fail as it has too many linefeeds
+		# according to the grammar in fast-import.txt.  But, for whatever
+		# reason, it works.  Since using the correct number of newlines
+		# does not work with older (pre-2.22) versions of git, allow apps
+		# that used this second-newline workaround to keep working by
+		# checking it with this test...
+		w_input | sed -e s/LFs/LL/ | tr L "\n" | git fast-import
+	)
 '
 
 test_expect_success !MINGW 'W: get-mark & empty orphan commit with erroneous third newline' '
-	# ...but do NOT allow more empty lines than that (see previous test).
-	sed -e s/LFs/LLL/ W-input | tr L "\n" | test_must_fail git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# ...but do NOT allow more empty lines than that (see previous test).
+		w_input | sed -e s/LFs/LLL/ | tr L "\n" | test_must_fail git fast-import
+	)
 '
 
 ###
@@ -4541,25 +4567,32 @@ test_expect_success !MINGW 'W: get-mark & empty orphan commit with erroneous thi
 ###
 
 test_expect_success ICONV 'X: handling encoding' '
-	test_tick &&
-	cat >input <<-INPUT_END &&
-	commit refs/heads/encoding
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	encoding iso-8859-7
-	data <<COMMIT
-	INPUT_END
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	printf "Pi: \360\nCOMMIT\n" >>input &&
+		test_tick &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/encoding
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		encoding iso-8859-7
+		data <<COMMIT
+		INPUT_END
 
-	git fast-import <input &&
-	git cat-file -p encoding | grep $(printf "\360") &&
-	git log -1 --format=%B encoding | grep $(printf "\317\200")
+		printf "Pi: \360\nCOMMIT\n" >>input &&
+
+		git fast-import <input &&
+		git cat-file -p encoding | grep $(printf "\360") &&
+		git log -1 --format=%B encoding | grep $(printf "\317\200")
+	)
 '
 
 test_expect_success 'X: replace ref that becomes useless is removed' '
+	test_when_finished "rm -rf testrepo" &&
 	git init -qb main testrepo &&
-	cd testrepo &&
 	(
+		cd testrepo &&
 		test_commit test &&
 
 		test_commit msg somename content &&

-- 
2.56.GIT

