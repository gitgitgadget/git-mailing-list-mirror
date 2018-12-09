Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C077F20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbeLIKZg (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:25:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39274 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLIKZg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:25:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so5939562lfh.6
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbXoGKlJEEf1reOV3wmiJqFXq46iANs252DJzk6aiWI=;
        b=A/BpO8O0hRbQodqzRlUqugqpfoBuEFLrQ3VgbFFXa8d4IAVk0i0KHvarcxcVHLsNio
         mL7uVGKhKl+nBgebVdFUf0D9910c1BQb0IXkmsEiogNY9nCvJNmiRCHgxHS1tWrUZAfb
         Ua8Vo6OrIRJEXHw6wI2ZqDN0243BcrHJIb9P6l78B/gxf8fjXpcqDaUawAMZP4X8fqZs
         uSihpcftOgA3+e3VmfLOvoqA51C7s9v/eKtngO94BST+y4GGfZLUy7RBXe0HoJcuZpTg
         Wq82zKuNox3/+RwlDUTi0loitMvXleNye3heyD0xFEjpN+BMvH4laJsOyDR7aamenCIq
         BWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbXoGKlJEEf1reOV3wmiJqFXq46iANs252DJzk6aiWI=;
        b=im0nkQFStEuJE5vfAuo4odjsDCXv0qk3h0/IzG6BRCiEZ69yfNInSJFv76PHWxO5Ve
         jvQtrvtzhNkSYfHqIOWHOO6h0skGwr1tpO31ueMt5QlQabIakz7tGrcvFeA83qRmnIUQ
         mS25CQ1CCCgf2WEKXFRCFoxrWM4FRwIst/EohuPhD4NftjCdX/PV3SRVEoDeaS9K7gVH
         jIMdlOpKbS73v1RtDhWpsPyCrnE58wF02J1a3VctNgxfmEcHG4VN/nOQ32kTdEyVWK3M
         PbCJnLelnkTno5f7FeFHAFr4QaqaGbgvBWnmlHuPq/MoLnatIOcKd0jY2Rfkbf8NeyzN
         6VHQ==
X-Gm-Message-State: AA+aEWb3AJO1SVhGRTgYrn2NUsFiFyRH5AaTxZDhyfH9Xmc78JDC4AkX
        F0BP2TwALDhnx45HEMVw2Y0kZAhM
X-Google-Smtp-Source: AFSGD/ULzraVH1EwUVHwuNN1fFm+ZXv+eQgj6kR8v6mjjVTBkA5ep1RkW/rqRmeCaZkh0vPWaGjvrQ==
X-Received: by 2002:a19:f115:: with SMTP id p21mr4491418lfh.20.1544351132640;
        Sun, 09 Dec 2018 02:25:32 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id v64sm1534246lfa.48.2018.12.09.02.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:25:31 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] style: the opening '{' of a function is in a separate line
Date:   Sun,  9 Dec 2018 11:25:21 +0100
Message-Id: <20181209102521.5301-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 bisect.c                   | 3 ++-
 builtin/config.c           | 3 ++-
 builtin/push.c             | 4 +++-
 convert.c                  | 3 ++-
 credential-cache--daemon.c | 3 ++-
 diff.c                     | 6 ++++--
 git.c                      | 3 ++-
 imap-send.c                | 3 ++-
 remote-curl.c              | 3 ++-
 sequencer.c                | 6 ++++--
 string-list.c              | 3 ++-
 t/helper/test-sigchain.c   | 3 ++-
 transport-helper.c         | 3 ++-
 url.c                      | 3 ++-
 userdiff.c                 | 3 ++-
 15 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/bisect.c b/bisect.c
index 487675c672..bd140cde36 100644
--- a/bisect.c
+++ b/bisect.c
@@ -558,7 +558,8 @@ struct commit_list *filter_skipped(struct commit_list *list,
  * is increased by one between each call, but that should not matter
  * for this application.
  */
-static unsigned get_prn(unsigned count) {
+static unsigned get_prn(unsigned count)
+{
 	count = count * 1103515245 + 12345;
 	return (count/65536) % PRN_MODULO;
 }
diff --git a/builtin/config.c b/builtin/config.c
index 84385ef165..99bc7ef64e 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -164,7 +164,8 @@ static NORETURN void usage_builtin_config(void)
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
 
-static void check_argc(int argc, int min, int max) {
+static void check_argc(int argc, int min, int max)
+{
 	if (argc >= min && argc <= max)
 		return;
 	if (min == max)
diff --git a/builtin/push.c b/builtin/push.c
index 8bb8a0849b..759812d1d5 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -143,7 +143,9 @@ static int push_url_of_remote(struct remote *remote, const char ***url_p)
 	return remote->url_nr;
 }
 
-static NORETURN int die_push_simple(struct branch *branch, struct remote *remote) {
+static NORETURN int die_push_simple(struct branch *branch,
+				    struct remote *remote)
+{
 	/*
 	 * There's no point in using shorten_unambiguous_ref here,
 	 * as the ambiguity would be on the remote side, not what
diff --git a/convert.c b/convert.c
index e0848226d2..bc40f01eb4 100644
--- a/convert.c
+++ b/convert.c
@@ -778,7 +778,8 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 
 static void handle_filter_error(const struct strbuf *filter_status,
 				struct cmd2process *entry,
-				const unsigned int wanted_capability) {
+				const unsigned int wanted_capability)
+{
 	if (!strcmp(filter_status->buf, "error"))
 		; /* The filter signaled a problem with the file. */
 	else if (!strcmp(filter_status->buf, "abort") && wanted_capability) {
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 4dfbc8c9f9..ec1271f89c 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -91,7 +91,8 @@ static timestamp_t check_expirations(void)
 }
 
 static int read_request(FILE *fh, struct credential *c,
-			struct strbuf *action, int *timeout) {
+			struct strbuf *action, int *timeout)
+{
 	static struct strbuf item = STRBUF_INIT;
 	const char *p;
 
diff --git a/diff.c b/diff.c
index dc9965e836..b5f573cf7a 100644
--- a/diff.c
+++ b/diff.c
@@ -1637,7 +1637,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	strbuf_release(&msgbuf);
 }
 
-static struct diff_tempfile *claim_diff_tempfile(void) {
+static struct diff_tempfile *claim_diff_tempfile(void)
+{
 	int i;
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
 		if (!diff_temp[i].name)
@@ -4819,7 +4820,8 @@ static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
 	return 0;
 }
 
-static void enable_patch_output(int *fmt) {
+static void enable_patch_output(int *fmt)
+{
 	*fmt &= ~DIFF_FORMAT_NO_OUTPUT;
 	*fmt |= DIFF_FORMAT_PATCH;
 }
diff --git a/git.c b/git.c
index 2f604a41ea..d69beaf3b0 100644
--- a/git.c
+++ b/git.c
@@ -98,7 +98,8 @@ static int list_cmds(const char *spec)
 	return 0;
 }
 
-static void commit_pager_choice(void) {
+static void commit_pager_choice(void)
+{
 	switch (use_pager) {
 	case 0:
 		setenv("GIT_PAGER", "cat", 1);
diff --git a/imap-send.c b/imap-send.c
index b4eb886e2a..18ca6ba10a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1471,7 +1471,8 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 }
 
 static int curl_append_msgs_to_imap(struct imap_server_conf *server,
-				    struct strbuf* all_msgs, int total) {
+				    struct strbuf* all_msgs, int total)
+{
 	int ofs = 0;
 	int n = 0;
 	struct buffer msgbuf = { STRBUF_INIT, 0 };
diff --git a/remote-curl.c b/remote-curl.c
index 1220dffcdc..90d565c8c5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -617,7 +617,8 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	return err;
 }
 
-static curl_off_t xcurl_off_t(size_t len) {
+static curl_off_t xcurl_off_t(size_t len)
+{
 	uintmax_t size = len;
 	if (size > maximum_signed_value_of_type(curl_off_t))
 		die("cannot handle pushes this big");
diff --git a/sequencer.c b/sequencer.c
index e1a4dd15f1..55b609a7f4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1670,7 +1670,8 @@ static int update_squash_messages(enum todo_command command,
 	return res;
 }
 
-static void flush_rewritten_pending(void) {
+static void flush_rewritten_pending(void)
+{
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id newoid;
 	FILE *out;
@@ -1695,7 +1696,8 @@ static void flush_rewritten_pending(void) {
 }
 
 static void record_in_rewritten(struct object_id *oid,
-		enum todo_command next_command) {
+		enum todo_command next_command)
+{
 	FILE *out = fopen_or_warn(rebase_path_rewritten_pending(), "a");
 
 	if (!out)
diff --git a/string-list.c b/string-list.c
index 1f6063f2a2..a917955fbd 100644
--- a/string-list.c
+++ b/string-list.c
@@ -155,7 +155,8 @@ static int item_is_not_empty(struct string_list_item *item, void *unused)
 	return *item->string != '\0';
 }
 
-void string_list_remove_empty_items(struct string_list *list, int free_util) {
+void string_list_remove_empty_items(struct string_list *list, int free_util)
+{
 	filter_string_list(list, free_util, item_is_not_empty, NULL);
 }
 
diff --git a/t/helper/test-sigchain.c b/t/helper/test-sigchain.c
index 77ac5bc33f..d013bccdda 100644
--- a/t/helper/test-sigchain.c
+++ b/t/helper/test-sigchain.c
@@ -14,7 +14,8 @@ X(two)
 X(three)
 #undef X
 
-int cmd__sigchain(int argc, const char **argv) {
+int cmd__sigchain(int argc, const char **argv)
+{
 	sigchain_push(SIGTERM, one);
 	sigchain_push(SIGTERM, two);
 	sigchain_push(SIGTERM, three);
diff --git a/transport-helper.c b/transport-helper.c
index bf225c698f..4702e150f0 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1026,7 +1026,8 @@ static int push_refs(struct transport *transport,
 }
 
 
-static int has_attribute(const char *attrs, const char *attr) {
+static int has_attribute(const char *attrs, const char *attr)
+{
 	int len;
 	if (!attrs)
 		return 0;
diff --git a/url.c b/url.c
index eaf4f07081..25576c390b 100644
--- a/url.c
+++ b/url.c
@@ -104,7 +104,8 @@ void end_url_with_slash(struct strbuf *buf, const char *url)
 	strbuf_complete(buf, '/');
 }
 
-void str_end_url_with_slash(const char *url, char **dest) {
+void str_end_url_with_slash(const char *url, char **dest)
+{
 	struct strbuf buf = STRBUF_INIT;
 	end_url_with_slash(&buf, url);
 	free(*dest);
diff --git a/userdiff.c b/userdiff.c
index 46d34cc2a4..e0579522bd 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -265,7 +265,8 @@ int userdiff_config(const char *k, const char *v)
 	return 0;
 }
 
-struct userdiff_driver *userdiff_find_by_name(const char *name) {
+struct userdiff_driver *userdiff_find_by_name(const char *name)
+{
 	int len = strlen(name);
 	return userdiff_find_by_namelen(name, len);
 }
-- 
2.20.0.rc2.486.g9832c05c3d

