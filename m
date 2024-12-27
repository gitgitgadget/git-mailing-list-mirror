Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCC1F37B3
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735306802; cv=none; b=UKoOM3SDMjcmVfuwUK4+pdM1G4/r6oQ4tOkEBrwZq/BszbIoBsBoC0+JVMCMFmB7vvlLpujrN+OeAY1YYFjqyDRt5AM3Q4tT+448XuzAxXoib3InFwyGvgWjK0MBECmuUtI2aCdczBJAB26t3af4wxzIE2fDpYj4iWk7Pj8D948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735306802; c=relaxed/simple;
	bh=pm+hUGfek0gu93Nnz39bPvhl42H2el86LyEaRDRrJMo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gOnkouB+VeWkv5yh0/yK6MXsfFQJwOqhEL3PqJ/5UNsj131uP5gBJXSvmFzSpo0Cgl8wCTb/wkqdMDm6mTsQGfucQ2OstdJglFGkjheDyd8suNjCDr5LoJ7j6ATZMufxqUU3U62E5OGPrZEel8rzm8OSf4PdQ2hUMVVrhJmsaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYNQaCRM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYNQaCRM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21628b3fe7dso84358125ad.3
        for <git@vger.kernel.org>; Fri, 27 Dec 2024 05:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735306798; x=1735911598; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKxzCsyKsZLSZGSGHHFlQR156CG3H2dHn0fjWDE11O0=;
        b=FYNQaCRMFWmn2dkFnEtblvfxk9Mdki9orizifOOccnnIACN3AKgcwJ2eZjSzZy5jAh
         ffAhOd9979MXR4eu3KcQhpT8zo6c+5Rehd8QGZA7XipVp6I7FTkj+GIVbyfAeI4b1SSq
         rhRkCgU/2nh3KYWy3H5+N+T75xiY6bDDUtQg0kHT5Lr65W8nIghQWEyGAx/QZCYFroig
         G5Hd2iDM0M0yNJdkl9PbsF25pZ8yKSrJ6Vyr6Z387EEW35Rdi7blVIkLfEwdVFFnCiNO
         aTP9NK2bDmWVcr6OLNtmWtNl2e1M3sTK6thTEULe75Z++C+/8o5XI3CMuePXdsWIYGt1
         YrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735306798; x=1735911598;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKxzCsyKsZLSZGSGHHFlQR156CG3H2dHn0fjWDE11O0=;
        b=ZWWfJSOORW/MSOcVkT9VX5xZNiPAw++6uIOKalmTpWY8tJQZ7c8KWASxXQa7PW5U26
         UQQ/FwZ89eXc+mwDi1ptvvVpd4quKzjHGAgwOJpwX7JN8Nyhg475yLcQcytWOn336PRP
         wvimz19pQW8EJdfTiwr/L8Ia2oxWtvyCDGf7iNzULw08fzQ734OPS+YJ1+E05tCPGqRk
         FMYp00dDB2QgZHZnIE3j8/9miZmMb99GVbpvmwy1QODAcJSrGQL525cGJEnw4E99yoSJ
         SfpbEXkJPP7tgT9LQsL9N1TXbzCqcxPqfCpHnY9hqUtgVVqD15tDRzGgmDwVV75bOxBu
         f6mg==
X-Gm-Message-State: AOJu0YwgcdJHrz95VLUxc3KClqrBxi2ecSauXNQ9WzX+mKjmp0YcxJvT
	kuiaqq/17gNcSQEkYzo8qoQ19YnI5BRau70FPhn1CxrAxflGQmz2p3bMWQ==
X-Gm-Gg: ASbGnctprFifE1yfgvkeYJHha43sfabKhtf7bXwwQaWDgQFuJF+ts561HMwv4H+OjqD
	bNHVFqT8lB2ACkh4q0O9zC4/gkIf61uPd3vpZI6VOkZ7t9fym3dttsXtBwoO2pfI9V6UN7lGkIs
	ufWRMEFLt/kmQup5aBo8pnCuOKfYM7UpImkYWJTXjaw+gncN3aYq6hWLJR7Tcu6nevkfU6+WhXb
	aJFkIblcM10pBw+Uh8WFtN1fAh6/lNbIBD0l0EcNMr1RevhRkPf
X-Google-Smtp-Source: AGHT+IEj/pwIyOhsCZkcPQPf5KDCMjYe6YtDhBHEVgbgi7/bxJqDmQxJys1Yce9lkWA2idTmqHWKsA==
X-Received: by 2002:a17:902:c947:b0:20c:9821:6998 with SMTP id d9443c01a7336-219e6e858b4mr339285365ad.10.1735306796844;
        Fri, 27 Dec 2024 05:39:56 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca025d1sm135301295ad.254.2024.12.27.05.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 05:39:56 -0800 (PST)
Date: Fri, 27 Dec 2024 21:40:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/1] ref: add object check for regular ref
Message-ID: <Z26uXy31q83dyxvD@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All:

When I implement the code for packed ref content checks, I somehow
notice that I ignore checks for the object. In the first glance, I think
I could make this patch in the first of my packed ref content check
series. However, this is not a good idea which may cause the reviewers
more overhead.

And this patch aims at checking whether the object exists and whether
the type of the object is correct.

Thanks,
Jialuo

shejialuo (1):
  ref: add object check for regular ref

 refs/files-backend.c     | 50 ++++++++++++++++++++++++++++--------
 t/t0602-reffiles-fsck.sh | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 10 deletions(-)

-- 
2.47.1

