Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B62F30
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050684; cv=none; b=uIzj9UHGGksPF3LWBweHYzmREINbrj3s2tz9O9DKEFua+Dd7JticuHKdvbauSQm08uVD6skzJrD0fBDAHUmlZZBX0uyIiPuQD5A9JjjndpwRXeT2hOY4yuG0nJNXP5Ok9DOXXNeVt9f0iBllwf30vSDWZ6UO1BiJU1He/QiIjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050684; c=relaxed/simple;
	bh=ARBqxlQhaai5FgL9qw/W3EGksCJC1AEfbA+8oYjCSx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DhJgisw/Fu5oKNK9syDZ/oyEPi0moPfUkqhOB++6QZF0N1OmVs+gpOW00nZe5SU4BTDn2/27KleZK+m3TGxDXjdMwZVKmlZh31Wy3/0LrUgZVEFNzxsnrREKbZdl+vIJHmN+kwmsyo4U5mjgIvAw4AMIiE6XE30S3XmxkYeg8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lymYtr7e; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lymYtr7e"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso12776441fa.2
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 03:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726050680; x=1726655480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5A/Pr8uG6ljHivxT7ESJCWNKCIC5H/QwRSUaummtBJ4=;
        b=lymYtr7e+y4oLxMXH+IiZPxm+3RGs6ZIiSiud8MBnFDXs+u0GovHr7VxiJsoaKEAlM
         +m5v+UJikHxq8JvvZuZren9vtCqn9avxIANeQaREGqMpQMFPG92HmZsYSrQKC0mXp0mJ
         Z10OgcGDxbSwsdZqSLk4vZab2EdhXoFT824py+0n2Cytwq1M0DrEhgCXbumGLR5FBRoT
         yrHbt6fThEH1FQNOOwU5qZLrWf/lIBBY+Vqqm1pJYqR2RPN3GZ6M5W9+feLy5WXBPpj9
         HelwMojHW3WWSyLZPQQmepeaGWUVigj5zbI/pd5KT8dErTp8N4fLiSsGUFEypWmVLGFM
         V9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050680; x=1726655480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5A/Pr8uG6ljHivxT7ESJCWNKCIC5H/QwRSUaummtBJ4=;
        b=bbjXWXc3Did15NciDwta+SKbJBHCGwijGUa+PpBtvmlWnhM86UpxDuGc5h38wJly3Z
         iGpjUXi1DtgDUslNX8UMfovRuTjTQ2J0l7p0A6AZ0m/StSzpi1uODtQvypVgv8b0Kze6
         t7CWknYbN1h/LWfKKHdOgQoVaJE7mPyXlgYvPIm7Qhs65CbNrbARADcAp5duoHjOXFiU
         zJSGEsrORQHxs89KH4I579uQJfpFeSURSrl6oOcJfvzLyZDLhK6l2mdgEny+/sThZb74
         YKQFGw2Vck+rMEAi0A8q5PTcDctEKfut+qd11Y85xubggO/JQKukpx70b4fWc1Ajzaft
         UAjw==
X-Gm-Message-State: AOJu0Yzd/0KrCHYCP3ZQwclrgmPI7bNVMsq8x3gbxTuGU/18/mZlIJVT
	N1Nok+hVMpLhVbal1yUshgJ+FSbivShBL0f8cjbh9eB/irzCHY1Zo+b7ug==
X-Google-Smtp-Source: AGHT+IEe7F54oQcR92pn46axgcMg4FEM5ULJPh3zGc/Wa9ArQtjvKLA4bNwUI131ys+CZrPKLHKgew==
X-Received: by 2002:a2e:f01:0:b0:2f0:27da:6864 with SMTP id 38308e7fff4ca-2f75a986ff2mr100153461fa.17.1726050679335;
        Wed, 11 Sep 2024 03:31:19 -0700 (PDT)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c07c81bsm14853871fa.76.2024.09.11.03.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:31:18 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: [PATCH 0/2] add missing LIBCURL prereq to a few tests
Date: Wed, 11 Sep 2024 12:30:58 +0200
Message-ID: <cover.1726049108.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.46.0.733.g1eb83ef1a1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I recently had reason to build Git without libcurl. That surfaced two
test scripts that use `git http-fetch` or similar without giving the
LIBCURL prerequisite.

Martin

Martin Ågren (2):
  t1517: add missing LIBCURL prereq
  t0211: add missing LIBCURL prereq

 t/t0211-trace2-perf.sh  | 6 ++++--
 t/t1517-outside-repo.sh | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.46.0.733.g1eb83ef1a1

