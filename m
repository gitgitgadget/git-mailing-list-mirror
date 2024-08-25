Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74B179A3
	for <git@vger.kernel.org>; Sun, 25 Aug 2024 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724581172; cv=none; b=OKQphKS/aO8yzjGsGZSABVlaa39UqINnGTlJFmtVpFfvsqkJ841POIQGXo89BykQNr4hLLKTn2+QHGUQDai78esmBgwhmSOwam4Kf9t18kNLr2/GWXxL86uqLwbP7kAEaqNh7ge2Oj3l98b6NPCq0TzZ55qm8iqUeZcReN5fB58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724581172; c=relaxed/simple;
	bh=TzPNQJM2LaybfqVOmrOLImI8ygStqD90jdr+Sm4uN9A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ebLCEigca0DYSRPgD/R+WV14yj+B+TMVY2U+pxN66hZJAPuLoa3ZXpsiZsNql/qlbYUHEqfMBGU/rE7iZ3xVGPjGb/jIvFV75w890WDRw24ChRFiiyO32R/c48fFXWttay/Ve7ISbJNv+ZTHQMPbmcO0I4UzWLg1sOGKa3cyGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONvBcM+g; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONvBcM+g"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37193ef72a4so2006581f8f.1
        for <git@vger.kernel.org>; Sun, 25 Aug 2024 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724581169; x=1725185969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ5AQI1Hd3n620+6eNQxRRCpC7Z8X9Ij8X1By4E6JCg=;
        b=ONvBcM+gqfg06QColBQGEJ5uUi7b2B+9kMaF8kC/ckE+3MiIi27lpf70PpyM/jKt0T
         1u0uJytFUC6svLXZFX8RLcrIFQJstdro+P63+64o2NnbXKPS0WoVMPXtHdGVI5Bgba20
         260GLYBr7vgPwJk9pWmAQwSOS1h+1onrSsNvfud2BfI8KEl5cVZMvY5wuv+NXb7KEQEq
         D9lO80nHyheWPbZqRTRzXr5SpR/UQeJDru/0fOVCWB/4mOGkUlOP83otd74/P7t8ONP5
         VJfwVfnRO+hkTzwO+Zb/guqmcdHFVtEOnUgJaRUF3DFwYSmpwpK0riWtYgD9C9qFf11M
         /kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724581169; x=1725185969;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ5AQI1Hd3n620+6eNQxRRCpC7Z8X9Ij8X1By4E6JCg=;
        b=Z43VCt7ZHzL8XmZdG4OGG6/hOx+OHXNtdUt0VbP1VFwOF9DXZeX5b56PKWsX9BIPje
         /wj+qE5+SZf+JMUDSIVb/L7IWe6jJMlfBlaeIe7+0gm+sVDfTQRmWtBj7ODyRVKtH9eZ
         mcTQFZuvc2C3+LakTyPXlRq9YC1x2uZDueHnVykf07zUKORU+Bqc9txFc8QujUFPaHV8
         zuffCpm3FEkWCT3uIy1q5xDXoI+MDi/aYCslKA/bFrOYPr/ATZg5B1a4dd+q96IG0DEk
         /5T65FCCmLyX0jPF2x1QnKHz834e0lR0wh3DuhknKi3gQHIDMGYvHpSdv6k1THn/Jg8E
         NRpg==
X-Gm-Message-State: AOJu0YwJr/CmJFCEiXIy6briX7LIvEzFynEZSlIKnX7nxQnOSxBygUnQ
	Pm6eXcHFrMz3WY2yULmqVIzPct+YSDfgoGvp9hkT430n9D98wMVUKZ19qw==
X-Google-Smtp-Source: AGHT+IEaWoFm65ecfLdm9yZe6fHexLLmfZzD0Da8R+Dwdymw8YL/IBEB+bKu237OXbLjdhbf/OvEDA==
X-Received: by 2002:a05:6000:1e52:b0:371:8292:4ede with SMTP id ffacd0b85a97d-37311926553mr4503493f8f.63.1724581168744;
        Sun, 25 Aug 2024 03:19:28 -0700 (PDT)
Received: from gmail.com (107.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308114a2dsm8342052f8f.3.2024.08.25.03.19.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 03:19:28 -0700 (PDT)
Message-ID: <a8ce6f0d-f0f2-4467-bf16-e7ce78c6ce2d@gmail.com>
Date: Sun, 25 Aug 2024 12:19:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/5] apply: error message in `record_ws_error()`
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
Content-Language: en-US
In-Reply-To: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It does not make sense to construct an error message if we're not
going to use it, especially when the process involves memory
allocations that need to be freed immediately.

If we know in advance that we won't use the message, not getting it
slightly reduces the workload and simplifies the code a bit.

Do it.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/apply.c b/apply.c
index e1b4d14dba..e6df8b6ab4 100644
--- a/apply.c
+++ b/apply.c
@@ -1642,8 +1642,6 @@ static void record_ws_error(struct apply_state *state,
 			    int len,
 			    int linenr)
 {
-	char *err;
-
 	if (!result)
 		return;
 
@@ -1652,11 +1650,12 @@ static void record_ws_error(struct apply_state *state,
 	    state->squelch_whitespace_errors < state->whitespace_error)
 		return;
 
-	err = whitespace_error_string(result);
-	if (state->apply_verbosity > verbosity_silent)
+	if (state->apply_verbosity > verbosity_silent) {
+		char *err = whitespace_error_string(result);
 		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
 			state->patch_input_file, linenr, err, len, line);
-	free(err);
+		free(err);
+	}
 }
 
 static void check_whitespace(struct apply_state *state,
-- 
2.46.0.353.g385c909849
