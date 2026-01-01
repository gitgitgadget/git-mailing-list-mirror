Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C62F39A3
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767297939; cv=none; b=VAgeJJXKYIrcDnpyohvHSVLW97NIrbnrWuTH16g0d5OT4MRoGbF2qw3XKkqJy2HGDqwKflwFwvRqgXuNkTAIvwSfR3d/lak/kUT8huE+3t7fDlpVHlXs2P1pWNFCU/UyaZ9Kxf/H2LFS1jVeF9ZAUVTW7S8PjwFaVYT3nVsaHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767297939; c=relaxed/simple;
	bh=+s+1ID5C0dZqTfhFzMoH9iJ1MQVvzBly667kQFei9wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4fjL0oHNOsvsHJ3RFSllZyPaI8eaz4XA11CpuVkEB/payqnEZSeHrgKaXQ2Zvdaid0T0SFdVg22W/x77faeTDSLm8quzPrtvoCyAV90LmrFJUAHIDtURRjZMvq0ckI9o1fZTEWTLqTzGZ2ZLE33COjk9ik4VeB0LUidu4+/lG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB/q5X3H; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB/q5X3H"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5945510fd7aso9435099e87.0
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 12:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767297936; x=1767902736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s+1ID5C0dZqTfhFzMoH9iJ1MQVvzBly667kQFei9wo=;
        b=eB/q5X3HzF9tKN6MHiDPM0M6UHEZ0k1aC3g2RsvD9+ZXTX5SN5crAWSjSq9aY/0QF5
         4CtkwwMmQKWbwpNZVdjIaofimoAqI1fwPcIf5T/BCSCmRJX3KZ0h6LJvS2ivkF6qlSAd
         DW9mTDpjWHaQNfuIIzncuRMUjCkwnQl3kXllYmqz1BTb2qvX+sn2HGT/9SjXw+Cfy2q1
         pKm0JULvLHm7KVZjVcdtPnrhbsDiIQkCo8exDZeG62iv7s2MrP9V8ziaSIpfyQ+RrB2b
         dd/RSZ1ZzLoriQsphSuI4l3X2pHnNdFireU4+WXaph7ATT2FFWS49HhX1u7tcvBrzC72
         7iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767297936; x=1767902736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+s+1ID5C0dZqTfhFzMoH9iJ1MQVvzBly667kQFei9wo=;
        b=ii+hJ+l3pFoPljs3jh8z/U94Phi7MZN1FAvORCEAJds9ewWXk+81qlz4USRtAmEPxX
         OtV4tl/ATfVJKKML10Rq2eI8FIxNZLdKzgCjQwDkDYHBtFm/AZDylAD465uRR+PjAaQ5
         apeURpjV/uQCjSXpVSxdpHW/WYmKIiwD/kvDdpzg4OcJxa/eFYtWqu93xO3LYsvAgF2g
         Y1ug81FAKGs7rEBM7IEZi6XDJPeMeouktIF7cmbK11xHErPcghSz+yx8jsICXKk3gdlh
         dcGcldKYJJJzFIOg1sFNq/mDAPshOwRRidA0itYiAbqKVrnNKHLWkZuiL9O5f03tOBGz
         0vrA==
X-Gm-Message-State: AOJu0YyPtwsN3IX9srVJ73I3WeioAa5L4VeOf8qgSWdGxvM0j3c5LLD9
	EXF0paoHfBwSzDCl+bNYaNINcbr+y+wndH0uXHjXZtp48gl3WJ0S7XEp
X-Gm-Gg: AY/fxX4fOvSauW+Uu9HE0lrIp3pWaww3uUz+7GsHlL5qSflynqSQGyZDqky+JcZH/2V
	iQYg5GDz6j5y+yhWDc/nAZ0Ami9QJwcnvDjX2dsFSfd1fmvKhOwP3Q04fBVwpp7JKFdGRzbDuxh
	3J49C8XEPzFeUA1FGCyvfDz/VQ4vO7l2LfvsR8C+6H5sg7BmRMsLD+jSbURk4tylQR492/tThvU
	bz4/4qmkCN4gYqf91SpJwwWVZsKaB/ff21dXEX8RGfzSUcX5mBRWQQnZliavnPCX3WntQNmxIJI
	+wjXfmbbpGsEUlR9yf7PVTQVAyVF6+bLHXAIvZJByjlWm3CyiX/357vGi7iu24WzIxKP4jNwOoU
	dD7E5IyYUQYb/EN7cAw9Kqx1h+Yimm38D7hi2IC5+GjKySMHLVaeGpKF9qN+dDcwMnxD22vXK6x
	YMWA8K2gz7m4Wra++LHrA9aTg3+JrTS/URC3xge67wrFIOGinrTMoCMRIRSVycqCKmY1cEUjO15
	mMnGRHH910k
X-Google-Smtp-Source: AGHT+IGGIGFgUvVl82mpujR/8ZgUZitY4tHMWNC3ikOUdiF5ci9xe2fGmLNP1syO2WR6OPTvfbQ1bg==
X-Received: by 2002:a05:6512:2398:b0:598:de6f:6670 with SMTP id 2adb3069b0e04-59a17d1b899mr14075324e87.0.1767297935542;
        Thu, 01 Jan 2026 12:05:35 -0800 (PST)
Received: from localhost.localdomain (h-85-24-230-171.A753.priv.bahnhof.se. [85.24.230.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f09fsm11988787e87.67.2026.01.01.12.05.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Jan 2026 12:05:35 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ychin.macvim@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com
Subject: Another look?
Date: Thu,  1 Jan 2026 21:05:34 +0100
Message-Id: <20260101200534.15457-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAHTeOx8nrjJVD0U0=BDTUJZNZX0Xs_b4YGbj=WSavWEPEg-9Eg@mail.gmail.com>
References: <CAHTeOx8nrjJVD0U0=BDTUJZNZX0Xs_b4YGbj=WSavWEPEg-9Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Brian!

Can you take a look at PATCH v10 to see if it achieves that you suggested here?


Harald
