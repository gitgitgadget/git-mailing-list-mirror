Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ACD3D6CB7
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956193; cv=none; b=iCTji/F0EVhin3v25OCRJtyLGIAbifpc4ueLevwMNhAGYlqG4IoLKEiISS/qwS8hD2c7qOU0XrfmsfxyS0YOQ3J69Da0x6aSfPZRbc0leTSpJ1Qbrc0CiyFbD6IlghbzffmGWe44TlMfCfSk8yQBWRovmhdEofVpTVMI4vRYezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956193; c=relaxed/simple;
	bh=GahCF0qPrtyzUr0jmd9RBHGoccQR+xkMEmCUNpOYKFs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=pJA9CPqsV8B4kXXwkJAZBtNTt+l+HRGaugPRss8PExk/xQc2Mje6jasVOcUrCHbyCTMg91hXx6XPmSXg6GhsjYqEh7q8gbM97yYNuPk4eB319tX8Md8k+VVpUying6e2Z9jBqkqEC6Yectlu+nq+bAd/4uMQbOnkH8cxSbjz0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8eWHwjF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8eWHwjF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486ff201041so1131875e9.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773956190; x=1774560990; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:date:cc:to:from:subject:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=13YpjyhEw4bwJRuq3O+sX629RilbIIB1uJR061MNEnw=;
        b=k8eWHwjFH7bVNR/wrTGjl8eBHYhphGdcRfSKE8mBObp4gSCgpOmZdgyRjr+KF/d/bR
         iCqRx60qhND0cDvX/V8kajsMBUqumFo8KIDchFNr7B20qSLCrYgNqtcauv/Ps1ReS0RF
         bf8ItndK9wfAdZhldxm6j3oqJ2V1C416QNANZl1BmgrTWJBqhkeC0a/Foao0WhlulCxE
         RhYO8SoOqEh506/UvPlrz7yU9To6Xvaxy9cQBqNth2/ET7NJzQqkXnE7qYEcY7RvTZwu
         SdzqpHvOALJbRsd1bUWoIfDlKKwR3Bsdev+MpxY5b7WxfCizPL/aqLcJP43O/7zXLerk
         8ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773956190; x=1774560990;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13YpjyhEw4bwJRuq3O+sX629RilbIIB1uJR061MNEnw=;
        b=n2hufNXLEYImuQIsAiFh8svd6N+i1jPWlU0qqzBEnMlGCk0F1s8gz0b6kBdTGIfFgp
         H+fj5CU1oaci0pqGcwyvs3BQjq3Pq3glmgTHirzuPiyaHrd9kklWRDS6fnPpxTfoKA1M
         QHBHGBgwz+wqKBH+SkBaDfUgtQHTXLdx6Um4hKHIMHcaN5dogV8gcTYDLg3qIIlIaPie
         xUpQqrM38kwgTN2C67MAzqXsTEW7tueiDrGRSJOmIQsfVynauHNq7Rp5JAV8OXZWtsA+
         wtO0ChOUk44bzAi0Hz1chAA6Kjkge1FqH565EgJSGc1H7KDyI32cYetrX86GtNzrioEX
         CMlQ==
X-Gm-Message-State: AOJu0YxMfCbfwA6QAFSq6rLZyQJq+DB1b4LF1R2C1BxwTb9MYklSF5J6
	fJxHxtNisYag6C6d5bxiLQx+EbApEmKSRzzura7zkZiyA2KkxJpmal7ftRW7fZV+4PPKAg==
X-Gm-Gg: ATEYQzywp+lE5L/sYzNBQ88IGw+BbZHktRcHtqPLcYfZ5va/AdWP7ZxAVBXD9Usnxfh
	/l9xoQDRTSIQxJP6HLNdqLTEZob+u21PAfNHWeFmpdVB2FRcC4sWqLcZLJWtQua+eo3MTSWKQ3Y
	v3ro3H1CWW7D7qzIbaIS20qt82JXrr9S9Duavx9r8gGLyyVa+UgEQC8JW9Jm9dCPY6lYU+PqmV9
	ZNg0LvcHrBbrndSniIe/E7vOWuLrTYl3TMFLgAdwCldQ3BbR5yAAaj5tElIVTbMG/Vht/zGow9K
	Mko8w4dktfRDGyJ7pEYEGMEcPSKE6XC5thHn77GJbYEkHKYQviTYsvcACJesNqDPr7a+O6mjynr
	LrWY/Hh+CTTS69S9G5txRboTljEN6N83KtDXrYuzCU9cF7r+2KJmSxZBbwkqbUi5EHQPli8SHhN
	5qTwR/DzYizMJMRn2Z+We6PgzBOXID/M7Dwt2vJA==
X-Received: by 2002:a05:600c:528e:b0:485:3fe6:2209 with SMTP id 5b1f17b1804b1-486fedb2f72mr9486245e9.11.1773956189374;
        Thu, 19 Mar 2026 14:36:29 -0700 (PDT)
Received: from pluton.example.com ([105.72.248.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714decsm1618482f8f.31.2026.03.19.14.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 14:36:28 -0700 (PDT)
Message-ID: <90d68696e7745e626e996ccd2acfccd58a535175.camel@gmail.com>
Subject: [GSoC] interested in improving git repo info path queries
From: BILAL EL KHATABI <elkhatabibilal@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com
Date: Thu, 19 Mar 2026 21:36:27 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

  I=E2=80=99m applying to Git for GSoC 2026, and I=E2=80=99m currently most
  interested in the =E2=80=9CImprove the new git repo command=E2=80=9D proj=
ect.

  I=E2=80=99ve been reading `builtin/repo.c`, trying the current `git repo
info`
  and `git repo structure` commands locally, and reading recent
proposal
  and patch threads around `git repo`&. The direction that seems most
  realistic to me is to focus on `git repo info`, especially path-
related
  values that are still "commonly queried" through `git rev-parse` and
  `git rev-parse --git-path`.

  My immediate thought is to keep the scope narrow:
  - start with a small batch of path-related `repo info` fields with
clear
    `rev-parse` equivalents
  - add tests and documentation together with the implementation
  - keep the main design discussion around path naming and relative
versus
    absolute path output
  - avoid taking on both `repo info` and `repo structure` at the same
time

  I=E2=80=99ve also been working through a microproject patch on the list a=
nd
  reading recent newcomer and GSoC-related threads on lore while
shaping
  the proposal.

  If there are particular open threads, design questions, or gaps
around
  the `git repo info` path-query direction that would make the best
  starting point, I=E2=80=99d appreciate pointers.

  Thanks,
  Bilal El Khatabi
