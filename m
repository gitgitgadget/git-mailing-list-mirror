Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296355;
	b=P59AIraFyo1aSZi3XqEju6QaXS5/c8stQe9T8rb2F07OhpqL43Eutd7m0hPk+OewX6yV
	 l3y16ah2XS5uSyXc8byou0aZTTrZuyxsm0ZgKyWOQNzRjkiNbKxnynAHsULyXqQBMiLIN
	 LvwbJkZ7o1UqJyF5Yh4dnqsHaPb/ET/4UG+ALuwZMqZLpVwkLN8rksTCmzpFXrwCya7G3
	 8XnqZH80PIDQEuZJkjMw5RbdXbBIs5Glqr0b7CMLRCfk2ZI6N3C3PvDQWXHcHSAvQVYdr
	 yVBOvLXDgIUnrbGz3p9ga3nBGeVCfv3oJL4QrEOYP5k4S8GSWvI3F+wH1V/PxJJchsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296355;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:In-Reply-To:
	 References:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rqegOE/ZQVLF7tIO9xzd1qrhYT23L9/5057AeZlU1GA=;
	b=Z0BZtnDwfJp0+mSHS5f6phfHGc+rtKu4KhjNtnO64AxSNQwSTTtjtWQQ7bhHfZtvlx1M
	 WG1zrdsDHJ18/zRbIpCVY7jZ3KbZjmwhjcfdg8PcvA/A949IEpCoZQU+osaWcfc2YW9mT
	 vLoKax7evR9QAgDHeJ1HFyPLzzcD2tTyEjYSGBkjuLWs20zGL0BfsDuP0qNnv28GgCmHq
	 c70gClg7r6LHmJ1s+tqKasUev0V9XAm6gIrHul72SxQ5YJ406PkLMW2esLVcsjTbXBuOb
	 qHhFYXuaGa2yQWfX4wRReMpLP2QPSyoHpCPxNigZc+I598hcapN0/3RKZh5znCJXEnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=jSS6hDeU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UpDr43Tr;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839F606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 17:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4839F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=jSS6hDeU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UpDr43Tr
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C6817A00FE
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:52:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 13:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793296353;
	 x=1793382753; bh=rqegOE/ZQVLF7tIO9xzd1qrhYT23L9/5057AeZlU1GA=; b=
	jSS6hDeUMXG9qjAUxeibzhzLq4kKMc9aCaBgNcxZWp1GGYOS8nNQhD1dCULjsRwv
	RqS6mh4/7d0yKrtde2t+rcLLZ8Rg77UZ4sHcLhCsz2tZqU0sT0kJbFTZQA/X/OkI
	+emJzSuU0r0HpS+RBMe4vFcGlwWVlagm75qXzA4yPAVdt/iTubxSdBpVxeEWqqnD
	KHsS3TmutilnWYFA5Jr28CBUKL/qtF+RSUjmU75FwDrO9yq+1HEM7xXGjEAsCyLE
	zszLKJsWHeoijytnfsje1Rr3cfz1+ktPVPwfnXb7k06WQ4a2w2vAUk3lGv4BUALS
	Vov3NaLvWW4hiG2iu72Q4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793296353; x=
	1793382753; bh=rqegOE/ZQVLF7tIO9xzd1qrhYT23L9/5057AeZlU1GA=; b=U
	pDr43Tr5AttcZjEjttjKcoalIyeXLx9StRYZ0wmK4IfOesjzz54Hr8hjs+A+AlGJ
	yiJV+6hPX54ZzgJqn4fx/V/OQdcL53kdPKb3bf+lp/glMDZLUI/IxjCsqzkrqtcG
	YJ8nQXAycTXQad8pBWOF71V4OdhzvpEbJXadWs1Imh/9Hm8YEu4NYWTmPdZu3XAD
	klVJIZeWE1NzpR8c/9OokgHKmhX2IIQg669Yw3nmQlp8UKzNygt6wn8wPxBok6+8
	1zPPItpwBdeN13a4SKNmIsRrphn5VDe+BlE3WIfAGeV86zzDKPJpM6I+YKrQBmvT
	+IT8j1Bs9RSCyP5W0YM8g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793296353; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:flsZrCfmR1mJLGPVs+sZ4V0Sk7Yb4zGUaEMcGgJz0ze3jdx
	rdMgrkqQSSF0Som679RLenWVXILjgjB4/CSDI0+Wjv0XvlKNwBxb0Fmw+WtnsK6K
	9kofQqLDY5K86FRvkAiKndEkCeDbD89KFQR9P/woKOQl4qfl3iYPWrYZXeEg16yw
	M0hXtE3WBSNLMoEo/wCXWJLMALTDKIriTOGrQmQJ+qcBSK93TNuLpjHw25+5ld76
	VnmVmWsMJk5NjKNuvpn3/NtFFXUpCNW/GpLhUtsmQ46ti9sc/b3A6ycAZNaYkAUy
	CjggCSq+Q1VtAuDXy3iNK8Nq5o4Dukr6j/vZ2tQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kQmaBGbFxvph1cNTgE1B6ELDbS6Q9Jcox57ZuqkKLH4=:Kpi0fQD8dUqNJIUYAgCcxHoBUWfJRTa0VrXF4sc83qk=;
X-ME-Sender: <xms:4YfjaoCk9JIGAHOK69Yg7WXQeQdF8SB-GYivr9xE2sLS4nSUdHuzSw>
    <xme:4YfjagiqiNyV9OKV7HzkAsYpE6z_AFNTgxnO7mNh2mLmdzuXg8qODla8azFdMNSx8
    0WrITSmghv0yAa_CQCiQJIaOpz-1L6mrTch-ZMiTdpKC_5gSNSLMqmk>
X-ME-Received: <xmr:4YfjapOLnJK4CL3d2t8rCd_4fUbrYLygSSipHdmsFO8LGfSNOHoFG_VIKf_nfALorWZEPMtRiUyr_ZrVNdJmHjJA8UjfWcHBcrG_thIe7C5JT5VbAv4wWKdFRznJ>
X-ME-Proxy-Cause: dmFkZTFs4VVMjdrS4lUHjIdmwmthYDIhQRNEFmtsB9WYXxnmcm2IfVqaGELrjEJc7OQZdL
    McOZmCUqvngb4T2hgGIUOCeFLy1VXc5XDwffHNBoDynRQlKf+0W0YhLDAfmY4RyvmsemSz
    2lfZV23XqVEj4PbwOh05bjs5W2MPU7mzO+mv/6LVMp/8fy9qtWKYIfO0gI2V5W2v8ZpJ2W
    EPHqzg+6GSEYKLzx/e9nh3eeVR+HwRRwuFgas8qKTvbymOwh59znb4YoDxt+WcqAvccbVh
    TnRU0+u1LbVh2xaa80ruzNNdomw2h4ElMf6vXNE36/U38NFZd1Y1KbQEAjafu1gGVYpeFl
    GOAdNo1TY7qOWNMaocd6ALB9JA/ZaUrtKLfODcMSS2SlPQo+64hqhBMXT+dh2UkKz+lZs9
    QaxkBFIRKwzqwchJ2P0Z1+Ex1/g+nQM3WDb/VnrUJGotejKiI1iLebbLbo9zs/pLM7KOrb
    tG2CQn+A/48aIAsAGfQqVNKqzLhXZhGywFzWhKudig+ILF+Id+hnfz/1MaT3DgceKl1ScY
    TrxiuMZt6DtEX5BNl4qJW/+PsWAh1Q3u6X/+ytA08aNUwWU5W1Z37+kQKO0Kv4SxTLio+T
    crzrJEFeeOVyLv7w9ylBbVfNwM64ZT/LJeenMrMn2gi/cmXmY7CRMwzL0uIg
X-ME-Proxy: <xmx:4Yfjap7Ia1_D3VUG1BddVZHQvtga4qej-ETb9njjwT06mmbJDg8gbA>
    <xmx:4Yfjav3ckFbAnMM6fETfKJe6dW_pnTKKP3ubcy5fiRqaF8y_9WY89A>
    <xmx:4YfjaiZRDb_V772X1QsZSfMDgzWyBHG8XbNIWj7cs6pUIR0MDmPOxg>
    <xmx:4YfjavBjMO6OwgJgohM_BddEs2M4z81AwjWWNQflxXRn9mkrD58UOw>
    <xmx:4Yfjarby9RogOc9r1dLXcZthIhYZgSWMqgK2ctVIy_3YO5QGrP2W6Ldi>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 13:52:33 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v4 0/2] repo: add degree-of-concern reporting to structure
Date: Thu, 29 Oct 2026 13:52:21 -0400
Message-Id: <20261029-b4-repo-structure-concern-v4-0-d813537ec617@fastmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ7CIBCF4asY1mKGoaWtK+9hXFQYFKPFAG00p
 ne3qAtjTJcvmfn+B4sUHEW2XjxYoMFF57tpFMsF08e2OxB3ZtoMAZUA0fB9wQNdPY8p9Dr1gbj
 2nabQcSuMskqigqZk0/81kHW3l73dvXfs9yfSKYP54uhi8uH+ig8i3306KGY6g+DASYKAskRsU
 G9sG9OldeeV9heWUwN+Y2oOw4yBsbJArI2u/2DyG6vmMDlhTW2qtqygEBX8YOM4PgG9xx6JcQE
 AAA==
X-Change-ID: 20261019-b4-repo-structure-concern-f1d6f6326095
In-Reply-To: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
References: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=56869;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=Kpi0fQD8dUqNJIUYAgCcxHoBUWfJRTa0VrXF4sc83qk=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIet9/L23lU3YLTfpd3/Qyvs0/eXvlXeG5Xnobx1IunL
 77ZeDjKsqOUhUGMi0FWTJHl/z+BxlcsDyT8gt59gpnDygQyhIGLUwAmcuMHw//4vf2ptstLN25e
 u+NL5IwV/C9XKjb8Stj0nzNDI+aQoeZFhr+idtuaxDedu5qzWGfG3nrdRaE68jfnC+cKJr1fxOv
 +1o0XAA==
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE

"git repo structure" computes a set of statistics that are useful for
diagnosing performance issues in a git repository. But for a typical
user who hasn't encountered any issues yet, it can be difficult to
interpret the data - when should a value be considered concerning?

This patchset introduces a feature to "git repo structure" that reports
on how concerning certain measures of storage structure  are for a
repository. In table mode, concern is displayed as a column containing
a number of stars indicating the degree of concern; in line or nul mode,
concerns are displayed as additional lines with a numeric value. This 
provides a functionality equivalent to the concern column provided 
by "git-sizer", although the implementation is different.

To select defaults for the thresholds where a value becomes concern,
a (hopefully) representative selection of repositories were analyzed.
Based on empirical exploration of the data, the measurement that seemed
closest to accurately assessing when a repository's structure becomes
concerning was based on the base 2 logarithm of the value. Across all of
the sample repositories, for all of the measurements, the point at which
things become concerning was when a base 2 logarithm of a statistic's
value was more than 1 standard deviation from the mean of the log_2
values of that stastistic in the sample set.  Based on this, the concern
threshold was set for each of the measures.

While this seems like a reasonable approach for setting default
thresholds, it's obviously still very ad-hoc. It's likely that over
time, the default values will evolve; and in any case, some projects
will want to set their own thresholds. To allow that, this includes
support for configuring the thresholds on a per-repository basis.

Overview of the change:
         
* The first commit adds the command-line option "--concern", and creates the basic implementation of concern reporting.
* The next commit adds configurability for the concern thresholds.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
Changes in v4:
- Reworked the history; the previous round had a history-rewrite error.
- Removed the duplication of configuration keys for the concern thresholds.
- Changed the prefix of the config keys.
- readability/quality of life naming changes.
- Link to v3: https://patch.msgid.link/20261027-b4-repo-structure-concern-v3-0-98d7a5704170@fastmail.com

Changes in v3:
- Merge the documentation commit backwards into the other two commits.
- Link to v2: https://patch.msgid.link/20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com

Changes in v2:
- Fix memory leak in concern string generation.
- Fix CI/CD test issue involving zlib versions.
- Updating the naming of the config value prefix.
- Link to v1: https://patch.msgid.link/20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com

To: git@vger.kernel.org

---
Mark C. Chu-Carroll (2):
      repo: add level of concern reporting
      repo: make concern thresholds configurable

 Documentation/config/repo.adoc |  59 ++++++
 Documentation/git-repo.adoc    |  27 ++-
 builtin/repo.c                 | 408 ++++++++++++++++++++++++++++++++++++++---
 repo.c                         |   1 +
 t/t1901-repo-structure.sh      | 137 ++++++++++++++
 5 files changed, 602 insertions(+), 30 deletions(-)

Range-diff versus v3:

1:  0f4e75e270 ! 1:  5f67be20e2 repo: add level of concern reporting
    @@ Commit message
         interpret the data - when should a value be considered
         concerning?
     
    -    Add an option to "git repo structure" that adds a "degree
    -    of concern" column to the structure report, which indicates
    -    when a stat values has reached a point where it might be
    -    concerning, and indicate how severe the concern should be.
    +    Add a new option to "git repo structure" which causes it
    +    to generate an additional column providing a level of concern
    +    for many values.
    +
    +    To select defaults for the thresholds where a value becomes concern,
    +    a (hopefully) representative selection of repositories were analyzed.
    +    Based on empirical exploration of the data, the measurement that seemed
    +    closest to accurately assessing when a repository's structure becomes
    +    concerning was based on the base 2 logarithm of the value. Across all of
    +    the sample repositories, for all of the measurements, the point at which
    +    things become problematic was when a base 2 logarithm of a value was
    +    more than 1 standard deviation from the mean of the log_2 values in
    +    the sample set.
    +
    +    Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
     
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: SYNOPSIS
    @@ Documentation/git-repo.adoc: supported:
     
      ## builtin/repo.c ##
     @@
    + #include "tree.h"
    + #include "tree-walk.h"
    + #include "utf8.h"
    ++#include "wrapper.h"
    + 
    + #define REPO_INFO_USAGE \
    + 	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]", \
      	"git repo info --keys [--format=(lines|nul) | -z]"
      
      #define REPO_STRUCTURE_USAGE \
    @@ builtin/repo.c: struct stats_table {
     +	size_t threshold;
     +};
     +
    -+enum concern_stat {
    -+	CONCERN_STAT_COMMIT_COUNT,
    -+	CONCERN_STAT_TREE_COUNT,
    -+	CONCERN_STAT_BLOB_COUNT,
    -+	CONCERN_STAT_TAG_COUNT,
    -+	CONCERN_STAT_COMMIT_SIZE,
    -+	CONCERN_STAT_TREE_SIZE,
    -+	CONCERN_STAT_BLOB_SIZE,
    -+	CONCERN_STAT_TAG_SIZE,
    -+	CONCERN_STAT_COMMIT_LARGEST,
    -+	CONCERN_STAT_TREE_LARGEST,
    -+	CONCERN_STAT_BLOB_LARGEST,
    -+	CONCERN_STAT_TAG_LARGEST,
    -+	CONCERN_STAT_COMMIT_INFLATED_SIZE,
    -+	CONCERN_STAT_TREE_INFLATED_SIZE,
    -+	CONCERN_STAT_BLOB_INFLATED_SIZE,
    -+	CONCERN_STAT_TAG_INFLATED_SIZE,
    -+};
    ++#define CONCERN_STAT_COMMIT_COUNT "commit-count"
    ++#define CONCERN_STAT_TREE_COUNT "tree-count"
    ++#define CONCERN_STAT_BLOB_COUNT "blob-count"
    ++#define CONCERN_STAT_TAG_COUNT "tag-count"
    ++#define CONCERN_STAT_COMMIT_SIZE "commit-size"
    ++#define CONCERN_STAT_TREE_SIZE "tree-size"
    ++#define CONCERN_STAT_BLOB_SIZE "blob-size"
    ++#define CONCERN_STAT_TAG_SIZE "tag-size"
    ++#define CONCERN_STAT_COMMIT_LARGEST "commit-largest"
    ++#define CONCERN_STAT_TREE_LARGEST "tree-largest"
    ++#define CONCERN_STAT_BLOB_LARGEST "blob-largest"
    ++#define CONCERN_STAT_TAG_LARGEST "tag-largest"
    ++#define CONCERN_STAT_COMMIT_INFLATED_SIZE "commit-inflated-size"
    ++#define CONCERN_STAT_TREE_INFLATED_SIZE "tree-inflated-size"
    ++#define CONCERN_STAT_BLOB_INFLATED_SIZE "blob-inflated-size"
    ++#define CONCERN_STAT_TAG_INFLATED_SIZE "tag-inflated-size"
     +
     +struct concern_stat_threshold repo_structure_concern_thresholds[] = {
    -+	{ .name = "commit_count", .threshold = 19 },
    -+	{.name = "tree_count", .threshold = 21 },
    -+	{ .name = "blob_count", .threshold = 22 },
    -+	{ .name = "tag_count", .threshold = 15 },
    -+	{ .name = "commit_size", .threshold = 28 },
    -+	{ .name = "tree_size", .threshold = 27 },
    -+	{ .name = "blob_size", .threshold = 36 },
    -+	{ .name = "tags_size", .threshold = 18 },
    -+	{ .name = "commit_largest", .threshold = 18  },
    -+	{ .name = "tree_largest", .threshold = 18 },
    -+	{ .name = "blob_largest", .threshold = 26 },
    -+	{ .name = "tag_largest", .threshold =  15 },
    -+	{ .name = "commit_inflated_size", .threshold = 28 },
    -+	{ .name = "tree_inflated_size", .threshold = 32 },
    -+	{ .name = "blob_inflated_size", .threshold = 34 },
    -+	{ .name = "tag_inflated_size", .threshold = 25}
    ++	{ .name = CONCERN_STAT_COMMIT_COUNT, .threshold = 19 },
    ++	{ .name = CONCERN_STAT_TREE_COUNT, .threshold = 21 },
    ++	{ .name = CONCERN_STAT_BLOB_COUNT, .threshold = 22 },
    ++	{ .name = CONCERN_STAT_TAG_COUNT, .threshold = 15 },
    ++	{ .name = CONCERN_STAT_COMMIT_SIZE, .threshold = 28 },
    ++	{ .name = CONCERN_STAT_TREE_SIZE, .threshold = 27 },
    ++	{ .name = CONCERN_STAT_BLOB_SIZE, .threshold = 36 },
    ++	{ .name = CONCERN_STAT_TAG_SIZE, .threshold = 18 },
    ++	{ .name = CONCERN_STAT_COMMIT_LARGEST, .threshold = 18  },
    ++	{ .name = CONCERN_STAT_TREE_LARGEST, .threshold = 18 },
    ++	{ .name = CONCERN_STAT_BLOB_LARGEST, .threshold = 26 },
    ++	{ .name = CONCERN_STAT_TAG_LARGEST, .threshold =  15 },
    ++	{ .name = CONCERN_STAT_COMMIT_INFLATED_SIZE, .threshold = 28 },
    ++	{ .name = CONCERN_STAT_TREE_INFLATED_SIZE, .threshold = 32 },
    ++	{ .name = CONCERN_STAT_BLOB_INFLATED_SIZE, .threshold = 34 },
    ++	{ .name = CONCERN_STAT_TAG_INFLATED_SIZE, .threshold = 25 },
    ++	{ 0 }
     +};
     +
    -+/*
    -+ * Concern thresholds aren't universal. We try to set reasonable default
    -+ * values, but projects may want to set these thresholds differently. To
    -+ * support that, they can set the thresholds for their project in the
    -+ * project's git config, in the section "repo.structure.concern".
    -+  */
    -+static int config_concern_thresholds(const char *prefixed_var,
    -+				     const char *str_val,
    -+				     const struct config_context *ctx,
    -+				     void *cb UNUSED) {
    -+	const char *config_prefix = "repo.structure.concern.";
    -+	if (!strncmp(config_prefix, prefixed_var, strlen(config_prefix))) {
    -+		const char *concern_name = &prefixed_var[strlen(config_prefix)];
    -+		for (int i = 0; concern_stat_thresholds[i].name != 0; i++) {
    -+			if (!strcmp(concern_stat_thresholds[i].name, concern_name)) {
    -+				int value = git_config_int(prefixed_var, str_val, ctx->kvi);
    -+				if (value < 0)
    -+					return -1;
    -+				concern_stat_thresholds[i].threshold = value;
    -+				return 0;
    -+			}
    ++static size_t get_concern_threshold(const char *name, struct concern_stat_threshold *thresholds) {
    ++	for (size_t i = 0; thresholds[i].name; i++) {
    ++		if (!strcmp(thresholds[i].name, name)) {
    ++			return thresholds[i].threshold;
     +		}
    -+		warning(_("Invalid concern threshold name: '%s'"), concern_name);
    -+		return 0;
     +	}
     +	return 0;
     +}
     +
    -+static size_t approx_log2(long value) {
    -+	int position = 0;
    -+	if (value <= 0) {
    -+		return 0;
    -+	}
    -+	while (value > 1) {
    -+		position++;
    -+		value >>= 1;
    -+	}
    -+	return position;
    -+}
    -+
    -+static size_t repo_structure_concern_level(enum concern_stat stat_id,
    -+					   size_t value) {
    ++static size_t repo_structure_concern_level(const char* concern_name,
    ++					   size_t value,
    ++					   struct concern_stat_threshold *thresholds) {
    ++	const size_t threshold = get_concern_threshold(concern_name, thresholds);
     +	size_t log_value;
    -+	if (stat_id >= ARRAY_SIZE(concern_stat_thresholds))
    -+		BUG("unexpected repository stat type");
    -+	log_value = approx_log2(value);
    -+	if (log_value > concern_stat_thresholds[stat_id].threshold)
    -+		return log_value -
    -+			concern_stat_thresholds[stat_id].threshold;
    ++	if (threshold == 0)
    ++		BUG("unexpected repository stat threshold: '%s'", concern_name);
    ++	log_value = log2u(value);
    ++	if (log_value > threshold)
    ++		return log_value - threshold;
     +	else
     +		return 0;
     +}
    @@ builtin/repo.c: static void stats_table_vaddf(struct stats_table *table,
      		int unit_width = utf8_strwidth(entry->unit);
      		if (unit_width > table->unit_col_width)
     @@ builtin/repo.c: static void stats_table_addf(struct stats_table *table, const char *format, ...)
    + 	va_end(ap);
      }
      
    ++// define a symbol for 'no concern value for this stat'; this will
    ++// make the code below easier to read.
    ++#define CONCERN_STAT_VALUE_NONE 0
    ++
      static void stats_table_count_addf(struct stats_table *table, size_t value,
     -				   const char *format, ...)
     +				   size_t concern, const char *format, ...)
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
     -	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
     -	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
     -	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
    -+	stats_table_count_addf(table, ref_total, 0,
    +-
    ++	stats_table_count_addf(table, ref_total, CONCERN_STAT_VALUE_NONE,
     +			       "  * %s", _("Count"));
    -+	stats_table_count_addf(table, refs->branches, 0,
    ++	stats_table_count_addf(table, refs->branches, CONCERN_STAT_VALUE_NONE,
     +			       "    * %s", _("Branches"));
     +	stats_table_count_addf(table, refs->tags,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TAG_COUNT,
    -+				       refs->tags),
    ++				       refs->tags,
    ++    			               repo_structure_concern_thresholds),
     +			       "    * %s", _("Tags"));
    -+	stats_table_count_addf(table, refs->remotes, 0,
    ++	stats_table_count_addf(table, refs->remotes, CONCERN_STAT_VALUE_NONE,
     +			       "    * %s", _("Remotes"));
    -+	stats_table_count_addf(table, refs->others, 0,
    ++	stats_table_count_addf(table, refs->others, CONCERN_STAT_VALUE_NONE,
     +			       "    * %s", _("Others"));
    - 
      	object_count_total = get_total_object_values(&objects->type_counts);
      	stats_table_addf(table, "");
      	stats_table_addf(table, "* %s", _("Reachable objects"));
     -	stats_table_count_addf(table, object_count_total, "  * %s", _("Count"));
    -+	stats_table_count_addf(table, object_count_total, 0,
    ++	stats_table_count_addf(table, object_count_total, CONCERN_STAT_VALUE_NONE,
     +			       "  * %s", _("Count"));
      	stats_table_count_addf(table, objects->type_counts.commits,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_COMMIT_COUNT,
    -+				       objects->type_counts.commits),
    ++				       objects->type_counts.commits,
    ++				       repo_structure_concern_thresholds),
      			       "    * %s", _("Commits"));
      	stats_table_count_addf(table, objects->type_counts.trees,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TREE_COUNT,
    -+				       objects->type_counts.trees),
    ++				       objects->type_counts.trees,
    ++				       repo_structure_concern_thresholds),
      			       "    * %s", _("Trees"));
      	stats_table_count_addf(table, objects->type_counts.blobs,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_BLOB_COUNT,
    -+				       objects->type_counts.blobs),
    ++				       objects->type_counts.blobs,
    ++				       repo_structure_concern_thresholds),
      			       "    * %s", _("Blobs"));
      	stats_table_count_addf(table, objects->type_counts.tags,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TAG_COUNT,
    -+				       objects->type_counts.tags),
    ++				       objects->type_counts.tags,
    ++				       repo_structure_concern_thresholds),
      			       "    * %s", _("Tags"));
      
      	inflated_object_total = get_total_object_values(&objects->inflated_sizes);
     -	stats_table_size_addf(table, inflated_object_total,
    -+	stats_table_size_addf(table, inflated_object_total, 0,
    ++	stats_table_size_addf(table, inflated_object_total, CONCERN_STAT_VALUE_NONE,
      			      "  * %s", _("Inflated size"));
      	stats_table_size_addf(table, objects->inflated_sizes.commits,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_COMMIT_INFLATED_SIZE,
    -+				      objects->inflated_sizes.commits),
    ++				      objects->inflated_sizes.commits,
    ++				      repo_structure_concern_thresholds),
      			      "    * %s", _("Commits"));
      	stats_table_size_addf(table, objects->inflated_sizes.trees,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_TREE_INFLATED_SIZE,
    -+				      objects->inflated_sizes.trees),
    ++				      objects->inflated_sizes.trees,
    ++				      repo_structure_concern_thresholds),
      			      "    * %s", _("Trees"));
      	stats_table_size_addf(table, objects->inflated_sizes.blobs,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_BLOB_INFLATED_SIZE,
    -+				      objects->inflated_sizes.blobs),
    ++				      objects->inflated_sizes.blobs,
    ++				      repo_structure_concern_thresholds),
      			      "    * %s", _("Blobs"));
      	stats_table_size_addf(table, objects->inflated_sizes.tags,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_TAG_INFLATED_SIZE,
    -+				      objects->inflated_sizes.tags),
    ++				      objects->inflated_sizes.tags,
    ++				      repo_structure_concern_thresholds),
      			      "    * %s", _("Tags"));
      
      	disk_object_total = get_total_object_values(&objects->disk_sizes);
     -	stats_table_size_addf(table, disk_object_total,
    -+	stats_table_size_addf(table, disk_object_total, 0,
    ++	stats_table_size_addf(table, disk_object_total, CONCERN_STAT_VALUE_NONE,
      			      "  * %s", _("Disk size"));
      	stats_table_size_addf(table, objects->disk_sizes.commits,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_COMMIT_SIZE,
    -+				      objects->disk_sizes.commits),
    ++				      objects->disk_sizes.commits,
    ++				      repo_structure_concern_thresholds),
      			      "    * %s", _("Commits"));
      	stats_table_size_addf(table, objects->disk_sizes.trees,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_TREE_SIZE,
    -+				      objects->disk_sizes.trees),
    ++				      objects->disk_sizes.trees,
    ++				      repo_structure_concern_thresholds),
      			      "    * %s", _("Trees"));
      	stats_table_size_addf(table, objects->disk_sizes.blobs,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_BLOB_SIZE,
    -+				      objects->disk_sizes.blobs),
    ++				      objects->disk_sizes.blobs,
    ++				      repo_structure_concern_thresholds),
      			      "    * %s", _("Blobs"));
      	stats_table_size_addf(table, objects->disk_sizes.tags,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_TAG_SIZE,
    -+				      objects->disk_sizes.tags),
    ++				      objects->disk_sizes.tags,
    ++				      repo_structure_concern_thresholds),
      			      "    * %s", _("Tags"));
      
      	stats_table_addf(table, "");
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      				     objects->largest.commit_size.value,
     +				     repo_structure_concern_level(
     +					     CONCERN_STAT_COMMIT_LARGEST,
    -+					     objects->largest.commit_size.value),
    ++					     objects->largest.commit_size.value,
    ++					     repo_structure_concern_thresholds),
      				     "    * %s", _("Maximum size"));
      	stats_table_object_count_addf(table,
      				      &objects->largest.parent_count.oid,
      				      objects->largest.parent_count.value,
    -+				      0,
    ++				      CONCERN_STAT_VALUE_NONE,
      				      "    * %s", _("Maximum parents"));
      	stats_table_addf(table, "  * %s", _("Trees"));
      	stats_table_object_size_addf(table,
      				     &objects->largest.tree_size.oid,
      				     objects->largest.tree_size.value,
    -+				      repo_structure_concern_level(
    -+					      CONCERN_STAT_TREE_LARGEST,
    -+					      objects->largest.tree_size.value),
    ++				     repo_structure_concern_level(
    ++					     CONCERN_STAT_TREE_LARGEST,
    ++					     objects->largest.commit_size.value,
    ++					     repo_structure_concern_thresholds),
      				     "    * %s", _("Maximum size"));
    ++
      	stats_table_object_count_addf(table,
    - 				      &objects->largest.tree_entries.oid,
    - 				      objects->largest.tree_entries.value,
    -+				      0,
    - 				      "    * %s", _("Maximum entries"));
    +-				      &objects->largest.tree_entries.oid,
    +-				      objects->largest.tree_entries.value,
    +-				      "    * %s", _("Maximum entries"));
    ++				     &objects->largest.tree_entries.oid,
    ++				     objects->largest.tree_entries.value,
    ++			             CONCERN_STAT_VALUE_NONE,
    ++				     "    * %s", _("Maximum entries"));
      	stats_table_addf(table, "  * %s", _("Blobs"));
      	stats_table_object_size_addf(table,
      				     &objects->largest.blob_size.oid,
      				     objects->largest.blob_size.value,
     +				     repo_structure_concern_level(
     +					     CONCERN_STAT_BLOB_LARGEST,
    -+					     objects->largest.blob_size.value),
    ++					     objects->largest.blob_size.value,
    ++					     repo_structure_concern_thresholds),
      				     "    * %s", _("Maximum size"));
      	stats_table_addf(table, "  * %s", _("Tags"));
      	stats_table_object_size_addf(table,
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      				     objects->largest.tag_size.value,
     +				     repo_structure_concern_level(
     +					     CONCERN_STAT_TAG_LARGEST,
    -+					     objects->largest.tag_size.value),
    ++					     objects->largest.tag_size.value,
    ++					     repo_structure_concern_thresholds),
      				     "    * %s", _("Maximum size"));
      }
      
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
      		       stats->objects.type_counts.commits, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.commits.count.concern_level", key_delim,
    -+			      repo_structure_concern_level(CONCERN_STAT_COMMIT_COUNT,
    -+							   stats->objects.type_counts.commits),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_COMMIT_COUNT,
    ++				       stats->objects.type_counts.commits,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
      	print_keyvalue("objects.trees.count", key_delim,
      		       stats->objects.type_counts.trees, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.trees.count.concern_level", key_delim,
    -+			      repo_structure_concern_level(CONCERN_STAT_TREE_COUNT,
    -+							   stats->objects.type_counts.trees),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_TREE_COUNT,
    ++				       stats->objects.type_counts.trees,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
      	print_keyvalue("objects.blobs.count", key_delim,
      		       stats->objects.type_counts.blobs, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.blobs.count.concern_level", key_delim,
    -+			      repo_structure_concern_level(CONCERN_STAT_BLOB_COUNT,
    -+							   stats->objects.type_counts.blobs),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_BLOB_COUNT,
    ++				       stats->objects.type_counts.blobs,
    ++				       repo_structure_concern_thresholds),
    ++		 value_delim);
      	print_keyvalue("objects.tags.count", key_delim,
    - 		       stats->objects.type_counts.tags, value_delim);
    +-		       stats->objects.type_counts.tags, value_delim);
    ++		stats->objects.type_counts.tags, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.tags.count.concern_level", key_delim,
    -+			      repo_structure_concern_level(CONCERN_STAT_TAG_COUNT,
    -+							   stats->objects.type_counts.tags),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_TAG_COUNT,
    ++				       stats->objects.type_counts.tags,
    ++				       repo_structure_concern_thresholds),
    ++		 	       value_delim);
      
      	print_keyvalue("objects.commits.inflated_size", key_delim,
    - 		       stats->objects.inflated_sizes.commits, value_delim);
    +-		       stats->objects.inflated_sizes.commits, value_delim);
    ++		stats->objects.inflated_sizes.commits, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.commits.inflated_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_COMMIT_INFLATED_SIZE,
    -+							    stats->objects.inflated_sizes.commits),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_COMMIT_INFLATED_SIZE,
    ++				       stats->objects.inflated_sizes.commits,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
      	print_keyvalue("objects.trees.inflated_size", key_delim,
    - 		       stats->objects.inflated_sizes.trees, value_delim);
    +-		       stats->objects.inflated_sizes.trees, value_delim);
    ++		stats->objects.inflated_sizes.trees, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.trees.inflated_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_TREE_INFLATED_SIZE,
    -+							    stats->objects.inflated_sizes.trees),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_TREE_INFLATED_SIZE,
    ++				       stats->objects.inflated_sizes.trees,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
     +
      	print_keyvalue("objects.blobs.inflated_size", key_delim,
      		       stats->objects.inflated_sizes.blobs, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.blobs.inflated_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_BLOB_INFLATED_SIZE,
    -+							    stats->objects.inflated_sizes.blobs),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_BLOB_INFLATED_SIZE,
    ++				       stats->objects.inflated_sizes.blobs,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
      	print_keyvalue("objects.tags.inflated_size", key_delim,
      		       stats->objects.inflated_sizes.tags, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.tags.inflated_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_TAG_INFLATED_SIZE,
    -+							    stats->objects.inflated_sizes.tags),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_TAG_INFLATED_SIZE,
    ++				       stats->objects.inflated_sizes.tags,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
      
      	print_keyvalue("objects.commits.disk_size", key_delim,
      		       stats->objects.disk_sizes.commits, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.commits.disk_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_COMMIT_SIZE,
    -+							    stats->objects.disk_sizes.commits),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_COMMIT_SIZE,
    ++				       stats->objects.disk_sizes.commits,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
      	print_keyvalue("objects.trees.disk_size", key_delim,
      		       stats->objects.disk_sizes.trees, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.trees.disk_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_TREE_SIZE,
    -+							    stats->objects.disk_sizes.trees),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_TREE_SIZE,
    ++				       stats->objects.disk_sizes.trees,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
      	print_keyvalue("objects.blobs.disk_size", key_delim,
      		       stats->objects.disk_sizes.blobs, value_delim);
     +	if (show_concern)
    -+		print_keyvalue("objects.blobs.blob_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_BLOB_SIZE,
    -+							    stats->objects.disk_sizes.blobs),
    ++
    ++		print_keyvalue("objects.blobs.disk_size.concern_level", key_delim,
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_BLOB_SIZE,
    ++				       stats->objects.disk_sizes.blobs,
    ++				       repo_structure_concern_thresholds),
     +			      value_delim);
      	print_keyvalue("objects.tags.disk_size", key_delim,
      		       stats->objects.disk_sizes.tags, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.tags.disk_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_TAG_SIZE,
    -+							    stats->objects.disk_sizes.tags),
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_TAG_SIZE,
    ++				       stats->objects.disk_sizes.tags,
    ++				       repo_structure_concern_thresholds),
     +			      value_delim);
      
      	print_object_data("objects.commits.max_size", key_delim,
      			  &stats->objects.largest.commit_size, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.commits.max_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_COMMIT_LARGEST,
    -+							    stats->objects.largest.commit_size.value),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_COMMIT_LARGEST,
    ++				       stats->objects.largest.commit_size.value,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
      	print_object_data("objects.trees.max_size", key_delim,
      			  &stats->objects.largest.tree_size, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.trees.max_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_TREE_LARGEST,
    -+							    stats->objects.largest.tree_size.value),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_TREE_LARGEST,
    ++				       stats->objects.largest.tree_size.value,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
      	print_object_data("objects.blobs.max_size", key_delim,
      			  &stats->objects.largest.blob_size, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.blobs.max_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_BLOB_LARGEST,
    -+							    stats->objects.largest.blob_size.value),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_BLOB_LARGEST,
    ++				       stats->objects.largest.blob_size.value,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
      	print_object_data("objects.tags.max_size", key_delim,
    - 			  &stats->objects.largest.tag_size, value_delim);
    +-			  &stats->objects.largest.tag_size, value_delim);
    ++		          &stats->objects.largest.tag_size, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.tags.max_size.concern_level", key_delim,
    -+			       repo_structure_concern_level(CONCERN_STAT_TAG_LARGEST,
    -+							    stats->objects.largest.tag_size.value),
    -+			      value_delim);
    ++			       repo_structure_concern_level(
    ++				       CONCERN_STAT_TAG_LARGEST,
    ++				       stats->objects.largest.tag_size.value,
    ++				       repo_structure_concern_thresholds),
    ++			       value_delim);
      
      	print_object_data("objects.commits.max_parents", key_delim,
      			  &stats->objects.largest.parent_count, value_delim);
    @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const
      		OPT_END()
      	};
      
    + 	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
    + 	if (argc)
    + 		usage(_("too many arguments"));
    +-
    + 	repo_init_revisions(repo, &revs, prefix);
    + 
    + 	if (show_progress < 0)
     @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
      	switch (format) {
      	case FORMAT_TABLE:
    @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const
      	default:
      		BUG("invalid output format");
     
    - ## sideband.c ##
    + ## repo.c (new) ##
     @@
    --#define USE_THE_REPOSITORY_VARIABLE
    -+define USE_THE_REPOSITORY_VARIABLE
    - #define DISABLE_SIGN_COMPARE_WARNINGS
    - 
    - #include "git-compat-util.h"
    ++#include "repo.h"
     
      ## t/t1901-repo-structure.sh ##
     @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
      		EOF
      
      		git repo structure >out 2>err &&
    --
    --		test_cmp expect out &&
    --		test_line_count = 0 err
    --	)
    --'
    --
    --test_expect_success SHA1 'repository with references and objects' '
    --	test_when_finished "rm -rf repo" &&
    --	git init repo &&
    --	(
    --		cd repo &&
    --		test_commit_bulk 1005 &&
    --		git tag -a foo -m bar &&
    --
    --		oid="$(git rev-parse HEAD)" &&
    --		git update-ref refs/remotes/origin/foo "$oid" &&
    --
    --		# Also creates a commit, tree, and blob.
    --		git notes add -m foo &&
    --
    --		# The tags disk size is handled specially due to the
    --		# git-rev-list(1) --disk-usage=human option printing the full
    --		# "byte/bytes" unit string instead of just "B".
    --		cat >expect <<-EOF &&
    --		| Repository structure      | Value      |
    --		| ------------------------- | ---------- |
    --		| * References              |            |
    --		|   * Count                 |      4     |
    --		|     * Branches            |      1     |
    --		|     * Tags                |      1     |
    --		|     * Remotes             |      1     |
    --		|     * Others              |      1     |
    --		|                           |            |
    --		| * Reachable objects       |            |
    --		|   * Count                 |   3.02 k   |
    --		|     * Commits             |   1.01 k   |
    --		|     * Trees               |   1.01 k   |
    --		|     * Blobs               |   1.01 k   |
    --		|     * Tags                |      1     |
    --		|   * Inflated size         |  16.03 MiB |
    --		|     * Commits             | 217.92 KiB |
    --		|     * Trees               |  15.81 MiB |
    --		|     * Blobs               |  11.68 KiB |
    --		|     * Tags                |    132 B   |
    --		|   * Disk size             | $(object_type_disk_usage all true) |
    --		|     * Commits             | $(object_type_disk_usage commit true) |
    --		|     * Trees               | $(object_type_disk_usage tree true) |
    --		|     * Blobs               |  $(object_type_disk_usage blob true) |
    --		|     * Tags                |    $(object_type_disk_usage tag) B   |
    --		|                           |            |
    --		| * Largest objects         |            |
    --		|   * Commits               |            |
    --		|     * Maximum size    [1] |    223 B   |
    --		|     * Maximum parents [2] |      1     |
    --		|   * Trees                 |            |
    --		|     * Maximum size    [3] |  32.29 KiB |
    --		|     * Maximum entries [4] |   1.01 k   |
    --		|   * Blobs                 |            |
    --		|     * Maximum size    [5] |     13 B   |
    --		|   * Tags                  |            |
    --		|     * Maximum size    [6] |    132 B   |
    --
    --		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
    --		[2] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
    --		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
    --		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
    --		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
    --		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
    --		EOF
    --
    --		git repo structure >out 2>err &&
     +		cp out /tmp/test1-out &&
      
      		test_cmp expect out &&
      		test_line_count = 0 err
    -@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines and nul format' '
    - 	)
    - '
    - 
    -+test_expect_success SHA1 'lines format with concerns' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+		# configure thresholds to get concern indications
    -+		git config repo.structure.concern.commit-count 7 &&
    -+		git config repo.structure.concern.commit-size 14 &&
    -+		git config repo.structure.concern.tree-size 10 &&
    -+		git config repo.structure.concern.blob-size 8 &&
    -+		git config repo.structure.concern.blob-inflated-size 10 &&
    -+		git config repo.structure.concern.tag-size 2 &&
    -+		git config repo.structure.concern.commit-largest 4 &&
    -+		git config repo.structure.concern.blob-largest 2 &&
    -+		touch configured &&
    -+		test_commit_bulk 1005 &&
    -+		git tag -a foo -m bar &&
    -+		oid="$(git rev-parse HEAD)" &&
    -+		git update-ref refs/remotes/origin/foo "$oid" &&
    -+
    -+		# Also creates a commit, tree, and blob.
    -+		git notes add -m foo &&
    -+
    -+
    -+		# The tags disk size is handled specially due to the
    -+		# git-rev-list(1) --disk-usage=human option printing the full
    -+		# "byte/bytes" unit string instead of just "B".
    -+		cat >expect <<-EOF &&
    -+		objects.commits.count.concern_level=2
    -+		objects.trees.count.concern_level=0
    -+		objects.blobs.count.concern_level=0
    -+		objects.tags.count.concern_level=0
    -+		objects.commits.inflated_size.concern_level=0
    -+		objects.trees.inflated_size.concern_level=0
    -+		objects.blobs.inflated_size.concern_level=3
    -+		objects.tags.inflated_size.concern_level=0
    -+		objects.commits.disk_size.concern_level=3
    -+		objects.trees.disk_size.concern_level=8
    -+		objects.blobs.blob_size.concern_level=6
    -+		objects.tags.disk_size.concern_level=4
    -+		objects.commits.max_size.concern_level=3
    -+		objects.trees.max_size.concern_level=0
    -+		objects.blobs.max_size.concern_level=1
    -+		objects.tags.max_size.concern_level=0
    -+		EOF
    -+
    -+		git repo structure --concern --format=lines >actual 2>err &&
    -+		test_grep "concern_level" actual >actual-concerns &&
    -+		test_cmp expect actual-concerns &&
    -+		test_line_count = 0 err
    -+	)
    -+'
    -+
    - test_expect_success 'progress meter option' '
    - 	test_when_finished "rm -rf repo" &&
    - 	git init repo &&
2:  56fb5590ea ! 2:  f0e25fae09 repo: make concern thresholds configurable
    @@ Commit message
         configure per-repo concern levels for "git repo structure"
         concern reporting.
     
    +    Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
    +
      ## Documentation/config/repo.adoc (new) ##
     @@
     +`repo.concern.commit-count`::
    @@ builtin/repo.c
      static const char *const repo_usage[] = {
      	REPO_INFO_USAGE,
      	REPO_STRUCTURE_USAGE,
    -@@ builtin/repo.c: enum concern_stat {
    - 	CONCERN_STAT_TREE_INFLATED_SIZE,
    - 	CONCERN_STAT_BLOB_INFLATED_SIZE,
    - 	CONCERN_STAT_TAG_INFLATED_SIZE,
    -+	CONCERN_STAT_MAXIMUM
    - };
    - 
    --struct concern_stat_threshold repo_structure_concern_thresholds[] = {
    --	{ .name = "commit_count", .threshold = 19 },
    --	{.name = "tree_count", .threshold = 21 },
    --	{ .name = "blob_count", .threshold = 22 },
    --	{ .name = "tag_count", .threshold = 15 },
    --	{ .name = "commit_size", .threshold = 28 },
    --	{ .name = "tree_size", .threshold = 27 },
    --	{ .name = "blob_size", .threshold = 36 },
    --	{ .name = "tags_size", .threshold = 18 },
    --	{ .name = "commit_largest", .threshold = 18  },
    --	{ .name = "tree_largest", .threshold = 18 },
    --	{ .name = "blob_largest", .threshold = 26 },
    --	{ .name = "tag_largest", .threshold =  15 },
    --	{ .name = "commit_inflated_size", .threshold = 28 },
    --	{ .name = "tree_inflated_size", .threshold = 32 },
    --	{ .name = "blob_inflated_size", .threshold = 34 },
    --	{ .name = "tag_inflated_size", .threshold = 25}
    -+struct concern_stat_threshold concern_stat_thresholds[] = {
    -+	{ .name = "commit-count", .threshold = 19 },
    -+	{ .name = "tree-count", .threshold = 21 },
    -+	{ .name = "blob-count", .threshold = 22 },
    -+	{ .name = "tag-count", .threshold = 15 },
    -+	{ .name = "commit-size", .threshold = 28 },
    -+	{ .name = "tree-size", .threshold = 27 },
    -+	{ .name = "blob-size", .threshold = 36 },
    -+	{ .name = "tag-size", .threshold = 18 },
    -+	{ .name = "commit-largest", .threshold = 18  },
    -+	{ .name = "tree-largest", .threshold = 18 },
    -+	{ .name = "blob-largest", .threshold = 26 },
    -+	{ .name = "tag-largest", .threshold =  15 },
    -+	{ .name = "commit-inflated-size", .threshold = 28 },
    -+	{ .name = "tree-inflated-size", .threshold = 32 },
    -+	{ .name = "blob-inflated-size", .threshold = 34 },
    -+	{ .name = "tag-inflated-size", .threshold = 25},
    -+	{ 0 }
    - };
    - 
    - /*
    -  * Concern thresholds aren't universal. We try to set reasonable default
    -  * values, but projects may want to set these thresholds differently. To
    -  * support that, they can set the thresholds for their project in the
    -- * project's git config, in the section "repo.structure.concern".
    -+ * project's git config, in the section "repo.concern".
    -   */
    - static int config_concern_thresholds(const char *prefixed_var,
    - 				     const char *str_val,
    - 				     const struct config_context *ctx,
    - 				     void *cb UNUSED) {
    --	const char *config_prefix = "repo.structure.concern.";
    --	if (!strncmp(config_prefix, prefixed_var, strlen(config_prefix))) {
    --		const char *concern_name = &prefixed_var[strlen(config_prefix)];
    -+	if (!strncmp(REPO_STRUCTURE_CONFIG_PREFIX, prefixed_var,
    -+	      strlen(REPO_STRUCTURE_CONFIG_PREFIX))) {
    -+		const char *concern_name =
    -+			&prefixed_var[strlen(REPO_STRUCTURE_CONFIG_PREFIX)];
    - 		for (int i = 0; concern_stat_thresholds[i].name != 0; i++) {
    - 			if (!strcmp(concern_stat_thresholds[i].name, concern_name)) {
    - 				int value = git_config_int(prefixed_var, str_val, ctx->kvi);
    -@@ builtin/repo.c: static int config_concern_thresholds(const char *prefixed_var,
    - 	return 0;
    +@@ builtin/repo.c: static size_t repo_structure_concern_level(const char* concern_name,
    + 		return 0;
      }
      
    --static size_t approx_log2(long value) {
    -+static size_t approx_log2(size_t value) {
    - 	int position = 0;
    - 	if (value <= 0) {
    - 		return 0;
    -@@ builtin/repo.c: static size_t approx_log2(long value) {
    - static size_t repo_structure_concern_level(enum concern_stat stat_id,
    - 					   size_t value) {
    - 	size_t log_value;
    --	if (stat_id >= ARRAY_SIZE(concern_stat_thresholds))
    -+	if (stat_id >= CONCERN_STAT_MAXIMUM)
    - 		BUG("unexpected repository stat type");
    - 	log_value = approx_log2(value);
    - 	if (log_value > concern_stat_thresholds[stat_id].threshold)
    ++/*
    ++ * Concern thresholds aren't universal. We try to set reasonable default
    ++ * values, but projects may want to set these thresholds differently. To
    ++ * support that, they can set the thresholds for their project in the
    ++ * project's git config, in the section "repo.structure.concern".
    ++  */
    ++static int config_concern_thresholds(const char *prefixed_var,
    ++				     const char *str_val,
    ++				     const struct config_context *ctx,
    ++				     void *cb)
    ++{
    ++	struct concern_stat_threshold *thresholds = cb;
    ++	if (starts_with(prefixed_var, REPO_STRUCTURE_CONFIG_PREFIX)) {
    ++		const char *concern_name = &prefixed_var[strlen(REPO_STRUCTURE_CONFIG_PREFIX)];
    ++		for (int i = 0; thresholds[i].name; i++) {
    ++			if (!strcmp(thresholds[i].name, concern_name)) {
    ++				int value = git_config_int(prefixed_var, str_val, ctx->kvi);
    ++				if (value < 0)
    ++					return -1;
    ++				thresholds[i].threshold = value;
    ++				return 0;
    ++			}
    ++		}
    ++		warning(_("Invalid concern threshold name: '%s'"), concern_name);
    ++		return 0;
    ++	}
    ++	return 0;
    ++}
    ++
    + /*
    +  * Holds column data that gets stored for each row.
    +  */
     @@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table *table,
      			strbuf_utf8_align(&buf, ALIGN_LEFT, concern_col_width, concern_str.buf);
      			strbuf_addstr(&buf, " |");
    @@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table
      	}
      
     @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    - 	print_keyvalue("objects.blobs.disk_size", key_delim,
    - 		       stats->objects.disk_sizes.blobs, value_delim);
    - 	if (show_concern)
    --		print_keyvalue("objects.blobs.blob_size.concern_level", key_delim,
    -+		print_keyvalue("objects.blobs.disk_size.concern_level", key_delim,
    - 			       repo_structure_concern_level(CONCERN_STAT_BLOB_SIZE,
    - 							    stats->objects.disk_sizes.blobs),
    - 			      value_delim);
    -@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    - 							    stats->objects.largest.commit_size.value),
    - 			      value_delim);
    - 	print_object_data("objects.trees.max_size", key_delim,
    --			  &stats->objects.largest.tree_size, value_delim);
    -+			 &stats->objects.largest.tree_size, value_delim);
    - 	if (show_concern)
    - 		print_keyvalue("objects.trees.max_size.concern_level", key_delim,
    - 			       repo_structure_concern_level(CONCERN_STAT_TREE_LARGEST,
    -@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    - 							    stats->objects.largest.blob_size.value),
    - 			      value_delim);
    - 	print_object_data("objects.tags.max_size", key_delim,
    --			  &stats->objects.largest.tag_size, value_delim);
    -+			   &stats->objects.largest.tag_size, value_delim);
    - 	if (show_concern)
    - 		print_keyvalue("objects.tags.max_size.concern_level", key_delim,
    - 			       repo_structure_concern_level(CONCERN_STAT_TAG_LARGEST,
    + 				       stats->objects.largest.tag_size.value,
    + 				       repo_structure_concern_thresholds),
    + 			       value_delim);
    +-
    + 	print_object_data("objects.commits.max_parents", key_delim,
    + 			  &stats->objects.largest.parent_count, value_delim);
    + 	print_object_data("objects.trees.max_entries", key_delim,
     @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    - 	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
    - 	if (argc)
      		usage(_("too many arguments"));
    --
    -+	if (show_concern)
    -+		repo_config(repo, &config_concern_thresholds, NULL);
      	repo_init_revisions(repo, &revs, prefix);
      
    ++	if (show_concern)
    ++                repo_config(repo, &config_concern_thresholds, &repo_structure_concern_thresholds);
    ++
    ++
      	if (show_progress < 0)
    -
    - ## sideband.c ##
    -@@
    --define USE_THE_REPOSITORY_VARIABLE
    -+#define USE_THE_REPOSITORY_VARIABLE
    - #define DISABLE_SIGN_COMPARE_WARNINGS
    + 		show_progress = isatty(2);
      
    - #include "git-compat-util.h"
     
      ## t/t1901-repo-structure.sh ##
     @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
    @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
      
      		test_cmp expect out &&
      		test_line_count = 0 err
    +@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'repository with references and objects' '
      	)
      '
      
    -+test_expect_success SHA1 'repository with references and objects' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+		test_commit_bulk 1005 &&
    -+		git tag -a foo -m bar &&
    -+
    -+		oid="$(git rev-parse HEAD)" &&
    -+		git update-ref refs/remotes/origin/foo "$oid" &&
    -+
    -+		# Also creates a commit, tree, and blob.
    -+		git notes add -m foo &&
    -+
    -+		# The tags disk size is handled specially due to the
    -+		# git-rev-list(1) --disk-usage=human option printing the full
    -+		# "byte/bytes" unit string instead of just "B".
    -+		cat >expect <<-EOF &&
    -+		| Repository structure      | Value      |
    -+		| ------------------------- | ---------- |
    -+		| * References              |            |
    -+		|   * Count                 |      4     |
    -+		|     * Branches            |      1     |
    -+		|     * Tags                |      1     |
    -+		|     * Remotes             |      1     |
    -+		|     * Others              |      1     |
    -+		|                           |            |
    -+		| * Reachable objects       |            |
    -+		|   * Count                 |   3.02 k   |
    -+		|     * Commits             |   1.01 k   |
    -+		|     * Trees               |   1.01 k   |
    -+		|     * Blobs               |   1.01 k   |
    -+		|     * Tags                |      1     |
    -+		|   * Inflated size         |  16.03 MiB |
    -+		|     * Commits             | 217.92 KiB |
    -+		|     * Trees               |  15.81 MiB |
    -+		|     * Blobs               |  11.68 KiB |
    -+		|     * Tags                |    132 B   |
    -+		|   * Disk size             | $(object_type_disk_usage all true) |
    -+		|     * Commits             | $(object_type_disk_usage commit true) |
    -+		|     * Trees               | $(object_type_disk_usage tree true) |
    -+		|     * Blobs               |  $(object_type_disk_usage blob true) |
    -+		|     * Tags                |    $(object_type_disk_usage tag) B   |
    -+		|                           |            |
    -+		| * Largest objects         |            |
    -+		|   * Commits               |            |
    -+		|     * Maximum size    [1] |    223 B   |
    -+		|     * Maximum parents [2] |      1     |
    -+		|   * Trees                 |            |
    -+		|     * Maximum size    [3] |  32.29 KiB |
    -+		|     * Maximum entries [4] |   1.01 k   |
    -+		|   * Blobs                 |            |
    -+		|     * Maximum size    [5] |     13 B   |
    -+		|   * Tags                  |            |
    -+		|     * Maximum size    [6] |    132 B   |
    -+
    -+		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
    -+		[2] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
    -+		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
    -+		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
    -+		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
    -+		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
    -+		EOF
    -+
    -+		git repo structure >out 2>err &&
    -+
    -+		test_cmp expect out &&
    -+		test_line_count = 0 err
    -+	)
    -+'
    -+
     +test_expect_success SHA1 'concern flagging' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
      test_expect_success SHA1 'lines and nul format' '
      	test_when_finished "rm -rf repo" &&
      	git init repo &&
    -@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines format with concerns' '
    - 	git init repo &&
    - 	(
    - 		cd repo &&
    -+		# differences between zlib and zlib-ng can cause this
    -+		# test to fail; so we just turn it off.
    +@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines and nul format' '
    + 	)
    + '
    + 
    ++test_expect_success SHA1 'lines format with concerns' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		# configure thresholds to get concern indications
     +		git config core.compression 0 &&
    - 		# configure thresholds to get concern indications
    --		git config repo.structure.concern.commit-count 7 &&
    --		git config repo.structure.concern.commit-size 14 &&
    --		git config repo.structure.concern.tree-size 10 &&
    --		git config repo.structure.concern.blob-size 8 &&
    --		git config repo.structure.concern.blob-inflated-size 10 &&
    --		git config repo.structure.concern.tag-size 2 &&
    --		git config repo.structure.concern.commit-largest 4 &&
    --		git config repo.structure.concern.blob-largest 2 &&
    --		touch configured &&
     +		git config repo.concern.commit-count 7 &&
     +		git config repo.concern.commit-size 14 &&
     +		git config repo.concern.tree-size 10 &&
    @@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines format with concerns'
     +		git config repo.concern.tag-size 2 &&
     +		git config repo.concern.commit-largest 4 &&
     +		git config repo.concern.blob-largest 2 &&
    - 		test_commit_bulk 1005 &&
    - 		git tag -a foo -m bar &&
    - 		oid="$(git rev-parse HEAD)" &&
    -@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines format with concerns' '
    - 		# Also creates a commit, tree, and blob.
    - 		git notes add -m foo &&
    - 
    --
    - 		# The tags disk size is handled specially due to the
    - 		# git-rev-list(1) --disk-usage=human option printing the full
    - 		# "byte/bytes" unit string instead of just "B".
    -@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines format with concerns' '
    - 		objects.tags.inflated_size.concern_level=0
    - 		objects.commits.disk_size.concern_level=3
    - 		objects.trees.disk_size.concern_level=8
    --		objects.blobs.blob_size.concern_level=6
    --		objects.tags.disk_size.concern_level=4
    ++		touch configured &&
    ++		test_commit_bulk 1005 &&
    ++		git tag -a foo -m bar &&
    ++		oid="$(git rev-parse HEAD)" &&
    ++		git update-ref refs/remotes/origin/foo "$oid" &&
    ++
    ++		# Also creates a commit, tree, and blob.
    ++		git notes add -m foo &&
    ++
    ++
    ++		# The tags disk size is handled specially due to the
    ++		# git-rev-list(1) --disk-usage=human option printing the full
    ++		# "byte/bytes" unit string instead of just "B".
    ++		cat >expect <<-EOF &&
    ++		objects.commits.count.concern_level=2
    ++		objects.trees.count.concern_level=0
    ++		objects.blobs.count.concern_level=0
    ++		objects.tags.count.concern_level=0
    ++		objects.commits.inflated_size.concern_level=0
    ++		objects.trees.inflated_size.concern_level=0
    ++		objects.blobs.inflated_size.concern_level=3
    ++		objects.tags.inflated_size.concern_level=0
    ++		objects.commits.disk_size.concern_level=3
    ++		objects.trees.disk_size.concern_level=8
     +		objects.blobs.disk_size.concern_level=6
     +		objects.tags.disk_size.concern_level=5
    - 		objects.commits.max_size.concern_level=3
    - 		objects.trees.max_size.concern_level=0
    - 		objects.blobs.max_size.concern_level=1
    ++		objects.commits.max_size.concern_level=3
    ++		objects.trees.max_size.concern_level=0
    ++		objects.blobs.max_size.concern_level=1
    ++		objects.tags.max_size.concern_level=0
    ++		EOF
    ++
    ++		git repo structure --concern --format=lines >actual 2>err &&
    ++		test_grep "concern_level" actual >actual-concerns &&
    ++		test_cmp expect actual-concerns &&
    ++		test_line_count = 0 err
    ++	)
    ++'
    ++
    + test_expect_success 'progress meter option' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&

---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20261019-b4-repo-structure-concern-f1d6f6326095

