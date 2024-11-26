Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B56139D07
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732619988; cv=none; b=gqvOPGlwn75wYWH+mHjrHYpP0AxldjUL9VDtvuj1ip8brGSpKbEHHbrduKSDGXT73IEw9KvEtZj934ziKoU0jSNqk6BwAo/0mq/MAPHosYmyV3LaxNDAb8Mq6WeGHivAnvwLGf4E7yIIxgKGCnWkYuQY7m2A7q6ayYBtXNbk6sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732619988; c=relaxed/simple;
	bh=0XucMJO3HEgpNY2lI+/v6/oodhjbUT+m+TEjTa1ZGXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=NlZHTmFEstjP/kcQSIpjMqLSS5N3sZ85bJj4gb2GpjDi2zfLXuJt0hZ+EX+pkior8mqMIzwLDe9OAtAL3KBS0nli4RzqDM2yPmjLPMlIKLTsf5A2XLPpKWYPZLQsyZD5k1AAn4P8Koa5R0KgHY55XNqULemABbecoc2pjoDJ+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcyIJm5r; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcyIJm5r"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de92be287so1178613e87.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 03:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732619981; x=1733224781; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/xJE5IVbQ99khNfESgc3zoVVR7tGD9MTgODlUtrmfk=;
        b=bcyIJm5r0aLXygjbxKQstrW1kDpTC+lcxl9SNE1/EMjUfE8qQTfejGVDKZi90UvSt0
         3WD/uznX+wEtCiJ79yCkmgkkNwzYiq8S5JYjQW5wzu6UYwnFV7G+T+rGHdixjxPx0wdL
         fIffKtlqEkVZqKIOxFC8XOMWIx9moFQafts3I5p1mWsnDk+PmlUlPXS8qKQtnRX+DA6s
         YQT9dAwFZcFp9WAPsYmQKFi8cwNkILojOijGGJ0B8rfbWGw5WwP6ttaS58omG/Y6Z+Kw
         +6iZfM3rjF2nGIFx8C3KB1eRmqWcSEMmH7Do1IKzOEf/F8JYETvxDcYut6U7g2wP3P9W
         Mq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732619981; x=1733224781;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/xJE5IVbQ99khNfESgc3zoVVR7tGD9MTgODlUtrmfk=;
        b=TTkdtnvn5utO2iipYpjeTWPnlb5T7GGFg8GBf/EDwwzo+7PhWm228oV+TBK7LFrjkR
         irwKFqLAQrJgwXU8o9Vy4VJSL+n7GmOAH3O0OnUDH3bezsLGezmdo9AAN8lR6wuWKVF+
         Qz+nyro2VoKFZiXLaQn0f1IQPgjjZIQHKNPVoZTF8NLdDgUSdfJ7uasFKNbBTda3wWTV
         e93vhgztYGtQSrEyi+gPoWNuaZCxQUDIuIDwAoBZaPti8cnMlKwIgKOjP1/CdbSX5KNJ
         /vxE7dlwQY9B1wrzHdlshrVHT/bB/KjleszFuLyRggDsF5CoO8cXfL6/D6roRWUU9res
         Qiaw==
X-Gm-Message-State: AOJu0Yynh3j3e9oBiatg1RydMc2QThNVgoYxCbWksJuEoQuWIA/p5i6P
	h2TsmFrE/2f3++Fg42CXBj8K/RnwB0/13Irr6KBjzsTYlgY7HuhN
X-Gm-Gg: ASbGncsGKTGBmH8Y7+dBTHShmHeVrbGXvYFd98godhfBFxJq6kT+YIf004AoawWsvzX
	5gJTmhg58fk2z39sda10lhETDV0cJhRHq9JyoJ99GMlCb+p7l/7VxWWYvPLkxwvXaeprxcZB6eM
	y6SmDRSfo4vSVcQ3vePuR+mZtGvy0Dqn3QzOX2VIDQKJCgVVdxTKSdPhl9J5KrCYqkXhbbUCuiu
	pcOkwQZnjv5xNrQEgxtu0segmbt+dag9jIxhh6/ByReH7jT/dY=
X-Google-Smtp-Source: AGHT+IEpWanDu9ZgVbRUALdq9ommzEkLApkOuLCay89McmPZNKKkE/wWDp4lplHfVX503HJ8FS4bbA==
X-Received: by 2002:a05:6512:12cb:b0:53d:eecf:e25d with SMTP id 2adb3069b0e04-53deecfe960mr82042e87.37.1732619980700;
        Tue, 26 Nov 2024 03:19:40 -0800 (PST)
Received: from [10.82.5.93] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa53e293078sm385537266b.125.2024.11.26.03.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 03:19:40 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 26 Nov 2024 12:19:22 +0100
Subject: [PATCH v2] builtin: allow passing custom data to sub-commands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-374-add-repository-to-subsubcommands-v2-1-417e0dc66c75@gmail.com>
X-B4-Tracking: v=1; b=H4sIALquRWcC/43PwW7CMAwG4Fepcl4QcdqUVmjiPRAHtzEQaUlYH
 CoQ6rsvLdt9ki+/D/9nvwRTcsSir14i0eTYxVACfFRivGK4kHS2ZAFbqJUCkLqtJVorE90iuxz
 TU+Yo+T6UGaP3GCxLAIO6U7ZrxlaUqluis3uszPH0zom+70XL76XwxIyr1lf7P0yBVnq3MaYzW
 6nkQGGkw5mSdaEwz03xPpf6AZnkgrvcVx45UxILc3W8HLg+N6nV+a1u/vfHpAprdIsNAQxY7w4
 Xj+5rgcVpnucfIryVPz8BAAA=
X-Change-ID: 20241122-374-add-repository-to-subsubcommands-226a391d95c7
In-Reply-To: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
References: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, shejialuo@gmail.com, 
 Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=105458;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=0XucMJO3HEgpNY2lI+/v6/oodhjbUT+m+TEjTa1ZGXY=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnRa7LTckOnYpjOVyVJHUJcuX8dbkZIoJqdIuyb
 K/h2KNToDKJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ0WuywAKCRA+1Z8kjkaM
 f0ZnC/9iYQo2yCo570t/VLAGcy5xuSJ9IzBvvheZByCmWpNohxhPiX+4A8lywfumcqsOF0UIt2r
 p1oAjXCSBuYvpxk2czDWmZJzvUUp7bXDVlLFhY4htl2QPBmBnTeND7r0bIGNu2IkLCyAvuhpO8y
 w99i4+HqfbiwPy9HqLFySchsAR4sHu4lvfVcjKtauj/cZJICHsYO6yzBp5xpxYWSZXfrLAlPDIM
 0uPbohUJjYzMaArVeoXhzSa2Y1BprnQ5/D4q/XZjg4kfXX2vHzhL8MxkHKtY8bIJQk9NDCFHGN0
 d2+w5MCerEZ7vPns4woIfOamfLe9ImTBw5iimS/5TEZbG6fNC8LsXvrNnW7eOuBUFLnOJ1x5DcU
 ib+/5Wp9uUCYhIDmF02et/qB8QOtourkGRFay2GFjLCX69Ptkq0SnYkpgNQ0LK5R6KE/aGGs+QN
 c5jxk5AiTXd6kxtp9TYI300mjpteaS++YYXdZYdw1F/gp58eDR/gd1Q1Nha/21mS4Hnko=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 9b1cb5070f (builtin: add a repository parameter for builtin
functions, 2024-09-13) the repository was passed down to all builtin
commands. This allowed the repository to be passed down to lower layers
without depending on the global `the_repository` variable.

To remove usage of global variables like `the_repository` in
sub-commands, it makes sense to pass down the repository value from the
commands to the sub-commands. But let's make it more generic and modify
`parse_opt_subcommand_fn` to instead take a `void *` value. This way we
can provide custom structures to each sub-command.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
This patch was part of my series to clean up the midx.c and midx-write.c
files from using global variables [1]. Since this patch stands on its own,
I've split it from the series. This should help merging this quicker
since it affects a lot more files but is isolated to one patch. 

I will re-send a new version of the series to depend on this patch. 

This patch conflicts with 'gitster/bf/set-head-symref' on seen. But it is 
not a dependency and the resolution should be simple enough. Happy to
resend after merging that in if needed. 

[1]: https://lore.kernel.org/all/20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com/
---
Changes in v2:
- Change from sending `repository *` to `void *`. This makes it more generic
  and allows us to send custom structures to sub-commands. Thanks Patrick. 
- Link to v1: https://lore.kernel.org/r/20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com
---
 builtin/bisect.c              | 29 ++++++++++++++++++----------
 builtin/bundle.c              | 14 +++++++++-----
 builtin/commit-graph.c        |  8 +++++---
 builtin/config.c              | 23 ++++++++++++++--------
 builtin/gc.c                  | 19 ++++++++++++-------
 builtin/hook.c                |  5 +++--
 builtin/multi-pack-index.c    | 10 +++++-----
 builtin/notes.c               | 34 +++++++++++++++++++++------------
 builtin/reflog.c              | 21 +++++++++++++--------
 builtin/refs.c                |  8 +++++---
 builtin/remote.c              | 32 ++++++++++++++++++++-----------
 builtin/sparse-checkout.c     | 21 +++++++++++++--------
 builtin/stash.c               | 37 +++++++++++++++++++++++-------------
 builtin/submodule--helper.c   | 44 ++++++++++++++++++++++++++++---------------
 builtin/worktree.c            | 26 ++++++++++++++++---------
 parse-options.h               |  2 +-
 t/helper/test-parse-options.c |  8 +++++---
 17 files changed, 218 insertions(+), 123 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 21d17a6c1a83e51fb82b53703b95d89bd9028830..dde7a8c6590b1b56ac123fcfd15c1e900ae0fdce 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1312,7 +1312,8 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 	return res;
 }
 
-static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED,
+			     void *data UNUSED)
 {
 	if (argc > 1)
 		return error(_("'%s' requires either no argument or a commit"),
@@ -1320,7 +1321,8 @@ static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNU
 	return bisect_reset(argc ? argv[0] : NULL);
 }
 
-static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
+			     void *data UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1333,7 +1335,8 @@ static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNU
 	return res;
 }
 
-static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNUSED,
+			     void *data UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1344,7 +1347,8 @@ static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNU
 	return res;
 }
 
-static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *prefix)
+static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *prefix,
+			    void *data UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1358,12 +1362,14 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 	return res;
 }
 
-static int cmd_bisect__log(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED)
+static int cmd_bisect__log(int argc UNUSED, const char **argv UNUSED,
+			   const char *prefix UNUSED, void *data UNUSED)
 {
 	return bisect_log();
 }
 
-static int cmd_bisect__replay(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__replay(int argc, const char **argv, const char *prefix UNUSED,
+			      void *data UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1376,7 +1382,8 @@ static int cmd_bisect__replay(int argc, const char **argv, const char *prefix UN
 	return res;
 }
 
-static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUSED,
+			    void *data UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1388,7 +1395,8 @@ static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUS
 	return res;
 }
 
-static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix UNUSED,
+				 void *data UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1399,7 +1407,8 @@ static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix
 	return res;
 }
 
-static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSED)
+static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSED,
+			   void *data UNUSED)
 {
 	int res;
 	struct bisect_terms terms = { 0 };
@@ -1451,7 +1460,7 @@ int cmd_bisect(int argc,
 	} else {
 		argc--;
 		argv++;
-		res = fn(argc, argv, prefix);
+		res = fn(argc, argv, prefix, NULL);
 	}
 
 	return is_bisect_success(res) ? 0 : -res;
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 127518c2a8d3c4ec0bde62f1932e964ce9bcf66f..dfb8d16300c96994b8d0add62174b498384aa367 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -67,7 +67,8 @@ static int parse_options_cmd_bundle(int argc,
 	return argc;
 }
 
-static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
+static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
+			     void *data UNUSED) {
 	struct strvec pack_opts = STRVEC_INIT;
 	int version = -1;
 	int ret;
@@ -123,7 +124,8 @@ static int open_bundle(const char *path, struct bundle_header *header,
 	return read_bundle_header(path, header);
 }
 
-static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
+static int cmd_bundle_verify(int argc, const char **argv, const char *prefix,
+			     void *data UNUSED) {
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int quiet = 0;
@@ -164,7 +166,8 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 	return ret;
 }
 
-static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix) {
+static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix,
+				 void *data UNUSED) {
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int ret;
@@ -189,7 +192,8 @@ static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix
 	return ret;
 }
 
-static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix) {
+static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix,
+			       void *data UNUSED) {
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int ret;
@@ -247,5 +251,5 @@ int cmd_bundle(int argc,
 
 	packet_trace_identity("bundle");
 
-	return !!fn(argc, argv, prefix);
+	return !!fn(argc, argv, prefix, NULL);
 }
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 7c991db6eb48ad6e935727a079abac02bb358f8a..8eeef506f5ca75b337e59fe2b0fc82bd76948710 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -62,7 +62,8 @@ static struct option *add_common_options(struct option *to)
 	return parse_options_concat(common_opts, to);
 }
 
-static int graph_verify(int argc, const char **argv, const char *prefix)
+static int graph_verify(int argc, const char **argv, const char *prefix,
+			void *data UNUSED)
 {
 	struct commit_graph *graph = NULL;
 	struct object_directory *odb = NULL;
@@ -214,7 +215,8 @@ static int git_commit_graph_write_config(const char *var, const char *value,
 	return 0;
 }
 
-static int graph_write(int argc, const char **argv, const char *prefix)
+static int graph_write(int argc, const char **argv, const char *prefix,
+		       void *data UNUSED)
 {
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
@@ -352,5 +354,5 @@ int cmd_commit_graph(int argc,
 			     builtin_commit_graph_usage, 0);
 	FREE_AND_NULL(options);
 
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, NULL);
 }
diff --git a/builtin/config.c b/builtin/config.c
index cba702210815b716a5c6c93ebb69d8c485901e43..304ba147a2cbb1c63ef838aeaa67c5d5b8e2ef27 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -826,7 +826,8 @@ static void display_options_init(struct config_display_options *opts)
 	}
 }
 
-static int cmd_config_list(int argc, const char **argv, const char *prefix)
+static int cmd_config_list(int argc, const char **argv, const char *prefix,
+			   void *data UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	struct config_display_options display_opts = CONFIG_DISPLAY_OPTIONS_INIT;
@@ -861,7 +862,8 @@ static int cmd_config_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int cmd_config_get(int argc, const char **argv, const char *prefix)
+static int cmd_config_get(int argc, const char **argv, const char *prefix,
+			  void *data UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	struct config_display_options display_opts = CONFIG_DISPLAY_OPTIONS_INIT;
@@ -915,7 +917,8 @@ static int cmd_config_get(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int cmd_config_set(int argc, const char **argv, const char *prefix)
+static int cmd_config_set(int argc, const char **argv, const char *prefix,
+			  void *data UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	const char *value_pattern = NULL, *comment_arg = NULL;
@@ -973,7 +976,8 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int cmd_config_unset(int argc, const char **argv, const char *prefix)
+static int cmd_config_unset(int argc, const char **argv, const char *prefix,
+			    void *data UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	const char *value_pattern = NULL;
@@ -1010,7 +1014,8 @@ static int cmd_config_unset(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int cmd_config_rename_section(int argc, const char **argv, const char *prefix)
+static int cmd_config_rename_section(int argc, const char **argv, const char *prefix,
+				     void *data UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	struct option opts[] = {
@@ -1039,7 +1044,8 @@ static int cmd_config_rename_section(int argc, const char **argv, const char *pr
 	return ret;
 }
 
-static int cmd_config_remove_section(int argc, const char **argv, const char *prefix)
+static int cmd_config_remove_section(int argc, const char **argv, const char *prefix,
+				     void *data UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	struct option opts[] = {
@@ -1099,7 +1105,8 @@ static int show_editor(struct config_location_options *opts)
 	return 0;
 }
 
-static int cmd_config_edit(int argc, const char **argv, const char *prefix)
+static int cmd_config_edit(int argc, const char **argv, const char *prefix,
+			   void *data UNUSED)
 {
 	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
 	struct option opts[] = {
@@ -1422,7 +1429,7 @@ int cmd_config(int argc,
 	if (subcommand) {
 		argc = parse_options(argc, argv, prefix, subcommand_opts, builtin_config_usage,
 		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
-		return subcommand(argc, argv, prefix);
+		return subcommand(argc, argv, prefix, NULL);
 	}
 
 	return cmd_config_actions(argc, argv, prefix);
diff --git a/builtin/gc.c b/builtin/gc.c
index d52735354c9f87ba4e8acb593dd11aa0482223e1..94f357c64680b275a7512505b18ecae76d03b5c9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1561,7 +1561,8 @@ static int task_option_parse(const struct option *opt UNUSED,
 	return 0;
 }
 
-static int maintenance_run(int argc, const char **argv, const char *prefix)
+static int maintenance_run(int argc, const char **argv, const char *prefix,
+			   void *data UNUSED)
 {
 	int i;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
@@ -1623,7 +1624,8 @@ static char const * const builtin_maintenance_register_usage[] = {
 	NULL
 };
 
-static int maintenance_register(int argc, const char **argv, const char *prefix)
+static int maintenance_register(int argc, const char **argv, const char *prefix,
+				void *data UNUSED)
 {
 	char *config_file = NULL;
 	struct option options[] = {
@@ -1687,7 +1689,8 @@ static char const * const builtin_maintenance_unregister_usage[] = {
 	NULL
 };
 
-static int maintenance_unregister(int argc, const char **argv, const char *prefix)
+static int maintenance_unregister(int argc, const char **argv, const char *prefix,
+				  void *data UNUSED)
 {
 	int force = 0;
 	char *config_file = NULL;
@@ -2917,7 +2920,8 @@ static const char *const builtin_maintenance_start_usage[] = {
 	NULL
 };
 
-static int maintenance_start(int argc, const char **argv, const char *prefix)
+static int maintenance_start(int argc, const char **argv, const char *prefix,
+			     void *data UNUSED)
 {
 	struct maintenance_start_opts opts = { 0 };
 	struct option options[] = {
@@ -2940,7 +2944,7 @@ static int maintenance_start(int argc, const char **argv, const char *prefix)
 	if (update_background_schedule(&opts, 1))
 		die(_("failed to set up maintenance schedule"));
 
-	if (maintenance_register(ARRAY_SIZE(register_args)-1, register_args, NULL))
+	if (maintenance_register(ARRAY_SIZE(register_args)-1, register_args, NULL, the_repository))
 		warning(_("failed to add repo to global config"));
 	return 0;
 }
@@ -2950,7 +2954,8 @@ static const char *const builtin_maintenance_stop_usage[] = {
 	NULL
 };
 
-static int maintenance_stop(int argc, const char **argv, const char *prefix)
+static int maintenance_stop(int argc, const char **argv, const char *prefix,
+			    void *data UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -2984,5 +2989,5 @@ int cmd_maintenance(int argc,
 
 	argc = parse_options(argc, argv, prefix, builtin_maintenance_options,
 			     builtin_maintenance_usage, 0);
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, NULL);
 }
diff --git a/builtin/hook.c b/builtin/hook.c
index 367ef3e0b893fa16756880395151a82ed053acd8..973a3b08387b6414a832f946d0437cbc9ca6c353 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -19,7 +19,8 @@ static const char * const builtin_hook_run_usage[] = {
 	NULL
 };
 
-static int run(int argc, const char **argv, const char *prefix)
+static int run(int argc, const char **argv, const char *prefix,
+	       void *data UNUSED)
 {
 	int i;
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
@@ -81,5 +82,5 @@ int cmd_hook(int argc,
 	argc = parse_options(argc, argv, NULL, builtin_hook_options,
 			     builtin_hook_usage, 0);
 
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, NULL);
 }
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index d159ed1314d912a390ed725659b3abe7c821b83f..aef59f4758534aa60a363a9cdbc412e90ffa6f40 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -119,7 +119,7 @@ static void read_packs_from_stdin(struct string_list *to)
 }
 
 static int cmd_multi_pack_index_write(int argc, const char **argv,
-				      const char *prefix)
+				      const char *prefix, void *data UNUSED)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_write_options[] = {
@@ -183,7 +183,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 }
 
 static int cmd_multi_pack_index_verify(int argc, const char **argv,
-				       const char *prefix)
+				       const char *prefix, void *data UNUSED)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_verify_options[] = {
@@ -210,7 +210,7 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 }
 
 static int cmd_multi_pack_index_expire(int argc, const char **argv,
-				       const char *prefix)
+				       const char *prefix, void *data UNUSED)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_expire_options[] = {
@@ -237,7 +237,7 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 }
 
 static int cmd_multi_pack_index_repack(int argc, const char **argv,
-				       const char *prefix)
+				       const char *prefix, void *data UNUSED)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_repack_options[] = {
@@ -297,7 +297,7 @@ int cmd_multi_pack_index(int argc,
 			     builtin_multi_pack_index_usage, 0);
 	FREE_AND_NULL(options);
 
-	res = fn(argc, argv, prefix);
+	res = fn(argc, argv, prefix, NULL);
 
 	free(opts.object_dir);
 	return res;
diff --git a/builtin/notes.c b/builtin/notes.c
index 72c8a51cfacf72e1f115774487311b3d4464d204..b134c3ab6ccd4e7da33f85cf2b38eb328353f185 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -431,7 +431,8 @@ static struct notes_tree *init_notes_check(const char *subcommand,
 	return t;
 }
 
-static int list(int argc, const char **argv, const char *prefix)
+static int list(int argc, const char **argv, const char *prefix,
+		void *data UNUSED)
 {
 	struct notes_tree *t;
 	struct object_id object;
@@ -468,9 +469,11 @@ static int list(int argc, const char **argv, const char *prefix)
 	return retval;
 }
 
-static int append_edit(int argc, const char **argv, const char *prefix);
+static int append_edit(int argc, const char **argv, const char *prefix,
+		       void *data UNUSED);
 
-static int add(int argc, const char **argv, const char *prefix)
+static int add(int argc, const char **argv, const char *prefix,
+	       void *data UNUSED)
 {
 	int force = 0, allow_empty = 0;
 	const char *object_ref;
@@ -543,7 +546,7 @@ static int add(int argc, const char **argv, const char *prefix)
 			 * argv[0-1].
 			 */
 			argv[0] = "edit";
-			return append_edit(argc, argv, prefix);
+			return append_edit(argc, argv, prefix, NULL);
 		}
 		fprintf(stderr, _("Overwriting existing notes for object %s\n"),
 			oid_to_hex(&object));
@@ -569,7 +572,8 @@ static int add(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int copy(int argc, const char **argv, const char *prefix)
+static int copy(int argc, const char **argv, const char *prefix,
+		void *data UNUSED)
 {
 	int retval = 0, force = 0, from_stdin = 0;
 	const struct object_id *from_note, *note;
@@ -646,7 +650,8 @@ static int copy(int argc, const char **argv, const char *prefix)
 	return retval;
 }
 
-static int append_edit(int argc, const char **argv, const char *prefix)
+static int append_edit(int argc, const char **argv, const char *prefix,
+		       void *data UNUSED)
 {
 	int allow_empty = 0;
 	const char *object_ref;
@@ -749,7 +754,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int show(int argc, const char **argv, const char *prefix)
+static int show(int argc, const char **argv, const char *prefix,
+		void *data UNUSED)
 {
 	const char *object_ref;
 	struct notes_tree *t;
@@ -875,7 +881,8 @@ static int git_config_get_notes_strategy(const char *key,
 	return 0;
 }
 
-static int merge(int argc, const char **argv, const char *prefix)
+static int merge(int argc, const char **argv, const char *prefix,
+		 void *data UNUSED)
 {
 	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
 	struct object_id result_oid;
@@ -1016,7 +1023,8 @@ static int remove_one_note(struct notes_tree *t, const char *name, unsigned flag
 	return (flag & IGNORE_MISSING) ? 0 : status;
 }
 
-static int remove_cmd(int argc, const char **argv, const char *prefix)
+static int remove_cmd(int argc, const char **argv, const char *prefix,
+		      void *data UNUSED)
 {
 	unsigned flag = 0;
 	int from_stdin = 0;
@@ -1059,7 +1067,8 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 	return retval;
 }
 
-static int prune(int argc, const char **argv, const char *prefix)
+static int prune(int argc, const char **argv, const char *prefix,
+		 void *data UNUSED)
 {
 	struct notes_tree *t;
 	int show_only = 0, verbose = 0;
@@ -1088,7 +1097,8 @@ static int prune(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int get_ref(int argc, const char **argv, const char *prefix)
+static int get_ref(int argc, const char **argv, const char *prefix,
+		   void *data UNUSED)
 {
 	struct option options[] = { OPT_END() };
 	char *notes_ref;
@@ -1148,5 +1158,5 @@ int cmd_notes(int argc,
 		strbuf_release(&sb);
 	}
 
-	return !!fn(argc, argv, prefix);
+	return !!fn(argc, argv, prefix, NULL);
 }
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 22df6834f71098ab8378e4423967f0fb87858340..65a0de6229eebf2e22e7db7eb0d611964a4dfada 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -234,7 +234,8 @@ static int expire_total_callback(const struct option *opt,
 	return 0;
 }
 
-static int cmd_reflog_show(int argc, const char **argv, const char *prefix)
+static int cmd_reflog_show(int argc, const char **argv, const char *prefix,
+			   void *data UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -253,7 +254,8 @@ static int show_reflog(const char *refname, void *cb_data UNUSED)
 	return 0;
 }
 
-static int cmd_reflog_list(int argc, const char **argv, const char *prefix)
+static int cmd_reflog_list(int argc, const char **argv, const char *prefix,
+			   void *data UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -270,7 +272,8 @@ static int cmd_reflog_list(int argc, const char **argv, const char *prefix)
 	return refs_for_each_reflog(ref_store, show_reflog, NULL);
 }
 
-static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
+static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
+			     void *data UNUSED)
 {
 	struct cmd_reflog_expire_cb cmd = { 0 };
 	timestamp_t now = time(NULL);
@@ -394,7 +397,8 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
-static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
+static int cmd_reflog_delete(int argc, const char **argv, const char *prefix,
+			     void *data UNUSED)
 {
 	int i, status = 0;
 	unsigned int flags = 0;
@@ -424,7 +428,8 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
-static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
+static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
+			     void *data UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -450,7 +455,7 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
 int cmd_reflog(int argc,
 	       const char **argv,
 	       const char *prefix,
-	       struct repository *repository)
+	       struct repository *repository UNUSED)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
@@ -467,7 +472,7 @@ int cmd_reflog(int argc,
 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 	if (fn)
-		return fn(argc - 1, argv + 1, prefix);
+		return fn(argc - 1, argv + 1, prefix, NULL);
 	else
-		return cmd_log_reflog(argc, argv, prefix, repository);
+		return cmd_log_reflog(argc, argv, prefix, NULL);
 }
diff --git a/builtin/refs.c b/builtin/refs.c
index 24978a7b7b081ac6ed8ca99016f201d34c0639f8..3af697b957e2e67eb58f274f0d08e3dc0ca9276e 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -12,7 +12,8 @@
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
 
-static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
+static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
+			    void *data UNUSED)
 {
 	const char * const migrate_usage[] = {
 		REFS_MIGRATE_USAGE,
@@ -63,7 +64,8 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 	return err;
 }
 
-static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
+static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
+			   void *data UNUSED)
 {
 	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
 	const char * const verify_usage[] = {
@@ -108,5 +110,5 @@ int cmd_refs(int argc,
 	};
 
 	argc = parse_options(argc, argv, prefix, opts, refs_usage, 0);
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, NULL);
 }
diff --git a/builtin/remote.c b/builtin/remote.c
index 909360096513fc72445f54b13ee92d7a95111ce1..119b6b367b7d831efc2cf30ecbea73659de78ffa 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -155,7 +155,8 @@ static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
 	return 0;
 }
 
-static int add(int argc, const char **argv, const char *prefix)
+static int add(int argc, const char **argv, const char *prefix,
+	       void *data UNUSED)
 {
 	int fetch = 0, fetch_tags = TAGS_DEFAULT;
 	unsigned mirror = MIRROR_NONE;
@@ -706,7 +707,8 @@ static void handle_push_default(const char* old_name, const char* new_name)
 }
 
 
-static int mv(int argc, const char **argv, const char *prefix)
+static int mv(int argc, const char **argv, const char *prefix,
+	      void *data UNUSED)
 {
 	int show_progress = isatty(2);
 	struct option options[] = {
@@ -881,7 +883,8 @@ static int mv(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
-static int rm(int argc, const char **argv, const char *prefix)
+static int rm(int argc, const char **argv, const char *prefix,
+	      void *data UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -1303,7 +1306,8 @@ static int show_all(void)
 	return result;
 }
 
-static int show(int argc, const char **argv, const char *prefix)
+static int show(int argc, const char **argv, const char *prefix,
+		void *data UNUSED)
 {
 	int no_query = 0, result = 0, query_flag = 0;
 	struct option options[] = {
@@ -1399,7 +1403,8 @@ static int show(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
-static int set_head(int argc, const char **argv, const char *prefix)
+static int set_head(int argc, const char **argv, const char *prefix,
+		    void *data UNUSED)
 {
 	int i, opt_a = 0, opt_d = 0, result = 0;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
@@ -1503,7 +1508,8 @@ static int prune_remote(const char *remote, int dry_run)
 	return result;
 }
 
-static int prune(int argc, const char **argv, const char *prefix)
+static int prune(int argc, const char **argv, const char *prefix,
+		 void *data UNUSED)
 {
 	int dry_run = 0, result = 0;
 	struct option options[] = {
@@ -1534,7 +1540,8 @@ static int get_remote_default(const char *key, const char *value UNUSED,
 	return 0;
 }
 
-static int update(int argc, const char **argv, const char *prefix)
+static int update(int argc, const char **argv, const char *prefix,
+		  void *data UNUSED)
 {
 	int i, prune = -1;
 	struct option options[] = {
@@ -1616,7 +1623,8 @@ static int set_remote_branches(const char *remotename, const char **branches,
 	return 0;
 }
 
-static int set_branches(int argc, const char **argv, const char *prefix)
+static int set_branches(int argc, const char **argv, const char *prefix,
+			void *data UNUSED)
 {
 	int add_mode = 0;
 	struct option options[] = {
@@ -1635,7 +1643,8 @@ static int set_branches(int argc, const char **argv, const char *prefix)
 	return set_remote_branches(argv[0], argv + 1, add_mode);
 }
 
-static int get_url(int argc, const char **argv, const char *prefix)
+static int get_url(int argc, const char **argv, const char *prefix,
+		   void *data UNUSED)
 {
 	int i, push_mode = 0, all_mode = 0;
 	const char *remotename = NULL;
@@ -1674,7 +1683,8 @@ static int get_url(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int set_url(int argc, const char **argv, const char *prefix)
+static int set_url(int argc, const char **argv, const char *prefix,
+		   void *data UNUSED)
 {
 	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
 	int matches = 0, negative_matches = 0;
@@ -1788,7 +1798,7 @@ int cmd_remote(int argc,
 			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
 
 	if (fn) {
-		return !!fn(argc, argv, prefix);
+		return !!fn(argc, argv, prefix, NULL);
 	} else {
 		if (argc) {
 			error(_("unknown subcommand: `%s'"), argv[0]);
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 49aedc1de81a17b8b491cded7fa71b384e0e8be9..c18133997476d6d8e90ef7a54a286b4889a3f905 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -48,7 +48,8 @@ static char const * const builtin_sparse_checkout_list_usage[] = {
 	NULL
 };
 
-static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
+static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
+				void *data UNUSED)
 {
 	static struct option builtin_sparse_checkout_list_options[] = {
 		OPT_END(),
@@ -443,7 +444,8 @@ static struct sparse_checkout_init_opts {
 	int sparse_index;
 } init_opts;
 
-static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
+static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
+				void *data UNUSED)
 {
 	struct pattern_list pl;
 	char *sparse_filename;
@@ -770,7 +772,8 @@ static struct sparse_checkout_add_opts {
 	int use_stdin;
 } add_opts;
 
-static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
+static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
+			       void *data UNUSED)
 {
 	static struct option builtin_sparse_checkout_add_options[] = {
 		OPT_BOOL_F(0, "skip-checks", &add_opts.skip_checks,
@@ -808,7 +811,8 @@ static struct sparse_checkout_set_opts {
 	int use_stdin;
 } set_opts;
 
-static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
+static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
+			       void *data UNUSED)
 {
 	int default_patterns_nr = 2;
 	const char *default_patterns[] = {"/*", "!/*/", NULL};
@@ -866,7 +870,7 @@ static struct sparse_checkout_reapply_opts {
 } reapply_opts;
 
 static int sparse_checkout_reapply(int argc, const char **argv,
-				   const char *prefix)
+				   const char *prefix, void *data UNUSED)
 {
 	static struct option builtin_sparse_checkout_reapply_options[] = {
 		OPT_BOOL(0, "cone", &reapply_opts.cone_mode,
@@ -901,7 +905,7 @@ static char const * const builtin_sparse_checkout_disable_usage[] = {
 };
 
 static int sparse_checkout_disable(int argc, const char **argv,
-				   const char *prefix)
+				   const char *prefix, void *data UNUSED)
 {
 	static struct option builtin_sparse_checkout_disable_options[] = {
 		OPT_END(),
@@ -989,7 +993,8 @@ static int check_rules(struct pattern_list *pl, int null_terminated) {
 	return 0;
 }
 
-static int sparse_checkout_check_rules(int argc, const char **argv, const char *prefix)
+static int sparse_checkout_check_rules(int argc, const char **argv, const char *prefix,
+				       void *data UNUSED)
 {
 	static struct option builtin_sparse_checkout_check_rules_options[] = {
 		OPT_BOOL('z', NULL, &check_rules_opts.null_termination,
@@ -1060,5 +1065,5 @@ int cmd_sparse_checkout(int argc,
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, NULL);
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index 1399a1bbe2c222ed3e1c33ac2dd17bd1148f709c..c0477240feb3f194240aafba8057636596326391 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -249,7 +249,8 @@ static int do_clear_stash(void)
 			       ref_stash, &obj, 0);
 }
 
-static int clear_stash(int argc, const char **argv, const char *prefix)
+static int clear_stash(int argc, const char **argv, const char *prefix,
+		       void *data UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -652,7 +653,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	return ret;
 }
 
-static int apply_stash(int argc, const char **argv, const char *prefix)
+static int apply_stash(int argc, const char **argv, const char *prefix,
+		       void *data UNUSED)
 {
 	int ret = -1;
 	int quiet = 0;
@@ -726,7 +728,8 @@ static int get_stash_info_assert(struct stash_info *info, int argc,
 	return 0;
 }
 
-static int drop_stash(int argc, const char **argv, const char *prefix)
+static int drop_stash(int argc, const char **argv, const char *prefix,
+		      void *data UNUSED)
 {
 	int ret = -1;
 	int quiet = 0;
@@ -748,7 +751,8 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int pop_stash(int argc, const char **argv, const char *prefix)
+static int pop_stash(int argc, const char **argv, const char *prefix,
+		     void *data UNUSED)
 {
 	int ret = -1;
 	int index = 0;
@@ -778,7 +782,8 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int branch_stash(int argc, const char **argv, const char *prefix)
+static int branch_stash(int argc, const char **argv, const char *prefix,
+			void *data UNUSED)
 {
 	int ret = -1;
 	const char *branch = NULL;
@@ -816,7 +821,8 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int list_stash(int argc, const char **argv, const char *prefix)
+static int list_stash(int argc, const char **argv, const char *prefix,
+		      void *data UNUSED)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct option options[] = {
@@ -889,7 +895,8 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 	do_diff_cache(&info->b_commit, diff_opt);
 }
 
-static int show_stash(int argc, const char **argv, const char *prefix)
+static int show_stash(int argc, const char **argv, const char *prefix,
+		      void *data UNUSED)
 {
 	int i;
 	int ret = -1;
@@ -1017,7 +1024,8 @@ static int do_store_stash(const struct object_id *w_commit, const char *stash_ms
 	return 0;
 }
 
-static int store_stash(int argc, const char **argv, const char *prefix)
+static int store_stash(int argc, const char **argv, const char *prefix,
+		       void *data UNUSED)
 {
 	int quiet = 0;
 	const char *stash_msg = NULL;
@@ -1491,7 +1499,8 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	return ret;
 }
 
-static int create_stash(int argc, const char **argv, const char *prefix UNUSED)
+static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
+			void *data UNUSED)
 {
 	int ret;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
@@ -1827,12 +1836,14 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
-static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
+static int push_stash_unassumed(int argc, const char **argv, const char *prefix,
+				void *data UNUSED)
 {
 	return push_stash(argc, argv, prefix, 0);
 }
 
-static int save_stash(int argc, const char **argv, const char *prefix)
+static int save_stash(int argc, const char **argv, const char *prefix,
+		      void *data UNUSED)
 {
 	int keep_index = -1;
 	int only_staged = 0;
@@ -1916,9 +1927,9 @@ int cmd_stash(int argc,
 		    (uintmax_t)pid);
 
 	if (fn)
-		return !!fn(argc, argv, prefix);
+		return !!fn(argc, argv, prefix, NULL);
 	else if (!argc)
-		return !!push_stash_unassumed(0, NULL, prefix);
+		return !!push_stash_unassumed(0, NULL, prefix, NULL);
 
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b6b5f1ebde7c2e4780af4097a0c4d6d838948aee..6d69360ff236e98d2daa63a87750c270a14795a0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -399,7 +399,8 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	free(displaypath);
 }
 
-static int module_foreach(int argc, const char **argv, const char *prefix)
+static int module_foreach(int argc, const char **argv, const char *prefix,
+			  void *data UNUSED)
 {
 	struct foreach_cb info = FOREACH_CB_INIT;
 	struct pathspec pathspec = { 0 };
@@ -544,7 +545,8 @@ static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data
 		       info->flags);
 }
 
-static int module_init(int argc, const char **argv, const char *prefix)
+static int module_init(int argc, const char **argv, const char *prefix,
+		       void *data UNUSED)
 {
 	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec = { 0 };
@@ -738,7 +740,8 @@ static void status_submodule_cb(const struct cache_entry *list_item,
 			 info->prefix, info->super_prefix, info->flags);
 }
 
-static int module_status(int argc, const char **argv, const char *prefix)
+static int module_status(int argc, const char **argv, const char *prefix,
+			 void *data UNUSED)
 {
 	struct status_cb info = STATUS_CB_INIT;
 	struct pathspec pathspec = { 0 };
@@ -1163,7 +1166,8 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	return ret;
 }
 
-static int module_summary(int argc, const char **argv, const char *prefix)
+static int module_summary(int argc, const char **argv, const char *prefix,
+			  void *data UNUSED)
 {
 	struct summary_cb info = SUMMARY_CB_INIT;
 	int cached = 0;
@@ -1339,7 +1343,8 @@ static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
 		       info->flags);
 }
 
-static int module_sync(int argc, const char **argv, const char *prefix)
+static int module_sync(int argc, const char **argv, const char *prefix,
+		       void *data UNUSED)
 {
 	struct sync_cb info = SYNC_CB_INIT;
 	struct pathspec pathspec = { 0 };
@@ -1485,7 +1490,8 @@ static void deinit_submodule_cb(const struct cache_entry *list_item,
 	deinit_submodule(list_item->name, info->prefix, info->flags);
 }
 
-static int module_deinit(int argc, const char **argv, const char *prefix)
+static int module_deinit(int argc, const char **argv, const char *prefix,
+			 void *data UNUSED)
 {
 	struct deinit_cb info = DEINIT_CB_INIT;
 	struct pathspec pathspec = { 0 };
@@ -1842,7 +1848,8 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 	return 0;
 }
 
-static int module_clone(int argc, const char **argv, const char *prefix)
+static int module_clone(int argc, const char **argv, const char *prefix,
+			void *data UNUSED)
 {
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
@@ -2779,7 +2786,8 @@ static int update_submodules(struct update_data *update_data)
 	return ret;
 }
 
-static int module_update(int argc, const char **argv, const char *prefix)
+static int module_update(int argc, const char **argv, const char *prefix,
+			 void *data UNUSED)
 {
 	struct pathspec pathspec = { 0 };
 	struct pathspec pathspec2 = { 0 };
@@ -2911,7 +2919,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int push_check(int argc, const char **argv, const char *prefix UNUSED)
+static int push_check(int argc, const char **argv, const char *prefix UNUSED,
+		      void *data UNUSED)
 {
 	struct remote *remote;
 	const char *superproject_head;
@@ -2991,7 +3000,8 @@ static int push_check(int argc, const char **argv, const char *prefix UNUSED)
 	return 0;
 }
 
-static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
+static int absorb_git_dirs(int argc, const char **argv, const char *prefix,
+			   void *data UNUSED)
 {
 	int i;
 	struct pathspec pathspec = { 0 };
@@ -3024,7 +3034,8 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int module_set_url(int argc, const char **argv, const char *prefix)
+static int module_set_url(int argc, const char **argv, const char *prefix,
+			  void *data UNUSED)
 {
 	int quiet = 0, ret;
 	const char *newurl;
@@ -3063,7 +3074,8 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	return !!ret;
 }
 
-static int module_set_branch(int argc, const char **argv, const char *prefix)
+static int module_set_branch(int argc, const char **argv, const char *prefix,
+			     void *data UNUSED)
 {
 	int opt_default = 0, ret;
 	const char *opt_branch = NULL;
@@ -3113,7 +3125,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 	return !!ret;
 }
 
-static int module_create_branch(int argc, const char **argv, const char *prefix)
+static int module_create_branch(int argc, const char **argv, const char *prefix,
+				void *data UNUSED)
 {
 	enum branch_track track;
 	int quiet = 0, force = 0, reflog = 0, dry_run = 0;
@@ -3424,7 +3437,8 @@ static void die_on_repo_without_commits(const char *path)
 	strbuf_release(&sb);
 }
 
-static int module_add(int argc, const char **argv, const char *prefix)
+static int module_add(int argc, const char **argv, const char *prefix,
+		      void *data UNUSED)
 {
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
@@ -3583,5 +3597,5 @@ int cmd_submodule__helper(int argc,
 	};
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
-	return fn(argc, argv, prefix);
+	return fn(argc, argv, prefix, NULL);
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index dae63dedf4cac2621f51f95a39aa456b33acd894..972b584b2170e1fca1658e397b7776205f545822 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -231,7 +231,8 @@ static void prune_worktrees(void)
 	strbuf_release(&reason);
 }
 
-static int prune(int ac, const char **av, const char *prefix)
+static int prune(int ac, const char **av, const char *prefix,
+		 void *data UNUSED)
 {
 	struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
@@ -763,7 +764,8 @@ static char *dwim_branch(const char *path, char **new_branch)
 	return NULL;
 }
 
-static int add(int ac, const char **av, const char *prefix)
+static int add(int ac, const char **av, const char *prefix,
+	       void *data UNUSED)
 {
 	struct add_opts opts;
 	const char *new_branch_force = NULL;
@@ -1039,7 +1041,8 @@ static void pathsort(struct worktree **wt)
 	QSORT(wt, n, pathcmp);
 }
 
-static int list(int ac, const char **av, const char *prefix)
+static int list(int ac, const char **av, const char *prefix,
+		void *data UNUSED)
 {
 	int porcelain = 0;
 	int line_terminator = '\n';
@@ -1084,7 +1087,8 @@ static int list(int ac, const char **av, const char *prefix)
 	return 0;
 }
 
-static int lock_worktree(int ac, const char **av, const char *prefix)
+static int lock_worktree(int ac, const char **av, const char *prefix,
+			 void *data UNUSED)
 {
 	const char *reason = "", *old_reason;
 	struct option options[] = {
@@ -1119,7 +1123,8 @@ static int lock_worktree(int ac, const char **av, const char *prefix)
 	return 0;
 }
 
-static int unlock_worktree(int ac, const char **av, const char *prefix)
+static int unlock_worktree(int ac, const char **av, const char *prefix,
+			   void *data UNUSED)
 {
 	struct option options[] = {
 		OPT_END()
@@ -1182,7 +1187,8 @@ static void validate_no_submodules(const struct worktree *wt)
 		die(_("working trees containing submodules cannot be moved or removed"));
 }
 
-static int move_worktree(int ac, const char **av, const char *prefix)
+static int move_worktree(int ac, const char **av, const char *prefix,
+			 void *data UNUSED)
 {
 	int force = 0;
 	struct option options[] = {
@@ -1312,7 +1318,8 @@ static int delete_git_work_tree(struct worktree *wt)
 	return ret;
 }
 
-static int remove_worktree(int ac, const char **av, const char *prefix)
+static int remove_worktree(int ac, const char **av, const char *prefix,
+			   void *data UNUSED)
 {
 	int force = 0;
 	struct option options[] = {
@@ -1377,7 +1384,8 @@ static void report_repair(int iserr, const char *path, const char *msg, void *cb
 	}
 }
 
-static int repair(int ac, const char **av, const char *prefix)
+static int repair(int ac, const char **av, const char *prefix,
+		  void *data UNUSED)
 {
 	const char **p;
 	const char *self[] = { ".", NULL };
@@ -1422,5 +1430,5 @@ int cmd_worktree(int ac,
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	return fn(ac, av, prefix);
+	return fn(ac, av, prefix, NULL);
 }
diff --git a/parse-options.h b/parse-options.h
index ae15342390837c21503ab812648a7d8fd21432a8..18d4e0c412cc86942e2da1277804f8b233076bc4 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -73,7 +73,7 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
 					      const char *arg, int unset);
 
 typedef int parse_opt_subcommand_fn(int argc, const char **argv,
-				    const char *prefix);
+				    const char *prefix, void *data);
 
 /*
  * `type`::
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 5250913d99eba18a28878d3904cb7b2399670d02..86a4e596e347dc2b9c65205237486ab2d352f8c3 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -282,14 +282,16 @@ int cmd__parse_options_flags(int argc, const char **argv)
 	return parse_options_flags__cmd(argc, argv, test_flags);
 }
 
-static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED)
+static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED,
+		      void *data UNUSED)
 {
 	printf("fn: subcmd_one\n");
 	print_args(argc, argv);
 	return 0;
 }
 
-static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED)
+static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED,
+		      void *data UNUSED)
 {
 	printf("fn: subcmd_two\n");
 	print_args(argc, argv);
@@ -319,7 +321,7 @@ static int parse_subcommand__cmd(int argc, const char **argv,
 
 	printf("opt: %d\n", opt);
 
-	return fn(argc, argv, NULL);
+	return fn(argc, argv, NULL, NULL);
 }
 
 int cmd__parse_subcommand(int argc, const char **argv)

---

Range-diff versus v1:

1:  6bce012f61 ! 1:  0c5e6aba3f builtin: pass repository to sub commands
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    builtin: pass repository to sub commands
    +    builtin: allow passing custom data to sub-commands
     
         In 9b1cb5070f (builtin: add a repository parameter for builtin
         functions, 2024-09-13) the repository was passed down to all builtin
         commands. This allowed the repository to be passed down to lower layers
         without depending on the global `the_repository` variable.
     
    -    Continue this work by also passing down the repository parameter from
    -    the command to sub-commands. This will help pass down the repository to
    -    other subsystems and cleanup usage of global variables like
    -    'the_repository' and 'the_hash_algo'.
    +    To remove usage of global variables like `the_repository` in
    +    sub-commands, it makes sense to pass down the repository value from the
    +    commands to the sub-commands. But let's make it more generic and modify
    +    `parse_opt_subcommand_fn` to instead take a `void *` value. This way we
    +    can provide custom structures to each sub-command.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, co
      
     -static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED)
     +static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED,
    -+			     struct repository *repo UNUSED)
    ++			     void *data UNUSED)
      {
      	if (argc > 1)
      		return error(_("'%s' requires either no argument or a commit"),
    @@ builtin/bisect.c: static int cmd_bisect__reset(int argc, const char **argv, cons
      
     -static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED)
     +static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
    -+			     struct repository *repo UNUSED)
    ++			     void *data UNUSED)
      {
      	int res;
      	struct bisect_terms terms = { 0 };
    @@ builtin/bisect.c: static int cmd_bisect__terms(int argc, const char **argv, cons
      
     -static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNUSED)
     +static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNUSED,
    -+			     struct repository *repo UNUSED)
    ++			     void *data UNUSED)
      {
      	int res;
      	struct bisect_terms terms = { 0 };
    @@ builtin/bisect.c: static int cmd_bisect__start(int argc, const char **argv, cons
      
     -static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *prefix)
     +static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *prefix,
    -+			    struct repository *repo UNUSED)
    ++			    void *data UNUSED)
      {
      	int res;
      	struct bisect_terms terms = { 0 };
    @@ builtin/bisect.c: static int cmd_bisect__next(int argc, const char **argv UNUSED
      
     -static int cmd_bisect__log(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED)
     +static int cmd_bisect__log(int argc UNUSED, const char **argv UNUSED,
    -+			   const char *prefix UNUSED,
    -+			   struct repository *repo UNUSED)
    ++			   const char *prefix UNUSED, void *data UNUSED)
      {
      	return bisect_log();
      }
      
     -static int cmd_bisect__replay(int argc, const char **argv, const char *prefix UNUSED)
     +static int cmd_bisect__replay(int argc, const char **argv, const char *prefix UNUSED,
    -+			      struct repository *repo UNUSED)
    ++			      void *data UNUSED)
      {
      	int res;
      	struct bisect_terms terms = { 0 };
    @@ builtin/bisect.c: static int cmd_bisect__replay(int argc, const char **argv, con
      
     -static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUSED)
     +static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUSED,
    -+			    struct repository *repo UNUSED)
    ++			    void *data UNUSED)
      {
      	int res;
      	struct bisect_terms terms = { 0 };
    @@ builtin/bisect.c: static int cmd_bisect__skip(int argc, const char **argv, const
      
     -static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix UNUSED)
     +static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix UNUSED,
    -+				 struct repository *repo UNUSED)
    ++				 void *data UNUSED)
      {
      	int res;
      	struct bisect_terms terms = { 0 };
    @@ builtin/bisect.c: static int cmd_bisect__visualize(int argc, const char **argv,
      
     -static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSED)
     +static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSED,
    -+			   struct repository *repo UNUSED)
    ++			   void *data UNUSED)
      {
      	int res;
      	struct bisect_terms terms = { 0 };
    -@@ builtin/bisect.c: static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
    - int cmd_bisect(int argc,
    - 	       const char **argv,
    - 	       const char *prefix,
    --	       struct repository *repo UNUSED)
    -+	       struct repository *repo)
    - {
    - 	int res = 0;
    - 	parse_opt_subcommand_fn *fn = NULL;
     @@ builtin/bisect.c: int cmd_bisect(int argc,
      	} else {
      		argc--;
      		argv++;
     -		res = fn(argc, argv, prefix);
    -+		res = fn(argc, argv, prefix, repo);
    ++		res = fn(argc, argv, prefix, NULL);
      	}
      
      	return is_bisect_success(res) ? 0 : -res;
    @@ builtin/bundle.c: static int parse_options_cmd_bundle(int argc,
      
     -static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
     +static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
    -+			     struct repository *repo UNUSED) {
    ++			     void *data UNUSED) {
      	struct strvec pack_opts = STRVEC_INIT;
      	int version = -1;
      	int ret;
    @@ builtin/bundle.c: static int open_bundle(const char *path, struct bundle_header
      
     -static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
     +static int cmd_bundle_verify(int argc, const char **argv, const char *prefix,
    -+			     struct repository *repo UNUSED) {
    ++			     void *data UNUSED) {
      	struct bundle_header header = BUNDLE_HEADER_INIT;
      	int bundle_fd = -1;
      	int quiet = 0;
    @@ builtin/bundle.c: static int cmd_bundle_verify(int argc, const char **argv, cons
      
     -static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix) {
     +static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix,
    -+				 struct repository *repo UNUSED) {
    ++				 void *data UNUSED) {
      	struct bundle_header header = BUNDLE_HEADER_INIT;
      	int bundle_fd = -1;
      	int ret;
    @@ builtin/bundle.c: static int cmd_bundle_list_heads(int argc, const char **argv,
      
     -static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix) {
     +static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix,
    -+			       struct repository *repo UNUSED) {
    ++			       void *data UNUSED) {
      	struct bundle_header header = BUNDLE_HEADER_INIT;
      	int bundle_fd = -1;
      	int ret;
    -@@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
    - int cmd_bundle(int argc,
    - 	       const char **argv,
    - 	       const char *prefix,
    --	       struct repository *repo UNUSED)
    -+	       struct repository *repo)
    - {
    - 	parse_opt_subcommand_fn *fn = NULL;
    - 	struct option options[] = {
     @@ builtin/bundle.c: int cmd_bundle(int argc,
      
      	packet_trace_identity("bundle");
      
     -	return !!fn(argc, argv, prefix);
    -+	return !!fn(argc, argv, prefix, repo);
    ++	return !!fn(argc, argv, prefix, NULL);
      }
     
      ## builtin/commit-graph.c ##
    @@ builtin/commit-graph.c: static struct option *add_common_options(struct option *
      
     -static int graph_verify(int argc, const char **argv, const char *prefix)
     +static int graph_verify(int argc, const char **argv, const char *prefix,
    -+			struct repository *repo UNUSED)
    ++			void *data UNUSED)
      {
      	struct commit_graph *graph = NULL;
      	struct object_directory *odb = NULL;
    @@ builtin/commit-graph.c: static int git_commit_graph_write_config(const char *var
      
     -static int graph_write(int argc, const char **argv, const char *prefix)
     +static int graph_write(int argc, const char **argv, const char *prefix,
    -+		       struct repository *repo UNUSED)
    ++		       void *data UNUSED)
      {
      	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
      	struct strbuf buf = STRBUF_INIT;
    -@@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv, const char *prefix)
    - int cmd_commit_graph(int argc,
    - 		     const char **argv,
    - 		     const char *prefix,
    --		     struct repository *repo UNUSED)
    -+		     struct repository *repo)
    - {
    - 	parse_opt_subcommand_fn *fn = NULL;
    - 	struct option builtin_commit_graph_options[] = {
     @@ builtin/commit-graph.c: int cmd_commit_graph(int argc,
      			     builtin_commit_graph_usage, 0);
      	FREE_AND_NULL(options);
      
     -	return fn(argc, argv, prefix);
    -+	return fn(argc, argv, prefix, repo);
    ++	return fn(argc, argv, prefix, NULL);
      }
     
      ## builtin/config.c ##
    @@ builtin/config.c: static void display_options_init(struct config_display_options
      
     -static int cmd_config_list(int argc, const char **argv, const char *prefix)
     +static int cmd_config_list(int argc, const char **argv, const char *prefix,
    -+			   struct repository *repo UNUSED)
    ++			   void *data UNUSED)
      {
      	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
      	struct config_display_options display_opts = CONFIG_DISPLAY_OPTIONS_INIT;
    @@ builtin/config.c: static int cmd_config_list(int argc, const char **argv, const
      
     -static int cmd_config_get(int argc, const char **argv, const char *prefix)
     +static int cmd_config_get(int argc, const char **argv, const char *prefix,
    -+			  struct repository *repo UNUSED)
    ++			  void *data UNUSED)
      {
      	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
      	struct config_display_options display_opts = CONFIG_DISPLAY_OPTIONS_INIT;
    @@ builtin/config.c: static int cmd_config_get(int argc, const char **argv, const c
      
     -static int cmd_config_set(int argc, const char **argv, const char *prefix)
     +static int cmd_config_set(int argc, const char **argv, const char *prefix,
    -+			  struct repository *repo UNUSED)
    ++			  void *data UNUSED)
      {
      	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
      	const char *value_pattern = NULL, *comment_arg = NULL;
    @@ builtin/config.c: static int cmd_config_set(int argc, const char **argv, const c
      
     -static int cmd_config_unset(int argc, const char **argv, const char *prefix)
     +static int cmd_config_unset(int argc, const char **argv, const char *prefix,
    -+			    struct repository *repo UNUSED)
    ++			    void *data UNUSED)
      {
      	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
      	const char *value_pattern = NULL;
    @@ builtin/config.c: static int cmd_config_unset(int argc, const char **argv, const
      
     -static int cmd_config_rename_section(int argc, const char **argv, const char *prefix)
     +static int cmd_config_rename_section(int argc, const char **argv, const char *prefix,
    -+				     struct repository *repo UNUSED)
    ++				     void *data UNUSED)
      {
      	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
      	struct option opts[] = {
    @@ builtin/config.c: static int cmd_config_rename_section(int argc, const char **ar
      
     -static int cmd_config_remove_section(int argc, const char **argv, const char *prefix)
     +static int cmd_config_remove_section(int argc, const char **argv, const char *prefix,
    -+				     struct repository *repo UNUSED)
    ++				     void *data UNUSED)
      {
      	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
      	struct option opts[] = {
    @@ builtin/config.c: static int show_editor(struct config_location_options *opts)
      
     -static int cmd_config_edit(int argc, const char **argv, const char *prefix)
     +static int cmd_config_edit(int argc, const char **argv, const char *prefix,
    -+			   struct repository *repo UNUSED)
    ++			   void *data UNUSED)
      {
      	struct config_location_options location_opts = CONFIG_LOCATION_OPTIONS_INIT;
      	struct option opts[] = {
    -@@ builtin/config.c: static int cmd_config_actions(int argc, const char **argv, const char *prefix)
    - int cmd_config(int argc,
    - 	       const char **argv,
    - 	       const char *prefix,
    --	       struct repository *repo UNUSED)
    -+	       struct repository *repo)
    - {
    - 	parse_opt_subcommand_fn *subcommand = NULL;
    - 	struct option subcommand_opts[] = {
     @@ builtin/config.c: int cmd_config(int argc,
      	if (subcommand) {
      		argc = parse_options(argc, argv, prefix, subcommand_opts, builtin_config_usage,
      		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
     -		return subcommand(argc, argv, prefix);
    -+		return subcommand(argc, argv, prefix, repo);
    ++		return subcommand(argc, argv, prefix, NULL);
      	}
      
      	return cmd_config_actions(argc, argv, prefix);
    @@ builtin/gc.c: static int task_option_parse(const struct option *opt UNUSED,
      
     -static int maintenance_run(int argc, const char **argv, const char *prefix)
     +static int maintenance_run(int argc, const char **argv, const char *prefix,
    -+			   struct repository *repo UNUSED)
    ++			   void *data UNUSED)
      {
      	int i;
      	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
    @@ builtin/gc.c: static char const * const builtin_maintenance_register_usage[] = {
      
     -static int maintenance_register(int argc, const char **argv, const char *prefix)
     +static int maintenance_register(int argc, const char **argv, const char *prefix,
    -+				struct repository *repo UNUSED)
    ++				void *data UNUSED)
      {
      	char *config_file = NULL;
      	struct option options[] = {
    @@ builtin/gc.c: static char const * const builtin_maintenance_unregister_usage[] =
      
     -static int maintenance_unregister(int argc, const char **argv, const char *prefix)
     +static int maintenance_unregister(int argc, const char **argv, const char *prefix,
    -+				  struct repository *repo UNUSED)
    ++				  void *data UNUSED)
      {
      	int force = 0;
      	char *config_file = NULL;
    @@ builtin/gc.c: static const char *const builtin_maintenance_start_usage[] = {
      
     -static int maintenance_start(int argc, const char **argv, const char *prefix)
     +static int maintenance_start(int argc, const char **argv, const char *prefix,
    -+			     struct repository *repo)
    ++			     void *data UNUSED)
      {
      	struct maintenance_start_opts opts = { 0 };
      	struct option options[] = {
    @@ builtin/gc.c: static int maintenance_start(int argc, const char **argv, const ch
      		die(_("failed to set up maintenance schedule"));
      
     -	if (maintenance_register(ARRAY_SIZE(register_args)-1, register_args, NULL))
    -+	if (maintenance_register(ARRAY_SIZE(register_args)-1, register_args, NULL, repo))
    ++	if (maintenance_register(ARRAY_SIZE(register_args)-1, register_args, NULL, the_repository))
      		warning(_("failed to add repo to global config"));
      	return 0;
      }
    @@ builtin/gc.c: static const char *const builtin_maintenance_stop_usage[] = {
      
     -static int maintenance_stop(int argc, const char **argv, const char *prefix)
     +static int maintenance_stop(int argc, const char **argv, const char *prefix,
    -+			    struct repository *repo UNUSED)
    ++			    void *data UNUSED)
      {
      	struct option options[] = {
      		OPT_END()
    -@@ builtin/gc.c: static const char * const builtin_maintenance_usage[] = {
    - int cmd_maintenance(int argc,
    - 		    const char **argv,
    - 		    const char *prefix,
    --		    struct repository *repo UNUSED)
    -+		    struct repository *repo)
    - {
    - 	parse_opt_subcommand_fn *fn = NULL;
    - 	struct option builtin_maintenance_options[] = {
     @@ builtin/gc.c: int cmd_maintenance(int argc,
      
      	argc = parse_options(argc, argv, prefix, builtin_maintenance_options,
      			     builtin_maintenance_usage, 0);
     -	return fn(argc, argv, prefix);
    -+	return fn(argc, argv, prefix, repo);
    ++	return fn(argc, argv, prefix, NULL);
      }
     
      ## builtin/hook.c ##
    @@ builtin/hook.c: static const char * const builtin_hook_run_usage[] = {
      
     -static int run(int argc, const char **argv, const char *prefix)
     +static int run(int argc, const char **argv, const char *prefix,
    -+	       struct repository *repo UNUSED)
    ++	       void *data UNUSED)
      {
      	int i;
      	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -@@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
    - int cmd_hook(int argc,
    - 	     const char **argv,
    - 	     const char *prefix,
    --	     struct repository *repo UNUSED)
    -+	     struct repository *repo)
    - {
    - 	parse_opt_subcommand_fn *fn = NULL;
    - 	struct option builtin_hook_options[] = {
     @@ builtin/hook.c: int cmd_hook(int argc,
      	argc = parse_options(argc, argv, NULL, builtin_hook_options,
      			     builtin_hook_usage, 0);
      
     -	return fn(argc, argv, prefix);
    -+	return fn(argc, argv, prefix, repo);
    ++	return fn(argc, argv, prefix, NULL);
      }
     
      ## builtin/multi-pack-index.c ##
    @@ builtin/multi-pack-index.c: static void read_packs_from_stdin(struct string_list
      
      static int cmd_multi_pack_index_write(int argc, const char **argv,
     -				      const char *prefix)
    -+				      const char *prefix,
    -+				      struct repository *repo UNUSED)
    ++				      const char *prefix, void *data UNUSED)
      {
      	struct option *options;
      	static struct option builtin_multi_pack_index_write_options[] = {
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, cons
      
      static int cmd_multi_pack_index_verify(int argc, const char **argv,
     -				       const char *prefix)
    -+				       const char *prefix,
    -+				       struct repository *repo UNUSED)
    ++				       const char *prefix, void *data UNUSED)
      {
      	struct option *options;
      	static struct option builtin_multi_pack_index_verify_options[] = {
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_verify(int argc, con
      
      static int cmd_multi_pack_index_expire(int argc, const char **argv,
     -				       const char *prefix)
    -+				       const char *prefix,
    -+				       struct repository *repo UNUSED)
    ++				       const char *prefix, void *data UNUSED)
      {
      	struct option *options;
      	static struct option builtin_multi_pack_index_expire_options[] = {
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_expire(int argc, con
      
      static int cmd_multi_pack_index_repack(int argc, const char **argv,
     -				       const char *prefix)
    -+				       const char *prefix,
    -+				       struct repository *repo UNUSED)
    ++				       const char *prefix, void *data UNUSED)
      {
      	struct option *options;
      	static struct option builtin_multi_pack_index_repack_options[] = {
    -@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_repack(int argc, const char **argv,
    - int cmd_multi_pack_index(int argc,
    - 			 const char **argv,
    - 			 const char *prefix,
    --			 struct repository *repo UNUSED)
    -+			 struct repository *repo)
    - {
    - 	int res;
    - 	parse_opt_subcommand_fn *fn = NULL;
     @@ builtin/multi-pack-index.c: int cmd_multi_pack_index(int argc,
      			     builtin_multi_pack_index_usage, 0);
      	FREE_AND_NULL(options);
      
     -	res = fn(argc, argv, prefix);
    -+	res = fn(argc, argv, prefix, repo);
    ++	res = fn(argc, argv, prefix, NULL);
      
      	free(opts.object_dir);
      	return res;
    @@ builtin/notes.c: static struct notes_tree *init_notes_check(const char *subcomma
      
     -static int list(int argc, const char **argv, const char *prefix)
     +static int list(int argc, const char **argv, const char *prefix,
    -+		struct repository *repo UNUSED)
    ++		void *data UNUSED)
      {
      	struct notes_tree *t;
      	struct object_id object;
    @@ builtin/notes.c: static int list(int argc, const char **argv, const char *prefix
      
     -static int append_edit(int argc, const char **argv, const char *prefix);
     +static int append_edit(int argc, const char **argv, const char *prefix,
    -+		       struct repository *repo UNUSED);
    ++		       void *data UNUSED);
      
     -static int add(int argc, const char **argv, const char *prefix)
     +static int add(int argc, const char **argv, const char *prefix,
    -+	       struct repository *repo)
    ++	       void *data UNUSED)
      {
      	int force = 0, allow_empty = 0;
      	const char *object_ref;
    @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
      			 */
      			argv[0] = "edit";
     -			return append_edit(argc, argv, prefix);
    -+			return append_edit(argc, argv, prefix, repo);
    ++			return append_edit(argc, argv, prefix, NULL);
      		}
      		fprintf(stderr, _("Overwriting existing notes for object %s\n"),
      			oid_to_hex(&object));
    @@ builtin/notes.c: static int add(int argc, const char **argv, const char *prefix)
      
     -static int copy(int argc, const char **argv, const char *prefix)
     +static int copy(int argc, const char **argv, const char *prefix,
    -+		struct repository *repo UNUSED)
    ++		void *data UNUSED)
      {
      	int retval = 0, force = 0, from_stdin = 0;
      	const struct object_id *from_note, *note;
    @@ builtin/notes.c: static int copy(int argc, const char **argv, const char *prefix
      
     -static int append_edit(int argc, const char **argv, const char *prefix)
     +static int append_edit(int argc, const char **argv, const char *prefix,
    -+		       struct repository *repo UNUSED)
    ++		       void *data UNUSED)
      {
      	int allow_empty = 0;
      	const char *object_ref;
    @@ builtin/notes.c: static int append_edit(int argc, const char **argv, const char
      
     -static int show(int argc, const char **argv, const char *prefix)
     +static int show(int argc, const char **argv, const char *prefix,
    -+		struct repository *repo UNUSED)
    ++		void *data UNUSED)
      {
      	const char *object_ref;
      	struct notes_tree *t;
    @@ builtin/notes.c: static int git_config_get_notes_strategy(const char *key,
      
     -static int merge(int argc, const char **argv, const char *prefix)
     +static int merge(int argc, const char **argv, const char *prefix,
    -+		 struct repository *repo UNUSED)
    ++		 void *data UNUSED)
      {
      	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
      	struct object_id result_oid;
    @@ builtin/notes.c: static int remove_one_note(struct notes_tree *t, const char *na
      
     -static int remove_cmd(int argc, const char **argv, const char *prefix)
     +static int remove_cmd(int argc, const char **argv, const char *prefix,
    -+		      struct repository *repo UNUSED)
    ++		      void *data UNUSED)
      {
      	unsigned flag = 0;
      	int from_stdin = 0;
    @@ builtin/notes.c: static int remove_cmd(int argc, const char **argv, const char *
      
     -static int prune(int argc, const char **argv, const char *prefix)
     +static int prune(int argc, const char **argv, const char *prefix,
    -+		 struct repository *repo UNUSED)
    ++		 void *data UNUSED)
      {
      	struct notes_tree *t;
      	int show_only = 0, verbose = 0;
    @@ builtin/notes.c: static int prune(int argc, const char **argv, const char *prefi
      
     -static int get_ref(int argc, const char **argv, const char *prefix)
     +static int get_ref(int argc, const char **argv, const char *prefix,
    -+		   struct repository *repo UNUSED)
    ++		   void *data UNUSED)
      {
      	struct option options[] = { OPT_END() };
      	char *notes_ref;
    -@@ builtin/notes.c: static int get_ref(int argc, const char **argv, const char *prefix)
    - int cmd_notes(int argc,
    - 	      const char **argv,
    - 	      const char *prefix,
    --	      struct repository *repo UNUSED)
    -+	      struct repository *repo)
    - {
    - 	const char *override_notes_ref = NULL;
    - 	parse_opt_subcommand_fn *fn = NULL;
     @@ builtin/notes.c: int cmd_notes(int argc,
      		strbuf_release(&sb);
      	}
      
     -	return !!fn(argc, argv, prefix);
    -+	return !!fn(argc, argv, prefix, repo);
    ++	return !!fn(argc, argv, prefix, NULL);
      }
     
      ## builtin/reflog.c ##
    @@ builtin/reflog.c: static int expire_total_callback(const struct option *opt,
      
     -static int cmd_reflog_show(int argc, const char **argv, const char *prefix)
     +static int cmd_reflog_show(int argc, const char **argv, const char *prefix,
    -+			   struct repository *repo UNUSED)
    ++			   void *data UNUSED)
      {
      	struct option options[] = {
      		OPT_END()
    @@ builtin/reflog.c: static int show_reflog(const char *refname, void *cb_data UNUS
      
     -static int cmd_reflog_list(int argc, const char **argv, const char *prefix)
     +static int cmd_reflog_list(int argc, const char **argv, const char *prefix,
    -+			   struct repository *repo UNUSED)
    ++			   void *data UNUSED)
      {
      	struct option options[] = {
      		OPT_END()
    @@ builtin/reflog.c: static int cmd_reflog_list(int argc, const char **argv, const
      
     -static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
     +static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
    -+			     struct repository *repo UNUSED)
    ++			     void *data UNUSED)
      {
      	struct cmd_reflog_expire_cb cmd = { 0 };
      	timestamp_t now = time(NULL);
    @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, cons
      
     -static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
     +static int cmd_reflog_delete(int argc, const char **argv, const char *prefix,
    -+			     struct repository *repo UNUSED)
    ++			     void *data UNUSED)
      {
      	int i, status = 0;
      	unsigned int flags = 0;
    @@ builtin/reflog.c: static int cmd_reflog_delete(int argc, const char **argv, cons
      
     -static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
     +static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
    -+			     struct repository *repo UNUSED)
    ++			     void *data UNUSED)
      {
      	struct option options[] = {
      		OPT_END()
    +@@ builtin/reflog.c: static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
    + int cmd_reflog(int argc,
    + 	       const char **argv,
    + 	       const char *prefix,
    +-	       struct repository *repository)
    ++	       struct repository *repository UNUSED)
    + {
    + 	parse_opt_subcommand_fn *fn = NULL;
    + 	struct option options[] = {
     @@ builtin/reflog.c: int cmd_reflog(int argc,
      			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
      			     PARSE_OPT_KEEP_UNKNOWN_OPT);
      	if (fn)
     -		return fn(argc - 1, argv + 1, prefix);
    -+		return fn(argc - 1, argv + 1, prefix, repository);
    ++		return fn(argc - 1, argv + 1, prefix, NULL);
      	else
    - 		return cmd_log_reflog(argc, argv, prefix, repository);
    +-		return cmd_log_reflog(argc, argv, prefix, repository);
    ++		return cmd_log_reflog(argc, argv, prefix, NULL);
      }
     
      ## builtin/refs.c ##
    @@ builtin/refs.c
      
     -static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
     +static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
    -+			    struct repository *repo UNUSED)
    ++			    void *data UNUSED)
      {
      	const char * const migrate_usage[] = {
      		REFS_MIGRATE_USAGE,
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
      
     -static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
     +static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
    -+			   struct repository *repo UNUSED)
    ++			   void *data UNUSED)
      {
      	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
      	const char * const verify_usage[] = {
    -@@ builtin/refs.c: static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
    - int cmd_refs(int argc,
    - 	     const char **argv,
    - 	     const char *prefix,
    --	     struct repository *repo UNUSED)
    -+	     struct repository *repo)
    - {
    - 	const char * const refs_usage[] = {
    - 		REFS_MIGRATE_USAGE,
     @@ builtin/refs.c: int cmd_refs(int argc,
      	};
      
      	argc = parse_options(argc, argv, prefix, opts, refs_usage, 0);
     -	return fn(argc, argv, prefix);
    -+	return fn(argc, argv, prefix, repo);
    ++	return fn(argc, argv, prefix, NULL);
      }
     
      ## builtin/remote.c ##
    @@ builtin/remote.c: static int parse_mirror_opt(const struct option *opt, const ch
      
     -static int add(int argc, const char **argv, const char *prefix)
     +static int add(int argc, const char **argv, const char *prefix,
    -+	       struct repository *repo UNUSED)
    ++	       void *data UNUSED)
      {
      	int fetch = 0, fetch_tags = TAGS_DEFAULT;
      	unsigned mirror = MIRROR_NONE;
    @@ builtin/remote.c: static void handle_push_default(const char* old_name, const ch
      
     -static int mv(int argc, const char **argv, const char *prefix)
     +static int mv(int argc, const char **argv, const char *prefix,
    -+	      struct repository *repo UNUSED)
    ++	      void *data UNUSED)
      {
      	int show_progress = isatty(2);
      	struct option options[] = {
    @@ builtin/remote.c: static int mv(int argc, const char **argv, const char *prefix)
      
     -static int rm(int argc, const char **argv, const char *prefix)
     +static int rm(int argc, const char **argv, const char *prefix,
    -+	      struct repository *repo UNUSED)
    ++	      void *data UNUSED)
      {
      	struct option options[] = {
      		OPT_END()
    @@ builtin/remote.c: static int show_all(void)
      
     -static int show(int argc, const char **argv, const char *prefix)
     +static int show(int argc, const char **argv, const char *prefix,
    -+		struct repository *repo UNUSED)
    ++		void *data UNUSED)
      {
      	int no_query = 0, result = 0, query_flag = 0;
      	struct option options[] = {
    @@ builtin/remote.c: static int show(int argc, const char **argv, const char *prefi
      
     -static int set_head(int argc, const char **argv, const char *prefix)
     +static int set_head(int argc, const char **argv, const char *prefix,
    -+		    struct repository *repo UNUSED)
    ++		    void *data UNUSED)
      {
      	int i, opt_a = 0, opt_d = 0, result = 0;
      	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
    @@ builtin/remote.c: static int prune_remote(const char *remote, int dry_run)
      
     -static int prune(int argc, const char **argv, const char *prefix)
     +static int prune(int argc, const char **argv, const char *prefix,
    -+		 struct repository *repo UNUSED)
    ++		 void *data UNUSED)
      {
      	int dry_run = 0, result = 0;
      	struct option options[] = {
    @@ builtin/remote.c: static int get_remote_default(const char *key, const char *val
      
     -static int update(int argc, const char **argv, const char *prefix)
     +static int update(int argc, const char **argv, const char *prefix,
    -+		  struct repository *repo UNUSED)
    ++		  void *data UNUSED)
      {
      	int i, prune = -1;
      	struct option options[] = {
    @@ builtin/remote.c: static int set_remote_branches(const char *remotename, const c
      
     -static int set_branches(int argc, const char **argv, const char *prefix)
     +static int set_branches(int argc, const char **argv, const char *prefix,
    -+			struct repository *repo UNUSED)
    ++			void *data UNUSED)
      {
      	int add_mode = 0;
      	struct option options[] = {
    @@ builtin/remote.c: static int set_branches(int argc, const char **argv, const cha
      
     -static int get_url(int argc, const char **argv, const char *prefix)
     +static int get_url(int argc, const char **argv, const char *prefix,
    -+		   struct repository *repo UNUSED)
    ++		   void *data UNUSED)
      {
      	int i, push_mode = 0, all_mode = 0;
      	const char *remotename = NULL;
    @@ builtin/remote.c: static int get_url(int argc, const char **argv, const char *pr
      
     -static int set_url(int argc, const char **argv, const char *prefix)
     +static int set_url(int argc, const char **argv, const char *prefix,
    -+		   struct repository *repo UNUSED)
    ++		   void *data UNUSED)
      {
      	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
      	int matches = 0, negative_matches = 0;
    -@@ builtin/remote.c: static int set_url(int argc, const char **argv, const char *prefix)
    - int cmd_remote(int argc,
    - 	       const char **argv,
    - 	       const char *prefix,
    --	       struct repository *repo UNUSED)
    -+	       struct repository *repo)
    - {
    - 	parse_opt_subcommand_fn *fn = NULL;
    - 	struct option options[] = {
     @@ builtin/remote.c: int cmd_remote(int argc,
      			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
      
      	if (fn) {
     -		return !!fn(argc, argv, prefix);
    -+		return !!fn(argc, argv, prefix, repo);
    ++		return !!fn(argc, argv, prefix, NULL);
      	} else {
      		if (argc) {
      			error(_("unknown subcommand: `%s'"), argv[0]);
    @@ builtin/sparse-checkout.c: static char const * const builtin_sparse_checkout_lis
      
     -static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
     +static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
    -+				struct repository *repo UNUSED)
    ++				void *data UNUSED)
      {
      	static struct option builtin_sparse_checkout_list_options[] = {
      		OPT_END(),
    @@ builtin/sparse-checkout.c: static struct sparse_checkout_init_opts {
      
     -static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
     +static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
    -+				struct repository *repo UNUSED)
    ++				void *data UNUSED)
      {
      	struct pattern_list pl;
      	char *sparse_filename;
    @@ builtin/sparse-checkout.c: static struct sparse_checkout_add_opts {
      
     -static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
     +static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
    -+			       struct repository *repo UNUSED)
    ++			       void *data UNUSED)
      {
      	static struct option builtin_sparse_checkout_add_options[] = {
      		OPT_BOOL_F(0, "skip-checks", &add_opts.skip_checks,
    @@ builtin/sparse-checkout.c: static struct sparse_checkout_set_opts {
      
     -static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
     +static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
    -+			       struct repository *repo UNUSED)
    ++			       void *data UNUSED)
      {
      	int default_patterns_nr = 2;
      	const char *default_patterns[] = {"/*", "!/*/", NULL};
    @@ builtin/sparse-checkout.c: static struct sparse_checkout_reapply_opts {
      
      static int sparse_checkout_reapply(int argc, const char **argv,
     -				   const char *prefix)
    -+				   const char *prefix,
    -+				   struct repository *repo UNUSED)
    ++				   const char *prefix, void *data UNUSED)
      {
      	static struct option builtin_sparse_checkout_reapply_options[] = {
      		OPT_BOOL(0, "cone", &reapply_opts.cone_mode,
    @@ builtin/sparse-checkout.c: static char const * const builtin_sparse_checkout_dis
      
      static int sparse_checkout_disable(int argc, const char **argv,
     -				   const char *prefix)
    -+				   const char *prefix,
    -+				   struct repository *repo UNUSED)
    ++				   const char *prefix, void *data UNUSED)
      {
      	static struct option builtin_sparse_checkout_disable_options[] = {
      		OPT_END(),
    @@ builtin/sparse-checkout.c: static int check_rules(struct pattern_list *pl, int n
      
     -static int sparse_checkout_check_rules(int argc, const char **argv, const char *prefix)
     +static int sparse_checkout_check_rules(int argc, const char **argv, const char *prefix,
    -+				       struct repository *repo UNUSED)
    ++				       void *data UNUSED)
      {
      	static struct option builtin_sparse_checkout_check_rules_options[] = {
      		OPT_BOOL('z', NULL, &check_rules_opts.null_termination,
    -@@ builtin/sparse-checkout.c: static int sparse_checkout_check_rules(int argc, const char **argv, const char *
    - int cmd_sparse_checkout(int argc,
    - 			const char **argv,
    - 			const char *prefix,
    --			struct repository *repo UNUSED)
    -+			struct repository *repo)
    - {
    - 	parse_opt_subcommand_fn *fn = NULL;
    - 	struct option builtin_sparse_checkout_options[] = {
     @@ builtin/sparse-checkout.c: int cmd_sparse_checkout(int argc,
      	prepare_repo_settings(the_repository);
      	the_repository->settings.command_requires_full_index = 0;
      
     -	return fn(argc, argv, prefix);
    -+	return fn(argc, argv, prefix, repo);
    ++	return fn(argc, argv, prefix, NULL);
      }
     
      ## builtin/stash.c ##
    @@ builtin/stash.c: static int do_clear_stash(void)
      
     -static int clear_stash(int argc, const char **argv, const char *prefix)
     +static int clear_stash(int argc, const char **argv, const char *prefix,
    -+		       struct repository *repo UNUSED)
    ++		       void *data UNUSED)
      {
      	struct option options[] = {
      		OPT_END()
    @@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info
      
     -static int apply_stash(int argc, const char **argv, const char *prefix)
     +static int apply_stash(int argc, const char **argv, const char *prefix,
    -+		       struct repository *repo UNUSED)
    ++		       void *data UNUSED)
      {
      	int ret = -1;
      	int quiet = 0;
    @@ builtin/stash.c: static int get_stash_info_assert(struct stash_info *info, int a
      
     -static int drop_stash(int argc, const char **argv, const char *prefix)
     +static int drop_stash(int argc, const char **argv, const char *prefix,
    -+		      struct repository *repo UNUSED)
    ++		      void *data UNUSED)
      {
      	int ret = -1;
      	int quiet = 0;
    @@ builtin/stash.c: static int drop_stash(int argc, const char **argv, const char *
      
     -static int pop_stash(int argc, const char **argv, const char *prefix)
     +static int pop_stash(int argc, const char **argv, const char *prefix,
    -+		     struct repository *repo UNUSED)
    ++		     void *data UNUSED)
      {
      	int ret = -1;
      	int index = 0;
    @@ builtin/stash.c: static int pop_stash(int argc, const char **argv, const char *p
      
     -static int branch_stash(int argc, const char **argv, const char *prefix)
     +static int branch_stash(int argc, const char **argv, const char *prefix,
    -+			struct repository *repo UNUSED)
    ++			void *data UNUSED)
      {
      	int ret = -1;
      	const char *branch = NULL;
    @@ builtin/stash.c: static int branch_stash(int argc, const char **argv, const char
      
     -static int list_stash(int argc, const char **argv, const char *prefix)
     +static int list_stash(int argc, const char **argv, const char *prefix,
    -+		      struct repository *repo UNUSED)
    ++		      void *data UNUSED)
      {
      	struct child_process cp = CHILD_PROCESS_INIT;
      	struct option options[] = {
    @@ builtin/stash.c: static void diff_include_untracked(const struct stash_info *inf
      
     -static int show_stash(int argc, const char **argv, const char *prefix)
     +static int show_stash(int argc, const char **argv, const char *prefix,
    -+		      struct repository *repo UNUSED)
    ++		      void *data UNUSED)
      {
      	int i;
      	int ret = -1;
    @@ builtin/stash.c: static int do_store_stash(const struct object_id *w_commit, con
      
     -static int store_stash(int argc, const char **argv, const char *prefix)
     +static int store_stash(int argc, const char **argv, const char *prefix,
    -+		       struct repository *repo UNUSED)
    ++		       void *data UNUSED)
      {
      	int quiet = 0;
      	const char *stash_msg = NULL;
    @@ builtin/stash.c: static int do_create_stash(const struct pathspec *ps, struct st
      
     -static int create_stash(int argc, const char **argv, const char *prefix UNUSED)
     +static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
    -+			struct repository *repo UNUSED)
    ++			void *data UNUSED)
      {
      	int ret;
      	struct strbuf stash_msg_buf = STRBUF_INIT;
    @@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *
      
     -static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
     +static int push_stash_unassumed(int argc, const char **argv, const char *prefix,
    -+				struct repository *repo UNUSED)
    ++				void *data UNUSED)
      {
      	return push_stash(argc, argv, prefix, 0);
      }
      
     -static int save_stash(int argc, const char **argv, const char *prefix)
     +static int save_stash(int argc, const char **argv, const char *prefix,
    -+		      struct repository *repo UNUSED)
    ++		      void *data UNUSED)
      {
      	int keep_index = -1;
      	int only_staged = 0;
    -@@ builtin/stash.c: static int save_stash(int argc, const char **argv, const char *prefix)
    - int cmd_stash(int argc,
    - 	      const char **argv,
    - 	      const char *prefix,
    --	      struct repository *repo UNUSED)
    -+	      struct repository *repo)
    - {
    - 	pid_t pid = getpid();
    - 	const char *index_file;
     @@ builtin/stash.c: int cmd_stash(int argc,
      		    (uintmax_t)pid);
      
      	if (fn)
     -		return !!fn(argc, argv, prefix);
    -+		return !!fn(argc, argv, prefix, repo);
    ++		return !!fn(argc, argv, prefix, NULL);
      	else if (!argc)
     -		return !!push_stash_unassumed(0, NULL, prefix);
    -+		return !!push_stash_unassumed(0, NULL, prefix, repo);
    ++		return !!push_stash_unassumed(0, NULL, prefix, NULL);
      
      	/* Assume 'stash push' */
      	strvec_push(&args, "push");
    @@ builtin/submodule--helper.c: static void runcommand_in_submodule_cb(const struct
      
     -static int module_foreach(int argc, const char **argv, const char *prefix)
     +static int module_foreach(int argc, const char **argv, const char *prefix,
    -+			  struct repository *repo UNUSED)
    ++			  void *data UNUSED)
      {
      	struct foreach_cb info = FOREACH_CB_INIT;
      	struct pathspec pathspec = { 0 };
    @@ builtin/submodule--helper.c: static void init_submodule_cb(const struct cache_en
      
     -static int module_init(int argc, const char **argv, const char *prefix)
     +static int module_init(int argc, const char **argv, const char *prefix,
    -+		       struct repository *repo UNUSED)
    ++		       void *data UNUSED)
      {
      	struct init_cb info = INIT_CB_INIT;
      	struct pathspec pathspec = { 0 };
    @@ builtin/submodule--helper.c: static void status_submodule_cb(const struct cache_
      
     -static int module_status(int argc, const char **argv, const char *prefix)
     +static int module_status(int argc, const char **argv, const char *prefix,
    -+			 struct repository *repo UNUSED)
    ++			 void *data UNUSED)
      {
      	struct status_cb info = STATUS_CB_INIT;
      	struct pathspec pathspec = { 0 };
    @@ builtin/submodule--helper.c: static int compute_summary_module_list(struct objec
      
     -static int module_summary(int argc, const char **argv, const char *prefix)
     +static int module_summary(int argc, const char **argv, const char *prefix,
    -+			  struct repository *repo UNUSED)
    ++			  void *data UNUSED)
      {
      	struct summary_cb info = SUMMARY_CB_INIT;
      	int cached = 0;
    @@ builtin/submodule--helper.c: static void sync_submodule_cb(const struct cache_en
      
     -static int module_sync(int argc, const char **argv, const char *prefix)
     +static int module_sync(int argc, const char **argv, const char *prefix,
    -+		       struct repository *repo UNUSED)
    ++		       void *data UNUSED)
      {
      	struct sync_cb info = SYNC_CB_INIT;
      	struct pathspec pathspec = { 0 };
    @@ builtin/submodule--helper.c: static void deinit_submodule_cb(const struct cache_
      
     -static int module_deinit(int argc, const char **argv, const char *prefix)
     +static int module_deinit(int argc, const char **argv, const char *prefix,
    -+			 struct repository *repo UNUSED)
    ++			 void *data UNUSED)
      {
      	struct deinit_cb info = DEINIT_CB_INIT;
      	struct pathspec pathspec = { 0 };
    @@ builtin/submodule--helper.c: static int clone_submodule(const struct module_clon
      
     -static int module_clone(int argc, const char **argv, const char *prefix)
     +static int module_clone(int argc, const char **argv, const char *prefix,
    -+			struct repository *repo UNUSED)
    ++			void *data UNUSED)
      {
      	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
      	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
    @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *up
      
     -static int module_update(int argc, const char **argv, const char *prefix)
     +static int module_update(int argc, const char **argv, const char *prefix,
    -+			 struct repository *repo UNUSED)
    ++			 void *data UNUSED)
      {
      	struct pathspec pathspec = { 0 };
      	struct pathspec pathspec2 = { 0 };
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
      
     -static int push_check(int argc, const char **argv, const char *prefix UNUSED)
     +static int push_check(int argc, const char **argv, const char *prefix UNUSED,
    -+		      struct repository *repo UNUSED)
    ++		      void *data UNUSED)
      {
      	struct remote *remote;
      	const char *superproject_head;
    @@ builtin/submodule--helper.c: static int push_check(int argc, const char **argv,
      
     -static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
     +static int absorb_git_dirs(int argc, const char **argv, const char *prefix,
    -+			   struct repository *repo UNUSED)
    ++			   void *data UNUSED)
      {
      	int i;
      	struct pathspec pathspec = { 0 };
    @@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **a
      
     -static int module_set_url(int argc, const char **argv, const char *prefix)
     +static int module_set_url(int argc, const char **argv, const char *prefix,
    -+			  struct repository *repo UNUSED)
    ++			  void *data UNUSED)
      {
      	int quiet = 0, ret;
      	const char *newurl;
    @@ builtin/submodule--helper.c: static int module_set_url(int argc, const char **ar
      
     -static int module_set_branch(int argc, const char **argv, const char *prefix)
     +static int module_set_branch(int argc, const char **argv, const char *prefix,
    -+			     struct repository *repo UNUSED)
    ++			     void *data UNUSED)
      {
      	int opt_default = 0, ret;
      	const char *opt_branch = NULL;
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
      
     -static int module_create_branch(int argc, const char **argv, const char *prefix)
     +static int module_create_branch(int argc, const char **argv, const char *prefix,
    -+				struct repository *repo UNUSED)
    ++				void *data UNUSED)
      {
      	enum branch_track track;
      	int quiet = 0, force = 0, reflog = 0, dry_run = 0;
    @@ builtin/submodule--helper.c: static void die_on_repo_without_commits(const char
      
     -static int module_add(int argc, const char **argv, const char *prefix)
     +static int module_add(int argc, const char **argv, const char *prefix,
    -+		      struct repository *repo UNUSED)
    ++		      void *data UNUSED)
      {
      	int force = 0, quiet = 0, progress = 0, dissociate = 0;
      	struct add_data add_data = ADD_DATA_INIT;
    -@@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix)
    - int cmd_submodule__helper(int argc,
    - 			  const char **argv,
    - 			  const char *prefix,
    --			  struct repository *repo UNUSED)
    -+			  struct repository *repo)
    - {
    - 	parse_opt_subcommand_fn *fn = NULL;
    - 	const char *const usage[] = {
     @@ builtin/submodule--helper.c: int cmd_submodule__helper(int argc,
      	};
      	argc = parse_options(argc, argv, prefix, options, usage, 0);
      
     -	return fn(argc, argv, prefix);
    -+	return fn(argc, argv, prefix, repo);
    ++	return fn(argc, argv, prefix, NULL);
      }
     
      ## builtin/worktree.c ##
    @@ builtin/worktree.c: static void prune_worktrees(void)
      
     -static int prune(int ac, const char **av, const char *prefix)
     +static int prune(int ac, const char **av, const char *prefix,
    -+		 struct repository *repo UNUSED)
    ++		 void *data UNUSED)
      {
      	struct option options[] = {
      		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
    @@ builtin/worktree.c: static char *dwim_branch(const char *path, char **new_branch
      
     -static int add(int ac, const char **av, const char *prefix)
     +static int add(int ac, const char **av, const char *prefix,
    -+	       struct repository *repo UNUSED)
    ++	       void *data UNUSED)
      {
      	struct add_opts opts;
      	const char *new_branch_force = NULL;
    @@ builtin/worktree.c: static void pathsort(struct worktree **wt)
      
     -static int list(int ac, const char **av, const char *prefix)
     +static int list(int ac, const char **av, const char *prefix,
    -+		struct repository *repo UNUSED)
    ++		void *data UNUSED)
      {
      	int porcelain = 0;
      	int line_terminator = '\n';
    @@ builtin/worktree.c: static int list(int ac, const char **av, const char *prefix)
      
     -static int lock_worktree(int ac, const char **av, const char *prefix)
     +static int lock_worktree(int ac, const char **av, const char *prefix,
    -+			 struct repository *repo UNUSED)
    ++			 void *data UNUSED)
      {
      	const char *reason = "", *old_reason;
      	struct option options[] = {
    @@ builtin/worktree.c: static int lock_worktree(int ac, const char **av, const char
      
     -static int unlock_worktree(int ac, const char **av, const char *prefix)
     +static int unlock_worktree(int ac, const char **av, const char *prefix,
    -+			   struct repository *repo UNUSED)
    ++			   void *data UNUSED)
      {
      	struct option options[] = {
      		OPT_END()
    @@ builtin/worktree.c: static void validate_no_submodules(const struct worktree *wt
      
     -static int move_worktree(int ac, const char **av, const char *prefix)
     +static int move_worktree(int ac, const char **av, const char *prefix,
    -+			 struct repository *repo UNUSED)
    ++			 void *data UNUSED)
      {
      	int force = 0;
      	struct option options[] = {
    @@ builtin/worktree.c: static int delete_git_work_tree(struct worktree *wt)
      
     -static int remove_worktree(int ac, const char **av, const char *prefix)
     +static int remove_worktree(int ac, const char **av, const char *prefix,
    -+			   struct repository *repo UNUSED)
    ++			   void *data UNUSED)
      {
      	int force = 0;
      	struct option options[] = {
    @@ builtin/worktree.c: static void report_repair(int iserr, const char *path, const
      
     -static int repair(int ac, const char **av, const char *prefix)
     +static int repair(int ac, const char **av, const char *prefix,
    -+		  struct repository *repo UNUSED)
    ++		  void *data UNUSED)
      {
      	const char **p;
      	const char *self[] = { ".", NULL };
    -@@ builtin/worktree.c: static int repair(int ac, const char **av, const char *prefix)
    - int cmd_worktree(int ac,
    - 		 const char **av,
    - 		 const char *prefix,
    --		 struct repository *repo UNUSED)
    -+		 struct repository *repo)
    - {
    - 	parse_opt_subcommand_fn *fn = NULL;
    - 	struct option options[] = {
     @@ builtin/worktree.c: int cmd_worktree(int ac,
      	prepare_repo_settings(the_repository);
      	the_repository->settings.command_requires_full_index = 0;
      
     -	return fn(ac, av, prefix);
    -+	return fn(ac, av, prefix, repo);
    ++	return fn(ac, av, prefix, NULL);
      }
     
      ## parse-options.h ##
    -@@
    - 
    - #include "gettext.h"
    - 
    -+struct repository;
    -+
    - /**
    -  * Refer to Documentation/technical/api-parse-options.txt for the API doc.
    -  */
     @@ parse-options.h: typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
      					      const char *arg, int unset);
      
      typedef int parse_opt_subcommand_fn(int argc, const char **argv,
     -				    const char *prefix);
    -+				    const char *prefix, struct repository *repo);
    ++				    const char *prefix, void *data);
      
      /*
       * `type`::
    @@ t/helper/test-parse-options.c: int cmd__parse_options_flags(int argc, const char
      
     -static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED)
     +static int subcmd_one(int argc, const char **argv, const char *prefix UNUSED,
    -+		      struct repository *repo UNUSED)
    ++		      void *data UNUSED)
      {
      	printf("fn: subcmd_one\n");
      	print_args(argc, argv);
    @@ t/helper/test-parse-options.c: int cmd__parse_options_flags(int argc, const char
      
     -static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED)
     +static int subcmd_two(int argc, const char **argv, const char *prefix UNUSED,
    -+		      struct repository *repo UNUSED)
    ++		      void *data UNUSED)
      {
      	printf("fn: subcmd_two\n");
      	print_args(argc, argv);


--- 

base-commit: 04eaff62f286226f501dd21f069e0e257aee11a6
change-id: 20241122-374-add-repository-to-subsubcommands-226a391d95c7

Thanks
- Karthik

