Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59123164C2
	for <git@vger.kernel.org>; Thu, 25 Dec 2025 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766655963; cv=none; b=h1geJn2+iodnMcUYW74f6NlMlp+25/xM2FZDwbaFkbMeUchPNn5NDFjVwtQDYdb7MMKA05gWCw3+RHiMveESwB1IPMI/m2DKmuecunxxuYZ05zrE9CTks35rfmJYxc/7nzpeTyf4TCrk7PYh8u2XFBaMtArIn0jFlhkZ5UJHM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766655963; c=relaxed/simple;
	bh=Uro1H7vKRC1RYsZfNOEZiJQxQz3mFP2sfzlHeo1XRYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/SDFcFcWCffnKS+1nMiuUFLZCR8kgWjdT489FQlrR85jYHdva0fOw47JTGSmsHB8MmNKCxfSD6VQVO2KVF9mRrLp5JSuh4I7fhmhVTltDqIgySKzbxKexkZpm6GP/bwBBhicW7OzDt+YBh22T5h2gcbm4N29oEZEiACLFVp1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9mmTNy+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9mmTNy+"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59a10df8027so8260797e87.0
        for <git@vger.kernel.org>; Thu, 25 Dec 2025 01:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766655958; x=1767260758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uro1H7vKRC1RYsZfNOEZiJQxQz3mFP2sfzlHeo1XRYw=;
        b=c9mmTNy+AumbJjxSBWSJjss2METdXk1ROT+V41JEgNHdd+FK9H6+Zx5FDivhfxS9ZF
         G0Az87f+LZOOBtjFyOElv0JeQ/zLQ1lqIHqwLip9FxeQYVCXKUX8DluS3yBV+trpoIZB
         zPpWV1PLhlJHl8KCZDG7WQdpE7jaEKsN4+t7ACp9EYIV05TkP7ssAlKNhPB+nVjM3wKy
         Zs3AP59F4/q4aocfWC/6gter9M62Ns8EIQ7om6f69/TncxgTHeYMEM1tT0YmDsW23StN
         UciOOLm3n3pwS2pC8mBujOoJgOZ72+MXUXxmWcfiIUeS2vdzxieSQBJttVuvpbXGB9xA
         20Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766655958; x=1767260758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uro1H7vKRC1RYsZfNOEZiJQxQz3mFP2sfzlHeo1XRYw=;
        b=EmSPXoPUMavn5NgKOvLDSY4G3XwR4n9ERD6oy6EcBRNlezphKmFHoUM/f54Rfxik0W
         IJIZMiYpYFOLt/wJ+ysro8lmd2ZDyxcVgQwoD49i1hZ3+yHzjos0ap0PX/4xMMRFlW+C
         M0tddOJO6R688v0ozev664tg3BprWimmQ43UnAg98inEXGuYQr0p/7nqz60zbbCxbaPs
         9/B6+sH7LCHM6q/K+TlkDiN92f0Hqj8lnBixRT2jA2oevPEGezv7RI3w54TC30yAI+qf
         AjWrV1EElll58nTUpqFrq3WYTO/keytzd3PVoDU9oacvcmeoeZIAjkGVII6sWMK8NwYu
         7r0A==
X-Gm-Message-State: AOJu0Yx7mwdbGCsCle0YsTjsfVfwJ558itO+Mmx7QGd7KecVP7uH9ptz
	T4ntVnsb/WTYCEGcrr5DL1XYEMi+fg4XJV6owNsXKyRYLYC6NsFkzFQA
X-Gm-Gg: AY/fxX4vXNphMjrq/H0q985Kmady4zTpDWobVtXMS6K2HF2LwvsPsbDIRrSphlqIYo4
	dpTvpmgLrWSHBt+5C7tV556K/NNH/UkEampxzbql3mJKt0oIJhGjJcyKx97MxnF6Hd5ZgJgrd0p
	LJy63AJz206ty32R64GmFvnHjgvflcMbflsal/4IQSYTrvfl6I92fBcHD8VoSbYGqSif8lfbjhY
	gKxdigH1dvlbtfSGqs0a3S545PDDzjLwtIKQ7YUjrgVDt3+0HsqufrfhMMfSXYChkUhIRhNW/f6
	AMTm4r3D+s9cTyR/0WVFk5M5K8vAFFmv5M6MdJer9FmVchgBKl8fRcMOYtAGSkA9i16VKF34x3Y
	1ValrhOLVX1AhfsufkrUDgwPA1Y2cP88TnR7bBnkCUf0fxds/oYEN1MVYe9Ce9hGJzBvJguud9v
	5Oq71qz57NrPxw8yf6UoxYKf3xrHm5N/e5m5DnM0irzynb+Yf4vUKrUhhgBUTMReoPClUm+Fg=
X-Google-Smtp-Source: AGHT+IH4WOoVheqwnzeVvXgqWAm4IFBHI0spdknwTql9JSAxaurtd0CWRyicFnqklQcxaDjE2pq+Ug==
X-Received: by 2002:a05:6512:688:b0:595:7a6b:91ff with SMTP id 2adb3069b0e04-59a17d355f8mr7494738e87.19.1766655957358;
        Thu, 25 Dec 2025 01:45:57 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185ddb06sm5795232e87.33.2025.12.25.01.45.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Dec 2025 01:45:57 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] status: show default branch comparison when tracking non-default branch
Date: Thu, 25 Dec 2025 10:45:56 +0100
Message-Id: <20251225094556.5944-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqms37m1n9.fsf@gitster.g>
References: <xmqqms37m1n9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Got it! I'd rather just squash all the commits then, the total diff is
quite small still.


Harald
