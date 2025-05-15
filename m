Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F46299A98
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313147; cv=none; b=pmOgJMSMjxumxy/bggzrOkezV1FBCslurystFL7Ils5U53e8J7xnIShrojv77loRGpadNcMd87+Ov8HoFs00FyfgxHknejQycQK9vmL0G5Ov3UQdQ8SZjYZ5M+BoGZ8yaWz3q9KaKMH6eMj1OoesAv9jJ/BMYRDzuQ/myxip1RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313147; c=relaxed/simple;
	bh=zWW9Za9EYiKwH6Mhf9HxHWr48HUr7Q/mQj3K9nfBT8k=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=aXjN7/4AB3aOMbmpuW55R7dclSBRWyYiNAaE1G4HwujJauDDGv0MASTnlJYUQZnot49JQ5A9cJi5ImnzFjVDOO/eyegwhYdQesV+51zI4TlX01Zc94b78bvh8eDePrdhmExXwtN1cn21uBKqAiXhO9Tdnvwof2wDEIB1p1rE454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYJiuRcF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYJiuRcF"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a1fb17a9beso489367f8f.3
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313142; x=1747917942; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DOGMfPUCcQuuMSV1rsBVVrY9/heNdPDvM5nGtwo+NIg=;
        b=LYJiuRcFYGzIEj4VOmhml2y3qhQgYvQLmJCb3aZthWBHpKF1FjYKtyJ7qIH/Lthq8S
         4FOsXaGuCIZSj+eb1cyCktllrrytxAHs2bvy2lABu9KWWTkg5Kc8BG2O2dP6TcIQ/y5w
         cZG+OyjU4wjQtg8uVDcPfckP9upW1GIneidJMBD6oatE9Az+7BOLg2m2EsjCq3SFUmGz
         iB9PwQtCa5BINIzbHCd9oG+ie9Nw29kn8uZwHVE0Is/Hbr4W20zvYVZ/Xig9WnndFjzv
         OfCnWDLjN3H2qx6XGceoCQtP4aoobPfjHDh5FPCRZ3sXHH1+VFXNLkEDD72UgYfxrRxq
         efzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313142; x=1747917942;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOGMfPUCcQuuMSV1rsBVVrY9/heNdPDvM5nGtwo+NIg=;
        b=N3qav6SNwHUEKSuLhp/5c3p1WmKnZPam98n+1/Pnxmrn8PrGrjAyjxltDMcvKcknUQ
         FFlJlDQuTwoDl4X9S412/gCxWvqI4IYI7jiFR+LHDITnN9Jk56iQZnH0Mom0pCh4abQm
         gmHO9zPUKKU5y/eUbAohPdHuIkckpYjswi85al06s7oJ0+gtviAZqdl/+aLpeGZqn5UE
         L3f9+hmDc7ouzeriZdYANYdQeTF6odNcwhb48S5uYk6bDvt1EiLafGbkNBVJtH7kbkdX
         1ouiUVFNlB3EmQoH9LZtFMbu4NDf6H/UWaxDOH6sfvZxxP3ZSc7H0tw+jVFcY+Mli/hQ
         YVpA==
X-Gm-Message-State: AOJu0YwV05dn+MXowdHoIH/nl8ym0sz5tS8sFQnD7uYcMZcu4lH9jvMc
	ih2M164hiSkW0fwiaoKmxcSRZaiOhADsO8C+bAlpVkj5rw2da0avUtt7eA==
X-Gm-Gg: ASbGncvC/Ybo/ZtWyMYrxNTKIDb3of2L3xmDZB9XgwQuMmI6nl/riZ0dRXOx0oQS9rd
	6gfhmmhQBH6VX94z3raXEj0YJm9B8fv828ggCLId3VaxVST+5CCyV6doPaV1y8jaRRpILhi+H2C
	tWoW0MogxNLfncAzAHHoTUa02NWql4VxJqPS4aSL+iB6gpmIgakQutxdNw54pqVwnMk7yXU3c6+
	CbRew50yPuStWVxwRALQ+Xxlsb59xx7P6I/rZdgENFLKDdtlGK+WI6cT7n5wmUHPwKyyte4EUNp
	DSKhhR6EyrPj7Vb87DUdNqw9aHpF83tgn+Fd9etHJsQW/MO7soIJmCsou3J9bp0=
X-Google-Smtp-Source: AGHT+IE1e+AhGDuYhfuXPmJ0mV5sf+0Tl8jk01ob7iee/PzuSG5Yh1zhATR0hqO2Q2RTNL5PiT8DaA==
X-Received: by 2002:a5d:5f8a:0:b0:391:952:c728 with SMTP id ffacd0b85a97d-3a349694210mr6031417f8f.4.1747313141557;
        Thu, 15 May 2025 05:45:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2ffsm22938977f8f.66.2025.05.15.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:41 -0700 (PDT)
Message-Id: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:25 +0000
Subject: [PATCH 00/14] Some defensive programming
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

These patches implement some defensive programming to address complaints
some static analyzers might have.

Johannes Schindelin (14):
  revision: defensive programming
  get_parent(): defensive programming
  fetch-pack: defensive programming
  unparse_commit(): defensive programming
  verify_commit_graph(): defensive programming
  stash: defensive programming
  stash: defensive programming
  push: defensive programming
  fetch: defensive programming
  describe: defensive programming
  inherit_tracking(): defensive programming
  submodule: check return value of `submodule_from_path()`
  test-tool repository: check return value of `lookup_commit()`
  shallow: handle missing shallow commits gracefully

 branch.c                    | 2 ++
 builtin/describe.c          | 2 ++
 builtin/fetch.c             | 3 ++-
 builtin/push.c              | 2 +-
 builtin/stash.c             | 7 ++++++-
 builtin/submodule--helper.c | 3 +++
 commit-graph.c              | 5 +++++
 commit.c                    | 2 +-
 fetch-pack.c                | 2 +-
 object-name.c               | 2 +-
 revision.c                  | 3 +++
 shallow.c                   | 3 ++-
 t/helper/test-repository.c  | 2 ++
 13 files changed, 31 insertions(+), 7 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1890%2Fdscho%2Fdefensive-programming-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1890/dscho/defensive-programming-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1890
-- 
gitgitgadget
