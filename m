Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3DA372AAA
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588410; cv=none; b=ut+63AhVKUtsI+iCFEvuwuQxyNHLW3PqPWD65okPagRohaoVO5ztG729ngzqM2lEOKu/vu8JI4ZQqM3RgtEGhSSZ3Z5pjPSGvSCgdKHC0sTgo4bjkIdAQRF7edrfmPwKvwGaOYdVCtkKoPGogcJ13ZMdxRU7J/M+fPfYLS8wd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588410; c=relaxed/simple;
	bh=WV+4nu9aRqO7gIQ5PP9ZN0JGSjaNLlW8NN24NmICYwI=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=oHtyb4//HqIAcjNwftO938pBoDpbmfRX6ZCMiKv/nP8W9NpGRFQl8TLrcBFcA/jCPELDo1z81Ua8OnFq8z/evJdiCWg466Ui2mHc0KMs/NsQojT5i1JXhBtw2nvyYe8EctD9O9yr4NqIV6SIQBEVX57ltEDrdVRnkXxptpcHdtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSEn6+VD; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSEn6+VD"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-949325df6c8so8925539f.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 13:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763588408; x=1764193208; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+I78rjbAIRYSbzymPK1Bld73l7Q/F8yuk8034Ln+18A=;
        b=MSEn6+VDuuVw1vSAb6gfAK3g1OY0f6HN1jYkj3RL+VFcuf0Fjn3QLytqsW29XMxGGU
         7X/qMaHI7qYAkFfF6g33+wpLTEpmtoWHlB4VtDbzcsk6sxeCbwsQaPOsOA+ZE1VXitoZ
         pimpPTLlHnz5Lp/mFpnv2RNQ9xuXIOpUH5Belngg+MlVJKzsbTgU5OzvJf5sPksgpi20
         VbVaKyuetTeSASbjW8u8PiDtXpl7a+KxQwIn0Sj7X/qyrbC06+NevbqkvsOvDypsEYJr
         HuH447RYYRwZO+6kaA2q2YDJtXkKD5SIXWMQP3cTFfh/TaE8SMRXqLM88gmkbDBbP3ID
         z+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588408; x=1764193208;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I78rjbAIRYSbzymPK1Bld73l7Q/F8yuk8034Ln+18A=;
        b=KK2TGLhayQyjy0dcfllqEoMqWhb03jMjArn1loIypkllxLC25QGdm+G9PSS4GU1xOd
         3SJ+StT92BjgvZjbQ6MzFEpGMrrSRUsYLR1R3KQqeOKYMzviAGXhGGoxUtjzUtGLggD7
         r5laariCS43s5qphbHXqGQcgUoMb+CBXy+XeIAPb2GFy/VfhU/ru8+taFgAhXI5e5n+u
         038oHxzPpoDmE67PqYI9Bb1HbqNH0hYFjIoOG7miSdfK4P4+eB0xv3/UMS4GFAovKoNe
         RVbYLw5z8Qq9NP9MIW3WCrNZU4ErElVyz/PO0e9uS1earmrAwo1aYG0qTLlHBhZ5fuvS
         /epw==
X-Gm-Message-State: AOJu0YxoqxfRkbY6vd0DDa5abIJ/ONaaMvGu2e/YslamfsEIrFDwe5se
	+9IqJJ8eoX3P9q59l9A1KIohlARKSBJVuod+Ym8liehZnG7NaZTKkdJaQhGkcA==
X-Gm-Gg: ASbGncvJsVIDgvalyDMun4Bsjtuy6amP/6lPITc7df4THhZl0r3Vq1jK6jJ+Jr2eNHI
	BOTv3KQJbtehLrhzSvrF4g9S+Jm5FeWdNjZUah10MEmvVS6hsC0AOSxDbaQs6huYxHMsnbRfwQt
	Lr04fxszBwKSV9YvhRW1OXFofcELnOKteblKL+wODX1iPSGWmpv+gg4qGjTC/sun0RrKkB1LiZf
	Jbf8T1fJKKReLKHV/6pXDcE7AIATmxYp7xMXAdlKAKsuaF20f7Noxlc57SOzUKQt7BE7LyC1Vcj
	PeIsCkIflVdwGio7VKmj5npPM1M61S558o+ndhZmJ8yfnXbYf6ZxnJu6GGj3BbH35RbMj+soiLB
	IvWn9nI3iegVufsPCEE9FRkeb/8x3A+5/I9N9zX7Flw92kmXo5LtYvEvNNm2W8R08PPsW3C3htW
	koBJ/BnROB3j2we+nqtv0E/kk=
X-Google-Smtp-Source: AGHT+IGcyAH22Q/n3XV2D9wK74rNfTJvCWZpDdqjS6brKqQOdXwW/D84Jzj+FzOAFvTdyZVQacgXzQ==
X-Received: by 2002:a05:6602:3c2:b0:948:28cf:3f9c with SMTP id ca18e2360f4ac-94938aee644mr62634439f.14.1763588407993;
        Wed, 19 Nov 2025 13:40:07 -0800 (PST)
Received: from [127.0.0.1] ([64.236.134.50])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949386d8f05sm19300439f.19.2025.11.19.13.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:40:06 -0800 (PST)
Message-Id: <pull.2002.git.1763588404.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Nov 2025 21:40:01 +0000
Subject: [PATCH 0/3] doc: convert fetch pull push to synopsis style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This is the continuity of the conversion to the synopsis style with a few
additional formatting changes.

Jean-Noël Avila (3):
  doc: convert git fetch to synopsis style
  doc: convert git pull to synopsis style
  doc: convert git push to synopsis style

 Documentation/config/fetch.adoc     |  60 +++----
 Documentation/config/push.adoc      | 113 ++++++------
 Documentation/fetch-options.adoc    | 211 +++++++++++-----------
 Documentation/git-fetch.adoc        |  48 ++---
 Documentation/git-pull.adoc         |  61 ++++---
 Documentation/git-push.adoc         | 267 +++++++++++++++-------------
 Documentation/merge-options.adoc    |   2 +-
 Documentation/pull-fetch-param.adoc |  52 +++---
 Documentation/urls-remotes.adoc     |  18 +-
 builtin/fetch.c                     |   2 +-
 10 files changed, 428 insertions(+), 406 deletions(-)


base-commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2002%2Fjnavila%2Fdoc_git_fetch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2002/jnavila/doc_git_fetch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2002
-- 
gitgitgadget
