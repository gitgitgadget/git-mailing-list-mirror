Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632438;
	b=opUKSoXU/+QzXYShZKDzqhqJT1hiDe9OzH8HLdXvLD/KDAFAOVx74cDvBYEjFP42y6Ya
	 2yWC42Feu1PrkMVuwq4VBTez/NaZI6QvKGZ7BQ8UD91t4yteNVFKUBJa8YfAWnl+dziky
	 L7RJy0ehGPgidMA3/pwqakbEsYKhnbzFvo4EnHA55b9mqBB6wiX33jXK8MuFPzXHHA1tE
	 nttOm3R+6uod2uY7+j9SEqyMy4nEqP3+62apH/jnr4YZ6MPmUbdLjUDnaRMacY/+yh8v6
	 gpBE5egNiXZYgpq0Zo99BpaJTj1R7chQ0nOpk9XAYmUdYSuTcDru+8/WW5n4TTrjHHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=cU74aHM7jlNfSAz77KMkGZe5zvTTb6/VQO7v88VA7fM=;
	b=iZaI/vdGS7e9SyPMKqM1iqU64tSu5WrIvO8TKX04ukdS82jm438TnoTQSvfD2Yy+DrA/
	 JZaA8gx4Kd4e34pIiHvP4ua9ymfcRTRAOGfquYNr1CKyEdxYc/Yap+I8PRmpEI5tqbXdt
	 gtfKdFwEH1v0E2zWKgqTLkreEoCHhFkUGC8gYyGunvjasbw4VwcKyj4fWEME/y3pcmYQL
	 1bm7Wy5l+TFYTFEyBR7Vv+7A10geZFAhey2sKiMG3MovHD/zpRslinSwqcXH/fjDhV7Ea
	 hTM/Yf+8Uk4vOpZBdgnS5xSipscOni3ZflPLAnHx15QYL1xvMT+qUqb9xJN9hqyA+aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uuliPGCU;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928F60B0167
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 15:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0928F60B0167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uuliPGCU
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93e55db58cfso309258585a.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632437; x=1794237237; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cU74aHM7jlNfSAz77KMkGZe5zvTTb6/VQO7v88VA7fM=;
        b=uuliPGCU3YqA4cuwPij8OJIMmeu0rI/x1Z+60qMEfL6tDyvl3SxLpH7IqQXc6aq0xU
         lddFt4dQFxvzqi+Fg7qPyeKkiWuOuEe2Ka8WIb6vVCx1qbmDufq2rOcsyKo6cgJtkcW/
         PyiYh8a1Dk9U0yY9ZJVymI4JaGYX9eacD3/x9xj9ZDzS2CZUM8UDVx7/tidweMpvOiq6
         uYFH+qCiaFsEBnvmLvOeOsrghZvy3S/+2uMcbZNEPk1+PuLwfoKlB0xm+xYLIMHHvH+5
         Zhme249rH4hlWfV25BRkE4+YfN3Kc2g30bhXfGBDw8JEy2RoRkmQgjSQ2jXksCpl/1DT
         zDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632437; x=1794237237;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cU74aHM7jlNfSAz77KMkGZe5zvTTb6/VQO7v88VA7fM=;
        b=bAn1haz4bncVYgMVDo7M/zaDwDWPWTINrue4IXVkp57yaYzLng5lLVfWqMRsuZzmSy
         gUeQBuh9wvhqpeUK0Kd3UTpus+FT3FEG62LrIx9l046YSFByJQeIwc0gLYKHijMig1Iz
         u9ejSwB8QazWbHotnHILi4o/MR5lDoYB7GrnsDa3JVqVi/o+J7tEPhTF/Nh3cTBQP0xU
         w8Oi3ayAlOq1bME9tmoyxMv0pgPqq2TWyCCSmik890J2xoN+MDvcU/FLMoqHDCPhB2lw
         qRDm6XY0OHWae8JqawdpJQaEsxTZTuemJSo8FHLMhmKRs1RP+AlR2hinkDvhhtDfQNoi
         a7DQ==
X-Gm-Message-State: AFq9FYKwLbFoaamRR0NCs9QUhIBFTv5uLbl8z9wK2H7TLdEPCq9euVIr
	21gpphQh6AWTa5JVLeTX/nrL9tUVhUAoK0nMaw/FGKNDIm1UZyRV/Mkldid4zbfc
X-Gm-Gg: AYBFou2x8fquQs+9XCzG1JLdxDNZBIcE13b0zW6lHgtvcHrmO4ipxYK06qrAo/cpY9t
	PXJX2xUcenpnksCebdd3JqW0QZQqwHrzfAG0dQNAijjR9bmF+h4lgpPqiq+8964Nj0VcxVIWiTx
	C+U7UiEAWScTtaNaxo9TSqEnbC6WV7fFkPSZOswEswEMUlCExmSDJkfNBJknqorqDGgMK7qyrDB
	mQqdRjrZLe1V/BUfju4L5T4pNlJuOYBm47z1YSAbYB29Lvc3qebdm/p8DBTtO0ls2dzTfkWtmUE
	hW0Q74Lobm3wERHgF+3cdU6aWp+v79tugx4Ut+yo13GsnxH9vzgfRQUDne7j8SMlLdrSg54V5V5
	p+wOjeXqU8yiBdzkP6oVPxXS41qEC5kfOMXWq4ezQpqUG3R0zBmxUHx1pHwVTB5CIy4O0hsyVNF
	UfV5+DP+TjhdQ+7mm0dOvMZ6REsJEjXoB/Z5SCnE60so3A5NhCU5nty3GPJLni3SAnvxnDWMj8g
	+81YCvGhzmkpI2MVE0FpTiUInVXQy0bqChANDMSZqXtOYI+y6x6rYOXwmpWBs6h/rHXgCS+IGGC
	bCXMTNqqTvojbeGCQPitwunE/aLLFr5izA==
X-Received: by 2002:a05:620a:4586:b0:93a:1b82:4962 with SMTP id af79cd13be357-9442178c78amr1772581685a.47.1793632436890;
        Mon, 02 Nov 2026 07:13:56 -0800 (PST)
Received: from [127.0.0.1] ([52.188.198.105])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425ac6bddsm856297885a.37.2026.11.02.07.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:13:56 -0800 (PST)
Message-Id: <pull.2479.git.git.1793632435937.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 15:13:55 +0000
Subject: [PATCH] doc: document the current project governance
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

The social structures and conventions in place in the project are
not necessarily obvious to its members, especially to newcomers.
Misunderstandings about the expectations of the community concerning
certain processes can potentially lead to conflicts or friction.
The ways in which the Git project functions could potentially be
improved too, but identifying areas where improvement is needed
is more difficult if the existing conventions haven't been spelt out
explicitly.

Document the existing project governance in a new page of the
technical documentation. Describe our current ways of working
without claiming to set those in stone as policies.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
    doc: document the current project governance
    
    Hi all,
    
    Following our earlier discussion 1
    [https://lore.kernel.org/git/1aee1829-d7ad-47e2-b7d1-1a946bd59991@delpeuch.eu/],
    I have attempted to describe the existing governance of the project and
    am submitting this as a patch to get your feedback on this draft.
    
    There are a number of aspects that I couldn't figure out myself, so I
    have left some questions in the document, formatted as "admonitions". Of
    course, the patch isn't mean to be merged as long as those questions are
    present. I'm hoping that I can replace those by informed answers after
    your reviews. I expect that the answers to many of those will be along
    the lines of "there is no agreed-on process for this, we would make one
    up if the issue arises", which is perfectly fine. In that case I think
    it still makes sense to describe that as such for now (which might
    prompt the project to prepare for those situations better).
    
    As suggested by Junio, the purpose of this document isn't to be a policy
    but to describe the status quo. So if some processes described here feel
    accurate but inadequate, I suggest that the discussion about what they
    should ideally be happens in separate threads, similar to the one about
    the voting process 2
    [https://lore.kernel.org/git/summit-2026.94e33e9ddf234334.06@ttaylorr.com/T/#m7b0180985c2ea6325078119406d09a4e4f0b9481].
    
    Thanks,
    
    Antonin

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2479%2Fwetneb%2Fgov_doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2479/wetneb/gov_doc-v1
Pull-Request: https://github.com/git/git/pull/2479

 Documentation/Governance.adoc | 85 +++++++++++++++++++++++++++++++++++
 Documentation/Makefile        |  1 +
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/Governance.adoc

diff --git a/Documentation/Governance.adoc b/Documentation/Governance.adoc
new file mode 100644
index 0000000000..b1f0a21203
--- /dev/null
+++ b/Documentation/Governance.adoc
@@ -0,0 +1,85 @@
+= Governance of the Git project
+
+This document describes the social structures in place in the Git project. It intends to be neither prescriptive, nor express a judgment on the merit of those existing ways of working.
+
+== Scope
+
+The Git project develops a free and open source distributed version control system.
+The scope of the project covers https://git-scm.com/install/source[the git.git repository],
+associated repositories hosted under the https://github.com/git[git GitHub organization] and the <git@vger.kernel.org> mailing list.
+Other spaces are considered external to the Git project for the purposes of this document.
+
+[NOTE]
+====
+Not knowing exactly what is considered part of the Git project or a third-party project, I have left the following repositories and initiatives out of the scope of this document for now, but I am not sure about this choice:
+
+* https://github.com/git-for-windows/git[Git for Windows]
+* https://github.com/j6t/git-gui[git-gui]
+* https://github.com/j6t/gitk[gitk]
+
+====
+
+== Roles
+
+=== Maintainer
+
+The maintainer is the head of the project.
+Their primary responsibility is to select patches submitted to the mailing list and integrate them in the git.git repository, to which they have an exclusive write access.
+The maintainer is Junio C Hamano, who was nominated by Linus Torvalds in 2005.footnote:[https://lore.kernel.org/git/Pine.LNX.4.58.0507262004320.3227@g5.osdl.org/[Meet the new maintainer], Linus Torvalds, 26 Jul 2005]
+
+When they take a break, the maintainer delegates their responsibilities to others. There are no firm plans about what would happen if the current maintainer was to retire, but
+there is interest in preparing for such a possibility.footnote:[https://lore.kernel.org/git/ZwAIM6GO3VtoG3ZM@pks.im/[Re: the latter half of october, the maintainer goes offline], Patrick Steinhardt, 4 Oct 2024]
+
+=== Project Leadership Committee
+
+The Project Leadership Committee (PLC) liaises between the project and the Software Freedom Conservancy, Git's fiscal sponsor.
+They coordinate on a private mailing list reachable at <git@sfconservancy.org>.footnote:plc[https://lore.kernel.org/git/20180816224138.GA15490@sigill.intra.peff.net/[Git Project Leadership Committee], Jeff King, 16 Aug 2018] Their responsibilities are:
+
+* to approve project expenses footnote:plc[]
+* to oversee the use of the GIT trademark, following the https://git-scm.com/about/trademark[policy] footnote:[https://lore.kernel.org/git/CAP8UFD3WQ64FuXarugF%2BCJ_-5sFNBCnqPE0AEBK-Ka78ituKTg@mail.gmail.com/[Handling the Git trademark], Christian Couder, 13 Sep 2022]
+* to enforce the code of conduct footnote:[https://github.com/git/git/blob/master/CODE_OF_CONDUCT.md[Git Code of Conduct]]
+* to produce an annual report of their activities, sent on the mailing list footnote:[https://lore.kernel.org/git/aNblfuTDdtxLdImC@nand.local/[Git / Software Freedom Conservancy status report (2025)], Taylor Blau, 26 Sep 2025]
+
+The committee consists of at least three members, who currently are:
+
+* Junio C Hamano
+* Christian Couder
+* Ævar Arnfjörð Bjarmason
+* Taylor Blau
+
+Those members are renewed by cooptation, after consultation with the community. When doing so, the over-representation of an employer in the PLC is avoided.footnote:[https://lore.kernel.org/git/20180821020849.GA2527@sigill.intra.peff.net/[Re: Git Project
+Leadership Committee], Jeff King, 20 Aug 2018]
+
+NOTE: Is there any existing process for leaving the PLC? (for instance, if someone has become inactive in the project or is in conflict with the rest of the project's leadership)
+
+=== Security team
+
+The security team triages vulnerability reports sent to the project.
+They do so on the private mailing list <git-security@googlegroups.com>.
+This team also includes people operating widely used git hosting sites and packagers.footnote:[https://lore.kernel.org/git/xmqqbj9d3y9x.fsf@gitster.g/[A note from the maintainer], Junio C Hamano, 1 Oct 2026]
+
+[NOTE]
+Is the list of subscribers to git-security public? +
+How does one gain and lose access to this list? +
+Does Johannnes Schindelin play a particular role in the security team? https://lore.kernel.org/git/5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de/[He seems to
+have the lead in triaging vulnerability reports], but I can't really tell to what extent
+
+=== Localization maintainer
+
+Jiang Xin coordinates the localization of Git by maintaining https://github.com/git-l10n/git-po[git-po].
+
+NOTE: How would their successor be appointed?
+
+=== Website maintainers
+
+The https://git-scm.com[git-scm.com] and https://git.github.io[git.github.io] websites are maintained by members of the https://github.com/git[git GitHub organization].
+
+NOTE: Under what conditions does one get added/removed from there? Are all members of the GitHub organization entitled to maintain all repositories there? Who has "Owner" access to the organization?
+
+== Decision procedures
+
+The decision process for technical changes and the venues for the associated discussions are documented in `Documentation/DecisionProcess`.
+
+There is no firm process yet for decisions on policy changes. There is ongoing discussion about adopting a voting process for such
+decisions.footnote:[https://lore.kernel.org/git/summit-2026.94e33e9ddf234334.06@ttaylorr.com/T/#m7b0180985c2ea6325078119406d09a4e4f0b9481[Documentation: propose community voting process], Emily Shaffer, 21 Oct 2026]
+For now, decisions are taken by the maintainer, who is expected to follow the consensus emerging after a discussion on the mailing list.footnote:[https://lore.kernel.org/git/summit-2026.94e33e9ddf234334.06@ttaylorr.com/[AI contribution policy], Taylor Blau, 6 Oct 2026]
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1747f4a00b..b2b58aa9d0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -112,6 +112,7 @@ API_DOCS = $(patsubst %.adoc,%,$(filter-out technical/api-index-skel.adoc techni
 SP_ARTICLES += $(API_DOCS)
 
 TECH_DOCS += BreakingChanges
+TECH_DOCS += Governance
 TECH_DOCS += DecisionMaking
 TECH_DOCS += ReviewingGuidelines
 TECH_DOCS += MyFirstContribution

base-commit: ebdc087dc99d68bb340c282b2ba5f722def28d19
-- 
gitgitgadget
