Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C373C38FA7
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766067; cv=none; b=P+Yd28xThN1imVU6JkCDeFsBH3i0sWmlmujhTeBjA+PpwPlQBZrJxnDqgH538ym0mv+7wZM4CL/OZum+EQtyMqxIwmlKy+bJ+aqD45FvyYs64v5fdmE3RUzpjpJ3rr9c2jnb7HnNKySyU4jBnigU8V6EKQYbnymqyhxe9Iawd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766067; c=relaxed/simple;
	bh=bntN+yPht1A1Hzxq2udczJSy4Xx7DBGcuGeuCoqshfc=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GjSmn4ZOAA9gJTW8dh/eDvpR0zJkI+tVtxlR709OZpOMcVrRAoHdRZ+5sT8d+uIYFuLTIXB8rZgFFDTPODXKUtRM9sd0I91+wdrTj8mvmQylYGBCxIlE1plnoo3MWMpXJAXYeqM9fOa1aoUtyfDHYakImJAKaxQTDckQqnc+jeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbk6UXpb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbk6UXpb"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4141341f1a8so3477645e9.0
        for <git@vger.kernel.org>; Mon, 18 Mar 2024 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710766063; x=1711370863; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AN7WR+Z0sW+5GsNjNh0XY+lrwTte5inxoxSorp4+0ms=;
        b=hbk6UXpbh/fT9BV9MPu4XtIgJjTfweAx9Zmao2gobqRCLMvm1hY5yBcLhP39yL3t/d
         yjKgiRfQY/lL8aifW40Tj6vZR0mygVmWO3zftmWlaHDMFVaLLl8RDfgpzWhrpV9SWWCC
         tchzqzTXZ4OtbdGFwz+QEJxh6yxqZ7ZEaFPFAOLxgFlnn54kBgwmGrwZum9WWRV4Ji1T
         uFBusnUkkWxfKJTHmwt9+WhZ+DZ0bowo+tfgXJJvJlgBYZdY/oiUBMwi6gdDZg5vdarQ
         OkiOuA7nxyTPL3LA+tjV8qhQr0EyydRJsjTofGnqLO3AJZNGGoDrysPsYZR2D0s4MbaX
         I3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710766063; x=1711370863;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AN7WR+Z0sW+5GsNjNh0XY+lrwTte5inxoxSorp4+0ms=;
        b=WqnGacfLvoab/VDnLkANcblQ5tFUXiym4xcuFqMe6SQWQd4YgpUipBPe/dBQCurcBG
         OuHn5rzO6sAmG9OMiVGVg/VJBeAox0mUW+zkj3e3YvhnLQFlru4gSQEHFPEoAa2XKiw/
         eNI6wvobrHVbcli2UA1x72ma+LSFwLYf6q3rqzVQP8j83kW3JRNy3wWYwlCxwdUbFpD+
         K47Q/FD9tJ0Z15Wvm1THpuCdpqtLdhPoMMwgCQIEC5UUlcc8jLNE6LrPL3aRlrvQDIm8
         UeYO5485/VRfieEIE5z6ta1RrYNgW0mSC0SZfKKzzDKxP5HRmSeRIj79D3fUx6UNZZp9
         GOYw==
X-Gm-Message-State: AOJu0YwvcXwu5NiUOYJXELW1Y8NaYiTX9OLdszrSV9txJKiqooRa1lhM
	xn/32ihLeubjmhQrETvAugGe+C848kTOs1VJrIMNlJmOrJ9zrxd14QqEqL8v
X-Google-Smtp-Source: AGHT+IEvYKYUAnrayyeajfeoVWOl/qxLYy6BosJ5Pn9tVsUaxaWlP4ymRxI+WFn5Uhph6fRWAZ0t1g==
X-Received: by 2002:a05:600c:4f07:b0:414:5e94:51cf with SMTP id l7-20020a05600c4f0700b004145e9451cfmr679486wmq.18.1710766063002;
        Mon, 18 Mar 2024 05:47:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id je20-20020a05600c1f9400b00413e6af1bd5sm14612452wmb.47.2024.03.18.05.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 05:47:42 -0700 (PDT)
Message-ID: <pull.1699.git.1710766062.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 Mar 2024 12:47:40 +0000
Subject: [PATCH 0/2] git-compat-util: move convert_slashes from compat/mingw.h and rename it
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
Cc: Mohit Marathe <mohitmarathe@proton.me>

Hi all,

This series aims to complete a #leftoverbits: https://lore.kernel.org/
git/xmqqzfw43xad.fsf@gitster.g/ by moving convert_slashes() to
git-compat-util.h and renaming it to change_path_separators().

I appreciate your review and feedback on this patch series.

Best regards, Mohit Marathe

Mohit Marathe (2):
  git-compat-util: migrate `convert_slashes()` from compat/mingw.h
  test-lib: replace repeated code logic with an existing helper

 abspath.c               | 4 ++--
 compat/mingw.c          | 4 ++--
 compat/mingw.h          | 6 ------
 git-compat-util.h       | 7 +++++++
 path.c                  | 2 +-
 t/unit-tests/test-lib.c | 9 +++------
 6 files changed, 15 insertions(+), 17 deletions(-)


base-commit: 2953d95d402b6bff1a59c4712f4d46f1b9ea137f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1699%2Fmohit-marathe%2Fconvert-slashes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1699/mohit-marathe/convert-slashes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1699
-- 
gitgitgadget
