Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F171F42E
	for <e@80x24.org>; Wed,  3 Jan 2018 16:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbeACQet (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:49 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:44009 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeACQeb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:31 -0500
Received: by mail-wr0-f169.google.com with SMTP id w68so2143086wrc.10
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xWnyCyDPNAn7vEugCHEJObZgrqetVPZSybNxhd2L5d4=;
        b=DbK3w3oIg4+KJ87GYsuxWgjEe/YuOzrNJFtKlIC2+MIMIUsX8ZA+9OOqEKX4qqjc/a
         1EUaMiQeWUhhBFTE0hOcHfDPw6Px6a8sCYBDxOfzy9lmzxVsWJpNpocREBzThOwCFWiu
         NWZGnIiuKkg+aGTpKX6Q2+RXAH5Fb4OIcfiieowoQbWjRFwkoXyC4wYoWE4LmX8z+Z9O
         A7HC9oxD5pHIpurL4IP+2Hu+ANhF+TY5g9IzOXor4sFmw3LO9ADHX3OaW7LGeh3oy/1m
         3vvzqN7ixQes1Ceo5LdzBB1PBDSIoLie0Drpuup0lVwd/Re6/h6jYW82bZxIAW0k5tp9
         XU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xWnyCyDPNAn7vEugCHEJObZgrqetVPZSybNxhd2L5d4=;
        b=HQLTTjKQOfuIBJO1if2l0U7VYydf731rTnD1X1vmnBwN0rsYxM/s/qYqtleZSm7Mne
         du6GFcb9J0RXNZbyot8jxrM3EDtrOP62ZvKxfFFhatDv3TUE1CfGMdG5CGBFRPOMVm/h
         56caVMXX/6g/I1YtCqQwJAl8PsqmqCWrcarFW7oolK469EYn64NHJld/sgkdp3EfnSOj
         Y1Epl6J4WbYxQPxhKx7+gr1zUhbHc64GkcwodO8F6F/6fIlxktyasGw41Nh/lCH89Zus
         duNs+xOzmKzAnPR/gcXSnO5aqUIcK0gfZa9a/Lu24ShZkAxPSeJobq+5TwmVLiRj1qMc
         bHSg==
X-Gm-Message-State: AKGB3mLKLPynBsth4Sdr6QrGLYqB5O57Cvs2NZ8J9XscqQNZ4i4r2nuK
        pAB/0QM7oU+C5HTScZFKohzntZBY
X-Google-Smtp-Source: ACJfBotJJawH1nOfKmB1sUiXA4zoNuEELhDvo5gNImJYisK1mi7nTRr1fipQZRhXac1e2eCzFddXvg==
X-Received: by 10.223.153.151 with SMTP id y23mr2107053wrb.130.1514997269631;
        Wed, 03 Jan 2018 08:34:29 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:28 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 09/40] introduce fetch-object: fetch one promisor object
Date:   Wed,  3 Jan 2018 17:33:32 +0100
Message-Id: <20180103163403.11303-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Introduce fetch-object, providing the ability to fetch one object from a
promisor remote.

This uses fetch-pack. To do this, the transport mechanism has been
updated with 2 flags, "from-promisor" to indicate that the resulting
pack comes from a promisor remote (and thus should be annotated as such
by index-pack), and "no-dependents" to indicate that only the objects
themselves need to be fetched (but fetching additional objects is
nevertheless safe).

Whenever "no-dependents" is used, fetch-pack will refrain from using any
object flags, because it is most likely invoked as part of a dynamic
object fetch by another Git command (which may itself use object flags).
An alternative to this is to leave fetch-pack alone, and instead update
the allocation of flags so that fetch-pack's flags never overlap with
any others, but this will end up shrinking the number of flags available
to nearly every other Git command (that is, every Git command that
accesses objects), so the approach in this commit was used instead.

This will be tested in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitremote-helpers.txt |  7 ++++++
 Makefile                            |  1 +
 builtin/fetch-pack.c                |  8 +++++++
 builtin/index-pack.c                | 14 ++++++++---
 fetch-object.c                      | 28 ++++++++++++++++++++++
 fetch-object.h                      |  6 +++++
 fetch-pack.c                        | 48 +++++++++++++++++++++----------------
 fetch-pack.h                        |  8 +++++++
 remote-curl.c                       | 14 ++++++++++-
 transport.c                         |  8 +++++++
 transport.h                         | 11 +++++++++
 11 files changed, 128 insertions(+), 25 deletions(-)
 create mode 100644 fetch-object.c
 create mode 100644 fetch-object.h

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 4a584f3c5d..4b8c93ec59 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -466,6 +466,13 @@ set by Git if the remote helper has the 'option' capability.
 	Transmit <string> as a push option. As the push option
 	must not contain LF or NUL characters, the string is not encoded.
 
+'option from-promisor' {'true'|'false'}::
+	Indicate that these objects are being fetched from a promisor.
+
+'option no-dependents' {'true'|'false'}::
+	Indicate that only the objects wanted need to be fetched, not
+	their dependents.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
diff --git a/Makefile b/Makefile
index 07694185c9..25b878279e 100644
--- a/Makefile
+++ b/Makefile
@@ -800,6 +800,7 @@ LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
 LIB_OBJS += external-odb.o
+LIB_OBJS += fetch-object.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 366b9d13f9..02abe7211e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -143,6 +143,14 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.update_shallow = 1;
 			continue;
 		}
+		if (!strcmp("--from-promisor", arg)) {
+			args.from_promisor = 1;
+			continue;
+		}
+		if (!strcmp("--no-dependents", arg)) {
+			args.no_dependents = 1;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 47515d8977..9dffaf20ae 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1429,14 +1429,16 @@ static void write_special_file(const char *suffix, const char *msg,
 		if (close(fd) != 0)
 			die_errno(_("cannot close written %s file '%s'"),
 				  suffix, filename);
-		*report = suffix;
+		if (report)
+			*report = suffix;
 	}
 	strbuf_release(&name_buf);
 }
 
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
-		  const char *keep_msg, unsigned char *sha1)
+		  const char *keep_msg, const char *promisor_msg,
+		  unsigned char *sha1)
 {
 	const char *report = "pack";
 	struct strbuf pack_name = STRBUF_INIT;
@@ -1455,6 +1457,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	if (keep_msg)
 		write_special_file("keep", keep_msg, final_pack_name, sha1,
 				   &report);
+	if (promisor_msg)
+		write_special_file("promisor", promisor_msg, final_pack_name,
+				   sha1, NULL);
 
 	if (final_pack_name != curr_pack_name) {
 		if (!final_pack_name)
@@ -1644,6 +1649,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	const char *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
 	const char *keep_msg = NULL;
+	const char *promisor_msg = NULL;
 	struct strbuf index_name_buf = STRBUF_INIT;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
@@ -1688,6 +1694,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				stat_only = 1;
 			} else if (skip_to_optional_arg(arg, "--keep", &keep_msg)) {
 				; /* nothing to do */
+			} else if (skip_to_optional_arg(arg, "--promisor", &promisor_msg)) {
+				; /* nothing to do */
 			} else if (starts_with(arg, "--threads=")) {
 				char *end;
 				nr_threads = strtoul(arg+10, &end, 0);
@@ -1798,7 +1806,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!verify)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
-		      keep_msg,
+		      keep_msg, promisor_msg,
 		      pack_sha1);
 	else
 		close(input_fd);
diff --git a/fetch-object.c b/fetch-object.c
new file mode 100644
index 0000000000..23ec2bb0d0
--- /dev/null
+++ b/fetch-object.c
@@ -0,0 +1,28 @@
+#include "cache.h"
+#include "packfile.h"
+#include "pkt-line.h"
+#include "strbuf.h"
+#include "transport.h"
+#include "fetch-object.h"
+
+/*
+ * TODO Investigate having fetch_object() return error/success,
+ * changing callers.
+ */
+void fetch_object(const char *remote_name, const unsigned char *sha1)
+{
+	struct remote *remote;
+	struct transport *transport;
+	struct ref *ref;
+
+	remote = remote_get(remote_name);
+	if (!remote->url[0])
+		die(_("Remote with no URL"));
+	transport = transport_get(remote, remote->url[0]);
+
+	ref = alloc_ref(sha1_to_hex(sha1));
+	hashcpy(ref->old_oid.hash, sha1);
+	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
+	transport_fetch_refs(transport, ref);
+}
diff --git a/fetch-object.h b/fetch-object.h
new file mode 100644
index 0000000000..f371300c88
--- /dev/null
+++ b/fetch-object.h
@@ -0,0 +1,6 @@
+#ifndef FETCH_OBJECT_H
+#define FETCH_OBJECT_H
+
+extern void fetch_object(const char *remote_name, const unsigned char *sha1);
+
+#endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 9f6b07ad91..7aa1f58995 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -450,6 +450,8 @@ static int find_common(struct fetch_pack_args *args,
 
 	flushes = 0;
 	retval = -1;
+	if (args->no_dependents)
+		goto done;
 	while ((oid = get_rev())) {
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
@@ -735,29 +737,31 @@ static int everything_local(struct fetch_pack_args *args,
 		}
 	}
 
-	if (!args->deepen) {
-		for_each_ref(mark_complete_oid, NULL);
-		for_each_cached_alternate(mark_alternate_complete);
-		commit_list_sort_by_date(&complete);
-		if (cutoff)
-			mark_recent_complete_commits(args, cutoff);
-	}
+	if (!args->no_dependents) {
+		if (!args->deepen) {
+			for_each_ref(mark_complete_oid, NULL);
+			for_each_cached_alternate(mark_alternate_complete);
+			commit_list_sort_by_date(&complete);
+			if (cutoff)
+				mark_recent_complete_commits(args, cutoff);
+		}
 
-	/*
-	 * Mark all complete remote refs as common refs.
-	 * Don't mark them common yet; the server has to be told so first.
-	 */
-	for (ref = *refs; ref; ref = ref->next) {
-		struct object *o = deref_tag(lookup_object(ref->old_oid.hash),
-					     NULL, 0);
+		/*
+		 * Mark all complete remote refs as common refs.
+		 * Don't mark them common yet; the server has to be told so first.
+		 */
+		for (ref = *refs; ref; ref = ref->next) {
+			struct object *o = deref_tag(lookup_object(ref->old_oid.hash),
+						     NULL, 0);
 
-		if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
-			continue;
+			if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
+				continue;
 
-		if (!(o->flags & SEEN)) {
-			rev_list_push((struct commit *)o, COMMON_REF | SEEN);
+			if (!(o->flags & SEEN)) {
+				rev_list_push((struct commit *)o, COMMON_REF | SEEN);
 
-			mark_common((struct commit *)o, 1, 1);
+				mark_common((struct commit *)o, 1, 1);
+			}
 		}
 	}
 
@@ -833,7 +837,7 @@ static int get_pack(struct fetch_pack_args *args,
 		argv_array_push(&cmd.args, alternate_shallow_file);
 	}
 
-	if (do_keep) {
+	if (do_keep || args->from_promisor) {
 		if (pack_lockfile)
 			cmd.out = -1;
 		cmd_name = "index-pack";
@@ -843,7 +847,7 @@ static int get_pack(struct fetch_pack_args *args,
 			argv_array_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
 			argv_array_push(&cmd.args, "--fix-thin");
-		if (args->lock_pack || unpack_limit) {
+		if (do_keep && (args->lock_pack || unpack_limit)) {
 			char hostname[HOST_NAME_MAX + 1];
 			if (xgethostname(hostname, sizeof(hostname)))
 				xsnprintf(hostname, sizeof(hostname), "localhost");
@@ -853,6 +857,8 @@ static int get_pack(struct fetch_pack_args *args,
 		}
 		if (args->check_self_contained_and_connected)
 			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
+		if (args->from_promisor)
+			argv_array_push(&cmd.args, "--promisor");
 	}
 	else {
 		cmd_name = "unpack-objects";
diff --git a/fetch-pack.h b/fetch-pack.h
index b6aeb43a8e..aeac152644 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -29,6 +29,14 @@ struct fetch_pack_args {
 	unsigned cloning:1;
 	unsigned update_shallow:1;
 	unsigned deepen:1;
+	unsigned from_promisor:1;
+
+	/*
+	 * If 1, fetch_pack() will also not modify any object flags.
+	 * This allows fetch_pack() to safely be called by any function,
+	 * regardless of which object flags it uses (if any).
+	 */
+	unsigned no_dependents:1;
 };
 
 /*
diff --git a/remote-curl.c b/remote-curl.c
index 0053b09549..431839111a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -33,7 +33,9 @@ struct options {
 		thin : 1,
 		/* One of the SEND_PACK_PUSH_CERT_* constants. */
 		push_cert : 2,
-		deepen_relative : 1;
+		deepen_relative : 1,
+		from_promisor : 1,
+		no_dependents : 1;
 };
 static struct options options;
 static struct string_list cas_options = STRING_LIST_INIT_DUP;
@@ -157,6 +159,12 @@ static int set_option(const char *name, const char *value)
 			return -1;
 		return 0;
 #endif /* LIBCURL_VERSION_NUM >= 0x070a08 */
+	} else if (!strcmp(name, "from-promisor")) {
+		options.from_promisor = 1;
+		return 0;
+	} else if (!strcmp(name, "no-dependents")) {
+		options.no_dependents = 1;
+		return 0;
 	} else {
 		return 1 /* unsupported */;
 	}
@@ -822,6 +830,10 @@ static int fetch_git(struct discovery *heads,
 				 options.deepen_not.items[i].string);
 	if (options.deepen_relative && options.depth)
 		argv_array_push(&args, "--deepen-relative");
+	if (options.from_promisor)
+		argv_array_push(&args, "--from-promisor");
+	if (options.no_dependents)
+		argv_array_push(&args, "--no-dependents");
 	argv_array_push(&args, url.buf);
 
 	for (i = 0; i < nr_heads; i++) {
diff --git a/transport.c b/transport.c
index fc802260f6..e82db773fd 100644
--- a/transport.c
+++ b/transport.c
@@ -161,6 +161,12 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_RELATIVE)) {
 		opts->deepen_relative = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_FROM_PROMISOR)) {
+		opts->from_promisor = !!value;
+		return 0;
+	} else if (!strcmp(name, TRANS_OPT_NO_DEPENDENTS)) {
+		opts->no_dependents = !!value;
+		return 0;
 	}
 	return 1;
 }
@@ -229,6 +235,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 		data->options.check_self_contained_and_connected;
 	args.cloning = transport->cloning;
 	args.update_shallow = data->options.update_shallow;
+	args.from_promisor = data->options.from_promisor;
+	args.no_dependents = data->options.no_dependents;
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0);
diff --git a/transport.h b/transport.h
index 731c78b679..8c3430a5b9 100644
--- a/transport.h
+++ b/transport.h
@@ -15,6 +15,8 @@ struct git_transport_options {
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
 	unsigned deepen_relative : 1;
+	unsigned from_promisor : 1;
+	unsigned no_dependents : 1;
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
@@ -159,6 +161,15 @@ void transport_check_allowed(const char *type);
 /* Send push certificates */
 #define TRANS_OPT_PUSH_CERT "pushcert"
 
+/* Indicate that these objects are being fetched by a promisor */
+#define TRANS_OPT_FROM_PROMISOR "from-promisor"
+
+/*
+ * Indicate that only the objects wanted need to be fetched, not their
+ * dependents
+ */
+#define TRANS_OPT_NO_DEPENDENTS "no-dependents"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

