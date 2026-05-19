Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37CA4A138C
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207909; cv=none; b=ui4jdkvgYtzKqmEEEhRpclsfUZnJOwo1Fs+VRGbJl1UZMt/o6MKmurQ4OisJv3BuTS9WfZaamvnOdZFWFVejubJxJ/e5PjOuRu58bvWthaV4tbAmAlxY4EXByfbB4zO3sP3l25gxZkjR1Zit/4/JF6zigEYfICNhuifQ971vGss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207909; c=relaxed/simple;
	bh=IxO4UPFccDyyNy2EQW140ZVKSI4+GG5kMElPWijk6Xk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=shj+zBPncEVL17etyMTq38nA5d8n28rGPsIRZIo4Nk8Fpe1Cd80RYOFEyVTulq+wLcrdZWkL+O+D0S3ErBuHcwT+tlngDo5Qjb/0VIP5U5f8tGIKuHirPGuw935fwcDS/sTvjooVYW6+YOiy4Dk9//9Zbd0T903NIaeLDC+UA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QI+g2NYq; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI+g2NYq"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30246cfd41aso9798eec.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779207906; x=1779812706; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbF+V98m9Wvy3TBli5FEJcQp6eQHIAknulhiAGo2wBw=;
        b=QI+g2NYq/ZX6wBeBnyJ6Qso1VrZQeFfsTJDkptjgEAx447GSZ5re+h/OT01aocKs/W
         HgCsHI9AgYyfn/oAkBlcsEpXd06pNIpHEZuTCrVPbN78D7p0ERbdB4rziPoegOIULkAL
         dHrb3LiaiHQ1bHBVLGqcl8Njg2crec4cqLbpco5wGTCToSgPkAslLnSg4a08c8G/OYal
         bSXZWMfXN6/P5tepcYTQnZa4MLZVIKSvdyHwrEl+6LZ09EkIo6S90BUd1GmyqwaUsEG0
         +3B5jJiW5ygiFwdRvEOYojDWY0cTJgzj/XWUw8Z4ApQvwqBnh3LqOUk327Jy4tBY4TjY
         HxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207906; x=1779812706;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbF+V98m9Wvy3TBli5FEJcQp6eQHIAknulhiAGo2wBw=;
        b=N2CZrkGqURDuCZb+c9DKB7Ext/BJ4HMZODrNu2AVTGiEHagEYfRVuFoTT9fJ+M3uAz
         yeQjyfW50m+/GxfenpJYMrND1X78VE/vwOL6h7r4lwnix5732Y4dJi70L7q+AjqwbO5I
         YFwNp4YgyeiMvEdAluHXerxYcPAu6S/lnsTDImAEx7gOY07efdpxQ98xue3hFU/WkT8x
         bWGma3EjYE6BlMgZ5TrOMWhZtV1Aio4TAOdLgLDSiJrUarsEoXAIPBDie0pUjgCaQ7xf
         tMAOOgR4y6ohM7bEWeOVVKnuje4dbvHkahfJrIbTFJta+9dtMam1CE5ETegf8Nku6O7y
         NtVw==
X-Gm-Message-State: AOJu0YwFUAt66hIy5GI8/CmqQ/elQP7nVp3yPYx77kRkVd1kDFRbQYF+
	q7dKhienRhIm7pYLk943HC8L41AOD0eQ/+JiqwjGrfcaUu2+tSPOgfXR5dbtaw==
X-Gm-Gg: Acq92OHiWJVE2Pj0klL6IAfp1QtNSc2iaCnwY5vNJmR3vTJjaHYNHQBHoFjbDwuDuFk
	6ImUyfI6KNjzMQhyYptePHcXFwHqwwBnn509++jYg5F4BPTryoZhHgSN6FdgeHtkQVHUMrwgP6W
	4WFYjM9hGjqMnkQ3wsoQYjUxC2IfZTMBZvPh+HF1s3QDKAPKz6+3k5l27EGtTRyA8lEtnR7RKYE
	m4qHPQPqTUmfUQYhRXGy0XEYDYxFo5KfY0E5zwOqpgeyFeuKKJy1kItL5ZedF4a68fr64hLW39a
	hnHzWAZSct7NKgfwbI7SpFC2ScOebYlVuGrV2fFArAYQDnWR+bOV47p3HQSTBj/WWbQTOy2t3RT
	ixrHBjNnlFK7GZHTte/zbRQu7Yefg2ciVixM5rXP5MTpSL5KRaXcaYBQa5ZE5HugN7LFW5DKWhZ
	uH6NbLvWBEo5ohyre0kunvGugu4ZAb
X-Received: by 2002:a05:7300:dc97:b0:2dd:6937:79bc with SMTP id 5a478bee46e88-3039818a666mr10069745eec.6.1779207905749;
        Tue, 19 May 2026 09:25:05 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm19672340eec.5.2026.05.19.09.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:25:05 -0700 (PDT)
Message-Id: <62e5ef1a4b800cb18b2e934f45303095d545613b.1779207896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
References: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
	<pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 16:24:53 +0000
Subject: [PATCH v6 6/8] fetch: add --negotiation-include option for
 negotiation
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new --negotiation-include option to 'git fetch', which ensures
that certain ref tips are always sent as 'have' lines during fetch
negotiation, regardless of what the negotiation algorithm selects.

This is useful when the repository has a large number of references, so
the normal negotiation algorithm truncates the list. This is especially
important in repositories with long parallel commit histories. For
example, a repo could have a 'dev' branch for development and a
'release' branch for released versions. If the 'dev' branch isn't
selected for negotiation, then it's not a big deal because there are
many in-progress development branches with a shared history. However, if
'release' is not selected for negotiation, then the server may think
that this is the first time the client has asked for that reference,
causing a full download of its parallel commit history (and any extra
data that may be unique to that branch). This is based on a real example
where certain fetches would grow to 60+ GB when a release branch
updated.

This option is a complement to --negotiation-restrict, which reduces the
negotiation ref set to a specific list. In the earlier example, using
--negotiation-restrict to focus the negotiation to 'dev' and 'release'
would avoid those problematic downloads, but would still not allow
advertising potentially-relevant user branches. In this way, the
'include' version solves the problem I mention while allowing
negotiation to pick other references opportunistically. The two options
can also be combined to allow the best of both worlds.

The argument may be an exact ref name or a glob pattern. Non-existent
refs are silently ignored. This behavior is also updated in the ref matching
logic for the related --negotiation-restrict option to match.

The implementation outputs the requested objects as haves before the
negotiator performs its own algorithm to choose the next haves. Use the new
have_sent() interface to signal these have commits were sent before engaging
with the negotiator's next() iterator.

Also add --negotiation-include to 'git pull' passthrough options.

Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/fetch-options.adoc | 19 +++++++
 builtin/fetch.c                  | 38 ++++++++++---
 builtin/pull.c                   |  3 ++
 fetch-pack.c                     | 81 +++++++++++++++++++++++++---
 fetch-pack.h                     |  6 ++-
 t/t5510-fetch.sh                 | 91 ++++++++++++++++++++++++++++++++
 transport.c                      |  8 ++-
 transport.h                      |  5 +-
 8 files changed, 232 insertions(+), 19 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index d39cecb446..7b897a7202 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -73,6 +73,25 @@ See also the `fetch.negotiationAlgorithm` and `push.negotiate`
 configuration variables documented in linkgit:git-config[1], and the
 `--negotiate-only` option below.
 
+`--negotiation-include=(<commit>|<glob>)`::
+	Ensure that the commits at the given tips are always sent as "have"
+	lines during fetch negotiation, regardless of what the negotiation
+	algorithm selects.  This is useful to guarantee that common
+	history reachable from specific refs is always considered, even
+	when `--negotiation-restrict` restricts the set of tips or when
+	the negotiation algorithm would otherwise skip them.
++
+This option may be specified more than once; if so, each commit is sent
+unconditionally.
++
+The argument may be an exact ref name (e.g. `refs/heads/release`), an
+object hash, or a glob pattern (e.g. `refs/heads/release/{asterisk}`).
+The pattern syntax is the same as for `--negotiation-restrict`.
++
+If `--negotiation-restrict` is used, the have set is first restricted by
+that option and then increased to include the tips specified by
+`--negotiation-include`.
+
 `--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
 	ancestors of the provided `--negotiation-restrict=` arguments,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a957739f37..ba56e9022b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -99,6 +99,7 @@ static struct transport *gsecondary;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_restrict = STRING_LIST_INIT_NODUP;
+static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
@@ -1534,23 +1535,29 @@ static int add_oid(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-static void add_negotiation_restrict_tips(struct git_transport_options *smart_options)
+static void add_negotiation_tips(struct string_list *input_list,
+				 struct oid_array **output_list,
+				 const char *argname)
 {
 	struct oid_array *oids = xcalloc(1, sizeof(*oids));
 	int i;
 
-	for (i = 0; i < negotiation_restrict.nr; i++) {
-		const char *s = negotiation_restrict.items[i].string;
+	for (i = 0; i < input_list->nr; i++) {
+		const char *s = input_list->items[i].string;
 		struct refs_for_each_ref_options opts = {
 			.pattern = s,
 		};
 		int old_nr;
 		if (!has_glob_specials(s)) {
 			struct object_id oid;
+
+			/* Ignore missing reference. */
 			if (repo_get_oid(the_repository, s, &oid))
-				die(_("%s is not a valid object"), s);
+				continue;
+			/* Fail on missing object pointed by ref. */
 			if (!odb_has_object(the_repository->objects, &oid, 0))
 				die(_("the object %s does not exist"), s);
+
 			oid_array_append(oids, &oid);
 			continue;
 		}
@@ -1559,9 +1566,9 @@ static void add_negotiation_restrict_tips(struct git_transport_options *smart_op
 				      add_oid, oids, &opts);
 		if (old_nr == oids->nr)
 			warning(_("ignoring %s=%s because it does not match any refs"),
-				"--negotiation-restrict", s);
+				argname, s);
 	}
-	smart_options->negotiation_restrict_tips = oids;
+	*output_list = oids;
 }
 
 static struct transport *prepare_transport(struct remote *remote, int deepen,
@@ -1597,7 +1604,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 	}
 	if (negotiation_restrict.nr) {
 		if (transport->smart_options)
-			add_negotiation_restrict_tips(transport->smart_options);
+			add_negotiation_tips(&negotiation_restrict,
+					     &transport->smart_options->negotiation_restrict_tips,
+					     "--negotiation-restrict");
 		else
 			warning(_("ignoring %s because the protocol does not support it"),
 				"--negotiation-restrict");
@@ -1606,7 +1615,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		for_each_string_list_item(item, &remote->negotiation_restrict)
 			string_list_append(&negotiation_restrict, item->string);
 		if (transport->smart_options)
-			add_negotiation_restrict_tips(transport->smart_options);
+			add_negotiation_tips(&negotiation_restrict,
+					     &transport->smart_options->negotiation_restrict_tips,
+					     "--negotiation-restrict");
 		else {
 			struct strbuf config_name = STRBUF_INIT;
 			strbuf_addf(&config_name, "remote.%s.negotiationRestrict", remote->name);
@@ -1615,6 +1626,15 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 			strbuf_release(&config_name);
 		}
 	}
+	if (negotiation_include.nr) {
+		if (transport->smart_options)
+			add_negotiation_tips(&negotiation_include,
+					     &transport->smart_options->negotiation_include_tips,
+					     "--negotiation-include");
+		else
+			warning(_("ignoring %s because the protocol does not support it"),
+				"--negotiation-include");
+	}
 	return transport;
 }
 
@@ -2582,6 +2602,8 @@ int cmd_fetch(int argc,
 		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_restrict, N_("revision"),
 				N_("report that we have only objects reachable from this object")),
 		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
+		OPT_STRING_LIST(0, "negotiation-include", &negotiation_include, N_("revision"),
+				N_("ensure this ref is always sent as a negotiation have")),
 		OPT_BOOL(0, "negotiate-only", &negotiate_only,
 			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
diff --git a/builtin/pull.c b/builtin/pull.c
index cc6ce485fc..d49b09114a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1000,6 +1000,9 @@ int cmd_pull(int argc,
 			N_("report that we have only objects reachable from this object"),
 			0),
 		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
+		OPT_PASSTHRU_ARGV(0, "negotiation-include", &opt_fetch, N_("revision"),
+			N_("ensure this ref is always sent as a negotiation have"),
+			0),
 		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
 			 N_("check for forced-updates on all updated branches")),
 		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
diff --git a/fetch-pack.c b/fetch-pack.c
index baf239adf9..96071434b8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -25,6 +25,7 @@
 #include "oidset.h"
 #include "packfile.h"
 #include "odb.h"
+#include "object-name.h"
 #include "path.h"
 #include "connected.h"
 #include "fetch-negotiator.h"
@@ -332,6 +333,21 @@ static void send_filter(struct fetch_pack_args *args,
 	}
 }
 
+static void add_oids_to_set(const struct oid_array *array,
+			    struct oidset *set)
+{
+	if (!array)
+		return;
+
+	for (size_t i = 0; i < array->nr; i++) {
+		struct object_id *oid = &array->oid[i];
+		if (!odb_has_object(the_repository->objects, oid, 0))
+			die(_("the object %s does not exist"), oid_to_hex(oid));
+
+		oidset_insert(set, oid);
+	}
+}
+
 static int find_common(struct fetch_negotiator *negotiator,
 		       struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
@@ -347,6 +363,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	struct strbuf req_buf = STRBUF_INIT;
 	size_t state_len = 0;
 	struct packet_reader reader;
+	struct oidset negotiation_include_oids = OIDSET_INIT;
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
@@ -474,6 +491,27 @@ static int find_common(struct fetch_negotiator *negotiator,
 	trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
 	flushes = 0;
 	retval = -1;
+
+	/* Send unconditional haves from --negotiation-include */
+	add_oids_to_set(args->negotiation_include_tips,
+			&negotiation_include_oids);
+	if (oidset_size(&negotiation_include_oids)) {
+		struct oidset_iter iter;
+		oidset_iter_init(&negotiation_include_oids, &iter);
+
+		while ((oid = oidset_iter_next(&iter))) {
+			struct commit *commit;
+			packet_buf_write(&req_buf, "have %s\n",
+					 oid_to_hex(oid));
+			print_verbose(args, "have %s", oid_to_hex(oid));
+			count++;
+
+			commit = lookup_commit(the_repository, oid);
+			if (commit)
+				negotiator->have_sent(negotiator, commit);
+		}
+	}
+
 	while ((oid = negotiator->next(negotiator))) {
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
@@ -584,6 +622,7 @@ done:
 		flushes++;
 	}
 	strbuf_release(&req_buf);
+	oidset_clear(&negotiation_include_oids);
 
 	if (!got_ready || !no_done)
 		consume_shallow_list(args, &reader);
@@ -1305,11 +1344,27 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
 
 static int add_haves(struct fetch_negotiator *negotiator,
 		     struct strbuf *req_buf,
-		     int *haves_to_send)
+		     int *haves_to_send,
+		     struct oidset *negotiation_include_oids)
 {
 	int haves_added = 0;
 	const struct object_id *oid;
 
+	/* Send unconditional haves from --negotiation-include */
+	if (negotiation_include_oids) {
+		struct oidset_iter iter;
+		oidset_iter_init(negotiation_include_oids, &iter);
+
+		while ((oid = oidset_iter_next(&iter))) {
+			struct commit *commit = lookup_commit(the_repository, oid);
+			if (commit) {
+				packet_buf_write(req_buf, "have %s\n",
+						 oid_to_hex(oid));
+				negotiator->have_sent(negotiator, commit);
+			}
+		}
+	}
+
 	while ((oid = negotiator->next(negotiator))) {
 		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
 		if (++haves_added >= *haves_to_send)
@@ -1358,7 +1413,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain,
-			      int sideband_all, int seen_ack)
+			      int sideband_all, int seen_ack,
+			      struct oidset *negotiation_include_oids)
 {
 	int haves_added;
 	int done_sent = 0;
@@ -1413,7 +1469,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	/* Add all of the common commits we've found in previous rounds */
 	add_common(&req_buf, common);
 
-	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
+	haves_added = add_haves(negotiator, &req_buf, haves_to_send,
+			       negotiation_include_oids);
 	*in_vain += haves_added;
 	trace2_data_intmax("negotiation_v2", the_repository, "haves_added", haves_added);
 	trace2_data_intmax("negotiation_v2", the_repository, "in_vain", *in_vain);
@@ -1657,6 +1714,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct ref *ref = copy_ref_list(orig_ref);
 	enum fetch_state state = FETCH_CHECK_LOCAL;
 	struct oidset common = OIDSET_INIT;
+	struct oidset negotiation_include_oids = OIDSET_INIT;
 	struct packet_reader reader;
 	int in_vain = 0, negotiation_started = 0;
 	int negotiation_round = 0;
@@ -1729,6 +1787,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				state = FETCH_SEND_REQUEST;
 
 			mark_tips(negotiator, args->negotiation_restrict_tips);
+			add_oids_to_set(args->negotiation_include_tips,
+					&negotiation_include_oids);
 			for_each_cached_alternate(negotiator,
 						  insert_one_alternate_object);
 			break;
@@ -1747,7 +1807,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 					       &common,
 					       &haves_to_send, &in_vain,
 					       reader.use_sideband,
-					       seen_ack)) {
+					       seen_ack,
+					       &negotiation_include_oids)) {
 				trace2_region_leave_printf("negotiation_v2", "round",
 							   the_repository, "%d",
 							   negotiation_round);
@@ -1883,6 +1944,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		negotiator->release(negotiator);
 
 	oidset_clear(&common);
+	oidset_clear(&negotiation_include_oids);
 	return ref;
 }
 
@@ -2181,12 +2243,14 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 			   const struct string_list *server_options,
 			   int stateless_rpc,
 			   int fd[],
-			   struct oidset *acked_commits)
+			   struct oidset *acked_commits,
+			   const struct oid_array *negotiation_include_tips)
 {
 	struct fetch_negotiator negotiator;
 	struct packet_reader reader;
 	struct object_array nt_object_array = OBJECT_ARRAY_INIT;
 	struct strbuf req_buf = STRBUF_INIT;
+	struct oidset negotiation_include_oids = OIDSET_INIT;
 	int haves_to_send = INITIAL_FLUSH;
 	int in_vain = 0;
 	int seen_ack = 0;
@@ -2197,6 +2261,9 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 	fetch_negotiator_init(the_repository, &negotiator);
 	mark_tips(&negotiator, negotiation_restrict_tips);
 
+	add_oids_to_set(negotiation_include_tips,
+			&negotiation_include_oids);
+
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
@@ -2221,7 +2288,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send);
+		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send,
+				       &negotiation_include_oids);
 		in_vain += haves_added;
 		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
 			last_iteration = 1;
@@ -2273,6 +2341,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 
 	clear_common_flag(acked_commits);
 	object_array_clear(&nt_object_array);
+	oidset_clear(&negotiation_include_oids);
 	negotiator.release(&negotiator);
 	strbuf_release(&req_buf);
 }
diff --git a/fetch-pack.h b/fetch-pack.h
index 6c70c942c2..6d0dec7f41 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -19,9 +19,10 @@ struct fetch_pack_args {
 
 	/*
 	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
-	 * lines only with these tips and their ancestors.
+	 * lines for all _include_ tips and then a subset of the _restrict_ tips.
 	 */
 	const struct oid_array *negotiation_restrict_tips;
+	const struct oid_array *negotiation_include_tips;
 
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
@@ -93,7 +94,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 			   const struct string_list *server_options,
 			   int stateless_rpc,
 			   int fd[],
-			   struct oidset *acked_commits);
+			   struct oidset *acked_commits,
+			   const struct oid_array *negotiation_include_tips);
 
 /*
  * Print an appropriate error message for each sought ref that wasn't
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index eff3ce8e2d..bc2e2af959 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1460,6 +1460,16 @@ EOF
 	test_cmp fatal-expect fatal-actual
 '
 
+test_expect_success '--negotiation-tip ignores missing refs and invalid hashes' '
+	setup_negotiation_tip server server 0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=alpha_1 --negotiation-tip=beta_1 \
+		--negotiation-tip=no-such-ref \
+		--negotiation-tip=invalid-hash \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
 test_expect_success '--negotiation-restrict limits "have" lines sent' '
 	setup_negotiation_tip server server 0 &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
@@ -1511,6 +1521,87 @@ test_expect_success 'CLI --negotiation-restrict overrides remote config' '
 	test_grep ! "fetch> have $BETA_1" trace
 '
 
+test_expect_success '--negotiation-include includes configured refs as haves' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-include=refs/tags/beta_1 \
+		origin alpha_s beta_s &&
+
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	test_grep "fetch> have $ALPHA_1" trace &&
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace
+'
+
+test_expect_success '--negotiation-include works with glob patterns' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-include="refs/tags/beta_*" \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace &&
+	BETA_2=$(git -C client rev-parse beta_2) &&
+	test_grep "fetch> have $BETA_2" trace
+'
+
+test_expect_success '--negotiation-include is additive with negotiation' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-include=refs/tags/beta_1 \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace
+'
+
+test_expect_success '--negotiation-include ignores non-existent refs silently' '
+	setup_negotiation_tip server server 0 &&
+
+	git -C client fetch --quiet \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-include=refs/tags/nonexistent \
+		origin alpha_s beta_s 2>err &&
+	test_must_be_empty err
+'
+
+test_expect_success '--negotiation-include avoids duplicates with negotiator' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-include=refs/tags/alpha_1 \
+		origin alpha_s beta_s &&
+
+	test_grep "fetch> have $ALPHA_1" trace >matches &&
+	test_line_count = 1 matches
+'
+
+test_expect_success '--negotiation-include avoids duplicates with v0' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+		-c protocol.version=0 fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-include=refs/tags/alpha_1 \
+		origin alpha_s beta_s &&
+
+	test_grep "fetch> have $ALPHA_1" trace >matches &&
+	test_line_count = 1 matches
+'
+
 test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
 	git init df-conflict &&
 	(
diff --git a/transport.c b/transport.c
index a3051f6733..fa54928966 100644
--- a/transport.c
+++ b/transport.c
@@ -464,6 +464,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
 	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
+	args.negotiation_include_tips = data->options.negotiation_include_tips;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
 
 	if (!data->finished_handshake) {
@@ -495,7 +496,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 					      transport->server_options,
 					      transport->stateless_rpc,
 					      data->fd,
-					      data->options.acked_commits);
+					      data->options.acked_commits,
+					      data->options.negotiation_include_tips);
 			ret = 0;
 		}
 		goto cleanup;
@@ -983,6 +985,10 @@ static int disconnect_git(struct transport *transport)
 		oid_array_clear(data->options.negotiation_restrict_tips);
 		free(data->options.negotiation_restrict_tips);
 	}
+	if (data->options.negotiation_include_tips) {
+		oid_array_clear(data->options.negotiation_include_tips);
+		free(data->options.negotiation_include_tips);
+	}
 	list_objects_filter_release(&data->options.filter_options);
 	oid_array_clear(&data->extra_have);
 	oid_array_clear(&data->shallow);
diff --git a/transport.h b/transport.h
index cdeb33c16f..97d905ecc0 100644
--- a/transport.h
+++ b/transport.h
@@ -40,13 +40,14 @@ struct git_transport_options {
 
 	/*
 	 * This is only used during fetch. See the documentation of
-	 * negotiation_restrict_tips in struct fetch_pack_args.
+	 * these member names in struct fetch_pack_args.
 	 *
-	 * This field is only supported by transports that support connect or
+	 * These fields are only supported by transports that support connect or
 	 * stateless_connect. Set this field directly instead of using
 	 * transport_set_option().
 	 */
 	struct oid_array *negotiation_restrict_tips;
+	struct oid_array *negotiation_include_tips;
 
 	/*
 	 * If allocated, whenever transport_fetch_refs() is called, add known
-- 
gitgitgadget

