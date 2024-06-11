Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4875176223
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109397; cv=none; b=UoH3Bj2kBpm0yYNlEWcRVZPBEXx3JH9Q1+SPT5RzDZGf0r3BEkrE7Id/df9g/f2CrAHxkDcypejBXFHE+S9ikiFQKSbXd7vmR3KmwzfLOeCMNekglZ33OufoDTYKukyzVwo27Y3pBtUQltsyET70wbsIg4EntEx+flISzIigcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109397; c=relaxed/simple;
	bh=5r2Iss27KqGj3Mfy83paAn9ClX2EdfqrjvpjrkcSMg4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GKzQPaBrOpbrCZYid5pGYTBaQ6XJTv2h1Vctx5JZdeRchLCsJerkBIXBeDNLIDUm+whu8mizhzWpxoSSsLFYZx2ERPvr63rPOn6RQbM1dQl9gDrQrTfvblBrM99BQBTk8h9G9fd4DVY3Bc375al/xw3rY6BBdIP4n9hXjV4qrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXStjdtJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXStjdtJ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c19bba897bso4575150a91.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718109395; x=1718714195; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5r2Iss27KqGj3Mfy83paAn9ClX2EdfqrjvpjrkcSMg4=;
        b=OXStjdtJpDQVIDlJZowaPh5wZAjF31Ue0Z8GlX9RoXt52/ihZB8QGNHnUu+BaWSBcb
         zdgo2Xikw06MrWmUjD/WbgDKKiy9AYhBWotpZH5z5mnUO4lMHNQw84vOtnSMUXRmT/vE
         PJpGrHQ+Zpx9KDuV/U6WC2/bjrSCXHbyJ9GLzsevCFSj2Ik+hctZ6VTus67AH2z7wCcU
         tIjsLaRG7IK1GnRh1u0HarFG01iXG7+3n4a3iA8y6j5OcWMeu7lF8Qxg5J4e+FV+zTMl
         T4IuCb3Xns/t8S+vNbiJFZ+8Ofr+zIgMYVLcINvBxUHxxstSl6grePtrHVF+SzZPCSly
         RC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718109395; x=1718714195;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5r2Iss27KqGj3Mfy83paAn9ClX2EdfqrjvpjrkcSMg4=;
        b=bDTF4/8gMgmmT7+i7mwB/TyxC4k1yDJfXJmO7kjCc4vXP7UIF9nILSDyX3aAg1lZw3
         rfPdMv3u3Na1O8Jb7MpjN9pNcBYF676+BUbFU4XoxPJiorZ48vc3DGETSf3VlGuJjPSo
         rwoBcyZ4SzO2KnONF/2v4gk+XeO9ZGIOG96M3BkJXvgkGHsU0boLqMyxSTrz5pV6FZpT
         mpbXNc6++rs3tKAlfz2lCSvG3wd3ra8cY11p07qkbBOzFM8H5b/uHLXiajg/6qMGpX1R
         KFm7KBLEWVeq803USrjzLVcPXZ7ziY81olzuge+ikI3UizcNjq/ZPaMz4P9mBRclAGv2
         dRzg==
X-Gm-Message-State: AOJu0Yy8EyX8o3J51kGSOaQxnendAok+kJB08Jy6aBkUTeTEiJ45R3Jq
	8E1r7PVJ58pxZGfmeLnPYij7ivDQzommCcSk3qAlxhBP8RFe840alS5jc4l7
X-Google-Smtp-Source: AGHT+IGD9BQcTHN1GJ9ji0V0rZ4aOtqS0eCcKO70UU4opwXVgkpWzSYEdx1xlsul3sHnw9wIpaH1jA==
X-Received: by 2002:a17:90a:d34e:b0:2b4:b306:ffbc with SMTP id 98e67ed59e1d1-2c2bcb023cbmr10244164a91.17.1718109394854;
        Tue, 11 Jun 2024 05:36:34 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28067d5acsm12304868a91.34.2024.06.11.05.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:36:34 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:06:32 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] Blog: Move existing tests to a unit testing framework
Message-ID: <uhysopkwfeucsptx4n2jgase2duqhckcgujiyobqd3xw6ioez3@wv2vpethsjre>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey everyone,

I am currently a GSoC mentee contributing to Git. My blog posts
about week 2 of my project 'Move existing tests to a unit testing
framework' can be seen here[1].

Previous blog posts can be seen here[2]. I will update this thread
fortnightly about new posts. If you have any feedback about my posts
you can mail me or join the shared slack channel (to get the invite to
the slack channel, you can contact Christian).

Thanks.

[1]: https://spectre10.github.io/posts/gsoc_week2/
[2]: https://spectre10.github.io/posts/
