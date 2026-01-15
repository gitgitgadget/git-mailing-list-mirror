Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA13326D75
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512552; cv=none; b=rcIqgvHL4HGZdSW/k3IBb/IZ+tnb6H1ysgHTpdsHSEU+ZAkmqyczAXbqUChP14t0y+eOac8fahZrjNhkD4h6voVohF7XIEaYzk9+eRISTXndjllCKfhf0DoBqimkrNnwhFl6hqdFS7g9QHHcnTzL5Ysfi0AIRWXB07ICB3BJasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512552; c=relaxed/simple;
	bh=9dszsXSUWhsYquRcjM277+BWd2K5XPAAHC6Bl2GUvoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5uQY+RmeV4k8GUYpq7Yw9bGgwqD5vU5rHTs0tCm9Ane2bDZODg6L0zBs/kHTo9I8IFHlsyRiWOZbffoJ5IhRh/mlI0mLgJdkqU8lSP0rhoDSduMkfkg3dqsbzNDUkoDXVfPkOVm0tmuSgAVKOpQlxukrSGx6dQAn/v6gMDnxr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiPp7w4u; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiPp7w4u"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a09d981507so9626555ad.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768512550; x=1769117350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dszsXSUWhsYquRcjM277+BWd2K5XPAAHC6Bl2GUvoQ=;
        b=PiPp7w4ukmeIm22istlpcD+gCbsPZWZdUUVu9H4LzlPWiWLU3q7COFz+fQ2kt28VzJ
         eQgBcLJamKo+8T7yyl/cnnK6PPHzLvPirbV8YP+diVabem4Xv1zcp6eE32dVMx22OXC7
         3q1Qx6bdbPvJUswimvMhbNXkAY52qTCr/GuTno++3nXKDuuKfFp1LQiJM9ySLUNabFRq
         tQFQhj6YkpeZq3ypjZFfGWKVv/TJh2+0UGX99tNp+hktHnc+8Q37sIFZaLQztIo1fz80
         duFj59o99j5aBlMvGoYhV50uz3wcixZ1XDp0RVeBei1PFcUbtpy9jjmRwgksHwgtHlQ0
         /lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768512550; x=1769117350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9dszsXSUWhsYquRcjM277+BWd2K5XPAAHC6Bl2GUvoQ=;
        b=ufh22wgd0ttuT5xSPBxTVtWWnCwXj9Nap0IempOVrADshuiyakQUlps3LkknIL58va
         LxtglF/5KiNQerNxTMQumpLpmbwQ1R5b5Xw2/Jsi5gtvYKv0M5uWWD54AwPKhTUTzx/p
         gVRcC84ojHUZnuJCgx6XHGgeeZE1sVsJQGWRnPwvvYZ1KvVEOt9TDAZutsWr9cWTIKzN
         hXW8avk7I9TSprVkpSYRCYCvKPGijR3F69QZ628/CC7nHxfXgFFwLe/AmLle8ahLbHIt
         p2AQ/TRYJANpVpP0sr2eW4FWSEDYWcFMMRn+vZn7qbccswmX33Jll1HhjxL6sY6f2yMo
         Ejpg==
X-Gm-Message-State: AOJu0YxVlJSp0tHxz+rgTdipTBDxXiOr/FQZzpWHq+ODhDr1M99eXHI4
	rRZC9//AXhnw5b6zWYoug3N234MneyqdFVvXh3s+GrJKbGnAiTuk8swsSAh4uw==
X-Gm-Gg: AY/fxX5nMhImVZFt271eAoK3y3vRh0/T0OZciA1Oi6cPA3CbJ7uKGL92Ael56kEz2Ea
	oDFlBj4Yq07LDLs3rRXJ2zoaEViY0oDzfagc6HwgIySN2LwLFIrtTmq58Y5i5yqRqgSQ0XrjNRk
	P+GFFnQqBHqOla1dGNwYsK4LzD3hkr5nAtKPe70uS4QY6l1rTlZPsTCgBCGYy3tNtPfXM/FxUEG
	b/I8EFBioBz17nPZRxV2d21592dgVEa+agTVQfsr6pBsV0tTvTG9mDEM9jp8gDQYyA4+gPGzYjB
	iS/W0fx/RT7TXhY+UgcKbzQ9lX51kZYqAyfiryaHVMhBRWQ/VD9hgZiG3Rs+de4+YoXiSlV8N5H
	FYKznbo91VAg11EffgFsCcFhzRTY2RF+IarWbjXfigNMTWnB9nuWScjGTTYYmL90E2eiEUK0tVr
	M4LdxARLS0n0tjfaUzYKjCabALPgZYZeNLn8nIYMmtZrVUyeC1SFyJL+dJ
X-Received: by 2002:a17:902:ea09:b0:29f:2734:837d with SMTP id d9443c01a7336-2a700a51209mr41886945ad.28.1768512549687;
        Thu, 15 Jan 2026 13:29:09 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:40a4:2a1f:e343:cf67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fb2bbsm1996825ad.74.2026.01.15.13.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 13:29:09 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im
Subject: Re: [GSOC][PATCH] t5500: simplify test implementation and fix git exit code suppression
Date: Fri, 16 Jan 2026 02:58:49 +0530
Message-ID: <20260115212859.18913-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113175913.474414-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260113175913.474414-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please let me know if this needs any further changes or improvements, specially in
the commit message.

Best,
Shreyansh
