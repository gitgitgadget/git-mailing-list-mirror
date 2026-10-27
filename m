Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115584;
	b=ST5RrLGczq7WgUwty2JJxBAVrtGhhtb/Qb4rEHIxSEexXz9/5fI3Zg/dO8QEGB5GkceE
	 YoRUT/3nD28gvcMBuSneD8thhIwT5bpyDHkj7idgBbTb7QjRsGNV0ylhkkzU2JG4dtUbh
	 UKgIdXIKm7iZjRu/vHcY48zs6r8WJuKmkDxn8Xs224h6brF88u69u0oPG6ANKVcUtfAL2
	 UIF66AZ7PBAGBc1Vp/+4y/4Zsvp1d2ZVwTJc7lnMR9zQSNx1QvyB/11FI0qgGpPML8Ywt
	 53WmWVOa+3OJInNPeAqOwFrgxcu5S3MF9Ry9fDm0VLqtK50CUJGY2v/fpiaFjLDNjcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115584;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:In-Reply-To:
	 References:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=T/W9OWAIam6ohQLbDOGcli8HzxjYg6H1ggObwjHHOS4=;
	b=kqStk7LbbHCGUnXYfwLN/G/z2g8YtFdIJkWiTUF0598hUoI8bFsp7Xa1nKNuqEPy4t4z
	 OfFzeAcyvQdsTJynvz6h234NHUb1wxonjAFEYec6YxvindxypJGz9BwMtEKOOK+Gok16x
	 0CAuJCcN3FmWN5R/9JggqU8qhgkv9wy/WHAUfbqHi0wa3XfeteziRVlQ/DhfW2vqcLwXh
	 xTROiXpNs7MhbPRvUc+HU3rpoMs4QVJuIS8ndK/ahcX9CWakSez0gPxilATaAivQT5rqa
	 z3nX53KcuqjMz9uU43VEJaxyDCaZpTrTdZr+JWM378QEiANv000ChOXNkZexAmlJhMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=NOETzgR1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=csO+jncC;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616A606A323
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2616A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=NOETzgR1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=csO+jncC
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A30FEC041F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:39:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 11:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793115583;
	 x=1793201983; bh=T/W9OWAIam6ohQLbDOGcli8HzxjYg6H1ggObwjHHOS4=; b=
	NOETzgR17QqE4c5x/8vEf+LrxgrdFpw3Q1MjWq+KNTnxnyL+Gk2g+gCPLPor+C/E
	uFUv/pf0tJWn7NitqYTtR/1RH8S18StyH/V41CF2aKs5rtt0x4wofy32bLI9uAxZ
	FQ0pVddh8T9ctRiSgjKMqx89fp+aeB1OYFAdm5QVKpETVvs/Cc4teg4pmNyHYx3G
	IfOY3BudcgGVyybUWclVi7VDQwgSLQAIckvQSihSnjVQbcpJnbHClz9a6VaqT9vo
	AVKhQKTYSX7Cyv7XGLqP3E16PnVy5OeHrXuoMO+EWnD6u32Q8wP0uRYXP4OhU4JJ
	zkqRvLi7qaDO6tJHoVYTlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793115583; x=
	1793201983; bh=T/W9OWAIam6ohQLbDOGcli8HzxjYg6H1ggObwjHHOS4=; b=c
	sO+jncCT7N4fH7Esy3UNmaAOcEZR4bW+SHyj7A2Qwe225O5IWrYKlyah9gAQqAsZ
	ksMra8GCVZ7okkhqwkVl0B4X4OKFak3BMCLI9X7Z2BPH1OxlIHmG5PASHfmsrpCP
	kHyxFr+WLk4n6kj6jMdVeOWHdlOnFJrMu8zjqVy8WyKXDt2mbarnsGY4h8OKe9Ol
	4OxR2uHYn5n/1AlzqLut49yxB4BTdof91Dk2/R3MUbBTlsBgyWG8oRUFPiHMmuAq
	ytVt/2YTysVYSm1QnCYv0PnJCeRs7yhfSIOYqnDTJhvEuVYAXoEN9g3qd7uIVf1k
	C+Q/d7umreyFk75Ckg8rQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793115583; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:k8KqxgYXFaRS9Z2PbTx+gBPmETqv43GPsXyIB2r2Fc4vC9p
	pEjbkgWsws5WEr7bBUECASuaGYIoRtwTD+m4AtUS3lDoUrQiNbyHa0ZQ1ecw50LQ
	XC2Wl4en9D5c/tE3mJINfgW9RDdpUFwcj6xYuQn/0lgXUrf21Zs1J4kC+3PP2XtU
	ziIFc1CDA4b/CLhDZGPBD+UPbZ6relK0LSvNpb0EAU9lYmCrFS4aRubjG8qciBW2
	q0TSj2vL9Tok7CX0sjS2v17LQ0q0wJrfIzIJA2F+3uYP5vYJHAlCjT4mFIifd4iz
	uZZ+cyFGan+Z2Wr9tDPn6n1BqNYVnULBYSGQbTA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:srG74iS0EMczy4yr8ih7/JPCuQMjPVfzM3HXQqGVIPQ=:VppyO5I4K89ixtEVqPOuPFdcwBb9FXIuyDqr5GtHbjg=;
X-ME-Sender: <xms:v8XgalmyPUnbEcFmnVfQuMvUqb10gkfTi6YJp8X9b1lkZMtRdGIpKQ>
    <xme:v8Xgam2FIA5HHntE3XK0UJ5I4CrIzJKV_mRxTKYFJNDKyCX2IkaDJu643ZoicdUle
    mFB3rJpMa5Id5FEZKtYAh3LZPI5yhiweEi5-zROPynYN6YcYcC-X8mr>
X-ME-Received: <xmr:v8XgapSzffaS7Sco53mraxzDtQAsTG9QCoTZvw09cj-IDwIISHXzn1vpZDxA9y1XB54GQ4bmgznMT26G3B0EydY_>
X-ME-Proxy-Cause: dmFkZTEZfH5o7mONR3xEV+YGoKV3W+tQyK9RsyRqraMNqYv63RmSidm7ldeQ31E4oQaKAI
    JSjUWtSmCkaxd7BXIaeTDE3XCfPtBEZda0DVMxi1RiOOl73G9ZRHS9iStgmoVAYSxHIEAz
    O4vpG151xPBInzbbXcbWmtsq9Xp1JEB3eMOu/1ATen0451DEZ0tVNxh8KUYo6OJqrcotvV
    7VMatjn3e23wB+NUJoHfeNSMCuq6pbfi/wO7WoVlFW+BKm1g70LqobZAKRofsYo70oNp0v
    FUXLB9KzQkSuaM2IDMK6LGJeIZ2+FIG6k2qbigft8hwad4Fj+hGxug/G9SSl5t5ce3JlHR
    aVoFFaKtLNAEgPN7KdqFkAiARoCGQcL9srg3Y7iWFtTJHdqPWqY+K6anygJf4iO34nX3yv
    TxoxeNG5/MIq6Ckl9ojJl+wdFfwNKQgRR8NZKc9gRriX8DLiU6pShYwwMQiLUcZMt1fPhk
    JUTQTB17tRiEQy6VViQ5Cn0KmBTOVFgs8l6Omorj0g3bpxWqgJ3mZIaCJM717wqtrHog7y
    8ocgUm2BE7Id2o+v8RWJxW8Eg6N54EgwBTDb88KxW7ah7u/V37fYhnEGGbIIrMthlacyvq
    N7g0RUBdPStex2t12e2VgvZ07KIHNqB4Dm1e7YDZ67ZqduiyaCvSoXgZ8n3w
X-ME-Proxy: <xmx:v8Xgagu3Ju-kGJQPEHJJHyrwjNKnjxfp_nsbe3j7iyhqyhgHBl8BYA>
    <xmx:v8XgamZP2s2Hjb7KvY9LTnBfOwuu5pVoqlt2_TLYGHJ9hEOD8xjWig>
    <xmx:v8Xgattd6QwPupa52tb1Jv2TxRmljXn6VvfPCPrx6oWKA-ln6Px2tA>
    <xmx:v8XgagFrKHW4lemKdJsP7pSTborxQTJlIAkj3ublUP7U6va2Iivgdw>
    <xmx:v8Xgag_hv7YtYz-f2_5nrZikzuCVkSpnhMSEPLqCILrTXTQoGODRz0aA>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 11:39:42 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v3 0/2] repo: add degree-of-concern reporting to structure
Date: Tue, 27 Oct 2026 11:39:28 -0400
Message-Id: <20261027-b4-repo-structure-concern-v3-0-98d7a5704170@fastmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBQFr0K6tqb9QAOuvIdxAeVXaqQlbWk0h
 LtL0YVxwXKS92Zm4tFp9OSUzcRh1F5bs0J+yIjsG3NDqruVCTAQnPGatgV1OFrqg5tkmBxSaY1
 EZ6jinVAiB8Hqkqz/0aHSz819uX7YT+0dZUjCtOi1D9a9tnjkafftAN/pRE4ZxZxxVpYANciza
 nwYGv04SjuQlIrwKxN7Mkgy1qm8AKg6Wf3JlmV5A+GItvokAQAA
X-Change-ID: 20261019-b4-repo-structure-concern-f1d6f6326095
In-Reply-To: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
References: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8579;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=VppyO5I4K89ixtEVqPOuPFdcwBb9FXIuyDqr5GtHbjg=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIeHN3dJLqyWjt3X9nZnvAGdZ/uRZF9Kev2vjLUl256r
 ZmWLn+yo5SFQYyLQVZMkeX/P4HGVywPJPyC3n2CmcPKBDKEgYtTACbiY8nw3/O5VPCjh3PM/e4e
 lbVI7XDJS7VuLBDreC1ocbd6idgNa4afjPFPI49mHOdQrTv64OKjFSFLjy6qehn7s0W2bt3PIqV
 sLgA=
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE

"git repo structure" computes a set of statistics that are useful for
diagnosing performance issues in a git repository. But for a typical
user who hasn't encountered any issues yet, it can be difficult to
interpret the data - when should a value be considered concerning?

This patchset introduces a feature to "git repo structure" that reports
on how concerning certain measures of storage structure  are for a
repository.  In table mode, concern is displayed as a column containing
a number of stars indicating the degree of concern; in line or nul mode,
concerns are displayed as additionaL lines with a numeric value.

To select defaults for the thresholds where a value becomes concern,
a (hopefully) representative selection of repositories were analyzed.
Based on empirical exploration of the data, the measurement that seemed
closest to accurately assessing when a repository's structure becomes
concerning was based on the base 2 logarithm of the value. Across all of
the sample repositories, for all of the measurements, the point at which
things become problematic was when a base 2 logarithm of a value was
more than 1 standard deviation from the mean of the log_2 values in
the sample set.  Based on this, the concern threshold was set for each
of the measures.

While this seems like a reasonable approach for setting default
thresholds, it's obviously still very ad-hoc. It's likely that over
time, the default values will evolve; and in the short term, projects
may want to set their own thresholds. So this patchset includes support
for configuring the thresholds on a per-reposiry basis.

Overview of the change:

* The first commit adds the command-line option "--concern", and creates the basic implementation of concern reporting.
* The next commit adds configurability for the concern thresholds.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
Changes in v3:
- Merge the documentation commit backwards into the other two commits.
- Link to v2: https://patch.msgid.link/20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com

Changes in v2:
- Fix memory leak in concern string generation.
- Fix CI/CD test issue involving zlib versions.
- Updating the naming of the config value prefix.
- Link to v1: https://patch.msgid.link/20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com

---
Mark C. Chu-Carroll (2):
      repo: add level of concern reporting
      repo: make concern thresholds configurable

 Documentation/config/repo.adoc |  59 +++++++
 Documentation/git-repo.adoc    |  27 +++-
 builtin/repo.c                 | 343 ++++++++++++++++++++++++++++++++++++++---
 t/t1901-repo-structure.sh      | 137 ++++++++++++++++
 4 files changed, 543 insertions(+), 23 deletions(-)

Range-diff versus v2:

1:  b1ef56dd47 ! 1:  11c60f6d6d repo: add level of concern reporting
    @@ Commit message
         when a stat values has reached a point where it might be
         concerning, and indicate how severe the concern should be.
     
    + ## Documentation/git-repo.adoc ##
    +@@ Documentation/git-repo.adoc: SYNOPSIS
    + [synopsis]
    + git repo info [--format=(lines|nul) | -z] [--all | <key>...]
    + git repo info --keys [--format=(lines|nul) | -z]
    +-git repo structure [--format=(table|lines|nul) | -z]
    ++git repo structure [--format=(table|lines|nul) | -z] [--[no-]concern]
    + 
    + DESCRIPTION
    + -----------
    +@@ Documentation/git-repo.adoc: supported:
    + `nul`:::
    + 	Similar to `lines`, but using a _NUL_ character after each value.
    + 
    +-`structure [--format=(table|lines|nul) | -z]`::
    ++`structure [--format=(table|lines|nul) | -z] [--[no-]concern]`::
    + 	Retrieve statistics about the current repository structure. The
    + 	following kinds of information are reported:
    + +
    +@@ Documentation/git-repo.adoc: supported:
    + 	quoted.
    + +
    + `-z` is an alias for `--format=nul`.
    +++
    ++To make it easier to know when one of the values is something that
    ++users should be concerned about, adding '--concern' will provide a
    ++level of concern to be added to the output. In 'table' mode, this will
    ++be a table column indicating the level of concern as a number of stars;
    ++in `lines` or `nul` mode, a `concern_level` line will be added for each
    ++statistic with a numeric value.
    +++
    ++The level of concern for each statistic is computed using the log_2 of the
    ++statistic value. The value is considered concerning if it exceeds a heuristically
    ++chosen threshold value; the degree of concern is the difference between the
    ++log_2 of the value, and the log_2 of the corresponding threshold.
    + 
    + INFO KEYS
    + ---------
    +
      ## builtin/repo.c ##
     @@
      	"git repo info --keys [--format=(lines|nul) | -z]"
2:  446391b362 ! 2:  4eba5072b0 repo: make concern thresholds configurable
    @@ Commit message
         configure per-repo concern levels for "git repo structure"
         concern reporting.
     
    + ## Documentation/config/repo.adoc (new) ##
    +@@
    ++`repo.concern.commit-count`::
    ++	Sets the value of the concern threshold for commit count.
    ++
    ++`repo.concern.tree-count`::
    ++	Sets the value of the concern threshold for tree count.
    ++
    ++`repo.concern.blob-count`::
    ++	Sets the value of the concern threshold for blob count.
    ++
    ++`repo.concern.tag-count`::
    ++	Sets the value of the concern threshold for tag count.
    ++
    ++`repo.concern.commit-size`::
    ++	Sets the value of the concern threshold for total commit size.
    ++
    ++`repo.concern.tree-size`::
    ++	Sets the value of the concern threshold for total tree size.
    ++
    ++`repo.concern.blob-size`::
    ++	Sets the value of the concern threshold for total blob size.
    ++
    ++`repo.concern.tag-size`::
    ++	Sets the value of the concern threshold for total tag size.
    ++
    ++`repo.concern.commit-inflated-size`::
    ++	Sets the value of the concern threshold for total size
    ++	of all inflated commits.
    ++
    ++`repo.concern.tree-inflated-size`::
    ++	Sets the value of the concern threshold for total size of
    ++	all inflated trees.
    ++
    ++`repo.concern.blob-inflated-size`::
    ++	Sets the value of the concern threshold for total size of
    ++	all inflated blobs.
    ++
    ++`repo.concern.tag-inflated-size`::
    ++	Sets the value of the concern threshold for the total size
    ++	of all inflated tags.
    ++
    ++`repo.concern.commit-largest`::
    ++	Sets the value of the concern threshold the size of the largest
    ++	commit.
    ++
    ++`repo.concern.tree-largest`::
    ++	Sets the value of the concern threshold for the size of the
    ++	largest tree.
    ++
    ++`repo.concern.blob-largest`::
    ++	Sets the value of the concern threshold for the size of the
    ++	largest blob.
    ++
    ++`repo.concern.tag-largest`::
    ++	Sets the value of the concern threshold for the size of the
    ++	largest tag.
    ++
    ++All of the concern thresholds are integer values for the
    ++floor of the base-2 log of the threshold value. The default values
    ++of each threshold are set to heuristically determined values.
    +
    + ## Documentation/git-repo.adoc ##
    +@@ Documentation/git-repo.adoc: statistic value. The value is considered concerning if it exceeds a heuristicall
    + chosen threshold value; the degree of concern is the difference between the
    + log_2 of the value, and the log_2 of the corresponding threshold.
    + 
    ++The threshold values are configurable; see the configuration section below.
    ++
    + INFO KEYS
    + ---------
    + In order to obtain a set of values from `git repo info`, you should provide
    +@@ Documentation/git-repo.adoc: using the `nul` format:
    + git repo info --format=nul layout.bare layout.shallow
    + ------------
    + 
    ++CONFIGURATION
    ++-------------
    ++
    ++include::includes/cmd-config-section-all.adoc[]
    ++
    ++:git-repo: 1
    ++include::config/repo.adoc[]
    ++
    ++
    + SEE ALSO
    + --------
    + linkgit:git-rev-parse[1]
    +
      ## builtin/repo.c ##
     @@
      
3:  92f1fafbcd < -:  ---------- repo: add documentation for level-of-concern.

---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20261019-b4-repo-structure-concern-f1d6f6326095

