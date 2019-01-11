Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21BDC211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfAKWS6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:18:58 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:42115 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:18:57 -0500
Received: by mail-yw1-f74.google.com with SMTP id d72so8613661ywe.9
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 14:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kvlaPdpwiLzKFBWMBG4yUcpuRyhe9W7l3KzSblqzlsY=;
        b=HHIRTpXAlv4bTS7hxFtt+c6CTSFA+VfVwgVaer7fcyTcXMxGuNLXV+dT980+eBuqj1
         Hla6mgYHMyJBohNbE8tNa3S9QoL198ZwsTy2cvcE60JTuhVoHnj/KcyOFKk8Mp6Bho0M
         h4nqylwBQGcPr6pRJQgJLbp+fltfI2omOUzSf/m+vDDYLhI2RZsvVFRSm31sQp+6cl5Z
         FInCNIcs187QZkX+c80q12rBh+6AnOv3bZBK5yh5Jv56gpox8KqKpGeTH5slqEKPP9H0
         TISSHJ2lqWM9aeNknTGhWrWbY9gaThvu0YtmuhopllgvKLiCX7MOX+Hl60sLsh9mO5OA
         uPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kvlaPdpwiLzKFBWMBG4yUcpuRyhe9W7l3KzSblqzlsY=;
        b=RP9UTYBGadqcSYedSiABDtU4U+pSrkWthVluL24zOCVEBza6Oy4sQntyv2P9ta5pQh
         R3ximLkNplYmys1qUG0Sm3UDp4KdYlDDBO06b3pmcyCFJdU8g4TubtxBkB9AFIEqa0s5
         y0lesCr15AbQ0eVaRgNDsNB1O+cNv1EyXSUi6+uzFs/e1cqW1Mu5oq7bSvdhoC82kQxx
         BgVTv4kCJk9MHcbj3iKaeHuD0CcPmtw+EtcslOCAlEByhfMxix/hVfwzPq9d67RKkzLa
         NqlBKj/EcrkxPlDRizOzsIdCTguyA7Z261S2FYsqrMBzS/Vw3UVu4P2NKg5AqLUbmclH
         Hpaw==
X-Gm-Message-State: AJcUukcPcUcMfFME4WkccsyHpkh0PlDZdFbMSW+FUkwMJG42OVKYnHWE
        xXMs7sv58QQTWhCHUI8MmzT4YCQzzQA6kICE4aB3WcRTmDRnOdZBgr7jkZbT+8oA3ARGPGvAeon
        eTG7chpgk3EvaSFD/rmq8YMZ2losj1bYgt4zqe4c2RMJxUcU15l8wxbjGo/+pootcXrhdvMZM1W
        cv
X-Google-Smtp-Source: ALg8bN6HgV06IgW+wyO3CfoRjyVn8GNmJBm7Akx3GHyc/ZEXLKZt2wwtRHesahv2IL30MTh6bToZQLwEjuVDnaEQyVaq
X-Received: by 2002:a25:af04:: with SMTP id a4mr1119352ybh.70.1547245136050;
 Fri, 11 Jan 2019 14:18:56 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:18:21 -0800
In-Reply-To: <cover.1547244620.git.jonathantanmy@google.com>
Message-Id: <7a6c111a9ad1c808fb3f0b562ac8b351e3fb1832.1547244620.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 8/4] upload-pack: send part of packfile response as uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a partial implementation of upload-pack sending part of its
packfile response as URIs.

The client is not fully implemented - it knows to ignore the
"packfile-uris" section, but because it does not actually fetch those
URIs, the returned packfile is incomplete. A test is included to show
that the appropriate URI is indeed transmitted, and that the returned
packfile is lacking exactly the expected object.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/pack-objects.c | 48 ++++++++++++++++++++++++++++++++++++
 fetch-pack.c           |  9 +++++++
 t/t5702-protocol-v2.sh | 27 ++++++++++++++++++++
 upload-pack.c          | 56 ++++++++++++++++++++++++++++++++++++------
 4 files changed, 133 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 411aefd687..448c42a666 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -117,6 +117,15 @@ enum missing_action {
 static enum missing_action arg_missing_action;
 static show_object_fn fn_show_object;
 
+struct configured_exclusion {
+	struct oidmap_entry e;
+	char *uri;
+};
+static struct oidmap configured_exclusions;
+
+static int exclude_configured_blobs;
+static struct oidset excluded_by_config;
+
 /*
  * stats
  */
@@ -831,6 +840,23 @@ static off_t write_reused_pack(struct hashfile *f)
 	return reuse_packfile_offset - sizeof(struct pack_header);
 }
 
+static void write_excluded_by_configs(void)
+{
+	struct oidset_iter iter;
+	const struct object_id *oid;
+
+	oidset_iter_init(&excluded_by_config, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct configured_exclusion *ex =
+			oidmap_get(&configured_exclusions, oid);
+
+		if (!ex)
+			BUG("configured exclusion wasn't configured");
+		write_in_full(1, ex->uri, strlen(ex->uri));
+		write_in_full(1, "\n", 1);
+	}
+}
+
 static const char no_split_warning[] = N_(
 "disabling bitmap writing, packs are split due to pack.packSizeLimit"
 );
@@ -1124,6 +1150,12 @@ static int want_object_in_pack(const struct object_id *oid,
 		}
 	}
 
+	if (exclude_configured_blobs &&
+	    oidmap_get(&configured_exclusions, oid)) {
+		oidset_insert(&excluded_by_config, oid);
+		return 0;
+	}
+
 	return 1;
 }
 
@@ -2728,6 +2760,19 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			    pack_idx_opts.version);
 		return 0;
 	}
+	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
+		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
+		const char *end;
+
+		if (parse_oid_hex(v, &ex->e.oid, &end) || *end != ' ')
+			die(_("value of uploadpack.blobpackfileuri must be "
+			      "of the form '<sha-1> <uri>' (got '%s')"), v);
+		if (oidmap_get(&configured_exclusions, &ex->e.oid))
+			die(_("object already configured in another "
+			      "uploadpack.blobpackfileuri (got '%s')"), v);
+		ex->uri = xstrdup(end + 1);
+		oidmap_put(&configured_exclusions, ex);
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -3316,6 +3361,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("do not pack objects in promisor packfiles")),
 		OPT_BOOL(0, "delta-islands", &use_delta_islands,
 			 N_("respect islands during delta compression")),
+		OPT_BOOL(0, "exclude-configured-blobs", &exclude_configured_blobs,
+			 N_("respect uploadpack.blobpackfileuri")),
 		OPT_END(),
 	};
 
@@ -3489,6 +3536,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		return 0;
 	if (nr_result)
 		prepare_pack(window, depth);
+	write_excluded_by_configs();
 	write_pack_file();
 	if (progress)
 		fprintf_ln(stderr,
diff --git a/fetch-pack.c b/fetch-pack.c
index 4618568fee..79af87b2cf 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1429,6 +1429,15 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				receive_wanted_refs(&reader, sought, nr_sought);
 
 			/* get the pack */
+			if (process_section_header(&reader, "packfile-uris", 1)) {
+				/* skip the whole section */
+				process_section_header(&reader, "packfile-uris", 0);
+				while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
+					/* do nothing */
+				}
+				if (reader.status != PACKET_READ_DELIM)
+					die("expected DELIM");
+			}
 			process_section_header(&reader, "packfile", 0);
 			if (get_pack(args, fd, pack_lockfile))
 				die(_("git fetch-pack: fetch failed."));
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index b491c62e3e..ba85ee4dd9 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -588,6 +588,33 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 	test_i18ngrep "expected no other sections to be sent after no .ready." err
 '
 
+test_expect_success 'part of packfile response provided as URI' '
+	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child log &&
+
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	echo my-blob >"$HTTPD_DOCUMENT_ROOT_PATH/http_parent/my-blob" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent/" add my-blob &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent/" commit -m x &&
+
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent/" hash-object my-blob >h &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent/" config \
+		"uploadpack.blobpackfileuri" \
+		"$(cat h) https://example.com/a-uri" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent/" config \
+		"uploadpack.allowsidebandall" "true" &&
+
+	# NEEDSWORK: "git clone" fails here because it ignores the URI provided
+	# instead of fetching it.
+	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" \
+		git -c protocol.version=2 clone \
+		"$HTTPD_URL/smart/http_parent" http_child 2>err &&
+	# Although "git clone" fails, we can still check that the server
+	# provided the URI we requested and that the error message pinpoints
+	# the object that is missing.
+	grep "clone< .*uri https://example.com/a-uri" log &&
+	test_i18ngrep "did not receive expected object $(cat h)" err
+'
+
 stop_httpd
 
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index c87b752550..fe6e2300e3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -106,9 +106,12 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 struct output_state {
 	char buffer[8193];
 	int used;
+	unsigned packfile_uris_started : 1;
+	unsigned packfile_started : 1;
 };
 
-static int read_pack_objects_stdout(int outfd, struct output_state *os)
+static int read_pack_objects_stdout(int outfd, struct output_state *os,
+				    int write_packfile_line)
 {
 	/* Data ready; we keep the last byte to ourselves
 	 * in case we detect broken rev-list, so that we
@@ -128,6 +131,37 @@ static int read_pack_objects_stdout(int outfd, struct output_state *os)
 	}
 	os->used += readsz;
 
+	while (!os->packfile_started) {
+		char *p;
+		if (os->used >= 4 && !memcmp(os->buffer, "PACK", 4)) {
+			os->packfile_started = 1;
+			if (write_packfile_line) {
+				if (os->packfile_uris_started)
+					packet_delim(1);
+				packet_write_fmt(1, "\1packfile\n");
+			}
+			break;
+		}
+		if ((p = memchr(os->buffer, '\n', os->used))) {
+			if (!os->packfile_uris_started) {
+				os->packfile_uris_started = 1;
+				if (!write_packfile_line)
+					BUG("packfile_uris requires sideband-all");
+				packet_write_fmt(1, "\1packfile-uris\n");
+			}
+			*p = '\0';
+			packet_write_fmt(1, "\1uri %s\n", os->buffer);
+
+			os->used -= p - os->buffer + 1;
+			memmove(os->buffer, p, os->used);
+		} else {
+			/*
+			 * Incomplete line.
+			 */
+			return readsz;
+		}
+	}
+
 	if (os->used > 1) {
 		send_client_data(1, os->buffer, os->used - 1);
 		os->buffer[0] = os->buffer[os->used - 1];
@@ -141,7 +175,8 @@ static int read_pack_objects_stdout(int outfd, struct output_state *os)
 }
 
 static void create_pack_file(const struct object_array *have_obj,
-			     const struct object_array *want_obj)
+			     const struct object_array *want_obj,
+			     int write_packfile_line)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	struct output_state output_state = {0};
@@ -189,6 +224,9 @@ static void create_pack_file(const struct object_array *have_obj,
 					 filter_options.filter_spec);
 		}
 	}
+	if (write_packfile_line)
+		argv_array_push(&pack_objects.args,
+				"--exclude-configured-blobs");
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
@@ -275,8 +313,8 @@ static void create_pack_file(const struct object_array *have_obj,
 		}
 		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
 			int result = read_pack_objects_stdout(pack_objects.out,
-							      &output_state);
-
+							      &output_state,
+							      write_packfile_line);
 			if (result == 0) {
 				close(pack_objects.out);
 				pack_objects.out = -1;
@@ -1108,7 +1146,7 @@ void upload_pack(struct upload_pack_options *options)
 	if (want_obj.nr) {
 		struct object_array have_obj = OBJECT_ARRAY_INIT;
 		get_common_commits(&reader, &have_obj, &want_obj);
-		create_pack_file(&have_obj, &want_obj);
+		create_pack_file(&have_obj, &want_obj, 0);
 	}
 }
 
@@ -1498,8 +1536,12 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			send_wanted_ref_info(&data);
 			send_shallow_info(&data, &want_obj);
 
-			packet_writer_write(&data.writer, "packfile\n");
-			create_pack_file(&have_obj, &want_obj);
+			if (data.writer.use_sideband) {
+				create_pack_file(&have_obj, &want_obj, 1);
+			} else {
+				packet_write_fmt(1, "packfile\n");
+				create_pack_file(&have_obj, &want_obj, 0);
+			}
 			state = FETCH_DONE;
 			break;
 		case FETCH_DONE:
-- 
2.19.0.271.gfe8321ec05.dirty

