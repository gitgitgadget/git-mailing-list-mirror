Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88C2F0670
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029256; cv=none; b=m7qCXGFtsJfx9SwGCTJJf2mEM94MbM+v0h8BH4Z0O8MDwEKzv5LVs/SxO3rUATG1K4s0x6a342GS0OuSQxDMgFER6iSrNx/Q0UdIOC1tFMxyJnJik8SsuXV3Jfr1Tl09rBiY1Qnxb8/1/gsYm6EAjUNLx+pAGiIbQqB8s6mMX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029256; c=relaxed/simple;
	bh=r1G/glWMI+BuYrTzJCpYz08HU3USZ374DshuBfVwShY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=chqLsp8CF/2k7LgBUpSev+voZLLkYZZiQQuRygwd0ZBgm2kMqo3++MEcxHCpmKdYB5/hhYlPDE8vRNe0MLEH29a7q1Ws1FjrzXHElYV8MujHZb4LyxUnSNJwXvNM33mQkF3c8GrnPRb6VkbPI/PdNWhT0eLiWbymyuN4ciFf7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiI5Qwum; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiI5Qwum"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b7892609a5so3509408f8f.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755029253; x=1755634053; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORK6OzOPn0khU/G6bIg21pYbQ9GiV06U/h/5A7CaVXk=;
        b=BiI5QwumYWt3/F4MXl4ndQ78vIa6WXWzQL6KyKg+6kxBhTbsIscGTVRoebTlXELE5C
         C2a66bzya+pJLsmPzqbmbhsK63NiSwJkv/BjbfPHLo7aAsCgWA6GQYey+6sdOigjBfpH
         I20mDyV8yt5jku3f1xa4kYH3TGcwWq2X2ZviP7MF6zMItrXiyrgzkrZtQrY01V9g7Ax5
         7hejDxnbvr/5dpUchgEhqkILjaXLjwQi17eaG5JPiHPxpjXV+VDpnpi3J4+Jd4HEFG8s
         quwnggcFOQ5aehki2nRFZ04sEYj9jNfQBbW8UjkDJfYxq0pfcLpm9LDXytlvuqPv6mlb
         PSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755029253; x=1755634053;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORK6OzOPn0khU/G6bIg21pYbQ9GiV06U/h/5A7CaVXk=;
        b=fu4aP4mXWOlDChmwA/xlQ7BtdwuU0wjXOZBwWagX4H1yMLP+zkDCEtQMqXFTxu2OaQ
         hKTWiLIbgHulSAgdFGM8ektGRL0gP5wLsIXykGEeTlhgxP+VwZ/xjI8stg7IGHb9lEV0
         /YOHrTE7ZqybODNtbGf0ZMF180AMvbwqb6LxvKrhBUWuVnDndkwJSWBI/a142FDkzHSX
         TV4aj4RrxZTscy2z3aLtvSUUwVqcYjI1WhbccT9GMoJIS5PY5jcTGBPzvTOERWrzJ/Vn
         wynim/BB9DUoXIjgNM4pYoR52nqcT41IR2ANV/goneomdCvL8FnbOJeMGiFrGg5QrF9n
         NLcA==
X-Gm-Message-State: AOJu0YwR1LrTTco5PFo4+trchPnmO7/pamRj5Izcm9EY6wlRz/44r2cw
	1FUxfTW/znFJPdorshWkCjGnBQKsS1H8FG2y6ix/LTxeqF9EvFpAwW+oLYtvIg==
X-Gm-Gg: ASbGncsvGNFSJaPzWHKEVDheDJQDBAbc8upuXoAhaTtXIPU85G3ibFMJFF3CICJmGyi
	C7I5/wDxqRwmP/wGiqxde+bbOUglHr8Dm7EJHUhNgINAvHxX8kUyuzJhkUHPial9RhgFwaBthoU
	yxvuYAKPDR+ndQT7uu0kQ1CrhWW86eaBxf25srDjH6Kgod5nkWFpl4HNjM2TDiu3g/qGSvDC3/W
	GusPwCN1DQCT83iCRcDIhQ02DLxbm21GxpIv/nVD8dSG2xR4Dly9WdFqx+WwBM0An/Ke1xL3gNM
	mS8OvVsfW2PNEI/8hXNO+xLTm1Yq4nrq2Kvd4omRQ5Ro1i1bDeA2egmEhBddg240vJXgM/0DYCN
	MVbaQrGKalb5PnesYBzeXa4A=
X-Google-Smtp-Source: AGHT+IEcymNlJYVxFMmpDF5elyxSj7sovNZovldVmJ6flhenAtwPiDR4lcwK7MgJstKoDkK6hhl1Fw==
X-Received: by 2002:a05:6000:2909:b0:3b8:d893:5230 with SMTP id ffacd0b85a97d-3b917eb573fmr203930f8f.47.1755029252786;
        Tue, 12 Aug 2025 13:07:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16dcbd55sm446935e9.2.2025.08.12.13.07.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:07:32 -0700 (PDT)
Message-Id: <3f4ab6150692418757c84db64cf6d3d79a654453.1755029249.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 20:07:27 +0000
Subject: [PATCH 3/5] doc: git-add: simplify discussion of ignored files
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Mention the --force option earlier
- Remove the explanation of shell globbing vs git's internal glob
  system, it's a common gotcha but I don't think this is an appropriate
  place to explain that concept. There's some discussion of the gotchas
  around globbing and `git add` in the EXAMPLES section which I think
  is clearer.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 99ca2d0f7e21..0c4ca1794c91 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -34,12 +34,11 @@ you must run `git add` again to add the new content to the index.
 The `git status` command can be used to obtain a summary of which
 files have changes that are staged for the next commit.
 
-The `git add` command will not add ignored files by default.  If any
-ignored files were explicitly specified on the command line, `git add`
-will fail with a list of ignored files.  Ignored files reached by
-directory recursion or filename globbing performed by Git (quote your
-globs before the shell) will be silently ignored.  The `git add` command can
-be used to add ignored files with the `-f` (force) option.
+`git add` will not add ignored files by default. You can use the
+`--force` option to add ignored files. If you explicitly specify the
+exact filename of an ignored file (e.g. `git add ignored.txt`), `git
+add` will fail with a list of ignored files. Otherwise it will silently
+ignore the file.
 
 OPTIONS
 -------
-- 
gitgitgadget

