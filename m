Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE04D231836
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122178; cv=none; b=syWL4qKlZYneZNgwJCBUcJJMYtIwOXlvqH/xkrijaNrBixuu5DAs6eEBsJiHd2zhr1BOQCayiUbZFIivDtmXUuNt2PY8HqmB4M2dHk/JDVVO7bn7fo5kEFsYRytrPlC1o6NwNZRBMuEXPHNyvjl2MhE8OCr0jJ/Yufde+T2OYvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122178; c=relaxed/simple;
	bh=Wcb5yLcZvtItjGieEBbiZ8cxFj9UE3ucK9W2Ke0XXhU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=cMxqErq2RhbUr0OAUAFqDRq8JrM3sNkLx4+Ay5DGWtw6a7LxwrykMrSskq91dLMEHxH9mYW/e58Y0f/iLuzV33962jDBpXusr+UNc4wNnrnw5zlaonTenaia90dw6jfWRB28IQ1Tgy5oeeWinqaPH9aEVVaubBpI7LcF4z2gT2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hru3Smmn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hru3Smmn"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-782e93932ffso5721876b3a.3
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761122175; x=1761726975; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FTqig+FmJekMWNO94FEQh7K9Ds7k1RSaPvbdO8DQZ/Q=;
        b=Hru3Smmn2sv7CoIvZO4y2LrlMD3v5sWxelVuV7zXNDrOTwn8uzLDFxmZNT6i3AyWXc
         +IWew/SfF6dd+62qDtw2JzESlgMMvdNg+srw6V53TQcSjkXbwCzcn1eqSrSnw5/SR1GN
         tljl5g3FGGoidkdO1nM2Uf2EZ5nYNvtWBn+Th8qSqgfS/jIrIrFAs0zd+dEDxtJi5Qc1
         PgE00D3CefvFaxv4IMCmfJv5J/j1/eAAm9miA6A6DXLaKR77CKlln3dEaRJFhXmd7B1f
         0Y/50sgd4XT+U0dELXT+EN8uEc1SbBtVad6H8bn+imZE+oxUVn/pf1VbUArg/bEOXVFm
         ZExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122175; x=1761726975;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTqig+FmJekMWNO94FEQh7K9Ds7k1RSaPvbdO8DQZ/Q=;
        b=tqH16azod/xHmnz02W7wUxJ5yG8agZUj6ObJ+CnooGqVa24lwYf8n6rfbouN7pCksB
         WUw5sJDZITHki/IE9HaxjoyemMtGtSawL/GbD01Waokj2x2fPzg/url4tlizI4KaXJKU
         R2ZwL/bl/51vbMsuERLshYNRv1WIb1yNQ1iz8HiSeVbji9F9/NnAt17nlQAWRzGyElee
         1CJxhHd3xlkf3fStlL7p3w3KygrJ2Va24/rVZ7C6x6RH9AHOKmmpDjn9A5Vo3v/iwOGE
         Vei/B7TYgSsA9oBHBEu64YIbd3qWaOEWckMf8Kqmz5ia7TRVE2tMwXTJRGCsokIb2dnB
         rp3w==
X-Gm-Message-State: AOJu0YzskPOmhIWEu9fbSZDhsCGxgaXAEvaek112BYvY90Y5veEn/7HP
	XncGPD/GksOQFUdOx0qplwHUbZEErXzTvu6qxj+asxdlk/HdKxlpqLHkiZeDzQ==
X-Gm-Gg: ASbGncuBj1Q991JfjpxyuvQLvz0L/9g3IIfmtDYnWwjkLTjHjtBBEZu1yFFGit/MwAd
	vXoKR+QhTjntftNBBoaWlRB5bmtbiGNV/yRosPod4ZfjUq18BYbXhyn6+gAGTbw7vIK0o9TIyZK
	sVCnmInF2DeQBvev6wEyqrmksY69zu7TZWBRvrn/5nYpMebR+M0nj582+27Y0pQFn2t1SGk7GwX
	FL+lN/XTptC66pbmaOs+znf7ptsCNCEU8kZFBruZGotwz8eRn0CW3H712yqL1DXrHBR/70doiL/
	x6qHbInNto4Sa/nK1x7DGKuu09A/U97nLwfot0r3XlJQMclN3ibKtrQ1lPhrrvZGFgHOhL/+V5F
	frdG19HZw5HG+KrrUa45nppdJxFWcEufgutVITqB6BNzMaNuUfHq6xDAxQ1Uk2hWjFFjfmYXLUO
	Zz0fy9
X-Google-Smtp-Source: AGHT+IH1IcCFCJUsiNCyxuoK113RKCZhMAY9QG2nqp4yRHM9Q5P0gkrqHu3GZOfkrcIQWusE3qwCYQ==
X-Received: by 2002:a17:90a:ec8b:b0:32e:a10b:ce48 with SMTP id 98e67ed59e1d1-33bcf86c996mr29071698a91.12.1761122174680;
        Wed, 22 Oct 2025 01:36:14 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.208.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7669392csm12129461a12.18.2025.10.22.01.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:36:14 -0700 (PDT)
Message-Id: <pull.2078.git.git.1761122173126.gitgitgadget@gmail.com>
From: "Ruoyu Zhong via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Oct 2025 08:36:13 +0000
Subject: [PATCH] bisect: fix handling of `help` and invalid subcommands
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
Cc: Ruoyu Zhong <zhongruoyu@outlook.com>,
    Ruoyu Zhong <zhongruoyu@outlook.com>

From: Ruoyu Zhong <zhongruoyu@outlook.com>

As documented in git-bisect(1), `git bisect help` should display usage
information. However, since the migration of `git bisect` to a full
builtin command in 73fce29427 (Turn `git bisect` into a full built-in,
2022-11-10), this behavior was broken. Running `git bisect help` would,
instead of showing usage, either fail silently if already in a bisect
session, or otherwise trigger an interactive autostart prompt asking "Do
you want me to do it for you [Y/n]?".

Similarly, since df63421be9 (bisect--helper: handle states directly,
2022-11-10), running invalid subcommands like `git bisect foobar` also
led to the same behavior.

This occurred because `help` and other unrecognized subcommands were
being unconditionally passed to `bisect_state`, which then called
`bisect_autostart`, triggering the interactive prompt.

Fix this by:
1. Adding explicit handling for the `help` subcommand to show usage;
2. Validating that unrecognized commands are actually valid state
   commands before calling `bisect_state`;
3. Showing an error with usage for truly invalid commands.

This ensures that `git bisect help` displays the usage as documented,
and invalid commands fail cleanly without entering interactive mode.
Alternate terms are still handled correctly through
`check_and_set_terms`.

Signed-off-by: Ruoyu Zhong <zhongruoyu@outlook.com>
---
    bisect: fix handling of help and invalid subcommands

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2078%2FZhongRuoyu%2Fgit-bisect-subcommands-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2078/ZhongRuoyu/git-bisect-subcommands-v1
Pull-Request: https://github.com/git/git/pull/2078

 builtin/bisect.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 8b8d870cd1..993caf545d 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1453,9 +1453,13 @@ int cmd_bisect(int argc,
 		if (!argc)
 			usage_msg_opt(_("need a command"), git_bisect_usage, options);
 
+		if (!strcmp(argv[0], "help"))
+			usage_with_options(git_bisect_usage, options);
+
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-		if (check_and_set_terms(&terms, argv[0]))
+		if (check_and_set_terms(&terms, argv[0]) ||
+		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
 			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
 				       options, argv[0]);
 		res = bisect_state(&terms, argc, argv);

base-commit: 81f86aacc4eb74cdb9c2c8082d36d2070c666045
-- 
gitgitgadget
