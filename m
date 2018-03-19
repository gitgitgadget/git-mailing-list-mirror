Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086D01F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeCSNeZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:34:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33524 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755518AbeCSNcW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:22 -0400
Received: by mail-wr0-f195.google.com with SMTP id z73so14358753wrb.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WZ6UikoxKFkLKzeBssfk96QYKc2748vmTifaiR9tAwM=;
        b=s6y0Bsdo3kP9AGgNgmyp1J11KEFtcqwssfxTHVvk4i33PxLJAtUxdhoNtQglyNF6DL
         RUxmevgqHbEC6fiaIdrBUwC5y/sq9NPVpQs17MYYqUpUEElr5ni1pXlGT4ldLWIXjD9w
         UAKo4ZmOlyrHUrmgHOaLRX9NwEyI46vPjFRRJ75Liuo0iwnqpCgl+fxCPnMMMCVF04mo
         WgSWSMMnHIGZSHBtX1EZ4F55dV8xLG+0pd4d4vSACbUF05n11JP82Ry78UeteSydW8Q8
         GZQyjmRrSVNIpuEOnQGz8WNyC25Hg9YQIHY8JxiW+I80lYKa89lWEKg/oXIwupGlFNEz
         GI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WZ6UikoxKFkLKzeBssfk96QYKc2748vmTifaiR9tAwM=;
        b=DJn9Lyb0wQGzeGAyKal113Bkr4W8aDCZcCDUrOXbf+xC8t6X98c5ORRQj+ZzO0GSot
         443DnjHcG8b8xmQt1WzVunaajOqQ4ve6j4CL8i9GTTBC/0abWtjY6ujGLo+Z2yaQtssL
         LoVKmqvwTdLi7ZIdcs65h7OVk6EGtGzViPNP5ij7+G4kIc2yskX/knCSev1yP87aFdbW
         Rqn2yGXy962LMrw5Db5TzoaydcHCCD6ZBkCtHE7MwUxqQBsa18t60vi+wSSAU4Phcm/R
         Q1l1qC2LrU59QDuFzAMKqqaMYut4yBsoESLKCQXtR9U3QcfZAkJdOB2358sgbw0imZkv
         yrzQ==
X-Gm-Message-State: AElRT7GGcgShSdQ7AC+m7e2ggxlLVx6uCS+QX+Ux3x4FgiL5bNT2SXTn
        eCUVon+BrpBkXwza1d1FfKJvDyl0
X-Google-Smtp-Source: AG47ELsMEzrJLmIVkZNk3ijVnYRHa24Fh9gFvdV9HFdRCspoHTC0vad8tVLAGTJROfY5SI/i+komhw==
X-Received: by 10.223.156.10 with SMTP id f10mr10194996wrc.174.1521466340818;
        Mon, 19 Mar 2018 06:32:20 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:20 -0700 (PDT)
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
Subject: [PATCH v2 09/36] external-odb: add script mode support
Date:   Mon, 19 Mar 2018 14:31:20 +0100
Message-Id: <20180319133147.15413-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds support for the script command mode where
an helper script or command is called to retrieve or
manage objects.

This implements the 'have' and 'get_git_obj'
instructions for the script mode.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c          |  55 +++++++++-
 external-odb.h          |   1 +
 odb-helper.c            | 218 +++++++++++++++++++++++++++++++++++++++-
 odb-helper.h            |   4 +
 sha1_file.c             |  12 ++-
 t/t0500-external-odb.sh |  44 ++++++++
 6 files changed, 331 insertions(+), 3 deletions(-)
 create mode 100755 t/t0500-external-odb.sh

diff --git a/external-odb.c b/external-odb.c
index 82ac80aa04..ec1ec82dd9 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -33,8 +33,14 @@ static int external_odb_config(const char *var, const char *value, void *data)
 
 	o = find_or_create_helper(name, namelen);
 
-	if (!strcmp(subkey, "promisorremote"))
+	if (!strcmp(subkey, "promisorremote")) {
+		o->type = ODB_HELPER_GIT_REMOTE;
 		return git_config_string(&o->dealer, var, value);
+	}
+	if (!strcmp(subkey, "scriptcommand")) {
+		o->type = ODB_HELPER_SCRIPT_CMD;
+		return git_config_string(&o->dealer, var, value);
+	}
 
 	return 0;
 }
@@ -100,6 +106,53 @@ int external_odb_has_object(const unsigned char *sha1)
 	return 0;
 }
 
+int external_odb_get_object(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+	struct strbuf pathbuf = STRBUF_INIT;
+
+	if (!external_odb_has_object(sha1))
+		return -1;
+
+	sha1_file_name_alt(&pathbuf, external_odb_root(), sha1);
+	safe_create_leading_directories_const(pathbuf.buf);
+	prepare_external_alt_odb();
+
+	for (o = helpers; o; o = o->next) {
+		struct strbuf tmpfile = STRBUF_INIT;
+		int ret;
+		int fd;
+
+		if (!odb_helper_has_object(o, sha1))
+			continue;
+
+		fd = create_object_tmpfile(&tmpfile, pathbuf.buf);
+		if (fd < 0) {
+			strbuf_release(&tmpfile);
+			strbuf_release(&pathbuf);
+			return -1;
+		}
+
+		if (odb_helper_get_object(o, sha1, fd) < 0) {
+			close(fd);
+			unlink(tmpfile.buf);
+			strbuf_release(&tmpfile);
+			continue;
+		}
+
+		close_sha1_file(fd);
+		ret = finalize_object_file(tmpfile.buf, pathbuf.buf);
+		strbuf_release(&tmpfile);
+		strbuf_release(&pathbuf);
+		if (!ret)
+			return 0;
+	}
+
+	strbuf_release(&pathbuf);
+
+	return -1;
+}
+
 int external_odb_get_direct(const unsigned char *sha1)
 {
 	struct odb_helper *o;
diff --git a/external-odb.h b/external-odb.h
index 254070994a..c5ac071995 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -15,6 +15,7 @@ extern struct odb_helper *find_odb_helper(const char *dealer,
 					  enum odb_helper_type type);
 extern const char *external_odb_root(void);
 extern int external_odb_has_object(const unsigned char *sha1);
+extern int external_odb_get_object(const unsigned char *sha1);
 extern int external_odb_get_direct(const unsigned char *sha1);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
index c6127ce81f..677ea850a5 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -21,13 +21,124 @@ struct odb_helper_cmd {
 	struct child_process child;
 };
 
+/*
+ * Callers are responsible to ensure that the result of vaddf(fmt, ap)
+ * is properly shell-quoted.
+ */
+static void prepare_helper_command(struct argv_array *argv, const char *cmd,
+				   const char *fmt, va_list ap)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addstr(&buf, cmd);
+	strbuf_addch(&buf, ' ');
+	strbuf_vaddf(&buf, fmt, ap);
+
+	argv_array_push(argv, buf.buf);
+	strbuf_release(&buf);
+}
+
+__attribute__((format (printf,3,4)))
+static int odb_helper_start(struct odb_helper *o,
+			    struct odb_helper_cmd *cmd,
+			    const char *fmt, ...)
+{
+	va_list ap;
+
+	memset(cmd, 0, sizeof(*cmd));
+	argv_array_init(&cmd->argv);
+
+	if (!o->dealer)
+		return -1;
+
+	va_start(ap, fmt);
+	prepare_helper_command(&cmd->argv, o->dealer, fmt, ap);
+	va_end(ap);
+
+	cmd->child.argv = cmd->argv.argv;
+	cmd->child.use_shell = 1;
+	cmd->child.no_stdin = 1;
+	cmd->child.out = -1;
+
+	if (start_command(&cmd->child) < 0) {
+		argv_array_clear(&cmd->argv);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int odb_helper_finish(struct odb_helper *o,
+			     struct odb_helper_cmd *cmd)
+{
+	int ret = finish_command(&cmd->child);
+	argv_array_clear(&cmd->argv);
+	if (ret) {
+		warning("odb helper '%s' reported failure", o->name);
+		return -1;
+	}
+	return 0;
+}
+
+static int parse_object_line(struct odb_helper_object *o, const char *line)
+{
+	char *end;
+	if (get_oid_hex(line, &o->oid) < 0)
+		return -1;
+
+	line += 40;
+	if (*line++ != ' ')
+		return -1;
+
+	o->size = strtoul(line, &end, 10);
+	if (line == end || *end++ != ' ')
+		return -1;
+
+	o->type = type_from_string(end);
+	return 0;
+}
+
+static int add_have_entry(struct odb_helper *o, const char *line)
+{
+	ALLOC_GROW(o->have, o->have_nr+1, o->have_alloc);
+	if (parse_object_line(&o->have[o->have_nr], line) < 0) {
+		warning("bad 'have' input from odb helper '%s': %s",
+			o->name, line);
+		return 1;
+	}
+	o->have_nr++;
+	return 0;
+}
+
+static int odb_helper_object_cmp(const void *va, const void *vb)
+{
+	const struct odb_helper_object *a = va, *b = vb;
+	return oidcmp(&a->oid, &b->oid);
+}
+
 static void odb_helper_load_have(struct odb_helper *o)
 {
+	struct odb_helper_cmd cmd;
+	FILE *fh;
+	struct strbuf line = STRBUF_INIT;
+
 	if (o->have_valid)
 		return;
 	o->have_valid = 1;
 
-	/* TODO */
+	if (odb_helper_start(o, &cmd, "have") < 0)
+		return;
+
+	fh = xfdopen(cmd.child.out, "r");
+	while (strbuf_getline(&line, fh) != EOF)
+		if (add_have_entry(o, line.buf))
+			break;
+
+	strbuf_release(&line);
+	fclose(fh);
+	odb_helper_finish(o, &cmd);
+
+	qsort(o->have, o->have_nr, sizeof(*o->have), odb_helper_object_cmp);
 }
 
 static const unsigned char *have_sha1_access(size_t index, void *table)
@@ -53,6 +164,111 @@ int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
 	return !!odb_helper_lookup(o, sha1);
 }
 
+int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
+			    int fd)
+{
+	struct odb_helper_object *obj;
+	struct odb_helper_cmd cmd;
+	unsigned long total_got;
+	git_zstream stream;
+	int zret = Z_STREAM_END;
+	git_SHA_CTX hash;
+	unsigned char real_sha1[20];
+	struct strbuf header = STRBUF_INIT;
+	unsigned long hdr_size;
+
+	obj = odb_helper_lookup(o, sha1);
+	if (!obj)
+		return -1;
+
+	if (odb_helper_start(o, &cmd, "get_git_obj %s", sha1_to_hex(sha1)) < 0)
+		return -1;
+
+	memset(&stream, 0, sizeof(stream));
+	git_inflate_init(&stream);
+	git_SHA1_Init(&hash);
+	total_got = 0;
+
+	for (;;) {
+		unsigned char buf[4096];
+		int r;
+
+		r = xread(cmd.child.out, buf, sizeof(buf));
+		if (r < 0) {
+			error("unable to read from odb helper '%s': %s",
+			      o->name, strerror(errno));
+			close(cmd.child.out);
+			odb_helper_finish(o, &cmd);
+			git_inflate_end(&stream);
+			return -1;
+		}
+		if (r == 0)
+			break;
+
+		write_or_die(fd, buf, r);
+
+		stream.next_in = buf;
+		stream.avail_in = r;
+		do {
+			unsigned char inflated[4096];
+			unsigned long got;
+
+			stream.next_out = inflated;
+			stream.avail_out = sizeof(inflated);
+			zret = git_inflate(&stream, Z_SYNC_FLUSH);
+			got = sizeof(inflated) - stream.avail_out;
+
+			git_SHA1_Update(&hash, inflated, got);
+			/* skip header when counting size */
+			if (!total_got) {
+				const unsigned char *p = memchr(inflated, '\0', got);
+				if (p) {
+					unsigned long hdr_last = p - inflated + 1;
+					strbuf_add(&header, inflated, hdr_last);
+					got -= hdr_last;
+				} else {
+					strbuf_add(&header, inflated, got);
+					got = 0;
+				}
+			}
+			total_got += got;
+		} while (stream.avail_in && zret == Z_OK);
+	}
+
+	close(cmd.child.out);
+	git_inflate_end(&stream);
+	git_SHA1_Final(real_sha1, &hash);
+	if (odb_helper_finish(o, &cmd))
+		return -1;
+	if (zret != Z_STREAM_END) {
+		warning("bad zlib data from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
+	if (total_got != obj->size) {
+		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
+			o->name, sha1_to_hex(sha1), total_got, obj->size);
+		return -1;
+	}
+	if (hashcmp(real_sha1, sha1)) {
+		warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
+			o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
+		return -1;
+	}
+	if (parse_sha1_header(header.buf, &hdr_size) < 0) {
+		warning("could not parse header from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
+	if (total_got != hdr_size) {
+		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
+			o->name, sha1_to_hex(sha1), total_got, hdr_size);
+		return -1;
+	}
+
+	return 0;
+}
+
 int odb_helper_get_direct(struct odb_helper *o,
 			  const unsigned char *sha1)
 {
diff --git a/odb-helper.h b/odb-helper.h
index d4b968693f..819182f76a 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -23,6 +23,10 @@ struct odb_helper {
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
 extern int odb_helper_has_object(struct odb_helper *o,
 				 const unsigned char *sha1);
+extern int odb_helper_get_object(struct odb_helper *o,
+				 const unsigned char *sha1,
+				 int fd);
 extern int odb_helper_get_direct(struct odb_helper *o,
 				 const unsigned char *sha1);
+
 #endif /* ODB_HELPER_H */
diff --git a/sha1_file.c b/sha1_file.c
index c460eb2658..847883f261 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -907,6 +907,9 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 			return 0;
 	}
 
+	if (!external_odb_get_object(sha1) && !lstat(*path, st))
+		return 0;
+
 	return -1;
 }
 
@@ -946,7 +949,14 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	if (fd >= 0)
 		return fd;
 
-	return open_sha1_file_alt(sha1, path);
+	fd = open_sha1_file_alt(sha1, path);
+	if (fd >= 0)
+		return fd;
+
+	if (!external_odb_get_object(sha1))
+		fd = open_sha1_file_alt(sha1, path);
+
+	return fd;
 }
 
 /*
diff --git a/t/t0500-external-odb.sh b/t/t0500-external-odb.sh
new file mode 100755
index 0000000000..eaa3688a31
--- /dev/null
+++ b/t/t0500-external-odb.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='basic tests for external object databases'
+
+. ./test-lib.sh
+
+ALT_SOURCE="$PWD/alt-repo/.git"
+export ALT_SOURCE
+write_script odb-helper <<\EOF
+GIT_DIR=$ALT_SOURCE; export GIT_DIR
+case "$1" in
+have)
+	git cat-file --batch-check --batch-all-objects |
+	awk '{print $1 " " $3 " " $2}'
+	;;
+get_git_obj)
+	cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
+	;;
+esac
+EOF
+HELPER="\"$PWD\"/odb-helper"
+
+test_expect_success 'setup alternate repo' '
+	git init alt-repo &&
+	test_commit -C alt-repo one &&
+	test_commit -C alt-repo two &&
+	alt_head=$(git -C alt-repo rev-parse HEAD)
+'
+
+test_expect_success 'alt objects are missing' '
+	test_must_fail git log --format=%s $alt_head
+'
+
+test_expect_success 'helper can retrieve alt objects' '
+	test_config odb.magic.scriptCommand "$HELPER" &&
+	cat >expect <<-\EOF &&
+	two
+	one
+	EOF
+	git log --format=%s $alt_head >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.17.0.rc0.37.g8f476fabe9

