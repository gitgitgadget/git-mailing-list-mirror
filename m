Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F06BB4B
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118094; cv=none; b=NTSd5ZcXtuSceEP134ybsEY7HLlEBWA8bKF8S3C9ZYJCi/u/JWssHjpIM/FWbMxXelUcGR79xg9JRJoNV4rPuaYp7duh06Dv1KddBQFzLTYFiBTt6sNVpRQ187JoZv8+n7gex+HJo24FtU0/hGJVEZaD8TY1zWA1mhaTNOFkf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118094; c=relaxed/simple;
	bh=W+nZYuZ/BZnLblmejnjQqZl03m4+O010WHVj0BnFMj4=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=Io8K9BoAbLsNJcyzLWBMG6pjnsRfjx9MaYsEXpDlUgUZ8yu6Hb2cI+s9Hu+NMd9f0eI6zib2sI4oubjPZ5+4ZcOX7FWPqwVmNdNjvqMsvz0zDdp4f8DiIxGDNAtJOLQeEJxI7zSWXTvIhvSXv/Ir+1YAhOI3Z33NbdfDea4G2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0t9VJxZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0t9VJxZ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d43657255so750293366b.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727118091; x=1727722891; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+nZYuZ/BZnLblmejnjQqZl03m4+O010WHVj0BnFMj4=;
        b=b0t9VJxZwiyjIZtM0BjC5KQbMRxn3y1fY+p470qeoT+JnzjdJaejeZbEKD6kfLL7mL
         m58O7JTYR6JukhRBEImyGTQAlRIWymvLiPtXRGO+nIbHMf8yY/HpiwUEp0+oEOZcJY3I
         EfcgZ6q6gndYkH0Njdj4D1QQGruVSPKBXPtm5K9KTesVT21qzTDpZzPjU9Jdf+D0aAaq
         jnsXwK6GTgaGGayPGhMGdr/S+j6kaF9hxC2o+p4H5Fr2jqqrYb82IKBBeonPxtOF04Pi
         GAMNtEdfIM0a2m+gCasv9mw8fDqtZkf5TcsTffH2zaoJDyxoSciNTdSegw7+nQkGUA8f
         JARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727118091; x=1727722891;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+nZYuZ/BZnLblmejnjQqZl03m4+O010WHVj0BnFMj4=;
        b=DchC2Lqfb5BT3344+b73eV6U4HyT0woE2QAhhVHgRYbS6kGGG3h4CVUIqHWIDnrxjZ
         FfYTTvxWuykcJWA+VsG1AJ+KufjsMLbbW7G4NJ2gUNv8hbzj5wHpU3fA8DrgfRjMGHyY
         /Cf+ngBeFHvjXOQMuIfnPXmZ2Kv0jhbE9ut04DPvd1E/MPBUyqthCciIEvIXQzcVv/bh
         pG7qzXYISyLvNglHhvlfI8jBcnsycKDYkB7xuMcxKc7eQ9Mn6ywy2BwedNyoTRLSPg8u
         BUDgxpSq3TXXPlxpP55gTtDQPFQAlQsJy2hLAbWbirV/zqcmJdAg1+7r7oqgy500dH/1
         HfHg==
X-Gm-Message-State: AOJu0YyD4CfHkmThUAU0P/I+hTzJPxonoFDBWrqh+VOOf8hTyz9RdPMb
	0wNMsm7kuo06PKBoMie8vIbAS+3pEGhurnpd52sv7Y3GUezISSzO89Ijcw==
X-Google-Smtp-Source: AGHT+IFE4+tLXr4Zr+425NQI5IiE4em6LOGN4C9jhu4JSirF55w3CmiM3HR2CsQGIeGknGrsWrHkuA==
X-Received: by 2002:a17:907:e65b:b0:a8d:c3b:b16 with SMTP id a640c23a62f3a-a90d4ffaf60mr1077193866b.28.1727118090433;
        Mon, 23 Sep 2024 12:01:30 -0700 (PDT)
Received: from smtpclient.apple ([90.196.156.204])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096740sm1279771566b.12.2024.09.23.12.01.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2024 12:01:30 -0700 (PDT)
From: Alistair Cairns <alistairc3@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Username bug
Message-Id: <4E002778-B3D4-49FA-A514-B2423CE8838E@gmail.com>
Date: Mon, 23 Sep 2024 20:01:29 +0100
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.10)

Hi there

I recently changed my username but it resulted in adding the new one to =
the old one and now I can=E2=80=99t even try changing it again to the =
name I want because now it says the name already exists! Github =
Community has it well described in conversation #69890. =E2=80=98Username =
did not change=E2=80=99. I am unable to expand the window to see what =
the solution is. Is there anyone who knows?

Regards

Cairnsy=
