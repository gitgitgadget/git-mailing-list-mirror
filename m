Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1F213E81
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744374446; cv=none; b=Cz9yCEYRtUvgPNnZZ/MRVYg9CzD0MmMBhgQx/w8P3d6AuDyDnsJYrN/vVHDVf+iqz9Z2AkwhCrFYfrs4KXoi851Yf4OLIsAn3jnW8MApda0pHMxsWOU5xPgWX15exXo5utITgoxZs8TCAEAxGy1qG9CmWJM51jBXf+pDO0IDRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744374446; c=relaxed/simple;
	bh=8Lls+bGNIN8cLAEo+d+YwBrMZWHPz9lCx02LItsFbNI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=dCm1I75Qbxm1rDzFqmOfxP1h/Rch0GCk9PCr5p6CAzHZx3pdiJD5dNdUS2MQBopJSFaeiJEhilsOq56a8IbFbgmMu7XKwHZL42If29uwsHZRoiIYCmk+oAaxnEteOt7TvW8ZABalUU0RasRw+dCWGmy/FaHqNU3+AgV2pLfWGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0SvZV+H; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0SvZV+H"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54963160818so2275344e87.2
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744374442; x=1744979242; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Lls+bGNIN8cLAEo+d+YwBrMZWHPz9lCx02LItsFbNI=;
        b=L0SvZV+HCmWpBhUeBrRGSktQZxavXxYQpnO1x+g5fERHYB1+SK20rc6ZuWim0g/ZdK
         lAw6P/XUR6JcwMsL0RATp1A0tNQ62SZ5COvaxbrHDfl/9Fy979fAl4jR0haqCp224r8f
         HDRw9BdnEUvuxzbYb5ngiWyEZdPYfVKmvntLJ8W3d5yYc8p/DndUE5C46G5hhvjz3fwU
         x6PNif6fMprZk2hWRMBPHiOiUsEktORXMcfCFA6PlPUNdPZAlMKk65+TyCOYH45c0QNX
         YDH6eB0KIvUvONTgDUgY0vcq/4V46mJMy+TNqBmAlTjU6WRUgS4XfQnuhITLYVrJO+By
         1S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744374442; x=1744979242;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Lls+bGNIN8cLAEo+d+YwBrMZWHPz9lCx02LItsFbNI=;
        b=SCh9Eh8yVocHith/S63FF/3aY10pPZ9biBRyP4J16q5ojGz1BEMOroRPKNZ0jhoiVx
         fNYI9U2PoD0bl6i4gTOFYaYImW5Gm69yk3hfly1tkenpLSjxwjgWy/w7lsqioHLY4ln1
         KUspZE0ApDVQAJeQWFRedEHZylCkRF58iDC3qdBHw1Ha0/mGSfcXk5u/2wCSFUPYrHg8
         w777vothPCy2hdDZCrIxDGDnA/V56ZZe7SD7a/Mil8Ut94+oizmAHyY+4SSRrsFqkv3e
         9FQomU+VSFAVLP4TZxUQgyOkO2NkZ0m5+x4ObfBBSSo0Wh5tz6zm5pNEaz8IAl1a7/eN
         j/pg==
X-Gm-Message-State: AOJu0YwKxNyaaKVB+eQOq2O7v5BfealB0FYb3PuyaPlP080ja/sq05xs
	/6H4l9alztt0pd6ov7X0NIt0uYuFyme7vPhad6XNVseFpKDhswQHuBNoWA==
X-Gm-Gg: ASbGncsQ5P6bdBIHPNFOm1m5+iUHmuuXS/vnIl403PTxDQjqYgUvC3eOLW0PorxYKGA
	Ch9lB7zAru/KGRJg074AgP6bbWnc+B+L1BRppJV4OV/Y6jZf5a8HwB1LRhtzoRatxoNo3iv77+j
	jkfm40/QCwwhZuYW4gLD/Ir5EwWyY54XdR12q+B6um+NZ2zGoU6jjQsGtf8qwPl9sW8OrroSK9G
	vRvgzz73bb0bx9lsaTLAgHEyY9YhBMfn7qx6+cGTT1ONB4RHAzNFtVi3jV3khgWZWHJJUkAmiok
	LC1JTG9WARLxsb/zrTThtm9TG74vsGGn2tKlqGQ51ZW5fn6y9DEB/foOrhX6Q8ZNF4ACAF2JcuS
	I3DYQoTOZr5noxGBu7UY3/Lw4vn+MHq8Lc01MJuE=
X-Google-Smtp-Source: AGHT+IFFKgK5UtyvH6Hi1lEow1smJK0WD/Sl3Bu7kXgKI3cmr5U2t9jfFQMfVN8PqMXm5mpWAcTUBA==
X-Received: by 2002:a05:6512:3f2a:b0:545:c7d:1796 with SMTP id 2adb3069b0e04-54d452c9cd5mr738483e87.43.1744374442393;
        Fri, 11 Apr 2025 05:27:22 -0700 (PDT)
Received: from smtpclient.apple (h-81-170-134-254.A498.priv.bahnhof.se. [81.170.134.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d510b1esm415032e87.198.2025.04.11.05.27.21
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2025 05:27:21 -0700 (PDT)
From: =?utf-8?Q?Filip_Skogstj=C3=A4rna?= <f.skogstjarna@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Bug in git-stash
Message-Id: <AE8657E8-D68A-4B86-9644-B57AEE743794@gmail.com>
Date: Fri, 11 Apr 2025 14:27:10 +0200
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

edit a file

`git add <file>`

edit the same line again

`git stash -k`

What did you expect to happen? (Expected behavior)
I expect the stash to contain the diff between the staged file and the =
unstaged file

What happened instead? (Actual behavior)
The stash contains the diff between HEAD and the unstaged file

What's different between what you expected and what actually happened?
The difference is that `git stash pop` will result in a merge conflict,
even though no files has been changed between stashing and unstashing.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.5 (Apple Git-154)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Fri Nov 15 15:11:49 =
PST 2024; root:xnu-10063.141.1.702.7~1/RELEASE_ARM64_T6020 arm64
compiler info: clang: 16.0.0 (clang-1600.0.26.6)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh=
