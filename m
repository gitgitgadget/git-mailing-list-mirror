Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019712E1D1
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695334; cv=none; b=Mho1BNEASTfO5l6eRuoAbDNSyBU7df4HfRSUVZrjGuYs1wpyd0DFnjmkKG1jiR/cCvmZ5EO/iTIoBh08I+3tb3btQ0BIJ6pTckLYQdloGVNZrBDwjKspVLvO9Uvxrg2w5Nf2oEZP6sOxcFloxwIHUrTFBlYh0xx+OisHo25w0KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695334; c=relaxed/simple;
	bh=v9fWouZ+jNK3DuYDW0yqECcnXiZUUmf75T9+/DO3Aic=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=epDmlDYGFtM91XwU4Gmwqoifl+BPk42MJ/XsGd6ReoNN23RqO4NIpskgDEQ7JFw1ZbA9MMqeMcXhF2+7WZ3CH4AYBwuddVFetfsAtoA8kB6plv6z8A6ZTRFgZFHa+KSeAeFEjBgXht7F2fom22QOMkselapjc1/ZPcgiL1WVEGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFOg2fpU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFOg2fpU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266fd39527so36800575e9.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721695331; x=1722300131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQUmnsmyBFiKlp1bZUG2SuB5OPBJXNrZiJQWTF+4KkI=;
        b=HFOg2fpUzhdQO20NPH0nqFfFkxwXialupIWTLVLDumIx+Yk/QnLoBORVgrseNIb6IP
         p+H4GqblFAhKAl3OvXg8DRZOwCHtl5n7rrmicFUloZmfr/Kp6dq7qRKNZUVamrKaf4BM
         0+rviFtX80Qg6J6rI9oAHr8SvZYKhQ2WRqYxikRHVxCLEPv+hP7fBu0ORFu98xBXFqdi
         iGjdWhanQn+vGir3Z4nsCGB9yrBAejvCi6Lo+4ajXIdThCHoXxyCjmuhroiN9rePdWr2
         4MeAmB5kaQhHyvB4zCKSGx6xdic0TuUvM7oGvtvCrlFov03Pclagc34G2MCTCbyZq42+
         FC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721695331; x=1722300131;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQUmnsmyBFiKlp1bZUG2SuB5OPBJXNrZiJQWTF+4KkI=;
        b=v1lggXhurX5oOT7qm88wUN4mzCRwejy0eDBbpCg/EFcfsiPZp9vRlqbhg7DhkkHyIO
         BeC1l+dYXR/+7SEV3j0Ve4xmpqeFm9JPKSkwdskia0X3IYQhYynki0nW8zoRxn3yM7x9
         pSS3rLnGRgaVPo1iMFUUUObIgF7pbP0WxZOoipY3zjvRJ0lzLqH5W7SG+hCS4cg6BoYg
         d3O3t5JeYp8mrPaq+gsnYiYY4gWPJprCRDG5r1HpMiY2k1wRlvzbECbUoaaZZiXKskPm
         G+f1apf19fKQOPjDqyGXo9V+MfImvn6szfLXBXl+le3jw8HKmishSu4nVxT9ocatwwkC
         aH+Q==
X-Gm-Message-State: AOJu0YytSEbjyXw7r2Wa62Sj0sSVzBEmyGuiVVk03HT+a7+4aUJKXX8p
	IVgtcvfR4Pgu7xrQQ1fvuKnF1Xan7a04zIDmdhbc+LvREVzf5AM4
X-Google-Smtp-Source: AGHT+IE8LlDKV/0jf8RDxYwxfMHjN5wiv3/+JNHAs+q75vghNpL76xLzF/cGsD7oLvL8D+VtYxArKg==
X-Received: by 2002:a05:600c:354a:b0:426:6921:e3e5 with SMTP id 5b1f17b1804b1-427ed05f101mr9074705e9.24.1721695331275;
        Mon, 22 Jul 2024 17:42:11 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a3b763sm175639415e9.10.2024.07.22.17.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 17:42:10 -0700 (PDT)
Message-ID: <af444f9c-7f40-4afa-98dc-0b503642b58c@gmail.com>
Date: Tue, 23 Jul 2024 02:42:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/2] t3701: avoid one-shot export for shell functions
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
Reply-To: 43e045e5-4c92-4c5f-b183-d63c5b510023@gmail.com
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
Content-Language: en-US
In-Reply-To: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The common construct:

    VAR=VAL command args

is a common way to set and export one-shot variables within the scope of
executing a "command".

However, when "command" is a function which in turn executes the
"command", the behavior varies depending on the shell:

 ** Bash 5.2.21 **

    $ f () { bash -c 'echo A=$A'; }
    $ A=1 f
    A=1

 ** dash 0.5.12-9 **

    $ f () { bash -c 'echo A=$A'; }
    $ A=1 f
    A=1

 ** dash 0.5.10.2-6 **

    $ f () { bash -c 'echo A=$A'; }
    $ A=1 f
    A=

Note that POSIX is not specific about this behavior:

http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01

One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running dash
0.5.10.2-6, so we failed the test t3701:51;  the "git add -p" being
tested did not get our custom GIT_PAGER, which broke the test.

Work it around by explicitly exporting the variable in a subshell.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t3701-add-interactive.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index c60589cb94..1b8617e0c1 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -616,7 +616,11 @@ test_expect_success TTY 'P handles SIGPIPE when writing to pager' '
 	test_when_finished "rm -f huge_file; git reset" &&
 	printf "\n%2500000s" Y >huge_file &&
 	git add -N huge_file &&
-	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
+	test_write_lines P q | (
+		GIT_PAGER="head -n 1" &&
+		export GIT_PAGER &&
+		test_terminal git add -p
+	)
 '
 
 test_expect_success 'split hunk "add -p (edit)"' '
-- 
2.45.1
