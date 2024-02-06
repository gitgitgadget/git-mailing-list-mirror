Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4B745E6
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196368; cv=none; b=cECx6l6LZIeYYnpg/uozb0O38EUEsiZ3LQXn8W+xcp0HaC8a6FEnPk1y6uy0XbCXm8XTN3xF/c3DhsevXXwY0gkoo3L6KDB2lkLuzrHGWNNvGWH9wM6Tv4tZYWBj9fVcZe9gdhn/Fx/BtomgqGaY/ym0QmfhuQO+z2fPGFWJZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196368; c=relaxed/simple;
	bh=X8jODAoXyhVFsxb2e0JL8oWln9j8Q7N31oMJJSNpMto=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tKHYlNykupmyCyYtt74aKEADcbf3WFGcaUN/NfQVarIXesYaHZfXZ5cjQ65uFKfO6w4utp9xaXVlSxdcxIXvtuzUsDhOqKOZ5MiX7ED6pSF9Cdj/yUQHrXUvYQqbWnX2H6kpIgKwRlUNP/BTuOVEiXLS1JZMIb+7BqhOqr916yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5Vjaids; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5Vjaids"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fdffc3831so5986575e9.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196364; x=1707801164; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgfULWLl0d1IFcFtlIoerafH18ezJHxLxJaAx6L9xXs=;
        b=V5VjaidsAMbthNYskMiPKbcntnlbodJecNx6mRkOenDXfRxafbwS3/ST/2oqMbo/kh
         uBvfX9eCtFdDFgJqZQHf7iLqeKavuPQQlE10qI1T5m2rK7fxAQMyFI/NGUQpa9LjUeSx
         pYBNH8bToaiQUzDxQt3Ea/3GmXysv0lWK5nBDT3afhLVwX+GxQfGYX7iylK4k/sdk7yL
         stuRKp/KNIjekEMVCPIqRa9uL96S14vOADr/RyU/brJFdk+LnLHzXblqMGcvJyi0iAQp
         tfnIAu4lnE2RtU/rlKuVQrEmDw5REdWVayZxInE4dQBAZuALXS3kx/z0I76zhcJf8Ats
         Acjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196364; x=1707801164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgfULWLl0d1IFcFtlIoerafH18ezJHxLxJaAx6L9xXs=;
        b=t+3BW6nam7LfxYfSILTZQgmVyPKJ7Yu/RItJCvPWNn7H0/t2wj9SpPhkX0qqWZkgwm
         Bgv0/I+4a04wtPIJsAfSAQEWV/yRIGHLdTqGPJTFV27DORLz/BOFfBHb8sznMlu8OWW3
         83gFSQLh0mvx9lgxm+SCtnRhJ1gCFQGkAbi9b4BfkBCvQcOAyf2uzhXkpup+NdJZ+bON
         enrzE2xsn3RiYrHxyTdJkL9FfrrufkfLWzQxbd9dlO+NOw60J7yVtBH5ZwBLMdIqYTMH
         5NmJjjzy8KVaQ3QySzqE16FAJiTPOy4Q8+NnnZ9twL/jy+3Q+vrQEBfiwuTBj05r7bB3
         Sdtg==
X-Gm-Message-State: AOJu0Yw/W/d4uPoKN2YGWYDa5AmYO/xR2/Kqh3zwqVGICA1GeNwqMIWe
	VgrYlo5Dus216f0WC1nlvDsG3/3eDtQBxgcKisV6kM3290qFYJ20r9lq+rgy
X-Google-Smtp-Source: AGHT+IGEGb9eWqcTp21oGu8EnbB2uCqbHNgXyLkZl0JSySl7lfwW5nsPF2JrzIJkpjeeal77yQzXTA==
X-Received: by 2002:a05:600c:5254:b0:40f:d2f7:6e34 with SMTP id fc20-20020a05600c525400b0040fd2f76e34mr1128878wmb.33.1707196364228;
        Mon, 05 Feb 2024 21:12:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVU3OEku8Iam3UD1m3UjjUROfGH9VOv62KvUFZW9LYjSfUns5v3daUMqY8/Pki5Ky1Qfy/Brkv/evjJuSrvEoYuWPi5nxb1Xd0aPGoPxP2hfWLc0Vm2ym59qsR3hQTx51V2b7JMPdPi28sLVM4mIM8yISkzvO1Y046jIVDbRcaA+JYbNNqXfwqSpUe1uEdZwKvO8/MkXSrLeA==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b0040efb445698sm657196wmq.5.2024.02.05.21.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:43 -0800 (PST)
Message-ID: <ba1f387747b08a7270f7387beddd75dc4a8eddfe.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:15 +0000
Subject: [PATCH v4 15/28] format_trailer_info(): avoid double-printing the
 separator
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Do not hardcode the printing of ": " as the separator and space (which
can result in double-printing these characters); instead only
print the separator and space if we cannot find any recognized separator
somewhere in the key (yes, keys may have a trailing separator in it ---
we will eventually fix this design but not now). Do so by copying the
code out of print_tok_val(), and deleting the same function.

The test suite passes again with this change.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/trailer.c b/trailer.c
index c28b6c11cc5..5c42a19943a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -144,24 +144,6 @@ static char last_non_space_char(const char *s)
 	return '\0';
 }
 
-static void print_tok_val(struct strbuf *out, const char *tok, const char *val)
-{
-	char c;
-
-	if (!tok) {
-		strbuf_addf(out, "%s\n", val);
-		return;
-	}
-
-	c = last_non_space_char(tok);
-	if (!c)
-		return;
-	if (strchr(separators, c))
-		strbuf_addf(out, "%s%s\n", tok, val);
-	else
-		strbuf_addf(out, "%s%c %s\n", tok, separators[0], val);
-}
-
 static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 {
 	struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
@@ -1104,8 +1086,11 @@ void format_trailer_info(const struct process_trailer_options *opts,
 				if (!opts->key_only && !opts->value_only) {
 					if (opts->key_value_separator)
 						strbuf_addbuf(out, opts->key_value_separator);
-					else
-						strbuf_addstr(out, ": ");
+					else {
+						char c = last_non_space_char(tok.buf);
+						if (c && !strchr(separators, c))
+							strbuf_addf(out, "%c ", separators[0]);
+					}
 				}
 				if (!opts->key_only)
 					strbuf_addbuf(out, &val);
-- 
gitgitgadget

