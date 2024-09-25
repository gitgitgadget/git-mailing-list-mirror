Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6D16DEB3
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267361; cv=none; b=KTFXcYfPJTtwKg2MARaM6OOVwwxGtdQmu900wTCFuDim2G2BOuwSxaJPkcYYSumdBlb6TBQkZuD0JzBFJlOaTzY89RQ5p3FnALjWW9b1XvTZdiPyRq8YWjxnnwoU/KP89L1xEKPyjQl58VinFsY0EYELncBDV/eM0pmReRDZHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267361; c=relaxed/simple;
	bh=Z9z5Di9MD8eAwpdgRhMHoxELHVfXsjDpGmveAkbDaSY=;
	h=To:Subject:MIME-Version:Content-Type:Message-Id:Date:From; b=OJTWOB9jQh60EX+NkinZJaXwvwknH43KBPHsPU2WnW1/kOkOJGyuA6S6QPUQT2pvIBvQKHmNrw+i30US0NemIpAyiT6D+XFucP4TCi+x4N57ISAuBlCFYZzsCX1foXwOOPJKfMjdQXC/tDqG67qRZRXOT7vTz0Myt4dSMdVyZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqTpkiqZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqTpkiqZ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e077a4b8c0so340923a91.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727267359; x=1727872159; darn=vger.kernel.org;
        h=from:date:message-id:content-transfer-encoding:mime-version:subject
         :to:from:to:cc:subject:date:message-id:reply-to;
        bh=UpHDd+iX/PoL6vw4gwqTcjtwFvunx5XxhOCNDO9stbc=;
        b=KqTpkiqZJLaKmzJGADNv+TMHDkUtjgHvbt/X4a+1Uz+bpki1JvHqrcbF5fBLh2L3se
         LmskdmgggsYSAjjFmZYUPu3i5bfDqhLtt96LzDRAuMV7sakOGx74C+O+AGg58UWRTnTU
         6hbD8DVz6GGCn5o5hGHrJfJLB7d+INhGN6J5Fnro/8bayKRVC3O+eYK+GnDhQz6Rm3Vf
         jD2Y9zpHDybxFpg7JIQvc95UlJyKg9hNVM0g/RW7UgmBWOvrFtgr/8DJf/bmE6lc/lBT
         EN4g3A0wI1mWmkCWqOuWVEihpOL410CJL/Y+Fb96MqtC6ZfK6hompov5ca7YgIddI3Mg
         j4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727267359; x=1727872159;
        h=from:date:message-id:content-transfer-encoding:mime-version:subject
         :to:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpHDd+iX/PoL6vw4gwqTcjtwFvunx5XxhOCNDO9stbc=;
        b=RDe7Nd35RTCSN95cfK4kYUTgWphFh3kK1LW1gfyd0cNh4LgHcaUo0y0o6qS/skHTg5
         32r/PLpDZjoRXwHsY7M0m5Ma8tMb0VCMA1j/DshH0EwWIm5t3B1Kt4B1HGeypxlZvuP7
         jVCzzp94DTDDTtJKgbDV7nlFrRkugooXqrp6V8lhw5HDdYQDY77Ar2EWeYR2j3v+6pSc
         N9MipvX6z26GbsYVdBojI+KkjU74sb88gMLFr87GcMZr+oRzlm6T9rZQpTguhfUguYMM
         jYsIQRttTtlhHLE4CYFI/BOHt4GJOIzi7h/CFuQPH/PxhpPKUfFycMjgCk6CkF6HkwqH
         y/2g==
X-Gm-Message-State: AOJu0YzD5moZgh9f3V37ZGy2TizYoEQdHutUbqiB3tWWCAv8PtWd4vT7
	OsMNj0LVBLw3GYDOFxgEI5z4+d+89A8eMs9JYSWAVI4xicm7cDVju+i9NQ==
X-Google-Smtp-Source: AGHT+IG22EzxPJNKcxr6mlN/raULdz+6Fnxb8eSTl36DY9oVcHZ/jBi55+LonZAoSxyjqoXFtsaaGw==
X-Received: by 2002:a17:90a:eb0f:b0:2d8:9fbe:6727 with SMTP id 98e67ed59e1d1-2e06aa9f061mr3806571a91.4.1727267359172;
        Wed, 25 Sep 2024 05:29:19 -0700 (PDT)
Received: from thunderbird.smith.home (ip70-162-122-51.ph.ph.cox.net. [70.162.122.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e2cebefsm1405536a91.55.2024.09.25.05.29.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:29:18 -0700 (PDT)
Received: by thunderbird.smith.home (Postfix, from userid 1000)
	id 1719619615FF; Wed, 25 Sep 2024 05:29:18 -0700 (MST)
To: git@vger.kernel.org
Subject: Can a note be pushed to origin?
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240925122918.1719619615FF@thunderbird.smith.home>
Date: Wed, 25 Sep 2024 05:29:18 -0700 (MST)
From: Stephen Steves Linda Smith <ishchis2@gmail.com>

In a project that I am working on, some metadata is currently embedded in some 
source files.  The question was asked yesterday if there is a way to move that 
metadata a git specific file and link it to the source file or commit.

I remembered that git has notes which can be used to add such data to a 
commit, but I don't believe that such metadata gets pushed to origin nor 
fetched from origin but another user.  

Is there a currently implemented way to do something like this?
