Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60098145B18
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763079; cv=none; b=Bs26Q5FbKeU+pBV4XFJ32nKWwRpRGZQ8AP474th0fht9vtk/Ie3og9tv5aNuhRgvRe36XlE/mKYHujJW1iss66UinJUw8QHq57cFiijr8J4JEIgHzsNK7t1CTWcDLu8pI1W230nP3WSg1/iqWeILadJihuodp8ecUrqRsun/S28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763079; c=relaxed/simple;
	bh=cyYj59H5M5GC+KFVmnpIOXPZClucBd2xlIJqvcMQyag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0ssJQb07/dTT+JSSWuCw0St+o2k8eBeBDwsYJ0C0GeTbE79QwoNxnvruJWPmUjBOjnnA6wqC2TmUEJQCcjchHWmSW6oOw8daPfsP6OPinGb0Ojv1c/eBVe7OBzLWQ+gxIJg0LvlZmtyAxGXOdBvb3rIc0d2OV+7us5USpLNkyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGaj2QmR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGaj2QmR"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa659775dd5so27426866b.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763075; x=1734367875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmLTGrfanphQq8deoywRnwX7tsfX/UWz40ST2nzYHtc=;
        b=iGaj2QmRxGwwYegwsCVCU4MzIQjvLPUqpJydwyLgNFQDyYFL4ce7CXUpHllcvMCjiP
         1n0GpbftGjm1WIEeCYUObRP4DHqjE2LFc49/vWLHUToiUk1/QnIyCg1XstrG1uH/EQMd
         ALa/PBbVljA3Keob8+2XBbwlmOz+rjPcsdzqchieDdzG3eUWQhkGxHzL4Q5DKtf70bV2
         WTfohUZ29izh5Eq4VyMxxKsHf3+PAEoR/y0zsH7QKesJBdSAii/Ybv2T7KmP8DT5lvR8
         0WuLsybgTZOXXdRxXLnEBaJBvLd5l/bGZSdGE1a+nmjv+nV3HalSyi3SrRlGSXt3X+jo
         7bFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763075; x=1734367875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmLTGrfanphQq8deoywRnwX7tsfX/UWz40ST2nzYHtc=;
        b=hhCCa90gQYZhdBq0c1TISkITFVe1TzZ1eJRHrVgo+ki3VfhzrKOCfuwQ/wGLfHcQb7
         uDPKSixcEbf7JBXENo0KPlOPGic9lbLP+ip+CHJ0/cP+3qq6sk/BqnicFnDVydiFijuK
         W7i0mMJT4bCZ0zaoERIbCSzHrFECdw9XuwzGpGEwR6p4WkITIu3vG+NUBMcGtxY1lRa0
         0rLJ7E4YORABoke1Q8C6y5ZXIapqAmg95lIjNNOk7XCcdgx/dOdNLGW2aw+5XXOxuEE/
         kNlRZUwACiZqc9F/L/pf7JEG6+REDFAuCaErE7vKRcHrE22UktIkPioYH46gwq1dMM4L
         7ipw==
X-Gm-Message-State: AOJu0YypPcdX5PCzcSyiIzZ3nXgPXx10acF3Fqq4Lcd/9kuDghUgtvsw
	32VIySwxIWMuzfodqy3h9fqpMBqyGmRerB/XPkLsbDpAb6CRSa6OiIMOvYE/
X-Gm-Gg: ASbGncubOOmG4sgAOs/6gSScKfNam+LDqjYrS8AfVxXKe1sjHxVmPG4grxilM3gd9mB
	lks1qMi+4lsdY1gDzZLUDBehwIOIoKsj1yM4Aws3YmhNoD3bJVwEA3mKk87ODRNkrFsXhLeNhHn
	zH1xb/U5aNhNJEe6JvYeIBAkWS/06EvlUo9PkOHgVKoJbRtx28ZXYfw0nS3oC38Hooi0FdmoIsY
	0hMWL18EQ9f5cnbbCqaRE6hwm6pkxOuavIs+aAHc5EMYneRbftpoPGrKjI=
X-Google-Smtp-Source: AGHT+IGiU+satkm8cdx2XZH1KOrqFsvhCLOzjLYtI21Qe0BY6uW+3tBrwhs7UUw/62GTHWEaAYujPQ==
X-Received: by 2002:a17:907:7285:b0:aa6:6792:8bce with SMTP id a640c23a62f3a-aa69f13df7bmr15613066b.3.1733763075162;
        Mon, 09 Dec 2024 08:51:15 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474e27sm300539766b.102.2024.12.09.08.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:51:14 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v2 0/8] git-submodule.sh: improve parsing of options
Date: Mon,  9 Dec 2024 18:50:01 +0200
Message-Id: <20241209165009.40653-1-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241207135201.2536-1-royeldar0@gmail.com>
References: <20241207135201.2536-1-royeldar0@gmail.com>
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

Changes since v1:

- Make variable values always contain the option name.
- Rename a couple of variables in order to improve consistency.

Link to v1:

https://lore.kernel.org/git/20241207135201.2536-1-royeldar0@gmail.com

Roy Eldar (8):
  git-submodule.sh: make some variables boolean
  git-submodule.sh: improve parsing of some long options
  git-submodule.sh: improve parsing of short options
  git-submodule.sh: get rid of isnumber
  git-submodule.sh: get rid of unused variable
  git-submodule.sh: add some comments
  git-submodule.sh: improve variables readability
  git-submodule.sh: rename some variables

 git-submodule.sh | 214 +++++++++++++++++++++++------------------------
 1 file changed, 104 insertions(+), 110 deletions(-)

-- 
2.30.2

