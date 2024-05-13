Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90584D07
	for <git@vger.kernel.org>; Mon, 13 May 2024 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641876; cv=none; b=iICASRQZdvIHEsSkD3ugrnjhieKFVJRotFfHR2WtnEDcJ3zceS4NNnA7bYuS1cZf+0sNIaL3wdWd1L4lSjofPN5mP/12yCoWj+MWJf3HQCpti6kNv54pb94A5zyt8ItKR0eF1wl0YmDw3nYIY8dRJbYmZhjZBDfG9GUIOjyAFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641876; c=relaxed/simple;
	bh=WVM3d3SQ3jargknuSD9XomRy8OoIUlWu47Xd4pUnVjU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BoY+8X2mTA+oAgeF3EdIclFhU6FKIL8MwlUDJtWdH037BG95uPpep3XAddW59xCxBE/VfJhtg9IW0FOg2LoylMc77IOYNfTx+FFpR+VgLoSo7kRcms1codctww4JwsjuPunkU/kSZOfCTuraV1h6Henje3ZjsnyD048S8zdYa9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TABwQV5g; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TABwQV5g"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ed904c2280so25639415ad.2
        for <git@vger.kernel.org>; Mon, 13 May 2024 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715641873; x=1716246673; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iGGRriEjLnaP+wfTq6Vesdygr3mO2PMmCfJznQGMEMc=;
        b=TABwQV5gBOR6XfS1dy8XhQL4EW74bXdjOrReiE+j0EaQZM13QY7Fy5DHB8SfUigtMQ
         qSeTS/R4ucXV+s0QSUMD6n3nvoWfa+mnkfcq6FHcHy9KmGLAUgtO35QGiSj8Be+2/oCi
         2hkJ//FDgNr9TWRBASPYMcEmETmRwGFsrxzNMXnKydrkesZ9v5js4E0IJSDtGkrnhRTf
         Ty7P7C5oFJrnBHt6JK6/n7qGTN6bmqq7zRPheHp+bd/hSqfEuac/skg69XHwV115rW6N
         qmS0H+Lbh50h6sqwBScsG1LOzvQ96wStJ52s0efmuvxxeLB32aJbgNpCRhaYiqW3JPly
         NSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715641873; x=1716246673;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGGRriEjLnaP+wfTq6Vesdygr3mO2PMmCfJznQGMEMc=;
        b=JavG90Puc77ibrhX/OxzG+cMKqtMs3+2h+12DYC+WvwrfkC3aaY4+x44/geP5X8cf/
         gnPhnvuwNHyo+XLGl0UrHGRLK0s6n9FzH1L/jiHPTRXDcm56IBPPgd2v3l7yhx+yhyVs
         8ikYsOrBfg+F6f35tHNL18PrrEPqFGhyfcaqlkMZroox4TC2tdmIckb4/tDhXSD0/Rs5
         M6RgOHTh0ZVgkaBTiWCSvAJAdDpV0GIC++zXzY5eBA/evILDKldDkigI/uMUixpYpsYJ
         VQOP6vFyEqgu2kuTFWdzo05RtO1PQUkGUCe8v2vUh8g0irgQp5Jjdf0HrwomEvuINxhj
         yPmQ==
X-Gm-Message-State: AOJu0Yx5RhOPlZXnlu99mNFFhtnmKhB4FxCAzrCN+qURh5pkT6R9p6B1
	615D44OZoY+c+e1yW28Oc76eLMEbaCKSrusl2SLfOn8d1gN2j6anB2qoCDQtXLXSpwHdrTorczz
	+KWICv3YTxjOMlrTeGsgbMxy2aekQMoYI
X-Google-Smtp-Source: AGHT+IEp6HUYEmTkEYG86aTo2Dxhbv+uadgRMaNhZfISBQxyEVIKLEhd5wq7tZVRjX439/Xfa8mKRZZP+PDkrX6swmY=
X-Received: by 2002:a17:902:db04:b0:1e5:9da5:a799 with SMTP id
 d9443c01a7336-1ef43c0cf1fmr137571545ad.6.1715641873323; Mon, 13 May 2024
 16:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Sanderson <yelliott@gmail.com>
Date: Mon, 13 May 2024 19:11:00 -0400
Message-ID: <CAC-6ESEfnjK1ubrzoAfUsegM55e55uKugCPSfxnBC607dmZJRA@mail.gmail.com>
Subject: git pull --prune --prune-tags yields a usage error In 2.45.0
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I noticed that "git help pull"  mentioned the flag --prune-tags in
conjunction with --prune, but actually supplying this flag to
"git pull" results in a usage error.  For instance, the command
"git pull --prune --prune-tags" fails with a usage error.  I would
have expected that this would work, since it works with "git fetch".

I could use "git fetch --prune --prune-tags" as I expected, and
"git help fetch" does describe --prune-tags on its own as well as
in the help for --prune.

I confirmed that this behavior still exists in git version 2.45.0.

David Sanderson
