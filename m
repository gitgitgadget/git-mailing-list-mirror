Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159F92F2D
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710561397; cv=none; b=HNEZ4uOpmsLMIdbDhEZuU2BVlgAZ8jjgiOEtgXXEjN3sMIJwi+/VRln+LEQTHFsDMfUb6r3t050O48sPHhGu1UVErQyjO/LtZ5LEZuCsiBZ6XYqty0I+hJwCz4WVM/y5HGecp3jUWtgvNtZFX1GBczLuRxrxRSHxmjAo2gyt/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710561397; c=relaxed/simple;
	bh=AlDbHL5tErHNJcVbzRF48g1lvT13TMnoMPvCoIMd2ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SoIj9wG5Zx+Rdxqx8qZ5EY/MNi1Q3mjDs+GfQl24HeeM/KqPW9Oe/6KVzhe3DkC8sjh9n+lPvLG0gClbBnIkNItTldl9/U/5oOqAQ8ivzJncIZ/EQu+Rf2Y8+nfL0eIrXufl48LbqN3C/ZitE0KRWa2zDFx21I4o0UnT3zXKZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bx/8k+IA; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx/8k+IA"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6928a5e2479so174726d6.0
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 20:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710561394; x=1711166194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNzj/vh08gJ/vORLGP97Jb/enf3dig1lLA759ZNBZok=;
        b=bx/8k+IACrNgpBZuouyIMs0PQAuWyZuAOWNVVQVWYGwLMd9EfD5NEjWykAfPx2BcP5
         7wowbOD9UuMRcT+K2kctGq8g9EYn0N4oJSlu0uHquzT5jOpCILgGU8q5v0fj5Uv78I9x
         6QPzNdZWUhAVb6COXJtNT2TKFlgYOpUne+isDoE6r7djoxrtzeLqACGg9za7NNRRerG6
         YbWvEFnVL02eGunav74wLeZJjL+iwQ7c+TApyNxk4o+NGlKz5Ly+l48kD5NZOdgLimyN
         4UVcMM933faqpUribm47nczKT/JM6AxW7t6K3nJo6WTzEQpuXoxbCjSKJoTK8l6RD/Yu
         uqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710561394; x=1711166194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNzj/vh08gJ/vORLGP97Jb/enf3dig1lLA759ZNBZok=;
        b=XfiZe0zZztL12RajhFtoy81Kk9MS3BGbYbwIoElZTgRVhVZclbesOQm8fL4aJiRcU0
         NmkF6zasaJ0cGATAMXg01pl1DjpvyZltgsEPlf5Rp1XqEx+OigY5ACf1ci/c/di4l4UB
         jpmCEmtN12o4ibLGcSiXHlKG0AZQpVgvtjEOkiqRhPiyGDfzO61+eZG5618+9MOC9s5g
         oFZIsul9RlJocw1Z7soD8+nCjJe/wW3RnfFN29qzUcqLHvxcu1PBNulnOepPb9QXwIhL
         lvLlQH5kRD7/ssnyyMxdTFLGTB+ocyUX4LhI5+Wl/GQlMq2C5UOu71UXgjoQqFHJqniC
         ZhYQ==
X-Gm-Message-State: AOJu0YyJc2NIUICsaFfejyGOHUDJyqcmaZcApBhpgf34Py20B5Ev7LKJ
	31v7apcKgnXTiRbMONdmEu3mmxB/Um3Gl/PMfM/i/jVmqoMtDKtE/TPd/Nrg
X-Google-Smtp-Source: AGHT+IGksWT5JL5j+KxEcLlmxdQ0fSJkrdJ2g2140mlbqRGnEgbklymZysQV14DIDqJ4FdmRmm8WlA==
X-Received: by 2002:a05:620a:819:b0:788:63dc:e1fb with SMTP id s25-20020a05620a081900b0078863dce1fbmr6444489qks.77.1710561394222;
        Fri, 15 Mar 2024 20:56:34 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id b23-20020a05620a04f700b007881a59042dsm2608013qkh.66.2024.03.15.20.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 20:56:33 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>
Subject: [PATCH] docs: correct trailer `key_value_separator` description
Date: Fri, 15 Mar 2024 22:55:42 -0500
Message-ID: <20240316035612.752910-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The description for `key_value_separator` incorrectly states that this
separator is inserted between trailer lines, which appears likely to
have been incorrectly copied from `separator` when this option was
added.

Update the description to correctly indicate that it is a separator that
appears between the key and the value of each trailer.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 Documentation/pretty-formats.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d38b4ab566..4839c2843c 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -329,9 +329,9 @@ multiple times, the last occurrence wins.
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
 ** 'keyonly[=<bool>]': only show the key part of the trailer.
 ** 'valueonly[=<bool>]': only show the value part of the trailer.
-** 'key_value_separator=<sep>': specify a separator inserted between
-   trailer lines. When this option is not given each trailer key-value
-   pair is separated by ": ". Otherwise it shares the same semantics
+** 'key_value_separator=<sep>': specify a separator inserted between each
+   trailer's key and value. When this option is not given each trailer
+   key-value pair is separated by ": ". Otherwise it shares the same semantics
    as 'separator=<sep>' above.
 
 NOTE: Some placeholders may depend on other options given to the
-- 
2.43.0

