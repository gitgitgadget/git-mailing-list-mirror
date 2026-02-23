Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852312BE03B
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835212; cv=none; b=iDbdLonJNy5w+KA3RtsqHv4l3FpaNhhOkeKXvd2xSGbynRycpukYulqMkONCtOdJ2jloTbyv6MfxPPwlklZ/5nfdsVrz5WM88hLXgRJL+dsjSzQbOABSABqkxPraKT/ONr9mqfCeerzk+/fjlshqynUGXnKXc8B1a63i8ffa9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835212; c=relaxed/simple;
	bh=+uL4VkuF8jbfml3iWfoEvn45NMigjlcwy75d9qoRhpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pse115uHJWpFlS/bAtrgNzEniGFKX9fP0qqoSSUQ9ALVsNNPpF5I2TWQp4z6gj1SbAWGBDf268hjlFQ5dINCuzOSAtWkZrkSo4K1y7//yVmgpDfkjVVn5Gp68TgEmC4gT4nKBMh95HYzWUT3q4oYAYSec9/66WIm07Jax9LOf4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Owuwvt1U; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Owuwvt1U"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3543b9f60e3so1788634a91.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771835211; x=1772440011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uL4VkuF8jbfml3iWfoEvn45NMigjlcwy75d9qoRhpw=;
        b=Owuwvt1UJBZdjH8ssu34XJ8DEfQ5Ocm3Ddtl0lXqJhEZ1qvkpUUltxJE8HSyXTp108
         K/nnCDqFYP+wvvlGyJ1EZs9inDIcGuKGqCIm2c+vC9b/H3wMluMVV9vLjaXkRwcGnsOn
         ksdK8QZBRVj+ZT7ZJ2jucbbmIo6a25uCeSpeCu3d5Lmp/I9iGb6n5s1f1Qb1ZPeUoI7y
         CpLF268sLOsTl9g0/8jT3t/ZhBX5bdeUcJ/R4Eo5xnCQHA2rcs4iXTP5x3JZereqUzSM
         U8zrSx43qqCxxaCWTfmhuEWxmmPwZrrpAyVjARZPvzg6qzqZNWiKFNkENS5neKVog0bK
         0pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771835211; x=1772440011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+uL4VkuF8jbfml3iWfoEvn45NMigjlcwy75d9qoRhpw=;
        b=rH00bs5i27z8sWEJAhwH4wC6EXZL9W3ZpmOC9rlDjPqXNr7uiEWWF4r3ovoUUxlZlA
         N4XLmhBdZd7HLR4IX3MpmAxltEbxmKrBFh+7i3K2+JZsdCgBAvHhcr2DLTyznyOXrZWa
         Nw6Jr1Azy7JW8EkrBkAnqRcLLfvtmnQLISzhY1RQLWthXRdehbN2yn8eojg7eEFQ9pyI
         Bb7FeCczVMGA96ahS5Y6KILO2CRxTkHQU34PQ32WNqJeH++Qw+2ifIP5EF4i4un2PpSx
         TqyUtgZkFZryjpCwMR426xfakrgRktdAKyzHDCJFXR0KsfzWmIX0nG/I3EuTGglQcEd0
         roYQ==
X-Gm-Message-State: AOJu0YxvGcJ3vu0UlDBp2FWJPE0DWbB9gqoHRWE7sMkLBMQsCN61g32Z
	KnPAOzhpdGBiTPqhprBQoiCOq8LIJnSS6aZerznKCowo3hV/G9eJOfb/RACmlw==
X-Gm-Gg: ATEYQzwR1IkWZrQVG6bENfrpQJxHMU/gzYAb4Kdx0SbAQ+u+kgyPYF98J8f2bU5zva7
	dGxBKZm8qt6E8BcizDiOQgBNwZEtv8GZTYWWOpeujzh7I/Ez+uoMaUiYepvYgfxmOsgBhqG3pj6
	dgbU0ID4DngwpvcGt8oZj6QDBSj8ekSi63+xae8oQa2NFuitvQ5M1SwnoT5nV0uZxQmLuQDtLeZ
	yFVPaac9j/heUHOmN+HWxqC3UIOibZkZ/9YXIr3n8SiMdi7/d36OPbNwQFYO57YqPcuDF7GRcTU
	y7g7UrKL7o1czFW6K9BHHs4X9j5s9IvcZbrwEv3JfyCrCqy4z/1704HbQNFI+xhbdoxnJWXRCU1
	S07FeGI7SWI4cdWON9TIwoXxyjmF2tpCX8kLHfyib63mcs7n9/i9Q3W4wERpKH77jyjB5lNFfo/
	gmJDHcyJ6bUYLf9oMf5+ISaqFD+J6JjMzXsiRWhh7br3NTKlBXMr6+aksRKaLaJg9UsPcFfw==
X-Received: by 2002:a17:90a:d40f:b0:343:684c:f8a0 with SMTP id 98e67ed59e1d1-358ae8bdf22mr6568120a91.23.1771835210703;
        Mon, 23 Feb 2026 00:26:50 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:6616:77cb:7575:e399])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af9139e0sm5856301a91.11.2026.02.23.00.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:26:50 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com
Subject: Re: [GSOC] Discuss: Refactoring in order to reduce global state
Date: Mon, 23 Feb 2026 13:56:11 +0530
Message-ID: <20260223082616.1824407-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219181154.66814-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260219181154.66814-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ping.
