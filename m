Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43631272B8
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223210; cv=none; b=payp1l8rfxYwZbFCfMO3STMnh9mRWF+6aHyUGaTapDGi9tXwsRxLnrMBp+LdYYtIFAQALr5xzmH4k8ugs7JRRc0xmp69r+0XBWTuoNAJiFLa6a9DzsfDsOfhX3ZS2zNJrcBplHyR6j6gD+KT8xCZ9qMheBZJfZx83bDAY4/riV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223210; c=relaxed/simple;
	bh=kDk7ultIYBGd8M3FoqTaeufeg5ZjYwzmN6CB22yCDso=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RVQzGhtuJgqNmv/LmLgmUTs7j3SMkyskw1eATHs6DeLxcYHPRJ/ke/7h+G94aF7CiTSM+0RICqXaa7p38VACXZZ7mbBzYMK3fqx0egkOmTWPpqo6qtYBdHvrsd7yIztnl8qI3BfycAGMx+l8eXcOb9FTc1Hw2h2Cd4lJhqmq1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvVJO/w5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvVJO/w5"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61aecbcb990so4767397b3.1
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 16:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713223207; x=1713828007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBVprKjqhzaSlM799uOkR4TJ83hTSrJAcZeVppxLfDA=;
        b=VvVJO/w5R2cjR/yMSBCq9q1rdOmEK3oe7aDofhm8T2aWL4EKxlV/tPW5sdjS15SV17
         9kdFk9gcjC4UYGl2Kaz2XKKaSGKS7kY8RErfbbx7ZB0yUzi3+ut48ip9bjEHJpj+wJL4
         ntqKu5GhDXhSBxCSEE9HkE549fRzfx8JMrKo/lGl/hsq/C60u6LDz7szpuyNbu6PzLs1
         CSnUzrsRj1kE+I32ahkoJuy1pRGczcwp5WqzTxnG8Wn0BqPvwwkSjWL4p1eI+OdlXP7l
         y0CMUXsY8K/5j0THA0/US1JEi5NYl30eMhwWfjs7wA8TemsOMQFnQn6A+OB4gpa6AS+T
         zYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713223207; x=1713828007;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBVprKjqhzaSlM799uOkR4TJ83hTSrJAcZeVppxLfDA=;
        b=hmZnViwff1U+tJuWqn4YJH0L1WR/xzynivIqSqK1GmWs4XIF6KVvKIwhfd2oz5H4Zo
         xz8Oh68OPikTOCYDvSX/cg8pnsT3Pjworg6opwwLdVjCiiIcbCyBhE+jEYBnELDuI2X/
         nGAmi/eb8DfsHhuHkqF+Hl3z0WqD6zZIyIKvWmF9FlMrttc9w3QseOmZxTiwtRtRJFqa
         X9aLQSD/QAkBlv9lnxNRfuaGTq6YyFVO8z2L2coW5a1ADaQXbApTBEu/kk/LBpUytdkI
         2BWZGCLCKq1O4wpfNe/cQwAQ6pHSrTsLEMFjOamYTBlKBXkdKSgQdj9TzB005HOYpVCS
         FSlw==
X-Gm-Message-State: AOJu0YyFphyjX4eEWypHxNkmizEwcXK64IN7kNsfmDPtR1Gjhmnpzpcq
	DAHfeUYZT+tqaTqh2USTATU6wC4I42VcXMXQ4EqwiMCoO4UgUCKVybdDVTXY8Du9noke92VP6lI
	OItiohJkTpCuEgyKT9vNmhDPxa8aMDr0w0ko1jJo5shYeTgfm6WbzlNP/SN7LWuXLvIMHayBw8u
	l40hlrmXE97cdUJDbvclr02ZwU6yYkE2UiTq1ecxk=
X-Google-Smtp-Source: AGHT+IGjn5xkw7ZFnzPvWOj+tSpXjAsPRGI7r/VgRM0gC+uDC1HGUME4+dux6Lq70JdLvWB/6Z6MN4u42siU7g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:29d4:b452:bd4b:5464])
 (user=steadmon job=sendgmr) by 2002:a81:a04b:0:b0:61a:e319:b0 with SMTP id
 x72-20020a81a04b000000b0061ae31900b0mr557720ywg.1.1713223207606; Mon, 15 Apr
 2024 16:20:07 -0700 (PDT)
Date: Mon, 15 Apr 2024 16:20:05 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
Subject: [RFC PATCH] doc: describe the project's decision-making process
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: avarab@gmail.com, christian.couder@gmail.com, gitster@pobox.com, 
	me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"

The Git project currently operates according to informal, unstated norms
when it comes to making bigger-picture decisions (above and beyond
individual patches and patch series). Document these norms so that
newcomers to the project can learn what to expect.

This document explicitly does not aim to impose a formal process to
decision-making, nor to change pre-existing norms. Its only aim is to
describe how the project currently operates today.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
This doc represents my impression of how the community operates. I have
obviously not been around as long as many other community members, so I
would welcome feedback if you feel that this misses or misrepresents any
aspect of how we make decisions.

One particular blind spot for me is how the Project Leadership Committee
operates, or if that's even relevant to this doc.

Unfortunately, I will be away from the list for a few days for $LIFE
reasons, but I will try to address feedback promptly once I get back.

 Documentation/DecisionMaking.txt | 58 ++++++++++++++++++++++++++++++++
 Documentation/Makefile           |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/DecisionMaking.txt

diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMaking.txt
new file mode 100644
index 0000000000..80fc732551
--- /dev/null
+++ b/Documentation/DecisionMaking.txt
@@ -0,0 +1,58 @@
+Decision-Making Process in the Git Project
+==========================================
+
+Introduction
+------------
+This doc aims to describe the current decision-making process in the Git
+project. It is a descriptive rather than prescriptive doc; that is, we want to
+describe how things work in practice rather than explicitly recommending any
+particular process or changes to the current process.
+
+We want to describe how the project makes larger-scale decisions. We won't be
+discussing how decisions are made for individual patches or patch series,
+although the process is similar at a high level.
+
+Starting a Discussion
+---------------------
+Proposals are made on the mailing list. Because members of the Git community
+have a wide variety of experience, backgrounds, and values, proposals are
+expected to include as much context as possible.
+
+If the proposer is aware of individuals with an interest in the topic being
+discussed, it is polite to CC them on the proposal to make sure they are aware
+of the discussion.
+
+Engaging in Discussion
+----------------------
+Once a proposal has been made, the community will discuss it on-list. While the
+maintainer will often participate in discussions, it is not the maintainer's
+responsibility to guide discussion; the proposer and any other interested
+parties are expected to stay engaged in the discussion and ensure progress is
+made.
+
+Anyone with an interest in the topic is welcome to discuss the matter. It is
+expected that all discussion will adhere to the Code of Conduct rules.
+
+Other Discussion Venues
+~~~~~~~~~~~~~~~~~~~~~~~
+Occasionally decision proposals are presented off-list, e.g. at the semi-regular
+Contributors' Summit. While higher-bandwidth face-to-face discussion is often
+useful for quickly reaching consensus among attendees, generally we expect to
+summarize the discussion in notes that can later be presented on-list, so that
+the full community has opportunity to engage in discussion.
+
+Finalizing a Decision
+---------------------
+After a suitable period of time has passed, the maintainer will judge whether or
+not consensus has been reached. If so, the consensus decision will be
+implemented. Otherwise, discussion may continue, or the proposal may be
+abandoned.
+
+In general, it is not the maintainer's responsibility to implement any
+particular decision. For decisions that require code changes, it is often the
+case that the original proposer will make the necessary changes to implement the
+decision, although it is also common for other interested parties to provide an
+implementation.
+
+For non-technical decisions such as community norms or processes, it is up to
+the community as a whole to implement and sustain agreed-upon changes.
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f2383a12c..a04da672c6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -103,6 +103,7 @@ SP_ARTICLES += howto/coordinate-embargoed-releases
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 SP_ARTICLES += $(API_DOCS)
 
+TECH_DOCS += DecisionMaking
 TECH_DOCS += ReviewingGuidelines
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk

base-commit: 436d4e5b14df49870a897f64fe92c0ddc7017e4c
-- 
2.44.0.683.g7961c838ac-goog

