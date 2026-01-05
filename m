Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E69A335BCC
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606398; cv=none; b=HLuRFmT8Ih6Yop3m62VSc7MT7zf/wDghRFW7R6EfdAxGCzDq9gJ3b05dIzVeUfPWzC6ApYQbxdFE8fwPxAtWoDIEQk4F6IDqsoFl3+ZBERv+pWyE54QmgjVuYFRRteAoCQxaTPosZIvrhnxfvIMIvAeTeH3QvzlmI1TWvYctSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606398; c=relaxed/simple;
	bh=IL4zrPY82FzwiTNooYbSeMbNJyZWkc8MNYIhVx7oLxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfjAg/vsJuwVVBS78iprq/ykx4Uo6i+iMaV0yTd6zXYx+bLR2Uw8/2PUTsPvR6PWm9sY96+Qw9ObOPllmCVWn1awCpqzNoSEhcZ/+9TIxhUsl548mpAniJ/3J4McbNanlYFy1aAPW7KxfRoJPMnZSilcu4FSsuQ644rlzS4598c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps47euVd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps47euVd"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-598f59996aaso16287475e87.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 01:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767606395; x=1768211195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IL4zrPY82FzwiTNooYbSeMbNJyZWkc8MNYIhVx7oLxk=;
        b=Ps47euVdHVup463FdHVVaUlC7yPqMYIOJMSYuD7tjY436PMxwz+aHefz43U/I4a3xa
         zdHroiqFcWbYheWL9cb+qwM7dJ871kerGtJZrxuUVUVBkZbMta804lTwzPHvH/s1xUsQ
         jqqkxeM3NYLBLixfW3hymepnRba8VzTN89+NWVp8LCvdzN1Y8wmXBGud+feEQT9e+2Bz
         vncVBlsQr1lrGUyzR/HYKZt2MuEjuldGn+fJ2hv/uoqWShU/XqK4WP0H8A+DUZMmDOR0
         JvS2q9A3nADtvEcs8GNn8piEdRXbe1bHm54/w3rYxVdx8ZwuXkNyI2VyYKmfd+/9KnwZ
         +mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606395; x=1768211195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IL4zrPY82FzwiTNooYbSeMbNJyZWkc8MNYIhVx7oLxk=;
        b=N1eVEdiKsc7+U55iggbmmNECiFWpi+M5a1vnVqVI4ndpowkyHMbp3aqRtiv4WGv2Cc
         f28gAp75f+9WMdhaekzETkx0/aaBH023tzSREa0gfOvfXCxy48dDB3xBfCavaqwmw2vj
         Py5r2DMOtaL3r406Gt3t50gIi6C++03PhWAPzFYDR45vKoCCPRykAvK0PgIO16p0WnKe
         Jg8khY+7QIo0HbQ94dns1umnk76Oyq6padJuGF1FsEcJFbsLIfX6L2jgZ1brVTyPc0lk
         oZRIc1IKKRYVwPcZihXMLpW/n/cMZTyWkHGQ5U9jEEGgqnWJd4OQ3Gsw/9zTbBri9/4P
         NHBg==
X-Gm-Message-State: AOJu0YyRFXkvpCtLXnXWNUZb3WdhBtpRNu74ak8LyZW9P/Wt/D2/vC1j
	Eaw+jngUBnN6UFdQF32yvoD6y/Tj41bBi4Dyw1xcvM9wpPI90wdb5WXb
X-Gm-Gg: AY/fxX7X+gTvCKdYDC0z4X1ULPLDMug4CM2L4xUVQy65QiTh/hpGSTdR8y6ZYXi4mz7
	Y64twP202xLLwZwJrBKYxYFBnEZ7L0sEpUHtvo8jC2oN//y1/ewSBpp2jg1plj5UQ2nETTFViV5
	DHfYmq1psp5FBELZDMIV94uer6OykIsPerSp+FK/nT7JSXFvy3P/dY3ck+MGDpVnw0EsXAByDBb
	ChXDP566s6k8Yxlk7JGBzNR37eyyyW7ZWBRcyxyhH2RAoLfizbXkkRR8Lukp4tGtSkBugGDS3hp
	iJvf9VKgskNWj1Vz6MpEyxS0HCwuKK149fOwbFV/lSoo1obmdPuVAQhNtPqUSfMTOY+3k24JsHl
	IiZ26SRKOxudfhlG9Gp9pez6/f1GjYrRxdhjQfRwePW3P93lsPTxMAofYRRqHavljTIyuzuN/oH
	3QRpbyW+mmYaaGTsnVM7C0yySzDJo4xLttgdhBnvOQ8i7oHVhQV5umP7cADGqUUoi0qvYLvLmdS
	ffP
X-Google-Smtp-Source: AGHT+IHVKp8usKiPImtzn5CCw0jgRrySiu9uXS/NVUoRGS8R1tpty+Sk4Sj7pK3rbVybCMvC+oS9ag==
X-Received: by 2002:a05:6512:2250:b0:598:eecb:c4f6 with SMTP id 2adb3069b0e04-59a17d44ffemr12824730e87.37.1767606394419;
        Mon, 05 Jan 2026 01:46:34 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f4e4sm14272107e87.83.2026.01.05.01.46.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Jan 2026 01:46:34 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com
Subject: Another look?
Date: Mon,  5 Jan 2026 10:46:33 +0100
Message-Id: <20260105094633.9674-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260105091517.86301-1-haraldnordgren@gmail.com>
References: <20260105091517.86301-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm also adding better test coverage for '--no-ahead-behind', it's not good
that that feature can silently break.


Harald
