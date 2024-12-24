Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3A1B413B
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735035494; cv=none; b=nyWbevk62nr3Kkx+HzhV/J/FH2sG+BJkJ3ysGkD7/nBSzlVOIPcWCi7HJ4+sIAq5uuK8oknulHUtTPby7C+F8Fl3KiB+YGf3dJ+zomJHG7VdZjvumJRwpiWu5yAXfvwLjxh/Ph3/6rEU/H3orKnueyte5p4ON09WDHSVAANSqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735035494; c=relaxed/simple;
	bh=4Ol3UHbf47jwyvpRoqzOZtvTRHXi89j1G9/7HGC+8LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrg5hpeFIEnoE4zSxooufOxirp0H0edqHHEAVf1P5A2q55IOrzivBo3vZm7apjY/spdgr7H38GLgPuQz2gJqAmR9DNk3LtSW/T8rNY8fhmLprnjKUIVZMZiTScIVkP8AyUkjwC74sThK3hzJN/Z/2zcVWUiXStxhY/04X6rTdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=nM25KVJO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="nM25KVJO"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so6406090a12.1
        for <git@vger.kernel.org>; Tue, 24 Dec 2024 02:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1735035491; x=1735640291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bod39lgR7xDCw8pQMlcOYSaJ9Zkx++sfcyetUwMiIGI=;
        b=nM25KVJO8zWnOolCW660cDbhfBjtk7+IUiSqEJdjo7ToAvaIuOGMYqtjQQe/VgP/HZ
         MG6ACSXA/qYybiPc0Y/YhDVykyGSKDHXhePlfKr1j5aETtHH43fP9BNcWPDLDRKs6ms4
         6nS8fWd++FkPaHTEkGyr/fmpDI0ysz7vg+EcmG17Vq5U5L9JjIXP/huW+X7Zwucmou0D
         9r0f+McyGlX7t2LnZDVc8mDcmI1lb0RMCP58+pRNcpfDuiXw+psyZPKWYdcxep3td2wv
         0GyWRbHyLgQku0ONzzaHK0xtWeLy8lPHgBvYmY4zVAkRqeaXMp9916VX9wEipAHjh5ys
         yeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735035491; x=1735640291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bod39lgR7xDCw8pQMlcOYSaJ9Zkx++sfcyetUwMiIGI=;
        b=ihIF4XJnuW5k+tMpzs4aIvf2/NbKd/dYmnlKt+tUvUmpMMHPyZGAJPvWnl6F99w+u5
         B1Dz0li8HUnzYACY0//ThquEuOifjQ6xUXPL++VOHNKcRTeEhdr8Gw8VHGFZnxzWVo82
         nNMKzPNoE+dd84txKah9S+DX++BLGfLNO0PdVxSZaqAPOyk4GqzPbvENWMAfjXYPpW7O
         KQVBCXc9otxtuvdOmhaaHevs0Pu2SVxB05VwaR7McboFmSG8J8KK1lIABx0rHEwNtmox
         CR2JjGQLzG+MfOakx+5o6fAyA9NBWvnjbmtMJde5VbzWuFDfzAweBNp9Ny/5g33BEnlb
         b0yA==
X-Forwarded-Encrypted: i=1; AJvYcCUPA2cJsngCBZelzG+hKzceamz+k4KBU6wXtGsxh6GAhYZpojOAc64Ot2ekWLfL2hmn+Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GaY4E6WKlnv+NQygWYxH5y9c8IGEeyk1rAkUzrpolArUiF7j
	4xfU0CPD3uTKFkzDQ5jlYzPUNQnJge1B1fdbByIWVTygoSv7pErW1z8WvRBcGVQ=
X-Gm-Gg: ASbGncsKRKDTclaF4uwV3tBBJu5FhRd4pjflUhuZFaO45bLYpjW2Csy6v8h565VyGxd
	9iTWmNXJ7mR2hHzIkG8oCX3Jck/CXBXW9GIC+rmnSm32LyKFd886ztUmaI7ExOAC//+mEoKZ0MI
	6FNhufYOmWFJJ5zJri6MjMQWQRCfOCPXRuuuNNGymkLpr3Orh3O/vlszAASBugzswHWdN09VpUB
	qIw9gRCQbT6hR8Jy++r9jk3xcoalNqJ/gk1Z9vhB9OHmX0SpLzKQJGo8EWbYdzj7zWgxrS42rIa
	4GfCklouuIzEgHQMZatOg+nEsg==
X-Google-Smtp-Source: AGHT+IFbdntcng1BSTPTkWncAR/zM29WdPl++VoYHbsbsi4hvDfrGBGk/AmTa1uOvCT+NWfPd9mG/Q==
X-Received: by 2002:a05:6402:524d:b0:5d2:723c:a57e with SMTP id 4fb4d7f45d1cf-5d81ddacfeemr15059002a12.16.1735035490732;
        Tue, 24 Dec 2024 02:18:10 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f0e4sm6000993a12.42.2024.12.24.02.18.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Dec 2024 02:18:10 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: j6t@kdbg.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 2 0/1] Resubmit Bulgarian tranlation of gitk
Date: Tue, 24 Dec 2024 11:17:57 +0100
Message-ID: <20241224101802.13762-3-ash@kambanaria.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <af81f74b-b5ef-4557-b929-c56fc3309d29@kdbg.org>
References: <af81f74b-b5ef-4557-b929-c56fc3309d29@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keeping the cover letter just for explabation

The Bulgarian translation is fully up-to-date with the latest master
of https://github.com/j6t/gitk.git

No more mentions of SHA1.
All translated, no obsoletes.

Alexander Shopov (1):
  gitk: Update Bulgarian translation (327t)

 po/bg.po | 730 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 385 insertions(+), 345 deletions(-)

-- 
2.47.1

