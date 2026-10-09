Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D023E334
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554152; cv=none; b=swAxrbjnLjpQoEKoMzp2TiT2HM9S2zV8BUrcSUnD96g8GjrOY0zm5Rwx6hUJ2MzSMNqrwREgvC3hJX1ynUkhb4Zq9EEEtkHL0Bjvgw/YPWugDvqIPzLvWT7Ms4V0O1TN8D5/rlYf2bWsmLUXLs3gYxnW+Mp4RcUGBctGxLF5XZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554152; c=relaxed/simple;
	bh=oTf/vygvvIEJ7BgsBfp8lKiFw3MtrZuUCNTj/bnD0fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=su4+BGu2JlK7hvKMLfOt+KJUu6bEnLtK6SdSbJQZwQiyMUtNHb4gR1rySZ7vektYhXooJgm4uPwCxlztyhgTyW/u0Rt0zU7d5I9nAmInGrY7RrgqSIzUH3tAAkJmmG2+mKN+wXypTmus2kBXvA/JR1asTTYHATR+yb1jNkmLlhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZQrNaDa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZQrNaDa"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e6038cebefso25537885ad.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791554151; x=1792158951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oTf/vygvvIEJ7BgsBfp8lKiFw3MtrZuUCNTj/bnD0fk=;
        b=rZQrNaDantUk8uYcnm8fEeoX2kcZ+9S9NO0prNv9R3kjxq8WGgOCg1Y6cZIifl0CRL
         +El5s/U3qdGBhWurtGczIJ5imXQsyW1rcQEvL8UUaxuZ3QGzeVEWuZCjJX45Kbz2oxXw
         n1oOJtOHspmon+sdCb8vxjokLXSc0gRVqXTmH5IsuG2STWyw/LWGAouLfmHrFQYl/YMv
         IsbgAS6uXlE4pvxf3NmbziHtkDO0aBj2we0LjxuMSol5/uDPi9AJCbn0H4BfbNBSn5Z8
         4TiXYeePXeZFVELnqTKLLYOtr6Z6YQ9U+jM4oH4BFfHiCVLmAURAni60FMynEV76oouS
         4AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554151; x=1792158951;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTf/vygvvIEJ7BgsBfp8lKiFw3MtrZuUCNTj/bnD0fk=;
        b=F2kUn66vEZ+PUaIlWIkv+zbAleRDOLZqMNmBnLLWWLx08nId+FrY0Sq9hnxKf4+8Ko
         CV8fFX5T29rb+g80qBzOVETLtmEpLFijHCl5XqZSlx+C5ovi6ETVrjTwJsrASyNKtBgU
         Sod4xkbtFxzt0vnAVLUwCwh9YN51HKDKOYgHUYOD1kcpOWNY/bXQZJNB3PgqRfRAxZ8a
         ss6uWq9fkBky/xwCFSqNsVBw2kLgxxT+AYqKT8YnT5GoXrZ4W8cwADK9J64O+qBwuU2e
         wki0hbBSC18nkGPn64H5fOVaZoGOcpd3eCOPdEYWSaYu4T7tm4+J//AwhVk77jmpyluj
         9SVg==
X-Gm-Message-State: AFq9FYILU2h/u0nsgKNojlntj6vcBPKJm48oBfv81iyqG1dX5XntkJ3O
	L8MMqVk6PDsE1PV9r2LOGfZh5plaJwOPm1hEcCzyEYWTFx4/M4hTIZ6C
X-Gm-Gg: AYBFou3njJEiSUlH+NIBFS0qEcZs6uh9JN739eAap64loqFh5W9TJSWnJINr0tSRhck
	7sSCWe99qQtcKv8hG9yDrmNfTPEW0lxfU5NJ4/mzVa1x4NIT4C6t5m7PBSSWC0Olo2ED0XpJ4W7
	CRnEhYc9+8Sn5nQYpYkj5BS5ori7H5pkgY0yJuuiNvrrI4ce84WoSOo9iiZ4aas09eMirKN+Xw1
	QF6bRwMDHelVb8uVavs0GsOX4PfOKYZspHS6Ne9Dxf4TSp4qMkQijHNsdvlPs5TdMVCgkXLb0oj
	VCEiT3105e8EulhoRtJXXBqKqmFkK0v+ShFcw1IB+EAqgSIgEj/d2E5QrnPfDLavFGA7GkYcGDS
	qJkqbY0jFQRBwx/aGXrBEJFD/apW2KPg6/rhxBf8bPIZvHg9rdZR6sYxLUzVCuF2WOU9D62sZkx
	GnRFBFv1yuprLZOyy4ZCyKbm8ZhKm4PLxaoaU82GIldYn+MPQQq1y8HI6E8GKvdu7NL+skOrTR/
	udUs7Q=
X-Received: by 2002:a17:903:1585:b0:2e4:affe:e06a with SMTP id d9443c01a7336-2e842cd4567mr18866125ad.56.1791554146376;
        Fri, 09 Oct 2026 06:55:46 -0700 (PDT)
Received: from archlinux ([2409:40f4:3151:37e2:36ef:bf3c:7f30:217e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422fb8b4sm9715565ad.82.2026.10.09.06.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:55:45 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: Re: [PATCH v2 2/3] mergesort: move sorting tests to the unit-test framework
Date: Fri,  9 Oct 2026 19:25:29 +0530
Message-ID: <20261009135529.141444-1-dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <asjVhlTj3MqHcGm4@pks.im>
References: <20261007034205.32619-1-dilsheddilu123@gmail.com> <cover.1791365181.git.dilsheddilu123@gmail.com> <0429552774367ddcc3c2fda78e09a83650ccfa02.1791365181.git.dilsheddilu123@gmail.com> <asjVhlTj3MqHcGm4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Patrick,

Sorry, I didn't explain that clearly. The list items are stored in one
allocated array. Cleanup frees that array directly, so it does not have
to follow possibly broken list links.

I'll go through the code and simplify the test setup before sending
another version. I'll also rewrite the commit message to explain the
changes clearly.

Regards,
Dilshad
