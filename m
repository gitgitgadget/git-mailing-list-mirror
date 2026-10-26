Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036646;
	b=R1ntqPXtnmvCwPD/j+nF5lsTHQGFQCP2HNJ0y4Fcdyd7ynzSIyJSEPdBaVNn26oBHMYj
	 EKiXYcOmJoUQ3XBXz4UuqZ0azR3qoVjmlDMgtZQJ+tJl2Pqe75EOjgbkEDFsXjsmHqNFK
	 Bh8LhmkcauwhLUykajiVSR3O9GwZxK9bH42OYA0eJGrMf/HldDIQwtPKoncLfQCdICgHR
	 M8urui10S+BLgV4RRFsIqgvWPxNQveQbjs8vf5qNOSW9PCuYEgQpcVfFB+U51Zzvhmz9j
	 01fOwuZKtJjEnPnSs/1nqApZ79dS7oH4az+XtIl8yjDHhpJizX6acHWQdAmwSklvBPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036646;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:In-Reply-To:
	 References:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5mp9w+bkE1QGs1AeoJ8K/hcvcgDu84y56ut65WgmBJY=;
	b=0db12WFTg3n0FjWX0N7tAzSOi0UZUWXnGnlzjSZyaFk0/6Yho6aSl0qoWi9xI93t2fXm
	 qBNR04ceOlUs9eaGgXp+An/EpbyGjHGX5o6Ir5jFTyKkDPdsGsY8loxbv19K1WjqnN8dq
	 cZpgtpH6J1a0FykXnkEC8IP6zrMYmWb/DEhx/anek3hQx0XlOtebEmH69ZgtKMiGCtDlI
	 lx4kcapHI8foj3O8tP8AZissGehEvYzn8xqOBrnkjLgfJtVIcJ0OXSx/lEnh0P9msLm8s
	 5F9GTjDkEKsj/6XdSLep6Zs5Dk1LASS0608/JjA3uQWKm4aQPkwuw0dusM4D3kWluCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=p31f6Ycb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RTRlYHCL;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED39606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ED39606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=p31f6Ycb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RTRlYHCL
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id CD59B1D0031A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:44:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 26 Oct 2026 13:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793036644;
	 x=1793123044; bh=5mp9w+bkE1QGs1AeoJ8K/hcvcgDu84y56ut65WgmBJY=; b=
	p31f6YcbsGXkG7Yd86fzriFq/sDe/vRa2iP92vCqkBPufUmA2xSzLje1v/NcZUIh
	7MYtUw3l2o74f8QUhDsN6hLN5gONgDOBSyYKb6C+fj9LFLo8wn5T1lbLeVTgRjCE
	a9Oa9+sTQQgVBHjuhBK06di+jaBtxNwEjn2085XUwm8EQFTUYSlORV5pAhq7bFsG
	8h4y3mYpYyfcmxOgnO4Nor8A83XEEJJUYv2vkcxzMDxVxXHsFdhDJdCbOgnUBPma
	0cG9WDP/HbKrIRzFkMhKQUoMLRdiGw2vbxuwTuHorJ4khfuw9kEUIyWC11ODSCn1
	9+lXLF5X+gVBbKJ2hyR0oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793036644; x=
	1793123044; bh=5mp9w+bkE1QGs1AeoJ8K/hcvcgDu84y56ut65WgmBJY=; b=R
	TRlYHCLGxg3Gu0npEosM+qx09grgWbqYbBzkbMBBpv/I/B/1OS9c3NkoOlv+3q2x
	M4ZlcyoaQ6h4eR4RLMYJJz4RS2xaukLOohxxJdoiIn8dW1vwAajrKO4Y24SjpqF9
	oONCNB2Ctwq2Qc22K4VeGUW1/u+Jy2KuWPr31Hc8R6/zNOvMUwqdLAsLz1yeMth3
	7XB8rZA6x0NOIbFR3GdbvE/PlOBCkusrAhTaKg2hWRea8IBefs0Fw7LU+XT9mOZn
	9fkNzoCKhQ+bvLsAF8zh3SQq63ih8cOVEpwZC2WGO6EK0nS742LZ1o2xxoB1HPLe
	igUR31NZ5PRTIpnRbf5zQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793036644; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jpUyZUR2Zue+FlwWEbBd/T6Ybn4m9QHtyLnBpquYt+dKqTX
	4AMo8IBiBKSvaxXbeB1Fggb5q2LojL5Cilh489wxQiynpNETpvinBmWhKTdfPSz2
	RxDsudBALfDU1VPJs2Ot4Ebcr/EPqPDMZh0gVvJMTWP/b/U6IQHfx5nyFJVXDJ2L
	L+t4wJymYrGd027JNFXvuHDrwu0wAKRLoICEQNOgKYFSijzBbRqsomrqR4Ai0/o9
	wkXDFaku0dXPhPqAB7r0jU5mFW1HIjEfHNekMq6QUZOnhhi+pzOs/IQ5ho+HIqy0
	ZjDod43W89W+IwwZhYy5LRR1jCj74bMwihMRlHA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DPvvC8nglwu6n+DlW7Y2pino7wrnuTyj+wXuZEehXjg=:UZJVh7/arZET15WCZgSSBIxFYro85Qn8uAlLPC729ik=;
X-ME-Sender: <xms:ZJHfaudDUzih_P6eFOLCyx9P2T_w2dtXwwPDRVBiDxbyegucICam2A>
    <xme:ZJHfauMS_Y3N55lUBvppoTqppvQsEReAVwzxYC5DSlcvZdSbaO7sA3lE-yKHWOT8w
    TvzWjd_RTEK_L6pQ0vpn73wBDq8oIJmg3bkGqIvGtaxyMKghctrdRw>
X-ME-Received: <xmr:ZJHfatLyRUtA3V4in30YLNKsn8RXg0axU8INion3Kotg6aRgr-4RlA3m-v8-PW_mdYfQxuhKnSQ6ES2GtNL7HMKQF5cx>
X-ME-Proxy-Cause: dmFkZTFj30rwbxbiEkeWgC3TcWMPUiUIi4VDq+iQyaHAdlJLkIOen/0pt13Nj6N6BVKGVu
    1Vro3iEJ3AxEBcQ8TDmt/Br79wU1mqekQZ9OCKVUVnDJOn/LkH47nxPuUrs+veykRcfAck
    EG45mhoWt0labPzSxUVa0S30BAWjprqBcUXka6L6qMST/Mp5IrJWhJi2tXGP0qS8WtMOGN
    maQ6yBz5vsaVF+4OduVsuHuIxNFyBEYkdb2Y+GZovt8JpOKPdwC6bHC6z2fIJSpouDuAK1
    mShu3Om9SZFvSERMQP+9pxKFGO/tu2nsGjokdL3c4v23ihzVxLW2iecHtU9UZXbHEKHiWz
    JWWt/h7hiNqjjKTXef4lTxXofj5mpPs1LHxw9m4f/Yfyz7wD1QM2oVez9fWQhL4m+4LuhN
    dB3WS8T5H4lFJD8/IAFsfQuqfeRdJ70Fg8ZiDjO4tGV9we941ez/bX9Shkqllmgu24qvtj
    vMGxIPAoaRb5W24Wn8TVPGLLhx6dFbtznUqWO6m5TLy9QSqFo38/g0QabKuA/SMZRyX8Us
    1uzYMNIpkudSW/WaVxXV1XyFi2w4A+juCXWKBysHkTN/mefXh95vDAT2wXS6a/FljSE9Cn
    iMFINwFGdJwp/OwG78XhxY/ZrMiVWLh2Zeq71MQmJrHpNxj1CXfNS4pF1m0w
X-ME-Proxy: <xmx:ZJHfanFYYwJ6HaQMhWBTL8KBMU5p7GcnRewuUzPyk8ps_LdSf37_iw>
    <xmx:ZJHfatSrtLV9lNvMoGLluce99unu_LD-Ndg05K3AnY6yipRljnZNnA>
    <xmx:ZJHfarGMVY20wZocXNrVtVjr5csAR-vqpVkbDYtZLv1iOFrqrkCjdA>
    <xmx:ZJHfah-glBYbWiW0l3IJVpXqfVK4xp9VclDO325qcdi-ZarklIjIIQ>
    <xmx:ZJHfap1Rc6yWzTY8s36kabJFmD_CqY3ZMvZQqXpx_Qqgbeh8v0QIL6Ey>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:44:04 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v2 0/3] repo: add degree-of-concern reporting to structure
Date: Mon, 26 Oct 2026 13:43:53 -0400
Message-Id: <20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0K6dkw7SBNceQ/CAspUaqQl00I0h
 LsL6NrlS/5/bxGR2FEU12wRTLOLLvgN8JQJ0zf+TuC6jQVK1EqqEtoLMI0BYuLJpIkJTPCG2IN
 VnbY6Ry3LQmz/kcm61+Gu6i/HqX2QSbtwX/QupsDvIz6rfffroPrTmRVIoFwqWRSIJZqbbWIaG
 vc8mzCIel3XD9Uw40rXAAAA
X-Change-ID: 20261019-b4-repo-structure-concern-f1d6f6326095
In-Reply-To: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
References: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17186;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=UZJVh7/arZET15WCZgSSBIxFYro85Qn8uAlLPC729ik=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLLuT0ysDLVec/2B4EJxvbWFKw7WfbkrYO3k22i3qu/ws
 fcrsqc+6ShlYRDjYpAVU2T5/0+g8RXLAwm/oHefYOawMoEMYeDiFICJTF7EyNBl0WbXEsXdqXTV
 O6ryhmRp978ljDo7j+or5vo0PLX3WcXIcNDB/UJgVfO/XfI/3rps+Czx4MtpFi/m+Z5qikdtYhN
 38QIA
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
* The final commit update the documentation for the command and
  configuration options.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
Changes in v2:
- Fix memory leak in concern string generation.
- Fix CI/CD test issue involving zlib versions.
- Updating the naming of the config value prefix.
- Link to v1: https://patch.msgid.link/20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com

---
Mark C. Chu-Carroll (3):
      repo: add level of concern reporting
      repo: make concern thresholds configurable
      repo: add documentation for level-of-concern.

 Documentation/config/repo.adoc |  59 +++++++
 Documentation/git-repo.adoc    |  27 +++-
 builtin/repo.c                 | 343 ++++++++++++++++++++++++++++++++++++++---
 t/t1901-repo-structure.sh      | 137 ++++++++++++++++
 4 files changed, 543 insertions(+), 23 deletions(-)

Range-diff versus v1:

1:  c2b2a79967 = 1:  e8971a4050 repo: add level of concern reporting
2:  67d77cfcd9 ! 2:  7a78eee517 repo: make concern thresholds configurable
    @@ builtin/repo.c
      #include "environment.h"
      #include "hash.h"
      #include "hex.h"
    +@@
    + #define REPO_STRUCTURE_USAGE \
    + 	"git repo structure [--format=(table|lines|nul) | -z] [--[no-]concern]"
    + 
    ++#define REPO_STRUCTURE_CONFIG_PREFIX "repo.concern."
    ++
    + static const char *const repo_usage[] = {
    + 	REPO_INFO_USAGE,
    + 	REPO_STRUCTURE_USAGE,
     @@ builtin/repo.c: enum concern_stat {
      	CONCERN_STAT_TREE_INFLATED_SIZE,
      	CONCERN_STAT_BLOB_INFLATED_SIZE,
    @@ builtin/repo.c: enum concern_stat {
     -	{ .name = "tag_inflated_size", .threshold = 25}
     +struct concern_stat_threshold concern_stat_thresholds[] = {
     +	{ .name = "commit-count", .threshold = 19 },
    -+	{.name = "tree-count", .threshold = 21 },
    ++	{ .name = "tree-count", .threshold = 21 },
     +	{ .name = "blob-count", .threshold = 22 },
     +	{ .name = "tag-count", .threshold = 15 },
     +	{ .name = "commit-size", .threshold = 28 },
    @@ builtin/repo.c: enum concern_stat {
      };
      
      /*
    +  * Concern thresholds aren't universal. We try to set reasonable default
    +  * values, but projects may want to set these thresholds differently. To
    +  * support that, they can set the thresholds for their project in the
    +- * project's git config, in the section "repo.structure.concern".
    ++ * project's git config, in the section "repo.concern".
    +   */
    + static int config_concern_thresholds(const char *prefixed_var,
    + 				     const char *str_val,
    + 				     const struct config_context *ctx,
    + 				     void *cb UNUSED) {
    +-	const char *config_prefix = "repo.structure.concern.";
    +-	if (!strncmp(config_prefix, prefixed_var, strlen(config_prefix))) {
    +-		const char *concern_name = &prefixed_var[strlen(config_prefix)];
    ++	if (!strncmp(REPO_STRUCTURE_CONFIG_PREFIX, prefixed_var,
    ++	      strlen(REPO_STRUCTURE_CONFIG_PREFIX))) {
    ++		const char *concern_name =
    ++			&prefixed_var[strlen(REPO_STRUCTURE_CONFIG_PREFIX)];
    + 		for (int i = 0; concern_stat_thresholds[i].name != 0; i++) {
    + 			if (!strcmp(concern_stat_thresholds[i].name, concern_name)) {
    + 				int value = git_config_int(prefixed_var, str_val, ctx->kvi);
    +@@ builtin/repo.c: static int config_concern_thresholds(const char *prefixed_var,
    + 	return 0;
    + }
    + 
    +-static size_t approx_log2(long value) {
    ++static size_t approx_log2(size_t value) {
    + 	int position = 0;
    + 	if (value <= 0) {
    + 		return 0;
     @@ builtin/repo.c: static size_t approx_log2(long value) {
      static size_t repo_structure_concern_level(enum concern_stat stat_id,
      					   size_t value) {
    @@ builtin/repo.c: static size_t approx_log2(long value) {
      		BUG("unexpected repository stat type");
      	log_value = approx_log2(value);
      	if (log_value > concern_stat_thresholds[stat_id].threshold)
    +@@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table *table,
    + 			strbuf_utf8_align(&buf, ALIGN_LEFT, concern_col_width, concern_str.buf);
    + 			strbuf_addstr(&buf, " |");
    + 		}
    ++		strbuf_release(&concern_str);
    + 		printf("%s\n", buf.buf);
    + 	}
    + 
     @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
      	print_keyvalue("objects.blobs.disk_size", key_delim,
      		       stats->objects.disk_sizes.blobs, value_delim);
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
      			       repo_structure_concern_level(CONCERN_STAT_BLOB_SIZE,
      							    stats->objects.disk_sizes.blobs),
      			      value_delim);
    +@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    + 							    stats->objects.largest.commit_size.value),
    + 			      value_delim);
    + 	print_object_data("objects.trees.max_size", key_delim,
    +-			  &stats->objects.largest.tree_size, value_delim);
    ++			 &stats->objects.largest.tree_size, value_delim);
    + 	if (show_concern)
    + 		print_keyvalue("objects.trees.max_size.concern_level", key_delim,
    + 			       repo_structure_concern_level(CONCERN_STAT_TREE_LARGEST,
    +@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    + 							    stats->objects.largest.blob_size.value),
    + 			      value_delim);
    + 	print_object_data("objects.tags.max_size", key_delim,
    +-			  &stats->objects.largest.tag_size, value_delim);
    ++			   &stats->objects.largest.tag_size, value_delim);
    + 	if (show_concern)
    + 		print_keyvalue("objects.tags.max_size.concern_level", key_delim,
    + 			       repo_structure_concern_level(CONCERN_STAT_TAG_LARGEST,
     @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
      	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
      	if (argc)
    @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
     +	git init repo &&
     +	(
     +		cd repo &&
    ++		# differences between zlib and zlib-ng can cause this
    ++		# test to fail; so we just turn it off.
    ++		git config core.compression 0 &&
     +		# configure thresholds to get concern indications
    -+		git config repo.structure.concern.commit-count 7 &&
    -+		git config repo.structure.concern.commit-size 14 &&
    -+		git config repo.structure.concern.tree-size 10 &&
    -+		git config repo.structure.concern.blob-size 8 &&
    -+		git config repo.structure.concern.blob-inflated-size 10 &&
    -+		git config repo.structure.concern.tag-size 2 &&
    -+		git config repo.structure.concern.commit-largest 4 &&
    -+		git config repo.structure.concern.blob-largest 2 &&
    -+		touch configured &&
    ++		git config repo.concern.commit-count 7 &&
    ++		git config repo.concern.commit-size 14 &&
    ++		git config repo.concern.tree-size 10 &&
    ++		git config repo.concern.blob-size 8 &&
    ++		git config repo.concern.blob-inflated-size 10 &&
    ++		git config repo.concern.tag-size 2 &&
    ++		git config repo.concern.commit-largest 4 &&
    ++		git config repo.concern.blob-largest 2 &&
     +		test_commit_bulk 1005 &&
     +		git tag -a foo -m bar &&
     +		oid="$(git rev-parse HEAD)" &&
    @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
     +		|     * Commits             | $(object_type_disk_usage commit true) | ***      |
     +		|     * Trees               | $(object_type_disk_usage tree true) | ******** |
     +		|     * Blobs               |  $(object_type_disk_usage blob true) | ******   |
    -+		|     * Tags                |    $(object_type_disk_usage tag) B   | ****     |
    ++		|     * Tags                |    $(object_type_disk_usage tag) B   | *****    |
     +		|                           |            |          |
     +		| * Largest objects         |            |          |
     +		|   * Commits               |            |          |
    @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
      test_expect_success SHA1 'lines and nul format' '
      	test_when_finished "rm -rf repo" &&
      	git init repo &&
    +@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines format with concerns' '
    + 	git init repo &&
    + 	(
    + 		cd repo &&
    ++		# differences between zlib and zlib-ng can cause this
    ++		# test to fail; so we just turn it off.
    ++		git config core.compression 0 &&
    + 		# configure thresholds to get concern indications
    +-		git config repo.structure.concern.commit-count 7 &&
    +-		git config repo.structure.concern.commit-size 14 &&
    +-		git config repo.structure.concern.tree-size 10 &&
    +-		git config repo.structure.concern.blob-size 8 &&
    +-		git config repo.structure.concern.blob-inflated-size 10 &&
    +-		git config repo.structure.concern.tag-size 2 &&
    +-		git config repo.structure.concern.commit-largest 4 &&
    +-		git config repo.structure.concern.blob-largest 2 &&
    +-		touch configured &&
    ++		git config repo.concern.commit-count 7 &&
    ++		git config repo.concern.commit-size 14 &&
    ++		git config repo.concern.tree-size 10 &&
    ++		git config repo.concern.blob-size 8 &&
    ++		git config repo.concern.blob-inflated-size 10 &&
    ++		git config repo.concern.tag-size 2 &&
    ++		git config repo.concern.commit-largest 4 &&
    ++		git config repo.concern.blob-largest 2 &&
    + 		test_commit_bulk 1005 &&
    + 		git tag -a foo -m bar &&
    + 		oid="$(git rev-parse HEAD)" &&
    +@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines format with concerns' '
    + 		# Also creates a commit, tree, and blob.
    + 		git notes add -m foo &&
    + 
    +-
    + 		# The tags disk size is handled specially due to the
    + 		# git-rev-list(1) --disk-usage=human option printing the full
    + 		# "byte/bytes" unit string instead of just "B".
     @@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines format with concerns' '
      		objects.tags.inflated_size.concern_level=0
      		objects.commits.disk_size.concern_level=3
      		objects.trees.disk_size.concern_level=8
     -		objects.blobs.blob_size.concern_level=6
    +-		objects.tags.disk_size.concern_level=4
     +		objects.blobs.disk_size.concern_level=6
    - 		objects.tags.disk_size.concern_level=4
    ++		objects.tags.disk_size.concern_level=5
      		objects.commits.max_size.concern_level=3
      		objects.trees.max_size.concern_level=0
    + 		objects.blobs.max_size.concern_level=1
3:  ac0adb7c9f ! 3:  cc78eaeca0 repo: add documentation for level-of-concern.
    @@ Commit message
     
      ## Documentation/config/repo.adoc (new) ##
     @@
    -+`repo.structure.concern.commit-count`::
    ++`repo.concern.commit-count`::
     +	Sets the value of the concern threshold for commit count.
     +
    -+`repo.structure.concern.tree-count`::
    ++`repo.concern.tree-count`::
     +	Sets the value of the concern threshold for tree count.
     +
    -+`repo.structure.concern.blob-count`::
    ++`repo.concern.blob-count`::
     +	Sets the value of the concern threshold for blob count.
     +
    -+`repo.structure.concern.tag-count`::
    ++`repo.concern.tag-count`::
     +	Sets the value of the concern threshold for tag count.
     +
    -+`repo.structure.concern.commit-size`::
    ++`repo.concern.commit-size`::
     +	Sets the value of the concern threshold for total commit size.
     +
    -+`repo.structure.concern.tree-size`::
    ++`repo.concern.tree-size`::
     +	Sets the value of the concern threshold for total tree size.
     +
    -+`repo.structure.concern.blob-size`::
    ++`repo.concern.blob-size`::
     +	Sets the value of the concern threshold for total blob size.
     +
    -+`repo.structure.concern.tag-size`::
    ++`repo.concern.tag-size`::
     +	Sets the value of the concern threshold for total tag size.
     +
    -+`repo.structure.concern.commit-inflated-size`::
    ++`repo.concern.commit-inflated-size`::
     +	Sets the value of the concern threshold for total size
     +	of all inflated commits.
     +
    -+`repo.structure.concern.tree-inflated-size`::
    ++`repo.concern.tree-inflated-size`::
     +	Sets the value of the concern threshold for total size of
     +	all inflated trees.
     +
    -+`repo.structure.concern.blob-inflated-size`::
    ++`repo.concern.blob-inflated-size`::
     +	Sets the value of the concern threshold for total size of
     +	all inflated blobs.
     +
    -+`repo.structure.concern.tag-inflated-size`::
    ++`repo.concern.tag-inflated-size`::
     +	Sets the value of the concern threshold for the total size
     +	of all inflated tags.
     +
    -+`repo.structure.concern.commit-largest`::
    ++`repo.concern.commit-largest`::
     +	Sets the value of the concern threshold the size of the largest
     +	commit.
     +
    -+`repo.structure.concern.tree-largest`::
    ++`repo.concern.tree-largest`::
     +	Sets the value of the concern threshold for the size of the
     +	largest tree.
     +
    -+`repo.structure.concern.blob-largest`::
    ++`repo.concern.blob-largest`::
     +	Sets the value of the concern threshold for the size of the
     +	largest blob.
     +
    -+`repo.structure.concern.tag-largest`::
    ++`repo.concern.tag-largest`::
     +	Sets the value of the concern threshold for the size of the
     +	largest tag.
    -++
    -+All of the concern thresholds are integer values for the 
    ++
    ++All of the concern thresholds are integer values for the
     +floor of the base-2 log of the threshold value. The default values
     +of each threshold are set to heuristically determined values.
    -+
     
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: SYNOPSIS
    @@ Documentation/git-repo.adoc: supported:
     +users should be concerned about, adding '--concern' will provide a
     +level of concern to be added to the output. In 'table' mode, this will
     +be a table column indicating the level of concern as a number of stars;
    -+in 'lines` or `nul' mode, a `concern_level` line will be added for each
    ++in `lines` or `nul` mode, a `concern_level` line will be added for each
     +statistic with a numeric value.
     ++
    -+The level of corcern for each statistic is computed using the base_2 log of the
    ++The level of concern for each statistic is computed using the log_2 of the
     +statistic value. The value is considered concerning if it exceeds a heuristically
     +chosen threshold value; the degree of concern is the difference between the
    -+base_2 log of the value, and the base_2 log of the corresponding threshold.
    ++log_2 of the value, and the log_2 of the corresponding threshold.
     ++
     +The threshold values are configurable; see the configuration section below.
      

---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20261019-b4-repo-structure-concern-f1d6f6326095

