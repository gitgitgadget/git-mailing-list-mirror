Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF63264D9
	for <git@vger.kernel.org>; Mon, 11 May 2026 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489082; cv=none; b=s2PJJy23KByWM7uhn/KDc/2M2klPMU9d0Ta6AcZSoViLwU3rBcbkKRiZix3oHZX88OHX8edDMB/Kr6rlVDk3+HVgUnU6E/FS1B0sN/pAGq0+1D0iQ8McEpqK5cHhGnNHD1YFLbpj9RLpiXltBhwdhnXOwQT/qb6B8A5If5NE03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489082; c=relaxed/simple;
	bh=DfUa1PwkFK6CVnpelq/B0jRW+VGyiiP1NxeyLoqxm7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bie1OwRG/J8CgK+MDQdG81RG04tlF8GXST04hitrf4OYPL5dgEjJeu1I/qHiiF8sEc+0BJlCPKau8WTb5CBtDXOmhgV9+YY91+eJWCos/I7kOYb5UTqq+Je9eKlcgCBpdb/1aWCR0NZyUZJWxfuLz96PU3p7I368u+3HUoZmnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoywDC3r; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoywDC3r"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a4113ab355so3724778e87.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 01:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489079; x=1779093879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfUa1PwkFK6CVnpelq/B0jRW+VGyiiP1NxeyLoqxm7s=;
        b=PoywDC3rgQCTQIsmQ58KkkWsfq8UOA/zbY6gpY/Bcku1QCCPMKXT1y+d9QlF1cFyaF
         dEXDmmzEldEOXW34RQk0uYf/VuiGRTHbPypE92bazRBH7Spkx87+/OXTI1ICvLVdK+Ur
         1Km/ok2vA9o5nKP2PFsn2rQ10T22p8OX6YcTUglfge02pvpj3ghwo5LI1BP67Iu8kwXk
         RwdtH/tPaPMPwqpPznoCvXk/kld4KYesqSqOpBgWqo3lU43aiPWupKpcQHNAsz2GDxnu
         rTJxmTI3pURCJb2USchwTJjr6WFSlZcww/TazThh+1BEu/+CQ7jIvuliKHbJNVjYPv5S
         hJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489079; x=1779093879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DfUa1PwkFK6CVnpelq/B0jRW+VGyiiP1NxeyLoqxm7s=;
        b=Gmv7YjsIKF+lazwnsR9Uygfkpo60gYbbFo/Oxkt/d8kY/ZFEoErOZxc1T1uPyLsa+w
         k9DdvTvuxoQA3fKV78Agp5gT6MWMc+kgkhFATjiqdyNQoU9ekSSzN4R/6vd2iJx5UloW
         WFtMQZRlyT27wks3x+id8RJPiec4eU8EzbyZLbn7QeFLrqrj2qfICJyUw8UR6ujLwRCE
         JYEv1E31onrIy3p77iIOY8c65Tn83ahyjgAD3UJrax7Tdd0sDrCRJHAMYfSa/e7Z/Mh1
         AlnB+u+GXQVtablJP2u0hzOA3e3nr6RBkPeIVrf652IbmwccTcjx9JnVrv6LALhCqlQG
         RnYg==
X-Gm-Message-State: AOJu0YxzexJIYDJ3HH08LLcI4h4wQc9VdBdBa8VNdVIOnE6Kb7lYKkbe
	wrlTjVT4R9vnCYW8qzti79jfzqKQOdzcUoKSy0x/EVLSczxfTm9SuG8h
X-Gm-Gg: Acq92OG+BHySU86/J8rHckC732s9qnL+D7Ep6bbf7wZyNc4BPzCkkh2KEaW4Yacpfrz
	+anUbTFsR1x1V5gMyNhuiw2is85s6tbp4LLQEE3DS8aAPxxTbPhr3mW4JA5VtkEoJxmvA8NVhtJ
	mUVR8Rpw6FI27wsyf7l8gC0r/lT6odSinHCmvdzrBuz71EKj1Od+qJN5U95SBaBt1wuW5uDxH79
	/oR222eDFh90qXlJfDwRtb2wuJfaw3/N7Mes4PbEnaKnjRUvC/6NNa7Yq7rzTgqimwI+Wo3f0zm
	xmIWdfaPlRQJU/h4kBCOhbQEBch1kbWEBOW1BAQRYZ45b3truEK+cWWhpG7Xkx/aBaUFu2/am8O
	OWe3/cT5yWv3PFaHKXExsL73LA8NfU/m0Y3sQvpUXkLQfWJ95NM97rs5pvaqhvkuVs10vG5xp4Z
	20t3Rmb5R9IBezzS3uxB54ev5U4ZvI3OFn0Eh4CbEC+id2m1aPNLbWPb2Uqix7xkgdSMvM1Cmlp
	Fa6EEg+JgUD0Qv7DkC6pHPciIHWeId1
X-Received: by 2002:a05:6512:15a0:b0:5a8:64c7:9592 with SMTP id 2adb3069b0e04-5a8a94c8da5mr4498321e87.37.1778489078503;
        Mon, 11 May 2026 01:44:38 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a95661e0sm2451335e87.67.2026.05.11.01.44.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 May 2026 01:44:37 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	j6t@kdbg.org,
	kristofferhaugsbakk@fastmail.com
Subject: [PATCH] fetch: add fetch.pruneLocalBranches config
Date: Mon, 11 May 2026 10:44:36 +0200
Message-ID: <20260511084436.76336-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.455.gdfa85cd088
In-Reply-To: <xmqq7bpas6k0.fsf@gitster.g>
References: <xmqq7bpas6k0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Existing call sites are about "branch -d <other>" that allows the
> other branch to be deleted if it is part of HEAD or if it is part of
> its tracking branch, but should "branch --prune-merged" pay
> attention to what branch happens to be checked out the same way (not
> a rherotical question to hint that I do not think it should---I do
> not have a strong opinion on this either way)?

This is a very good question! My opion is that it should work the same way
regardless of which branch you are on, it should always compare against the
remote's default branch.

I this explains some weirdness I saw today when running it from non-main
and prune didn't get triggered.

I will look into making that change.


Harald
