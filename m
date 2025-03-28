Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09B1D89EF
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181674; cv=none; b=CtbTWur74MQr3NzrwInyAF8oWFC0hn0r31y8YdnsAjIx4nL6CZex7F/8BE1xN8t3xesxMUjm4r4y4FJlnOHfKN3xnuLXYShW20leVX6QTGQSCGYv7rREnp5dPtfWmWjPxiOksxP1XFWQHr8XIGb1kY53m8NmF+bqifJ7Vl2/je8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181674; c=relaxed/simple;
	bh=RHB9W+OBm/a6Bc09NshRP2LpbkkQvO/PLCdeQ0c2nvg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JU3U84JbysHm9qMGL9cy2j/XJ7B4b5OrxkcIAP8tNP154WYnKECp74Zp4Cd9YHhmjmtNLPvWIp6vboJU0ekER6zmBhxBDQtDgsNg13L5WfB3MCnlGnnIRBhjCMbSYYz24v/m20yqjYghMf8GVG6w0xMhmnbiaoDgUc/e3zP9WlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tkl+cklR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tkl+cklR"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ac9aea656so1999835f8f.3
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181671; x=1743786471; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DXJlBHlbZu805VY22uoVzm9WqN5aOjrwOyuSCNCt570=;
        b=Tkl+cklRbOiXrz2oMlS15T6V6JM/VUT1K6461hYr2ay7Sjd3/9b/f1REFl8VwxHV5w
         gxwtFoegD8FV4RKKLQqG64QGjx34TtvNl9R5EOF9vCwmGbdMd/syQs8cxN/q+DzmtR5A
         TDcKNrjthHnbeEJtOxxl4fKP+WZKA2rFJ5fMG2daFI1PtlPLmNZQCroFIXo6S2wY2a7z
         3JM/qTPP4nxT5XCAg6pBi1lDNsDcipt85+bm9ZMZt1oVJJ03l881TbUA+t7Xz3wnadUS
         6u4CsKM48Bg/2S09r0MShpIxCqCwPG4/ExkXVPckgsqhHfZp9DbBc3upwDAQghfib7zG
         i1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181671; x=1743786471;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXJlBHlbZu805VY22uoVzm9WqN5aOjrwOyuSCNCt570=;
        b=gN6gsvaZ4S3ADzFDEd9Zio/qjKCrrnXvg4P5y+V4uzIbM629UzIx6yafgWNn9mhUTl
         tzMpksq8c8tfRoutAxqk7D7MG9kmkdly2hP71bXYpZZxyARJ9oKlDLaE0N3xZ6Ns/C6z
         MMekc5fXe0fnXJ4WG3uLezkJAJV3uD5juRAmPk5AZkwpD76Iv+QQxAy6o2F3tT2M9sgB
         /FhL1zl2HAqoYMhKYDpoPYUyZy8QeYa9gmewtjAKQf2rsvzmYQHSL2ak/ftyEqj+bA/m
         ppaPUyVyEyZpc94Cs92F/ivqQmJ8jytetTVPA0Q23u8FGBGg89bqF0xW06/U7vFgCw92
         duRA==
X-Gm-Message-State: AOJu0Yy+gdAg5yr7FyBLuf9PEYzPeONPBsCqs8lBiIXsPO9rqZuHJ+LH
	bSVm5LsrWoMO40f6p3VF8wt1o+S2oZKSUeOrszZsMorSWILr4FQc8lmzrA==
X-Gm-Gg: ASbGnctu3L550tticxk09cmHEi/sKvR/FUkgT2P5CnHjs/2OudL9umXTOZoymeqIf0p
	vopnpTQm1T4inTZzeCdXbGM+CZMemsF7zMBIfZH7KB2YJ0/mrozJJ5MsvIoSTGgPYLwjcms2R1v
	Q0s49rppucQCRO8/7Byf95cwuoTnKQtBuR9dujijUIY1foFicTK6Q1HQriCy5I0cGoZxBIklA/M
	avCwy6cp/0w846HhKOxCujSkESEE4WzbjycbCZGjl5zuxb01MKQ9bhmUjDNjQYeg6bk0Q2gBisu
	ndQME51VCqar23SJ0LzIsb8c7656ojMl+ZzPGG3dNPKlGg==
X-Google-Smtp-Source: AGHT+IHJ9LEk3zxYzb+3nMwMQN7e7yWKfWbwsljdyxgY3bYT3mEZnwjcVI5qkOTBNFqkH33j5NHlvg==
X-Received: by 2002:a5d:5f83:0:b0:390:f745:bbfb with SMTP id ffacd0b85a97d-39ad1760792mr7750868f8f.26.1743181670458;
        Fri, 28 Mar 2025 10:07:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6589e4sm3219502f8f.10.2025.03.28.10.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:07:50 -0700 (PDT)
Message-Id: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Mar 2025 17:07:47 +0000
Subject: [PATCH 0/2] Two perf test fixes
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
Cc: Victoria Dye <vdye@github.com>,
    Neeraj Singh <neerajsi@microsoft.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

Here a two fixes for failures I noticed while running the perf tests.

Philippe Blain (2):
  p7821: fix test_perf invocation for prereqs
  p9210: fix 'scalar clone' when running from a detached HEAD

 t/perf/p7821-grep-engines-fixed.sh | 4 ++--
 t/perf/p9210-scalar.sh             | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1936%2Fphil-blain%2Fperf-test-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1936/phil-blain/perf-test-fixes-v1
Pull-Request: https://github.com/git/git/pull/1936
-- 
gitgitgadget
