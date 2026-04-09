Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EF374E5B
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775769812; cv=none; b=U6C3d8dY9B6YGXEicyyWIQ9tQIkBHFt9gErKMN7s//sYo/vZfp8Xt9heixtfZRuRV4dME/JbNGBiGoqCEltGLJPjBUkGfqUnCSZZ+yEQ830Ni/M7d8rZkvwNmPR2LeA6egqKw7CE/vLAfmevG0k+etPPiL1onBUXw5dx54JO70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775769812; c=relaxed/simple;
	bh=GwoAXe8VcuYdUOHHgDfuoqBc2isu2t5QDDEsyHgWBoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFGyXhvEjjJMwVuPFw7/xiZg+7DY7hEbK1mYwdRU/ELPdEZEvR0tjE+eR+htKicKFo0T861Ydsjdo1VrDurKZJDTaG5l4yDBsZ+JAYb57NZBTdEYkSlGTeiY5Ypsi0gsUAoFmoyiycCha+RdYdW4R5aO+SydLheJOrYZ75hRkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLA+bq96; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLA+bq96"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38c620f1699so15029291fa.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775769810; x=1776374610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfIdPxylQSz83mPyQUhGaP3A5fWDbzTcmbvLQcsQy8U=;
        b=dLA+bq96tx9tmFltu59RT41MkVnVuKDo83+JbYNawzwIC+sL+wDEp+Gv1578Gm5gjA
         yvUqmQnzguStbuHtV/RfCk/pleQFMOgJUvjGZJ7E4z0ywHPaFJu+8SXjX/MYtVhI4E4X
         CekSV9/5VZduiDeKa3sgtD/p5oQ0I1TydoWxlWRo5/pmIZEKxI4LUdMuAXYxwunth+Pr
         L5wooDrB1Kh9tK/W/2XDRwhMP9mfjP199TIainh/qa7YGHM9AlsMpnZL6VpkZFtaxJRj
         bofEmFcq1r3wZkglv8990Ji1GcePMxT9rYUXS4bp20lrjhAuvMFzdACtN5aJeStU7wAA
         yPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775769810; x=1776374610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hfIdPxylQSz83mPyQUhGaP3A5fWDbzTcmbvLQcsQy8U=;
        b=iQx/2mi8fyZACzCEw26FShsjb9o4NIt+HPOIXKsi919FK2y2zUBRjKNIry1Q/SsfND
         nVsWfEJJgcxfTW62NYAwwrjTj4sCx5xHZTBOKYn0X0QJdWfeWrZInnAM6fw1XLpabPxx
         kdl6hvG0pRXp6ho6LahVsCQW1cMlrQpa3SkM1XzxbS7nuFV+6QCh9Lwrhlq1NQx39MEM
         S2XLh3GEjoRPpKtfFkEB+2boV/R9MMW4DXMv0I3OBJN1wNP8QVS9oHzephd0la9ncb32
         FuXetcJpYfaa+16v/Y4uPOLqvOG7bQpbzHY6htqD6LxBw0QauywLoWRzzCL4ENsB2J3M
         uAMg==
X-Gm-Message-State: AOJu0Yzw06551zD//R2S+sIvBmYfYu2Axp9R6kbys00tPbDsJmRd9QUh
	+fGuqXT2MaNpGq3Zl1jZvsIes4KnDDYzTXr5KLR1r8g7EM0Dp5lVyf96
X-Gm-Gg: AeBDieuoJSx/f8cyDdH1/Wty24SfpCd+jKGi1/c7u6VPfAdvA6h1BfqvpQ8lw6hE90J
	XH8oq4LqUBpE9XXVrN680weJl5unAypcU+Ao1/SyW+imUgc95df4RlRGTrwsnDsiTZIaC7dGgyT
	z//w667jXRnnHvWd/nIN6o/5d4jpgKPB6rS/86sxeYmjmq29e14ZLarrEEOT2ebwMUPUqGrRwYp
	UjIdQ8fzIBPCCU4aYTmSV4Jczb6+4CkZ/SPwx0pysWgSBMFtTlP/G6LbnRnypjy8U6T7ILPfAx7
	1HHeu3VHPERSHRI2JRGPqmhCFGgJD4rg5TA9BFp5ULgzPTkWJCBE4brzI6JLojmKK28ZAeRtqrx
	lEfStMz4xDJ3d9I/xGJaMHJUyuvLZedpuBBSGq8NmdKp6n1+Zj53NrDYkgcuR/Q5X+E3ZA7qlU/
	7fnpF765qos5AWUN7bPSzzbWMcTaDSNP59zuJuFc9xROuJmHYEuCTM4TwSVFDx5/lPPhiszVGku
	SvTpMLNhP5z+IYU
X-Received: by 2002:a05:651c:553:b0:38d:d686:e4c7 with SMTP id 38308e7fff4ca-38e4bece01fmr1135741fa.14.1775769809496;
        Thu, 09 Apr 2026 14:23:29 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e49270372sm1895181fa.6.2026.04.09.14.23.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Apr 2026 14:23:29 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Thu,  9 Apr 2026 23:23:28 +0200
Message-ID: <20260409212328.19875-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqeckoul03.fsf@gitster.g>
References: <xmqqeckoul03.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thanks for an update.  Above the list of the commits, it would be
> helpful to give a summary of the overall goal of the topic (which
> typically stays more or less the same during the life of the topic)
> and the highlights of the changes since the previous iteration
> (which authors often accumulate, so that in a cover letter for v7,
> there will be 6 such summaries), if you are sending a cover letter.

I'm not exactly sure how to do that with GitGitGadget.

Isn't that what the commit message of the only non-preperatory commit is
here?


Harald
