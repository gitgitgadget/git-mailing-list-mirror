Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B1433020
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220951; cv=none; b=HUMdPPZjvJ23qWNjyJkcLxXecHCH/xvACsbauCvNSLn7FetRUqd/htQneU9oCgbvy5VCiS6QEKBUAHCAi8v+jseX2axkbV3Z0OhFqp/RHEDgKf1pOz/rwMLvtP2gXUQ3BT5h96Wl3JYEnboJoovJjVR4BZ5HGCZacRcZmKHlTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220951; c=relaxed/simple;
	bh=sOK05h1VS/Kq4iXLZ/2ggeNqCX7ff7A8En/oX+v7pzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uc80IL4qfHGfMzLKQZcJhKD/K4xTYkgZ9aWTPBAlTTDb7rO0kjec9NK8wOsqo9zbwuytqTaEMxTuMjzZtx6KYI5h0ZOMdYVnqZpkoXgSz2QeZc074bUSIKG8okhjmWdEs/YOllSIZn/EqrYPWOaqWONKC8tgJbTpGNZlOwQ8FMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEP5pDPe; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEP5pDPe"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so3354232a12.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784220939; x=1784825739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/yoEASeH3YQTzAD/KNUa25I+ta20d/v2d97GyMhH8fs=;
        b=IEP5pDPeGs7/VniUf2B39Ef1AEhbuRZewR2aOp5brcWi4QTTx3gHiwE+NyDggkMj8Z
         leq/0div7NdfxB5MotkRVEb8lbncVuZqiEAsTgs3MUP6ljROSHlWm9eEDcEFGDBUtzMD
         VFhSj8WdBwPStVnE5aHWGxbvlq7Oc7S8iMxQsFS2XILFRnY5Zd3LCOmnjCHS9gQH6YVy
         o9TYM8IvTbfKQBkoOHJIFtJFajx4nqnpjqSGCJE92Dhep5ILZNyM3I+DVljhfU5i75wF
         xL6RCwsvNBhYvkyhED12Gwmn2Qxjfcqzhqi3ijAwAqUXJsUEhDmqf7GE7nH7ek3s9957
         bZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220939; x=1784825739;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/yoEASeH3YQTzAD/KNUa25I+ta20d/v2d97GyMhH8fs=;
        b=EaYTFNPMXtsqmeSkOZqoiGJ/aNoVL4JFNsj7cDLfAjZ0b0ayyv/MJ9M/2veM4Urwkp
         RP+o5K6L2AWLtcbSEVHheE0UFnKd5GDtuxRnsa9+13TPaSxaUUWbCopMggHq469JJ7eo
         CaAB0w+vjbDcGWUGvx+3T2ef3VTstmzFnYxxXjCoubhtIXu1QVoAa0nGl0DFuoozs1ru
         sefh7zzl/Fl8e2+0XPK2IrESvtYdZbHPXxm6XBCV3r61o0mzBAYzUQjyWDQqTe6rO8iN
         wEBjfDGMYrmEHa/sHIgAtUpQ5Pj/YaNMKLzstMBAyLOAlza6NDjbmQ+As6flYH7gu8Jl
         rmsw==
X-Gm-Message-State: AOJu0YwepOFIWmwy2zuIrPe7cg06HmzD+SdEMltApUCSlc4H/D/7cDnf
	LOYagvIDk4unrr5F6QdXkTv2rZ+05vby3bGZ9ANNigxyKckboahfdTMCL6Eom48PYb0=
X-Gm-Gg: AfdE7cnHt1OcZVrgF2PdxKVihFSIKagsfi9rrAXTsSX4DaK5rzBURvZxbNQS4SYhE0f
	46/dL6/68vz7q/ozOgOkn5Y7XTLof8BxCRglJbC4V48z6a2ayBd0M1YNYCmqpRo+O+xuMpZ05lw
	6xnFkVlJc4UNnZ7n04mVD/TbTRYKk7r8pdQXrJ5CjEaOkpr/2pTHU6RVv3Ey44Ol0gbbWTGiyVz
	4LFJlf1a3Ic3ucuCDHG3P1+nbcjjk40E8Fs3GBVk+ffQWp20+lhUs5FUEewp9+MBY5lHc82CMk3
	6DRMG4PPnXuSp7m4o+G4wiL64sa7JVcK7DO1A4G4aY/NuOgIU42/z+DqzvapH/uZ16/wWITCkCd
	yAyiHYlkKsNjTVM6mzMhZnPuPMdcgiecTns6YkISdOKRaQvISkwoHAv6GQNYa66G9skZ+qFbF/D
	44JNSJn3z7hKtRf//PzjSHrcou3inLR3burihyDg9/QCVkCvKv99e8Hr2R3uP1wB/USOTKFjNa/
	0yIgL/PwUrKym6SHH2Ku+bSZyDV
X-Received: by 2002:a05:6402:40d0:b0:698:aa82:3d77 with SMTP id 4fb4d7f45d1cf-69e19ee9729mr4181228a12.21.1784220938425;
        Thu, 16 Jul 2026 09:55:38 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2937527sm5017149a12.20.2026.07.16.09.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:55:36 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/7] fast-import: standardize usage string and SYNOPSIS
Date: Thu, 16 Jul 2026 18:55:10 +0200
Message-ID: <20260716165517.433849-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.185.g9120d2b5c0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The goal of this series is to improve on `git fast-import`'s usage
string as it is obsolete in many ways.

Along the way it modernizes "builtin/fast-import.c" mostly by using
`struct option`, by starting to remove global variables and libify
that command, and by introducing a new `OPT_HIDDEN_GROUP` macro.

`struct option` is used only for the usage string for now and there
are still many global variables left, so it's left to future work to
finish on these directions.

But this is already enough to standardize the usage string and make it
consistent with the SYNOPSIS in the docs, so that the command can be
removed from "t/t0450/adoc-help-mismatches".

Overview of the patches
=======================

  - Patch 1/7: Introduces OPT_HIDDEN_GROUP and improves on the hidden
    option tests.

  - Patches 2/7 and 3/7: Improves on the parse-options API docs.

  - Patch 4/7: Cleans up an 'i' loop counter variable in
    cmd_fast_import().

  - Patches 5/7 and 6/7: Starts libifying "builtin/fast-import.c" by
    introducing a 'struct fast_import_state' and using it to store
    some global variables.

  - Patch 7/7: Improves the usage string and SYNOPSIS by introducing
    `struct option`.

CI tests
========

They all pass, see: https://github.com/chriscool/git/actions/runs/29513714019

Christian Couder (7):
  parse-options: introduce OPT_HIDDEN_GROUP
  api-parse-options.adoc: document per-option flags
  api-parse-options.adoc: document hidden and OPT_*_F option macros
  fast-import: localize 'i' into the 'for' loops using it
  fast-import: introduce 'struct fast_import_state'
  fast-import: move command state globals into 'struct
    fast_import_state'
  fast-import: use struct option for usage string

 Documentation/git-fast-import.adoc            |   2 +-
 .../technical/api-parse-options.adoc          |  79 ++++
 builtin/fast-import.c                         | 372 +++++++++++-------
 parse-options.c                               |   4 +-
 parse-options.h                               |   5 +
 t/helper/test-parse-options.c                 |   4 +
 t/t0040-parse-options.sh                      |  25 +-
 t/t0450/adoc-help-mismatches                  |   1 -
 8 files changed, 344 insertions(+), 148 deletions(-)

-- 
2.55.0.185.g9120d2b5c0

