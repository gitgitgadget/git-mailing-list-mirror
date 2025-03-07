Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9014A4F9
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351197; cv=none; b=nHJLnXwzsIPqOD3+vG9QHWCjAE/G2UI0pH1232MNl6fcCNA0IBuPs1RYk5nID00AHkFm530QQ+wQ5Ea83pTBWRPFMPPlGekGEaHVudbt0OuToQ87BYgx7WeFmR8nZexu43jLzH1hYLiNkLv1jCPug7VtvnImvEzr9Kc9b2Xq13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351197; c=relaxed/simple;
	bh=72NS7JCbbzPW6aW4JxSG37HC8iV3GMi3jqb1734meqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lboPdc140jkQvh+Lw7cqrExdeodu4WiVcxT9eQZCrppeRmBLZiK0yxIz5M8Qp+WD186c0CurcZIfhKZBr9ActnREadOWSpbTPtS09rwKFh/RkNK+XBI9mUCa2n9yfeVtvurqsnJWnU/CJnavCJz7sjWPnJ1FbNYB5YFa5/aMOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8W6+gYK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8W6+gYK"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2235908a30aso2309595ad.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 04:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741351195; x=1741955995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMOV+072UnyaRd5BtgkTosbm/gxkwiKkRhQ+Rgr3LI8=;
        b=A8W6+gYKHYgmYkQjmWjTyHpR6DqCbQIgll1Al7Iohi6L958J12KrqaD4KPUw5n+F7H
         zAWDRqqLmSteU4Ex1u5nNfWPzTDYNcI/3wmq7JZZcOp7+dOC3HPfhLZcxWVtXnTCRkdK
         sOW2pQ6X62VXeO+TMRdmoP8/lqxTfEmmgugKUCVDrSY7V6bDz1OLsooFxb8qCReEKI/Y
         Rjk0+QxBxtJdc/qxpnW6wlXIZOHKzoaSzhAnPz6xd5km1zwM7Fci9s7c+fV1cZ9megLO
         c75Ami5zqX7BlME4ng3II82JL76q3qEntBLVEO80Gabd6jmZqsQEFCfS2cJZ5PxafgPJ
         Faww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741351195; x=1741955995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMOV+072UnyaRd5BtgkTosbm/gxkwiKkRhQ+Rgr3LI8=;
        b=GTcruVu9kUeZEvP0hg/ACZ5Jv3Ho556ymtLDERS+bs7dgjw7u8S/caimbqQ5o8l2eP
         duPK0a0+8dI8TA5WEU2fau4liQDXZkOkK/mOAX1w3zbQqQFzT2e98e2waqR7to3tt3KE
         3DfpVZ1rpdH//3UfCjXhTR25O5wHJTt1OsMj40PFtTpjE+gGNpliw/ubpUU8a1hJXNeb
         UeEEeVdwLuajaqnVKgh2s3py15Xat1r/FcEZXdxHtOWHYWg3+v06gFN2LQjLQskk1bBT
         i8jY0APDKzgdZ/rGIjVQLU6+hINw0KAjoyS5oyWeqBjLSRXU+idTVid+EhbzZL4Y1xr3
         9luQ==
X-Gm-Message-State: AOJu0Yxsn1JUsw67uZlBmRwDLph/VNi/JlXiaNHouoJA0/wSQ4SPtcdC
	mTT+KE4NZMTRWkVlfnJ2zhU3B2TAcGq82Ttlz+6Vyw2VmSuYnOav41CqIXYM
X-Gm-Gg: ASbGncu45D7tP5UkAvmn6yQUjqR1jUx8pn22ysrKskJt7I5Tvizls77ZyE5CwGoknh4
	a9+dJDWHWmvIcwqaPD0ldC9SuL6jM0V0sZaJBBtxkTpmHq/mxp9QhQBztdY15KWbkjX+4wKtZVi
	P5XjR1UPgMukEJfq9VeaeyF1mlAh4BZNTAIo4xgq9NIJGkDZQREsXYaHuWeYAZxxYQEsQ9GIq5a
	TsmoOjIFWtNExG+SkUrGWK7AS7vJfWLiJ/N2ZOARiJKbnayE9/L3tCcbwgTjM5vNSTKXj0XO8YL
	0Og9Ot3LWmNE/NSeUANgdbMjgc194CvKfNEyS3dAj1kaNtE6IskLOw==
X-Google-Smtp-Source: AGHT+IE3XKPgzqODIVjVoYwDoghj5daBQnuSXn6tA620wDW3XygrYD041mnSpNU2nnOAvFv58OjmtQ==
X-Received: by 2002:a05:6a20:1584:b0:1ee:85b2:ef7c with SMTP id adf61e73a8af0-1f544c601f0mr5917172637.27.1741351195564;
        Fri, 07 Mar 2025 04:39:55 -0800 (PST)
Received: from localhost.localdomain ([39.184.61.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28870cc98sm2232975a12.26.2025.03.07.04.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:39:55 -0800 (PST)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: git@vger.kernel.org
Cc: Zheng Yuting <05ZYT30@gmail.com>
Subject: [PATCH 0/1] [GSoC]smtp_auth_maybe: improve smtp authentication error handling logic
Date: Fri,  7 Mar 2025 20:39:22 +0800
Message-ID: <20250307123934.2064275-1-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.57.gdb91954e18
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enhances error handling in the smtp_auth_maybe() function by
distinguishing between temporary errors and permanent authentication failures.

- For temporary errors (e.g., timeout, network issues, etc.), the function
logs a warning and returns 1, allowing retries.

- For permanent errors (e.g., invalid credentials), it returns 0.

Additionally, it separates handling for SASL and plain authentication
to prevent rejecting valid credentials due to non-credential errors,
improving robustness.

Zheng Yuting (1):
  improve smtp authentication error handling logic

 git-send-email.perl | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

--
2.49.0.rc0.57.gdb91954e18
