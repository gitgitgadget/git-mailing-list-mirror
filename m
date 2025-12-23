Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722E26AC3
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766534384; cv=none; b=JdVN7Yfu8wDx5J0OFQys4N2VCHQbsH6nD/Ttiu+zmZ2ITSCY9riQj1sBhXVAn4Z8zLWCA/Y2ghWclFh73DXWQV6SNxjrtJN43KTZRvdHkvDy50j9iDCfNISMLbI0QRG7EM4DXU+P/dmqkqc82lXP0YiTjrJbVCXWXK5ZZnV+tFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766534384; c=relaxed/simple;
	bh=e4C+57eZsleSqlhO9IncHYJ0ALHytLcdy687yvPGj30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oj4Nf2S9YJaux9oOhWyqjSuPul6ZqXrWl7xsG/fkpj4/7pmihLhZTCjhRJWX7RtsqKldoD8U1IPSGftHJ0NfetfY90viFEjjFq5+Y484W7P8Zcy1rFxDK1kCrLYXEkRVBanvRQXTXlsx0f22FgddBXbBBDiP4/efGAD0idYUiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBBlGLWs; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBBlGLWs"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37b8aa5adf9so33829491fa.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 15:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766534381; x=1767139181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4C+57eZsleSqlhO9IncHYJ0ALHytLcdy687yvPGj30=;
        b=UBBlGLWsq7vTk9ZzuVFFct6MsrvuR8FdPZkNN0gM/lTkUqyppAlyDYpIQVgj7LW8Dr
         KgbONmulMMZAaG3SxO6zzi6S5mVg/oliLVLCd1ZOTmrS65EXEWnTR/3g/dWn5OHtQ3uN
         jJNfcYp93JNNxT/k5jwYqjZPbYt51VfW6g4dxEN6v995ksC8UWJ0gbBAx20nKOH3xBqf
         w9eQlfRXwkoMoMa0KmRYthOBpyEBvVVxo0lD1tDeEoAP/kajs+y81+6ySB1vMxj7MYIk
         qp1xQdmmq+SsTOFBPnGf4I4S3VPXOTn/Rfl09CihjGQS2mVSxWyXJrO2i5Yt1hscvUWI
         J67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766534381; x=1767139181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4C+57eZsleSqlhO9IncHYJ0ALHytLcdy687yvPGj30=;
        b=wcJZqwNgEa7ubYdAOrRd+SIjIZs9NxDUAtxuSJuFeu1C91bOqtOc/Jx2CSPtpBysBy
         Wycc7VaMbUd4l9Ncw/tFJtdEXJY1zJvvvS9LVNo2T3bmcnisIbjZbj5QMLs+bj1wVeCw
         9/zRWoQc3Vtkc8cj93fMfmuoylqlc2tO4qXqPStCP6ziLLtDYkwVeUuXrQqd6PLOEsnm
         iQJkN8Lb1JYmr2KF5NtOmxmDH+fbQ2Hz9ITpN/Z6enVsw3LknRpa7WNjvKIpbJkzADBv
         E6WRZhcNUcs1+aMhydjQLRatUhecQp7ySc551IiVMU1/RBtf3FVH+Xd/3WAJzWahyVVU
         wtDQ==
X-Gm-Message-State: AOJu0Yz3KeWQur1LV8pnsKmgmOSezbZZlcrufLll+dSkxzYKFiG9/2k7
	jeGdbRJUoIpfMdGSLa/j+4oawGtZbLfj6HIpGLadXBojUQ1RPhiqYk3pdfaxeg==
X-Gm-Gg: AY/fxX6rQ61wsx3f+4L7bfyaLM9BFWPOwYUkH7+p0KyZQ8VdTSRj3canYOKyHwVBI5I
	jvkSYJfw0M7qTqs/W+2w5zj6KN7rd5GtbIV/kqg90fr9byYr5ODeZDyD9jCWi1gYDeHje89ss/5
	aL4NhtyY5laCA9OSVtoeGGCWqbuH2zIbMd1Rdibf7TJBECIDyAbN7Je88ebWhgJg99NBlf9JFZ+
	1KdEA2oiY8gxN02Fuzb76HKsOOMNJ49Q9p7JSq9ypj6GLHyPZz27hTM9CoqLkRwrtjD24/sPn4K
	RC67hpNHrQoRYDyBzrPlEXOF81O3wGj3KfrZL6cRb2tbUpyrhfYx6Hg+lg8vD0A4SX2xK3yzIJC
	eaK/dttb/yKvtQv0iSTIVPsi1CMMjQY1wlHw2hXE7ybIsN5pxa+MN2LneK4kEdxR4ZPA9WisCsr
	Bmvf1UYy0TkLZKFhh5ld901S6xSXLeEEqER5Zhk2dQfnuAg9fMd9HIZWJ3HvrzgoJcj1fAa8A=
X-Google-Smtp-Source: AGHT+IEdFi19LIYC7N1vQm9P9d6JKbi1l5Kyv7WRJ7jwN2X2eTGhCdfMP0DEPYRl2gGp1XKyNwtVXg==
X-Received: by 2002:a2e:bd16:0:b0:37b:b140:e512 with SMTP id 38308e7fff4ca-3812155fe23mr39620201fa.10.1766534380716;
        Tue, 23 Dec 2025 15:59:40 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38122683ba1sm35733221fa.46.2025.12.23.15.59.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 15:59:40 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ychin.macvim@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] status: show default branch comparison when tracking non-default branch
Date: Wed, 24 Dec 2025 00:59:39 +0100
Message-Id: <20251223235939.45614-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAHTeOx_kSX7RhVvjjffSK849MMQbjNreqrq=ezHazw0GjMO2Ww@mail.gmail.com>
References: <CAHTeOx_kSX7RhVvjjffSK849MMQbjNreqrq=ezHazw0GjMO2Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are very fair points, maybe a reason not to have this feature on by default then.

For me, I work against clear origin/master, origin/master, origin/develop branches at my dayjob, and when I do open-source there is a default branch to work against. The GitHub 'gh' tool defaults to upstream and origin repos, which is why I chose those. But I agree it might not be right for everyone.

Maybe what I wrote in a previous message about making this configurable via 'repo.settings.defaultBranch' (maybe call it 'repo.settings.statusGoalBranch') would be useful, but having it off by default instead of on by default as I originally suggested.

I feel strongly that it should be able to be set be repo-specific (and globally). Having it only per branch defeats a big part of it. Should be straightforward git config to have a repo-wide rule but still allow disabling it for e.g. 'gh-pages', I hope?


Harald
