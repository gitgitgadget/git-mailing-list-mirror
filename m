Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD02989B3
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313150; cv=none; b=Keg28frCmnbdaBnme3XArVmuzlTWcriVgnpW7/8lTOujld4BKzEtiRlnYCbsHEKeJotBEZKaDW8wvvNlI27rUG0/lD7j3EgjyxW9X2EeVN8eq0N2zyUWv5/i3M7TjulHBkdCxHDznON1ssA6Mbew2fESB13i7SFbwlP7HvLIgb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313150; c=relaxed/simple;
	bh=Eu+Q8Epwhhu2aYkA0YLaW/DNhqVA93RZIfNgvtsHf/4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oueXaAhYQNPWTIjUHvup2Y+mA0WzKpp2fLorQOXok20QeecSYrh6tlEQY/vOgY971HSdSyFdwmEUYU+wJXLnV7j2gfGpLtRGqColxrGl8xN5Y8KsXKvv46+oWV8+aNMf6+MlXT+w7/p/TzLhPUobJXJGPDmxY9T2Hs/6qM3Lv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwuRM03D; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwuRM03D"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so9780075e9.3
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313147; x=1747917947; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFgrUFb3ZBtOfvW5/CuWghn3nTrlDNSNCaOyHQM/XVM=;
        b=VwuRM03DHQ4Y2dqMvAjYHnqTmpI1rs2iTMDMU16WaUGcf+kuvfiw7/XazgbWYOoGWj
         iCX5IGsWmcg50mp67OQbL7a0Ju5YG0u2oIuPkBxVqdFvsFG801Wa7PHQeG0Q97TZgvSW
         jj5+DfujYlxXOgpFmWyFEUwBrDQqEUhWPIQVYIjB6KM5i+tVxvzs7iSvURw04LZTHUvu
         0TV5opeqOO6D+I9L242xXuafAaoVjUm/DhgUnBGVAJ8Pc9mUB/uOC3mtx5KQRa53MGS4
         mU6ULKo+s0u/+AAmZ+1QXlbjFCrRZZ1oM3js8hcCDTGYjt7KA6EKP/WuWeGVW5OnLiqB
         Cpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313147; x=1747917947;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFgrUFb3ZBtOfvW5/CuWghn3nTrlDNSNCaOyHQM/XVM=;
        b=LfVoj2dOFJMeH04JpmhFn+UOzmiHmVPsG1bNmd4ekSzssIwFEYVl4AE60ebjNkEuYg
         mv6RGrLyHfUUKT4baIsrX8Lfr5nXw4NZBYL3SuxZshNwxWI+h4pC96Me8J0/EcExOPBz
         G+e2QZqWNfz4lCDd/3gqqi3cVMBeCRp68STW0T4gl7BmKfgJLtSJd5oDVUUD/VQ+7dPn
         U/RjfhdqTWCy9zyAPUYcwfgYDtWo9dQ1rpQcvOlRdniLoZ5LiycJwkuJoSwV9qef+fM+
         oFWsia5m7916cr8Jncv2a8U+g0mME+E1gpffZtVrsEQT2ZrgKzsMGPYLfi+8iCuSpN8e
         W7fQ==
X-Gm-Message-State: AOJu0YyCNpxz/Lo7kXHXe8DXBD9lihTEi1MruQOq1CVcbuOgkAk4GzFP
	KwibM4wT7REzsrOiG0b50KvVsSG6fNR95KVPABJaZa3k/Cvt4/xhJr9PIQ==
X-Gm-Gg: ASbGnctYfD9oT3EfP5mDQ3gyvGUvPoCs6IVHHY8YVJxBzX1BD2Y9mKgTrEDoigHQgwV
	1VutaYjhaPX8J0peDmicqvCTTRXktZnXEKdCUtJoRv57jQcfnEFFqD8t9HdF0siLXNJIdjo3gKz
	TVMaHmS6e0z3tIUDIYcoRm4dyO1JBs9pQ5nMLE9zyIoNVxj9UJo8th7ZLupFzpzBCGEVGAp0hHq
	HJfQeRQ4C63mGZV/MwPgE9BIZ94bfyC4K65yxOQhpvuGrBxNdgTMvl42olFNBWAmp7MuGUFPmnN
	kGh4LN6aNxTOaxVvy4AnamybOfSI+N9Kps5Nd+LxHO5R1IhDFnoX
X-Google-Smtp-Source: AGHT+IFWOOngGMvKegxvPAb4hrTqhbhfppaNZ3OF/NQpkKya+PK+tuMInp2UemjjSzJmuHPbTk9Tdw==
X-Received: by 2002:a05:600c:c87:b0:43c:e7ae:4bc9 with SMTP id 5b1f17b1804b1-442f96e48d6mr17901345e9.1.1747313146578;
        Thu, 15 May 2025 05:45:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e852fsm72052795e9.27.2025.05.15.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:46 -0700 (PDT)
Message-Id: <130251bc324cc90ab19f82552888071f974c35b6.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:31 +0000
Subject: [PATCH 06/14] stash: defensive programming
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

CodeQL points out that `parse_tree_indirect()` can return NULL values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index dbaa999cf171..23c4bbd3e21e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -285,7 +285,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	memset(&opts, 0, sizeof(opts));
 
 	tree = parse_tree_indirect(i_tree);
-	if (parse_tree(tree))
+	if (!tree || parse_tree(tree))
 		return -1;
 
 	init_tree_desc(t, &tree->object.oid, tree->buffer, tree->size);
-- 
gitgitgadget

