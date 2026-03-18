Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D894368277
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773817389; cv=none; b=EsVbG+vstpCHQWCCIAhd2PqaH70lZsf5rSYE995aU0obk4QenMgNH4L5YnMH2eICTfYB6oNTwdidXRjEYi4+Nf8zSsd+Kder/JK2R8icNOEkxgQFwAhA+pdS2pltel6Ol5hnaceJXwMXKRbDEIqWLGOw1RH+O4b+v5dA4Api1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773817389; c=relaxed/simple;
	bh=RRXHV1dxpa1nI0XOUnvr5ZWxrKYaC+rSwmuM3HLjeQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzkd6V6fczEQ19kNIHf8YcHcFGxpCPTBaIgCC228pMMp0PRRK2A3Ym1vu54bGU6A3eBnjDCK4fCr5mPENm3pvlARGD1o9rzaxwknsQkJR/YQeAHHE7ajpdALPpm3tze/J/PPqhxyZWy6VvMIBo+WccR1UdY7OUrzCltYUY3jqC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSbtx9oG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSbtx9oG"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a034ca40cso541606a91.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773817387; x=1774422187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0mCEzs0dvzNjfIq+Zz9pQHeJz4r5Pni1ZHsec6oXZ1Y=;
        b=FSbtx9oG9d93zKD7YuNgI9UmACKpSKx5Y1WSXcFIIILsGG0KZC7iYQBMbPz75i+F5D
         aJqM9Njy3wmS7LTvMj+PjcQvrUnk/54lOI+Lzf272nty40GmbCLXGHDZ5CRuhd3FcMU1
         aHGX/jEoy0UsCji5p0LEB+qLk5zljZiLlSkBu0pYgt5VLbRkyBULxcYYQTFfCHbyeWjX
         yaHjd5aOxKDn1r2S5ILYhWjyZxbfDphhpKFeK0Iiz9DB6gBy5SQ1tKd1iOx+H8v2q/w1
         typ7IYcLjyiZca4zJRmT1Srcm4DAu5CarOliiB4HOdXkH6qBSKfVRc/1BBM+7DFoy1rd
         XeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773817387; x=1774422187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mCEzs0dvzNjfIq+Zz9pQHeJz4r5Pni1ZHsec6oXZ1Y=;
        b=NirLuK146PhAv7FmnBSHg61MyyKLVfnoMiAdh9BfTFOG7rknWrgzF9rMMUl0U/QcVW
         0NyR86Ar4lLcpmBC36XJ1N0GVmDHAi6eiiymFLfo03SkMsYRYZjpUjavZBRwjXIIYTq0
         5m6nlvxg1KJF96G7BihBBonFcjnW+XImjEqybTAwwgWHKK7fOrKR5o0C1DklCTBXAetB
         rXsVk/+8t0E2meusIK08034vcAaxFsj28Yox2WbKUanWx7FHK8pN+c68f0dGPd/g+au6
         5YOJ1ALKyPNdld2FCNn6QyvOwbqs87XgpMyah794lDAIsbKj3Ip2+NR/oDtcgxMEtbig
         LJEw==
X-Gm-Message-State: AOJu0YzjzKWypNFm5c0/PhlKQCbi8KLsFs2hXwqln+7iq0G/2L6nwvCc
	hoc5OUk2xJyuAWS1J8cJsB25KNtVRJjUfO1hB8/MeVpweorkeXtgOBByZvSf3Z5A
X-Gm-Gg: ATEYQzxqVS72FAyQ9tKqjgnONlePoDG1kB+8BYAxWdhITHGSoW6XrKBU+8n+3YtDCl5
	5Al99oo3tjDB4XDxdIlbl37E8S+6COOCVQbu0US4fXhyZjK+1Ipl6SSlc0g1LTj0zdNoVBm7mXw
	gk2/OnukFg+ejdPP4EbRuima7nBHdPOFIRc5a26LmapY3+Jf4KlV2sYizP43goNSIjhYeBbE9E2
	32a/CWrEEBI3U4GE6Jqn/jHmz8z5LqnfJRZhW7mHNWbgEoBso6hXVHMqxTVbxlDqjGlNzoQ3Qr1
	NWN6DhDgr7WeSa/Qid2FUqZPjpk+cVQkImLhV5JXctFrw4lzDMiOSkjm3msC/gvrccb7HkIPomm
	q4LKdfcmseUxLKHwj4BrR/3oQWyBhhrXacyHcrpiEdHCoIUMAzbk+VfcH0IzPgB+K3wJByAvWYJ
	jsrLNGnZH/zq8w4S/Zf7G0p8Mcy2HiSKfaVUgwQJf0e+N5ohrCZtQ0N6OUuNOFlx1jfjPkQGg=
X-Received: by 2002:a17:90b:5281:b0:35b:a418:6993 with SMTP id 98e67ed59e1d1-35bb9d6be43mr1431480a91.0.1773817386940;
        Wed, 18 Mar 2026 00:03:06 -0700 (PDT)
Received: from localhost.localdomain ([14.195.131.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada2bfdbsm5054889a91.3.2026.03.18.00.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:03:06 -0700 (PDT)
From: jayesh0104 <jayeshdaga99@gmail.com>
To: git@vger.kernel.org
Cc: Jayesh Daga <jayeshdaga99@gmail.com>,
	gitster@pobox.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com
Subject: [RFC] repo: path representation in `git repo info` (absolute vs relative)
Date: Wed, 18 Mar 2026 06:55:03 +0000
Message-ID: <20260318065545.10001-3-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jayesh Daga <jayeshdaga99@gmail.com>

Hi,

While working on extending `git repo info` to include additional
path-related values (e.g., `paths.common_dir`, `paths.toplevel`,
and `--git-path` equivalents), I wanted to clarify the expected
representation of paths before proceeding further.

Currently, commands like `git rev-parse` may return paths relative
to the current working directory depending on context. In contrast,
some internal APIs operate on absolute paths.

This raises a design question for `git repo info`:

  Should path-related values be returned as:
  1. Relative paths (consistent with `rev-parse` behavior and more portable), or
  2. Absolute paths (more explicit and unambiguous)?

One possible approach is:
  - Default to relative paths for consistency and portability
  - Provide an optional flag (e.g., `--absolute`) to return absolute paths

This would allow flexibility while maintaining compatibility with
existing expectations.

I would appreciate feedback on the preferred approach before
proceeding with additional path-related keys.

Thanks,
Jayesh
