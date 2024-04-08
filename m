Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C5433BD
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610140; cv=none; b=ZUT9L4V9C6CqkOLDTMGOsBZXS4lV0Lw/NQsCgryv0ZMhgw8H4ILSd8+m+WVo8QWF/QnDJ//l+1KLCrzeL9avSSAOMcbaHWZhEuYz7j1bcT/bVi3h2KLeeFjhpBi28KQB8jZR7SbwY8CXeqRLIPBWf4a8kLc4QOyG2QbloT/WJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610140; c=relaxed/simple;
	bh=NT0UZyZOye9WxWaBrkijnGM7VIe6SkhNqP/5dvNlPQ8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=PYFGT+nAsTjydGLH/BSusd72zNvWJxvxYxEFudEoRXIRZOPAyGz2PnhEi1FQsr/7xCLlel0k2Piwh3NUbtV/RsvdZils0D/DkXDiFYezl58HXQGfBdCvSCyeSGDjGtcpYsbWhswS5AaNKx1BnWiK5g8l39AX7kh6YdxAivkOZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlqLilOo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlqLilOo"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4169e385984so1904575e9.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712610137; x=1713214937; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YR7r4rjsuoMMg6trYhypWfUg2uYS7o5DG3+nCaN2X+4=;
        b=hlqLilOori7AJj7liEvYufa7m9Pih+qfzVvWsOJf7XgoI1nRkqe8hQUCh1jbHc6q34
         DHNIa0Fy5yr7ulXV2YGEhay3fge26eozObuTTlhvl/L3JwfJmljmnGLNk9sxBFCZUV3t
         XV3GquAWGI295S4jr62UpZOWqx2G5VEwFwOuKPQHMkOKSRWOmJEnCtreceTtey1rNVQm
         DjeNxTg4NkghAjxDwtE3hGGVO3xBONeBySF43ruMKOK/WJQylGev4vQjiKKRnH2aDNEH
         dj5IRy/nEbCrqaXR8HPYuY0uCG9VzO1ismxjArmhUc1NlcCcSr6XJeLamC1Uj7WTXZYA
         9NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712610137; x=1713214937;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YR7r4rjsuoMMg6trYhypWfUg2uYS7o5DG3+nCaN2X+4=;
        b=bYxNbm+HGO2YQq6RDrPs3iQuDMfh6a3okR82/VtK44woekHu5pLplLX9xtC1E1xIsI
         55hg5N3w+XX+yKuo6h5plu7BLjS3cj+d3S3RkrnVa8VhD20cjwRnRdihxOftp0aP91wa
         l0YLcveMTGKPRnIyXNXtIEw/nMkdETD5TVD158h0gvXXGzIxvG15f8yf8DI9AtflOKyc
         NP5kaNHzxWwONeFCMq9b1Zfn5nsRTx4DSbDBwJ4OkMrs9UtVziY3E0IsCN2WjZ75CAJo
         Y0/slOAb2RsCEYrgN+pex9ZrnrRyoLatfebDfNo6C5oivJR4WIUn+LPGM+WEu1OP+kGV
         mZeQ==
X-Gm-Message-State: AOJu0YweoYCO3ZeV6s057Whag01a8D5TMk56MpAy72TDCuBuQrw4+z2G
	xBf/VOm8+wv7g4NxZaNiY4EQ9+o+u0D4epj+6tueOs4qHiMOcM50x1OJepTa
X-Google-Smtp-Source: AGHT+IGK6mHX1lEJjyr0HPhvgtD3u0rfUgXfE/zP36ERmj79nXdkAXd2V63zlfyHd3aL9y+deL6muw==
X-Received: by 2002:a05:600c:a017:b0:414:8065:2d25 with SMTP id jg23-20020a05600ca01700b0041480652d25mr6883077wmb.38.1712610136887;
        Mon, 08 Apr 2024 14:02:16 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b0041674bf7d4csm4585963wmq.48.2024.04.08.14.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 14:02:16 -0700 (PDT)
Message-ID: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
Date: Mon, 8 Apr 2024 23:02:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] launch_editor: waiting message on error
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We have the hint we're touching in this commit since abfb04d0c7
(launch_editor(): indicate that Git waits for user input, 2017-12-07).

Adding a new line after the hint when the editor returns error was
discussed in the list, but finally it was considered not necessary
because a shorter message is used [1].

However, even with a short message, feeding that LF makes our next
"error: There was a problem with the..." more clear.  For example, the
editor could print messages that would be mixed with our error message.
So, add that LF.

While we're here, make the error message follow our CodingGuideLines.

 [1] https://public-inbox.org/git/20171127134716.69471-1-lars.schneider@autodesk.com/T/#u

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 editor.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/editor.c b/editor.c
index b67b802ddf..a658090a65 100644
--- a/editor.c
+++ b/editor.c
@@ -104,16 +104,25 @@ static int launch_specified_editor(const char *editor, const char *path,
 		sigchain_pop(SIGQUIT);
 		if (sig == SIGINT || sig == SIGQUIT)
 			raise(sig);
-		if (ret)
-			return error("There was a problem with the editor '%s'.",
-					editor);
 
-		if (print_waiting_for_editor && !is_terminal_dumb())
-			/*
-			 * Erase the entire line to avoid wasting the
-			 * vertical space.
-			 */
-			term_clear_line();
+		if (print_waiting_for_editor && !is_terminal_dump())
+			if (!ret)
+				/*
+			 	 * Erase the entire line to avoid wasting
+			 	 * the vertical space.
+			 	 */
+				term_clear_line();
+			else
+				/*
+				 * We don't want term_clear_line() here
+				 * because the editor could have written
+				 * some useful messages to the user.
+				 */
+				fprintf(stderr, "\n");
+
+		if (ret) 
+			return error("there was a problem with the editor '%s'",
+					editor);
 	}
 
 	if (!buffer)
-- 
2.43.0
