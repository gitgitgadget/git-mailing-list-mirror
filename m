Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803074;
	b=bV7856yDKHzrr+/IzR5CpRV50hgJ0xGQDy0ftT9gp7Ovp0Vopkd7fFxyynUXWJqxUFo6
	 w5yCAYJGO6pnAxay4DU1HU0X/MzhFbC+E2mjzXJTzKHchbqKgWeBCdIuywEKz13Vg7eZW
	 sQDHrn7m2ZsjskU0ib1RHnnDs+U/Yel6XqiDRgRqiK7HatRxIj1v7YASj5wMvcFSANpYf
	 H7SVvP6K0RAGP9zGZHyt6PhxmzBITfmqbE0bvRtg/FA+ZDU7OxV242H65gbPW5yxavEHr
	 PfavmdJ5JYtvJR/JaStFeHmxLwzigeSZpG/uPkSyfFL6qnpz2blkc6F69Snb+Bp9aWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GYBNI2+Rt3yuc4hMxF3uZoB0Q4ol78p7dQK0qRAzOSY=;
	b=QsEfpPNb54hKOiWMIBxqIf/WXb6eertpMPtnhAIi3HO5WgtnzRnPAGxtMhPhCWPDclHO
	 Gtc7FSVYBPiqW0g16BHm/IUTAz4mNvyvf4qRezg00xCnvqe6QOMyxCF6hlAZi/czC9sEQ
	 kE714JnGgw3Ql6AfPaTqwLk9ka6vUE+V5vPnxYXEjGPbzMUn8N3KPxW0cSJ7ydZkkSewq
	 CE7kyJngz659R1v/vmbhXyIjJez0fq+Ke8RW4tab2IMgEvoNNedsR9n7PZoUBxf8cRGiU
	 Qrobm2F9M064+UIdMj2FTP2NCiA7YGf7xyJzaMJLjRKpBvkiRvOq3Kj4v/AF78XuIeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jBraCCzG;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57199606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 14:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57199606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jBraCCzG
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso5394395e9.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 06:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793803073; x=1794407873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYBNI2+Rt3yuc4hMxF3uZoB0Q4ol78p7dQK0qRAzOSY=;
        b=jBraCCzGArTBKQ5tgTq8ofdc8NARr88Etu/J/9N5wgo2PPofZNgy8SNka2GmK7fdOe
         WbpeqOgbAqZzzxR4n2iv4ljGK0OjUdV1IPzG8VtesVaQkbaa5SGEWFu3rp9yRaPY72VO
         C2Eq/GMykID0vjsI/hUV9AArTjpKxaUoAf1t5r0mckJjgAQHKVOkyQrsCniN74D7ENGM
         mzOOfd47U662MVJwZMF3ig4/ZAWjx8Lze7C/s1pSmOzeiskHP/UE2DBIwhQoeWt168If
         PV5LF7zlKbDVp5u9T//TLBdStOT6xYfUl/7I+fTp9CS3qTvNoVEPGisinnmKUn2nIPVU
         MIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793803073; x=1794407873;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GYBNI2+Rt3yuc4hMxF3uZoB0Q4ol78p7dQK0qRAzOSY=;
        b=YK6XaE6GJGmGamQIvArI2M1h2u8OsGjWELWYGrRtxoAhRkTMwQkMc1yDRdcg6SDAMj
         InvBk+UALB1Il/Yi95Hxd6+lAfuo0rCMH0VntMK81OtVl7TwvGbmW3xBulXdqp8Jo5UK
         bIdeSdkk4a8Oi5VlKf7mvTb8EgQwzSx0UDEiy2Y11VG2OlbwZcmt7LqqD4D1Fn8asZZ5
         nPz/7OkfLN95d9beC3VOmvVItvPipkHo7JHWPjonZs4vUldokcOmnUqpUjeOQJ4PXqgY
         f9G29d/KXPLcq+B3becEP5E7HF1LYb/fA8KJ5FIhqdsfggv+zYS1UYpbxBESIq633YAu
         fcMg==
X-Gm-Message-State: APuU4Z/seRmjqu10t2QTACxtzZ+XKt4i+FsbLGgIqDJLyIQGOTvfmwYf
	ea0H1tWUzzLZxzHeEsDf+oihZaCEeols5rk8D/J5ZUGkER+Jw09pgGsZ8vsNFw==
X-Gm-Gg: AYBFou3/5wTgVfIP6H6GnFkQ7yTqWh02V1L8VZdBmuYPNb8a6PdZe3B55DliiifsigN
	FHPzjcTr1mVx8sGJWwST2To9uHdTpTsPe5Ujr1tPA5qVFmV/7rs6ofPsOISM0sl3fFb6z2hwTal
	j86NPULFwGLce957XVpdMAs2lmV/Cc1bmIzN0vp9e/TgIfcaQE4nElNhPhJiIt8KoqFM7n4BzC2
	gPV5BQHhXZD1zntBtJWmBg/PUjWfqZPRbSf4CZQ18V/evGWepOkEa3v3CmmmJ0P8Lc49TCDi7Yx
	W7z0SdXRReoN60dKmIjQRIqbGDiUXTrBfi7hdonBwYuue6fkZosZssnQONDjHdH2PaLKzTgyhG4
	SfUNEs91KATNpODekj1Hup3RBscTerDOyFVZj/ZvIf1e72Ic9PVPr9m8JmyDejRiy8sVBhpsHds
	gp+JCGB8jQzHn2pa1XUv7I5GyICg1wAjvaKiYHIXVnPziHclrxLsMCD8lKFCDnct3snPWalBvIK
	w5DA+YBNhAN/WZhvY7xKQT5kUQBIigDzcvnbGB/BXg8gU6U49bq5Rmvce8LpqrxkabtmrF6akmj
	VA/J8dnA4Q3GqnCbd3zQpECG5JyRfqFSi5mUZV1lPp42pNhxONleTQ==
X-Received: by 2002:a05:600c:8b46:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4ac18c73238mr380796435e9.33.1793803072416;
        Wed, 04 Nov 2026 06:37:52 -0800 (PST)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aaa4b85fsm131696215e9.10.2026.11.04.06.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:37:51 -0800 (PST)
From: kerylefondji7@gmail.com
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com
Subject: [OUTREACHY][PROPOSAL] Improve how command arguments and options are scanned and parsed - Keryle Fondji
Date: Wed,  4 Nov 2026 15:37:41 +0100
Message-ID: <20261104143741.654-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi mentors and the Git community,

Here is my Outreachy proposal for the project "Improve how command
arguments and options are scanned and parsed".

I would appreciate any feedback from mentors and the community.

Personal Information
--------------------

Full Name: Fondji Tamekong Keryle Blondeau
Email Address: kerylefondji7@gmail.com
Location: Kribi, Cameroon (WAT, UTC+1)

About me
--------

I am a self-taught C developer with a background in computer science,
interested in low-level programming and open-source development.

My journey into open source began when a friend introduced me to open
source and shared details about Outreachy.

When I first tried to apply to Git years ago, I struggled with the
codebase and could not finish a patch in time. However, I remained
motivated to learn. I spent time studying Git internals and improving
my C programming skills.

Returning to Outreachy this year with better preparation, I was able
to follow the mailing list workflow and complete a merged contribution.
Working on Git's parse-options API confirmed that the "Improve how
command arguments and options are scanned and parsed" project is the
right fit for my 13-week internship.

Project Details
===============
Applicant: Fondji Tamekong Keryle Blondeau
Mentors: Christian Couder, Siddharth Asthana

Contributions Summary
====================

Contribution #1: started Oct. 17, 2026. Not accepted or merged.

Patch: [PATCH v3] builtin/var: refactor to use parse-options API [1]

Details:
On October 17, 2026, I started working on converting option handling in
builtin/var.c to the parse-options API. I sent three patch revisions
(up to v3), updating the option structures, flag logic, and formatting.

Context, Learnings & Outcome:
During code review, Phillip Wood explained that git var had already been
converted in commit e19f0779c67 in September 2026 [1]. Even though the
changes were already upstreamed, this attempt was very helpful. Phillip
noted that the main goal of microprojects is to help candidates practice
sending patches, using the mailing list, and handling reviews.
Through his response, I learned how to run the test suite, search the
mailing list archives [6], check the 'seen' branch, and use microproject
documentation [4, 5].


Contribution #2: started Oct. 26, 2026. Accepted and merged into 'next'
(marked "Will merge to 'master'").

Patch: [PATCH v7] archive-zip: refactor 'path too long' error message
to use Q_() [2]

Details:
On October 26, 2026, I started working on the error message in
archive-zip.c for pathnames that exceed maximum length limits. I updated
the code to replace _() with Q_() to handle plural forms correctly for
internationalization [2].

Context, Learnings & Outcome:
I submitted seven patch revisions (v1 to v7) on the mailing list [2].
Thanks to clear feedback from Junio C. Hamano, Phillip Wood, and
Kristoffer Haugsbakk, I gained practical experience in:
- Internationalization (i18n): Using Q_() to handle plural forms across
  different languages.
- Git Coding Guidelines: Following indentation standards, aligning
  function arguments, keeping lines under 80 characters, and using tabs.
- Patch Workflow: Structuring commit messages according to
  SubmittingPatches.

On October 29, 2026, patch v7 was accepted and merged into 'next'
(commit ae25f6f799), and included in Junio C. Hamano's "What's cooking
in git.git" report marked as "Will merge to 'master'" [3].


Availability
============
I am committed to 40 hours per week during the internship.
I am based in Kribi, Cameroon (WAT, UTC+1) and can adjust my hours for
calls, syncs, and reviews.
I have no conflicting work or exam commitments.


Internship Blogging
==================
I will publish regular updates about my progress, technical notes, and
challenges on a schedule agreed with my mentors, and share post links on
the mailing list.

Proposed Timeline
=================

Pre-Internship Period (Now – Dec 6):
- Continue studying the Git codebase and internal option parsing APIs.
- Work on another microproject or cleanup patch on the mailing list to
  keep practicing the patch workflow.
- Discuss initial target builtin/ commands with Christian Couder,
  Siddharth Asthana, Phillip Wood, and Junio C. Hamano.

Weeks 1–2 (Dec 7 – Dec 20): Onboarding & Command Selection
- Set up local test setups for target commands.
- Confirm the first group of builtin/ commands needing option parsing
  refactoring with my mentors.
- Submit a first setup or documentation patch for the workflow.

Weeks 3–6 (Dec 21 – Jan 17): Option Parsing Conversion (Batch 1)
- Convert legacy option parsing in the first set of builtin/ commands to
  the parse-options API.
- Update or add tests in t/ to maintain test coverage.
- Send patch series to the mailing list and address review comments.

Weeks 7–10 (Jan 18 – Feb 14): Refactoring & Cleanup (Batch 2)
- Work on the second set of commands assigned by mentors, including
  subcommands and complex flags.
- Update error messages according to Git coding and internationalization
  standards (Q_() / _()).
- Follow up on review discussions on the mailing list.

Weeks 11–12 (Feb 15 – Feb 28): Testing & Integration
- Prepare final patch revisions based on maintainer and reviewer
  feedback.
- Run full test suite checks on all modified commands to ensure
  stability.

Week 13 (Mar 1 – Mar 8): Documentation & Final Evaluation
- Complete documentation updates and submit the final Outreachy report.
- Outline post-internship contribution goals for Git.

After the Internship
====================
After the internship, I plan to stay active in the Git community by
sending patches, reviewing code, and supporting new contributors.

Appreciation
============
Having my first contribution merged into Git has been a meaningful
achievement for me. I would like to thank Usman Akinyemi for the warm
welcome when I joined the mailing list.

I am very grateful to Junio C. Hamano, Phillip Wood, and Kristoffer
Haugsbakk for their patience, reviews, and guidance on my patch
revisions [1, 2, 3, 4]. Finally, thank you to my mentors, Christian
Couder and Siddharth Asthana, and to the Git community for helping new
contributors learn and progress.

References
==========
[1] https://lore.kernel.org/git/d748915d-c50c-4143-8140-ae885a6ba604@gmail.com/
[2] https://lore.kernel.org/git/20261026192803.1985-2-kerylefondji7@gmail.com/
[3] https://lore.kernel.org/git/xmqqcxsmejd9.fsf@gitster.g/
[4] https://git.github.io/SoC-2026-Microprojects/
[5] https://git.github.io/General-Microproject-Information/
[6] https://lore.kernel.org/git

Best regards,
Fondji Tamekong Keryle Blondeau
