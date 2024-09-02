Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23219E98D
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279246; cv=none; b=qxDDsTblhDncKnvewh4yzqdR+QTwGB9Y0xUueGGpq2cT1AkDk+6vnsXlCl73hVGXk2hOX5UYNQKG9YbzD1SDl3ULSGy07Dky0bvE3ZHzMlQG/I3/ZSEK8yZ2gIGOl0BpwZLFwJcI3tuXh2i4S0rZ1lMDQ23b8WQ0heHgJYjPORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279246; c=relaxed/simple;
	bh=2AleUzX4KNTb1yimu4w4tptABuaI3Vn6zOpW0s3aLsA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hgyc32YjNOC2jP/koqIq3iibbRhQx22Pv30vNQ7780L5L/GO6irCnLn2AAWHLF1X6uXy0duklLHvmCP3gH7XNblOyac4pJilCf8enCUYQGohnWJH7GAZwy3TG59Qr15kYKfJuXpgTz/bb9PpKccLDdQgwRW2p71TSplO1XKolU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntAsAB8j; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntAsAB8j"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso4185880a12.2
        for <git@vger.kernel.org>; Mon, 02 Sep 2024 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725279242; x=1725884042; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf8pnEwTEFVQPc4gf21xDNxUWTveihY816B6E/0WvoI=;
        b=ntAsAB8jtanI3HS97OWt96CmDvDsn1lWO6DfqNBssxovkZXNL20mSFH5GHzruIN+6k
         mD0Nw/3t9LanBg9Ge6+niEPADrRxpB94elmWQpw/vBFr7rtQnGk/4Js8HGqLzxh9YGSa
         6DMVY7BNUPGtwfRnoEmf7NCOXEOPcO5JtS9xwyz6+Am7IzLQJ5uaxTCdzW4nz+Y3qE/E
         koOfRgAqyRSvGvIoUz8SpyRkS36yyN77ndgljTexoO8iqJ9ysuUU9I3/YBz/Aupf8dOU
         5qgZPAF1fcNpXVYpiC5dTP93Wjdr0qb/l1z7z++lbbKEb10zAlOYe+fKFAWIu4Tug8Up
         pdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725279242; x=1725884042;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tf8pnEwTEFVQPc4gf21xDNxUWTveihY816B6E/0WvoI=;
        b=Nxj+9rY3T7sXUwE91WVBCJkbsgWdHsiNnOmM8ODwCC+fWdGI4eAnHATFoWjZ1IvPJH
         kNBes5oPvUFuBhLJ3oKSUXIUVuw2WSSBTexY1E+TqIVOKWpbePypzCPp/vSpqB2Pb7ZB
         TQZQfyzl+XatK3ptKps0oneVyZRPsGFmgpQlNpATrwGg8krfMLL4Wnb0k3Et6b/4VU/q
         ZPJ3uCQ7nOez+9lzLstHfrZw98UOLgdyBreA3SFcAYB7JjGkil/9DghvAsKXvbKbEByn
         TkCSI1/mmAMb5Lja78APcTlEVw+/Vb+rNoC2oUfC1z7Q7EjX3SBhCC62WsOuQnM6w3Yg
         SDNQ==
X-Gm-Message-State: AOJu0YwSCtPb4q22DdjfHJofjngK6stigXMeY1Al25+mk+vTlGTqJ1xi
	l8m9XER/vgtPP43P9wVIAc0j1+sLNlv26eE7eSajEBqKUkMRouzpvqNw/w==
X-Google-Smtp-Source: AGHT+IHcsUrZkDZBrOzFSp1T++9KkMjNkJq2mTQs2et+0/OwDmq0a78YBjAviWSCIduUSc2SBiE/EA==
X-Received: by 2002:a17:907:868a:b0:a86:8d83:542d with SMTP id a640c23a62f3a-a89b96f6feamr531408966b.45.1725279241727;
        Mon, 02 Sep 2024 05:14:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892335b2sm547649266b.217.2024.09.02.05.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:14:01 -0700 (PDT)
Message-Id: <8962031f9997c4030cf32652908fc431f3bf9976.1725279236.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Sep 2024 12:13:56 +0000
Subject: [PATCH 4/4] builtin/ls-remote.c: recognize fetch.serverOption
 configuration
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
Cc: Brandon Williams <bmwill@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Teach git-ls-remote to recognize the `fetch.serverOption` configuration
as a default list of server options to send for Git protocol v2, if
server options are not explicitly set via the command line.

Tests and documentation have been updated accordingly.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 Documentation/git-ls-remote.txt |  3 +++
 builtin/ls-remote.c             | 32 ++++++++++++++++++++++++++++----
 t/t5702-protocol-v2.sh          | 29 ++++++++++++++++++++++++-----
 3 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 76c86c3ce4f..fc9930193f8 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -81,6 +81,9 @@ OPTIONS
 	character.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
+	When no `--server-option=<option>` is given from the command
+	line, the values of configuration variable `fetch.serverOption`
+	are used instead.
 
 <repository>::
 	The "remote" repository to query.  This parameter can be
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 0a491595ca8..87afd69828c 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "gettext.h"
 #include "hex.h"
 #include "transport.h"
@@ -8,6 +9,8 @@
 #include "parse-options.h"
 #include "wildmatch.h"
 
+static struct string_list config_server_options = STRING_LIST_INIT_DUP;
+
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--branches] [--tags] [--refs] [--upload-pack=<exec>]\n"
 	   "              [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]\n"
@@ -37,6 +40,18 @@ static int tail_match(const struct strvec *pattern, const char *path)
 	return 0;
 }
 
+static int git_ls_remote_config(const char *k, const char *v,
+			    const struct config_context *ctx, void *cb)
+{
+	if (!strcmp(k, "fetch.serveroption")) {
+		if (!v)
+			return config_error_nonbool(k);
+		parse_transport_option(v, &config_server_options);
+		return 0;
+	}
+	return git_default_config(k, v, ctx, cb);
+}
+
 int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 {
 	const char *dest = NULL;
@@ -49,8 +64,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct strvec pattern = STRVEC_INIT;
 	struct transport_ls_refs_options transport_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
+	struct string_list option_server_options = STRING_LIST_INIT_DUP;
+	struct string_list *server_options = NULL;
 	int i;
-	struct string_list server_options = STRING_LIST_INIT_DUP;
 
 	struct remote *remote;
 	struct transport *transport;
@@ -80,16 +96,23 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			      2, PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "symref", &show_symref_target,
 			 N_("show underlying ref in addition to the object pointed by it")),
-		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
+		OPT_STRING_LIST('o', "server-option", &option_server_options,
+				N_("server-specific"),
+				N_("option to transmit")),
 		OPT_END()
 	};
 
+	git_config(git_ls_remote_config, NULL);
+
 	memset(&ref_array, 0, sizeof(ref_array));
 
 	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	dest = argv[0];
 
+	server_options = option_server_options.nr ?
+			 &option_server_options : &config_server_options;
+
 	/*
 	 * TODO: This is buggy, but required for transport helpers. When a
 	 * transport helper advertises a "refspec", then we'd add that to a
@@ -130,8 +153,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	transport = transport_get(remote, NULL);
 	if (uploadpack)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
-	if (server_options.nr)
-		transport->server_options = &server_options;
+	if (server_options && server_options->nr)
+		transport->server_options = server_options;
 
 	ref = transport_get_remote_refs(transport, &transport_options);
 	if (ref) {
@@ -169,5 +192,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	transport_ls_refs_options_release(&transport_options);
 
 	strvec_clear(&pattern);
+	string_list_clear(&option_server_options, 0);
 	return status;
 }
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 3bf31fb570d..da6241afa22 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -173,16 +173,35 @@ test_expect_success 'ref advertisement is filtered with ls-remote using protocol
 test_expect_success 'server-options are sent when using ls-remote' '
 	test_when_finished "rm -f log" &&
 
-	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
-		ls-remote -o hello -o world "file://$(pwd)/file_parent" main >actual &&
-
 	cat >expect <<-EOF &&
 	$(git -C file_parent rev-parse refs/heads/main)$(printf "\t")refs/heads/main
 	EOF
 
+	# Specify server options from command line
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		ls-remote -o hello -o world "file://$(pwd)/file_parent" main >actual &&
+	test_cmp expect actual &&
+	test_grep "server-option=hello" log &&
+	test_grep "server-option=world" log &&
+	rm -f log &&
+
+	# Specify server options from fetch.serverOption config
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		-c fetch.serverOption=hello -c fetch.serverOption=world \
+		ls-remote "file://$(pwd)/file_parent" main >actual &&
+	test_cmp expect actual &&
+	test_grep "server-option=hello" log &&
+	test_grep "server-option=world" log &&
+	rm -f log &&
+
+	# Cmdline server options take a higher priority
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		-c fetch.serverOption=hello -c fetch.serverOption=world \
+		ls-remote -o foo=bar "file://$(pwd)/file_parent" main >actual &&
 	test_cmp expect actual &&
-	grep "server-option=hello" log &&
-	grep "server-option=world" log
+	test_grep ! "server-option=hello" log &&
+	test_grep ! "server-option=world" log &&
+	test_grep "server-option=foo=bar" log
 '
 
 test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
-- 
gitgitgadget
