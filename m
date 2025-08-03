Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD097E792
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256322; cv=none; b=onbwjE7U5QzMK1ix3l9qPy71loErMvQ8XOcAu0uMV7io3geLfpYzGfCeYVkurIXiL4Kp9/EbSPLmk4N7m/fPqHFAsVe6njiANQiPdj1gqAx9tpFWXLzc9P26h++RnRMmTIMtDwkktFpMsFozz/3xIT66YMuqKZjpsUWuJoAjHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256322; c=relaxed/simple;
	bh=j8/r46524Ur+blq4xd+N0su9CZohwWajVv0L+7QU+kY=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=Ku3E76r+QBXaeb4vlh8mShSQvzcH52ORo9clDTKOfxue4nHffn6YNviJn3M7sCHboakwF4+yR6QIXa7P5Sn+7a4Hr0c8bwv20ERdN6NFm7MDf1okBY/ErJgYz3jsj8eYmrMQqZ+nC2dO22Q19A0FDgL838ZNLOvzmr1ma/79DEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avJsFbMd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avJsFbMd"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af66d49daffso461125366b.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754256319; x=1754861119; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aFrkk+0JZqu0S3Z3L7GYTZNjp+DpAz3QEaaqNeL1fOE=;
        b=avJsFbMdzJERid0P0RPHAanWaXLrVf+ti+yqkDLIOi5oDluU+gFr5YKL8rfquVBC3P
         eNHubX2ZolNEoc2qo1Z1gPkeZCLspWkLWAucT2L/EhL8Jnu8FkuKMuMHuUR15NZagyNJ
         NhD8ZtzZxxZGo7o8xA7cR5k5vqs1L7qCGfqjgqE8+/du5jvJI26dO/+n5ANZdoLQn80p
         33L2oAuGuWYFdBiB7iejpTTeJRFNftoHSgxShF2278dy5yqzE5lHvzrfv8N/MpMJwBeu
         rELfrQHAlUaAnUOAPqf+yGNfFweRBLGyTgYoleYIk+pzyA6vifHaeEOC09VAiRjRXc7e
         gd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754256319; x=1754861119;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFrkk+0JZqu0S3Z3L7GYTZNjp+DpAz3QEaaqNeL1fOE=;
        b=IccljkLBe1RQvOW1KWWkfPGa+ZLNpJsLXrhIbXwuxrIhJ2ZMkm2OUN0N5Rm5EnECSM
         BMUKTGcBz5NtHriuPpEhz3uHgNhVOiy7pkz8QhNflqzq51cwTOdE3QFNQgZbRs7973JP
         EGq8NBTXCUmMpJ90MridMEoLCcN5brRpf3R5zTr+rZC8TDT/SakukHWJXBmFMZkz6+Tw
         rn4hXcpa9SRnDj1N9H0WYstgUNNnCQ0GqGsiT4j3hvDtNcqo0inLeMFvxg7S0PQ3PSCG
         ES3iRovo3I7WOZlLv6FoKIsAjA0Wh3/QTxFf8VtD6TK+kdTlJa/ta8P8PI5ugshaUtDd
         +Qbw==
X-Gm-Message-State: AOJu0YzYDJRAraZK3pqTkMNsq8a/z6OdBfjEjQba413KoNqAyswPDX4E
	Bgg8CYpeqMSzYP5FDvWT/9zlSJZXLkIEhl5QnEc/xcQxSi+3UMKmx3PRBdeGyQ==
X-Gm-Gg: ASbGncsjjqgFu/fKimzFgrw23KzjHqLfLwSDaVT6lwWjv70zdDsMIu7CLlJ47qnuHjU
	9xuPlCOe9v7tUeDyBfyXMxw9AkKaTYjyhl1upHIvw7fWa8pRQRGguDjMlQL4IbJVMwNBRw973vp
	CIIIn+Qvl9I9jNa1PiI5VXr3GjXFnQH6wSkRxvsNanYitX8/OYa1hkyfEJ/YojNUdfeYJaJODsg
	AXCs7EixBZcGoIoX0DhDYI2jWxysYOUH3DfcHIvuj+tzre3hXVGuGlg4dadqezRbgtW9lOIndMd
	LNBL29SV73gKTHNeI+qCr9nviuXX+dKbbrbl9JD0G6hlZYxcpswU1Kc8KBPnYXv3Haxluj+vUkg
	ECgeJ8GZEpty7jUVLfywP8AE=
X-Google-Smtp-Source: AGHT+IE5TvvcD5oiaYZqHCuZ84R+lwPLrd0DuVyUc7AKHpDmxgNLlhK6cHnuISP/MrZZcodEZDq9Lg==
X-Received: by 2002:a17:907:96ab:b0:ad8:a935:b908 with SMTP id a640c23a62f3a-af940180c31mr818759566b.30.1754256318939;
        Sun, 03 Aug 2025 14:25:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a07670bsm639580766b.8.2025.08.03.14.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 14:25:18 -0700 (PDT)
Message-Id: <pull.1948.git.1754256318.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Aug 2025 21:25:14 +0000
Subject: [PATCH 0/4] mingw: rename and open fixes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

The recent change of mingw_rename() to use POSIX semantics had quite a bit
of fall-out, breaking in pre-Windows 11 setups that use ReFS, and in a
different way on Windows Server 2016.

While at it, this patch series also upstreams two related patches that
matured in Git for Windows for long enough already.

Johannes Schindelin (3):
  mingw: drop Windows 7-specific work-around
  mingw_rename: support ReFS on Windows 2022
  mingw: support Windows Server 2016 again

Matthias Aßhauer (1):
  mingw_open_existing: handle directories better

 Documentation/config/core.adoc |  6 ---
 compat/mingw.c                 | 93 +++++++++-------------------------
 2 files changed, 23 insertions(+), 76 deletions(-)


base-commit: 866e6a391f466baeeb98bc585845ea638322c04b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1948%2Fdscho%2Fmingw-rename-and-open-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1948/dscho/mingw-rename-and-open-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1948
-- 
gitgitgadget
