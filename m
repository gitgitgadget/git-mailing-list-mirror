Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A51A6801
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773568383; cv=none; b=R1QFwJsKg2ClFkMbKfvKjhVibp0x0uJiFVHGhmzBL9qPJdmIm44Thn1YOFBMKtRsN9jEpX2LqLuwxWSFK8DUJH4cqimf7/fHfBpr1ZX5mhcYfj2OcLptlJMra6JQExCBC6dNE2RvINJ1smigjzctrZmXA5sz2naw5Rrm0/QLpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773568383; c=relaxed/simple;
	bh=a31MsDRH92HSpz4GcnKHL9GQFLiIQPV7+ql/I77Ff0I=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:Mime-Version:
	 References:In-Reply-To; b=RieHBJTMewSK9XfyU3AmJdr06tlx3y5qsilYQZ/Mip88c8mK1Th77USh3zBlVVMnjrKxhva2kcrlzD88AkLaaqKxxkJTCaQZ0bup0agChYWsHjxNUrs0pMpCm3oT8nXu5qfpFQUwfl0a10hw4NAkraA5OEys16pkBtFexctX0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQFeZ/cw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQFeZ/cw"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so4112184f8f.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773568380; x=1774173180; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaPPd056QQaFPrUbtaughC+MQuCQx1IQzei16/wWyvE=;
        b=RQFeZ/cwKzxau5iCcMfBauItbsZG1K4CRnkF5Yksvs6RZJa5rPYAGRwANDT8KjiaJc
         mdmx97EtW9O9pAiBCPFOi6IMknCiYz3wQfgWhPZ1lMaYTu5nJrK/Bj4hu3uI1SCrWO8u
         hl4HBjvfBmS4k44eCE9MuSaniEyrVXECIA5nDOeZijqwBZTDFktlqyy9DBba3ZffbE8h
         yfIEK9pswe9uiMihey2e0Fy1LtL3LMoi25rYZUp9S6w6Upn2vTCm90CDPiIfa7kiT0s9
         z0fDVDlcgsz2QD+mhFVLfG7xhI+koDGu2dnIOCBy2VBIPNrNpmd6tBuK2YexBM8k6DW/
         zawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773568380; x=1774173180;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaPPd056QQaFPrUbtaughC+MQuCQx1IQzei16/wWyvE=;
        b=knC+ofcxMPYBrHraJ/gBFoiZwlGlALgfIea8V1IktDxoaPJFNR50jkmXQt0gAhTbdF
         tfrek1J9nPQVXpcMD1wIDoMP6GbFITUmXLgwGpm6S3/NHu/rDmybCcFfZIYLXD8ORtOr
         0FStiQAUz+O5TkMKrgOkkaes8PBZk6FBo1jQRG5q2FzwuqfCKiz6fOU0UyIqYT8yNuFh
         RWc1emrR0laf9d3CDpX/JtYAsUBeWLUBHcfgbDArMV82XQGMn47BInn2F1S3hP80ggFY
         mEcDNczxAFgVPekJU7bBD7uInKauCAfcy0UVDkMihOIgHWMqF0eT56zjVwd6fISY5kUU
         iTRw==
X-Forwarded-Encrypted: i=1; AJvYcCUS5V6M5dchR4g+4nO+vp9K3zQE6AM4QBKNpBfG3icXwFLuQERRJCZwtdRCaXQ7QMj/GJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3m32ovqHpnXOTDyo+fJrLfgR5/wBCQgoRKREMHF1caRRTd6t7
	KYwJfMVZFf9o7C3MDNeBKWola9Xx63sbNej6/GyJkIlrWvv8xdpsXogg
X-Gm-Gg: ATEYQzzLWwkpBu/n3UTjYi0GLn3EYulsTepCCFzMY32n+ph7m1JiUfpPrv57YloKvvU
	eLyYlzremydA0vrBt5IHD778fuj1R/1lxNBx92sT9ADjlShezjYRx5+4yxZOrZrEJ1YX8qNG3rW
	JIPTatES9TS38IHK4a9IKbl5QuKTiXOBKgWz9XRpu1wUQwivTcF0JJXr0zqwFFykxmv4x3cMHU2
	MdiMFMFroU857xIztR4PhZBXRL66wt8ji98sY2Az/i2esqaHgghYq0rX0X5jREzGsrurwKB/XOM
	pMo9R6bP4EGUytoUk7te4gLvKjsh7xwRk22bJgTUWRSuvVAKZTx6eKabtAgSPrAu4cl/4BOKL3I
	vKQjxGscBjSwLcw7qgbsCxYo2xRMFJwZnkK16V7dGg9pDSBp8yl86VyAxH3iPUq3frqKn76lzxX
	aCI1zLkW6V+KuTFYLtIQU=
X-Received: by 2002:a05:6000:4007:b0:439:fdd5:34d with SMTP id ffacd0b85a97d-43a04dc07b1mr16332488f8f.43.1773568379677;
        Sun, 15 Mar 2026 02:52:59 -0700 (PDT)
Received: from localhost ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b899sm32421406f8f.23.2026.03.15.02.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 02:52:59 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Mar 2026 12:52:57 +0300
Message-Id: <DH39IOSGA9U9.K4GIHJXAPHX7@gmail.com>
To: =?utf-8?q?Burak_Kaan_Kara=C3=A7ay?= <bkkaracay@gmail.com>,
 <git@vger.kernel.org>
Cc: <christian.couder@gmail.com>, <karthik.188@gmail.com>,
 <jltobler@gmail.com>, <ayu.chandekar@gmail.com>,
 <siddharthasthana31@gmail.com>
Subject: [GSoC Draft Proposal v2] Refactoring in order to reduce Git's
 global state
From: =?utf-8?q?Burak_Kaan_Kara=C3=A7ay?= <bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <aa1cn0_ATfh-uRE4@gmail.com>
In-Reply-To: <aa1cn0_ATfh-uRE4@gmail.com>

Changes in v2:
- Clarified merge commit - commit hash difference.
- Added 'Project Background' section.
- Refined the part about Olamide's API in 'Technical Approach'.
- Removed 'enum git_error_code' proposal.

Thanks for time and guidance.

---

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Refactoring in order to reduce Git=E2=80=99s global state
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Personal Info:
--------------

Name: Burak Kaan Kara=C3=A7ay (he/him)
Email: bkkaracay@gmail.com=20
Education: UG Sophomore, Marmara University
GitHub: https://github.com/bkkaracay
Timezone: UTC+3 (Istanbul, Turkey)


My Patches:
-----------

+ (Microproject) t2003: modernize path existence checks using test
helpers
   - Thread:
     https://lore.kernel.org/git/20260208202809.270523-1-bkkaracay@gmail.co=
m/T/
   - Thread v2:
     https://lore.kernel.org/git/20260209112444.1268765-1-bkkaracay@gmail.c=
om/T/
   - Status: Merged to master
   - Merge Commit Hash: 70d3916a7db5233ce01f2f3f36ee04d57c0f9252

+ [PATCH v2 0/2] mailmap: reduce global state
   - Thread:
     https://lore.kernel.org/git/20260219125954.3539324-1-bkkaracay@gmail.c=
om/T/
   - Status: Merged to master
   - Merge Commit Hash: 2d843a2d3d6c2d5e7861e6aa99743d15d36746b9
  =20
+ [PATCH v3 0/2] run-command: stop using the_repository
   - Thread:
     https://lore.kernel.org/git/20260311151923.4178655-1-bkkaracay@gmail.c=
om/T/
   - Status: Will merge to master
   - Merge Commit Hash (next): 61ffe62b75cf89af469af53b15f3fdc6639d217a


Relevant Experience:
--------------------

I am currently developing my own programming language as a hobby
project, writing a zero-dependency interpreter for it in C. While it is
still a work in progress, I have completed the core front-end pipeline.
Building this project has given me practical experience with C
programming, data structures and modular software architecture.

+ To support potential future multithreading, I avoided global variables
in my own project. Instead, I pass state via local contexts.

+ I implemented an arena allocator (memory pool) to reduce malloc system
call overhead, prevent memory fragmentation and ensure cache locality.

+ I used techniques like string interning and Pratt parsing.

My project is available on my GitHub profile [1]. If you would like to
take a look at the code, 'src/main.c' is a good starting point.


Project Abstract:
-----------------

Git was originally designed as a short-lived CLI tool, where relying on
global variables was highly practical. Over time, the need to embed Git
into other projects and applications emerged. Today, these global
variables are a huge roadblock to the libification of git, as they make
it impossible to properly handle multiple repositories within a single
process or safely support multi-threading.

This project aims to reduce this reliance by migrating global variables
from 'environment.c' into appropriate locations. This effort will
support the libification goal and modernize Git's internal structure.


Project Background:
-------------------

Discussions surrounding the "libification" of git date back as early as
2005 [2]. However, efforts to isolate global state in environment.c
accelerated following Patrick Steinhardt's groundwork in 2024.

Once the environment.c cleanup became an official GSoC project, the
patch series from the first intern in this area, Ayush Chandekar,
provided valuable lessons on best practices and potential pitfalls.
During the later stages of Ayush's internship, the limitations and
safety risks of lazy-parsing became apparent. To solve this bottleneck,
Phillip Wood proposed a new eager-loading API, which was successfully
implemented by Outreachy intern Olamide Caleb Bello. Although this API
is currently functional, to avoid invasive changes across the codebase,
it can currently only read config values from 'the_repository' [3].


Technical Approach:
-------------------

The core challenge of this project is choosing the correct parsing
strategy more than relocating globals. The codebase currently offers two
migration strategies for global state removal.

Currently, globals are loaded eagerly via 'repo_config()'. Olamide's
'struct config_values' API provides a modern way to load these globals
eagerly by parsing them into fields in 'repo->cfg_values'. However,
eager-loading parses all configurations upfront, including unnecessary
ones. Users may encounter fatal configuration errors that are entirely
unrelated to the command they are executing [4].

On the contrary, lazy-loading postpones the parsing process until the
variable is strictly required, preventing unrelated configuration
errors. However, it is significantly trickier to migrate. If a
misformatted configuration triggers a 'die()' in the middle of the
execution, it risks causing data corruption. Moreover, lazy-loading
changes the timing of error reporting and struggles to replicate
eager-loading behavior when multiple configuration keys affect a single
variable [5].

If lazy-loading is considered safe for variable, git provides two APIs
depending on the performance requirements:

   * The 'repo_config_get*' function set is suitable for variables
     accessed infrequently because of underlying string hashing costs. It
     is important to use this API to not bloat the 'struct repo_settings'
     [4].
  =20
   * For frequently accessed variables, caching them within 'struct
     repo_settings' is preferred, as it amortizes hash costs and provides
     direct memory access speed.

There is no silver bullet solution for migrating globals. Because
transitioning these variables require a deep understanding about the
codebase, communication with mentors and the community is essential.


About Gentle Reading:
---------------------

Current config readers rely on 'die()' to handle error cases. While
pragmatic for cli-tools, fatal exits are unacceptable for a library, as
they will crash the host process. Building upon Derrick Stolee's recent
introduction of gentle parsing functions [6], I propose implementing
'_maybe' variants for core configuration readers. Since removing all
'die()' calls is inevitable for libification, sooner or later config
readers will be purged from 'die()' calls. Utilizing the gentle
functions for newly migrated global variables will reduce the future
amount of work.

Applying this gentle API to widely used functions risks creating
unreviewable patches and merge conflicts. To solve this, I plan to use a
function wrapper approach, similar to the strategy used in early
the_repository migrations [7]. However, the_repository changes are more
mechanical work compared to the gentle transition. In complex call
stacks, a gentle transition risks causing a regression or a scope creep.
Utilizing the "normal" config helpers will be helpful in these
conditions.


Availability:
-------------

I plan to dedicate 40+ hours per week to this project during my active
coding period. However, I want to be completely transparent about my
university's academic calendar to set realistic expectations.

In Turkey, the university summer break begins in July and ends in late
September. During May and June, my schedule will be heavily occupied by
final exams and major group project deadlines. For this reason, my
availability during these two months will be limited to around 10-15
hours per week. I will use this time to stay active on the mailing list,
participate in architectural discussions and submit smaller, preparatory
patches.

To ensure the highest quality of work, I propose utilizing GSoC's
officially supported flexible timeline. I am completely free during
July, August, and September (with no summer school or internships).
During these three months, I will dedicate 40+ hours per week entirely
to git.


Community Bonding (May 1 - May 24):
- Analyze environment.c and create a detailed mitigation plan for each
   variable.
- Discuss the plan with mentors to identify potential roadblocks or edge
   cases.
- Set up a blog to share bi-weekly updates throughout the project.

Phase 1 (May 25 - June 28):
- Introduce the '_maybe' versions of the config readers and write tests
   for them.
- Begin mitigating "low-hanging" globals. To avoid wasting time while
   waiting for reviews, start drafting next patches.
- Publish the first progress reports on the blog.

Phase 2 (June 29 - September 15):
- Discuss globals with mentors where mitigations might cause behavioral
   changes.
- Shift focus to the more complex cases, specifically those involving
   eager-lazy or '_maybe' transitions.
- Continue publishing regular blog updates.

Phase 3 (September 16 - September 30):
- Act as a buffer period to respond to final feedback on patches
   currently under review.
- Complete the final project report and publish it on the blog.

References:
-----------

[1] https://github.com/bkkaracay/caret
[2] https://lore.kernel.org/git/7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net/
[3] https://cloobtech.hashnode.dev/week-5-and-6-design-reviews-rfcs-and-ref=
ining-the-path-forward
[4] https://lore.kernel.org/git/xmqq1pk3lmu3.fsf@gitster.g/
[5] https://lore.kernel.org/git/23428022-ab13-4a3e-90ed-ff91ef93f051@gmail.=
com/
[6] https://lore.kernel.org/all/pull.2044.v3.git.1771849615.gitgitgadget@gm=
ail.com/
[7] https://lore.kernel.org/git/20260109213021.2546-2-l.s.r@web.de/
