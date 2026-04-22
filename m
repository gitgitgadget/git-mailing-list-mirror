Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC426B2DA
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871563; cv=none; b=QAWlef0dP6iIbzkxHOA36TzssibvUfttJarb477mCCItdwqYkzG96TfiAmxsNFPcUDae+aw/f06UIzeVEiDsKZAkJo04ldHqecABbNtUcSqFl3OVA0GrpWLxymPK/Z7fR+zU2jSmI4nXI9+DSMbCNKMRf7MC8lcM0GeOoZqujwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871563; c=relaxed/simple;
	bh=CeR22isZL/D8cMZNVRuthnBL/foZyPFNyHGFfHNMmMY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CDDPsYwczhr9CVEzSWvBcifUfFl7kUSl8znW9filW/xn0HEHe+Y5tzOPROmTDuP3/Np3nZfrHG3rYaxzOOezH5QCP0Qra5X1FPqrk6mb3/g990vt0hkB4YhF2KDLIgnG8G1Okny/6A3iT/0U6Fu+VE/FaHJrvLUPbljYQEok0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaU+7Y9E; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaU+7Y9E"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so5333817eec.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871557; x=1777476357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SL8/e23cxy4VmTDP24+6w9HbeYv1JPiSShfpJSgy0XM=;
        b=WaU+7Y9EBwp7C+HJ3h1CmNaqwFhpS4OtsJwyO2vSDplKmsbTkYgYwWvfxrV4txy+Q8
         94Gi7dERqmR2F/P/nguD2GA8+GfOwOs+WLhRa5yUh5PfDBEp+8P2uSRGeJBbZ7JaS/nL
         Pr3ely8Hhok9Dq5n4N3TRZ0h0zJg7ei53GpcD1bHtx+iv+G+lRR5w2bVNmScflZDdnZi
         8DNktGJsDA7T3uxpFTeBttgLJb9A5jg4U97McRw3SFkFs7F3tjndiYgSCrE315gTB3M7
         NTw4Gu+sW1GQ0X98Wx5hydv0TtcQvqf39CWaq6QmsnyLwAtyPIB2u5wSSKzn+khO55J/
         9eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871557; x=1777476357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SL8/e23cxy4VmTDP24+6w9HbeYv1JPiSShfpJSgy0XM=;
        b=CUrcWXU1sgBLjL+sckE4tq8/0aDdi/XkftoKwzezM7BuvxArKAWgOEkSX9330rz96a
         zEzlZRM/khivdHVQy7TUlwfO89yjHzQuZZ+3l9gAzWHFt8iVU//fxnqNMDWnWn1goc9k
         U6s/yO1b3H8fnPTTqCDAgSVZ6mOj7s1lQA6dSG5fF2/HVQ9HeC1i65IIbIfijySj5qNN
         bFM855fF1bLPS8pCZhid1pR+3lZFkpkGCc9fAAw5BWNxz888od5ADy8gm5jJU0y4SsQG
         vzyzcH6BjkbNPE93Te5qf9BDOf6qRZCMh75W2k2kkkJT0MBn23T3nc6ON8zwuc28sGAY
         sF/A==
X-Gm-Message-State: AOJu0YypCWXo+3X3q4tVGTMq3Xjp5IP1SqMATh4zy2tLg63QpkCMsbZz
	ObSvZSbf21hgtwQleKGEk/RG+jyAwwP8wrDzHY2NN6NXG7lttYVo7Upg4KOJTw==
X-Gm-Gg: AeBDiet+Tfqr73yBvdpCwpeHPpVyPs4E/QOnAyRBsM0GIvOzZ+iNFTt1jxWYPaQUljA
	F/CJmNfNXMAXObLYEbeG8vdLlyqrVAEEWIzrnM8l39asQdL5HOroCcObFBpc779PeuqXDeE8Nik
	tmDBSOcf42vBZe1gwiUZ7CnO0Ddt9+Z5cXWHT3rJN1GfRD7yO7U0eRHaOEUslV1xkLaIlbqrb0t
	mm/x71sZ7Au8o2mdvwACQ2RgFk5vF609BUWR1Qsxw6jKyJCcRIOryMOl7enN4jwCkTtnzFCBGv2
	3Dis4ys/zFUO1C8DxBzds5HCJXMaLhJ1kHK5iJ8xJMw9vEseKCbXVPL9ZGw84ibsc5T4JteG8rd
	Y2qcJxEQupQSF9HjRtf4K6+L/7kSjoqg87n+N+95gW07ESaehw5uSjUmHflfZ5U66xW2JPqcxss
	M3XH/ROQkhox/+cmZPwnKA/eZJbPlHimpVxXofTW8lV9R6Dl0f
X-Received: by 2002:a05:7301:9f10:b0:2d4:532e:7e45 with SMTP id 5a478bee46e88-2e47930fdf6mr12602298eec.23.1776871556663;
        Wed, 22 Apr 2026 08:25:56 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d4bdaf7sm22829337eec.25.2026.04.22.08.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:25:56 -0700 (PDT)
Message-Id: <ae81ef36a1b3ca04e39e891cce827fa55540b9bb.1776871546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
	<pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Apr 2026 15:25:44 +0000
Subject: [PATCH v3 5/7] fetch: add --negotiation-include option for
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
advertising potentially-relevant user brances. In this way, the
'include' version solves the problem I mention while allowing
negotiation to pick other references opportunistically. The two options
can also be combined to allow the best of both worlds.

The argument may be an exact ref name or a glob pattern. Non-existent
refs are silently ignored. This behavior is also updated in the ref matching
logic for the related --negotiation-restrict option to match.

The implementation outputs the requested objects as haves before the
negotiation algorithm kicks in and performs a priority-queue walk from the
tip commits. In order to avoid duplicates, we mark the requested objects as
COMMON so they (and their descendants) are not output by the negotiator. The
negotiator still outputs at least one have before a round is flushed, when
the server could ACK to stop the negotiation.

Also add --negotiation-include to 'git pull' passthrough options.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/fetch-options.adoc |  19 ++++++
 builtin/fetch.c                  |  16 ++++-
 builtin/pull.c                   |   3 +
 fetch-pack.c                     | 112 +++++++++++++++++++++++++++++--
 fetch-pack.h                     |  10 ++-
 t/t5510-fetch.sh                 |  66 ++++++++++++++++++
 transport.c                      |   4 +-
 transport.h                      |   6 ++
 8 files changed, 227 insertions(+), 9 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index c07b85499f..decc7f6abd 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -73,6 +73,25 @@ See also the `fetch.negotiationAlgorithm` and `push.negotiate`
 configuration variables documented in linkgit:git-config[1], and the
 `--negotiate-only` option below.
 
+`--negotiation-include=<revision>`::
+	Ensure that the given ref tip is always sent as a "have" line
+	during fetch negotiation, regardless of what the negotiation
+	algorithm selects.  This is useful to guarantee that common
+	history reachable from specific refs is always considered, even
+	when `--negotiation-restrict` restricts the set of tips or when
+	the negotiation algorithm would otherwise skip them.
++
+This option may be specified more than once; if so, each ref is sent
+unconditionally.
++
+The argument may be an exact ref name (e.g. `refs/heads/release`) or a
+glob pattern (e.g. `refs/heads/release/{asterisk}`).  The pattern syntax
+is the same as for `--negotiation-restrict`.
++
+If `--negotiation-restrict` is used, the have set is first restricted by
+that option and then increased to include the tips specified by
+`--negotiation-include`.
+
 `--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
 	ancestors of the provided `--negotiation-tip=` arguments,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a1960e3e0c..ef50e2fbe9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -99,6 +99,7 @@ static struct transport *gsecondary;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_restrict = STRING_LIST_INIT_NODUP;
+static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
@@ -1547,10 +1548,14 @@ static void add_negotiation_restrict_tips(struct git_transport_options *smart_op
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
@@ -1615,6 +1620,13 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 			strbuf_release(&config_name);
 		}
 	}
+	if (negotiation_include.nr) {
+		if (transport->smart_options)
+			transport->smart_options->negotiation_include = &negotiation_include;
+		else
+			warning(_("ignoring %s because the protocol does not support it"),
+				"--negotiation-include");
+	}
 	return transport;
 }
 
@@ -2582,6 +2594,8 @@ int cmd_fetch(int argc,
 		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_restrict, N_("revision"),
 				N_("report that we have only objects reachable from this object")),
 		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
+		OPT_STRING_LIST(0, "negotiation-include", &negotiation_include, N_("revision"),
+				N_("ensure this ref is always sent as a negotiation have")),
 		OPT_BOOL(0, "negotiate-only", &negotiate_only,
 			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
diff --git a/builtin/pull.c b/builtin/pull.c
index 821cc6699a..86c85b60ef 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1002,6 +1002,9 @@ int cmd_pull(int argc,
 		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
 			N_("report that we have only objects reachable from this object"),
 			0),
+		OPT_PASSTHRU_ARGV(0, "negotiation-include", &opt_fetch, N_("revision"),
+			N_("ensure this ref is always sent as a negotiation have"),
+			0),
 		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
 			 N_("check for forced-updates on all updated branches")),
 		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
diff --git a/fetch-pack.c b/fetch-pack.c
index baf239adf9..8b080b0080 100644
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
@@ -332,6 +333,48 @@ static void send_filter(struct fetch_pack_args *args,
 	}
 }
 
+static int add_oid_to_oidset(const struct reference *ref, void *cb_data)
+{
+	struct oidset *set = cb_data;
+	if (!odb_has_object(the_repository->objects, ref->oid, 0))
+		die(_("the object %s does not exist"), oid_to_hex(ref->oid));
+	oidset_insert(set, ref->oid);
+	return 0;
+}
+
+static void resolve_negotiation_include(const struct string_list *negotiation_include,
+					struct oidset *result)
+{
+	struct string_list_item *item;
+
+	if (!negotiation_include || !negotiation_include->nr)
+		return;
+
+	for_each_string_list_item(item, negotiation_include) {
+		if (!has_glob_specials(item->string)) {
+			struct object_id oid;
+
+			/* Ignore missing reference. */
+			if (repo_get_oid(the_repository, item->string, &oid))
+				continue;
+
+			/* Fail on missing object pointed by ref. */
+			if (!odb_has_object(the_repository->objects, &oid, 0))
+				die(_("the object %s does not exist"),
+				    item->string);
+
+			oidset_insert(result, &oid);
+		} else {
+			struct refs_for_each_ref_options opts = {
+				.pattern = item->string,
+			};
+			refs_for_each_ref_ext(
+				get_main_ref_store(the_repository),
+				add_oid_to_oidset, result, &opts);
+		}
+	}
+}
+
 static int find_common(struct fetch_negotiator *negotiator,
 		       struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
@@ -347,6 +390,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	struct strbuf req_buf = STRBUF_INIT;
 	size_t state_len = 0;
 	struct packet_reader reader;
+	struct oidset negotiation_include_oids = OIDSET_INIT;
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
@@ -474,6 +518,33 @@ static int find_common(struct fetch_negotiator *negotiator,
 	trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
 	flushes = 0;
 	retval = -1;
+
+	/* Send unconditional haves from --negotiation-include */
+	resolve_negotiation_include(args->negotiation_include,
+				    &negotiation_include_oids);
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
+			/*
+			 * If this is a commit, then mark as COMMON to
+			 * avoid the negotiator also outputting it as
+			 * a have.
+			 */
+			commit = lookup_commit(the_repository, oid);
+			if (commit &&
+			    !repo_parse_commit(the_repository, commit))
+				commit->object.flags |= COMMON;
+		}
+	}
+
 	while ((oid = negotiator->next(negotiator))) {
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
@@ -584,6 +655,7 @@ done:
 		flushes++;
 	}
 	strbuf_release(&req_buf);
+	oidset_clear(&negotiation_include_oids);
 
 	if (!got_ready || !no_done)
 		consume_shallow_list(args, &reader);
@@ -1305,12 +1377,26 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
 
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
+		while ((oid = oidset_iter_next(&iter)))
+			packet_buf_write(req_buf, "have %s\n",
+					 oid_to_hex(oid));
+	}
+
 	while ((oid = negotiator->next(negotiator))) {
+		if (negotiation_include_oids &&
+		    oidset_contains(negotiation_include_oids, oid))
+			continue;
 		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
 		if (++haves_added >= *haves_to_send)
 			break;
@@ -1358,7 +1444,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain,
-			      int sideband_all, int seen_ack)
+			      int sideband_all, int seen_ack,
+			      struct oidset *negotiation_include_oids)
 {
 	int haves_added;
 	int done_sent = 0;
@@ -1413,7 +1500,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	/* Add all of the common commits we've found in previous rounds */
 	add_common(&req_buf, common);
 
-	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
+	haves_added = add_haves(negotiator, &req_buf, haves_to_send,
+			       negotiation_include_oids);
 	*in_vain += haves_added;
 	trace2_data_intmax("negotiation_v2", the_repository, "haves_added", haves_added);
 	trace2_data_intmax("negotiation_v2", the_repository, "in_vain", *in_vain);
@@ -1657,6 +1745,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct ref *ref = copy_ref_list(orig_ref);
 	enum fetch_state state = FETCH_CHECK_LOCAL;
 	struct oidset common = OIDSET_INIT;
+	struct oidset negotiation_include_oids = OIDSET_INIT;
 	struct packet_reader reader;
 	int in_vain = 0, negotiation_started = 0;
 	int negotiation_round = 0;
@@ -1729,6 +1818,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				state = FETCH_SEND_REQUEST;
 
 			mark_tips(negotiator, args->negotiation_restrict_tips);
+			resolve_negotiation_include(args->negotiation_include,
+						    &negotiation_include_oids);
 			for_each_cached_alternate(negotiator,
 						  insert_one_alternate_object);
 			break;
@@ -1747,7 +1838,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 					       &common,
 					       &haves_to_send, &in_vain,
 					       reader.use_sideband,
-					       seen_ack)) {
+					       seen_ack,
+					       &negotiation_include_oids)) {
 				trace2_region_leave_printf("negotiation_v2", "round",
 							   the_repository, "%d",
 							   negotiation_round);
@@ -1883,6 +1975,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		negotiator->release(negotiator);
 
 	oidset_clear(&common);
+	oidset_clear(&negotiation_include_oids);
 	return ref;
 }
 
@@ -2181,12 +2274,14 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 			   const struct string_list *server_options,
 			   int stateless_rpc,
 			   int fd[],
-			   struct oidset *acked_commits)
+			   struct oidset *acked_commits,
+			   const struct string_list *negotiation_include)
 {
 	struct fetch_negotiator negotiator;
 	struct packet_reader reader;
 	struct object_array nt_object_array = OBJECT_ARRAY_INIT;
 	struct strbuf req_buf = STRBUF_INIT;
+	struct oidset negotiation_include_oids = OIDSET_INIT;
 	int haves_to_send = INITIAL_FLUSH;
 	int in_vain = 0;
 	int seen_ack = 0;
@@ -2197,6 +2292,9 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 	fetch_negotiator_init(the_repository, &negotiator);
 	mark_tips(&negotiator, negotiation_restrict_tips);
 
+	resolve_negotiation_include(negotiation_include,
+				    &negotiation_include_oids);
+
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
@@ -2221,7 +2319,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send);
+		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send,
+				       &negotiation_include_oids);
 		in_vain += haves_added;
 		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
 			last_iteration = 1;
@@ -2273,6 +2372,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 
 	clear_common_flag(acked_commits);
 	object_array_clear(&nt_object_array);
+	oidset_clear(&negotiation_include_oids);
 	negotiator.release(&negotiator);
 	strbuf_release(&req_buf);
 }
diff --git a/fetch-pack.h b/fetch-pack.h
index 6c70c942c2..32ae94d0b4 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -23,6 +23,13 @@ struct fetch_pack_args {
 	 */
 	const struct oid_array *negotiation_restrict_tips;
 
+	/*
+	 * If non-empty, ref patterns whose tips should always be sent
+	 * as "have" lines during negotiation, regardless of what the
+	 * negotiation algorithm selects.
+	 */
+	const struct string_list *negotiation_include;
+
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
@@ -93,7 +100,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 			   const struct string_list *server_options,
 			   int stateless_rpc,
 			   int fd[],
-			   struct oidset *acked_commits);
+			   struct oidset *acked_commits,
+			   const struct string_list *negotiation_include);
 
 /*
  * Print an appropriate error message for each sought ref that wasn't
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index eff3ce8e2d..4316f8d4ea 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1511,6 +1511,72 @@ test_expect_success 'CLI --negotiation-restrict overrides remote config' '
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
 test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
 	git init df-conflict &&
 	(
diff --git a/transport.c b/transport.c
index a3051f6733..8a2d8adffc 100644
--- a/transport.c
+++ b/transport.c
@@ -464,6 +464,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
 	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
+	args.negotiation_include = data->options.negotiation_include;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
 
 	if (!data->finished_handshake) {
@@ -495,7 +496,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 					      transport->server_options,
 					      transport->stateless_rpc,
 					      data->fd,
-					      data->options.acked_commits);
+					      data->options.acked_commits,
+					      data->options.negotiation_include);
 			ret = 0;
 		}
 		goto cleanup;
diff --git a/transport.h b/transport.h
index cdeb33c16f..6092775a27 100644
--- a/transport.h
+++ b/transport.h
@@ -48,6 +48,12 @@ struct git_transport_options {
 	 */
 	struct oid_array *negotiation_restrict_tips;
 
+	/*
+	 * If non-empty, ref patterns whose tips should always be sent
+	 * as "have" lines during negotiation.
+	 */
+	const struct string_list *negotiation_include;
+
 	/*
 	 * If allocated, whenever transport_fetch_refs() is called, add known
 	 * common commits to this oidset instead of fetching any packfiles.
-- 
gitgitgadget

