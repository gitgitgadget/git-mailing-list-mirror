Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163851BC2A
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756062418; cv=none; b=eXeTPylFxnyr6tV++OBKqqJFYHC2tbkmMlBc/8MZeUvJYwlV/YKIeH/nId6MdAfF1mYWo3GpprIGxUas5rLOSdkc7y23GWcdxdcKduf6mHouFBtTMUXjJUbs+OJMdLTm1c9jmoaoe2vkrqJyOx+UB4kb+WuAhtUA0/FFd93bnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756062418; c=relaxed/simple;
	bh=z0UWElBoisFPrs5CVTrWj0DdKR7Aqirg7MFdCBidQWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E5al3PaCXCuqmZLmf7jtJkP9AH//zKdEje+PQucBADZ/Z8cbTt4Iw0I4x5kRwNCja9lkJNlhbPDOb5PYKKq9FMWxGtNxzkQt6y0EOgF/Z0mzzzILhCmFY+UM6wAmnpb6ehm31bKmcLuFlT2aN5aRix7dM3uKsFh7wL5OWCh0j6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUJp5wzu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUJp5wzu"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b4d892175so17074545e9.2
        for <git@vger.kernel.org>; Sun, 24 Aug 2025 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756062415; x=1756667215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iH9P8ofnUkNSSKkR0hyV1dY23F/l/zJ71XtjIpllrlU=;
        b=jUJp5wzutbmcYphsxTC8WBSUBDvx5osiC7CPQ1mqy7wWyzsgMivVlE9MC8qJSYqeb4
         hNfpV97LrO1008Qspj6AJBqdAx1b6XFeTgLwjUvF4MXYHTTwsIuLcg5MyYtP9btUvhkz
         Qv84EeD9d05BntpXM5mmM+ProIaSa104IKhbAVFXLxWP2zWV2mqsCL+efTMu9kP8Y+7+
         1WoDzdkHrz47FeQf0MzrV5nYxJlJC2NlTSdCL7LK7OVjr1U/uWYf9w29BCFDXig7DnB5
         GLWcyB4Qx4/8BdgEv6jm/EbsHiP8/EsxmsTOXhko1+f0HxDe943lFzF/1rpTaLmEQjAx
         v3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756062415; x=1756667215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iH9P8ofnUkNSSKkR0hyV1dY23F/l/zJ71XtjIpllrlU=;
        b=Ntj7lHIHm7DNj28Sfau/vDr7ZC+H5Xgwz7xf0Jg0SpveWkwEia633jQ/fNtKiX7Phc
         /Ascm3bk1/MxSOQ8gV36U70LZv+lX7JHYlb8ERxj86uazJwj+I+q83wqcDtjwY4LZUXY
         qwi9bvi6Jf9YRwrL+N1w4nfSDzdtIBAe+dRKapqGeTJI7Zmv2LYIGIhYYu68iYGIQIA+
         NIuE3zanNseKCg5gPrXmNjO6TUEWJ9ycedvAH1afJXM5J+Lu9EVb5fu8eHiBH+JVgOuC
         h1J3Gdt47GAorcX4NnxWX7mQbNIolVRXmE7e8D1vtbAwT6BO2UNqZtj5U47LzhDyVbaU
         iijA==
X-Gm-Message-State: AOJu0YwWOL6hnhIdc4ssMa5uxPPyfCvh4RZp3Ocv7ePsRzYSDCL13/Fq
	W9BhhwtT5qwrbSPTEBXjFQs6BqBVnrd7HXv+w+0HU/vyw43XBBwSI5q/B8FXjQ==
X-Gm-Gg: ASbGnctF7rfySdShT6m/rruUkv7OKYM2PzxYG/hXDKnYsjJBYihYUNyyCGfeDfiWwli
	8mdmElO/7UMTiB8L0XKg65ONc4EsnbtF+GwOEAeFtJ9aZdWlMOAIif3sToDOK2mNxBokmf8p2mT
	jod+Cksgiwl9lwqn2/cC5sIDizVlnpYP7FtPm25+FUz7W18cac/Xat8q1MK7y3u0ZqtCIHs7mLo
	vMgA0TEnuejCGTRADVmKPHvJ8S8qLvrUKJCB07UGHZo5ZyA9RbB5qPW/Wf6p2bGMlutMZ2vHbBf
	4gbmn0LK56/rUXSmSoZNqmcQyjmm/fbc/7gG4HJ/Nsqnf1m1cVXj1Cin5IkS3NSs/0s3X0djpdC
	52/FWvwyLnRjLCzkNoIxLDwjWQ6FwuDsk6fZMliKSzlQ2o47N587GGERtAPiDCjE=
X-Google-Smtp-Source: AGHT+IGqYWtW1K2xqFVlcX/5xAKZv5ihX7HJU7gI5cqvyxFAmFdtuuMogWABTXoThysffhF+rn/i7g==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr118328535e9.16.1756062415101;
        Sun, 24 Aug 2025 12:06:55 -0700 (PDT)
Received: from localhost (78-131-14-231.pool.digikabel.hu. [78.131.14.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm8917144f8f.14.2025.08.24.12.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 12:06:54 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/4] line-log: optimize merge commit processing
Date: Sun, 24 Aug 2025 21:06:40 +0200
Message-ID: <20250824190644.2573279-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.51.0.433.g1a66b3fb12
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch is an optimization of the line-level log machinery.
The rest are cleanups in the area that I subjectively consider slight
improvements.

SZEDER Gábor (4):
  line-log: avoid unnecessary tree diffs when processing merge commits
  line-log: get rid of the parents array in
    process_ranges_merge_commit()
  line-log: initialize diff queue in process_ranges_ordinary_commit()
  line-log: simplify condition checking for merge commits

 line-log.c | 50 ++++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

-- 
2.51.0.433.g1a66b3fb12

