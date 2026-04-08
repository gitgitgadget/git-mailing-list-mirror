Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E96345752
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658980; cv=none; b=NjGj/MzyMR1rB7rVpt5fe7nd747w/WKzb+uChWsffLGqed/FbdA67Nu2sGndeOyXxPN///IoSXhjzzd17bvORdOtvzstYLXyDY9Xy5Veu2r/Soz3r/Uae5sQtI/yZlkBUwdooVJy3MxMSOGiLXzZeSLoErm5Gm4YM7bEMqHdE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658980; c=relaxed/simple;
	bh=vo2KaNKvWxCfUEZmIS/Fmd9OJepNVIkwDRezkCATC7E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kOjASqt7tyyoJlo+cPaQWpQsTetxiCLJgn8VUM0uZOLjIOblP4ghLrsn+fqK8BRbAqKYjej5ssivwBFA3KA81aGl2TyEZFu/OiL06DT+K3sTqb6Mq9cSHBTT9ZsmttvVPTl11XSS9/RfVN31moAKWPZNWivgtdoz9jgG2fnUxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1Clqlbh; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1Clqlbh"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a3970f1a0eso86980306d6.2
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775658977; x=1776263777; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdvsC0U+PozkzOw9NNTZJAcGXBrNK7v/QmWL+kKBet0=;
        b=D1ClqlbhYE5gt9hvUpHZOddOHD1Ej2XTsr2TnOVOVoctA99H8/QAXhuc5ztPfv0Qet
         wJtA7GcyyNvhXkqqIyoOrucQq5oUo6Zn0RkiJmTwaVhF7kRkyKo7fmhu8JRrRwMGIkfN
         5WIWhb5St9RPyZBnAtEHmVw4rTXEMcaoALOdIM5i4NBPRH0gwbOxBWgJasZbklTcTvVY
         0lo/AeX7g2UJbjYALAXKf8DGR04P/kiaLzqLOfrIdPrHVV5zeM8MprPR0NBq8TH571Ug
         WQSxEA8IxrdLWXJwF+7DFl6SIoDH4l2vzGsSG+1CUKk7ZtQsGIlutvjQ+T1NOKc2kMAn
         OTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658977; x=1776263777;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LdvsC0U+PozkzOw9NNTZJAcGXBrNK7v/QmWL+kKBet0=;
        b=g3tS34JUlVv86TTUbi/ySiPjofy2G+mN7mKjMVwkAf3I1snYOXmpb7qY5xiJi09ZBp
         93NkMpPVrtADetCJO9WmSf7oo02w33oo9mNFNIl1lJ5ktp/AVg1a3bauJIsGZJzCxYPz
         aGrWgxhIFem7s0hkXf9JDEj4+7xKbWlFPIgl0MjYZ+P8PMse+KazjcgumjjAIBUFYvsl
         Zv36T7SGX01OpNcXsPpLQo8gShKu5z3BX75v8McBR0/fIY8H/eVDoh4UzF8Pets5VnZj
         yjEtuK4AP0KqZavfhMda/79GjQYvfZtDLEk0mIoU5QjdquOG/J6XBYdC7MrOmHjQQB5Y
         olcw==
X-Gm-Message-State: AOJu0YxgqFVMFrZ9r44y9MCBYcF8iX/VmEBYooTETYD0+nE4LR9TMUcL
	Za1wj7aGWReK9sjenJdP2i42loHPt0UPNj2ecVxKLgFseeWDubedFcGxdA57gg==
X-Gm-Gg: AeBDieufz49nQGpmlCTpbYRsa7375qIH03QRUBnmf/bp+W20nYGZyq0Xo6kKBeeZbYe
	mVVZr+x5r2LzEcpzxV46ZIVsnKmgpZW3hLucLGk3MCR9RbCNytRI2NJ9WbHw9x2MUAblIGM9afZ
	Lsuv1eEnvNQSVnh9mZlOY/MoMJOs7QcpFs9T3FEDpH6q+vOuRkuF8ZnG5ak9tFCehC+seaPy7+P
	K0J+Rb75uHfYJOveKjzQRXi/Gi0rC7YwWwaoyNxgX5pVWvy1eedG2JVjQ87QS+vA5iJiMxXolQa
	0uHx5LkWbqNxoNX4PiYTH7ULHBUxsuQ2qWmTSACjcgRiVNzY5wL0QoPhOThcg6B8JS7lCSwtL7d
	Q0z0dMqtLXM0R0ZbUm/tUyyDll0KSGj4a04u5ID6L0Hf16sl4Xm1yBnybbwJUEjHJlmt5t0/tpQ
	4yl3GEDKFti8+ycsMxLGVBqEOEWj4=
X-Received: by 2002:a05:6214:4905:b0:89a:72ee:3233 with SMTP id 6a1803df08f44-8a7020c09f4mr356725756d6.6.1775658976955;
        Wed, 08 Apr 2026 07:36:16 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593330593sm193237136d6.3.2026.04.08.07.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:36:16 -0700 (PDT)
Message-Id: <8b39eb9e6c0e587ba1bdd040ca4fb425d4224eca.1775658970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 14:36:08 +0000
Subject: [PATCH 2/4] fetch: add --must-have option for negotiation
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
    jonathantanmy@google.com,
    chooglen@google.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a --must-have option to git fetch that specifies ref patterns whose
tips should always be sent as "have" commits during negotiation,
regardless of what the negotiation algorithm selects.

Each value is either an exact ref name (e.g. refs/heads/release) or a
glob pattern (e.g. refs/heads/release/*). The pattern syntax is the same
as for --negotiation-tip.

This is useful when certain references are important for negotiation
efficiency but might be skipped by the negotiation algorithm or excluded
by --negotiation-tip. Unlike --negotiation-tip which restricts the have
set, --must-have is additive: the negotiation algorithm still runs and
advertises its own selected commits, but the refs matching --must-have
are sent unconditionally on top of those.

If --negotiation-tip is used, the have set is first restricted by that
option and then increased to include the tips specified by --must-have.

Due to the comparision with --negotiation-tip, a previously untranslated
warning around --negotiation-tip is converted into a translatable string
with a swap for which option that is relevant.

Getting this functionality to work requires moving these options through
the transport API layer.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/fetch-options.adoc | 18 +++++++
 builtin/fetch.c                  | 11 +++-
 fetch-pack.c                     | 92 +++++++++++++++++++++++++++++---
 fetch-pack.h                     | 10 +++-
 t/t5510-fetch.sh                 | 73 +++++++++++++++++++++++++
 transport.c                      |  4 +-
 transport.h                      |  6 +++
 7 files changed, 205 insertions(+), 9 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 81a9d7f9bb..852e30191e 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -69,6 +69,24 @@ See also the `fetch.negotiationAlgorithm` and `push.negotiate`
 configuration variables documented in linkgit:git-config[1], and the
 `--negotiate-only` option below.
 
+`--must-have=<revision>`::
+	Ensure that the given ref tip is always sent as a "have" line
+	during fetch negotiation, regardless of what the negotiation
+	algorithm selects.  This is useful to guarantee that common
+	history reachable from specific refs is always considered, even
+	when `--negotiation-tip` restricts the set of tips or when the
+	negotiation algorithm would otherwise skip them.
++
+This option may be specified more than once; if so, each ref is sent
+unconditionally.
++
+The argument may be an exact ref name (e.g. `refs/heads/release`) or a
+glob pattern (e.g. `refs/heads/release/{asterisk}`).  The pattern syntax
+is the same as for `--negotiation-tip`.
++
+If `--negotiation-tip` is used, the have set is first restricted by that
+option and then increased to include the tips specified by `--must-have`.
+
 `--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
 	ancestors of the provided `--negotiation-tip=` arguments,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4795b2a13c..5d29cc6b1a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -99,6 +99,7 @@ static struct transport *gsecondary;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
+static struct string_list must_have = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
@@ -1599,7 +1600,13 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		if (transport->smart_options)
 			add_negotiation_tips(transport->smart_options);
 		else
-			warning("ignoring --negotiation-tip because the protocol does not support it");
+			warning(_("ignoring %s because the protocol does not support it"), "--negotiation-tip");
+	}
+	if (must_have.nr) {
+		if (transport->smart_options)
+			transport->smart_options->must_have = &must_have;
+		else
+			warning(_("ignoring %s because the protocol does not support it"), "--must-have");
 	}
 	return transport;
 }
@@ -2567,6 +2574,8 @@ int cmd_fetch(int argc,
 		OPT_IPVERSION(&family),
 		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
 				N_("report that we have only objects reachable from this object")),
+		OPT_STRING_LIST(0, "must-have", &must_have, N_("revision"),
+				N_("ensure this ref is always sent as a negotiation have")),
 		OPT_BOOL(0, "negotiate-only", &negotiate_only,
 			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
diff --git a/fetch-pack.c b/fetch-pack.c
index 6ecd468ef7..afd4f31225 100644
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
@@ -332,6 +333,40 @@ static void send_filter(struct fetch_pack_args *args,
 	}
 }
 
+static int add_oid_to_oidset(const struct reference *ref, void *cb_data)
+{
+	struct oidset *set = cb_data;
+	oidset_insert(set, ref->oid);
+	return 0;
+}
+
+static void resolve_must_have(const struct string_list *must_have,
+			      struct oidset *result)
+{
+	struct string_list_item *item;
+
+	if (!must_have || !must_have->nr)
+		return;
+
+	for_each_string_list_item(item, must_have) {
+		if (!has_glob_specials(item->string)) {
+			struct object_id oid;
+			if (repo_get_oid(the_repository, item->string, &oid))
+				continue;
+			if (!odb_has_object(the_repository->objects, &oid, 0))
+				continue;
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
@@ -347,6 +382,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	struct strbuf req_buf = STRBUF_INIT;
 	size_t state_len = 0;
 	struct packet_reader reader;
+	struct oidset must_have_oids = OIDSET_INIT;
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
@@ -474,7 +510,24 @@ static int find_common(struct fetch_negotiator *negotiator,
 	trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
 	flushes = 0;
 	retval = -1;
+
+	/* Send unconditional haves from --must-have */
+	resolve_must_have(args->must_have, &must_have_oids);
+	if (oidset_size(&must_have_oids)) {
+		struct oidset_iter iter;
+		oidset_iter_init(&must_have_oids, &iter);
+
+		while ((oid = oidset_iter_next(&iter))) {
+			packet_buf_write(&req_buf, "have %s\n",
+					 oid_to_hex(oid));
+			print_verbose(args, "have %s", oid_to_hex(oid));
+		}
+	}
+
 	while ((oid = negotiator->next(negotiator))) {
+		/* avoid duplicate oids from --must-have */
+		if (oidset_contains(&must_have_oids, oid))
+			continue;
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
 		in_vain++;
@@ -584,6 +637,7 @@ done:
 		flushes++;
 	}
 	strbuf_release(&req_buf);
+	oidset_clear(&must_have_oids);
 
 	if (!got_ready || !no_done)
 		consume_shallow_list(args, &reader);
@@ -1305,12 +1359,25 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
 
 static int add_haves(struct fetch_negotiator *negotiator,
 		     struct strbuf *req_buf,
-		     int *haves_to_send)
+		     int *haves_to_send,
+		     struct oidset *must_have_oids)
 {
 	int haves_added = 0;
 	const struct object_id *oid;
 
+	/* Send unconditional haves from --must-have */
+	if (must_have_oids) {
+		struct oidset_iter iter;
+		oidset_iter_init(must_have_oids, &iter);
+
+		while ((oid = oidset_iter_next(&iter)))
+			packet_buf_write(req_buf, "have %s\n",
+					 oid_to_hex(oid));
+	}
+
 	while ((oid = negotiator->next(negotiator))) {
+		if (must_have_oids && oidset_contains(must_have_oids, oid))
+			continue;
 		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
 		if (++haves_added >= *haves_to_send)
 			break;
@@ -1358,7 +1425,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain,
-			      int sideband_all, int seen_ack)
+			      int sideband_all, int seen_ack,
+			      struct oidset *must_have_oids)
 {
 	int haves_added;
 	int done_sent = 0;
@@ -1413,7 +1481,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	/* Add all of the common commits we've found in previous rounds */
 	add_common(&req_buf, common);
 
-	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
+	haves_added = add_haves(negotiator, &req_buf, haves_to_send,
+			       must_have_oids);
 	*in_vain += haves_added;
 	trace2_data_intmax("negotiation_v2", the_repository, "haves_added", haves_added);
 	trace2_data_intmax("negotiation_v2", the_repository, "in_vain", *in_vain);
@@ -1657,6 +1726,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct ref *ref = copy_ref_list(orig_ref);
 	enum fetch_state state = FETCH_CHECK_LOCAL;
 	struct oidset common = OIDSET_INIT;
+	struct oidset must_have_oids = OIDSET_INIT;
 	struct packet_reader reader;
 	int in_vain = 0, negotiation_started = 0;
 	int negotiation_round = 0;
@@ -1708,6 +1778,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	resolve_must_have(args->must_have, &must_have_oids);
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
@@ -1747,7 +1819,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 					       &common,
 					       &haves_to_send, &in_vain,
 					       reader.use_sideband,
-					       seen_ack)) {
+					       seen_ack,
+					       &must_have_oids)) {
 				trace2_region_leave_printf("negotiation_v2", "round",
 							   the_repository, "%d",
 							   negotiation_round);
@@ -1883,6 +1956,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		negotiator->release(negotiator);
 
 	oidset_clear(&common);
+	oidset_clear(&must_have_oids);
 	return ref;
 }
 
@@ -2181,12 +2255,14 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 			   const struct string_list *server_options,
 			   int stateless_rpc,
 			   int fd[],
-			   struct oidset *acked_commits)
+			   struct oidset *acked_commits,
+			   const struct string_list *must_have)
 {
 	struct fetch_negotiator negotiator;
 	struct packet_reader reader;
 	struct object_array nt_object_array = OBJECT_ARRAY_INIT;
 	struct strbuf req_buf = STRBUF_INIT;
+	struct oidset must_have_oids = OIDSET_INIT;
 	int haves_to_send = INITIAL_FLUSH;
 	int in_vain = 0;
 	int seen_ack = 0;
@@ -2205,6 +2281,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 			   add_to_object_array,
 			   &nt_object_array);
 
+	resolve_must_have(must_have, &must_have_oids);
+
 	trace2_region_enter("fetch-pack", "negotiate_using_fetch", the_repository);
 	while (!last_iteration) {
 		int haves_added;
@@ -2221,7 +2299,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send);
+		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send,
+				       &must_have_oids);
 		in_vain += haves_added;
 		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
 			last_iteration = 1;
@@ -2273,6 +2352,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 
 	clear_common_flag(acked_commits);
 	object_array_clear(&nt_object_array);
+	oidset_clear(&must_have_oids);
 	negotiator.release(&negotiator);
 	strbuf_release(&req_buf);
 }
diff --git a/fetch-pack.h b/fetch-pack.h
index 9d3470366f..2e97ca5ea2 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -23,6 +23,13 @@ struct fetch_pack_args {
 	 */
 	const struct oid_array *negotiation_tips;
 
+	/*
+	 * If non-empty, ref patterns whose tips should always be sent
+	 * as "have" lines during negotiation, regardless of what the
+	 * negotiation algorithm selects.
+	 */
+	const struct string_list *must_have;
+
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
@@ -93,7 +100,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 			   const struct string_list *server_options,
 			   int stateless_rpc,
 			   int fd[],
-			   struct oidset *acked_commits);
+			   struct oidset *acked_commits,
+			   const struct string_list *must_have);
 
 /*
  * Print an appropriate error message for each sought ref that wasn't
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5dcb4b51a4..c34f3805c1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1728,6 +1728,79 @@ test_expect_success REFFILES "HEAD is updated even with conflicts" '
 	)
 '
 
+test_expect_success '--must-have includes configured refs as haves' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	# With --negotiation-tip restricting tips, only alpha_1 is
+	# normally sent. --must-have should also include beta_1.
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=alpha_1 \
+		--must-have=refs/tags/beta_1 \
+		origin alpha_s beta_s &&
+
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	test_grep "fetch> have $ALPHA_1" trace &&
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace
+'
+
+test_expect_success '--must-have works with glob patterns' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=alpha_1 \
+		--must-have="refs/tags/beta_*" \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace &&
+	BETA_2=$(git -C client rev-parse beta_2) &&
+	test_grep "fetch> have $BETA_2" trace
+'
+
+test_expect_success '--must-have is additive with negotiation' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	# Without --negotiation-tip, all local refs are used as tips.
+	# --must-have should add its refs unconditionally on top.
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--must-have=refs/tags/beta_1 \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace
+'
+
+test_expect_success '--must-have ignores non-existent refs silently' '
+	setup_negotiation_tip server server 0 &&
+
+	git -C client fetch --quiet \
+		--negotiation-tip=alpha_1 \
+		--must-have=refs/tags/nonexistent \
+		origin alpha_s beta_s 2>err &&
+	test_must_be_empty err
+'
+
+test_expect_success '--must-have avoids duplicates with negotiator' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	# Configure a ref that will also be a negotiation tip.
+	# fetch should still complete successfully.
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=alpha_1 \
+		--must-have=refs/tags/alpha_1 \
+		origin alpha_s beta_s &&
+
+	# alpha_1 should appear as a have
+	test_grep "fetch> have $ALPHA_1" trace >matches &&
+	test_line_count = 1 matches
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/transport.c b/transport.c
index 107f4fa5dc..90923a640a 100644
--- a/transport.c
+++ b/transport.c
@@ -464,6 +464,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
+	args.must_have = data->options.must_have;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
 
 	if (!data->finished_handshake) {
@@ -495,7 +496,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 					      transport->server_options,
 					      transport->stateless_rpc,
 					      data->fd,
-					      data->options.acked_commits);
+					      data->options.acked_commits,
+					      data->options.must_have);
 			ret = 0;
 		}
 		goto cleanup;
diff --git a/transport.h b/transport.h
index 892f19454a..7f8d779e9b 100644
--- a/transport.h
+++ b/transport.h
@@ -48,6 +48,12 @@ struct git_transport_options {
 	 */
 	struct oid_array *negotiation_tips;
 
+	/*
+	 * If non-empty, ref patterns whose tips should always be sent
+	 * as "have" lines during negotiation.
+	 */
+	const struct string_list *must_have;
+
 	/*
 	 * If allocated, whenever transport_fetch_refs() is called, add known
 	 * common commits to this oidset instead of fetching any packfiles.
-- 
gitgitgadget

