Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB6E57D
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737532349; cv=none; b=Fi4/VjycfQcrmS6fEMMbGccrmu2OssCzinlnKBilHkmxua2dgm0Aiuy678U6FrntpIW/qoHGyHbWmVWUfyAgcuCc487hOIs5ISj52uCJZWKgujfNCBBW/QpRpZL6vN0CB/Sd3tmG+B78ECQBepEpfInQuIet+NFgFTqxmIy4aQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737532349; c=relaxed/simple;
	bh=F9XApTD0cViNFdrEV8p/dghA4O0lSy6tZDyFrm0MJhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=leAISdS7j64XiLkhWAdXhTloGYchtkHSkLUxgTLz3/actf8KwyFDAzfKD993oHy9jI8FbSPqVHJVbdV+ud08QdPoVt0XWNDYtDPz1cAxu8LVOO9k0Kw83BbyOte/U1Vir2RjrrO0P+bbGcZGfSizCCJ+gO/NTfge2hsPShl9tWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyzLAfij; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyzLAfij"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215770613dbso84824385ad.2
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 23:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737532346; x=1738137146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTyH4OpgMsJ1hNgPIhv6fhgJQQvEU4bDz+GxT8uBj1o=;
        b=hyzLAfijx4qcD4APAqo+mUggmiDB/zfOiOYuscI8/mcxNid6iuB+2tJIlJjV6S9lt/
         5NBCIB2VpMlNxMIi2+ng5O5VDNKIEr8rZaIy6mXhse+7x3CjneelA0NTzxKk5YWSSso1
         bnMnrrwb+Ij7WaZmEh6kLhV5xY5rP4GM+uKQaoF7NkjI6mRkrC0hEGuDySpwiZ0YULCe
         pZPFK3KpSXaQfhr+2VzZURJZ9V2l73yMj9ALEPYTVeqI1x0srT6WER0Nlo1+QQDQxYSB
         Ilhnl3szLLDxCFFULbq9KF/fJFm3L4x8CC6mt2/dkex7OCeZIa9dfrfbjBZAuk9EtG3G
         BuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737532346; x=1738137146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTyH4OpgMsJ1hNgPIhv6fhgJQQvEU4bDz+GxT8uBj1o=;
        b=eE2MyrehWBQW4LXXKpY1QFuftTkGyJVfiwykjjDT1xZuvtZaypcfY9BYMuU5SCnFk4
         dpBByF2OZHMu1ENRQFQtLNFHnXmf/4YRZx/Rn8kvWL2Db0mlZ0PrsycHdSxjPqjvyCua
         JzeI6jgiEU1c5vXP6tuk6qTS7H4ubybcWpy7HgCnPxC2KWhEU6WtJKKK2mprISnxh8sn
         D4WpHLJ6jnkBeVp/oOMEXQ3f/4c0R+cRQEy6Fa/iOSSfUztA/QxeXulMaKjHOzER/sU3
         ovmQhclDeNqj+qwD3v/ZiVR9PHX/mpxy8xlXOiZwLD4YcsM8JJGkshYKKvlS3LviNgT4
         uaGA==
X-Gm-Message-State: AOJu0Yx1QoNJ4hpNN65qnKxkJyoIzPddHUuCqxWiGJEx5Yx2KVAtUWeW
	dpHEjYyKvlOFu0V9tKwp9W1HvJIT5t1anmwoZd51B2J4eqaTWP2haqOGyR7E
X-Gm-Gg: ASbGncvXj4cS1L2TWuIyuOHK4kwiALwYKxCmVKZDZkPu+oOROrw0J7g6zTBdRgRUK8k
	Yo/VEPo7UKicXKT9xX9RYsglUedILKTFgIbKJEYDdhBacpOYSwQjkdyE5tBZYXTOJV70ksv7hUc
	UT+8enB2gET5NKsSg7gUQaD2+TIIlAp3smq9jrqEBr6HrGB7FL0AXZ8RfsnQdOjRYAYBFvkTCTQ
	LnN1e7O+TvEpQLhg9Z1iM/fTf4kaczS5Pmp0uHghc3odCeMH3BbC7KfnAT07Fb+zT7M
X-Google-Smtp-Source: AGHT+IEVWni197Ly1Dr2IUHEpDrZPoGaAIseIIsTY8r1wUyJtUgBaSZAmWkOriJmAyeIBXuptfD+PA==
X-Received: by 2002:a17:903:2a88:b0:215:9894:5679 with SMTP id d9443c01a7336-21c34ccef5fmr304498915ad.0.1737532346232;
        Tue, 21 Jan 2025 23:52:26 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3acce3sm89284155ad.119.2025.01.21.23.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 23:52:25 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [RFC PATCH 0/3] refspec: centralize refspec-related logic
Date: Wed, 22 Jan 2025 13:21:51 +0530
Message-Id: <20250122075154.5697-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Patrick pointed out in [1], the logic related to refspec is currently
split across multiple headers. This patch series addresses that by
relocating refspec-related logic from remote to refspec for improved
cohesion.

There are a few functions that seem to be on the borderline. They seem
to have refspec-related logic, but also contain some elements related
to remote logic, so I'm unsure whether they should be moved.
Specifically:

    * get_fetch_map()
    * count_refspec_match()
    * check_push_refs()
    * match_push_refs()

[1]: https://lore.kernel.org/git/ZysQvUyxgdRqjvj2@pks.im/

Meet Soni (3):
  refspec: relocate omit_name_by_refspec and related functions
  refspec: relocate query related functions
  refspec: relocate apply_refspecs and related funtions

 refspec.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h |  23 +++++++
 remote.c  | 201 -----------------------------------------------------
 remote.h  |  15 ----
 4 files changed, 226 insertions(+), 216 deletions(-)


base-commit: efff4a85a4fce58b2aa850c6fbf4d8828329f51d
-- 
2.34.1

