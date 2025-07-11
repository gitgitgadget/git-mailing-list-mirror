Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AA17A2EB
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246262; cv=none; b=tCStX66L1ueasth801l3P5RAdIo4yXpsanyqU7mnHPUVCEdpf8ueAWwUxydldltMYPWueRXaDPFHWWXw2E3Bw4ZtwhpegdNugXOeh7bIg4wdNdBOmCV6CY1/P1KNyfWqkOhc52kKrdyKRVz0SodF6+HXYvkAeVWgta4GAZlqSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246262; c=relaxed/simple;
	bh=+yL+WWlfwR1/l5JEJwq0PDi7OgFhi3oNo88ClFDr0Pg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sFsjkFSWG0Dr8H4ApFA0/fD/XUv6GNxEhG0gRwBk870QZL2UflRTvGv3m09Okv/nuKgSFBaAs/JWZ2SiOsgIjsd7dzT5tzR7rH/RxdfeAOgy4dKhY6Ku/Y33ZLrBkpjBT+CCSigMD/8cDXxLX1Nszg9/cVAKQEUFmZev0gI1efs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macarthur.io; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=macarthur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-714066c7bbbso23073687b3.3
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 08:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752246259; x=1752851059;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/WPjHLd6Mdq4N1bnC7Na9ZJ7aFIztidZzWoszka6Hk=;
        b=PN0l/HdJqsKN5UqY+awdw6WzRrHMOV2OCquFbIO6/W3ZUHIgt7yT1hMflpgK/f2xTZ
         TrQEhBdQthvlt3JwZsNbBOQQyL8wCTC9hO93H6gQyFILG2QY1Fn/LLcDvs1CNcYEe9fz
         kCW7BDSl7rVRq2myUrHcIgbJg+wr3qo01n17ZDchEis0zTkZMRPBzUw5JdXTrFA+NOt1
         tg/jsN1rjp3FSZoCaVatDmvSjqa+8qcg0B92DYgsg8VBS9TGpw4VWg7V+9gfGbNR/QwU
         m/e1/x9amtzFHae0wOHpaWwMzWkIsgnbkac1iJd3ZqW/L2cXk4P+G3WIyoYYoXEDuE3t
         QqYg==
X-Gm-Message-State: AOJu0Yxy00fVKhFxCJMB1CmtkFtmjjuKv6AZ7GLWXYPdtgaYB1s9ByGt
	zKvMDSL9nOlleTLZ9IobpX3RBFzhh2M884tjBxaK76Rknzb0B9zYzCR8qDNHarl0+GE=
X-Gm-Gg: ASbGncudjhpt5bb0z/LeTtzcDtvUwu6PB10TylKk8MJf455/ynfb0jPr8akbQG4kndX
	EyBG45Q2Olut+LO51SCCRMvrOgzUDaUyY6LKCxkc9b0KrBoz5Nie3fRDKgoi0mHbfmTj6um1Bzh
	utZ1hUrlDIwzNi3MbIIs9WqWnebCVDa3mgry2d7ivu04O1+aUWZTXq3VSUte5x9kt6rmsOcJ0iP
	haK79ALOVlV/dHIjpmnvxdZGuszBK0vStJBjc6yo7RP43UoiXun2LX2aJo6bgayTlGOAyE0Ng/m
	zseYB9OIBKGffqQ+kz7cNrmAOcuvqdnrL+au7sjumbcikkyMCmh4nkB+nNIXGHrCaoGeGKm5Y/9
	Hgz2tUQOD7ABMHlCJqc6JwjosU19SKZI7D8Rt6Ma59zvqjpJa72Bkf4neD9Xy
X-Google-Smtp-Source: AGHT+IHN8XZmEU4Pyuo02Hac4issAPCc7xnFVYAbBCMVpq+nQ2FerTt4o+X9aspwInG6kmP0xs+Jhw==
X-Received: by 2002:a05:690c:296:b0:70c:8f0c:f923 with SMTP id 00721157ae682-717d5dc93b9mr59467257b3.18.1752246259439;
        Fri, 11 Jul 2025 08:04:19 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d753absm7813017b3.45.2025.07.11.08.04.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 08:04:19 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-714066c7bbbso23073527b3.3
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 08:04:19 -0700 (PDT)
X-Received: by 2002:a05:690c:3581:b0:714:250:833a with SMTP id
 00721157ae682-717d5e0ed24mr64047247b3.27.1752246258786; Fri, 11 Jul 2025
 08:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ross MacArthur <ross@macarthur.io>
Date: Fri, 11 Jul 2025 17:04:02 +0200
X-Gmail-Original-Message-ID: <CAF1X4d7N1xdZt9JkVZytbEU1=7q3X_F_nqm4EG82B8-cVa7g8Q@mail.gmail.com>
X-Gm-Features: Ac12FXyLuHq4wksISD7Tf5HPPKG-cJC7vtXXIYTHp6h0pGwi2s2yQdd-8x-X5a4
Message-ID: <CAF1X4d7N1xdZt9JkVZytbEU1=7q3X_F_nqm4EG82B8-cVa7g8Q@mail.gmail.com>
Subject: [BUG] gpg.program: '~' not expanded to home directory
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

`gpg.program` treats a leading =E2=80=98~=E2=80=99 literally, unlike other =
path
options such as `core.excludesfile`.

Error:

    fatal: cannot exec '~/.local/bin/mygpg': No such file or directory

Reproducer:

    ln -s "$(command -v gpg)" ~/.local/bin/mygpg
    git config gpg.program '~/.local/bin/mygpg'
    git commit -S -m "test"   # fails as above

Expected: Git should expand =E2=80=98~=E2=80=99 to $HOME.
Work-around: have to use an absolute path
