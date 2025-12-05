Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3A30595B
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946963; cv=none; b=nY8IwrgAM4fBvsEymXQaf4MxhYsbW0HlFYFDZtDz0rutOJA9XyUcnnrixDYgpZPSHcGmrIsXkzZ6U0BZutoHkjd+M2eg0uiKBwMA49p6xAG51dj16NjDFAfKIJM0+RSiTRMgswsCxwNx5E2KHSnsD7e0ayRh7yw4waV6UFPGvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946963; c=relaxed/simple;
	bh=oZaLOTVlbZaMMOUyojkmt0fzh178aFUpiYBxAZ6RFmA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fWV5cPDJa8BgBT/ZRYrYZqsRvPPwo7+BSuxKZu62l7w0F9O2KcxJeg7uLZacpnBPH0Crp4DEKNrtE2WN25UboVbYFgn9Fsuxwz/6GRWxPPTnSKf0acfm+CVc9p2Dlk+4JDs8raoYtvp3NMqRvK70vUWkSjHh0/zUxXNNUYusSdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoM7YurG; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoM7YurG"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-93518a78d0aso1263221241.3
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 07:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946955; x=1765551755; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zF0/9k7+5kiugSM7dWVf98N8rbcXlJUxQ7z66V8dGag=;
        b=FoM7YurGN9XLnFuoL0lPAQ47llwAhpgCKbkvUp3TL+02hFIPUC0vZw1gmkIBSIyOUj
         K9bTvIRlKSV+OhP/5utPb28CytOvXRIG5deI3Zhy+Guk3eFORBBfLlTqicUyt7Efl7Pu
         V7UTz2vvWoziVazPqz4y+eNqKVZPeaL5XYAqKxBfKDQC1mQWOp3r4i3yADnJylJy2gEh
         CVIV0odIpw1K2B5ol1NARAi5WBzFMJx/N0nnJl5AluiLjtYMAPLukRKn2rQVGmzmv+QX
         ELLkRsKeTC2Dzd8Dh+THigniEGR/dQ76/VdO+D5xsHbqEcgXRwK9gj1GYSwUFO2Gvb7Q
         Cf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946955; x=1765551755;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zF0/9k7+5kiugSM7dWVf98N8rbcXlJUxQ7z66V8dGag=;
        b=M7c3W5UxkxeEbOJ5RQVbiw3RsPRnZo+Q3qxd3QBdNn5XcOd0VWkcLIdXAbG4uiNM4B
         FwArsWS6TrDOTQHFbDEPapmPunzKkolNZJTxqjJBISnwmRNWsCWePW1KvSjBnzptsCzg
         BT5z9r5w7HhreKGDPBrNb3Opd9FKOoCiSzp/RsaNFTocZWEWduQRpM6wSy257wHNKHHT
         qn6sopWGEAUKffN3s5wuELIkrXdfIfnrXF+2S8fInJ/xe3jazd9t5RYAqTF1jpl4bUmC
         hAwarKRtVUegI7sntABA9q87zJVKJTds/vSqzLsFMcm8sO3G+iWN1SWdYIk6Ty72xYkO
         wgqg==
X-Gm-Message-State: AOJu0Yx+wU4HF9BKWlFPBGjEsRUyD/oJhRpC/OwyTAkUr8Z6vDXmKTZY
	I1EV/SqdyvRlRmr9sM9f2znInNZ2LUIsIbRU2m4ogDxhplYVY91HEvX6U2jRMg==
X-Gm-Gg: ASbGncvZ0ZQWfipFZpFB/CdIYgueI6xpbCX4CtkdQAIw8R4W3iRvdS94ZsAM7Q1MFWL
	Ul5QAKrz7ncohL/UlT2PdzGMAGTeA9u+wvZeAuW8f2eX35OpHnAz3wQXn0LrgmM0f8sCrThxdRg
	j457YccTksdlNSw9srbKkqnjNTztl8dmKIO4/53H3JiO8YFv9NHfCdJADFb58q8ggQRAOjCxb1J
	zQ8HWtmEBkurukJqACdjjfthb4JNeehu7YShc9H2b8Jz9J2lTycqsDLlHV+3oPVU0qA3WFJ3Aaa
	MaEbZRYz/qqej5VxNz2fyZj9LUxbEAsSnjL+5dNOGli7R/7aTfvgpIIA8EXLllUpEfIXjx7aG3R
	RU197bo5Iq8MQ4vpcVL90azGa0huYGjtbmBNulrjNwJaNNkS6WhHdOkzYLJByviSOqKIaZgNnhZ
	s1Sci+Z27I28yv
X-Google-Smtp-Source: AGHT+IGzIHHKjvWquNExtoXJwGAHPcL+3PLhCsTz0xL02FMDHwUq/W0Ulo7x5qOU1TQiQXqP6IXDOQ==
X-Received: by 2002:a05:6102:3e89:b0:5d7:dea0:d6c4 with SMTP id ada2fe7eead31-5e48e22285dmr4073413137.7.1764946954163;
        Fri, 05 Dec 2025 07:02:34 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88827f4d413sm36873846d6.18.2025.12.05.07.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:02:33 -0800 (PST)
Message-Id: <f2da7d4d503eaf9dabf61a0626be2586f9da835f.1764946945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Dec 2025 15:02:21 +0000
Subject: [PATCH v2 06/10] t0600: fix incomplete prerequisite for a test case
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The 'symref transaction supports symlinks' test case is guarded by the
`SYMLINK` prerequisite because `core.prefersymlinkrefs = true` requires
symbolic links to be supported.

However, the `preferSymlinkRefs` feature is not supported on Windows,
therefore this test case needs the `MINGW` prerequisite, too.

There's a couple more cases where we set this config key:

  - In a subsequent test in t0600, but there we explicitly set it to
    "false". So this would naturally be supported by Windows.

  - In t7201 we set the value to `yes`, but we never verify that the
    written reference is a symbolic link in the first place. I guess
    that we could rather remove setting the configuration value here, as
    we are about to deprecate support for symrefs via symbolic links in
    the first place. But that's certainly outside of the scope of this
    patch.

  - In t9903 we do the same, but likewise, we don't check whether the
    written file is a symbolic link.

Therefore this seems to be the only instance where the tests actually
need to be adapted.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0600-reffiles-backend.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index b11126ed47..74bfa2e9ba 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -467,7 +467,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	esac
 '
 
-test_expect_success SYMLINKS 'symref transaction supports symlinks' '
+test_expect_success SYMLINKS,!MINGW 'symref transaction supports symlinks' '
 	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
 	git update-ref refs/heads/new @ &&
 	test_config core.prefersymlinkrefs true &&
-- 
gitgitgadget

