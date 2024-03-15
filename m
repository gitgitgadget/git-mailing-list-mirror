Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109CA1A27E
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485711; cv=none; b=GrBzGXiAggmsFYApOQGDkemQHZ5Ffhxg31yv1R7Gbu3i+DPYwWo00CopupM92hTU3i6HRo/fQRvnTCjZIxr8BIP2XVpUG3s0uoChe3OkQoMY5rncI/P9xu0ZRHxTa8rbKg1RPnEXlEUq9ezz70wk0wSlnP7eH91MuRRyZuWlH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485711; c=relaxed/simple;
	bh=pjXvylZqO0Rx1TGZ859TJb2FCUKcglsO3e52USnHV+E=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=NXf9SN8mjgujz2QusYNvZQmcmBFBc6HgboarPwfonraBTbRfABkArb0lsNetyzpMq3Nu0j9Z6+4eoi+mEoH4K7jJu/fGluM+CS02kyoR2ysJoyc8n++QCvZZVGdMDqMQneXRyLPPVMS71bv4MOKGXKPscOibjFk1hPE0EloFuEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgkouShU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgkouShU"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-413fff2aa2aso3442335e9.2
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710485707; x=1711090507; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MnoRT0dLe1y/xZMrNCwJyQxsmnVHDXG9wrtZVOj65Lw=;
        b=HgkouShUyC5uSqhmnHwVHINeAY3tKERZDfJkhlOjUnmaHlnn9ygfxMJPjPOACCkILB
         gXiClEyr8kYX46uWau3mSUfBMo0R3d36938Sumg3ARBkQjhbKOjJua4b/3NnOhNz0Dqj
         lXuYkD//xNi0lCfT0Fr3oTpQJFeIyFpKdLnQSPVa3cBOs+UMtP+f1F0EnEec8DJ/JHjA
         jIdvoSnzfiyFwNXOXC/CPNK7OfKjukzaov2Soqn9lhhp0LO0DDf7UdVW9ub1mSaR1tZs
         D8QzSmuJJcM83Ai6pF+ftC4pU/v6IV1k3090qYJeOaZr8ALP/st3kAtWkVI9J8f87DoN
         GxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710485707; x=1711090507;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnoRT0dLe1y/xZMrNCwJyQxsmnVHDXG9wrtZVOj65Lw=;
        b=vjel5NEJO3FQpl5r4LcTl/ONBa2WgEhpYgaDwXHTXyk/wtdOTi7fnbVe/aYkXfm7o6
         YPFimpdFPqC0XGekr1iL1Hx4MKgdLZue7Y2EDYcw/5BBbcCdiFt0MMmqjb6KLO2SD1Wv
         gL2Q96kNP8Q36rJPgZXuma7Slt9vkMPWcuJ5ar/jo8rsx4DjRFd+ksRufhlM58wJNJIa
         RkbuIjh+qfQKyPrGqCc/tqvC++IbrcLGOk+IPRTbhrDbzBgOBbu/eLi94CSz3/l4QY6T
         kYosnb5U9A+RwZRwffgZ0nRjGyhsQAHx1ZViVC4Ag5tsoUSjRgRvs3GYXdoGIplZ4I5E
         RK5w==
X-Gm-Message-State: AOJu0YxeedQ5KXUbgY99LvelTkmA2cTHMAnPpoA+IQFzueYfuL+/6wgs
	vn5bviMvgcRKtx5yMvvTnGAI1eNDjriS8KJXr+5C5c66QT6dds8h2nt9nhPa
X-Google-Smtp-Source: AGHT+IFmysv9X82GspwwRGucRMw913EcWc3D8nJWWbiEHGdXiSoUItmly1guOUNb5JkM53Jzdc2k3g==
X-Received: by 2002:a5d:4acf:0:b0:33e:7dc1:ff53 with SMTP id y15-20020a5d4acf000000b0033e7dc1ff53mr1466645wrs.16.1710485706891;
        Thu, 14 Mar 2024 23:55:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d634c000000b0033e9d9f891csm2445435wrw.58.2024.03.14.23.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 23:55:06 -0700 (PDT)
Message-ID: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 06:55:00 +0000
Subject: [PATCH 0/5] Unify trailer formatting functions
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Christian Couder [ ]" <chriscool@tuxfamily.org>,
    "Junio C Hamano [ ]" <gitster@pobox.com>,
    "Emily Shaffer [ ]" <nasamuffin@google.com>,
    "Josh Steadmon [ ]" <steadmon@google.com>,
    "Randall S. Becker [ ]" <rsbecker@nexbridge.com>,
    "Christian Couder [ ]" <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    Linus Arver <linusa@google.com>

This series is based on the initial series [1], notably the v4 version of
patches 10-16 as suggested by Christian [2]. This version addresses the
review comments for those patches, namely the avoidance of (temporary) test
breakages.

The central idea is to unify the functions format_trailer_info() and
format_trailers() together (preferring the name of the latter), so that both
the interpret-trailers built-in and format_trailers_from_commit() can call
the same format_trailers() function, while maintaining feature parity.

[1]
https://lore.kernel.org/git/pull.1632.v4.git.1707196348.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/CAP8UFD08F0V13X0+CJ1uhMPzPWVMs2okGVMJch0DkQg5M3BWLA@mail.gmail.com/

Linus Arver (5):
  format_trailer_info(): use trailer_item objects
  format_trailer_info(): drop redundant unfold_value()
  format_trailer_info(): append newline for non-trailer lines
  trailer: begin formatting unification
  trailer: finish formatting unification

 trailer.c | 81 ++++++++++++++++++++-----------------------------------
 trailer.h | 13 +++------
 2 files changed, 32 insertions(+), 62 deletions(-)


base-commit: 4f9b731bdeccffa1b13e5edf4bc0428b8d49704e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1694%2Flistx%2Ftrailer-api-part-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1694/listx/trailer-api-part-2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1694
-- 
gitgitgadget
