Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA0B11CAF
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443198; cv=none; b=GWoNVc9yTpzq6EG0zSZ4jwcKOSYsyb/hT+xcWCWM1GyvNaPm5QeLd0C9XdzlxJ0O9/9/hrlhE2KO72+L3gGotDoOakbCPnF6TzIJ0fqHaoQU8u0hOtmGaEO9ZShu09b/BLYrZ68ho19b5rMm7myDX6FRMPRamLAhUrc/E+qbMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443198; c=relaxed/simple;
	bh=qjwVByp1iFHJ6Ro7QuQSTJzWic21nW442I8GdHBpyJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbIBtEXyK+S8BaPUabPTc7iymu3dP+dN1x86MkFfF/K352ovOxJfuhdYF2HoE3jcf1kcwLNd2r8PQshvae1nTFnm0ya6V6wc7Q2m+iBMzqi9SjJEVWua6taVpBRx2V+QrceBvPepA77mV/F01eo5J8UXCoH914URlPZMlIB65qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=qgwR4olp; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="qgwR4olp"
Received: from inspiron-LM22 ([80.189.83.109])
	by smtp with ESMTPA
	id 4RXivYtrc2D8r4RY0vkVxP; Thu, 02 Oct 2025 23:13:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1759443193; bh=m4I+7OVO74uIcs8hI4PkJcfpr93CTu2D7evfevD+8fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qgwR4olphB9/bw8DsZ2u6BJx1sYB8eNOfuB+cCfszvijqtmSzRGgeceC75IlrGhYR
	 KecMcRKwSTfogVtIfoq3V0sFSSl6VAVn5IwBwqZpPa9liHFmSKvtrXLERnb41FZfxR
	 YmJF1b3xo5/G9Oy987kjZZJdEVw45kXRMPH0QYcM7LtoYFKTIgwAwvpT0eN/rTZvgx
	 ZqbidoRU4EtskSH/09UW/VaQ9jx1QUMOfzQa+deYrXkfNc2ecMM0BfJHCbsbu0SBxg
	 KhFNW48RqQ6xHwK6LVWVfr1PZX7txr6Tbn+1kgG4T3IWQpAuCo6u0u+9Bgiv8SwiyB
	 efPf/FYzhpyww==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=beTIU/PB c=1 sm=1 tr=0 ts=68def8f9
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=EN9LMFLN1Mj5RIHHXKcA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 1/4] doc: add some missing technical documents
Date: Thu,  2 Oct 2025 23:12:13 +0100
Message-ID: <20251002221233.541844-2-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
References: <https://lore.kernel.org/git/bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com/>
 <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAAkqv8yEiehzaud8ulBWMmt+HP0pe9+a5d19o3oIiqfXdFbN6EvWUd/24FidQavUCV8OxHThhMdUdEu+1S83mvHQkeaapb5x+1Uw1D0PE1kEg/vninm
 sWj9B/oirv0XBWxhF3TroegsySytUfigwF8COu/w9TuwJGzOpX5Krz7RfZbf8BC3DMEovZ+vmw5TI0iRuaJOZLPwoaQ7+kKOcpE=

Commit bcf7edee09 ("meson: generate articles", 2024-12-27) added the
generation of the 'howto' and 'technical' documents to the meson build.
At this time those documents had a '*.txt' file extension, but they were
renamed with an '*.adoc' extension by commit 1f010d6bdf ("doc: use .adoc
extension for AsciiDoc files", 2025-01-20), for the most part. For the
meson build, commit 87eccc3a81 ("meson: fix building technical and howto
docs", 2025-03-02) fixed the meson.build files, which had not been
updated when the files were renamed.

However, the 'Documentation/Makefile' has not been updated to include
all of the recently added technical documents. In particular, the
following are built by meson, but not by the Makefile:

    commit-graph.adoc
    directory-rename-detection.adoc
    packfile-uri.adoc
    remembering-renames.adoc
    repository-version.adoc
    rerere.adoc
    sparse-checkout.adoc
    sparse-index.adoc

In order to ensure that both build systems format the same technical
documents, add the above documents to the TECH_DOCS variable in the
Documentation/Makefile.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Documentation/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6fb83d0c6e..a3fbd29744 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -119,18 +119,26 @@ TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/build-systems
 TECH_DOCS += technical/bundle-uri
+TECH_DOCS += technical/commit-graph
+TECH_DOCS += technical/directory-rename-detection
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
+TECH_DOCS += technical/packfile-uri
 TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
 TECH_DOCS += technical/platform-support
 TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/reftable
+TECH_DOCS += technical/remembering-renames
+TECH_DOCS += technical/repository-version
+TECH_DOCS += technical/rerere
 TECH_DOCS += technical/scalar
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
+TECH_DOCS += technical/sparse-checkout
+TECH_DOCS += technical/sparse-index
 TECH_DOCS += technical/trivial-merge
 TECH_DOCS += technical/unit-tests
 SP_ARTICLES += $(TECH_DOCS)
-- 
2.51.0

