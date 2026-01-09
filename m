Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CFA29AB1A
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 03:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767930643; cv=none; b=PquwlTMcCbBNVU7tN3ibfwr4hkaXVjtw9YpD7x2LYJzmrk9r5f0zlEVyyxe7o89q7U9Bsiw6qhJnKu7W/ABG/Wocpz9RouJ9q1PQtR9w7KubcA+7pxssUC6VCdrtxcyoK1wGqgx7NOWrIX13jTEX9F/Cn+P+EkT+ACFVFGFeOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767930643; c=relaxed/simple;
	bh=8znyw/lKBB+Oy71fJVFdx/zPokg48u1Mc3NR4QhOCfI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cQ70b0bQEAzZcgh9Kd6OYahMWxwOeW67jTY9lBkcgAMaY0UxG5WycARV+rBLWcPbQo578r99h0NIe/Tj1OR4VjqH27SHlSDXQh0JSFiY+SolPR5ySixHzS5wG3mUj4uUdF0Ge/MfoN9I54bgOHztkHCqCMqGzbb9Ug1G9qt5pl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Inu/X+m0; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inu/X+m0"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5635f3eff8aso356521e0c.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 19:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767930641; x=1768535441; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8znyw/lKBB+Oy71fJVFdx/zPokg48u1Mc3NR4QhOCfI=;
        b=Inu/X+m0SsVKRijiUh6kIjhj8nqDv0wIZfE1TUHLg8LMqcziCjBgVv5CPWOkpy9Txd
         qcebejaaLIZxX1FEIZVsJaM3vVOn4+wSsalWlvxwdifb7Vg+T6bOB6tdVfsDobv/62cM
         yeag99vYrzYkMhCu7B0/BCynu2zzqEv5A3CML/69NqAxrGJ+ulrn84i0fNOjMj+/RKBE
         jrAsJTdjC/xaESdMoHG/+KZmvV8ISuZvcwVtQRY+OB3yuv6kfZIlucDWxZ6MKbGXxVcE
         56Ef3MHSEWFaTQh/+fSNWmuTLGROcqeRjInYPOYeUdWoiNRb+aDCMfYCAvgZSDCTMe7n
         DBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767930641; x=1768535441;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8znyw/lKBB+Oy71fJVFdx/zPokg48u1Mc3NR4QhOCfI=;
        b=tPBj6wuXPlOaQUAq41AEV21KIWaMLjPROS54SDcejg04lS2wnSKFxomKJ2P0L9RClF
         /P4uohMukYSqFsPV+r9FRyssp+9oB6RYTovp2HT1B770+J3ihherD7e8h5q7w5wUisT1
         y4ZP7OD7siNuAN6Om6rAlH4Tl+Vqj2wJOSV/2/27L6MsgZb1F7NBR7HQ3hQZleN35DNj
         ql1Mul3gHb4EekSDyb7F7sGA2K8G48KsDvOeaZMuWDRyQmtTE/mgoCVU8D9DAuT2ailZ
         DngpwEN4xx0mWoq6lhYQcX9jL/mM/InIm8pe6kcZBENqlEmOFx8UAWnbYn8AcD3JvDek
         GiYQ==
X-Gm-Message-State: AOJu0YyJLVEnXbA8MeXti/9dShjLvzH8P6ZuNgrPDDK91FtKMigVv6hi
	pmXqFWmyV+9qWwCT/pvXlrb6zJSxFbxxfXjVNVJtifeRne0Ycyypt6NWPc/FNOMJCa8OgZo30xE
	msv3trlJpE1FpMdLkH1794pqkw68NGhRmAgg3
X-Gm-Gg: AY/fxX7Mz7PWk32gJwxpZYiu9FpV25GKPEhQaCG7OlRjHq9DY/eV+5J3CJUlx8JISUn
	SjValWC5gHb1OCjHP74qzyT3796m7yMR7LxpCEgKZoHNSF+UQ/VWWw0/PdblU6GKvz+lHw9hnDe
	/NmJeJzz3wMOr1NTgYSjczPL2qekN85uxD4oCaEF51SJPP4OTAR6Bh4RuxTP/8WX2Q7XRLqjSQ3
	aCny7WYVehBF1mw4h9CTbt85CGVW0qfHBKPNvqpbfB/XBszNBgOx1eYqgsh4tEnHUFin00bYQ==
X-Google-Smtp-Source: AGHT+IGXAtVqHKjm5tUat1y/AOg8oJlKdulhdmMFK6WsQ7nZeUIKl0jqYqIL6poyyVRpmxJPrRniPqI5hvF2eebAYpk=
X-Received: by 2002:a05:6122:31a5:b0:559:70bc:ca54 with SMTP id
 71dfb90a1353d-56347fd1becmr2315226e0c.14.1767930640995; Thu, 08 Jan 2026
 19:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Simon Cheng <cyqsimon@gmail.com>
Date: Fri, 9 Jan 2026 11:50:30 +0800
X-Gm-Features: AQt7F2qziFBRHP-lG6hxuufCXCe2JUhLa-O3pHxrAP2hjgf685t5bgbMQyHjGf0
Message-ID: <CA+itcS3-RQ=ESqcWj0Pkw=N4e4gwaz2fp2xH2M1MPXQXaMDmCw@mail.gmail.com>
Subject: Feat. req.: add a flag to `git clean` to also remove ignored nested repositories
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, running `git clean -dxf` on a repository that includes
another repository under an ignored path would skip said repository:

$ git clean -dxf
Removing foo
Skipping repository ignored-path/repo
Removing bar

This is to request the addition of a new flag to allow altering this
behaviour, i.e. to make `git clean` remove those repositories too.

For me, this feature is relevant for building `*-git` packages from
the AUR, for example https://aur.archlinux.org/packages/paru-git. By
default `makepkg` would clone the source repo into `./src/NAME`, which
creates the aforementioned condition. Without such an option on `git
clean`, cleanup after build is rather complicated.

Thanks and regards,
Simon Cheng
