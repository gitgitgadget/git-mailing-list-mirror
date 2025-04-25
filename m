Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3856417C21C
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609594; cv=none; b=LjouKoSM7ZRA7oMJkIre2YffssORhh4OaClo/GWLpS50geg0azMtYl/aIL2iHt1e1lhX7s2U4EZM74wxvCaxNN6VY0hb1Q6NkBUgBTEIlrajsfdzzaPPgX+hvzqDtemPj61PaNKoWkC1jWx8P+yXKEiKKxpNOLK4BbL+wLIms1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609594; c=relaxed/simple;
	bh=XkA2TywC8rH4JTXd8wVLpllj7noRVXlsKilZrYCPmCs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aujsHaaATemlF6Im/10ih74laieN3JcECV1mhBL65a6HB4LVcmcHkJD6D06CwSKFC0Qvx7t28BE0LoQUsI7+lOiEreBVxqqd5L2vbLfblH+Vfr1mf9868cl9gQhDFMb9+Xwb8HC+qKEv+RZcoMi8oRlApILMEoP27jTZANC+i5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9eExG7p; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9eExG7p"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso18872105e9.3
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745609591; x=1746214391; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOeCnDzDEnuB4BKiFjphSPsjidfdJMuz8gvboE4UAC0=;
        b=C9eExG7pyzwEBtP9F7p3YHemHVapBI0ls5V4G5fKMPII6Oq87/2FyetH8rYdmg6Ekm
         9TB5z9ndY0X9Qv8cP9MMemar+eZ5LpzD+XeeqP++02ewfEo6kco6OKQfUjZXxePUVfoh
         nktFpS0+/HR6ZA3yo0UuOMM9Lf0Np4uLAMfvIEQAqarck016hulb/7ZS3z4dwELbdnII
         lYaq2+xp4NIuEmPgEVgMKteCGW307M3gts+gSZKIwFlGptyeAz0SpLFtWM4oH3CkQdG3
         LAV5PiMS15Pi9rCmbF7uyx9gZ1dtdAMET78f9saLNanXxh8evouibMPQVLTMvvHMvgRl
         7evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745609591; x=1746214391;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOeCnDzDEnuB4BKiFjphSPsjidfdJMuz8gvboE4UAC0=;
        b=KCcSGDAAS4LlczFdmgz0+13RdBHYlSgGUJTM21kYOigohknbm9zstBUyLN7hAnwyia
         JdHnkIYDVkjezuMhOTdOWQ72VR53kCyKHLOCW8SmGUh+2IIyFTIHTrAhQF6YeXKJ3qAw
         4BZ9DyQoRvNYJYA0SkaagqPUaQA84cEWr5D5k508QPH10XJrKR9oT2X8zQl1EuJ3ASy4
         s8ubQ9roFdhnB66DReWsqK520/+H4rOcDGkEu4PaxdwVgyOfkE/D7p72S1YYJAcJjc40
         LjKETJdWnoArMFOmWh7TieLZglRJS//uZkvcQkCJlWAa3R/j8yiQF0GPvMioQiwAOT1P
         +tgg==
X-Gm-Message-State: AOJu0YxxuhokAXRMeVa2f1i+0yyfwA7Jb+gCsCVYdjc6F6h9ZuIy1xZC
	fI3BEtWXitDsIPnkqo/kqZhjkOOSeugH63C+iplLAoj8MMflC+LCXFt21g==
X-Gm-Gg: ASbGncvb01hxFOaTmSsLyZqXIZyzoAo3wRWgjBbkUKfWQz3YV0R7G/RF02PT9EBSkHh
	JF4KI5aT9mLvpCEjdr6aYp0qLKLM0HGZA7UtX3YEsxWcEO2wAAkKtJ8/NBD6RX2cIPooifaotO8
	uKj9v3O5iKcEZUDnshcyaeSRl2kLAfnCwYmTkSgCxTrGN0q+KgGcUWOlq/LqGBCBzVeYduFbrne
	YhBq+AeGHQ9GcpBu/Sm6gGh39ZSIZ3cYKGoKszGu4V8cp1AbDsg+4IMN3RWm5NfMxg+NHC+qQUI
	c2ANH6/BEXILMDWoQqXV5kYze2/R0eQwS/6mDeD7Yw==
X-Google-Smtp-Source: AGHT+IFRVuTHvjo8kJiKi0zgKdxrFOTD1s2kCSSU/hVLvYywbx8dwAnO/RO3J4jh6Ar/ccWkisgrww==
X-Received: by 2002:a05:600c:524a:b0:43c:fae1:5151 with SMTP id 5b1f17b1804b1-440ab8480b4mr4629165e9.25.1745609591100;
        Fri, 25 Apr 2025 12:33:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5287a94sm34737075e9.0.2025.04.25.12.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:33:10 -0700 (PDT)
Message-Id: <pull.1897.v7.git.git.1745609589.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v6.git.git.1745609278.gitgitgadget@gmail.com>
References: <pull.1897.v6.git.git.1745609278.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 19:33:07 +0000
Subject: [PATCH v7 0/2] bundle-uri: copy all bundle references ino the refs/bundle space
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Toon Claes <toon@iotcl.com>,
    Scott Chacon <schacon@gmail.com>

Sorry everyone for the noise. There was a whitespace issue the tests
complained about, hopefully this fixes it.

> bundle-uri: copy all bundle references ino the refs/bundle space
> bundle-uri: update bundle clone tests with new refspec path

Scott Chacon (2):
  bundle-uri: copy all bundle references ino the refs/bundle space
  bundle-uri: add test for bundle-uri clones with tags

 Documentation/technical/bundle-uri.adoc |  14 +-
 bundle-uri.c                            |   2 +-
 t/t5558-clone-bundle-uri.sh             | 202 ++++++++++++++----------
 3 files changed, 124 insertions(+), 94 deletions(-)


base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1897%2Fschacon%2Fsc-more-bundle-refs-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1897/schacon/sc-more-bundle-refs-v7
Pull-Request: https://github.com/git/git/pull/1897

Range-diff vs v6:

 1:  d6ec5c87b43 ! 1:  1cbf0787d49 bundle-uri: copy all bundle references ino the refs/bundle space
     @@ Documentation/technical/bundle-uri.adoc: will interact with bundle URIs accordin
      -   introduce a numbered namespace (such as `refs/bundles/<i>/*`) such that
      -   stale bundle refs can be deleted.
      +   client unbundles that data using a refspec. The refspec used is
     -+   `+refs/*:refs/bundles/*`. These refs are stored so that later 
     ++   `+refs/*:refs/bundles/*`. These refs are stored so that later
      +   `git fetch` negotiations can communicate each bundled ref as a `have`,
      +   reducing the size of the fetch over the Git protocol. To allow pruning
      +   refs from this ref namespace, Git may introduce a numbered namespace
 2:  825d2b01eae = 2:  7f36484e267 bundle-uri: add test for bundle-uri clones with tags

-- 
gitgitgadget
