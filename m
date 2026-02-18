Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239DB32B9B2
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449616; cv=none; b=S94a2ygdhektRELNztCTUz/hldW5mOpTpqnaUjnOtg/o0D/w51MaHBnQmZOUF+UsEBUMnDiuh1jgrvj04ZiZzlNHFS7YVRrcNWOMTW2AhTGhc2/hLp/XtS15L5nSqO7Aw3KtNjpOPx/UH3IL0LF4V6+30cp45E8wchC4n87sZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449616; c=relaxed/simple;
	bh=fBpB9eMfzE3Xk5zyxk+LFnsFWj8X1oMLlNRMUd9FH/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0Cn+IGbQW6pahWJ5tWLv1A64jkF4qmjCYVegTZB8HAFi+UsBE1zioDfiOP15sqUsEYCMCZHh4cgjcRKT4pGQLetTpbvxDWu67rlZYEZZ6atifG3s8vDk+dCFqvbqnXVtFfornE1RqoRzE69PHL94T33ShU2utG9z2JeYPEG+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK9jH83k; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK9jH83k"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-948a374845fso170889241.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771449614; x=1772054414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBXuYxfp6cDG1q2ah0A89YkkgRAFCI8AuxjfqKZADOw=;
        b=SK9jH83k808h0dDEWJVy7iDpQkoYKIgfXaqmzT2ySnkyUP8hl2pccWdNbzy7GMpQZx
         voRk15A54e6ZBTNjtWbpbrajnii7EBtMQM2SuTb1tEW/I4G3oO2CTkUrkRHzo8y7wtwS
         HmyzcBwDKHS7M5KddKJoe9KbQTygTGFy0EV/16wpYmktLbMv2LtD6K4GMjFjo75Rm2e5
         vGIHTL6ZNoIKR4jNw38wdxAG+x5ICGrxCqglV9ysrJTXpF8w/dO3B3V0qc80abziht/a
         nzrc7uFUuMHBDBhSe7DPs5CJIEyYttGKCD86gK7zbqxTvJk5lg9B/M08AF0va8zJFDFa
         C7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771449614; x=1772054414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JBXuYxfp6cDG1q2ah0A89YkkgRAFCI8AuxjfqKZADOw=;
        b=r33GMV2lrQC0Kq6z+KOYgdkQplfKCS1OiSk4qKc3TA8Dn5wTETFDv4QziYZESMe2t3
         GJTN5p27gFwAAFcbZ4EeOGgo5JaXWcy98utaAcJT66asvACz5dxjPDaX/SKP0wptx0VF
         EEdSyefpwGlASCEMVYwfbY5xW6+AHtFtkovO7duEjFd0b4TaTaqG3TEqts8ekb7Qc2Cm
         BgqxOi/wNwFmOqbJPTlTjA4AW3+A4yRkJXw7wek6Fp6FHyvUVusUwOaQp6ukiDuv3vNw
         uAQqhyWNBd5tqtuuXekdSaVM1G8obOad8zXLl29C22ArSorL0cA7QVyrwhRI7H+tiuHM
         tTig==
X-Gm-Message-State: AOJu0Ywzf0Y7iTyyYxJBOmBaHk1irxprUA1Ed16AaqCghkSiTYWvtJm0
	wpYzMuFxP3Htmj00DquEwoYjVe202BbakDyeQB0ToqnQ9cNFiufTY6oJQ/Sx3g==
X-Gm-Gg: AZuq6aKyFy0sAFVLDFdyc6cqICo95jAZbE8u3c+P89u2TqfESpHPncSxMc5gUxLIrOs
	7tt042wEQijE5y27fS7PuI+RekIEP+msHzeJ+uaNjFjdRJ34NzOF7FlVDUzCw+5ZFgZXkz9puCb
	ufNT2XfKLRP6PISRiqP5UvIKcu5B/o8yrfyiRlRKm/OR8U5/A0bMpc/YQRTHcJHTcVHuDUlFdk1
	ILwpToFcvU6dl5aa9/euYe8UemtA+MiPHfRaIz7luSG0ivH7sdNA06zO8hQUgxBm/85LHlmxkdU
	DKsFRDV3b+ZsvrTIDYQpAHbuSV+alUh80SY5Vh1bX6KSvMZTwbPgT3uvibOS3gZEBrwZImO2t00
	3HFic7Jm7KUM56dV6GeOU12xOqjeatA51x5CE9HuZ+quu1Glx6F0VkY8WFunzzBa9UuKoVng8cx
	dHZtvpAWK6SQMTMtfpXQyTiHIkX0EqQADzyU0VeevxjYBkj/VaabQgnJjndZKoH7aTKrLaEpi92
	CDc
X-Received: by 2002:a05:6102:5493:b0:5fd:fff8:5c36 with SMTP id ada2fe7eead31-5fe1aea9f85mr6658238137.39.1771449613906;
        Wed, 18 Feb 2026 13:20:13 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:a068:d017:8d32:248])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afcdc345asm12326301241.0.2026.02.18.13.20.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Feb 2026 13:20:13 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 6/8] t1901: use tr in git repo structure output instead of expected value
Date: Wed, 18 Feb 2026 18:08:42 -0300
Message-ID: <20260218211845.96009-7-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'keyvalue and nul format', as it description says, test both
keyvalue and nul format. These formats are similar, differing only in
their field separator (= in the former, LF in the latter) and their
record separator (LF in the former, NUL in the latter). This way, both
formats can be tested using the same expected output and only replacing
the separators in one of the output formats.

Adjust the output of `git repo structure --format=nul` in t1901, matching the
--format=keyvalue ones. Compare this output against the same value expected
from --format=keyvalue.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 t/t1901-repo-structure.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index a6f2591d9a..4de795181f 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -145,18 +145,18 @@ test_expect_success SHA1 'lines and nul format' '
 		test_cmp expect out &&
 		test_line_count = 0 err &&
 
-		# Replace key and value delimiters for nul format.
-		tr "\n=" "\0\n" <expect >expect_nul &&
 		git repo structure --format=nul >out 2>err &&
+		tr "\012" "=" <out | tr "\000" "\012" >actual &&
 
-		test_cmp expect_nul out &&
+		test_cmp expect actual &&
 		test_line_count = 0 err &&
 
 		# "-z", as a synonym to "--format=nul", participates in the
 		# usual "last one wins" rule.
 		git repo structure --format=table -z >out 2>err &&
+		tr "\012" "=" <out | tr "\000" "\012" >actual &&
 
-		test_cmp expect_nul out &&
+		test_cmp expect actual &&
 		test_line_count = 0 err
 	)
 '
-- 
2.50.1 (Apple Git-155)

