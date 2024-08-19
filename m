Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B124E15B111
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069714; cv=none; b=jeKgIJhrobHhHkIDc8E5wSRRrPs75LcfiqjBn4mwTw5Ni3bB+QusG8Zvekd+0Ud1uvaX0e5XEIaTiIu00GFPKhoUgVeQAT2zM2nz5tFPXvVvaensG1NJ2MVCvt29JQpiw+quAU8gBU7Bymf8E5IzXfSvoYDAusJJisWsDI+MlMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069714; c=relaxed/simple;
	bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=OBQKpPlgjIRM8i5GcrQuTOiDITl5ncV8x2cnSZGxQQi2Ns4I1/2RzDIHOrzpktKa3qA464vd7mBeCcB2OqHjl2TgnU4Hjc1vIgngOvFyjG6aawgvKsBpPudsg3dIKiAm2LnT01Z+2FvRCi9SCyPqTpGAzIVg5JTbB6QJSX1gYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue3dTbkJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue3dTbkJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2020e83eca1so21485365ad.2
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724069713; x=1724674513; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=Ue3dTbkJhPpdCvIFO+JR95fnrdk+gve73rMkXLLLIJZR0CWn41y1ImHKdpQHwU/UaF
         O7zFw9Wq20LHKK+bKlgssN0gr7LTxeuHnT13MkYMopeqoF4XCbHYXBwTcV83hf/SLmav
         cjKYgex1BLytaG/fdUPI1xwcdd6hMTm+RX4U5iDlwZvtdXQBj+mPC3s9cYTz7T+ovKWN
         QZzXJbD2y6TETkX1shdSh/0DTp7FiB/VNfrBecNb0zN4Xht9JuIrvuYLGmucFLqWo41/
         JQdcm4d98Ry5U6hMckSf3DGHBcgRBxdLmOPXuEakdLKUnkEZvkFtLOHeJ3JalXVxtYcG
         RZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069713; x=1724674513;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=dVkrIzsegUXnDDwbUjViM+1CRWeiLXQQdtzy1bzifxb0UnbFa8sxHf4aPAK89ZdOvK
         pSL52oSiuu7Z1HmydZIkXKpKkmjJVfvB6uJXoomaFrJKDVWRj1jj5VgYr4CkY5AK6Sms
         QByfEdv+Xfeirp5L33cqqaaxx7LqtqOUqyTteU3X39tA9i/7j5b5ZOC3qu7N+sftnLXO
         1nXcUI/L9QXJJl5ypSzpiCPDWFvsW2i2eifrVqS8siS/7N19cgxBunlk4FPX1P/q+qBX
         rd8JkAKEO2tg1QpHosH0KH0qWonxyaw2YWdUEHJ70s6foFrcAzZ9gmv6LSbCRnizeFic
         Nxog==
X-Gm-Message-State: AOJu0Yyp6ZszVMIyPymTC7olFj8JqfPPiMXzojdvNwk9NKIKqsiIe/w6
	uGovqJZicu07HBrYRx640iy6arwekb+xcQZUk4pgYLHgb439sY9O4RKRGw==
X-Google-Smtp-Source: AGHT+IFujNcDWjaMfUo34DlAMWBaUqzfFBLuzMjkhUqef5Zz0/X2NxvJeGxEzwHbboM5GFLmJCC3xA==
X-Received: by 2002:a17:902:ced2:b0:202:2ead:f93f with SMTP id d9443c01a7336-2022eadfc1dmr46809065ad.1.1724069712516;
        Mon, 19 Aug 2024 05:15:12 -0700 (PDT)
Received: from smtpclient.apple ([117.20.113.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03a1533sm61379515ad.272.2024.08.19.05.15.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 05:15:12 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: khmer song and funny clip 855 <limeangkonkhmer@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 19 Aug 2024 19:15:09 +0700
Subject: =?utf-8?Q?Hello_let=E2=80=99s_start?=
Message-Id: <C2009750-8973-4BFD-A967-6AA4F9542982@gmail.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (19H386)



Sent from my iPhone
