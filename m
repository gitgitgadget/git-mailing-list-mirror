Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895935967
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856331; cv=none; b=L/C0y920Bf+mGhUl6S0lvagF8P6BuCqc0rGvQEueYHlxRC8CUf/axss/8iQr0QGc71pqBW8swMVnw6QlgZL5BZYvYGj2AApu68pTrsee1hLRtm7vWLeOdEKiIYjRcm0wNCcYJAU9y78Ep/dW0/rA5kqinJF6CeRKNtNpIQJc7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856331; c=relaxed/simple;
	bh=sSCM1Y332DxWficGsPOKa5NaG/1QHrnhnK+p7xt91bA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ksz9porGHDvcu5u7TAQuKeuxHtx30OITlaZZXsZ9qjxuehQl0MmBpNwf6QrOFQnUH/nlz95n0BfeEVYuN5RC05CjbcLrp/HKRsHTrtnPCLkxDZU3rxiT9DYSIphpXBlD7lp+Dne2XBrs5vycVdK2xV1htyszWbf7ExqGL1RHXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0Nmusfk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0Nmusfk"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3cfa1da14so457465a12.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 10:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733856328; x=1734461128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntV5lc2j73nsDW/KE0JEb+WFKWS/2ZUyOLDlZ6+dJuM=;
        b=M0NmusfkH/g93s9MnJxPRtFWRwqWJTjXmtnmOvKDql1Hrtmdx4E5Cbbt5ipIxONspr
         wbWWMhvVge6cofM1QLQW/d0lTyf+rugo23hbn2ZaA0Okra0rMq3JC85xmjXzDQNN+7Qh
         R1ReZLkzmtSePCDN+LIB3fvDqI39Fia9ZpSZm9Uaq2pRGLCumj5X1CXJMSUJPdPI9aIa
         oH2qOcOqYC6qKJUUsJw8HWfjXbefGhKr0QSDYNtFX+GummOgl2CyegX3+/P4/RtMrd5m
         WFdz1clScQT1hdwejw4hloX5IGGvCFuxwWNFYUlrRmVuQDqqUchfHewHplqpOOhLrD0N
         KqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856328; x=1734461128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntV5lc2j73nsDW/KE0JEb+WFKWS/2ZUyOLDlZ6+dJuM=;
        b=EFfL65FBn7cQNWPHulla+8kKbQSuGmAflNdcrpTqfsYEWorAtMfGDruaCq0SWefkGX
         i6PCRVu5foZXGjQoyNlEABvERtO0wghMv717bIE3I4VwkBVEsm5CA+bLxDHW2g72P9bU
         O8StdMtgbsnkdzsAPwQoLA6zltBU9e+jFufZ/JHRE6T/S5vmjopnEAV80dXRBF0JAesl
         zXHFCdUJWI0Ec3NW08S0G0gEkciGWbQxrRqYhbCtnrTGgSvkCXQ9pjS6Vmq4OhCpeBjD
         WIUiqXOAvP9pespeSF+PEJW22Gz5f6m1zGwO6Y0Py3Nvbt5/f6AfXuGEzDIyukR3Bqlo
         P0fg==
X-Gm-Message-State: AOJu0YxF5pJ2cAQFn5de8roxR3akw+wDkYmBg2z4/yNOo3Y7Pz88mnaR
	VsL3aw70WwLaylMPeRMApRe44FHhl2LL/+jhDZbb69Ld3X+G7v+7qLxAjK8/
X-Gm-Gg: ASbGnctEhbGcKMscTt8Wyxdd2XfT7woo91ugoLIR6lcK3smUMiDgNRjloqZ5Nj2GU+8
	6aukli8AXI0zuWYgOtWpuEIicbf/c3BAP6J0aexcsN3vhPMOdsGOZS4ePytkcW3pPzMnLCWC8xQ
	DPTBnwRN3lj6lM1QGo+icDx9PiiTUBoO6DOc8jQH6lkYB2pk9IIDlh2whxeDRaTa6LcMInB7bnX
	vl7aQlnPN0vcLfwAoNUV1srNdInP3DWS6ynvAEZvBqrxRRElzfn4X3BIdnDp7E=
X-Google-Smtp-Source: AGHT+IFQFUj+7n1ypXNgfl+60PfPYotZ8Ie7mS8qB+9+cu2QHZ/1zO/8HYwiQIVyEhl2QKvhSThCsA==
X-Received: by 2002:a05:6402:34c9:b0:5d0:eb6b:1a31 with SMTP id 4fb4d7f45d1cf-5d41c454e66mr2029507a12.5.1733856328065;
        Tue, 10 Dec 2024 10:45:28 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48882sm7895896a12.24.2024.12.10.10.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:45:26 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v3 0/7] git-submodule.sh: improve parsing of options
Date: Tue, 10 Dec 2024 20:44:35 +0200
Message-Id: <20241210184442.10723-1-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241209165009.40653-1-royeldar0@gmail.com>
References: <20241209165009.40653-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we run "git submodule", the script parses the various options and
then invokes "git-submodule--helper". Unlike most builtin git commands
which parse short/long options using parse-options.c, the parsing of
arguments is completely done within git-submodule.sh; therefore, there
are some inconsistencies with the rest of the commands, in particular
the parsing of option arguments given to various options.

Improve the handling of option arguments for both long & short options;
for example, passing flags such as "--branch=master" or "-j8" now works.

Changes since v2:

- Remove redundant patch from the series.
- Rename another variable for the sake of consistency.

Link to v2:

https://lore.kernel.org/git/20241209165009.40653-1-royeldar0@gmail.com

Roy Eldar (7):
  git-submodule.sh: improve parsing of some long options
  git-submodule.sh: improve parsing of short options
  git-submodule.sh: get rid of isnumber
  git-submodule.sh: get rid of unused variable
  git-submodule.sh: add some comments
  git-submodule.sh: improve variables readability
  git-submodule.sh: rename some variables

 git-submodule.sh | 216 +++++++++++++++++++++++------------------------
 1 file changed, 105 insertions(+), 111 deletions(-)

-- 
2.30.2

