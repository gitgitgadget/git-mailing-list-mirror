Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A1285067
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666670; cv=none; b=oBhXncPDqwXWsDhq0+a4YzrTrwI1Q8y+oFR0TXquR5/TMILjo8S+orkBFF6Brp4N7sycQVzhCfOYhhbAQzsF9cLxoleIaQZYDwHCHHtd53LFQtJHgdKEd9Tug/mxXaYqnL0wZ4QoupOKmI/U0ZPAQXWRk9bZIJnJGgJxp3GR4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666670; c=relaxed/simple;
	bh=UXv5mORioX1LsAARlJjSkHvoKvsfZ502stTEsQmJuWY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=rYDUplgLfEL60rt/WzVfjds/mcd1cfTVtrgLNGn++NjjP+4PFZJKhNm8OjmAXqMdmArlO7DhCBaACSdaHFm9x3ue88mFEhMFWppFw9wdokkXcbn1x2A7XjU9HcfZS4MirxXmgwHDeTCt0PPAX34vn9Bt2tce3Ak1BOJtT74QaV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVZtm0v+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVZtm0v+"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78310b296so1144591f8f.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754666666; x=1755271466; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0tO2wEsFWO7gLfwjjFRl3U16y8oqE2MVgcXpwD0zAfE=;
        b=GVZtm0v+g5eXAaB5TH1G/7A9jmfKBPk38bgwT7OGzXMGT892YDN+mN5Wfl2nwovlAS
         8aMY4s6aRmh+FaWag6o743lwx2+o5E5LB29m4CAWyZybqbhs1vnFUcrphCzRF35hoSWs
         WIVsim0h9b2Z/rV3EnR4d1z22qBk9BZxFUg+A79uoi+wlHuSTRwhw7hwjstgalhW4eWX
         zgV/Ssv47JAFtWbuRI2Hv951mRT/NJZCLy0oNKxFfQSgsREgXTl2RK1AaQH0wSeMJIqV
         4i/O8ygGX2S+puMiR6eO7tBxogsQZfph8g0xA21vrI7UNtocgTMqfdATNGB7YEwMXXl3
         REFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666666; x=1755271466;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tO2wEsFWO7gLfwjjFRl3U16y8oqE2MVgcXpwD0zAfE=;
        b=SPUPVm+q25nof1gLzelRtZHXu8qZQEacOzHoZfL4jSwFFH9+7Osnrqc7cqkGNbICYA
         yuPwYUgEyWb00UnPRFEXtyadP+xBhoyzvx4LFlsz8F47wb7hdjLgJPX0IJAbRoyBhtMm
         zmfWo7luRG5YH2AC22gPYoef34BOncZgafSNnY8l6g5MpOUIzIpxO5oVUyEFriDtDBum
         K5JQ0WJLfI9uKImnZ4FXbExxa007yl45sDsaKJN4xyWE4yx2RmNhUg6/OPPBUiTSCs3k
         nvhnXiBeagmXbCHolXvAzaroKsSAniyqm2+MZtHlI8i447D8NjD5eWLAeUmBByNdENvX
         6a5w==
X-Gm-Message-State: AOJu0YxtuO7ZxF+32izLL0ujYFjdRmv6GDYkjmxf0CcEUdrkV3mq0G3V
	brSvqP98e5wYW+mRgM03pgVbldEZBNuB2bFgnIC/hTMmlKqADgYzbpX4UGhVmA==
X-Gm-Gg: ASbGncvEmibvEyBlGy7EW57OnnwUTPAbUIjYa/Q2f9pfcQFRlvbmjedplExhWvea6IG
	TNXgBXG7syeANY9FWNUvewyr0BW5NGY1VDAmF/Mizte6NWo6C65bOJ+10DSHs7YipUCnUlj7iis
	huQ0yvdTqR5PV5hlWS8DfqyFMN9Gh7AxcBmllBFYP/m8uY0S9xBxmtN3PoQj2SioB7R4wM1CNbN
	179VE2ASqk/hCSGTaR6mewG2MP/W/+c+5gffxv0ZNf/udxulubUb4gJR8x+jFqW1tVB+qeULmOw
	m4/GdGV86ZdhjNwrw/yEWbQFGA7C/xsmSYCu7PreWN1wxRf0TsfHRqDG8CBHvE4SgSphS383OO5
	amQxjjppegjeeWwuW0+s5Tl0=
X-Google-Smtp-Source: AGHT+IE4XGDMItC58Kg8JXcr/xaXSXVbDK96uHO9IOZ5w6XonkTnkabWFCgQBS6fJRFwhZ8mgBfquw==
X-Received: by 2002:a05:6000:26c1:b0:3b7:8b5e:831d with SMTP id ffacd0b85a97d-3b900b2d7admr2889709f8f.17.1754666666205;
        Fri, 08 Aug 2025 08:24:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dd85f423sm202346705e9.18.2025.08.08.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:24:25 -0700 (PDT)
Message-Id: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 15:24:20 +0000
Subject: [PATCH 0/5] doc: git-rebase: clarify DESCRIPTION section
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>

This patch series reorganizes the DESCRIPTION section of the git rebase man
page. My goal is to make the page more accessible to git newcomers (who from
my experience have an extremely difficult time understanding git man pages)
while keeping the exact same information available for more advanced users.
This series:

 * puts more commonly used information first (a basic example of a rebase
   and "how to fix merge conflicts" are moved to before "how rebase modifies
   ORIG_HEAD" and "what git rebase <upstream> <branch> does")
 * removes duplication
 * more closely parallels the git merge man page's structure by starting it
   with the same example history
 * moves the --onto examples to their own section

I've never contributed to Git before so I'd appreciate any pointers to past
discussions of Git's documentation philosophy or who the target audience for
Git documentation is.

Julia Evans (5):
  doc: git-rebase: start with an example
  doc: git rebase: dedup merge conflict discussion
  doc: git rebase: clarify arguments syntax
  doc: git-rebase: move --onto explanation down
  doc: git-rebase: update discussion of internals

 Documentation/git-rebase.adoc | 287 ++++++++++++++++------------------
 1 file changed, 139 insertions(+), 148 deletions(-)


base-commit: 64cbe5e2e8a7b0f92c780b210e602496bd5cad0f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1949%2Fjvns%2Fclarify-rebase-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1949/jvns/clarify-rebase-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1949
-- 
gitgitgadget
