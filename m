Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889562072C1
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266075; cv=none; b=tmi9wWTYVxYRw1lCmCPXXddLs5Zi7+X2mDpJwg7LB5yPBWjrNdGHXWZWPK5bLowyJHZgDeELXwttgM4kxmVfGJ90mYq+qPcN1IZyvGZ6gvI2oQiH0cIusfGT/ciXDgMBEOYvUArNH6EQA8mfJ/D3qDKMYeeg3gYcDyoEET0v3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266075; c=relaxed/simple;
	bh=Z9z5Di9MD8eAwpdgRhMHoxELHVfXsjDpGmveAkbDaSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tUS4rjVEJW7+zZN/IA1T21KSqTzeiPLPiDln6GaXzDASp7P4xjlVi+7vGLdzp6bBwysiVFtIyQODgRXvQgJ90tkP0qr4c+nM/leyJXD6ZbMwtO90huzghwRZv1vMJ13nOifSby4rUqyxLQ4N9nnCkhOhTyGnI9v4FyaRu3c/Ym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxDeg6i2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxDeg6i2"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71afb729f24so1348372b3a.0
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 05:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727266074; x=1727870874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UpHDd+iX/PoL6vw4gwqTcjtwFvunx5XxhOCNDO9stbc=;
        b=KxDeg6i2x3zJllJQNCkNzT6wwgzsEJPK0PKGsHUw7t1pphZPERunjSnsNKH8CilNET
         x55i20+yxMBZewyoXF/EwH+oykcL+nYFHswW4wGeFtR9gU1HJyUcFcWL1lYzL/jo7r1j
         wvWn528fowYs1lyj28yUdsxbiKQeCN7whQNsb+D117YiiWo9azuMp1DfPhvh6Sd+5to6
         2yb0cUEA+utlZkCuqw6yC0/faXsMI9M1QUbgIjErPFfCtb5HQPBBvHnUfb7h+K3eGTpF
         FvGpW2HCZB0+gz4VkovI7yQi1zTnn0ZHhXONqjNdtenRZe8+QLXd0f8rtmW2viROmfyl
         JAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727266074; x=1727870874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpHDd+iX/PoL6vw4gwqTcjtwFvunx5XxhOCNDO9stbc=;
        b=X7EHV3T8CM5pYPdpWGKjEgaCZfFRPuzWp0xUNQCj6DE/M9KKPJTHlL8cQSxP9XytHB
         HNA+Sd0OZVKXAhtRKbc0iY8l/AcEG88z7+UgBqrhbImxyHdj2iRztM17CvUNp3SmQLpo
         EBvKSiqVW86pi8Ket97Ooh/RWdEqS58t6Tw1XOLp8st9YM2kuNUi1TOyiKroiT7dfHm6
         nAHmeHtaraIpKEtumwfEzplcLZOBgw10p1MIn8TDoOGgRry/vU1AzhSIA4Y0mIRGnbkc
         CFof0PTDdbRAZ9S1NRGmZGkcwh2n501uk8jU2UTd6v1OeOoGP/G4Wg1GAAFEzasKExRX
         XmfA==
X-Gm-Message-State: AOJu0YytL2xVXokFqw0fM4sOFxZC++6nJHSkt6Ehw6+B4WTZjZvc6Fef
	IDfxwWWcvoCEmlVVzclPjnFpMhkhRC1G8UbDUvy3NT1RscPS7VKLKRnpTg==
X-Google-Smtp-Source: AGHT+IHGB9bkrkZ9U1YFF9QVy/Nhks/Y9F3CH8DPNV7ITQ6IlMpD7rVV5H5MKPlKlDvPB85Q02BUTg==
X-Received: by 2002:a05:6a20:8409:b0:1d4:e63a:1b2 with SMTP id adf61e73a8af0-1d4e63a0213mr1527968637.5.1727266073596;
        Wed, 25 Sep 2024 05:07:53 -0700 (PDT)
Received: from thunderbird.smith.home (ip70-162-122-51.ph.ph.cox.net. [70.162.122.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc844e3bsm2648908b3a.76.2024.09.25.05.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:07:53 -0700 (PDT)
Received: from thunderbird.localnet (localhost [127.0.0.1])
	by thunderbird.smith.home (Postfix) with ESMTPS id 595B31960236;
	Wed, 25 Sep 2024 05:07:52 -0700 (MST)
From: "Stephen P. Smith" <ishchis2@gmail.com>
To: git@vger.kernel.org
Cc: "Stephen P. Smith" <ishchis2@gmail.com>
Subject: Can a note be pushed to origin?
Date: Wed, 25 Sep 2024 05:07:52 -0700
Message-ID: <4962148.31r3eYUQgx@thunderbird>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

In a project that I am working on, some metadata is currently embedded in some 
source files.  The question was asked yesterday if there is a way to move that 
metadata a git specific file and link it to the source file or commit.

I remembered that git has notes which can be used to add such data to a 
commit, but I don't believe that such metadata gets pushed to origin nor 
fetched from origin but another user.  

Is there a currently implemented way to do something like this?



