Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637177;
	b=0kHyX2M+mkJJt4eM2b3OE/BLaL0SvHnZhDdpKLchnGGHTq+hc6FhVidPBtAKkMmcs8vH
	 IsZUJYJdnmuxAUEIokl5Hpwn7wLvXaRnXb7fc7T209jsfrjKupYnZ/j2qV/ZjGTbwjaae
	 F6BHeXIJFogS3x4uDNwMOAKw8B8ukQiHmhMJWHYXdKz9v9/QqKipjb4JeWauNdfCU+5m6
	 VIB6a02zwITVi/ustTvv0cHsP9GY8blq+L1DfqXRSmVfPEEvyXPFVrsNq+IGZZRSPaIVc
	 6lSxSZqyl3r1VvoVg0Zy0yyaPoOFYtFitM18pabFar0XAhVUVmmY4qEh/nRE+eXXRzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637177;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:In-Reply-To:
	 References:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SPkun3mgrBaV0h6PD/L9YPlru2YR7d8zcJgxdljNAEA=;
	b=P+oJ9Djq5v73JMWuyAkHUMUZxn1svGmQSGQm82p3vzIjh1ziPuRc7vfDErPdeEdNDGmq
	 V6sPkKnIC0Ahs0NI2GTJfBkfLoeIyxRWaD0fdDm5JCvOCjIwhQ2IDohOJhpRNy9vAm1ka
	 TT7S2+t2DaQpNbY3m944zj2fyprDMRofaWLeBtbZxOQgG79mXZEaXcjTjZuEjbcMiX8tO
	 9ljABwPvuNQypgSGo6YzFHJ4ZXDzq/b0F6r+0DmXwxuYD1dNZa2hh0SfesmrhKpCsoo53
	 k0CHGe8HlMFHGUa4tj3XN/Nz5xx69I/343XUDWaIS3M4schMNPOmaU7JpZ7YgRun+YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=POk4SJyZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fz+KQfNa;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E8608360D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A69E8608360D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=POk4SJyZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fz+KQfNa
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 064EDEC0068
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:32:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 02 Nov 2026 11:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793637175;
	 x=1793723575; bh=SPkun3mgrBaV0h6PD/L9YPlru2YR7d8zcJgxdljNAEA=; b=
	POk4SJyZHLEACWcXRpg0YtQ4RLlrh8c6x9sNLeNt+5Dopp4aenXhXpnSNEZkiBDQ
	JEmZKpQG7toM46QzEKiqMDXdpclq7d3H7D6hBiFFmiuQgN9oOF1B/l3SGLcPSFtl
	gWQngXNLMULsi7a1XJKFps5U0tyF7fsvMIkkfa3CyWsUapHEgPfkg92zmesM540v
	NX8BVXle8b7lNK/fvgELyGDN+LJszDCqtN2uiDz5D3ZIJ8Yw5+c2KLed2alcy9zQ
	JxVGprKBAra4e6BgpqyO5C3xW/SFlSmhLTCQjxD9oatpIFPKdwsIvF0SiADVasKo
	zpix/zNJ7GHDy0zyX/T15A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793637175; x=
	1793723575; bh=SPkun3mgrBaV0h6PD/L9YPlru2YR7d8zcJgxdljNAEA=; b=f
	z+KQfNaPA0D3C/1nnRkkEeha2+WxcZUI4qvNodf7Py8krHZQPWp2s2oMtsZCerBS
	u9grZx4euLRHK42fYw2eGZ/QiVwpNpIlTKlptA3RpyoVJkTBbiK21sotLk35Ybre
	BIK8su7keQHzJfePi0JeHkUfvCPBP204LLhLebKKcum5HJcSHBRDr6Wo00j25+9X
	jo7G7IGwvpx23Wl+6j7N5xxK7Cnplct0ckXqsnFsBIMKg7hLkL2yRFx/wwgFJsWf
	3LwMYZsVRz3YNpndZSbz6XeRYqup2MRnDwI7U4sTXZg4OGG+VvJLjFcu12WNTZzl
	EjLXaBMNFoHLq4zuSHwkA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793637175; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:auQxHskanbmk2rErB6YH8xUlZPvD8LkP2LjQO4Lna6dPTek
	Nll0giB8Js5kzM/Xr1SRMEZcZs8/uq3N7xoOJQF3AlSs9zQh9ScWLx4SN/ZY8Y52
	Q3JFMj5GcVFV6umnyEb4kbji4LX42R3Cqc88KaITb5qlNzWTi7Md+D27eOdAa2Hs
	manx2/KuLtOrhoI5UMDn97+VNSZlsXap2vFMsV4u59NSB71uMJ6ZQbhc553fBFfP
	+ZytzWV5vYgXbQb/JbM8B4zx/RHVbFlwvGJ0pqTQLltkrPv0/76LnAcftKmEm27B
	sPFNnipmzHGruaWtllpU35vku11czpAyvdMQ4tw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:f4bHPS+uH/L7a7OkTDPmvNup28qoKYdB0Q6XfLseMWQ=:FlfnPAbtM0sk/E79Y85LFev1hCvK2rxZihDV7UbBuj8=;
X-ME-Sender: <xms:N7voap0vhYXNl4PqsQMbbpyCD5RMbUONooihB0J2MctYFdYuJO-DpA>
    <xme:N7voamHzy2X6p3E4Z95Gdk8QujFDEdOJIkNsNVcSb9lgALvq1FcUiwfh-YGViGjO3
    -QC2UJxLX_zvp3Hp7qskP-dX_WazksWiW4-ZMODIE9QsDtJL8rakWQ>
X-ME-Received: <xmr:N7voani8NESn0h1RvQDASVugiAmJIhQIxCcujLGqRJL7tonoEBDF7P3R5Y53JA>
X-ME-Proxy-Cause: dmFkZTG14K2xswXwr7KYrshX2lyARJWHCdrt5x+k4tF1sKt14jNoo1EjGzFl/trTtuE4B8
    wDx31BtV170Tq81qip4xGNQeDQvc2Zht9/c/2RpktrbbsKrmGFJwsofU9KzEkZOO7Z1k9D
    Igbx55VXZbjEry0OguvygPL93+Y5WBy5bl53c/5sZMS2SxfbAu06o0kj2ukDfMghggQZd1
    Oz33f3up+Hdh1YJQ/BmoriUfLEXHKqRDD3OBI7dRNSHlkw8ChNLy4RrihK/95B29dPQz2J
    MoC5BX6iOFu/UYEbnXYMTiSIi7PsmJC5xZOuv399IksQXk372Kza2y1R60SjY+zmS01EVh
    gWuNj3mwnMZA6PMQ4x/hIigL2auGJ/bhfTlyNCMBxz7GUiMIWhLq/kh9v/gj7Tzl50smQ4
    W0AnObRsCt+9TlseI7hOjBDLxSSyGTch6URwB/u1FA5trUATD50jQ3xIaUJH9H9C3aMbC1
    t9z00kKgzc6Fd6JZg5l1ilqUjn968S11CbJkCvoozBJ5o58T/U7HGo0VCUDhFB7NXI2Mxf
    DYbf0yR6PtRgZpQfhe9dCe6YOuSgu6OCiWesaDl4MsUXgpbsEQWL4Fs9s6paZbNwr29HO4
    V8S+gmEmQeHOEaZ/1CYjOQGii+otl6O0thKoP2kpbb7eGejE7XYL1LFnDG9w
X-ME-Proxy: <xmx:N7voah9YQmIPtB55Rtq8v0mOcFnQuDnX05xa_OV97xNNE867OOC2uw>
    <xmx:N7voaurcxXm-fhIKIJQE2JmkmeLq_5ON6ZjTSzJK_36xb4uEZfY-vQ>
    <xmx:N7voag83Cc_5Ftob4zdeSWyXOCTGVVKuUMEj45IDALWHq4iuGaEWZQ>
    <xmx:N7voaiWezA3TAxKwHa2kQAjDl79bO3Pa8Q6X63ld18oSEovzIubePg>
    <xmx:N7voalNQg0zy_3Xh5PsY8SV5sTWRqYboXY3srGakrzpRTQHZHWZXf9zg>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 11:32:55 -0500 (EST)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v5 0/2] repo: add degree-of-concern reporting to structure
Date: Mon, 02 Nov 2026 11:32:42 -0500
Message-Id: <20261102-b4-repo-structure-concern-v5-0-2d8f37b70b75@fastmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33QTW7DIBAF4KtErEsFw5+dVe9RdeHA0FA1JgKMW
 kW+eyHtwqoiL5/05nvS3EjGFDCT4+FGEtaQQ5xbUE8HYs/T/I40uJYJMNCc8ZGeJE14jTSXtNi
 yJKQ2zhbTTD132msBmo2KtPtrQh++7vbr22/Oy+kDbelgb5xDLjF938cr772/HeA7O5VTRlEwz
 pQCGMG++CmXyxQ+n228kD5VYYvpPQw6xpwXEmBwdniAiS1m9jDRsHFwZlKGSW7YA0xusb13Vtk
 wN3ChhEGrufmHrev6A/F061e+AQAA
X-Change-ID: 20261019-b4-repo-structure-concern-f1d6f6326095
In-Reply-To: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
References: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=41241;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=FlfnPAbtM0sk/E79Y85LFev1hCvK2rxZihDV7UbBuj8=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLJe7Db9tlNAzu29RvY07a4tebfnMfxQUzCJfCO75+rq0
 q5Uge8FHaUsDGJcDLJiiiz//wk0vmJ5IOEX9O4TzBxWJpAhDFycAjCRg5cY/sfYXn44QceTx0Bp
 4aIZjFOWfJp6Yme03SWT7T4va2bnH0xl+Ct3fNbNhRkTDSeqe877X7U586dL8eH0TR4beI8yee4
 4/YwZAA==
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
Changes in v5:
- whitespace fixes
- change configuration values to make them more intuitive.
- fix cut-and-paste error
- fix location-of-deallocation error of strbuf in table generation
- removed invalid concern for tag-refs.
- fix integer typing in concern computation and table generation.
- Link to v4: https://patch.msgid.link/20261029-b4-repo-structure-concern-v4-0-d813537ec617@fastmail.com

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

 Documentation/config/repo.adoc |  63 ++++++
 Documentation/git-repo.adoc    |  27 ++-
 builtin/repo.c                 | 479 +++++++++++++++++++++++++++++++++++++----
 t/t1901-repo-structure.sh      | 138 +++++++++++-
 4 files changed, 668 insertions(+), 39 deletions(-)

Range-diff versus v4:

1:  66d6fc14d4 ! 1:  c5100f5fa3 repo: add level of concern reporting
    @@ Documentation/git-repo.adoc: supported:
      ---------
     
      ## builtin/repo.c ##
    +@@
    + #define USE_THE_REPOSITORY_VARIABLE
    + 
    ++#include "git-compat-util.h"
    + #include "builtin.h"
    + #include "commit.h"
    ++#include "config.h"
    + #include "environment.h"
    + #include "hash.h"
    + #include "hex.h"
     @@
      #include "tree.h"
      #include "tree-walk.h"
    @@ builtin/repo.c
      #define REPO_STRUCTURE_USAGE \
     -	"git repo structure [--format=(table|lines|nul) | -z]"
     +	"git repo structure [--format=(table|lines|nul) | -z] [--[no-]concern]"
    ++
    ++#define REPO_STRUCTURE_CONFIG_PREFIX "repo.concern."
      
      static const char *const repo_usage[] = {
      	REPO_INFO_USAGE,
    @@ builtin/repo.c: struct stats_table {
      	int name_col_width;
      	int value_col_width;
      	int unit_col_width;
    -+	int concern_col_width;
    - };
    - 
    ++	size_t max_concern_value;
    ++};
    ++
     +/*
     + * For computing level of concern about a stat, we need to have some
    -+ * baseline values. For each of these, we'define a minimum level
    ++ * baseline values. For each of these, we define a minimum level
     + * of concern, which will appear as 1 star. Then we scale exponentially:
     + * each time that value doubles, we add another star.
     + *
    @@ builtin/repo.c: struct stats_table {
     +struct concern_stat_threshold {
     +	const char *name;
     +	size_t threshold;
    -+};
    -+
    + };
    + 
     +#define CONCERN_STAT_COMMIT_COUNT "commit-count"
     +#define CONCERN_STAT_TREE_COUNT "tree-count"
     +#define CONCERN_STAT_BLOB_COUNT "blob-count"
    @@ builtin/repo.c: struct stats_table {
     +#define CONCERN_STAT_BLOB_INFLATED_SIZE "blob-inflated-size"
     +#define CONCERN_STAT_TAG_INFLATED_SIZE "tag-inflated-size"
     +
    -+struct concern_stat_threshold repo_structure_concern_thresholds[] = {
    ++static struct concern_stat_threshold repo_structure_concern_thresholds[] = {
     +	{ .name = CONCERN_STAT_COMMIT_COUNT, .threshold = 19 },
     +	{ .name = CONCERN_STAT_TREE_COUNT, .threshold = 21 },
     +	{ .name = CONCERN_STAT_BLOB_COUNT, .threshold = 22 },
    @@ builtin/repo.c: struct stats_table {
     +	{ 0 }
     +};
     +
    -+static size_t get_concern_threshold(const char *name, struct concern_stat_threshold *thresholds) {
    ++static int get_concern_threshold(const char *name, struct concern_stat_threshold *thresholds)
    ++{
     +	for (size_t i = 0; thresholds[i].name; i++) {
    -+		if (!strcmp(thresholds[i].name, name)) {
    ++		if (!strcmp(thresholds[i].name, name))
     +			return thresholds[i].threshold;
    -+		}
     +	}
    -+	return 0;
    ++	return -1;
     +}
     +
    -+static size_t repo_structure_concern_level(const char* concern_name,
    -+					   size_t value,
    -+					   struct concern_stat_threshold *thresholds) {
    -+	const size_t threshold = get_concern_threshold(concern_name, thresholds);
    -+	size_t log_value;
    -+	if (threshold == 0)
    -+		BUG("unexpected repository stat threshold: '%s'", concern_name);
    -+	log_value = log2u(value);
    -+	if (log_value > threshold)
    -+		return log_value - threshold;
    -+	else
    ++static int repo_structure_concern_level(const char *concern_name,
    ++					size_t value,
    ++					struct concern_stat_threshold *thresholds,
    ++					bool show_concern)
    ++{
    ++	if (show_concern) {
    ++		size_t log_value;
    ++		const int threshold = get_concern_threshold(concern_name, thresholds);
    ++		if (threshold < 0)
    ++			BUG("unexpected repository stat threshold: '%s'", concern_name);
    ++		log_value = (size_t)log2u(value);
    ++		if (log_value > (size_t)threshold)
    ++			return log_value - threshold;
    ++		else
    ++			return 0;
    ++	} else {
     +		return 0;
    ++	}
     +}
     +
      /*
    @@ builtin/repo.c: static void stats_table_vaddf(struct stats_table *table,
      		if (value_width > table->value_col_width)
      			table->value_col_width = value_width;
      	}
    -+	if ((int)entry->concern > table->concern_col_width)
    -+		table->concern_col_width = entry->concern;
    ++	if (entry->concern > table->max_concern_value)
    ++		table->max_concern_value = entry->concern;
    ++
      	if (entry->unit) {
      		int unit_width = utf8_strwidth(entry->unit);
      		if (unit_width > table->unit_col_width)
    @@ builtin/repo.c: static void stats_table_addf(struct stats_table *table, const ch
      	va_end(ap);
      }
      
    -+// define a symbol for 'no concern value for this stat'; this will
    -+// make the code below easier to read.
    ++/*
    ++ * Define a symbol for 'no concern value for this stat'; this will
    ++ * make the code below easier to read.
    ++ */
     +#define CONCERN_STAT_VALUE_NONE 0
     +
      static void stats_table_count_addf(struct stats_table *table, size_t value,
    @@ builtin/repo.c: static void stats_table_object_size_addf(struct stats_table *tab
      
      	/*
      	 * A NULL OID should not have a table annotation.
    +@@ builtin/repo.c: static inline size_t get_total_object_values(struct object_values *values)
    + }
    + 
    + static void stats_table_setup_structure(struct stats_table *table,
    +-					struct repo_structure *stats)
    ++					struct repo_structure *stats,
    ++					bool show_concern)
    + {
    + 	struct object_stats *objects = &stats->objects;
    + 	struct ref_stats *refs = &stats->refs;
     @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *table,
      
      	ref_total = get_total_reference_count(refs);
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
     +	stats_table_count_addf(table, refs->branches, CONCERN_STAT_VALUE_NONE,
     +			       "    * %s", _("Branches"));
     +	stats_table_count_addf(table, refs->tags,
    -+			       repo_structure_concern_level(
    -+				       CONCERN_STAT_TAG_COUNT,
    -+				       refs->tags,
    -+    			               repo_structure_concern_thresholds),
    ++			       CONCERN_STAT_VALUE_NONE,
     +			       "    * %s", _("Tags"));
     +	stats_table_count_addf(table, refs->remotes, CONCERN_STAT_VALUE_NONE,
     +			       "    * %s", _("Remotes"));
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_COMMIT_COUNT,
     +				       objects->type_counts.commits,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
      			       "    * %s", _("Commits"));
      	stats_table_count_addf(table, objects->type_counts.trees,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TREE_COUNT,
     +				       objects->type_counts.trees,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
      			       "    * %s", _("Trees"));
      	stats_table_count_addf(table, objects->type_counts.blobs,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_BLOB_COUNT,
     +				       objects->type_counts.blobs,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++			               show_concern),
      			       "    * %s", _("Blobs"));
      	stats_table_count_addf(table, objects->type_counts.tags,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TAG_COUNT,
     +				       objects->type_counts.tags,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
      			       "    * %s", _("Tags"));
      
      	inflated_object_total = get_total_object_values(&objects->inflated_sizes);
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_COMMIT_INFLATED_SIZE,
     +				      objects->inflated_sizes.commits,
    -+				      repo_structure_concern_thresholds),
    ++				      repo_structure_concern_thresholds,
    ++				      show_concern),
      			      "    * %s", _("Commits"));
      	stats_table_size_addf(table, objects->inflated_sizes.trees,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_TREE_INFLATED_SIZE,
     +				      objects->inflated_sizes.trees,
    -+				      repo_structure_concern_thresholds),
    ++				      repo_structure_concern_thresholds,
    ++				      show_concern),
      			      "    * %s", _("Trees"));
      	stats_table_size_addf(table, objects->inflated_sizes.blobs,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_BLOB_INFLATED_SIZE,
     +				      objects->inflated_sizes.blobs,
    -+				      repo_structure_concern_thresholds),
    ++				      repo_structure_concern_thresholds,
    ++				      show_concern),
      			      "    * %s", _("Blobs"));
      	stats_table_size_addf(table, objects->inflated_sizes.tags,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_TAG_INFLATED_SIZE,
     +				      objects->inflated_sizes.tags,
    -+				      repo_structure_concern_thresholds),
    ++				      repo_structure_concern_thresholds,
    ++				      show_concern),
      			      "    * %s", _("Tags"));
      
      	disk_object_total = get_total_object_values(&objects->disk_sizes);
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_COMMIT_SIZE,
     +				      objects->disk_sizes.commits,
    -+				      repo_structure_concern_thresholds),
    ++				      repo_structure_concern_thresholds,
    ++				      show_concern),
      			      "    * %s", _("Commits"));
      	stats_table_size_addf(table, objects->disk_sizes.trees,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_TREE_SIZE,
     +				      objects->disk_sizes.trees,
    -+				      repo_structure_concern_thresholds),
    ++				      repo_structure_concern_thresholds,
    ++				      show_concern),
      			      "    * %s", _("Trees"));
      	stats_table_size_addf(table, objects->disk_sizes.blobs,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_BLOB_SIZE,
     +				      objects->disk_sizes.blobs,
    -+				      repo_structure_concern_thresholds),
    ++				      repo_structure_concern_thresholds,
    ++				      show_concern),
      			      "    * %s", _("Blobs"));
      	stats_table_size_addf(table, objects->disk_sizes.tags,
     +			      repo_structure_concern_level(
     +				      CONCERN_STAT_TAG_SIZE,
     +				      objects->disk_sizes.tags,
    -+				      repo_structure_concern_thresholds),
    ++				      repo_structure_concern_thresholds,
    ++				      show_concern),
      			      "    * %s", _("Tags"));
      
      	stats_table_addf(table, "");
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
     +				     repo_structure_concern_level(
     +					     CONCERN_STAT_COMMIT_LARGEST,
     +					     objects->largest.commit_size.value,
    -+					     repo_structure_concern_thresholds),
    ++					     repo_structure_concern_thresholds,
    ++					     show_concern),
      				     "    * %s", _("Maximum size"));
      	stats_table_object_count_addf(table,
      				      &objects->largest.parent_count.oid,
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      				     objects->largest.tree_size.value,
     +				     repo_structure_concern_level(
     +					     CONCERN_STAT_TREE_LARGEST,
    -+					     objects->largest.commit_size.value,
    -+					     repo_structure_concern_thresholds),
    ++					     objects->largest.tree_size.value,
    ++					     repo_structure_concern_thresholds,
    ++					     show_concern),
      				     "    * %s", _("Maximum size"));
     +
      	stats_table_object_count_addf(table,
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
     +				     repo_structure_concern_level(
     +					     CONCERN_STAT_BLOB_LARGEST,
     +					     objects->largest.blob_size.value,
    -+					     repo_structure_concern_thresholds),
    ++					     repo_structure_concern_thresholds,
    ++					     show_concern),
      				     "    * %s", _("Maximum size"));
      	stats_table_addf(table, "  * %s", _("Tags"));
      	stats_table_object_size_addf(table,
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
     +				     repo_structure_concern_level(
     +					     CONCERN_STAT_TAG_LARGEST,
     +					     objects->largest.tag_size.value,
    -+					     repo_structure_concern_thresholds),
    ++					     repo_structure_concern_thresholds,
    ++					     show_concern),
      				     "    * %s", _("Maximum size"));
      }
      
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      {
      	const char *name_col_title = _("Repository structure");
      	const char *value_col_title = _("Value");
    -+	const char *concern_col_title = _("Concern");
    - 	int title_name_width = utf8_strwidth(name_col_title);
    - 	int title_value_width = utf8_strwidth(value_col_title);
    -+	int title_concern_width = utf8_strwidth(concern_col_title);
    +@@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table *table)
      	int name_col_width = table->name_col_width;
      	int value_col_width = table->value_col_width;
      	int unit_col_width = table->unit_col_width;
    -+	int concern_col_width = table->concern_col_width;
    ++	const char *concern_col_title = _("Concern");
    ++	const size_t concern_title_width = strlen(concern_col_title);
    ++	size_t concern_col_width = (table->max_concern_value > concern_title_width) ? table->max_concern_value : concern_title_width;
      	struct string_list_item *item;
      	struct strbuf buf = STRBUF_INIT;
     +	struct strbuf concern_str = STRBUF_INIT;
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      	if (title_value_width > value_col_width + unit_col_width + 1)
      		value_col_width = title_value_width - unit_col_width;
     -
    -+	if (show_concern && title_concern_width > concern_col_width)
    -+		concern_col_width = title_concern_width;
      	strbuf_addstr(&buf, "| ");
      	strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width + INDEX_WIDTH,
      			  name_col_title);
    @@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table
     +	printf(" |");
     +	if (show_concern) {
     +		putchar(' ');
    -+		for (int i = 0; i < concern_col_width; i++) {
    ++		for (size_t i = 0; i < concern_col_width; i++) {
     +			putchar('-');
     +		}
     +		printf(" |");
    @@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table
      		printf("%s\n", buf.buf);
      	}
      
    +@@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table *table)
    + 		for_each_string_list_item(item, &table->annotations)
    + 			printf("%s\n", item->string);
    + 	}
    +-
    ++	strbuf_release(&concern_str);
    + 	strbuf_release(&buf);
    + }
    + 
     @@ builtin/repo.c: static void print_object_data(const char *key, char key_delim,
      }
      
    @@ builtin/repo.c: static void print_object_data(const char *key, char key_delim,
      {
      	print_keyvalue("references.branches.count", key_delim,
      		       stats->refs.branches, value_delim);
    -+
    - 	print_keyvalue("references.tags.count", key_delim,
    - 		       stats->refs.tags, value_delim);
    -+
    - 	print_keyvalue("references.remotes.count", key_delim,
    +@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
      		       stats->refs.remotes, value_delim);
      	print_keyvalue("references.others.count", key_delim,
    -@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    - 
    + 		       stats->refs.others, value_delim);
    +-
      	print_keyvalue("objects.commits.count", key_delim,
      		       stats->objects.type_counts.commits, value_delim);
     +	if (show_concern)
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_COMMIT_COUNT,
     +				       stats->objects.type_counts.commits,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			       value_delim);
      	print_keyvalue("objects.trees.count", key_delim,
      		       stats->objects.type_counts.trees, value_delim);
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TREE_COUNT,
     +				       stats->objects.type_counts.trees,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			       value_delim);
      	print_keyvalue("objects.blobs.count", key_delim,
      		       stats->objects.type_counts.blobs, value_delim);
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_BLOB_COUNT,
     +				       stats->objects.type_counts.blobs,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +		 value_delim);
      	print_keyvalue("objects.tags.count", key_delim,
     -		       stats->objects.type_counts.tags, value_delim);
    +-
     +		stats->objects.type_counts.tags, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.tags.count.concern_level", key_delim,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TAG_COUNT,
     +				       stats->objects.type_counts.tags,
    -+				       repo_structure_concern_thresholds),
    -+		 	       value_delim);
    - 
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
    ++			       value_delim);
      	print_keyvalue("objects.commits.inflated_size", key_delim,
     -		       stats->objects.inflated_sizes.commits, value_delim);
     +		stats->objects.inflated_sizes.commits, value_delim);
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_COMMIT_INFLATED_SIZE,
     +				       stats->objects.inflated_sizes.commits,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			       value_delim);
      	print_keyvalue("objects.trees.inflated_size", key_delim,
     -		       stats->objects.inflated_sizes.trees, value_delim);
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
     +	if (show_concern)
     +		print_keyvalue("objects.trees.inflated_size.concern_level", key_delim,
     +			       repo_structure_concern_level(
    -+				       CONCERN_STAT_TREE_INFLATED_SIZE,
    -+				       stats->objects.inflated_sizes.trees,
    -+				       repo_structure_concern_thresholds),
    ++					CONCERN_STAT_TREE_INFLATED_SIZE,
    ++					stats->objects.inflated_sizes.trees,
    ++					repo_structure_concern_thresholds,
    ++					show_concern),
     +			       value_delim);
    -+
      	print_keyvalue("objects.blobs.inflated_size", key_delim,
      		       stats->objects.inflated_sizes.blobs, value_delim);
     +	if (show_concern)
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_BLOB_INFLATED_SIZE,
     +				       stats->objects.inflated_sizes.blobs,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			       value_delim);
      	print_keyvalue("objects.tags.inflated_size", key_delim,
      		       stats->objects.inflated_sizes.tags, value_delim);
    +-
     +	if (show_concern)
     +		print_keyvalue("objects.tags.inflated_size.concern_level", key_delim,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TAG_INFLATED_SIZE,
     +				       stats->objects.inflated_sizes.tags,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			       value_delim);
    - 
      	print_keyvalue("objects.commits.disk_size", key_delim,
      		       stats->objects.disk_sizes.commits, value_delim);
     +	if (show_concern)
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_COMMIT_SIZE,
     +				       stats->objects.disk_sizes.commits,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			       value_delim);
      	print_keyvalue("objects.trees.disk_size", key_delim,
      		       stats->objects.disk_sizes.trees, value_delim);
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TREE_SIZE,
     +				       stats->objects.disk_sizes.trees,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			       value_delim);
      	print_keyvalue("objects.blobs.disk_size", key_delim,
      		       stats->objects.disk_sizes.blobs, value_delim);
     +	if (show_concern)
    -+
     +		print_keyvalue("objects.blobs.disk_size.concern_level", key_delim,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_BLOB_SIZE,
     +				       stats->objects.disk_sizes.blobs,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			      value_delim);
      	print_keyvalue("objects.tags.disk_size", key_delim,
      		       stats->objects.disk_sizes.tags, value_delim);
    +-
     +	if (show_concern)
     +		print_keyvalue("objects.tags.disk_size.concern_level", key_delim,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TAG_SIZE,
     +				       stats->objects.disk_sizes.tags,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			      value_delim);
    - 
      	print_object_data("objects.commits.max_size", key_delim,
      			  &stats->objects.largest.commit_size, value_delim);
     +	if (show_concern)
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_COMMIT_LARGEST,
     +				       stats->objects.largest.commit_size.value,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			       value_delim);
      	print_object_data("objects.trees.max_size", key_delim,
      			  &stats->objects.largest.tree_size, value_delim);
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TREE_LARGEST,
     +				       stats->objects.largest.tree_size.value,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			       value_delim);
      	print_object_data("objects.blobs.max_size", key_delim,
      			  &stats->objects.largest.blob_size, value_delim);
    @@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stat
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_BLOB_LARGEST,
     +				       stats->objects.largest.blob_size.value,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			       value_delim);
      	print_object_data("objects.tags.max_size", key_delim,
     -			  &stats->objects.largest.tag_size, value_delim);
    +-
     +		          &stats->objects.largest.tag_size, value_delim);
     +	if (show_concern)
     +		print_keyvalue("objects.tags.max_size.concern_level", key_delim,
     +			       repo_structure_concern_level(
     +				       CONCERN_STAT_TAG_LARGEST,
     +				       stats->objects.largest.tag_size.value,
    -+				       repo_structure_concern_thresholds),
    ++				       repo_structure_concern_thresholds,
    ++				       show_concern),
     +			       value_delim);
    - 
      	print_object_data("objects.commits.max_parents", key_delim,
      			  &stats->objects.largest.parent_count, value_delim);
    + 	print_object_data("objects.trees.max_entries", key_delim,
    + 			  &stats->objects.largest.tree_entries, value_delim);
    +-
    + 	fflush(stdout);
    + }
    + 
     @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
      	struct repo_structure stats = { 0 };
      	struct rev_info revs;
    @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const
      
      	if (show_progress < 0)
     @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    + 
      	switch (format) {
      	case FORMAT_TABLE:
    - 		stats_table_setup_structure(&table, &stats);
    +-		stats_table_setup_structure(&table, &stats);
     -		stats_table_print_structure(&table);
    ++		stats_table_setup_structure(&table, &stats, show_concern);
     +		stats_table_print_structure(&table, show_concern);
      		break;
      	case FORMAT_NEWLINE_TERMINATED:
    @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const
      	default:
      		BUG("invalid output format");
     
    - ## repo.c (new) ##
    -@@
    -+#include "repo.h"
    -
      ## t/t1901-repo-structure.sh ##
     @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
    + 		|   * Tags                  |        |
    + 		|     * Maximum size        |    0 B |
      		EOF
    - 
    +-
      		git repo structure >out 2>err &&
    -+		cp out /tmp/test1-out &&
      
      		test_cmp expect out &&
    - 		test_line_count = 0 err
2:  2c1395b6f0 ! 2:  0a3b6415ec repo: make concern thresholds configurable
    @@ Documentation/config/repo.adoc (new)
     +	of all inflated tags.
     +
     +`repo.concern.commit-largest`::
    -+	Sets the value of the concern threshold the size of the largest
    ++	Sets the value of the concern threshold for the size of the largest
     +	commit.
     +
     +`repo.concern.tree-largest`::
    @@ Documentation/config/repo.adoc (new)
     +	Sets the value of the concern threshold for the size of the
     +	largest tag.
     +
    -+All of the concern thresholds are integer values for the
    -+floor of the base-2 log of the threshold value. The default values
    -+of each threshold are set to heuristically determined values.
    ++Thresholds are actually computed using log values. But for human convenience,
    ++they're set as integer values. If the integer value supplied isn't a power of
    ++two, the actual value will be rounded to the nearest power of two. For example,
    ++if the value in the configuration setting is 80,000, the actual threshold will
    ++be set to 65536; if instead, the value from the configuration was set to
    ++100,000, the threshold will be set to 131,072.
    ++
     
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: statistic value. The value is considered concerning if it exceeds a heuristicall
    @@ Documentation/git-repo.adoc: using the `nul` format:
      linkgit:git-rev-parse[1]
     
      ## builtin/repo.c ##
    -@@
    - 
    - #include "builtin.h"
    - #include "commit.h"
    -+#include "config.h"
    - #include "environment.h"
    - #include "hash.h"
    - #include "hex.h"
    -@@
    - #define REPO_STRUCTURE_USAGE \
    - 	"git repo structure [--format=(table|lines|nul) | -z] [--[no-]concern]"
    - 
    -+#define REPO_STRUCTURE_CONFIG_PREFIX "repo.concern."
    -+
    - static const char *const repo_usage[] = {
    - 	REPO_INFO_USAGE,
    - 	REPO_STRUCTURE_USAGE,
    -@@ builtin/repo.c: static size_t repo_structure_concern_level(const char* concern_name,
    - 		return 0;
    +@@ builtin/repo.c: static int repo_structure_concern_level(const char *concern_name,
    + 		const int threshold = get_concern_threshold(concern_name, thresholds);
    + 		if (threshold < 0)
    + 			BUG("unexpected repository stat threshold: '%s'", concern_name);
    ++		if (!threshold)
    ++			return 0;
    + 		log_value = (size_t)log2u(value);
    + 		if (log_value > (size_t)threshold)
    + 			return log_value - threshold;
    +@@ builtin/repo.c: static int repo_structure_concern_level(const char *concern_name,
    + 	}
      }
      
    ++/*
    ++ * To make configuring thresholds as intuitive as possible, we set the
    ++ * internal threshold value to the _nearest_ power of two to the value
    ++ * the user specified. So if they set a threshold to 500, we should use
    ++ * a log value of 9, but log2u would return 8.
    ++ *
    ++ * A threshold value of 0 means "never flag concerns for this stat".
    ++ */
    ++static size_t nearest_log2_value(size_t v)
    ++{
    ++	size_t logval, power_of_two_floor, mid;
    ++	if (!v)
    ++		return 0;
    ++	logval = (size_t)log2u(v);
    ++	power_of_two_floor = (size_t)1 << logval;
    ++	mid = (power_of_two_floor + (power_of_two_floor << 1)) / 2;
    ++	return (v <= mid) ? logval : (logval + 1);
    ++}
    ++
     +/*
     + * Concern thresholds aren't universal. We try to set reasonable default
     + * values, but projects may want to set these thresholds differently. To
     + * support that, they can set the thresholds for their project in the
    -+ * project's git config, in the section "repo.structure.concern".
    -+  */
    -+static int config_concern_thresholds(const char *prefixed_var,
    ++ * project's git config, in the section "repo.concern".
    ++ *
    ++ * This is used by repo_config; the call site is guarded by show_concern,
    ++ * so the global threshold array is only modified when --concern is requested,
    ++ * and that will happen at most once.
    ++ */
    ++static int config_concern_thresholds(const char *config_val_name,
     +				     const char *str_val,
     +				     const struct config_context *ctx,
     +				     void *cb)
     +{
     +	struct concern_stat_threshold *thresholds = cb;
    -+	if (starts_with(prefixed_var, REPO_STRUCTURE_CONFIG_PREFIX)) {
    -+		const char *concern_name = &prefixed_var[strlen(REPO_STRUCTURE_CONFIG_PREFIX)];
    ++	const char *concern_name;
    ++	if (skip_prefix(config_val_name, REPO_STRUCTURE_CONFIG_PREFIX, &concern_name)) {
     +		for (int i = 0; thresholds[i].name; i++) {
     +			if (!strcmp(thresholds[i].name, concern_name)) {
    -+				int value = git_config_int(prefixed_var, str_val, ctx->kvi);
    -+				if (value < 0)
    -+					return -1;
    -+				thresholds[i].threshold = value;
    ++				int threshold = git_config_int(concern_name, str_val, ctx->kvi);
    ++				if (threshold < 0) {
    ++					warning(_("invalid concern threshold '%d': value must be 0 or more"),
    ++						threshold);
    ++					return 0;
    ++				}
    ++				thresholds[i].threshold = nearest_log2_value(threshold);
     +				return 0;
     +			}
     +		}
    -+		warning(_("Invalid concern threshold name: '%s'"), concern_name);
    -+		return 0;
    ++		warning(_("invalid concern threshold name: '%s'"), concern_name);
     +	}
     +	return 0;
     +}
    @@ builtin/repo.c: static size_t repo_structure_concern_level(const char* concern_n
      /*
       * Holds column data that gets stored for each row.
       */
    -@@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table *table,
    - 			strbuf_utf8_align(&buf, ALIGN_LEFT, concern_col_width, concern_str.buf);
    - 			strbuf_addstr(&buf, " |");
    - 		}
    -+		strbuf_release(&concern_str);
    - 		printf("%s\n", buf.buf);
    - 	}
    - 
    -@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
    - 				       stats->objects.largest.tag_size.value,
    - 				       repo_structure_concern_thresholds),
    - 			       value_delim);
    --
    - 	print_object_data("objects.commits.max_parents", key_delim,
    - 			  &stats->objects.largest.parent_count, value_delim);
    - 	print_object_data("objects.trees.max_entries", key_delim,
     @@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
      		usage(_("too many arguments"));
      	repo_init_revisions(repo, &revs, prefix);
      
     +	if (show_concern)
    -+                repo_config(repo, &config_concern_thresholds, &repo_structure_concern_thresholds);
    -+
    ++		repo_config(repo, &config_concern_thresholds,
    ++			    &repo_structure_concern_thresholds);
     +
      	if (show_progress < 0)
      		show_progress = isatty(2);
      
     
      ## t/t1901-repo-structure.sh ##
    -@@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
    - 		EOF
    - 
    - 		git repo structure >out 2>err &&
    --		cp out /tmp/test1-out &&
    - 
    - 		test_cmp expect out &&
    - 		test_line_count = 0 err
     @@ t/t1901-repo-structure.sh: test_expect_success SHA1 'repository with references and objects' '
      	)
      '
    @@ t/t1901-repo-structure.sh: test_expect_success SHA1 'repository with references
     +		# test to fail; so we just turn it off.
     +		git config core.compression 0 &&
     +		# configure thresholds to get concern indications
    -+		git config repo.concern.commit-count 7 &&
    -+		git config repo.concern.commit-size 14 &&
    -+		git config repo.concern.tree-size 10 &&
    -+		git config repo.concern.blob-size 8 &&
    -+		git config repo.concern.blob-inflated-size 10 &&
    -+		git config repo.concern.tag-size 2 &&
    -+		git config repo.concern.commit-largest 4 &&
    -+		git config repo.concern.blob-largest 2 &&
    ++		git config repo.concern.commit-count 120 &&
    ++		git config repo.concern.commit-size 16384 &&
    ++		git config repo.concern.tree-size 1024 &&
    ++		git config repo.concern.blob-size 256 &&
    ++		git config repo.concern.blob-inflated-size 1024 &&
    ++		git config repo.concern.tag-size 4 &&
    ++		git config repo.concern.commit-largest 16 &&
    ++		git config repo.concern.blob-largest 4 &&
     +		test_commit_bulk 1005 &&
     +		git tag -a foo -m bar &&
     +		oid="$(git rev-parse HEAD)" &&
    @@ t/t1901-repo-structure.sh: test_expect_success SHA1 'lines and nul format' '
     +		cd repo &&
     +		# configure thresholds to get concern indications
     +		git config core.compression 0 &&
    -+		git config repo.concern.commit-count 7 &&
    -+		git config repo.concern.commit-size 14 &&
    -+		git config repo.concern.tree-size 10 &&
    -+		git config repo.concern.blob-size 8 &&
    -+		git config repo.concern.blob-inflated-size 10 &&
    -+		git config repo.concern.tag-size 2 &&
    -+		git config repo.concern.commit-largest 4 &&
    -+		git config repo.concern.blob-largest 2 &&
    ++		git config repo.concern.commit-count 100 &&
    ++		git config repo.concern.commit-size 16384 &&
    ++		git config repo.concern.tree-size 1024 &&
    ++		git config repo.concern.blob-size 256 &&
    ++		git config repo.concern.blob-inflated-size 1024 &&
    ++		git config repo.concern.tag-size 4 &&
    ++		git config repo.concern.commit-largest 16 &&
    ++		git config repo.concern.blob-largest 4 &&
     +		touch configured &&
     +		test_commit_bulk 1005 &&
     +		git tag -a foo -m bar &&

---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20261019-b4-repo-structure-concern-f1d6f6326095

