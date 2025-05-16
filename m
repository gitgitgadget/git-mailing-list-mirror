Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020EA1ACEDC
	for <git@vger.kernel.org>; Fri, 16 May 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407339; cv=none; b=N2Trsd6zcf5H4kiI+MbBKQGLXn0PNKMAgRK3TWUQo5KQA881rsJ4gQHskIUe2+KH25Z1i6yCOK88xg83slDSQLT9ncZQ8En4E1j6ep4gsTENLB6xLMj4yq42GISZtlzYy33xabf4dNTmAs82BHamIeeKV5NEvvkt5xhwa04E1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407339; c=relaxed/simple;
	bh=/WjnbKw+zp/V4XNczMDiXyHihs9r/zvQsTjxbN2ZIlA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bbsFUFCRnN8wrDO5F9udbDIR0LEAUlwLHXPYSb86OyiYEHJYSTLRi2gnVJ5t8SQAQhr9ZjoaMdKICMvBjD472HNGrBH4oPsVBpBIBvYM8Jj8iXZjavWoVffhcH5hzP9xhKv2FUHvdO2VnGKxZLIYP+XcFrl1v69bGCgnEoDcIRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klu1aEmb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klu1aEmb"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf257158fso16114405e9.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747407336; x=1748012136; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGk4rbkjpfFitpGFz8dXC7wE0mBSsI5Ww1RNsld/S1Y=;
        b=klu1aEmbOiTDrqD1ol9OoSAwrzYo1vQr+fgIe8W8TdM+QGvmq1s2vDD5A/pgdRhjD0
         vTaE3HHTzsQ+JHyX0s1EBKAhO1ybpJb5VkvAp/fiJCZ71S5nJxoRsg330cXatQPmkYFT
         /gItnQpbqiWcSyN+DciH848f4NQHa0BRfXHxvYhtdVC8UDXuRLx0NGX5k5p2jwZ6IUxL
         JofaKVLsCb5Qbk2pWK2liQR0ntAOyOP9FszElf3kWxVt6DMBPv2vep2GeYvPikbuB9pl
         ZnbSxEVxwqGAgxCf4Zr2dvre3fgRdPunI6hzmYzn/vGQjtLb4ajLHxH40ycTbuJNPMXX
         XeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747407336; x=1748012136;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGk4rbkjpfFitpGFz8dXC7wE0mBSsI5Ww1RNsld/S1Y=;
        b=DCnhnsx7S5N7/50BmNe6GoJPrqpo+bgrjDyyowjsvZSfI4QB+FXHrqo3O4npnUfv7U
         mrWyImjsxnjBaIWlodVXn5HlNRbIleX+JO0UtVKQpyr/QJz4tDLV+miO3WmuP53tlF7I
         0sCXJqK2XOLZWFZnVVrOs7mQHhrAECsPEG4LwcDU1xd4127dXAMwQbULxrd4kOul7c93
         k2FsgXsd3Q0904lPa/amaKJwlcoEJnKJpQmhY6UeWoiB5yJAtIO74gPh0uUOl57sHnx3
         MV8OJC0U3emxze33cgG9nUWf79bb3ahKo8SaXy7BxtgTb12mEVJNAxBTWmIO1mRKVn4k
         wC2w==
X-Gm-Message-State: AOJu0YyAEel4i45I89KmgYUAf54VHXNazzoRwivsG6hGHf8oekV94fsZ
	FVjWLa6nDWhCaLuhnXmYkFFxjeeNcB2a0c99ebEZqLprfNRBh0Nc84zuKLUpZw==
X-Gm-Gg: ASbGncsoPG2if/NWFJqRsqFrXfXOopDaASrOpliRd65KIBU2sW9x78EuEbieDC1YxKp
	AxYNLotaikrXuVxjtQZh3tHkjUUNcIUaqbz4uEdRjK9ZkU47iNQIqmNrtlmMaKnFMDOGjS01hlz
	y0Mwkm4+Lcwk9hD0cHpQUET+Ym6IsuGgfFTPvBqpzusTewvrrjq24D74sk3K35LfoslIPrcHorL
	MU6Hm9THefuLrQBUKTCviLnUis6+gB3wHYiVCMFqvhRbHH2TtPe/0L9IA+QO9Xs1eg3m1UCiGyA
	3AXejLW+e5JFK5y+YCf4s4o61um451vFrskdnHBHvAKkNIBizgeLHMIzxqxfeR8=
X-Google-Smtp-Source: AGHT+IFkZFEvUa7vSER1sQbPf7SIZoRaCuayyptvwTxJOEMb/I0nWJ4hwDvfM9qGCJ3X8kc2Sl8BrA==
X-Received: by 2002:a05:600c:3d8e:b0:43c:eeee:b706 with SMTP id 5b1f17b1804b1-442ff032801mr32198385e9.24.1747407335752;
        Fri, 16 May 2025 07:55:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6210asm3092965f8f.41.2025.05.16.07.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:55:35 -0700 (PDT)
Message-Id: <a50c57f7628cf99e22b6f3888f50162bab75a2ce.1747407330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
	<pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 14:55:30 +0000
Subject: [PATCH v2 4/4] p2000: add performance test for patch-mode commands
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous three changes contributed performance improvements to 'git
apply', 'git add -p', and 'git reset -p' when using a sparse index. The
improvement to 'git apply' also improved 'git checkout -p'. Add
performance tests to demonstrate this (and to help validate that
performance remains good in the future).

In the truncated test output below, we see that the full checkout
performance changes within noise expectations, but the sparse index
cases improve 33% and then 96% for 'git add -p' and 41% and then 95% for
'git reset -p'. 'git checkout -p' improves immediatley by 91% because it
does not need any change to its builtin.

  Test                                    HEAD~4  HEAD~3       HEAD~2       HEAD~1
  -------------------------------------------------------------------------------------
  2000.118: ... git add -p (full-v3)        0.79  0.79  +0.0%  0.82  +3.8%  0.82  +3.8%
  2000.119: ... git add -p (full-v4)        0.74  0.76  +2.7%  0.74  +0.0%  0.76  +2.7%
  2000.120: ... git add -p (sparse-v3)      1.94  1.28 -34.0%  0.07 -96.4%  0.07 -96.4%
  2000.121: ... git add -p (sparse-v4)      1.93  1.28 -33.7%  0.06 -96.9%  0.06 -96.9%
  2000.122: ... git checkout -p (full-v3)   1.18  1.18  +0.0%  1.18  +0.0%  1.19  +0.8%
  2000.123: ... git checkout -p (full-v4)   1.10  1.12  +1.8%  1.11  +0.9%  1.11  +0.9%
  2000.124: ... git checkout -p (sparse-v3) 1.31  0.11 -91.6%  0.11 -91.6%  0.11 -91.6%
  2000.125: ... git checkout -p (sparse-v4) 1.29  0.11 -91.5%  0.11 -91.5%  0.11 -91.5%
  2000.126: ... git reset -p (full-v3)      0.81  0.80  -1.2%  0.83  +2.5%  0.83  +2.5%
  2000.127: ... git reset -p (full-v4)      0.78  0.77  -1.3%  0.77  -1.3%  0.78  +0.0%
  2000.128: ... git reset -p (sparse-v3)    1.58  0.92 -41.8%  0.91 -42.4%  0.07 -95.6%
  2000.129: ... git reset -p (sparse-v4)    1.58  0.92 -41.8%  0.92 -41.8%  0.07 -95.6%

It is worth noting that if our test was more involved and had multiple
hunks to evaluate, then the time spent in 'git apply' would dominate due
to multiple index loads and writes. As it stands, we need the sparse
index improvement in 'git add -p' itself to confirm this performance
improvement.

Since the change for 'git add -i' is identical, we avoid a second test
case for that similar operation.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p2000-sparse-operations.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 39e92b084143..aadf22bc2f0b 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -135,5 +135,8 @@ test_perf_on_all git diff-tree HEAD
 test_perf_on_all git diff-tree HEAD -- $SPARSE_CONE/a
 test_perf_on_all "git worktree add ../temp && git worktree remove ../temp"
 test_perf_on_all git check-attr -a -- $SPARSE_CONE/a
+test_perf_on_all 'echo >>a && test_write_lines y | git add -p'
+test_perf_on_all 'test_write_lines y y y | git checkout --patch -'
+test_perf_on_all 'echo >>a && git add a && test_write_lines y | git reset --patch'
 
 test_done
-- 
gitgitgadget
