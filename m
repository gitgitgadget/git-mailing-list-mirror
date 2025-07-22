Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF8C27E06C
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206078; cv=none; b=c5tVq0UVZn/b5bjUK6U+ewsiJdj2BZI98kIDX2YRAGaL3FPbaITkbkg6AcQPH24v0MQUvafVe5YS22RA6y09G2d+tX8r+aD7oULJGbWsVg/TF0WaArQWzS+aC4V3hi1YEXViUnoCI04nAs5PBM2SUY9iwaILylxXPo+rMGrH4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206078; c=relaxed/simple;
	bh=QHyOxeBI3LwetSNgHPk2mF/thqKUdYrS8x6hTyWyPgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XQvP9xQZDP8MhHaZ+ZBJY1lHUDqt7nhC1Enr78IlgUQ2l6pdRyRimCZ4CSn6HwZw9CHUF01De95U4Vspsh2FedFlzunYtETHomUXOhgJcLhdqwIFve4t9lqzWdS8uJyxWnZXhSfjY26aKWcgZGGLae0pQB7I+UvUn1daYKaKxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ5VGPWD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ5VGPWD"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so4926086a91.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753206075; x=1753810875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uywAOdvk7cyDvwtoPRI4QTFJJ5uMwa7KN8jBdCoSidE=;
        b=ZJ5VGPWDi7eUK76EruReSAksP8o5xZhQNLImCluE6GKOzWjx97X+VN8mZBnIefUHo3
         wXn25J3rMcizbm8VNn1eziHATHdECpn8tCJsnht1WvnwzW0gkXCpq/UnGT+vU9lbT+32
         iEvxunkV7D3a41/yZbE30vYOG1LiWMZLvjc4QoYMQSmPJ7vIuWWclI+Xq7XINuVRlwRi
         kZKXQNGTxSwbssGLz/O53jf+M/m99ui4o/cFV2mFs3Ef0epkQp09/14OSAcZejMFbWhG
         AfrSA31HBq/K2dBu9cdHQAEn9lbjg/rhfo4HU+QI9XoobhVxMJIxgT3irHsuqY7Kh34k
         XwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753206075; x=1753810875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uywAOdvk7cyDvwtoPRI4QTFJJ5uMwa7KN8jBdCoSidE=;
        b=b9QmbRD7tb7MXCEnWodQdjEIOnwldoSZ4w2GA7YbMZiSjHZwo1njt7pWTSVJZoCFGU
         ICVPIkco4Cu2LA2mKwKe3/QKF3Ri0jevvvcBHVKnmSwBejDzDxsR97KPt0VjAQA3nQsn
         /UOgDY/dX47NLHdfc015MFrg0N54sjt8N6Qz8FegCGX0yWQxU7EeWAdD8oFv7ozv3Fun
         MidyR9PvwPnE/zAvOko6c/OWBq9DAsqmlxfej7JAv3hIj5NktGnmOyZ9DBsWPMBHgczM
         Mo0ALWnr/OngK2xS48e+KdX5CRAtT6U2jqJDqvzWOpEkTPylioi7rZRigwrxK7qSx5zh
         iOeg==
X-Gm-Message-State: AOJu0YyeTQRwR2TQm/lGk+Pyy9h3aLU+ZYOZE0/gOvKBtbAAGrJ6NaNV
	6uagDdQtftAZrSxHZVoCahinf0bfo5MuN4hzbuqwWvHhSnB9Z+kWvt+uFcjXBg==
X-Gm-Gg: ASbGncsFv0zJbYJRt5lxMh8ooe1N/r7NRYie3ZZssdt2N8lKfgtmlwP2H7OltDPDLhO
	bVf1FOxtmwFLJcp/xdiNajSByRhub1sG3D+HbpwBejASNxNo8dk8QvbfnIMlZNnIzRK70/sVsi4
	QzpJJFAXMR1IPqP8/Y/XYTFMytk7McLNLfe54ewnqXm09h4wHkuMxmY6xL6cA9zzj5CT0MzpyK4
	GiP/06UsVn+VobtXP8eCa7RKkgAft5u0v8/NUwrlA5aOhG2mbyyd2hM6F6mS1RKbwS6prfghRg/
	v4IhNsA9Ol7mwRJ2JZwXUS0Cfv+hXNagE6pTXA+Zc6yMbiWv/BhsfZLgOv4Ks6srjcEZEaN++0V
	J1oi++1nEHLWge67dmi3zLCLNI+eTOHxpTQ==
X-Google-Smtp-Source: AGHT+IGPRNxICRyK1o2M4EVIj0VEXtnROhRH0Xl7ZjNXfDfG175Hz/VnPPHIgZWa7cPZv1Ln+lbqMA==
X-Received: by 2002:a17:90b:3809:b0:2fe:e9c6:689e with SMTP id 98e67ed59e1d1-31e50768ab4mr216689a91.8.1753206074910;
        Tue, 22 Jul 2025 10:41:14 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e40f31bedsm932293a91.2.2025.07.22.10.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:41:14 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v3 0/2] fix resource leaks in test helpers
Date: Tue, 22 Jul 2025 17:41:00 +0000
Message-Id: <20250722174102.1876197-1-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the detailed and thoughtful reviews. Your comments helped me better understand how resource cleanup should be handled, especially when dealing with early program termination.

I especially appreciate your in-depth explanation regarding the difference between true resource leaks and stack-unwinding cases. The example you gave was very insightful, and it clarified how automated tools and reviewers should assess whether a resource is truly leaked. Thank you for taking the time to provide such a clear and instructive explanation.

Hoyoung Lee (2):
  t/helper/test-truncate: close file descriptor after truncation
  t/helper/test-delta: fix possible resource leak and ensure safe
    cleanup

 t/helper/test-delta.c    | 9 +++++----
 t/helper/test-truncate.c | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.34.1

