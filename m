Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EED82C76
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947276; cv=none; b=Z0R1TMyp2BbYt6JFKh0OLNvj3MZK/6crZH2To2wlyecHMX59rol0LSzLHXxg3eVWMwlYK2I45IrWF/GioV99hGpFJe7la/5kEWK48vH/rE5YGGc+73JrHpT0TQbRnzilc9198mci/78IlEecC+/HdUXUsbtJ7DNmq3FrGlhGPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947276; c=relaxed/simple;
	bh=5ji/svaLjDfZ1Lde3mkJWaeDx8PiQLZ47/kOpNu5hKE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=hoDGuurcWcjhKixo+y4Wmt0rPRNrIc2vwXpFdQg432UPBsSSM9QmbsyIF5Z46spSe4mSsevhPX3TsP8yZ4n/Zv2vkSXf5CYgYcCbomsKnYV9zTFvgk5mx/LvDhRqA4eE+RXMFlYQka4YD/ULA2KSeOn/pHrrYnR65WQRRNmapzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdoytvYb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdoytvYb"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42574064b16so28935505e9.2
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719947272; x=1720552072; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zeD/cQx2Lpog6U0vUq+/qV8fc63+TgoCA7ZTrXRMRVs=;
        b=EdoytvYbsV2vxACj6MiSQq6m3S8cn++2jUwrrRP9u69FtUZQWEXBsEEfspWFrZBq40
         Nh7O7eTJiaDohv+sxszTuRZgwkBXNdgxqWRYPcCjYYmpSkYXZ7TkLDJgsBNaHw0uFjrU
         n58au2GIyUTRjuGy35WhJps2HXzFTpTAhbpVifSB4kgnCZbO3JP+HWiGIFC3wOesMere
         2VKIstm3fj6VvtRrdFAnZHPTDPS9dDtm/QMKsHB+xfnrx1TMlJrLjLjtlCwxHoXbOw8g
         EjBebiZEBDj4IUaEyXFN3WIq+Een8a9uuYqSYPS1W2kV/Pt/Cm+NNbUfBhb9kHV1y9Hs
         d2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719947272; x=1720552072;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zeD/cQx2Lpog6U0vUq+/qV8fc63+TgoCA7ZTrXRMRVs=;
        b=nwoclpYmFbnFfpJCqnRbldRbKQ5BZaxZTL61j0QPDlm9DgLxXBN37pz+XIPb9xzrt/
         mJpjJfdDCFswhNjSkFjrASe5OqwTSltKOa2icjqgmbTxzoDigsMvbxt5P+5EKh88061n
         MKXixIhanSJHTXCepri3PKGp6jCxU84jpyboPXDbaEIMEmHZCttwqBWtJYAQ0ubF+Jxb
         G00VspfcX/Dtk+qM1wNQkBSIYPfAdfpTG3ShS/6KJQkiZydXgi3Vdj5puT80+qUmww0s
         Z9kC7XRBGafcrYsdfxE/vm4sd9/oT0iIXH9YGvweyepOQ6uvgJ+D6BExm3LK+Vp80eNj
         AYJg==
X-Gm-Message-State: AOJu0Ywd/oLoCqiH2K0AUwOLKjdFE72CLm5mAaGYiXvKQI5iMgaN11J7
	jKWD3qqUZ9GaUWl8swrFRrkfevMxcBJdLpHY1pm8nxW1PkuIYDpucB2icQ==
X-Google-Smtp-Source: AGHT+IHAYbFLMXOtlT/SJ8xKEV5DNuuY1j+TNhCD3eJtgI4wGSBDZRJQCE/eMbYn/E4Co12aHHYtHQ==
X-Received: by 2002:adf:e408:0:b0:367:4154:c430 with SMTP id ffacd0b85a97d-367756cf60amr6144149f8f.38.1719947272404;
        Tue, 02 Jul 2024 12:07:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8e97sm13935250f8f.33.2024.07.02.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:07:52 -0700 (PDT)
Message-Id: <pull.1740.git.git.1719947271.gitgitgadget@gmail.com>
From: "Bruce Perry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Jul 2024 19:07:48 +0000
Subject: [PATCH 0/2] clone: shallow-submodules should be single-branch by default
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
Cc: Stefan Beller <stefanbeller@gmail.com>,
    Emily Shaffer <emilyshaffer@google.com>,
    Bruce Perry <bruce.a.perry@gmail.com>

I noticed a couple places where the behavior of recursive clones for shallow
submodules does not match what is implied by the documentation. Shallow
submodules should be, but aren't, single branch by default. It would also be
useful to allow users to override the shallow specification in gitmodules on
the command line for clones as they can for submodule update. The
modification here for the former is a bit ugly, but hopefully at least gets
the point across to start a discussion. First time submitting a patch here,
hopefully I'm getting the process right.

Bruce Perry (2):
  clone: shallow-submodules should be single-branch by default
  clone: no-shallow-submodules clone overrides option in gitmodules

 Documentation/git-clone.txt         |  3 ++
 Documentation/gitmodules.txt        |  4 +--
 builtin/clone.c                     | 10 ++++--
 t/t5614-clone-submodules-shallow.sh | 52 +++++++++++++++++++++++------
 4 files changed, 53 insertions(+), 16 deletions(-)


base-commit: daed0c68e94967bfbb3f87e15f7c9090dc1aa1e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1740%2Fbaperry2%2Fsubmods-clone-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1740/baperry2/submods-clone-bug-v1
Pull-Request: https://github.com/git/git/pull/1740
-- 
gitgitgadget
