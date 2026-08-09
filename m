Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879241E515
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786261539; cv=none; b=dLSCG8pZQdn6STW0MypWjoqHpZnrz3HsnW7TOW3o7hn68guLume/59cjldZTfA/99jgfhxMiXc3pvQj8c3yO54iGvYtVI81Ebxy2lujKSN6NwIwUvMDmNR7MRI+APz16FN+a/RwUZYj88PzMYKgoKZrXDQD+2CH+9tDPwvbKRTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786261539; c=relaxed/simple;
	bh=3L4n7C5IdfLGUEobcJFx3k28dIeApBURVAoraFFpRQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0hNf3MPboNcnQrqJHL9MHzOcO4/dTLseDb7gE/wBS79trE568zXhylDwsqfKWWiVPRkDZgc5dltsZcdoKO0o0ILVRxzEYMQ4PcRW3lwNb8l4J963tjWGOdJNpfvf0iNnhbwfK6jHh3++P+sy1tMAW6VhTGyR8i6bH4K3xZv5+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD7noSIR; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD7noSIR"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39f75e0a2f1so4779331fa.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 00:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786261536; x=1786866336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3L4n7C5IdfLGUEobcJFx3k28dIeApBURVAoraFFpRQE=;
        b=ZD7noSIR7GN0cxl19qynS5M9jm4FcEOiKd342qMydTOIe8GK6/IuNLFEHOlnq9bKNm
         bQ1WriJ5iBGttdgdRMng6lRc7JTMaWTH//KF1rDwkCFOW2srvLuTpP1PdFd3xpItGIPD
         1ya4DONyemO6kege5L09i+uQEJWk6Wpa3ze28yZ2nq8rwUqUEw6kxHTf+NYIb2J2+pgD
         Js3fBrOzBdvSQYathJrCEZIpUkfOvcBfDpv8Os11kyv7uOBOfiBI+Tl7JOuiV+8K3OXj
         qRq0ebKRtcGT8rH/smh/cbAB9/YCuNeEmT4vVowA2pjoDOfSAdbUK8FxnrX9q3pbzy45
         5mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786261536; x=1786866336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3L4n7C5IdfLGUEobcJFx3k28dIeApBURVAoraFFpRQE=;
        b=WjkBtWDOt8B2YXhZGJs8WDnokxMjG3yM/VnAFrD/NkzQtVCsqO/9bWUPfFUf1lLY6B
         O2U21GuIVtFLVD9h/Bm8ALOxdP6IbqitPq+YrjA5SZ/Y9J/gUUGOqdrsdE4Bg3uSZMOE
         ijopQgBFX+d1d65lr8mAqd1M+/EJng2AWcijClkHHaxF8/M7Yfh/Age+jNMwcREIN8lj
         g+D6lIlU8t0vmkDGNOOs0ejLs1Trr16jcsy6tC7p4pxu32nsxTXwxV0cDHcC1h1/YMjJ
         u4pfJKcA2nkI1pLPTFPmmPi0ciGySIy4BXFDnvghkdK/x0nQk80M0yprBgF9OKTziHKV
         xqzA==
X-Gm-Message-State: AOJu0YxrnHf/iKVkkz5LEDXKTsdyKcOK7hDBLWzhvDo1QXTgow/pmxCu
	NvSsWA3M2Lizpkg2/mNSJHrbAy26tYRJjsFZ5yt+UNm9pn5oB/1oLwDW
X-Gm-Gg: AR+sD12SUYh4GQ8cJAC9bJa6eHH6CdLG67HzKCDmrxrCXbWu73owgj1sio8PC/LLmV4
	3UF5PEvS4igMN7d04yRjSTDVw6JjZ3/dzopGGEe/iutXA0jLqJr4bvO8ZYLl6SeVtSFKWc/zGip
	U9Qz9crOHonIeK49mwDn10zD8PRUOwnZXjDdT4lc5xagn6E2HIvj3BCY1pPPvw+GHabLamyd7Bf
	/sdUjnPmiBmV2rJjlALve22WS8hYmqZwyJyTSP92TFUyLfvJ6qbn9SDggsdqSo/n4HMX7WtYLIw
	8duajgaXJvAitBfOPhxpLICD2GOHs05xvp2VHyXwejNi9jMdlqdlf6igQfB5HJ+pHu/5O9HcjtN
	BnrGgSjSxaVfDNT6Fn0J3Sr/xzV52DDod+yxeYKvdyPqQr4Xq4e2qZeKatp9p4hIVkm54GlP14u
	IE49HrCbn3dJCtvI/Fk/Hg8a+klrYR8FqX80xBbTGKy6o+378mYT4hHU4iWINsczT4bzCDi1akD
	pTFEEV1QzCdb4cDDyfX5fwFr914qxhOcZrKi61Jftb9H1KJ44+OBQKNgW+zZRRzopuyJ0E=
X-Received: by 2002:a2e:bc20:0:b0:39f:bc94:eba0 with SMTP id 38308e7fff4ca-39fbc94ec95mr41331671fa.14.1786261535358;
        Sun, 09 Aug 2026 00:45:35 -0700 (PDT)
Received: from Haralds-Air.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fddd861f0sm15252661fa.40.2026.08.09.00.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:45:34 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	yoichi.nakayama@gmail.com
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote branch name
Date: Sun,  9 Aug 2026 09:45:28 +0200
Message-ID: <20260809074528.5189-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.55.0.500.g5a936bcb93
In-Reply-To: <xmqqo6fc9swz.fsf@gitster.g>
References: <xmqqo6fc9swz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an interesting idea!


Harald
