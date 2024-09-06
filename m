Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79801D2F49
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636607; cv=none; b=MWd07Itzvq/tZwrWtdIdc/aPDT3+gXUdzX+sCHA0mrOM2xohaO/z9h8t5Tqj4Ul3FLU7kKUoRJ2r1bAaXRhT2rrApn5k6k2pIO+SUe4APFzDP+xmLQ4lZwJZRW8gItuoBkNLDGX4unHKh4CAXX4zU8EEUqmI/90JYyZ937stIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636607; c=relaxed/simple;
	bh=RTK/fnUJIX+XdcQhg1p/3YnYR0Gn79/PBozHZ7IZXJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBi8Up3Pt1yXYdfvvLfYAb58BK6YQFfAioHO25pkUbHGSyd7n3KQ3BlUXtaQAbY02LhzVXvj1+t3eX1hkpOEDSaWAgFzr6ddhUt+jBe7xEEuEL9on0iIEXyIZyCYm8kyu9GtrdkwchDlskoqT66cCxpGETAewK0parmXRDbw+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkVTtYtZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkVTtYtZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2053616fa36so22623645ad.0
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725636605; x=1726241405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7zLR/bmAXmNv8kz96wkbK4ZkMrtqSVK6khcmXtJCSU=;
        b=nkVTtYtZsIBi644uSvLmO1FyDp1DvsyT5R6N3h3LJM8TxJZdUEV4W7n0ety2kT7RbL
         v1+NYyH/eeZyPpmawWvwzjFTTa1nxqUj6EWHzQ5lQBZB5Djuo+hSPEoeDizVFnT5jryl
         Jkd83Z6vs1DoMdMvFkGdmvqXi6ZdB8C1D/RPmQEqe/ukSiCVdAnCYxEe8cOgxnKjvjOS
         9+bGJo8AbRqmo7hjh45KxRYmHaycjfjF8MgA21O3J0u+UVQsJGBJJtyaC7MWjagJsIBg
         DjHdQKPIbsvJrh5SGoxza/YwS+NUyfkZfpSBpAKt7dFgLYXNrIQBrYtjerBbiWPqfcW6
         xmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725636605; x=1726241405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7zLR/bmAXmNv8kz96wkbK4ZkMrtqSVK6khcmXtJCSU=;
        b=evqdIoIfwdwftmgSyrSA3GV9Yg0z5KuwAtrSGun37Zz9NcYVCBc7QG+EaqVm3uu4fx
         sOm7dvf566owB8Z9yOaQt+75dVKAbgbRWmd41wZpjU78IWr2wgG919Y7WtXSZJQzaHVF
         sNORvBBw2PxsIdVsdNXGl3N02YNeIBokT5BIFJRPukW8wNtv0n+winB1ew0kuo/I1fWJ
         ymxsx/V14RLAOqITTKQT0qOMZCSdk0cbyxgnwtlRxuIjZJ/cSPQ+7U50B9j4jtxe/OLS
         fjgyDRQJxz85q4jhdI66epU1kEv4PH4RDDBaZoz2wPTM6AyOqujMYqXNtJU0TracNhQU
         g9Ig==
X-Gm-Message-State: AOJu0YwdK62E0L6RxdZhGWkGx0tySICpJTyZYccWBzhaMR+fQkjV7eMB
	xGSYW95eH2XHdxR4MgxvCU78Q74BinWN/jGzgtwI64mkkm9aiXm0D9jzQg==
X-Google-Smtp-Source: AGHT+IFucHmZ6x4qqRNYtmMgofqurNPHfNa3oUl3TqC49/oTN62GDt2luPuKWGs5pYFo2V7CIX+/Ag==
X-Received: by 2002:a17:902:fc8f:b0:206:8c4a:7b73 with SMTP id d9443c01a7336-2068c4ae8b3mr148965135ad.50.1725636604845;
        Fri, 06 Sep 2024 08:30:04 -0700 (PDT)
Received: from thunderbird.smith.home (ip70-162-122-51.ph.ph.cox.net. [70.162.122.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae950e5csm44475965ad.97.2024.09.06.08.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:30:04 -0700 (PDT)
From: "Stephen P. Smith" <ishchis2@gmail.com>
X-Google-Original-From: "Stephen P. Smith" <ischis2@cox.net>
Received: from thunderbird.. (localhost [127.0.0.1])
	by thunderbird.smith.home (Postfix) with ESMTP id DF25F196011C;
	Fri,  6 Sep 2024 08:30:03 -0700 (MST)
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	ishchis2@gmail.com
Subject: [PATCH 0/1] Add entry to mailmap file
Date: Fri,  6 Sep 2024 08:30:01 -0700
Message-ID: <20240906153003.110200-1-ischis2@cox.net>
X-Mailer: git-send-email 2.46.0.267.gbb9c16bd4f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Stephen P. Smith" <ishchis2@gmail.com>

Cox Communication quit supporting email in May. The accounts were
moved to yahoo and I was never able to figure out a way to send an
email that the yahoo web interface didn't modifiy in some way or I
would have sent this patch from the old address.

I have since closed the account for cox.net.

Stephen P. Smith (1):
  .mailmap document current address.

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

-- 
2.46.0.267.gbb9c16bd4f

