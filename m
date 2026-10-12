Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206349B1F1
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818279; cv=none; b=qZoyW+ze6K+S5U3e0R8ki+RbacSRsaQR7d/9uO8tlcu2tk90f8IAVr4X+76N3wKghlQoo77o5roJ7e0S2v54sKi5V8VTJXEgg45moEDA0OrBe0so6DxpG7ALupHeqQ/1jXZlBbfjM2vA0iikeblmqGInH+F/tFxcMCU8tkhq1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818279; c=relaxed/simple;
	bh=CesbK8+NFuXbS+spzKHuu3AW1Raf2w5kloHTynl1AM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehxekq6f+ZyuIgjV/wQ45QEWatk4fDy9rSJ9KkxTYV1NTuqAnnR4pg92NypwCLOZ9Cdb4wRfqAI0hUaF9LTy+JIWZTBFZhLlds4Ov17v7BbCwZlesvTPddk2ZTzhoCMgp8SG63eJXwywzvbqfjavsdaUv201A2+F3G2q4O0eth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTxkFTnU; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTxkFTnU"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-354ba08cfd1so3549786eec.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791818278; x=1792423078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ft8Sb7KdKQW1PvBHSYGS1zGkj4cCPTVD2fWrPm2+zcc=;
        b=QTxkFTnUACSl3s1nQymE0UmIp1sSzwwEgshEQFsoyUfQONIrkRAxkDG6R9+nEM2d5d
         xjGPXJpMcjWJAT2rQWELPIGO5pWjBMyuMOHdm3PQAi3rxA9SYOwyb6s+SeUU8txDqXoR
         TRmiy00VhW2z51NSm+LgJJ8yHZCJUHa/JtRNrYoMqWKfrJDiUjqk/Cl6iqRnctHWJdP8
         VN5J/V1AtAGSkmzO9lExoLVIbB+sn7q/IGtCr7uSnZ6eSPmSkky7Dv+YG0CiQ5UnpEO9
         RcPXV+F+tHF40FA3S2qfKsuA9yFOycf8jiax2Z7BizfHfIyV+hylYpZ/zro8nnloppN6
         5KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818278; x=1792423078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ft8Sb7KdKQW1PvBHSYGS1zGkj4cCPTVD2fWrPm2+zcc=;
        b=CTlE/DoNpiwBqv8ARnPdm90pewzd7jd5udoMBv6peqYWmCrPKferUjOdMGig68WYti
         II8bOFil70qIFy/Y2PTYsCOOE1dRiuebq5dhW/JE0V3mWKwhkgG3UU/FRiHH4Tv3zQYb
         l1FgHXqGW+AofGHuM5XydYHtGo7oDyTfAE1aGYrqPCdLLDzN7Crc9PVXXwP6arH9yKb0
         SCYoLKLeoTClcNFPPB+bnVL6YQACZp6I3LQc2jXa3iuG5ftgfc5LmtePPyo+mUBnbRS3
         LUoH9nQKUCWtnF3jySgjA24pbHFa1Ei5vbzyjeUMfuy8ZNx9ZXCIa65biBV+7mHXEcfT
         bwTw==
X-Gm-Message-State: AFq9FYL4XMDY66PZIx9/QLxmaFlaCEa/+EUm+ENy9Blx/XcdMgL3Qw9C
	qtLgv0EmpUB75XHJiWwZwOj3HH2TwcybMGFl68s9hj+JG3J/0930p+UE7quEDHTSc7Q=
X-Gm-Gg: AYBFou0AAeawjwX8aQhd+bzMGVozB0EG2jTkqe3FOK15q7KPCn4CdsUgb+THpuakb32
	vIZvEd8NfpqZ7zsxRZUXn86o8E9B55hST8Ls0hQetdYW0TQqagJyDW3Zc7JV+kL++K3MQfWifLX
	cROI8aCA+O99eYk6lufcT95of1sFKP+Dm9M+O/kLpUuKytDqJMTzpA86brIlauwLBiPibIKufxA
	SqwHOu2Ch2xrLRGfn0drY9AB7kZIEzAfhyeTK++B+auxzn81vUQ8QpItKbOETwwlnZLmTjPjdYF
	W0BpX0rIMXlVc8dSMRVh/jbIxv7+Rz+D3Dk5OeI7EE3UM36lsX4Y8stP2yKyLlCL7h8mUkhT/7F
	aFWRf35XsPBr1E/F+jex7NHCmc6GlqVuzjilreQ57+CpVq52TqgiN/+YVLntXXfLm3VmO55+FRT
	ELa6f8ifBqsKHdELRv9DZwYIt48oq8e+PDK/J2ga5RWEzgRThHjyxwLY+SgBgaIcD3SilSV2as1
	zDiwLnwJ1wW12OJo6va2FEqURYI9WTbjoc2ZrG6ZYAuTn+k4qy/73yuKbaW
X-Received: by 2002:a05:7301:5f0b:b0:351:4648:3611 with SMTP id 5a478bee46e88-3537e1118bcmr12689181eec.26.1791818277413;
        Mon, 12 Oct 2026 08:17:57 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm36525549eec.21.2026.10.12.08.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:17:56 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Xiangfei Ding <xfding@google.com>
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	dev+git@drbeat.li,
	davidben@google.com,
	dingxiangfei2009@protonmail.ch
Subject: Re: [PATCH] imap-send: use ASN1_STRING_length
Date: Mon, 12 Oct 2026 15:17:48 +0000
Message-ID: <20261012151748.62723-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f609.dirty
In-Reply-To: <20261011210928.3900020-1-xfding@google.com>
References: <20261011210928.3900020-1-xfding@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Xiangfei,

> +	int pat_len = ASN1_STRING_length(asn1_str);

It seems that with OpenSSL 4.1.0-beta2 this is deprecated (ASN1_STRING_get_length() is the replacement), so it warns, and fails with DEVELOPER=1. The patch adds a second use at the error message. Beat Bolli has a series from 7 Sept ("imap-send: future proofing and two correctness fixes") that also touches host_matches(), maybe we can check how the two can fit together?

Thanks,
Aniket
