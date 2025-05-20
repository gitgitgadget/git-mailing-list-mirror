Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3E1C3C08
	for <git@vger.kernel.org>; Tue, 20 May 2025 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747706045; cv=none; b=LZCe5Nt6+RDIo89j+hpNWqsYuQjKXlz2bt3uGZ2T4vhKk3sEQ4Ug/TquyxbwU91FqfHSQObdyKRqBwK4sdas7WUbh24dnddw6PpdBORD9XFw5OP7cSM8eyA953PSsdPHOQsB/lo2soNNYNxAszG2qNTTEJT28HQH0Bk6rB+xWOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747706045; c=relaxed/simple;
	bh=nNGcbGqR9/UDC2lEfeANxhwOJwSzyAGPLmNPyv9MoTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPDtPposJLQ1ShqfZ0MlKTtPCtNN96cdU0pVXjXkX907IwE4L+cTCi/RU+6ddt2HT7gcIi9qAMNEolEHJ6lF0EIdB8EJjeKte4gNKQhJ4UaxcQYLxdljP3iXyHeM/rfy3ddSGVtSVwdzZ+/8BSzHzkeH9EdC3FrTsZ1YVupen50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFpgHh74; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFpgHh74"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-734e0dff444so3579169a34.2
        for <git@vger.kernel.org>; Mon, 19 May 2025 18:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747706042; x=1748310842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZMOqmOQS8LgLc/LL6s5QYbNYP2XD2ogNXurCbnWXLs=;
        b=EFpgHh74jO2KLX0FIV0w1njDLZKP7LjPMPuK5TwkMSwRIuYxsG8XZXzJa6kZo0ICJi
         2mpag9wWl6HQ5mGZ9hk4DYoePCpzLZDjwfM4C7pKGq2Egm+/W7DYVnwGWxN0f1Ora1at
         fEZdIg52kwk9TUdB+Z0RCI2phUKxI4LDu7l1K29fQoFS44OhfzH1eYIzao+sMRJIsQ6r
         MTCnsSP65+gl8u4LGwCCEu/wkKeI7tr4B/C4EJetfGqVSDYqh8qCJLE55quJF9h4zhks
         eGQs41fh7PjJtHot6lcOfFCEfvf7uNWqeueiw2RUFWH/jtYQuMUl/rEOAyNtRGr8OYFf
         q5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747706042; x=1748310842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZMOqmOQS8LgLc/LL6s5QYbNYP2XD2ogNXurCbnWXLs=;
        b=TPBk0ruQmvB0+68uBCeZcokUJp6PPqwHV3H5GcNElQpqSbXV/JM3h0qUbEPayUNmjq
         6vSrL6soTZ6oxenwQOUzhZfaDvV3wFEbVOUC25Gh7RZGvmeUeXPPuuOJYh/R5z8qoOYR
         bHNMtD6eMFKuSJQj9AI9rsE9DSV9ojpJogulH+E9J4H6EgDhUfW7Ow/RkqVzloyjx8/c
         Nd49c1ij/wk4ODlzXz2dumyIYOPndyDvMrKom4UgTLOW/RJjpdO11EnV4DKP3cwIXGnM
         5inkyiVSRj4herBa6lAtArujXpZGAgU67mgNZMCSeF/lkhIz2O/sNo60DCZP4NIRcqSi
         LryA==
X-Gm-Message-State: AOJu0YwrX60cMF/AbDxOcgrkwfz4oGD0wmf1vjB/REGkz7Ft1kaWfsgX
	gS1fWuJ8NOy2RsFBR/sxDl+G7vSRoB22Aw6jiF4DRb80hexEsBPIEnieekS5CMBj
X-Gm-Gg: ASbGncvRGpFGFPfbfbsNXMp94wdd/CPJo3cUqDZ4sfxyC08W4/B+GMUcTdWriIoMbSd
	hmy/PL0MQFifSUG8lwKWy9aUfQ2EbfE2xE86wwNsC4TUUN3tDYC73sRYymouubBbeYz/OHbg6aT
	bjJd/7ku1QdlB+rDwKG+4yEkPg7FsLih/SlZ75++vSEvYUb/MhOLHwOUn+8qlc9wJiaVs5NhIsa
	4w8NirLTeHYg8ut5xqb4cp4RawyKGQnVanRqNHXLanWkCdlYrQBtVIpLhDIuZQ9FpyQQcrfT7Sd
	pTJW8RDEZqWbgG1Rf6sjeaucDoNMGbMGMOv5smF3BCoTpQmxSoUlG+KnxkI=
X-Google-Smtp-Source: AGHT+IFabivwYOD9awmSPjHHOqEzjRDNyig0EZ2RnBcDnxUM/eg0mlVgyWyKuC7LpmFJcLo603WF7g==
X-Received: by 2002:a05:6871:60c7:b0:29e:3921:b1ea with SMTP id 586e51a60fabf-2e3c1ed632cmr8509451fac.30.1747706042041;
        Mon, 19 May 2025 18:54:02 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c0b21fe5sm2006368fac.45.2025.05.19.18.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 18:54:01 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/2] builtin/receive-pack: introduce option to skip connectivity checks
Date: Mon, 19 May 2025 20:49:18 -0500
Message-ID: <20250520014920.201736-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.111.g5b97a56fa0
In-Reply-To: <20250507030249.4802-1-jltobler@gmail.com>
References: <20250507030249.4802-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

At GitLab, we are interested in introducing an optional means to bypass
the connectivity checks performed through git-receive-pack(1). This
series implements a `--skip-connectivity-check` option to facilitate
this.

For some background, we have a transaction management system that runs
in our Git RPC service and wraps all repository operations. Operations
that write to a repository are first recorded and staged outside of the
repository. When committing a transaction, the connectivity of newly
written objects is checked by walking the object graph containing only
the new objects from the updated tips and identifying the missing
objects which represent the boundary between the new objects and the
repository. The boundary objects are then checked in the canonical
repository to ensure the new objects will connect as expected. All
repository operations are run in a transaction and conflict checked
before being applied serially to the canonical repository. This ensures
that operations that would break the repository are not applied.

For our specific use case, the conflict checks performed by
git-receive-pack(1) are redundant and thus we would like to introduce an
option that allows connectivity checks to be skipped.

Thanks for taking a look.

Changes since V1:
        - Instead of creating a new test file, t5410 is generalized.
        - Test assertions updated to more explicitly check for object
          connectivity error messages.
        - Updated commit message and added documentation for the option.

-Justin

Justin Tobler (2):
  t5410: test receive-pack connectivity check
  builtin/receive-pack: add option to skip connectivity check

 Documentation/git-receive-pack.adoc | 12 ++++
 builtin/receive-pack.c              | 40 ++++++++------
 t/meson.build                       |  2 +-
 t/t5410-receive-pack-alternates.sh  | 44 ---------------
 t/t5410-receive-pack.sh             | 86 +++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+), 63 deletions(-)
 delete mode 100755 t/t5410-receive-pack-alternates.sh
 create mode 100755 t/t5410-receive-pack.sh


base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
-- 
2.49.0.111.g5b97a56fa0

