Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A06155A57
	for <git@vger.kernel.org>; Wed, 15 May 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807885; cv=none; b=GUcTBtCTfSEslJhleJnhA8Js//Idk2YlTRfSnPAeK9GN+ISoVq0mMFbQMgCDDbuHdHfzLGg9Es3wT5UkXR0We086xujGWyOic0vPavgQ4clzpdKlzktNMmarsA3vw256xxvMVnmiLp8gd3xKMR46EUIZizEip4hrxyWJTK8+4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807885; c=relaxed/simple;
	bh=T0VDPRh2LHYXc2baLTXN9uA2nNgF85x09Bgohqgm2rQ=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To; b=W268/qj1jpY71OGuvPNoJcC/xgpTc7ZUs3lReWekkw9YbXeN7kiIz1VC21K+vKAQ+5yQtwcPKu0Hf2nf+igRUUvC1r6f41IxgVwSEAOsDh6dFA1VxzdVL/UxIufiLbg+y6gfEZAI1FHipeVHYwyepywOQjFgIE7tB5WJVv/pAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDy5O4nK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDy5O4nK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ed0abbf706so54752885ad.2
        for <git@vger.kernel.org>; Wed, 15 May 2024 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715807883; x=1716412683; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0VDPRh2LHYXc2baLTXN9uA2nNgF85x09Bgohqgm2rQ=;
        b=PDy5O4nKH71l0sMYFidGKYcuxUpLPYAfUgEJi2Rgi1AK8EcSs4eJZ+Q1QhhZrM/B5M
         VwjGnhhJ9QdoKjbbyRw1Xf51IZqaeNWV4JyA8cB7FZ8vR2c2D/ygLRZfilMEFTfWNCJ5
         njAQsa7fw83FkV7eMrjuw9QDMUuyU4Cch2BMqQzjYXsxx7mK7rM/QueZO2TtFbUMiuzn
         nqiyItuuQai7lmwoibr7zMYLhddqpuRn4U+23I3YZmphrmAEDO9p/EeIppZH3IFM4QY9
         0PFuavT+Qhj4wrRNMajOfIK8iVFeTX4WIBh7BD33abTQWB2K5a9JhZf48mYSV7gfWLi6
         S2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715807883; x=1716412683;
        h=to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T0VDPRh2LHYXc2baLTXN9uA2nNgF85x09Bgohqgm2rQ=;
        b=r/Z/bkPRf9njuc39HjhumUs6u8OwyzzOp4sMMfvF4d728n9O0Ja7ydEK14qun5I1H+
         klJbNOlmfmebUHW7VvxU7rysmm4DJNXgKbw1hTCAN8OktAVIGv0lUCgyJhgl9YQvqARy
         CzTr4MsxLZFXltDrfLj5jNn0VK9ttBAnUVAUU19UrhZyNfsG/EURcF2sDFf0VkgvrRPS
         8LEmhl/7M0cZF1zu3S1iEFp7GP+B4fcBvTIRZDn0mGy6tZUWy/LgYS34bs0l5qstMekd
         Xw8ejkc/JUBPBRZ0nx/72zIrFGfmhvf4MUuJFuZKCl7zUl+y7K1xqrLBdkub/xCfm/1F
         sZ0g==
X-Gm-Message-State: AOJu0Yz+AeH9wbGqmpzlg4Utw4Evv6nKRhp9HeqacFv0+tSMwOacy3Ah
	DQ/t7E3jpIcWuFtloQxKtsNXVKD6H0QtMMuAEXW0f+J0KiqBb4cItzggXg0Z
X-Google-Smtp-Source: AGHT+IFS6t6odhY0bM6FVwAp2o230M6ntWUYHGw3toZTtcPvDZbI3olbwYeV+D0V14EIt61c4vX/zQ==
X-Received: by 2002:a17:902:9890:b0:1e5:3d8a:75fd with SMTP id d9443c01a7336-1ef44162e66mr178071035ad.69.1715807882519;
        Wed, 15 May 2024 14:18:02 -0700 (PDT)
Received: from smtpclient.apple ([103.151.116.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f0cb316bdbsm112625ad.289.2024.05.15.14.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 14:18:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: =?utf-8?B?5L2V546J6aG6?= <baozai55001222@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: EDF 
Message-Id: <54F1F519-BA74-4C03-948E-A92D6D71B1FF@gmail.com>
Date: Thu, 16 May 2024 04:17:48 +0700
To: git@vger.kernel.org, careers-feedback@google.com
X-Mailer: iPhone Mail (20H330)

DQoNCuWPkeiHquaIkeeahOKAhmlQaG9uZQ==
