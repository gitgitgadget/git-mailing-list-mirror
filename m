Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5817352FA3
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524739; cv=none; b=XIwlF+C30nIOpvk+Wrbp1Jj+45GKUDsTgXXz9yuXcKhhfl0ocxCtH7/Pc3yZzS2qpTErottxGyVUEpqIT5hMzXNWlSatlv/+X3g4uYUZFK0t8X30fIw5gnDF6TGfXMvbHIQa6SVlyj2dH4MZ2FQXd61PLnABW4KTNaHzCIEiVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524739; c=relaxed/simple;
	bh=9hy3Zhn92rUN/l97IpLs6/m9g4ckYpP13UVIXthu7So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fj7XJyRtCP8Tydi1HhOte3f2+JoexALIBzGOotc/ScuYSHGNuqljQ7gUPfTEPpKxHqtZp9Gthjlb49gUzUzwIUbjwRP0PW2kladGV664LNZjQCaW7ilpuUOUa94LiOI1WV64DIcd/AbkugdULOPb7UKacqFGkBj2GkxDpQI/wFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlzXQYyS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlzXQYyS"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-354b79a9ad5so502039a91.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 10:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771524737; x=1772129537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YTb31lK+ShiIyROwhufbydCpV2FOElhnbeSY4TJxxvE=;
        b=mlzXQYySFF6VK3irbr8UpH7Aspr4euq3jsJxAjrmZ0q7iYY0Z8dnc4j6LmY4NY5R2I
         IHqCecKDnLBLrNFMOon7I9YaO3lmTU8/S0K02PN+B8UWwpsicGE5EhzUQ0ma1rLxDb+B
         qTm+icyId0q64PAV+MHSPSzSAeCScYsNbGyNGfranYfYLkNnQtJpaPAZJLyQBQtGIZdw
         czr3lvGlsi1Q0afjxuPA/ep8QWZHqPMu7MmJ5O/yI0A5Ju39c26l4uj66VOrquabew73
         rMvrMbznMuVsM/HSQ6q0B7cE6d92sNKYEreGjygHH4LNfGIq5QN/beX+Z/lcRRSow2fK
         fPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771524737; x=1772129537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTb31lK+ShiIyROwhufbydCpV2FOElhnbeSY4TJxxvE=;
        b=N7r5fm7bSkkg0mcM/BDSExX21AIkj7yk0x37S88XiFtPNRv539pPlLJasHxAMQ4wdC
         tXEYZXRONE5xBdxmN45A3HOpN6R2zLBwrw09qcN75QMYz87E0ohXPkK5OpjHY2AgG6/l
         YRYzE9EYrbQYmA4G7s+UJvvBxeZy2WnwV55+qaap6qtzSYKnMm4iFVXW+VtAComH8hR/
         02TWAolJZ/ec5zyAmSHNc+WaHdqvIEeBC1UfLjBCR3k3xrJpV58YMZKP7Hf5IC5SO8UX
         K47a0JzR/89znCdamDTPRzNsfWjJDuWd/9EM8s8NwyIjm66n/Sj4rkL1yPg0ucjeIqmJ
         ++QQ==
X-Gm-Message-State: AOJu0YyJnZ9biY6kZvwtxhp7ctmVViKBo2VOZsZV23OvdTcky/yOHICM
	TaCs8LIQ9kk+hgGR/ngr+CLtTM2iI1anb3b/G9uaFZxc/6jJjVlhjcqOmtOFvA==
X-Gm-Gg: AZuq6aImaJxuXPIsgqHWGKSA9xMAETe9BlL6sAUwpMIgrnkhKb9CyYlKbteACZdo2zA
	61eKUfDguTZAtr/KWkC1nBvzDg5WNeK7FNS69TmcsLoZL+DdQ/uV2hct5nk4x3sovt6hyivzKrr
	VJDUgyXNjHCt+qoMGjNr/P6RLAHFR9Y5t0bI0i+ozrsiCGe4VAxlLs+xDMiiMjBPmRhpptjhFER
	20I4WMtArg+xlLk3yHFxXJcarjqRoPfyheZQvIjGHnFWSzsDJmBkt4cSrbAFhcdmaS6IK7A1Pxo
	Q2z6hygVzRAazcnLEUIxS5VKluOmqEH0ypvySPTNe4wFQJNOMNd8YNRrJtcdyMgdtVsjHprUpTm
	WuhPy2fL4Hv6auFGlhYpj4UkgXzPscoNtxL0YZINvj3Ssj2QWhFw613Sn+HC9Gg4husHM3zHI26
	858VEzk8YXyU4pe9H8s0tkihF50j9OcbM4eKyWucJLAvXH6P2UnNYbSaA2CXw=
X-Received: by 2002:a17:90b:4a52:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-3584481e5a0mr19069578a91.6.1771524737028;
        Thu, 19 Feb 2026 10:12:17 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:d059:98ee:c623:cf0b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3589d6d773fsm678691a91.0.2026.02.19.10.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:12:16 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com
Subject: =?y?q?=5BGSOC=5D=20Discuss=3A=20Refactoring=20in=20order=20to=20reduce=20Git=E2=80=99s=20global=20state?=
Date: Thu, 19 Feb 2026 23:32:18 +0530
Message-ID: <20260219181154.66814-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi everyone,

I have been around Git for some time and am interested in the “Refactoring
in order to reduce Git’s global state” project for GSoC 2026.

So far I have built Git from source, completed a microproject, and explored
some related areas in worktree and wt-status. I have also gone through the
blog posts by Ayush and Bello Olamide, which were very helpful in getting
to know about the ongoing/previous related to this. From what I gathered,

- In Outreachy, recent work has focused on moving core.attributesfile and
  core.sparseCheckout into local structs and also to handle the issue of
  lazy loading, but it is still a work in progress.

- In last year’s GSoC work, the focus included removing uses of
  the_repository and other globals across areas such as
  preload-index:(core_preload_index), builtin/prune:
  (repository_format_precious_objects), builtin/fmt-merge-msg:
  (merge_log_config).

Though I still have a few questions regarding the project for better clarity,

- Should the primary focus be on core library code rather than builtin?
  (ref. [1])

- Is it preferable to approach the project file-wise (eg. cleanup of one
  file making it completely free of the_repository) or variable-wise (eg.
  identify one global state from environment.c and eliminate across the
  codebase)?

- Are there any globals which are best not to be removed currently?

For example, in editor.c there are mainly two globals,

- editor_program, which appears to be only used within the file and is not
  dependant on repository. So would it be preferable to remove it from
  environment.c and localize it within editor.c, move it into struct
  repository_settings / repo_config_values, or keep it as is?

- the_repository, there is only one instance in the function
  git_sequence_editor() which is used in editor.c which can be modified to
  pass struct repository down the callers but is also used in
  builtin/var.c, where a local repository instance is not available. In
  that case, would it be feasible to pass the_repository or is there any
  other way?

I have also surveyed files that use #define USE_THE_REPOSITORY_VARIABLE to
roughly analyse the usage of globals, and I could make that much of the
library code is still dependant on the_repository, so could that be taken
on priority to reduce the usage of the_repository throughout the codebase.

Thanks,
Shreyansh

[1]- https://lore.kernel.org/git/7b5dd0c4-0ca0-458e-89db-621a70dac9ae@gmail.com/
