Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792613028;
	b=ZerTXId1WfdU+wK4adSrf+c12+P+/FzX7BEYtAfxiaoXF/gZAIt4IVzajaGft7VEnAYw
	 8hk8aZ6YK/axQiGmdUmTSQ0oY7XSF4Q0174l+msavrrYfjhGol6wIaOXyNyEnyHQZ8aHD
	 bCyUTecPopo1wzyb0sBnE952Q0UKgWlf6LoWB6f/4Bx8GcrS/5k0geqwneHs0oneiBN2p
	 gZPnUpH6eAlNDJ9IamR7sxUoE9pOnZ1eq7tp9rnqZVsOqUHNCx4WKkPyX2Ok5pmp5ex2Q
	 yIxMsYetls0kZ+YChL5fWDs/Kdt1b4MmPjaR1/Tccd5IOQJgb8MaKw3fPW6Z+Izws0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792613028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/wR7ga0VxJ2SW0lnOGn9VS8aMi5ubieHH7c12Q9NwtE=;
	b=A0cfHGt0y8YimZhvao0e1sk5wEY4Gqx+L5Jft5Z/dDoyqTGepoj+XcOap+FWR/SaCul6
	 xUKglMeaMpvmGXJZPyY3cBGZ9R1TktEksb5qqwrmfwLqN4b5ZFvQtYMDhKaVQEC+GIiNm
	 Gd2HaP5VAgAOHtXU3+AuzJ58AF1ylpzR+JdLgky+c9qOtFRjmOQ3ibfh8CCsfNNm1rRH9
	 PLBel0raO3YjFT1QI2CoV250HxliYJmJRRLKbeVHyyLwvkT3pcri5IW6pyhUXnLZHqHi8
	 BF3UD0Tn2HCxHBu6r2mQfCzebcO9FMmT+2N+nHPjrJmuxjjwdFdrvkz0wT8nsepjJrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="o8mIoiG/";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A93606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 20:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29A93606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--emilyshaffer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=o8mIoiG/
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so2543705eec.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792613027; x=1793217827; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/wR7ga0VxJ2SW0lnOGn9VS8aMi5ubieHH7c12Q9NwtE=;
        b=o8mIoiG//l1zYzqbYYEwAx23FEmzbPCgrGxEE6FBAXYz139IuBBPaCL//rv5f44iDk
         EwBGZkEvtGFUuRyA0Z4/YmJ0zv7X1olHBUIdnz4YLFd4Ng9DlDRV3nKQYaA15cs7hMUf
         CXUp7lJDE2NIqmHd0OSj2ERKAX2/OpTQgHR8PgcqJVAQvSiNuhx609dIwROEeJihMB7j
         LNTHRzGM86tKvw4rXBZeyngCTjKAUouS/HF/CDqCPvvhkUi7543pDKaqlff90NAPBwq2
         ZPk4rMbWCQ2pcrcsEPUhGuej1tiXC1NUkYCCcAFueTAP0Bo9hQGhin8IyRMju/yf9arV
         ejbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792613027; x=1793217827;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wR7ga0VxJ2SW0lnOGn9VS8aMi5ubieHH7c12Q9NwtE=;
        b=lEN/mQeLs2+663+VDvJGYuIhD/q9QKLl6cIlD+PTjdCnFcucq5bhNswGMrnE/x/yPq
         swqfdCd+upBgzCNNPKkQdMMoL7K8YyV6EYbDDskah1D7nwyn3JThxjPTB3i+QLe9BeSv
         CneUUI0AHZa1a0tilsOGEr/mNvdFgdHvC3Y90TvgXUMHf2R9HuMGaJMx24TJEW830ryx
         dNlgeypx1darXDUr61OO/A6gFrm6WH5LOqsFBSxZinmKoke+mBWwksfF3TOm12xk9ICg
         Grl+yzyZrciv0EmDik7xaJDOQYLDGDkDhe6hfz0nWuMz+K/O2kf3Uw1aM2Fdck8FySRg
         o85w==
X-Gm-Message-State: AFq9FYKixyG9BBt6QDSRS0buOTtR3JK/ezMjCPOr+uwnFui/OJiiYYTS
	5sTBj9ihnqTNC0rm2EVXfrDjQtJY82iarSoEwCFLNhj1WX2uDfkVLbHYF/vGytWVA1diaJqZtRu
	2iNTMeJsSogcwVnHNRQw389wXNVDHwa5ITZTzwXWIuPQNcAQZcNsO/LNpnvP3RYm06WZiGmDYJ2
	5AhGyONaR9nyi3qJlVIitvUYbit2a5GHjZlnnD0u3z3U8r/rjvV9BbcaOe7IHAhzOk
X-Received: from dybvk1.prod.google.com ([2002:a05:7301:53c1:b0:356:dbeb:82ad])
 (user=emilyshaffer job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:90a:b0:368:6a59:f3a5 with SMTP id 5a478bee46e88-3686a5a02f1mr1142960eec.18.1792613026613;
 Wed, 21 Oct 2026 13:03:46 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:03:41 -0700
In-Reply-To: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261021200341.378978-1-emilyshaffer@google.com>
Subject: [PATCH] Documentation: propose community voting process
From: Emily Shaffer <emilyshaffer@google.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"

Not all discussions can be settled by community consensus. For truly
contentious decisions we need a way to democratically make a decision
that represents the majority will of the project. This doc outlines the
methodology we use in the rare case where we need to vote to make a
decision.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Hi folks,

Thanks for your patience with this taking much longer than I expected or
wanted it to.

As we discussed in the Contributor Summit this past September[1], there's
interest in taking a formal community vote to decide whether and how to accept
AI contributions. The topic is of course a very contentious one, and I don't
think that we're going to come to general consensus the way we have on most
other concerns in the past.

With this patch I'm trying to outline only the process for collecting the vote,
NOT a proposal for the AI contribution policy itself. I'm interested in making
sure that the Git community is able to be heard fairly, and that we don't end
up dealing with tampering during the voting process (e.g. non-contributors
dogpiling to shift the vote one way or another

I expect the approval of the voting process itself to be fairly non-contentious
(or else I haven't managed to write a fair process!) so for approving the
voting process, I suggest we use a similar approach to the one we did with the
Code of Conduct back in 2019[2][3]: discussing the process itself, ultimately
coming to general consensus, and collecting a list of Acked-by: to put onto the
commit outlining the voting process. And by the way, I do think that we should
check in the voting process; it seems likely to me that we will want to revise
the AI policy again given the pace of development, and it may be useful for
other discussions that we've had trouble resolving in the past.

BTW, there are some parts of this proposal that I still don't have a good
answer for, so look for my self-review immediately to follow, highlighting open
questions.

[1]: https://lore.kernel.org/git/summit-2026.94e33e9ddf234334.06@ttaylorr.com/
[2]: https://lore.kernel.org/git/20190924064454.GA30419@sigill.intra.peff.net/
[3]: https://github.com/git/git/commit/5cdf2301d4a8b439f89fd2cdfed13736ccd64a30 

---

 Documentation/CommunityVoting.adoc | 100 +++++++++++++++++++++++++++++
 Documentation/DecisionMaking.adoc  |   6 ++
 Documentation/Makefile             |   1 +
 3 files changed, 107 insertions(+)
 create mode 100644 Documentation/CommunityVoting.adoc

diff --git a/Documentation/CommunityVoting.adoc b/Documentation/CommunityVoting.adoc
new file mode 100644
index 0000000000..155acc9777
--- /dev/null
+++ b/Documentation/CommunityVoting.adoc
@@ -0,0 +1,100 @@
+Voting in the Git Project
+=========================
+
+For the most part, technical concerns in Git should be resolved by community
+consensus - either on the mailing list or in one of the annual-ish Contributor
+Summits. Voting should be used as a last resort when the community really and
+truly cannot come to a compromise on a policy decision. As such, the initiation
+of a vote should be generally agreed on by the mailto:git@sfconservancy.org[Git
+PLC] or primary maintainer.
+
+The voting discussion should be held to a single (huge) thread, to make it easy
+to refer back to the decision process when looking at the successful proposal
+after the process concludes. The thread may be structured like so:
+
+--------
+Formal vote: Commit subject line style guide
+  Re: Formal vote: Commit subject line style guide
+  ...
+  [PROPOSAL] Require emojis in commit subjects
+    Re: [PROPOSAL] Require emojis in commit subjects
+    [PROPOSAL v2] Require emojis in commit subjects
+      Re: [PROPOSAL v2] Require emojis in commit subjects
+      ...
+          [PROPOSAL v4] Require emojis in commit subjects
+  [PROPOSAL] Require Camel Case In Commit Subjects
+    Re: [PROPOSAL] Require Camel Case In Commit Subjects
+    [PROPOSAL v2] Require Camel Case In Commit Subjects
+  [PROPOSAL] forbid capitalization in commit subjects
+  ...
+--------
+
+A formal vote has three phases:
+
+1. Proposal collection and refinement
+2. Voting window
+3. Implementation
+
+Phase 1: Proposal collection and refinement
+-------------------------------------------
+
+Proposals should be formatted as a patch to Git's documentation, for easier
+review and implementation once landed. Anyone who is eligible to vote is
+eligible to submit a proposal. To avoid noise on the final ballot, a proposal
+will only be added to the ballot if it has been seconded by another eligible
+voter, indicated by a `Seconded-by:` footer in the patch's commit message.
+
+After the first draft of the proposal has been sent, the community is
+encouraged to discuss and polish the proposal, just like any other code review.
+Keep in mind that these proposals still need to be voted on, so it is likely
+counterproductive to use the discussion period to try to completely change the
+nature of the proposal or the mind of the author.
+
+This phase should last around 4 weeks in order to provide plenty of time for
+community members to write proposals and respond to feedback, and make space
+for contributors' individual timezone and availability differences. The
+maintainer or PLC member who sends the kickoff message should also include the
+closing date for proposal collection.
+
+It may also be useful to invite expert feedback during this time, e.g. from
+Software Freedom Conservancy's legal counsel, depending on the topic under
+consideration.
+
+Phase 2: Voting window
+----------------------
+
+The final version of each seconded proposal will be collected into a ballot at
+the end of Phase 1. When the ballot is prepared, eligible voters will be able
+to vote by mail for two weeks, to make space for contributors' individual
+timezone and availability differences. During this time the proposals may no
+longer be altered; the ballot should refer to a specific version of the
+proposal (e.g. `[PROPOSAL v4] Require emojis in commit subjects`) and any later
+version of the proposal will be ignored.
+
+Votes will be decided using <mechanism TBD>.
+
+Phase 3: Implementation
+-----------------------
+
+When the voting window ends, the winning proposal should be merged to `main`
+without delay by the maintainer. The commit message should be appended to
+include a link to the top of the voting discussion thread so that the
+discussion can be revisited by history divers in the future, as well as a brief
+summary of the result of the vote (% in favor out of total number of
+proposals).
+
+Voting Eligibility
+------------------
+
+Votes are welcome from contributors who have authored a commit which has been
+merged to next, or who have provided 2 or more code reviews, and who have not
+been banned from participation in the project. All eligible contributor votes
+are weighed equally, regardless of the overall number of contributions they
+have landed.
+
+To prevent dogpiling, contributions are only eligible for a given vote if they
+landed before the beginning of the voting process (the kickoff email mentioned
+above). That is, the code reviews must have been sent or the patch must have
+been accepted before the initial email is sent. The intention is to ensure the
+mailing list isn't spammed with low-quality reviews during the voting process
+solely to increase the number of eligible voters on one side of the issue.
diff --git a/Documentation/DecisionMaking.adoc b/Documentation/DecisionMaking.adoc
index b43c472ae5..c08fb7abd5 100644
--- a/Documentation/DecisionMaking.adoc
+++ b/Documentation/DecisionMaking.adoc
@@ -72,3 +72,9 @@ We prefer that "official" discussion happens on the list so that the full
 community has opportunity to engage in discussion. This also means that the
 mailing list archives contain a more-or-less complete history of project
 discussions and decisions.
+
+Formal Voting
+-------------
+When a decision cannot be reached by general consensus or compromise, a formal
+vote may be called. See link:CommunityVoting.adoc[Community Voting] for details
+of this process.
diff --git a/Documentation/Makefile b/Documentation/Makefile
index f8dea4b395..314b8dc8f5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -113,6 +113,7 @@ SP_ARTICLES += $(API_DOCS)
 
 TECH_DOCS += BreakingChanges
 TECH_DOCS += DecisionMaking
+TECH_DOCS += CommunityVoting
 TECH_DOCS += ReviewingGuidelines
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

