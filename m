Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15FDF1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 00:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfAHARR (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 19:17:17 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:47146 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAHARQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 19:17:16 -0500
Received: by mail-qk1-f201.google.com with SMTP id z68so1778949qkb.14
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 16:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ClCYmnl1ac08JGHFmybmeqOI5lA12cszp2LNruJhT/U=;
        b=E24sYGDZmKM4kHB5knA+Jaqmmu1YMAM2/ev+I4WI9L4Sxll4AMYi2LWkQ2C5sM6GRq
         PyJ+5KxjuU2G6odNvQMdWrvlkarOAShDC4J4ZcmELocGiEmGovh9iGn3w3w5AaOSDNQw
         4MKw9HDZGkoTEMxv6nvoz32PRjdPpuoK372XjWSpEDO3Yv9aXvuZDSoeyTOyFU/N+rVC
         3RNg07WCJiPIEPA0Ups7lFx75i3wGLVOFfVpj7Tk5BycE+3m7FuXZKHEi3LA+QPBF3f4
         TAJydbcEPsjijKIe/Nu+4uOAhDq7tcMgo8idsGT0MgUr2yLjZpZlls+MLBJdBU/53FGT
         9hPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ClCYmnl1ac08JGHFmybmeqOI5lA12cszp2LNruJhT/U=;
        b=iCwPj0cuJH2B3euuxbkDYO+W4ajEwgQxSY+hO0+8/Bo3qHz+kpZdhdyUaCsJbU2DSt
         GsWdfVAn//D19gzeF5LZvNPcKUrF++K48Y2X0PfwD0DzxAbb4Az58VVNj1cujLOTxm3n
         DttBm2g8JSPyxgywzu2sPRKeYlVYuCayajf/3TMzDZSkwHhWgOmQaeqrYwLWICewKWCi
         iSUmqossJoiHIx/PymwFBnfAsBAj2wem5IZM5C6Is1lEqaHE0K8fiVz6H2yPj52UIP9e
         5P0faKubLtSrqpOnjyHGQOTi2+Ur9/nZ9tSSNx5pUZZIp5O3pfmB8L0LpqLG9h2xyZlq
         tGAQ==
X-Gm-Message-State: AJcUukfOPq4po/e48BzBiLhErCleQI9NW4il4VBeTfSBZxN04vWWHUnc
        6SnPcSLMImWzZI+JEZlztdy5JK+9g9dEwjIgowajSUfOsTmZEXAQgVhhuT992kGnfFU5jxgNUiw
        C73lIz31IxSaUFxjwGtursLQiNytFEqqBCCirIEJ6gnzS/a/vAGpFwXJ19T1Q5sk=
X-Google-Smtp-Source: ALg8bN75TCXSk2cgVVGbwwR6ICmVciKqpKzDKhqTENQjYE3p4MyTCl5fUMMGXbVDvQbPqpqBLpUgZiYvacS4OA==
X-Received: by 2002:a0c:9199:: with SMTP id n25mr47161111qvn.49.1546906634709;
 Mon, 07 Jan 2019 16:17:14 -0800 (PST)
Date:   Mon,  7 Jan 2019 16:17:09 -0800
In-Reply-To: <cover.1546906008.git.steadmon@google.com>
Message-Id: <d35827de35d2a158cd5325569eaaf355563bf028.1546906008.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1545261186.git.steadmon@google.com> <cover.1546906008.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v2 1/1] filter-options: Expand abbreviated numbers
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When communicating with a remote server or a subprocess, use expanded
numbers rather than abbreviated numbers in the object filter spec (e.g.
"limit:blob=1k" becomes "limit:blob=1024").

Update the protocol docs to note that clients should always perform this
expansion, to allow for more compatibility between server
implementations.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/protocol-v2.txt |  8 +++++++-
 builtin/clone.c                         |  6 +++++-
 builtin/fetch.c                         |  7 ++++++-
 fetch-pack.c                            | 15 ++++++++++++---
 list-objects-filter-options.c           | 20 ++++++++++++++++++--
 list-objects-filter-options.h           | 17 +++++++++++++++--
 t/t6112-rev-list-filters-objects.sh     | 17 +++++++++++++++++
 transport-helper.c                      | 13 +++++++++----
 upload-pack.c                           |  7 +++++--
 9 files changed, 94 insertions(+), 16 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 09e4e0273f..292060a9dc 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -296,7 +296,13 @@ included in the client's request:
 	Request that various objects from the packfile be omitted
 	using one of several filtering techniques. These are intended
 	for use with partial clone and partial fetch operations. See
-	`rev-list` for possible "filter-spec" values.
+	`rev-list` for possible "filter-spec" values. When communicating
+	with other processes, senders SHOULD translate scaled integers
+	(e.g. "1k") into a fully-expanded form (e.g. "1024") to aid
+	interoperability with older receivers that may not understand
+	newly-invented scaling suffixes. However, receivers SHOULD
+	accept the following suffixes: 'k', 'm', and 'g' for 1024,
+	1048576, and 1073741824, respectively.
 
 If the 'ref-in-want' feature is advertised, the following argument can
 be included in the client's request as well as the potential addition of
diff --git a/builtin/clone.c b/builtin/clone.c
index 15b142d646..8e05e8ad6c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1130,9 +1130,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				     option_upload_pack);
 
 	if (filter_options.choice) {
+		struct strbuf expanded_filter_spec = STRBUF_INIT;
+		expand_list_objects_filter_spec(&filter_options,
+						&expanded_filter_spec);
 		transport_set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
-				     filter_options.filter_spec);
+				     expanded_filter_spec.buf);
 		transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+		strbuf_release(&expanded_filter_spec);
 	}
 
 	if (transport->smart_options && !deepen && !filter_options.choice)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index e0140327aa..8b8bb64921 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1172,6 +1172,7 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 static struct transport *prepare_transport(struct remote *remote, int deepen)
 {
 	struct transport *transport;
+
 	transport = transport_get(remote, NULL);
 	transport_set_verbosity(transport, verbosity, progress);
 	transport->family = family;
@@ -1191,9 +1192,13 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	if (filter_options.choice) {
+		struct strbuf expanded_filter_spec = STRBUF_INIT;
+		expand_list_objects_filter_spec(&filter_options,
+						&expanded_filter_spec);
 		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
-			   filter_options.filter_spec);
+			   expanded_filter_spec.buf);
 		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+		strbuf_release(&expanded_filter_spec);
 	}
 	if (negotiation_tip.nr) {
 		if (transport->smart_options)
diff --git a/fetch-pack.c b/fetch-pack.c
index 9691046e64..485632fabe 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -329,9 +329,14 @@ static int find_common(struct fetch_negotiator *negotiator,
 			packet_buf_write(&req_buf, "deepen-not %s", s->string);
 		}
 	}
-	if (server_supports_filtering && args->filter_options.choice)
+	if (server_supports_filtering && args->filter_options.choice) {
+		struct strbuf expanded_filter_spec = STRBUF_INIT;
+		expand_list_objects_filter_spec(&args->filter_options,
+						&expanded_filter_spec);
 		packet_buf_write(&req_buf, "filter %s",
-				 args->filter_options.filter_spec);
+				 expanded_filter_spec.buf);
+		strbuf_release(&expanded_filter_spec);
+	}
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
@@ -1155,9 +1160,13 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	/* Add filter */
 	if (server_supports_feature("fetch", "filter", 0) &&
 	    args->filter_options.choice) {
+		struct strbuf expanded_filter_spec = STRBUF_INIT;
 		print_verbose(args, _("Server supports filter"));
+		expand_list_objects_filter_spec(&args->filter_options,
+						&expanded_filter_spec);
 		packet_buf_write(&req_buf, "filter %s",
-				 args->filter_options.filter_spec);
+				 expanded_filter_spec.buf);
+		strbuf_release(&expanded_filter_spec);
 	} else if (args->filter_options.choice) {
 		warning("filtering not recognized by server, ignoring");
 	}
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 5285e7674d..9efb3e9902 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -18,8 +18,9 @@
  * See Documentation/rev-list-options.txt for allowed values for <arg>.
  *
  * Capture the given arg as the "filter_spec".  This can be forwarded to
- * subordinate commands when necessary.  We also "intern" the arg for
- * the convenience of the current command.
+ * subordinate commands when necessary (although it's better to pass it through
+ * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
+ * convenience of the current command.
  */
 static int gently_parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
@@ -111,6 +112,21 @@ int opt_parse_list_objects_filter(const struct option *opt,
 	return parse_list_objects_filter(filter_options, arg);
 }
 
+void expand_list_objects_filter_spec(
+	const struct list_objects_filter_options *filter,
+	struct strbuf *expanded_spec)
+{
+	strbuf_init(expanded_spec, strlen(filter->filter_spec));
+	if (filter->choice == LOFC_BLOB_LIMIT)
+		strbuf_addf(expanded_spec, "blob:limit=%lu",
+			    filter->blob_limit_value);
+	else if (filter->choice == LOFC_TREE_DEPTH)
+		strbuf_addf(expanded_spec, "tree:%lu",
+			    filter->tree_exclude_depth);
+	else
+		strbuf_addstr(expanded_spec, filter->filter_spec);
+}
+
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options)
 {
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 477cd97029..e3adc78ebf 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -2,6 +2,7 @@
 #define LIST_OBJECTS_FILTER_OPTIONS_H
 
 #include "parse-options.h"
+#include "strbuf.h"
 
 /*
  * The list of defined filters for list-objects.
@@ -20,8 +21,9 @@ struct list_objects_filter_options {
 	/*
 	 * 'filter_spec' is the raw argument value given on the command line
 	 * or protocol request.  (The part after the "--keyword=".)  For
-	 * commands that launch filtering sub-processes, this value should be
-	 * passed to them as received by the current process.
+	 * commands that launch filtering sub-processes, or for communication
+	 * over the network, don't use this value; use the result of
+	 * expand_list_objects_filter_spec() instead.
 	 */
 	char *filter_spec;
 
@@ -62,6 +64,17 @@ int opt_parse_list_objects_filter(const struct option *opt,
 	  N_("object filtering"), 0, \
 	  opt_parse_list_objects_filter }
 
+/*
+ * Translates abbreviated numbers in the filter's filter_spec into their
+ * fully-expanded forms (e.g., "limit:blob=1k" becomes "limit:blob=1024").
+ *
+ * This form should be used instead of the raw filter_spec field when
+ * communicating with a remote process or subprocess.
+ */
+void expand_list_objects_filter_spec(
+	const struct list_objects_filter_options *filter,
+	struct strbuf *expanded_spec);
+
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options);
 
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 18b0b14d5a..f96f551fb5 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -437,4 +437,21 @@ test_expect_success 'rev-list W/ missing=allow-any' '
 	git -C r1 rev-list --quiet --missing=allow-any --objects HEAD
 '
 
+# Test expansion of filter specs.
+
+test_expect_success 'expand blob limit in protocol' '
+	git -C r2 config --local uploadpack.allowfilter 1 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -c protocol.version=2 clone \
+		--filter=blob:limit=1k "file://$(pwd)/r2" limit &&
+	! grep "blob:limit=1k" trace &&
+	grep "blob:limit=1024" trace
+'
+
+test_expect_success 'expand tree depth limit in protocol' '
+	GIT_TRACE_PACKET="$(pwd)/tree_trace" git -c protocol.version=2 clone \
+		--filter=tree:0k "file://$(pwd)/r2" tree &&
+	! grep "tree:0k" tree_trace &&
+	grep "tree:0" tree_trace
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index bf225c698f..01404bfac5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -679,10 +679,15 @@ static int fetch(struct transport *transport,
 	if (data->transport_options.update_shallow)
 		set_helper_option(transport, "update-shallow", "true");
 
-	if (data->transport_options.filter_options.choice)
-		set_helper_option(
-			transport, "filter",
-			data->transport_options.filter_options.filter_spec);
+	if (data->transport_options.filter_options.choice) {
+		struct strbuf expanded_filter_spec = STRBUF_INIT;
+		expand_list_objects_filter_spec(
+			&data->transport_options.filter_options,
+			&expanded_filter_spec);
+		set_helper_option(transport, "filter",
+				  expanded_filter_spec.buf);
+		strbuf_release(&expanded_filter_spec);
+	}
 
 	if (data->transport_options.negotiation_tips)
 		warning("Ignoring --negotiation-tip because the protocol does not support it.");
diff --git a/upload-pack.c b/upload-pack.c
index 5e81f1ff24..1c6d73e5a2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -140,14 +140,17 @@ static void create_pack_file(const struct object_array *have_obj,
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
 	if (filter_options.filter_spec) {
+		struct strbuf expanded_filter_spec = STRBUF_INIT;
+		expand_list_objects_filter_spec(&filter_options,
+						&expanded_filter_spec);
 		if (pack_objects.use_shell) {
 			struct strbuf buf = STRBUF_INIT;
-			sq_quote_buf(&buf, filter_options.filter_spec);
+			sq_quote_buf(&buf, expanded_filter_spec.buf);
 			argv_array_pushf(&pack_objects.args, "--filter=%s", buf.buf);
 			strbuf_release(&buf);
 		} else {
 			argv_array_pushf(&pack_objects.args, "--filter=%s",
-					 filter_options.filter_spec);
+					 expanded_filter_spec.buf);
 		}
 	}
 
-- 
2.20.1.97.g81188d93c3-goog

