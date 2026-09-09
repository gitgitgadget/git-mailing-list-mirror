Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD93932E3
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983417; cv=none; b=Lso0TUhnnkQzE2QEuNo88x+GPjjXTpnn7RF0Cs6F2wPD5v+qGZknLJjq1zwDXKU2WNSIgwCjn58Q4vcsLaAD+RKAal1U6pKEXqvo+QKkio6kCoOS2gCRMy7+0v2HceTiM9VTfQ5OPNXHhsggUSRW3D41qJ9vqnpehCJmouNIaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983417; c=relaxed/simple;
	bh=e8eNuD0d4iwYNUIE5sWCqIUaE47fOOB3JYhDMfDx6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ROE2K+6pxMx2jMy+2vRCr2yIScIfcE3ddVbspHrNuX6jDu3ryGkr3E1aR4X8TuHVF2zJNoCsreJD4Tr57DwJAAmfnQgnhp8gnUz1DVheweeN9I2uT8lJDG9JGl2eE2T+1zUu4ihyhsFiP5PKJ/LQDKddO3psHKxQ3wlIc+5vEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYgWdUb7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYgWdUb7"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2938116fefso176448066b.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788983413; x=1789588213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=viXfebyiogOY00up0/8ixJkYzYjvdRCy7GROGDISun8=;
        b=oYgWdUb7aIMoUUMQ3lyyFETPbRqAG8snvNmiwPSG1sxEVkwiIuwgaWmSlB0OL1wJf/
         nbYHHHIzWJdpd68TC9areoLWrP1m0i2m2n6ib4+um6YotNaZos2JsJvcMdwXma8Q7tzN
         z3zJxYtPGSUWmkTic30rNccrZVZeZgkvkEwvR/d7JXGkKxGV9XWiFLsRVy7jU7E+dTGE
         qitG3O6k0AcoP3aSF3YdurrdF2Xud1YK3uFqRsXpfErrHRe329OOlm2iVQo424/7XQpl
         ULYS+pA2fVfJ5k0qHnsHZ+Y1m4UJO/wKy7gKScjxg6iIqNZE1fhaMO0M5DIYz5+AzvNK
         1SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983413; x=1789588213;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=viXfebyiogOY00up0/8ixJkYzYjvdRCy7GROGDISun8=;
        b=iI45u8rd9i2TFggUoEPWLfU0rxhnqVAgjGqemf6nd+bqpTwWjw0wR9dip3Oz5V6Zcq
         GaqaHi6ifot3R7+h0IiK4VPRLBGnBJhPZe6T2PIqgvVfjHsdqOe1WcMrDR7Re6nH9mWC
         SJn2ITZdH8UltdB6oPJlQtsNrWJZIVdLZSWQPr9pVgE3X1DRe4iEkML15JXr+xxduIWP
         2Zjl176jzGxIHSogKbHforYp2ArzvvYdQQur3epHdtuoJHc+lSrsOrKThULEHj1OznEk
         t+BbLZIz5RXRXm4KvZPc8cbVg2BeBFZw3OzI4O3chotbTyMCbTVNpe4wQ9u8ahdKMXKK
         ivSQ==
X-Gm-Message-State: AFuF++krm4bScW7vsBLeeWeXrr5foINREJrKINKkBK9qLs+WX0KjBIT/
	v8ukgZOBHfdPlzKeXRkpPkCIg7jqs4m3cFFFrBS5Lc8A9Ok/Qas6C5236tTGlg==
X-Gm-Gg: AYBFou32yjH1JjCMvOMYrzpe36IcqRYGPeOyYF9l8HrmF+4k4vCnKaSgNVkYK2KK9b3
	LwXKdkV8SGAlp0QPjkW3Wf3YM/xUy0AJ7rqWClfQvgwPgh6JNXUr8uwAHBp88mC5UHzGMOZwFB9
	4tXVniCfsUHx8ajUICHDmR56j2yZDRpW73etzBghB2KSozKBEsW2qM3qkfAEyDc897fShKYosQA
	27A7AnR53xTtnO5kC/jhRHZicM6x2k/D0Clya8EcVfXQtPeM4ofKuyGWKvEUH050t3NHIh9n+QC
	Bpd/6G5L7F4FBHsMIXISRXulQfVpAS1nYcd1KiT27r5+YVEbeCw7ifAHkYw4AzuJTz/yBCBuKsh
	7g7fzwOJgdamxJYNNbwtES4mrWqKFrWfaS5gU6rju1XYol1zpyTM6CSTsB21NK8/DuXnwghdakr
	Hl+yLIn21arHfq9xC6504jgVYpzTwTjNOes/RavhZZEvQxbY7yPzVqIfIeO6OzSwdrV+fxD0V0P
	35ZO0a3LbrZEihKiNjfexu6LJQ=
X-Received: by 2002:a17:906:ef0a:b0:c12:6d25:2c7a with SMTP id a640c23a62f3a-c260c9e2420mr1495178366b.17.1788983412462;
        Wed, 09 Sep 2026 12:50:12 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260cb7a18dsm816929366b.0.2026.09.09.12.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:50:12 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/4] make: precompile "git-compat-util.h"
Date: Wed,  9 Sep 2026 21:50:02 +0200
Message-ID: <20260909195006.2179119-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.55.0.1193.g1b994e35de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update our Makefile to make use of the recently introduced precompiled
header to make builds faster (on my setup by about 35%).


SZEDER Gábor (4):
  Makefile: remove XDIFF_OBJS initialization
  cmake: remove any "$(*_OBJS)" variables when parsing Makefile for
    sources
  Makefile: reintroduce REFTABLE_OBJS
  Makefile: precompile "git-compat-util.h"

 .gitignore                          |  1 +
 Makefile                            | 59 +++++++++++++++++++----------
 contrib/buildsystems/CMakeLists.txt |  6 ++-
 3 files changed, 45 insertions(+), 21 deletions(-)

-- 
2.55.0.1193.g1b994e35de

