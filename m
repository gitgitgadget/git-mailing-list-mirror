Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EEEFC1F
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801859; cv=none; b=mmeSGZ2T/tUldhK3LfswVWoWtK4DnSNM31uIz89QGmtGHowbIkIGkZr0y3fN485etwbjql+qmBU1325GeKCy+6ZmPGLnbxqW90z99eYIyQ6VWDFOagw+knB6Z8pJhwI5N97rA4IhzBxZVx1NECYAvjWz1H5dVZdCe84UBdf1jNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801859; c=relaxed/simple;
	bh=da8aucNXb8mrdn7nElDxwMscjIHMfdEreahJspCbG4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXLUk9iPv93tc/QJZxO5b3UO7sOuY6Pr+wEclhZ7hYWix21VB8PqCdk4dE84Fm/XdXX6lj+3GUWXwl17s+Zm0sc5bOO4xrqDX79iNg23/GAo9t1QgXyzbvwrnS2rmoUA15loxV5i5yXwfELW1z7ta2AR9lTrKvoatA5zzWwXzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUY4LPWY; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUY4LPWY"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so73567301fa.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718801855; x=1719406655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Wm/VbeSV0siWSOMwSTTtkpt2/E5qS/DxWFwKHu1mN4=;
        b=gUY4LPWYChooxY8BRemsN6XJGIegbCOKWuzA5duLpcIJEAb1blvuVZlmPwseoIyyEc
         gNYQ0MfIX1ZQP10wvdVDnVcYXWfkC49527iUcpFKb+IVbB5zLqu5P0d4rHHsZ8lf5MOP
         8IcnZCHqzoQU+C+NVOpN2MBMwSYYGEuRuoItGRySfJ23vFLpOe+5fWUKnnnv6KlxVt8+
         CBcTsRyIKqX7+Er6wUNWq7u3wjHblgzjqC7+YjXN+2jZghBGrYLarP97NHa1rzmQI/35
         2oIUL4jksmOLUVFbLus/fEsWbZAkW4JAJz2ISLerzpYpqOzHFS6RCxDu5u9LJ/WtanAv
         Thwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718801855; x=1719406655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Wm/VbeSV0siWSOMwSTTtkpt2/E5qS/DxWFwKHu1mN4=;
        b=Nck8SgJzQcrJnUtFPdBYzKkqLUt02E8MyLrs1YzAxyjC/JWENhqA34UAEz69NSsogE
         74XVnJYTrYVcgiJ/4HLvkNpAO65I+eYA+gItUHka8gt51YJb4GiQVadbWIedqgRc8NgS
         4g71qy4ARFlJ7OxifQFx7GcBqnEBeDVwDysjbtjrImTB+AEyG2JY7B8C//twk//FR9SK
         +s5GC8ZgPcqVE3LDAFsUUmbbVVmhC4xiJaab/WA6xlKSvW3/pklo1qyiNTl8cw7lX5IO
         gOOpjh9I25D6WnHSdgZY0EuVIj/dXpA87ecmKo0tWdaBR/nXxFFZNPBMpX6RB+Xk4H8L
         7vyA==
X-Gm-Message-State: AOJu0YzYqUKEdsau1Q0NmCw2TwuFyA/QEzwqxk3u5Uqy7JzTlnRiR8FS
	dlTj/KXA7NcaAnHjuYyaU9kp2SQSIrRZgzLFhRpiswMhZjZcCjwvuHGAXw==
X-Google-Smtp-Source: AGHT+IEbwsVkSvRxvAY2F5rT6nMnLvjTxtZNvcML3szmLm4yykUgrGk3PPxKJKRi9mVm/aHuZ2Ky/g==
X-Received: by 2002:a2e:7a0d:0:b0:2ec:3ca1:e54c with SMTP id 38308e7fff4ca-2ec3cffc5eamr19224651fa.43.1718801854782;
        Wed, 19 Jun 2024 05:57:34 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e95d7sm8334237a12.47.2024.06.19.05.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:57:33 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/3] Advertise OS version
Date: Wed, 19 Jun 2024 14:57:05 +0200
Message-ID: <20240619125708.3719150-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.45.2.564.g3a7d533bde
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging and statistical purposes, it can be useful for Git
servers to know the OS the client are using.

So let's add a new 'os-version' capability to the v2 protocol, in the
same way as the existing 'agent' capability that lets clients and
servers exchange the Git version they are running.

This sends the same info as `git bugreport` is already sending, which
uses uname(2). It should be the same as what `uname -srvm` returns,
except that it is sanitized in the same way as the Git version sent by
the 'agent' capability is sanitized (by replacing character having an
ascii code less than 32 or more than 127 with '.').

CI tests are currently failing on Windows as it looks like uname(1)
and uname(2) don't report the same thing:

  -os-version=MINGW64_NT-10.0-20348.3.4.10-87d57229.x86_64.2024-02-14.20:17.UTC.x86_64
  +os-version=Windows.10.0.20348

(See: https://github.com/chriscool/git/actions/runs/9581822699)

Thoughts?

Christian Couder (3):
  version: refactor strbuf_sanitize()
  version: refactor get_uname_info()
  connect: advertise OS version

 Documentation/gitprotocol-v2.txt | 18 +++++++++
 builtin/bugreport.c              | 13 +------
 connect.c                        |  3 ++
 serve.c                          | 12 ++++++
 t/t5555-http-smart-common.sh     |  3 ++
 t/t5701-git-serve.sh             |  3 ++
 version.c                        | 67 ++++++++++++++++++++++++++++----
 version.h                        | 10 +++++
 8 files changed, 111 insertions(+), 18 deletions(-)

-- 
2.45.2.563.g6aa460b3cb

