Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749943EBF02
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771066882; cv=none; b=az0PE8/q95mtX9JY3w3/F0VvmZXfRMYOXUoOp9kR3Q5Easo6ANwtBz02OLvh0v8WC3QHQ6o5qWzjY+eBDzOtXpP7WL7xMOYgZrQI1x6MA2qpOhpRGAVHmTD+UgA0vmEBr0rwNCu0W/jYll2ncff7KxkxrNwr8onWymhztWZ8RzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771066882; c=relaxed/simple;
	bh=ESYUmFZ5m3VUbNhtZE9K+mZhf2BC5G0WcgxTuAg3AUs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MZ9YDg4ZHVV7tWIileHZNV1OrqR4l/sVE9aA4jBxSIfPm/Rt0FFZSJ/bxrNADJooEKCaNWN2AWhRxE/U/URYkZS/Bp3kYcre/PAmuuTU1ryyIQ1VvHll/G+4B5eGdw0N7ltauIL6BivOvrXz2XBGuEyi+7p9dWYO4OR8G4xHzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTsvwsXh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTsvwsXh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-482f2599980so18784085e9.0
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 03:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771066880; x=1771671680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JttS/cgHwa55Cs22hoRdPmeViu5L6XggApuW2Q1K1MQ=;
        b=NTsvwsXhhNpgZ/krxF76M8L5TA0GiJTqQulRl2+0locEbJIemvNRalfe7hH2LV0CkO
         oTyN/A/3QryOCpmxHVSDtKMfgXBQjYTRSHVJcCerFf/wOQArD9peOkSTPwBiYzUvSvK6
         gdw0vkf223xaI6S+YXgMcOlonQI3mBQ4dogu8qV5I1ZG4xecHkG8mQwijdZ/2GaH5nZv
         aF6CVDYqWqpmwDnytqYlq1OVqlZ6+65lKbQGKe58Vh7+0tg/LbyFC2oE+7wVtIJCeq0/
         ygyyzQ9R0K4EwEGJl0SlXarlTmEv9F51ISIkTaq9yHiUGZoqhOxh0/E1Jj7PHaBHOLF8
         APRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771066880; x=1771671680;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JttS/cgHwa55Cs22hoRdPmeViu5L6XggApuW2Q1K1MQ=;
        b=UGcv76wCOkCqR4HfnTzaKYvnwSrjEWN6KEvdsjQeljHuAbkt9M/rcvuoT9SQTtVVIt
         His+IIk8DTR8USWwZ+RcwU2VwmvEan1p4yFFkw4J3IhEyxNgVwd3xBjha2/gWcQskaxT
         4Wo8CB0ws8/6l3qluDfFZL6+IdO2HgoB/CcuNKHdtuXr8Ch882mCo/XqxmfmIP0T+H5c
         YGf207hrOuMBV/H1UbCWmY4O722lkkadJ1D6JgKJgu5utU2/vpKo7VKVtJ3Z2a705+FY
         FrYoW0KkAkDfais3Z38Q/1J1GJ+eh98AjLsPUIjqSyG6dXzEfnlryl4a4EqPXxeta/VF
         uxbw==
X-Gm-Message-State: AOJu0YwBaS93uhoS8/yqdFoRLlWrOChO21hmS/HqgM3hEvy2fYzRgjMR
	KXuSnOrT451bAu/wTSUruIpJET7t4hJc6Sdbu50I7GRJmo4b5BJWy1SaqvzpRLAs
X-Gm-Gg: AZuq6aKTbnryzdmVE8PDLhe64wVdqaRqdIVXnt2mG2qhNjbheh+eoTsgFOveWZZ+oCh
	TEJBRfdFilHgwPQsEp9A7wcPqzppyfY8+Eu32Xs51OFeZPxjinR9JWR9y3EaxKVpH9FEAZWmutm
	aO6jrIdRQNN5YTZWRLAgTXHg/Xuz2WW3YpoDzsPGxoKorpplG1XiXz/xFDH/kSvan2PdcOaW6nW
	1WIE9ZFsWcsD3TidmHNnZZ7upTmps6PnQ9tCnZMS1Hv9s2mh/6u51k8flaoNeii4FuvRPrQ13pj
	sMB/B7CScn95SR7jGFycP5ArAdyq9BPI0YLk0uu5HdV47K19c/E3nYOWodAojyoLANANPAQ00ym
	pIhgcKlY7DVHSde94GhLCaL7oWm/h766KInrdAfSgVJSIuIZkOlEMCXtPjitjv5zBfxCJkXCpT9
	IeIv9GWvw0ICqw7KO2of9f6lowH/g4AA==
X-Received: by 2002:a05:600c:8b38:b0:483:456a:514b with SMTP id 5b1f17b1804b1-48373a1babdmr75907155e9.12.1771066879263;
        Sat, 14 Feb 2026 03:01:19 -0800 (PST)
Received: from localhost ([102.88.77.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a2392bsm69789015e9.6.2026.02.14.03.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 03:01:18 -0800 (PST)
Date: Sat, 14 Feb 2026 12:01:28 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH v5 0/4] introduce new option `--auto-advance`
Message-ID: <cover.1771066252.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771015581.git.abrahamadekunle50@gmail.com>

Hello,

After after more reviews and deliberations, I have been able to
rename the new option name to `--auto-advance`, where the
--no-auto-advance implements the feature and does not auto advance
while --auto-advance is the default and maintains the current
behaviour.

With the option, users can navigate in between files while deciding
on hunks as they wish with the '>' and '<' option for going to the
next and previous file respectively if there are more than one file.

Patch 1 implements the new `--no-auto-advance` options, Patch 2
modifies the function `patch_update_file()` to instead take the index
of the file as parameter instead of the file_diff. Patch 3 moves the
'git apply' logic into a function so that we can reuse this logic when
implementing the all or none application of patches.
Patch 4 implements the interfile navigation, and adds tests to the
interactive test file.

Changes in v5:
==============

- Moved 'auto_advance' member in struct add_i_state to its own line
- Removed redundant lodic to set s->auto-advance in init_add_i_state()
- Modified patch_update_file() to return size_t
- Modified the logic which checks when to quit in run_add_p() to check
  for s->file_diff_nr instead of a negative value.

Abraham Samuel Adekunle (4):
  interactive -p: add new `--auto-advance` flag
  add-patch: modify patch_update_file() signature
  add-patch: allow all-or-none application of patches
  add-patch: allow interfile navigation when selecting hunks

 add-interactive.c          |   2 +
 add-interactive.h          |   4 +-
 add-patch.c                | 154 +++++++++++++++++++++++++++----------
 builtin/add.c              |   4 +
 builtin/checkout.c         |   7 ++
 builtin/reset.c            |   4 +
 builtin/stash.c            |   8 ++
 t/t3701-add-interactive.sh | 100 ++++++++++++++++++++++++
 t/t9902-completion.sh      |   1 +
 9 files changed, 241 insertions(+), 43 deletions(-)

-- 
2.39.5 (Apple Git-154)

