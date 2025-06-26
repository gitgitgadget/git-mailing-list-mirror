Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF71EDA3C
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972974; cv=none; b=nj/ST9RXU5tXz5ngaQgamowqSdhnqmjOT7CpCemg2SRGR/LYLnHoFemdTEFNGaHfUrC4d3naKVACPw0Lp/kQpPYeKUZBLvHR0JHUG4rFbo0NjEnjKD4vUNcKNlTwVUJZXcz4E7U2QAC20M4tJ5UgygOocSnfc4nMnidiPIeiP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972974; c=relaxed/simple;
	bh=4OMew0Hu/xlFH9xWNqsmA/6AXdoa8aGZmVy+wtgUgrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCzlHs+yF46vOxjAMkWEog4a31Wl4Zc0rCO1Vi7X1F1v4sM0j6/xpXPwY8jTFizI3dHLt0b3Uta6tJpU/Wl7k2VhiboOSFgMt39xiaFWR7ejY5BHLJ65AAIEZ+yyuoYulc2VK6A7u1JYc0XFMEqa0WqE3OcZPCP3dzOd2FmCby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyJx4bf7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyJx4bf7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33677183so16427265ad.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750972972; x=1751577772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bePbSvgA2ZUxczXYwOh908HyCpC7RN/SJJbu5M/6/ME=;
        b=SyJx4bf79BDKdqYhZtSnAlsnFBlshQ+VnUYx5RgGVE/Mu7dc9KoB/ATAEmzOgVDc10
         y/0s9cPM+kGqdgwU8kt1lkkIJZxMj0lLBh7BCMp9kUYxzNLyDVPIC+Fho5ImHiZBGp4K
         P2ExBmiYWnmD/tLro+oAjng2vYZQsyUtct2bC2N9JmMAewtCR7l21+OdLg8HlfXLfCoh
         0LTB4054nScpnU/0v5J0wU+VneIcYQCeJpg2w2LlMLGWi+p1J8e25kXsb+kBWLPSSuBa
         d/fuFFqzBrXIE4KeTJSaZDNYS4Apa9s6KsyeoVpQ4k84IjTxHEsc3ir1eImmq58RAnvf
         mlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750972972; x=1751577772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bePbSvgA2ZUxczXYwOh908HyCpC7RN/SJJbu5M/6/ME=;
        b=sH9qrrwxeKDZA+u6aM8TnG/33saaQcNaRg6cJZTGabzt3D2q9sm75UV7YsDTBBQEHG
         EtlDqaZgmZZ8YaPHfEZ2LnDqPlaayiNTrzy70lBbdmEALb3JRQCVDVzF5BAp2fgJCtvv
         adS84PrlPCcsUpxqKOZn7KUNNj2j8HhCHQfWAErIMEqPIf9Ky6KldPVABpYHQ9wta0hP
         5Oztk620O07vRZyae8hb3v31ojN90sx2zbjWs9YK7uutFeukZMNPx+yag7Ptf8rlHSo0
         au8zMgcvR1RUHVOa5jFlD8u/FHLff3m8XLLEoI0l9i7t2meSd26OkRddnscPUkgVOgEP
         sq/Q==
X-Gm-Message-State: AOJu0Yyn00njpZLKKIijqoL8ot0mZP4WTD7IZZzBzjgnT+efinjrn/Zp
	IF4HS8VsPEm0z/s9w8JyhXvVi02VZ0qIepC5W7KLqNF7tvHdP13q75mttbTapA==
X-Gm-Gg: ASbGncsTOsIMnUxmMXifwAsx8ShvSdLezBqvMUqmHlLZ/enaspfMJGJKj4vbln8PKo5
	cv7QbLJUDb6KbVgdFr8Cgg5fGN8mbxYtKEls87Ub+1iC8WbvK2wzRWjgbUMsCiIZdksEaILEso9
	hk7U01OV0ismCjFp0H3XuoHHkhZwoixmkOEAckgdbUSa40uEXPKY6UCZIqGCBmmB6sF2ho8APgo
	XSvPqXGeY/isPb6+Vh7iSC0gSsp51ngHgL4EUKrhaqdVY7XM0EmCJLkReGO9JiWsy1ejsOWXbS8
	KSSFisRTkiej9pQ7kmO8D1mDdiwmfAnHE4krZj7OzXklixLLycEfQwKubc7mgfhNeWrIeQO7wot
	P1HYuy3gBHJgAxnAE
X-Google-Smtp-Source: AGHT+IFLTUEWmjaER5EzsC8wMBmyxOF34thiOn7j77iQj1+A92rBF2zdmH94RqpqfSXE78eYSq83nw==
X-Received: by 2002:a17:903:1aed:b0:236:6fbb:a5f3 with SMTP id d9443c01a7336-23ac4893e96mr11707215ad.40.1750972972490;
        Thu, 26 Jun 2025 14:22:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:3061:f32d:ab3f:87dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1bc3sm311995ad.28.2025.06.26.14.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:22:52 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: chris.torek@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [RFC PATCH 0/2] daemon: tracking childs without signals
Date: Thu, 26 Jun 2025 14:22:32 -0700
Message-Id: <20250626212234.88570-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250626182432.87523-1-carenas@gmail.com>
References: <20250626182432.87523-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a minimum POC of what could be done to remove signals when
handling children in git-daemon.

The advantage is that it is at least portable to *NIX systems, unlike
using a Linux specific API like pidfd which also allows collecting
status from children through fds.

It has to do some innefficient management of the fds array that is
given to poll, and wouldn't work as a general solution, since the
children could close the pipe() used for tracking unintentionally,
but since we control both sides in this case, that might not be a
problem.

Carlo Marcelo Arenas Belón (2):
  run-command: add a pipe() write end to childs
  daemon: poor man's pidfd like POC

 daemon.c      | 74 ++++++++++++++++++++++++++++++++++++---------------
 run-command.c |  3 +++
 run-command.h |  2 ++
 3 files changed, 57 insertions(+), 22 deletions(-)

-- 
2.39.5 (Apple Git-154)

