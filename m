Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F632CA4E
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771373737; cv=none; b=Ovuhbq0akoF65S8nrIWitBdZ876CXLz2YdMVNQ+DqmSFfsKklV/V8yNjRQNbCOsBE+1EUfEeGNa6d5bPBXh4R5ipdongzTRr7D8F3URCaMisHPagWZq4To//R0ghhGdqWB+CHv56cBk8WOCT4hCak8NVQXb5joWU5y9uBEyPQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771373737; c=relaxed/simple;
	bh=aAFTfsiEj25GHT9vuFwhQwGNvELRDgUeEh9ESlsUq/U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MtR/0Pg++T0M5kVz8CxhXlNEd3DmozAYXS1tsksdrdyO4hHPNg8At/cy41gCCugde8NjrX2c4/D6hI9ZFvn5nw3XBE7AJ4Lyqslx2XW++mHgPtdXA/eOptFz+dl/3CeHOpxtU38OEqw7YbNMiY/gifF5ArQuhgM+1uKx8QfHjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2wEKXQh; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2wEKXQh"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1271195d2a7so9636520c88.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 16:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771373735; x=1771978535; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BryyTB+e5nNA1CWMI1Bth2PtfCtUqhx+RbaI4xhDNdI=;
        b=j2wEKXQh46x6B+jeys/wkvja/4fVqmEiPxlbknjFEDceXf9wiYs2I/Gg/oljz1AXuT
         CycUlZCLIR4guqplrZBXPGFzGi/ISQTJAJ6UTRaH+PuERUSEOGlJFoSINvFvZ22jMaVS
         OPnsJj1Jv5sjCD4Ie4ktikolJH6jE0utTFSW2ZuCLMj5Sr5xWIn1h1d8adWqBf+WAMcp
         oB2aB5hE5LjX6fKC5NG7WKplyPQnbdIezQ3tMaMcKeLQwUbfwntOuuSjolqliIIEHJWQ
         zEWsn9TgntfHw2xLKVFmO4XL8gEqzaDD9r5wu/7juTh4B3ouyIcXvSuqN1NLmRtl81wT
         7h0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771373735; x=1771978535;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BryyTB+e5nNA1CWMI1Bth2PtfCtUqhx+RbaI4xhDNdI=;
        b=V10+RGGd2mZGekzQl8QENRu8ps1VxpVwNRH+Q2ttOkqrtkdbKmTpwnjvelWWiXxStU
         xHYUc1AlpEJzb5cUoAApr+tsAb6ojWMe89C2LjwrJXEQwQCJk6eN6+BPioxB6XsUTpxZ
         EVUPjBmgXAa6G/tSouuhKxuXAAEDyWg6SlDgTG62OVlPaUMr/u9iW9ma1f07MuBdSNhK
         VM/GjtzrJH9nEDUJJczkffeTf/QWhdXAQu9kG4zCP2FAl75gTsXjjrz911G7Setiz7eK
         1jgjbUq4nSfcJ2ahqu8hhCSFH+EoOzUl0J/CpAVj1q/KysieWLoQSKu4+qge9bPEdbXU
         ogwQ==
X-Gm-Message-State: AOJu0YyGBUM6Mn1SzkfpjeX/RhIOzgvqKGr8unMSxeqWWOC1PAad6e5y
	G25xh4d6677iZxu6lBmktpSE7mmgiCLaiKC6crZFoDISoH5JsugCVgd6aW7Z6A==
X-Gm-Gg: AZuq6aKUrQQKCZYA1QOX3aFsy4rBDrf7EdFgpkAe55Kzea4pIJishiDnl7vzXQP24md
	rPMYWiFQmwWtflShCsvpm6Wd7geE62iFjz4ZA2wzNHMDY2JO2hOmAFBDiQPXSN8gPjRJOvEcIzj
	zAzwaU5Sx7s/ICOdF3ssvYPUwOqIYCUd+E+DgTsxUE6OSLGCgvoosh+o4/lXBFSOLXg4D6z9HX7
	1ItvF4regT9fiKQTIDGlFVymBvxo8sps15QzRnTWJwwtHu1BtMacaQ6p450u5dOwHK1C4dvfVpX
	xaxFdJXlSrgEaucextFBje7CgmvU+CZxkEyU672lUMxkubHE64UvGyz9xeL559r5XHyNvQzywpo
	WkFmnsI21nDmR5A2dUf6o76/3YJf64MVON9zmg/LpGjycnEu4R4tlolMzSwaZ+2mCiGdzl/OkYE
	ZQPZKYvEaWrKVuO8up53naACIAYcvcILmInmH9
X-Received: by 2002:a05:7300:a984:b0:2b7:a3a9:9c28 with SMTP id 5a478bee46e88-2bac9795c4cmr5717955eec.20.1771373734238;
        Tue, 17 Feb 2026 16:15:34 -0800 (PST)
Received: from [127.0.0.1] ([52.159.243.198])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb6782e5sm16060542eec.29.2026.02.17.16.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 16:15:33 -0800 (PST)
Message-Id: <pull.2198.v2.git.git.1771373732749.gitgitgadget@gmail.com>
In-Reply-To: <pull.2198.git.git.1771002510709.gitgitgadget@gmail.com>
References: <pull.2198.git.git.1771002510709.gitgitgadget@gmail.com>
From: "Joaquim Rocha via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 00:15:32 +0000
Subject: [PATCH v2] apply: normalize path in --directory argument
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Joaquim Rocha <me@joaquimrocha.com>,
    Joaquim Rocha <joaquim@amutable.com>

From: Joaquim Rocha <joaquim@amutable.com>

When passing a relative path like --directory=./some/sub, the leading
"./" caused apply to prepend it literally to patch filenames, resulting
in an error (invalid path).
There may be more cases like this where users pass some/./path to the
directory which can easily be normalized to an acceptable path, so
these changes try to normalize the path before using it.

Signed-off-by: Joaquim Rocha <joaquim@amutable.com>
---
    apply: strip ./ prefix from --directory argument
    
    Changes since v1:
    
     * Normalized the path as Patrick recommended
     * Return error is we have ../ at the beginning of the --directory
       argument

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2198%2Fjoaquimrocha%2Fapply-directory-dot-slash-prefix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2198/joaquimrocha/apply-directory-dot-slash-prefix-v2
Pull-Request: https://github.com/git/git/pull/2198

Range-diff vs v1:

 1:  82e24c3471 ! 1:  8ac66a876d apply: strip ./ prefix from --directory argument
     @@ Metadata
      Author: Joaquim Rocha <joaquim@amutable.com>
      
       ## Commit message ##
     -    apply: strip ./ prefix from --directory argument
     +    apply: normalize path in --directory argument
      
          When passing a relative path like --directory=./some/sub, the leading
          "./" caused apply to prepend it literally to patch filenames, resulting
          in an error (invalid path).
     -
     -    Since using "./" is almost memory muscle for many, strip the "./"
     -    prefix so it behaves the same as --directory=some/sub.
     +    There may be more cases like this where users pass some/./path to the
     +    directory which can easily be normalized to an acceptable path, so
     +    these changes try to normalize the path before using it.
      
          Signed-off-by: Joaquim Rocha <joaquim@amutable.com>
      
       ## apply.c ##
      @@ apply.c: static int apply_option_parse_directory(const struct option *opt,
     - 	BUG_ON_OPT_NEG(unset);
       
       	strbuf_reset(&state->root);
     + 	strbuf_addstr(&state->root, arg);
      +
     -+	if (starts_with(arg, "./"))
     -+		arg += 2;
     ++	if (strbuf_normalize_path(&state->root) < 0)
     ++		return error(_("unable to normalize directory: '%s'"), arg);
      +
     - 	strbuf_addstr(&state->root, arg);
       	strbuf_complete(&state->root, '/');
       	return 0;
     + }
      
       ## t/t4128-apply-root.sh ##
      @@ t/t4128-apply-root.sh: test_expect_success 'apply --directory -p (2) ' '
     @@ t/t4128-apply-root.sh: test_expect_success 'apply --directory -p (2) ' '
      +	test_cmp expect actual &&
      +	test_cmp expect some/sub/dir/file
      +'
     ++
     ++test_expect_success 'apply --directory (double slash)' '
     ++	git reset --hard initial &&
     ++	git apply --directory=some//sub -p3 --index patch &&
     ++	echo Bello >expect &&
     ++	git show :some/sub/dir/file >actual &&
     ++	test_cmp expect actual &&
     ++	test_cmp expect some/sub/dir/file
     ++'
     ++
     ++test_expect_success 'apply --directory (./ in the middle)' '
     ++	git reset --hard initial &&
     ++	git apply --directory=some/./sub -p3 --index patch &&
     ++	echo Bello >expect &&
     ++	git show :some/sub/dir/file >actual &&
     ++	test_cmp expect actual &&
     ++	test_cmp expect some/sub/dir/file
     ++'
     ++
     ++test_expect_success 'apply --directory (../ in the middle)' '
     ++	git reset --hard initial &&
     ++	git apply --directory=some/../some/sub -p3 --index patch &&
     ++	echo Bello >expect &&
     ++	git show :some/sub/dir/file >actual &&
     ++	test_cmp expect actual &&
     ++	test_cmp expect some/sub/dir/file
     ++'
     ++
     ++test_expect_success 'apply --directory rejects leading ../' '
     ++	test_must_fail git apply --directory=../foo -p3 patch 2>err &&
     ++	test_grep "unable to normalize directory" err
     ++'
      +
       cat > patch << EOF
       diff --git a/newfile b/newfile


 apply.c               |  4 ++++
 t/t4128-apply-root.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/apply.c b/apply.c
index 3de4aa4d2e..7f0ce5918b 100644
--- a/apply.c
+++ b/apply.c
@@ -5002,6 +5002,10 @@ static int apply_option_parse_directory(const struct option *opt,
 
 	strbuf_reset(&state->root);
 	strbuf_addstr(&state->root, arg);
+
+	if (strbuf_normalize_path(&state->root) < 0)
+		return error(_("unable to normalize directory: '%s'"), arg);
+
 	strbuf_complete(&state->root, '/');
 	return 0;
 }
diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index f6db5a79dd..5eba15fa66 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -43,6 +43,47 @@ test_expect_success 'apply --directory -p (2) ' '
 
 '
 
+test_expect_success 'apply --directory (./ prefix)' '
+	git reset --hard initial &&
+	git apply --directory=./some/sub -p3 --index patch &&
+	echo Bello >expect &&
+	git show :some/sub/dir/file >actual &&
+	test_cmp expect actual &&
+	test_cmp expect some/sub/dir/file
+'
+
+test_expect_success 'apply --directory (double slash)' '
+	git reset --hard initial &&
+	git apply --directory=some//sub -p3 --index patch &&
+	echo Bello >expect &&
+	git show :some/sub/dir/file >actual &&
+	test_cmp expect actual &&
+	test_cmp expect some/sub/dir/file
+'
+
+test_expect_success 'apply --directory (./ in the middle)' '
+	git reset --hard initial &&
+	git apply --directory=some/./sub -p3 --index patch &&
+	echo Bello >expect &&
+	git show :some/sub/dir/file >actual &&
+	test_cmp expect actual &&
+	test_cmp expect some/sub/dir/file
+'
+
+test_expect_success 'apply --directory (../ in the middle)' '
+	git reset --hard initial &&
+	git apply --directory=some/../some/sub -p3 --index patch &&
+	echo Bello >expect &&
+	git show :some/sub/dir/file >actual &&
+	test_cmp expect actual &&
+	test_cmp expect some/sub/dir/file
+'
+
+test_expect_success 'apply --directory rejects leading ../' '
+	test_must_fail git apply --directory=../foo -p3 patch 2>err &&
+	test_grep "unable to normalize directory" err
+'
+
 cat > patch << EOF
 diff --git a/newfile b/newfile
 new file mode 100644

base-commit: 6fcee4785280a08e7f271bd015a4dc33753e2886
-- 
gitgitgadget
