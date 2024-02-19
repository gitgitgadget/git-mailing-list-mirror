Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9261CA98
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708317943; cv=none; b=IwPFkNlTDmp15QsMN1z7qKX0rZfkh5iOVM8vES7VjXANuaYKX6WvIeEW/Q2mt8CYNMVxvJettc5Sqy5cVEZAMQzc+JuOHsdRm0Eul0jZeb8gKpSF253YhMS1rkYP+D/9urz/+TxKePUB3ptQ86lonPdVvEGSrjV1vyMcV64ctSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708317943; c=relaxed/simple;
	bh=PdGZxgtpN44VEG2Ru2pXOAoEYgnaWzpzmYWCvQztwAc=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=upitahEm2GBgPmhI/2OPNiOrJ8AahmEfosR3Qw9EjTLzaoP+381ZGT1zseepoAs4U6Gaf5xNQauskm215O4Dw7y9KTveFzqKx1JiSxgjwyrJ4DW84pxlXYpaf2aOE5BaRSKAizRr1oO29xPgut7Hwz6K55rvWFOoXk9X0eyPD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZAsAYRB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZAsAYRB"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d4c11bd34so477258f8f.3
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 20:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708317939; x=1708922739; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=04AWro/l2GSoxnlpL3TgY0+7O4VEhtza7wOD/pSUzqA=;
        b=OZAsAYRBAE390+iUAjq9mgxFJOdTwyA0QAzdE9qa4AEJERYXNEZ8BQ0wUpUpfDhdcQ
         I6brHXZsXT0iz0XOI448okM812IoXxo6lszNAY75ZCGf6A+pH27PYfgp02OMHhInL+o4
         D2INb/LscSBJtFn/eHBLvsJ6YUxDVvUY3WHJo6MzfMdnFMavRFj691dbxw2wx4WIteYh
         eKw8gDSace/hg/sBOkbIap/dic0+K0yCgr9LO4X3GVCfbTD1fij79G4fJBwJkPRXbWOW
         e14x2Xd4xUx1rQqHVHpmA/zKlobTG0x665MxS7c4s+Coxe01RiqM5nh/9L3aSRgM5JmT
         u7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708317939; x=1708922739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04AWro/l2GSoxnlpL3TgY0+7O4VEhtza7wOD/pSUzqA=;
        b=sPj1KcgwhcZ9Fv2MvO0UuId8In+WO7J/077r6SINdrL7UY+rAd/FDFVQG63bv9tXpx
         BcyP3AvBJO1rtRfNaLXBavpJZz4mArWyhYvXqtnrGhvqXSBk65oJN277QEx+HLx80do4
         JD5MdV+eESPttSC1fCHL5gsLSZyWT67pTZSyueWR4X32NiGmTX0s+LfQY+z5RKRGXjlo
         4eynfxcut6jkML/p64RJt0kVqnIUTGjmCpTjsUjoxULgvFnZ+qfjwT2ZYHET9sV29ypC
         5c+nNGWD73hrHwoHQq51sKnmg0qR5G3bPZlZccJNpJVdMxTNXDj+ZXT+nsi5fBGXt0dH
         empA==
X-Gm-Message-State: AOJu0YyTJhAsTN6VEwoFJGQeVdF7tiJfwSa0RnYqLHu0BjP95dyXfjp4
	1gB9HCWR+6yGyqnRlC6lbGVSUVSNyHreOb1Ck12aOQraEO5DNuAtxEbu8nws
X-Google-Smtp-Source: AGHT+IHQ4Yu6fe44T/LzvHVqhDoz1svx086ky5R5qjYxcP8xyHj6CxJYAS6ZdThgS4KGSz2PwE8fug==
X-Received: by 2002:a5d:4b0c:0:b0:33d:1416:7149 with SMTP id v12-20020a5d4b0c000000b0033d14167149mr7878400wrq.66.1708317939598;
        Sun, 18 Feb 2024 20:45:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020adfe3c1000000b0033afc81fc00sm9068506wrm.41.2024.02.18.20.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 20:45:39 -0800 (PST)
Message-ID: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Feb 2024 04:45:36 +0000
Subject: [PATCH 0/2] apply: add unit tests for parse_range
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
Cc: Philip Peterson <philip.c.peterson@gmail.com>

Hello all,

This patchset adds unit tests for apply's parse_range function. Also renames
parse_range to parse_fragment_range.

It was necessary to make the function be non-internal linkage in order to
expose it to the unit testing framework. Because there is another function
in the codebase also called parse_range, I changed this one to a more
specific name as well: parse_fragment_range. There are also several test
cases added (both positive and negative) for the function.

Thank you for your help,

Philip

Philip Peterson (2):
  apply: add unit tests for parse_range and rename to
    parse_fragment_range
  apply: rewrite unit tests with structured cases

 Makefile               |   1 +
 apply.c                |   8 ++--
 apply.h                |   4 ++
 t/unit-tests/t-apply.c | 100 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100644 t/unit-tests/t-apply.c


base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1677%2Fphilip-peterson%2Fpeterson%2Funit-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1677/philip-peterson/peterson/unit-tests-v1
Pull-Request: https://github.com/git/git/pull/1677
-- 
gitgitgadget
