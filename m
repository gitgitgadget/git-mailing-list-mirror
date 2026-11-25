Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640156;
	b=L/j7hhc708Q6X/E9nEdUE+ZfcJY90tJQux+j3nEycnnmJ32HvrubXADqVuIeduO5ydxp
	 Jw2H8vgBRRba4sUhxcKU5f34P0/VlsWDKpbwbc5KkFlzOhsVYo/ly+lcOP8uLRC57M84f
	 xNQwk33ibjeGDPsJ09OXNMY5f8iNShd4lV9OmyyojG3EtjeoUSZIa+F3RDMQwYWgZsV0r
	 6bnqHiAB3429ODVW1CNA0O1hwTjcGYKnrlfrzIbtZ4usCFJbC+DSmW7xO3bGXdzD8Y9c5
	 KxGKkiNs+T7xx2qbCH+RATdcArvvaRxi07i/4EszL5UeYozXXMXJQDUY/K8MdmfrKrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=PJcTXIs9jpH6Hx3PBoC3bJmAq5OM/TGSjulDwj4/AM4=;
	b=Y73oGX8GpGQt36fl46cFMxXx9YHeoOARmonEI6uElWeO0F4LJxQjarFd8sAQuznm7sRp
	 66bPHmxhW5q9RuHrBqcBg1IagNNuXJ1IfW98jrgh3WTOWqKYYW3TdmmzDudGKUccxZQ8d
	 uKfwnRcYXhzFsSVAILN/Eqh81M4wIdsI/27w/8ggCd7ce2RCKh/y3BYfCXDm+tB4O86Vm
	 GT0DYVhe4gPe+90vMob9KjK4hkTxn90r+hnh8/V63roQc11/ZGPMexJgobROdUpH1TCJJ
	 SHZNsPAOZpuHq8ZsPBUNjnJ8ESCr3PHRV0MDt+YSLCyZcq+WrdoBOh5HdUSSVU0HGxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JtcwycIz;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE58606A32E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE58606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JtcwycIz
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6ddef424972so5093083eaf.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795640155; x=1796244955; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PJcTXIs9jpH6Hx3PBoC3bJmAq5OM/TGSjulDwj4/AM4=;
        b=JtcwycIzMEpU7HlZ16fYxouMu+HVUZ5yO6c0HdgfpE2sGorOKr/tnobE3JRb9maQnU
         yDhgIQiji+MpYJoFBUjOp+E5AsL0y6WliqhJdDJqq9PcGmlOrB80oQ2PbT9AQoIHzqcv
         mW0MXBk4oAfYrACaSd/iyI7jPmkTvPhWNXOW8PCciftlXqXVPOT3Z+7FKEOcHe0VaH8z
         y+RpKV+64elvLQdUjucyc53KciGU9axmVLa6JmXjSxefyUPH8c6f55iZILmJTrNo225+
         xPGrbZ80zqOOdgmfzyb35Toye1FOCYV9uIYFXrVps4KrmIgQcHxhONQAN0gd9f/0JnCN
         Xm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640155; x=1796244955;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJcTXIs9jpH6Hx3PBoC3bJmAq5OM/TGSjulDwj4/AM4=;
        b=M8jyG7sDf0iadOBQVREuxUeUGzz3ltkgcRFdWEG1Udy5FFDyVlNa4nqxsDXQyKmgI0
         5NBKIHfLFQNgC/n9jhH8kIWrBUr2S7sAikw3SKtXe2T5CkZa8Zi55pDxzqnbeaxTxes7
         vU8Ui5kvXrrs3RNT6Z9Gq1jGqE0lT6hgFvLP//Jtwi61DhJRTA1DoTunOJ9foA7o1Ocq
         f865OC8Y+hSPYgjo9ykDcCii6yxu3m28rOuyxCFjujn58C5lTWkIeNOrwgxGEbVj5sBI
         PGMhEDxIAEONxvuTqkc54XtggnqwLoOiQAZBLvzbiZGrOxDC51/BT544CSnjCf+vhxFa
         Kg0w==
X-Gm-Message-State: APuU4Z/NKCpxBGVzqI4hVFUWbeF/p11BLbxqC5yeTtTVYqRLUVw8vYXV
	4laeQtT5PipF/FNAId00HPPp6+ChoSQsJtpFQ5hzV12/yXe+sRhR9TbnapYvuwCx
X-Gm-Gg: AZFdTZfX/+Q9toe1ywnQd1vDhhPQpJV2KaIr0PNsA3Rf8vu/ouRQ1vxrr7KAWO1bxVE
	UGhCJG5L27DfOryinlJZJdtdwrZB+/8rAZ+Oxr9jI4iEE4Eki2Z9Hc74/dYqpU6LJVzkngcbrLU
	7ITSz1YHGHAi1JTNGgedS7GjPzshNpalF1AdNtF2zAPthAbLK+GSm7HkSlqul9RAgCM5prZTM+Q
	h21IwkYJazR+AX6IMUihNkJ1jmOf29cMmYmjT1KipI3ELoNb8JnA8Go5bKg6s1oCwtKGcw3cAxY
	x9ZEVZzVGYvkwlmKGdKQSeOh0H0+2A1Ilh22qJdQg/mdSX0aVvsAIyypIqUjdJ5iMvVNDGqzKrV
	bXl2CHxtpXUL4DlAODkFFXGXsezY5UhOGXuY1R+0JNCo4yTfoCrhOxsvwEicTzVL50oebJFDsxv
	UjG/LYTu2zDvThyY1s+nCoxddotjDUxOUltjinmKia7j9Gry9X46jxZYq7A5JsrnXaaqAvq0yHQ
	HuvmluO4WUhYf6RhoRz2J1+zNQPpfsFXVQcoR8xo6C1ljFpgscbxKFCZ6P1xjWuLoT6HQeV/euY
	IwmgFDMy5zJHUOO4pMFcZWTTYfeBQZES
X-Received: by 2002:a05:6820:c31b:b0:70e:2096:8070 with SMTP id 006d021491bc7-71b39482d41mr12910413eaf.35.1795640155270;
        Wed, 25 Nov 2026 12:55:55 -0800 (PST)
Received: from [127.0.0.1] ([132.196.38.97])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5edc52aasm18965805fac.4.2026.11.25.12.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:55:54 -0800 (PST)
Message-Id: <bb8225547fb67224a199137ff50a24720b4e506e.1795640149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 20:55:45 +0000
Subject: [PATCH v3 1/5] archive-tar: guard get_path_prefix against zero-length
 input
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Simon Richter <Simon.Richter@hogyros.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `get_path_prefix()` function uses a `do ... while()` loop that
unconditionally decrements the `size_t` index variable before checking
the loop condition. When that variable is 0 on entry, the decrement
wraps to `SIZE_MAX`, and `path[SIZE_MAX]` is an out-of-bounds read.

The current caller (`write_tar_entry()`) only invokes this function when
`pathlen > sizeof(header.name)` i.e. when `pathlen` is at least 100.
Therefore, the bug is unreachable in practice.

However, the function's interface accepts arbitrary pathlen and maxlen
values, and a future caller or a maxlen of 0 could trigger the wrap, so
let's add a check for that.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 archive-tar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/archive-tar.c b/archive-tar.c
index a1c66024d4..2da6e55484 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -210,6 +210,8 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
 		i--;
 	if (i > maxlen)
 		i = maxlen;
+	if (!i)
+		return 0;
 	do {
 		i--;
 	} while (i > 0 && path[i] != '/');
-- 
gitgitgadget

