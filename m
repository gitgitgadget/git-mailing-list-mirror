Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A932FB0A5
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392769; cv=none; b=fZit3WcXT8eXUv4GYCF/sbzkHNSLYKuotoJEBU89CDMOg/cYagrtyyCFTKQh6HXRClmEHfIBOKr2KDZjfiT0+E1u/p+3L2a2nVdXF1bSS1atUtfzzuUN6A+uxhG0whGOeESc7NvPtHiw06ezUviO4iMiCqUdzO1pxmEBcUqKxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392769; c=relaxed/simple;
	bh=CIkNy2xVErAq6F0E0kmpguqhQ0uoB2cmf44a8t3M6PA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=gYgo48YgAZnLV4ZyYt8wxfmkHsZbNUSgbFevhhwOhhN5P7O9fjjLd21OECMxyvu5YKaI7TNbTiVb5+kQ2stYPaQVngSjbJVqx6Kqy2yeStu4B4UN24Atz/gA/+Mryw0zhhhJD2mbXQI3LN5IEKvN9gXuHBMTy0cmTZb+qAw22t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPeYitgu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPeYitgu"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3748033f8f.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760392766; x=1760997566; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=23XrKSkwxbp0+ytZe5SlamLC8Looj3Q06ptlevOZYsI=;
        b=PPeYitgun2uTi7NmuYpxdNPqSHXX7edMt/YKHpaAPzi5xzc+PqaVZOOibIc5NEfwn9
         LtGkGSj1f0HgrpHRYQOumGEykfCCiVYk2DRlJXctlmB7Ps9OjgpPqZ0Jio/yT1VhwWbN
         IpUTMZ/m2DiWcG4IwQngoXjvXytW7Hbpmui53n9u3SJ+m15m1GoApHkbUnRkFZgtZMcs
         3WkEva8l6v0O9C3zfV5IGi4wJeffBqOnRju0EN6bcOTLhv+3c08i1BPR5yuXXNzZuLFY
         tofZla85I6UkGrMJuGKZMAZCD+DBt3v6/OhAAtFruqwrHAsI17/0H8lKvWhv81wjN7hQ
         p8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392766; x=1760997566;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23XrKSkwxbp0+ytZe5SlamLC8Looj3Q06ptlevOZYsI=;
        b=V/g7dp0lOdwZUzrsnTp3R4tJ7THAhPo3jdmH4M4ebnKUrmNB4PfB8ZmLHSXvFxQ1no
         XWoBmt0FJpf+FKnNX14N/MqdF9OLaVpUhYWXdScg2qdas0CjOTvHAikA1SRdwBnCtpYU
         kQOE51Ar7jlbskt4Fyx2bXhX67CT/lFGFn6eTMmoUfFgRzbvP9Crx0zGpBDoFE0ueA2S
         pExVQ2+Vy7KLTlI8+RyyvizRk561+nYOCK5/MwbgDdQPU9YchdqDjIoXs+0psHv9bQkZ
         9OlBL3Ar/74nAB73HRvHOx5Ij4htn54U0c6d5tkJKnWZzc5zM8n8R3MNFwg9ICFRF+CQ
         X0OA==
X-Gm-Message-State: AOJu0Yz1dfq3+7VuYo6GN7HRlhNpEEzGZz9GIrukXzF5GDdvKuXvV+Li
	ONxqeuJ7HBakHd6X8ExKYiXLZT8lh0TUpLqRKwDQqiqFABSEs9rcUHgjl3T5zw==
X-Gm-Gg: ASbGncvnGIuoddC8Tx8kFH2Ixt5O+HuaaL5KKLhrjN8cMwgtnkUUxO7aUpPh4P+RzJM
	mMQ+xAiQbtqv3y3CveXTc+PeUpjGaGSrAf8c5jfiy9vDLWnB7eHDc6MweeuIbLC/0CfTdsHxrSf
	c4R6dndyrz7MXLxH5UU/c/Mq1t8OoUHCoJ4w1BKP8+wzt3ROhU5dF/uZoPvqUI7QuPHU06BAqWr
	0FfGePkv/eLcq9WawUbH6eCfud++dqpClWzrx0r010izLlPeBXwI2z11pHe6MuTmoydIv86Olqm
	+fr/5sz8YkyU92XSGpqbZprz3EBeV8Gfd5qA410xFj2kOvv3z5L47kBymibQuGp9QD9xlJ7p50u
	ytCNIJcBfXqnd/uesO7Qrf6AQbMI0x+bAohKi2J/pVsUmiJfV11+XtTc3zJ9IpZRGRn6NZijQc/
	Xr7w==
X-Google-Smtp-Source: AGHT+IHOPova8MYxWiNtswxB31n0N2aNpKTFRZUalIjokLqcyfxSWch1JL37GvTRjX9kijqqnaCahA==
X-Received: by 2002:a05:6000:2506:b0:3e9:978e:48fd with SMTP id ffacd0b85a97d-42666ab88fbmr13928677f8f.23.1760392766473;
        Mon, 13 Oct 2025 14:59:26 -0700 (PDT)
Received: from smtpclient.apple ([2a01:4b00:ae1d:6000:b8c0:b80:af84:2374])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d3desm20412887f8f.7.2025.10.13.14.59.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 14:59:25 -0700 (PDT)
From: Samer Abdallah <samer.abdallah.00@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: I still use git whatchanged
Message-Id: <EBCAE8A8-E556-4DE9-9B76-EA4C27EECA01@gmail.com>
Date: Mon, 13 Oct 2025 22:59:15 +0100
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6)

Hello,
I still use git whatchanged.
Thank you.
Samer 
