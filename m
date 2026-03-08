Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0A348866
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772993052; cv=none; b=CQ+NDZztCoXvx7YtL8NskMQ1VGySqtAZW9PPK1v06+t2ElFGoCCuYy+YjlFZ1S+Y/cOX3zBiLHEdvT/vupqVTaSDHmbuPwy6MJXqYBiv5ByGdEnerrEqtSgLgvoZ1xyYKcV0nBmyh/yOyGTfBhmmk2hDiC7cksdcpmcGOBBqozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772993052; c=relaxed/simple;
	bh=ckT0VpyngUFbyEtCknaTIUfpUdqaeNof0+wHN5/XAvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XqBQGPSBornqOrKrD0XHiyt17FbwkGjoY97267zoFvmURhg5V8TcMx+RXwZqpGDDlmju3Kb/g47Ja3hT3EZ+/S+ZKPUw/3/I4FMFB3ezE0QBm8zXylgwfqHq7127IckFWGnyIOncgJPG65BmKT2zHCOrdYU/XRY4H8lo00K606U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsOPegyt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsOPegyt"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82987437624so1705088b3a.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772993050; x=1773597850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GEqYip57QS9Sezg0Y2TEzadwCADC1JPw8MlB1Qkth+I=;
        b=nsOPegytrXGnXWC+wx8pvmcoLQKa5f892iBt/rG7tLHujyl1w81MshtB93OWxB7ksl
         75ctzGmYgauA/ossBAt5k8cExDXxaTqZEma0G5e9n/i1QJ6oa4S+uR8OtHmaHVrz5Lm1
         M7UQH0Pjo3h3KBwXhQl2locREGTBr68ob1PpUYcLlR75D4JzGcH46idM9CN1Raq+q4d4
         PEjVT25YxOZ0WX/MXNIKRrrhcsTl0iiZ/ytigBHVEs5P8oYH+eLEKhchfYvevqU1UZQ9
         8EDolQdJa9famUvBjeCvseyvtRmWbCJTnazBq3YedbOrJmDSdGog85/SOTLuZGtEpBO2
         fJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772993050; x=1773597850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEqYip57QS9Sezg0Y2TEzadwCADC1JPw8MlB1Qkth+I=;
        b=RLE5jG69by2stXdo9zftSjRwOoJjb2VGD12R+UrVeVEL8dmDb6+X+DKOz+R4MjAZF5
         CIeSLCbq977jxcaitYCslFIV8H9Wj9Yt4hWUTZRb9O+KXVr6ciJEueyt7bLUfFsB+ZzI
         HzJnfgam4QxaaO9KZzeddqpKZ9CQj1lHeSQVtiYaVspxDYZ4OwrmJzGlhyedvFDRVmfL
         2fCfY0QxtZpeQY9hMwU3WycTCBu42Houm/3oTv2x8mJ2/nUsK6wav2dSrHGjOrISj2iw
         NZzRB/VUaivl/i5d7yav49ycf6Wl7PdoML8n933dUNM6bcHCEB1lTPz6cnWNJm8+jmhN
         l5dA==
X-Gm-Message-State: AOJu0YybNectkASr2gFboKWcQPEb9l2Wq5eTVx5hiSd8QhoEQrGBed9Y
	1WLzcMYJpKaBeCHvc1Hk33bY5fhWOp/ttuzvWpTf5hgWyYX8KU1G7PmcvoJyOA==
X-Gm-Gg: ATEYQzwQwxTsTrDimjwfQDAEPla/okJt0JnnWrTbCsHTtQZiaK4lML1k9SnHDSinD7V
	qPV1MgT5BxE9aahltr9jnf1DwrPyJseCCh7KqhX6XqSPd+QxGBs9+/Ch3VPKzUHI3tviPWUvSP7
	J7UTXEihxs9VwHl1hPGorEb5UgHULlQ4p8V03SW3sS0xENUtWnJ63Y7IT4yiaHMXAZMD3N6+8XT
	O0mt61h1hwNmTrB04PxnCfYokegdHE92EnpA9HM/+fajSwlxZp09WNAkSo+CGWJVSshGvXXHEyd
	pRvzhJlQ22H3+c2/T4A7wl7v5VoLHoOAyrrTHWODbrI7zFmaVFbCdjM6N/yYhc1MQWzLwNw9Ztj
	N65hySXhyo1hcobtie+SFTUnHyKVHgbSkjGibz8qvUH629OABXqKuuQSfXWpfahRI1ob6CfXhTc
	fdHjgqYwjdwG9wyrw/AYkBox+s4dQEtvQ1g8/iPtjBpoUR
X-Received: by 2002:a05:6a00:ae10:b0:824:a466:7470 with SMTP id d2e1a72fcca58-8298583d0b9mr9195463b3a.17.1772993050282;
        Sun, 08 Mar 2026 11:04:10 -0700 (PDT)
Received: from d ([49.43.41.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636a92sm7835541b3a.1.2026.03.08.11.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:04:09 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v1 0/2] avoid unnecessary strbuf_split*() and strbuf-by-value usage
Date: Sun,  8 Mar 2026 18:03:57 +0000
Message-ID: <20260308180359.31188-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio's "do not overuse strbuf_split*()" series [1] calls out
remaining uses of strbuf_split*() as leftover bits for others to
continue. This series picks up two of them.

write_worktree_linking_files() takes two struct strbuf parameters by
value even though it only needs plain path strings. This is the same
class of problem fixed for builtin/clean.c in that series.

parse_combine_filter() in list-objects-filter-options.c uses
strbuf_split_str() to split a combine: filter spec at '+', then
mutates each non-final piece to strip the trailing delimiter. An
array of strbufs is unnecessary; the function processes one sub-spec
at a time and does not use strbuf editing on the pieces.

[1]: https://lore.kernel.org/git/20250731225433.4028872-1-gitster@pobox.com/

Deveshi Dwivedi (2):
  worktree: do not pass strbuf by value
  list-objects-filter-options: avoid strbuf_split_str()

 builtin/worktree.c            |  2 +-
 list-objects-filter-options.c | 40 +++++++++++++++++------------------
 worktree.c                    | 22 +++++++++----------
 worktree.h                    |  2 +-
 4 files changed, 33 insertions(+), 33 deletions(-)

-- 
2.52.0.230.gd8af7cadaa

