Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1F1AC44F
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888322; cv=none; b=D34sDKdOZ0cVsjNztBT9JcDdg+rbiiukd8bBYoNw0HL7mUYO+8tUz5bXMugL97hkI5lPH8eDHOMGRjrOYdHqLUdmM0zdZJuwLKfIE3NZCf91b9Pvxn0xklNhPqG6u6lUffg74q6Sie0AvUpYJgWret5pLT4y/Dby8NGRB4XpdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888322; c=relaxed/simple;
	bh=QVmy/F1x7ToOmjii3tn8PboeI+hIDnjyR99ju+Z0GAw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=if2hKpfCVTW58sjUx/Tff1k+S+sX2i6BPvrbDEZ4VybU5R26nyBqrWXqdKhtZh5MSOpGqwVRhz1U+wVEm0MygPUV4aJhB47sKGPYFl0jocsZtdjMleNo/aTa4gLFmx6AJ2Fmri9nslRLIIdFO0YBniZP2ftQ5vx2adfTRPJp1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb1MEErh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb1MEErh"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so8724315e9.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718888319; x=1719493119; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QVmy/F1x7ToOmjii3tn8PboeI+hIDnjyR99ju+Z0GAw=;
        b=eb1MEErhNbDUJwJXh8JWWk46ctX/MX7nzTuOZo2YeVFsioLBVLVe+hwkV+4z/VshIT
         FX5ygv11F3PLMOp62ORYy/9s7v1ydkfdbBuHS/KRV/QBUuXqBGfyYNfji3D0S2RM1mhA
         7b/pMkMMn96UX5Z/WcvB0lWTxHgvbj/5TooYoqIXfbnO6l/CRFU16PGtqtfXVUVN0l+O
         qD5QPCtjTmRlB/oYAgmUY/yS0ZWOzFkuJOlHfDGlFHpeBCyMBsoVHaa9BL1uvPCWGmUc
         r6ycQHgssrDWhxTHlDLHbTVp0wN3JOqLr7t3hiCq5UVW7xSiYeFW5mU2oIDsmwTS+jI5
         ASqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718888319; x=1719493119;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVmy/F1x7ToOmjii3tn8PboeI+hIDnjyR99ju+Z0GAw=;
        b=kc0z1wV+TxjB7fdCTsDdgX1J3TrRtmM9Vh5FZVMf6FrFcVe36ORMBZymR3IhCy8NG4
         td9DtaL7SIMwdCvY73/lqfs3EEMO3gui489h4c6StnPi3WAJivefwrlysrIYOQwoRSk7
         rYQBwey1Da4dZDQkW6fYosmL2aw/xexVTA+2zspyOljPSmHTXRr9cHYyypvjikbvyWBd
         iJky4eo6xCU1LlDfmbXCdc5g9T00PCiv1In5FWasDKRQpeIp91fOVo+O7eF1OtzN2QlK
         OS7gwf8oFu7URpWX76SywlfCZHEHXfcPnuPkvQLdnS3vu53gY4cmcGVtrSiYljtaZsrw
         MaCw==
X-Gm-Message-State: AOJu0Yw+p9VGeeQ76qt9ofkzcg8Omu9OVtdP3c6YZMotwEVsLTS9GXoM
	7pXZLtS7dmQ64PlZIeYqIjO3q9imWFaao/IiBdNK3cm3gTNmQ4aY8wZUSkMjCW3C9HM5jAAA9/D
	YruxddKtXrnrmJHfOluPJ6toMiubPycRU
X-Google-Smtp-Source: AGHT+IGtWfOjDLWm2cZic0b04VHalnCXxK9TsjxMgkG4j62iZUt+lGnB2O4UMBvlL77Aqt10DlIQfVcmXpt/sXVRvuQ=
X-Received: by 2002:a05:600c:2106:b0:422:e7e8:588a with SMTP id
 5b1f17b1804b1-424751763ddmr40588705e9.16.1718888318513; Thu, 20 Jun 2024
 05:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Clement Sello Tsetsa <clementsellotsetsa@gmail.com>
Date: Thu, 20 Jun 2024 14:58:27 +0200
Message-ID: <CAOqo0cWd5BK5zAgMmsWPYFuWscLvuOq0Gq_a5PH-oXJoGrPb_w@mail.gmail.com>
Subject: Feature Request
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings;

My name is Clement and I am a second year student at NWU university in
South Africa studying towards a bachelor's degree in information
technology, i just recently learned about Git and it is a fascinating
piece of technology. This is my first time making a feature request
for anything and please excuse me if it is not up to your standards in
any way. Please read the below text as it is the feature request:

When initializing a Git repository, allow specifying file types to
track using the command git init <file>. If no file type is specified,
Git should track all file types by default. Additionally,
automatically create the .gitignore file during initialization, and as
new file types are created, add them to the ignore list. Later, when
adding files to the staging environment, Git will already know which
types to include or ignore using the git add <file> command.

I think the user should not have to create the .gitignore file in the
future if this is implementable.

Kind regards
CS Tsetsa
