Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4E2E3393
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741911658; cv=none; b=LQs+ZTRGNoli1+umQYdsg/Qq8ulNiv81X9N8SDVTVslXxCJMVadGiJdcJolKt4/FXW75FRhCbyMC8SqQ9dCxNaMmHZ3/oXrQJNM5cwwCkmoN/Z3trPsUFOYlqhmXQJ9HB+DqxlFL54hH1tOGGUFvN++Y+vp/N+QkLmHxdjYx8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741911658; c=relaxed/simple;
	bh=+oARwFbq45lMp4Z3MeeOCoOoIDgOgOFMnKrmjSweHPc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JddhLipr3C92HhIAIWpz5LLFFxvAnwJtzRc3E2tcOrB8emz5Cb3FDuw1se7izFfHwKJeUyXoUyHoCNgGSxP6XpjFSa/Do3uEOgAqtIkaZXuP//dpaqDvgmklbzReEHt50z+SDTjQZ4qo3RigSIaC2XDmbe+QnxwufMTwGZZaBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7HkeFIr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7HkeFIr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so9886515e9.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741911654; x=1742516454; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LdRUSnfqFGIIXNq3wpd0zdYxwexefuKO0h/QkcGuSyY=;
        b=l7HkeFIrz/HAkqjFEoDX/SO30B92JEZpBygbGK6e0OpgodAcf0Eg/QpACXxLrZ7kKh
         sk2WZYeMFKRLdiUomd1F71MOq8l6g5Nwqlab/HgPRphpcyJcHEB12MijGJJVExe1aG/i
         m3uWXrOuHOYgqIbAVfzZ+eI58x+o9X2i5gwE+t35zdrqx9T860xEkP5gdUL2zD1+isIG
         VdDQt3CGOmBG3uHQzZOQQax2wXTmq+InQnPXHJKTU3llInegu79CZFzZvZDGZr4mrnmX
         W44iAij9xCJt4N8alk1PXL780vI0PR7dZdCjHBAfazEObEQZqetbo/3l4Wj18d7UhcqY
         aT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741911654; x=1742516454;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdRUSnfqFGIIXNq3wpd0zdYxwexefuKO0h/QkcGuSyY=;
        b=FuTssCUkYLwntUWEv3piYBC3vGHzyJcSIHl7M/KKOvr/J6tgntvlHz8zANuh69KFsf
         fV9owYAK42E6Tug+C/QZyNTbFZ7mVd7egrBf1fWvzlC6NwJf7+unvxehzySlDQMjm9JP
         FwyhJc9ZgX3P1zkkFV6AzRS1kgVYzA4b02Yw8+hZzAIxp39IZq+Illw/2ZNPpM6Nleni
         i4219LwcXj1S1AhuiyqGeEDCWSkycR2ToJlsGYPymvTnSkWmvP88rw0rBg1/U0CyFbrp
         DnvpRS/ciVmEeW4nQzxAMqYj3Nbw7A4hDeGy/zmJ+LIzN78YmX3eDMpfywVK/KdO3i2C
         kZEA==
X-Gm-Message-State: AOJu0Yw/dnj4hqNt9wlsVDncD28Sv0QaRz1FJsT95jXf18K1ukfLK+zF
	M67F5VU2XI+MiO4zRYpG8Su7inuG1FY2Y7aT4Lro2IgD9f3rKjFIzgecOg==
X-Gm-Gg: ASbGncuUsWq/4Wo616iG0k0xV+ZrYC+UiiaAFm2nDsq1dmnfcX41UtNZmIm4WFTkbLs
	NZoG2qvtlQwPmM5TX0vB7l0N/YKyyOrJRYeeKRc/G5SlagMeLOl236i0Ok4YmemBVvGyxZ3n7aG
	jVB0aLdDTetSbYpnHlFmTMavaLWMSgM7qt2t33lIELgbT2xGvP64d8cWjGMsZBSiaHbmsVOqs5v
	T5yAhcE6frFYcWr9khDV1E0xDHryws6HJMKRkjBemQvk0sfFzpUYpoV2b8DZ+ABZKyXPc/4Bu/4
	25wb7wjzCxkfRY1g++qLFN6kek0dgK77X7so5fvSc6KfGWLAs7/5fbst
X-Google-Smtp-Source: AGHT+IEQMUGCPkEMnHyzbMaoMlZeOwun44gF80NV+gH4MyhgszYt3q5prJgvROV8xZ6g4nk3nD9HKA==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr5896585e9.28.1741911653440;
        Thu, 13 Mar 2025 17:20:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c23ffsm3632108f8f.22.2025.03.13.17.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:20:52 -0700 (PDT)
Message-Id: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Mar 2025 00:20:49 +0000
Subject: [PATCH 0/3] Add a static analysis job to prevent assertions with side effects
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
Cc: Elijah Newren <newren@gmail.com>

We have several hundred assert() invocations in our code base. Some have
suggested that we should add a recommendation in our CodingGuidelines to
avoid their use, because there is a risk that someone might include
something with a side-effect in their assertion, which can lead to a very
difficult to debug problem. However, CodingGuidelines are going to be less
effective at preventing that foot-gun than a CI job which can warn of
assertions that possibly have side-effects. So, let's add a CI job instead.

While it is difficult to perfectly determine whether any expression has side
effects, a simple compiler/linker hack can prove that all but 9 of our
several hundred assert() calls are indeed free from them. While I believe
the remaining 9 are also free of side effects, it's easier to just convert
those 9 to a new macro (which will not be compiled out when NDEBUG is
defined), and instruct any future assertion writers to likewise switch to
that alternative macro if they have a slightly more involved assert()
invocation.

See
https://github.com/newren/git/actions/runs/13845548634/job/38743076293#step:4:1938
for an example of it running in CI and reporting possibly problematic
assertions (sample output also included in the commit message of the middle
commit in this series if you don't have access to view the link; I'm not
sure what the rules on that are).

Elijah Newren (3):
  git-compat-util: introduce BUG_IF_NOT() macro
  ci: add build checking for side-effects in assert() calls
  treewide: replace assert() with BUG_IF_NOT() in special cases

 Makefile                      |  4 ++++
 ci/check-unsafe-assertions.sh | 18 ++++++++++++++++++
 ci/run-static-analysis.sh     |  2 ++
 diffcore-rename.c             |  2 +-
 git-compat-util.h             |  7 +++++++
 merge-ort.c                   |  4 ++--
 merge-recursive.c             |  2 +-
 object-file.c                 |  2 +-
 parallel-checkout.c           |  2 +-
 scalar.c                      |  4 ++--
 sequencer.c                   |  2 +-
 11 files changed, 40 insertions(+), 9 deletions(-)
 create mode 100755 ci/check-unsafe-assertions.sh


base-commit: 4b68faf6b93311254efad80e554780e372deb42f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1881%2Fnewren%2Fassertion-side-effects-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1881/newren/assertion-side-effects-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1881
-- 
gitgitgadget
