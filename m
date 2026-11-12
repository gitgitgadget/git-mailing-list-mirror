Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504857;
	b=XOXRMr9LcNIne8DiyKokrq/cm0LPTfKKe4ewBNWTOgCt+i4aNH+ptvI06cNWafRzucTw
	 FtS4fAjMZY019LdJ/jZgAHfkWJBQ+jxw3oVvLQmMNJ4O/tcx0BjSL0I0sKtDwUCOuXvlB
	 /YcXiGYNKZawzevIY0EDAHQ8OxmHue8cN+1hG/bM6PxX1WjB9BSVrk1JCroe+1X64JTHh
	 6dbx14iJV9yrBuYxGE4a1tPf+xf0OchCwYOCCfbcqAcmou5zEcqj3kX9Gzar+mPbKHhro
	 oUThQO9N9LOWL6L//OoMG88NZSv7Q9Fq/RlS8r8OgTaEeFwh2YNxzuD+HFStFIluEUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Gyi7uZeZxN0C3h7kwyZ/wHfQK9ICjO/yk+cPpio2Jzs=;
	b=BZorEA8pQheRsOX3d51apmP+XO4tb8cNkUiIGOy/AQj+W4Piv9NeGN7uxMZa4fm8sepO
	 POw5eAv0NjZIZADEapTF7VoSgb27uBWmwG9D6WNAatNdPYpUsSpJvXEJvoxsVdHWP23FP
	 zQ4iGFkgAYXvyRBx3Wp2LmJc4g7rNmixywPegUQU/BV7ziaTZIg36eqo1NO9mT1Xz7cTw
	 e+Pn2h7dbovVU65NXiE94IvrkIYPY2gbU+pMX7awzNR615bCN2Mba63iMfEny9URuUCzy
	 WHqhe4VYCj72LCbOhjBPxgqtOcody+cezoyptcnu6ORvKEkTo874rhCQlDnQS/lDAZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgZ7gKzJ;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9E60A263D
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D9E60A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgZ7gKzJ
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-49412eb1474so4920f8f.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504855; x=1795109655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gyi7uZeZxN0C3h7kwyZ/wHfQK9ICjO/yk+cPpio2Jzs=;
        b=NgZ7gKzJy+wGm9f+bB4dO3HzWIhgAjCgi+ZoGDQ6aduRQnd7tu5xIFwFGoFHNIgvD5
         B75njCV+gOhHa2YQsA5sJ/c2NN7SuIY9Ey85gDrxRUhx3NN9R2L4Cs4at/M7LGDAdx18
         Z5lPGM1mrW8v7I8rGtJSbcCKllIMm1FzyBtnHfl9+d3gJHLuM0D0l65tsK1NCuZWYYK6
         766JPdQwr1+sfsqzjaHnvmNz+NIx4hGWcTCWgjnNbW0CFCU0OyFHFV2gfQNEjOpKqPcM
         DN9O5Gl0qQmQarjviTAH4elRxjj2S0vVEpBukKEmeewoUuFHl0qekFhWcligje1KAWKm
         7Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504855; x=1795109655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gyi7uZeZxN0C3h7kwyZ/wHfQK9ICjO/yk+cPpio2Jzs=;
        b=SnwuC7bJn6ZxGWZQyk5COVV3FpLuw7l8lAGEEQdeHe56l7I7PayXlBMxadCOpQq6OP
         +2nQAXcXVb5owPpAI8/PY9oW34fQEw69icXEWjIGSruHRbEnNOG0OzoMr7XIB2QimVIE
         5OEdOXRkJK4QcqVgSYXogX3Ja4/aVUyLqDuixmXdi6dP4LwcrfnIj61k0+d+KSOQ+Bqe
         g6Z/cxcmp0cVox3b1T7WdlgGahL7iI9Uvu8MYLh3MGYyt+YbcDqkDsjuHLeTs7MtJ8nl
         imUlLabyqRdZlTqpaxQ7FLKTrq5EKYPHF6UkvNtjrtZyJATW3IBsngJd8RD8HWuvJ7Wl
         NO9g==
X-Gm-Message-State: APuU4Z/OKQl0CiZ39LtvYKqHBxSqBcP9JeczcOi0d6EQ0D09emnaqeJ5
	QXwr5AHieLoudqwKTxz0leD6spyxvS43704GCUX28toVt/Fph7lEzs3bonPC9A==
X-Gm-Gg: AYBFou2iSQvVXXTz1CZ19m9tU9UtmxuL7/zLowky5ZNMO6sllwjPyFJEUO+Foakdz9z
	TVzDwqyMQ3qpPNBZAmIxeYuaQ+ybWLB7YuYRBAgkfXeMnX/lHRypaJ4HSas687sG0VnzmQMFKJf
	EHEaHps2hgx0q//aJ87zQ55WfXanLNb1WY8yIq08WPPCg/df9sJp6sDe7E0OSyOLZso3FX9lnNw
	8o9GaNg9mKOpUnEgBTW5LXihdvrCYX73b8FEOuDbiE96OtkVILrKIjXhOdPLSYNsfETMtBiU4lo
	sWYxUPZLoYEpxTfou/MxQFYCFZBN6C8VTpm+IywKq5KGUwGCCfbjhRXci7VIuK92knArb1M38Hv
	FEp8niXpOoDpaju4b9YtnEnM03giQNg60v6IbltceDKeqvk9TgQPzo+tZNjK8GwLGFF20TGJrj2
	QL+pdAY3/VX9HDpqZiLUmkOgXW1gdPNlBXp5OtzZyDRn01fkoMlHwZhkJWny2Putlc/Xwzr0Qro
	nK9LYqJXa558x+HL2ATgPpTGHCnjz6SMhxkxFKE3TLF7kJprL+jMIgVO9k4g7D82Ap29fH7q9Wm
	mhLrkRrErto0+I+7HOXOUVSbnBmX4OxLekvGWvN0HOu75oa58bdRFdz9BGa4UgRKVAP1
X-Received: by 2002:a05:6000:2912:b0:48e:2a04:4ea3 with SMTP id ffacd0b85a97d-49c6e68daa6mr266721f8f.8.1794504855439;
        Thu, 12 Nov 2026 09:34:15 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:14 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:03 +0100
Subject: [PATCH v2 03/20] t9300: make the series T tests self-contained
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
Message-Id: <20261112-kn-fast-import-tests-1-v2-3-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2692; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=HKUv444HAC8tk7i6jeJkpT4dAI8TMoszkn3LOA6dwdE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JB7BbCIKDuVdsu1D8AVwkMPLpl+pJMYJ
 oWDiUvgz55cmYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiQAAoJED7VnySO
 Rox/zf4MAIUju4Fs/n0AnIOh1TDUDG7PenXe00Yhlx+9tVeKwnKsShhVigc6U0uP1lbTLac4Xj2
 oanuZtYNzs1E/oazjFBOrU4720dojMx2yzHftuhJMDXJjKQU/ILlpBPmd+mefFMV0gu/x7+uXhv
 nwLvKqyD2rvwDndBt0EdnUIK3YAREyo01yH4A4ZzRUG7wjFIeWt82NQPs0MyfgDumZe78DQermL
 si0b3BW2cGgvJse1MPQHWKFkER8/7jdoXKWkTdSZ7Au974tuPcvwdtHneo+x69VasJObrEXAC95
 OP3UiN4dOz5NfGQ7fp1vTS9moOPNLnKdlfIjIzXj8aLB+hpDOeoV0I83eq7OQQtKjNIVMtpiV+l
 NFSKmcxy7rg0wo0BqNUHd3cb+j1jAHBTC8wUKWPpDF6DVn8kGyyAs8f06esn4z3TzQocjxCiLkr
 NZ83K8BrKoejz/0TJtcvAVVkvIJvid2y6FkHG0RudTzBlOxASMNU3s3kVmXjSM91ioo7g+cXYZ6
 a8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commit, modify the tests in 'series T' to make
them independent of state from preceding tests.

The 'ls root' tests list the root tree of the 'S' branch, using the
marks left behind by series S. The expected output is derived from the
commit itself, so any commit will do. Run them against a commit created
in a new repository instead. Run the branch tests in a new repository
too.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 62 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e2cf0b7a22..a0e322b866 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3602,38 +3602,58 @@ test_path_eol_quoted_fail 'ls (without dataref in commit)' 'ls ' path
 ###
 ### series T (ls)
 ###
-# Setup is carried over from series S.
 
 for root in '""' ''
 do
 	test_expect_success "T: ls root ($root) tree" '
-		sed -e "s/Z\$//" >expect <<-EOF &&
-		040000 tree $(git rev-parse S^{tree})	Z
-		EOF
-		sha1=$(git rev-parse --verify S) &&
-		git fast-import --import-marks=marks <<-EOF >actual &&
-		ls $sha1 $root
-		EOF
-		test_cmp expect actual
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit one &&
+
+			sed -e "s/Z\$//" >expect <<-EOF &&
+			040000 tree $(git rev-parse HEAD^{tree})	Z
+			EOF
+			sha1=$(git rev-parse --verify HEAD) &&
+			git fast-import <<-EOF >actual &&
+			ls $sha1 $root
+			EOF
+			test_cmp expect actual
+		)
 	'
 done
 
 test_expect_success 'T: delete branch' '
-	git branch to-delete &&
-	git fast-import <<-EOF &&
-	reset refs/heads/to-delete
-	from $ZERO_OID
-	EOF
-	test_must_fail git rev-parse --verify refs/heads/to-delete
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit one &&
+
+		git branch to-delete &&
+		git fast-import <<-EOF &&
+		reset refs/heads/to-delete
+		from $ZERO_OID
+		EOF
+		test_must_fail git rev-parse --verify refs/heads/to-delete
+	)
 '
 
 test_expect_success 'T: empty reset doesnt delete branch' '
-	git branch not-to-delete &&
-	git fast-import <<-EOF &&
-	reset refs/heads/not-to-delete
-	EOF
-	git show-ref &&
-	git rev-parse --verify refs/heads/not-to-delete
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit one &&
+
+		git branch not-to-delete &&
+		git fast-import <<-EOF &&
+		reset refs/heads/not-to-delete
+		EOF
+		git show-ref &&
+		git rev-parse --verify refs/heads/not-to-delete
+	)
 '
 
 ###

-- 
2.56.GIT

