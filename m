Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DFB41F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeFBEdJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:09 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45601 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeFBEdB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:01 -0400
Received: by mail-lf0-f68.google.com with SMTP id n3-v6so17613995lfe.12
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWWAYB/QRnXrBZwaKrnt1pptn9162fawxr7+E16CwzQ=;
        b=rAq2rNfkZFjxwqA2i9uQr/9oT7YeT4sWGLjLWntTSgNK9jnSAx+qt4o+ZqLmZLK8xJ
         LhHrAzEaP6Ntmi9sLq8Sd0KBcVRnW5//8/f32FBMVotsSK4cMQG6l5UMDdNEHv1XKVG4
         wmL679DiPYJB3KPL9f2diRQ3lgj0fZaHKcT9TQbHparBnNsBoLk//OYhgEXGuC7SbjfE
         POkM6TmJuymYgNGNBg24TmCneAcNMpphcdZaymmvJCYbJjbA9rzmNPH25ElRLbOIIKz1
         OoRfPTxqDvV87UnanohxjF6ZKUwqyaxqtnf7y6A8JAivHi9zOLBxxdYnseTS6Mxep+bS
         zvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWWAYB/QRnXrBZwaKrnt1pptn9162fawxr7+E16CwzQ=;
        b=F4K/mHcTckceliBiCTSogu9mqPzz5MN11WyXVUUKycbK0+f6y2x+/o+vBRpWxvz+31
         UTg/r8cJAeFCFRpNqRQVyUpFm3VkD2GhECmgdGQT6N7cUgGUvLDShgp56IJ46U1O/tc+
         InI0nnS+1W0JUv7qkZxUfontqDKZ/ZwL59e5Uz9xJgXtIxK4cujpVHylMMm616t9w25i
         aOSn5q9dxmLvoYU8MYb3jiciJL4W2XXH1Lmdi9bkBnsXdEMkKZWxFIdIzsKQ8CSj7haL
         HnePHeqca90jUX6MipX38OsD/7dQU63fa87lIsxvO7P7u29iAwkXRl128UlxQ10IywjF
         emNA==
X-Gm-Message-State: ALKqPwc2NY7rCd2RfaAvRlqt9KkvGs1A5tsZW6PThlqpExo1hKxDlfYB
        dulqRQ/VTjE+heMS9jmrT42QNA==
X-Google-Smtp-Source: ADUXVKLRUP4FmK384dt12x21J2kkc/qy0lfQUTEYyBCPPK89L2rHFT34g9SpOe6SPRuq6lqdgPw7EQ==
X-Received: by 2002:a2e:5c8:: with SMTP id 191-v6mr10228868ljf.136.1527913978920;
        Fri, 01 Jun 2018 21:32:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:32:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/22] connect.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:28 +0200
Message-Id: <20180602043241.9941-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are also some rephrasing and breaking sentences to help
translators.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 connect.c             | 87 +++++++++++++++++++++++--------------------
 t/t5512-ls-remote.sh  |  2 +-
 t/t5570-git-daemon.sh |  6 +--
 3 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/connect.c b/connect.c
index 968e91b18c..af8a581d0e 100644
--- a/connect.c
+++ b/connect.c
@@ -58,9 +58,9 @@ static NORETURN void die_initial_contact(int unexpected)
 	 * response does not necessarily mean an ACL problem, though.
 	 */
 	if (unexpected)
-		die(_("The remote end hung up upon initial contact"));
+		die(_("the remote end hung up upon initial contact"));
 	else
-		die(_("Could not read from remote repository.\n\n"
+		die(_("could not read from remote repository.\n\n"
 		      "Please make sure you have the correct access rights\n"
 		      "and the repository exists."));
 }
@@ -78,7 +78,7 @@ int server_supports_v2(const char *c, int die_on_error)
 	}
 
 	if (die_on_error)
-		die("server doesn't support '%s'", c);
+		die(_("server doesn't support '%s'"), c);
 
 	return 0;
 }
@@ -100,7 +100,7 @@ int server_supports_feature(const char *c, const char *feature,
 	}
 
 	if (die_on_error)
-		die("server doesn't support feature '%s'", feature);
+		die(_("server doesn't support feature '%s'"), feature);
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static void process_capabilities_v2(struct packet_reader *reader)
 		argv_array_push(&server_capabilities_v2, reader->line);
 
 	if (reader->status != PACKET_READ_FLUSH)
-		die("expected flush after capabilities");
+		die(_("expected flush after capabilities"));
 }
 
 enum protocol_version discover_version(struct packet_reader *reader)
@@ -230,7 +230,7 @@ static int process_dummy_ref(const char *line)
 static void check_no_capabilities(const char *line, int len)
 {
 	if (strlen(line) != len)
-		warning("Ignoring capabilities after first line '%s'",
+		warning(_("ignoring capabilities after first line '%s'"),
 			line + strlen(line));
 }
 
@@ -249,7 +249,7 @@ static int process_ref(const char *line, int len, struct ref ***list,
 	if (extra_have && !strcmp(name, ".have")) {
 		oid_array_append(extra_have, &old_oid);
 	} else if (!strcmp(name, "capabilities^{}")) {
-		die("protocol error: unexpected capabilities^{}");
+		die(_("protocol error: unexpected capabilities^{}"));
 	} else if (check_ref(name, flags)) {
 		struct ref *ref = alloc_ref(name);
 		oidcpy(&ref->old_oid, &old_oid);
@@ -270,9 +270,9 @@ static int process_shallow(const char *line, int len,
 		return 0;
 
 	if (get_oid_hex(arg, &old_oid))
-		die("protocol error: expected shallow sha-1, got '%s'", arg);
+		die(_("protocol error: expected shallow sha-1, got '%s'"), arg);
 	if (!shallow_points)
-		die("repository on the other end cannot be shallow");
+		die(_("repository on the other end cannot be shallow"));
 	oid_array_append(shallow_points, &old_oid);
 	check_no_capabilities(line, len);
 	return 1;
@@ -307,13 +307,13 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 		case PACKET_READ_NORMAL:
 			len = reader->pktlen;
 			if (len > 4 && skip_prefix(reader->line, "ERR ", &arg))
-				die("remote error: %s", arg);
+				die(_("remote error: %s"), arg);
 			break;
 		case PACKET_READ_FLUSH:
 			state = EXPECTING_DONE;
 			break;
 		case PACKET_READ_DELIM:
-			die("invalid packet");
+			die(_("invalid packet"));
 		}
 
 		switch (state) {
@@ -333,7 +333,7 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 		case EXPECTING_SHALLOW:
 			if (process_shallow(reader->line, len, shallow_points))
 				break;
-			die("protocol error: unexpected '%s'", reader->line);
+			die(_("protocol error: unexpected '%s'"), reader->line);
 		case EXPECTING_DONE:
 			break;
 		}
@@ -441,11 +441,11 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		if (!process_ref_v2(reader->line, &list))
-			die("invalid ls-refs response: %s", reader->line);
+			die(_("invalid ls-refs response: %s"), reader->line);
 	}
 
 	if (reader->status != PACKET_READ_FLUSH)
-		die("expected flush after ref listing");
+		die(_("expected flush after ref listing"));
 
 	return list;
 }
@@ -544,7 +544,7 @@ static enum protocol get_protocol(const char *name)
 		return PROTO_SSH;
 	if (!strcmp(name, "file"))
 		return PROTO_FILE;
-	die("I don't handle protocol '%s'", name);
+	die(_("protocol '%s' is not supported"), name);
 }
 
 static char *host_end(char **hoststart, int removebrackets)
@@ -595,8 +595,7 @@ static void enable_keepalive(int sockfd)
 	int ka = 1;
 
 	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0)
-		fprintf(stderr, "unable to set SO_KEEPALIVE on socket: %s\n",
-			strerror(errno));
+		error_errno(_("unable to set SO_KEEPALIVE on socket"));
 }
 
 #ifndef NO_IPV6
@@ -636,14 +635,17 @@ static int git_tcp_connect_sock(char *host, int flags)
 	hints.ai_protocol = IPPROTO_TCP;
 
 	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "Looking up %s ... ", host);
+		fprintf(stderr, _("Looking up %s ... "), host);
 
 	gai = getaddrinfo(host, port, &hints, &ai);
 	if (gai)
-		die("Unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
+		die(_("unable to look up %s (port %s) (%s)"), host, port, gai_strerror(gai));
 
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
+	if (flags & CONNECT_VERBOSE) {
+		/* TRANSLATORS: this is the end of "Looking up %s ... " */
+		fprintf_ln(stderr, _("done."));
+		fprintf(stderr, _("Connecting to %s (port %s) ... "), host, port);
+	}
 
 	for (ai0 = ai; ai; ai = ai->ai_next, cnt++) {
 		sockfd = socket(ai->ai_family,
@@ -665,12 +667,13 @@ static int git_tcp_connect_sock(char *host, int flags)
 	freeaddrinfo(ai0);
 
 	if (sockfd < 0)
-		die("unable to connect to %s:\n%s", host, error_message.buf);
+		die(_("unable to connect to %s:\n%s"), host, error_message.buf);
 
 	enable_keepalive(sockfd);
 
 	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\n");
+		/* TRANSLATORS: this is the end of "Connecting to %s (port %s) ... " */
+		fprintf_ln(stderr, _("done."));
 
 	strbuf_release(&error_message);
 
@@ -697,22 +700,25 @@ static int git_tcp_connect_sock(char *host, int flags)
 	get_host_and_port(&host, &port);
 
 	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "Looking up %s ... ", host);
+		fprintf(stderr, _("Looking up %s ... "), host);
 
 	he = gethostbyname(host);
 	if (!he)
-		die("Unable to look up %s (%s)", host, hstrerror(h_errno));
+		die(_("unable to look up %s (%s)"), host, hstrerror(h_errno));
 	nport = strtoul(port, &ep, 10);
 	if ( ep == port || *ep ) {
 		/* Not numeric */
 		struct servent *se = getservbyname(port,"tcp");
 		if ( !se )
-			die("Unknown port %s", port);
+			die(_("unknown port %s"), port);
 		nport = se->s_port;
 	}
 
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
+	if (flags & CONNECT_VERBOSE) {
+		/* TRANSLATORS: this is the end of "Looking up %s ... " */
+		fprintf_ln(stderr, _("done."));
+		fprintf(stderr, _("Connecting to %s (port %s) ... "), host, port);
+	}
 
 	for (cnt = 0, ap = he->h_addr_list; *ap; ap++, cnt++) {
 		memset(&sa, 0, sizeof sa);
@@ -740,12 +746,13 @@ static int git_tcp_connect_sock(char *host, int flags)
 	}
 
 	if (sockfd < 0)
-		die("unable to connect to %s:\n%s", host, error_message.buf);
+		die(_("unable to connect to %s:\n%s"), host, error_message.buf);
 
 	enable_keepalive(sockfd);
 
 	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\n");
+		/* TRANSLATORS: this is the end of "Connecting to %s (port %s) ... " */
+		fprintf_ln(stderr, _("done."));
 
 	return sockfd;
 }
@@ -842,9 +849,9 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	get_host_and_port(&host, &port);
 
 	if (looks_like_command_line_option(host))
-		die("strange hostname '%s' blocked", host);
+		die(_("strange hostname '%s' blocked"), host);
 	if (looks_like_command_line_option(port))
-		die("strange port '%s' blocked", port);
+		die(_("strange port '%s' blocked"), port);
 
 	proxy = xmalloc(sizeof(*proxy));
 	child_process_init(proxy);
@@ -854,7 +861,7 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	proxy->in = -1;
 	proxy->out = -1;
 	if (start_command(proxy))
-		die("cannot start proxy %s", git_proxy_command);
+		die(_("cannot start proxy %s"), git_proxy_command);
 	fd[0] = proxy->out; /* read from proxy stdout */
 	fd[1] = proxy->in;  /* write to proxy stdin */
 	return proxy;
@@ -921,7 +928,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 		path = strchr(end, separator);
 
 	if (!path || !*path)
-		die("No path specified. See 'man git-pull' for valid url syntax");
+		die(_("no path specified. See 'man git-pull' for valid url syntax"));
 
 	/*
 	 * null-terminate hostname and point path to ~ for URL's like this:
@@ -1116,7 +1123,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 		case VARIANT_AUTO:
 			BUG("VARIANT_AUTO passed to push_ssh_options");
 		case VARIANT_SIMPLE:
-			die("ssh variant 'simple' does not support -4");
+			die(_("ssh variant 'simple' does not support -4"));
 		case VARIANT_SSH:
 		case VARIANT_PLINK:
 		case VARIANT_PUTTY:
@@ -1128,7 +1135,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 		case VARIANT_AUTO:
 			BUG("VARIANT_AUTO passed to push_ssh_options");
 		case VARIANT_SIMPLE:
-			die("ssh variant 'simple' does not support -6");
+			die(_("ssh variant 'simple' does not support -6"));
 		case VARIANT_SSH:
 		case VARIANT_PLINK:
 		case VARIANT_PUTTY:
@@ -1145,7 +1152,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 		case VARIANT_AUTO:
 			BUG("VARIANT_AUTO passed to push_ssh_options");
 		case VARIANT_SIMPLE:
-			die("ssh variant 'simple' does not support setting port");
+			die(_("ssh variant 'simple' does not support setting port"));
 		case VARIANT_SSH:
 			argv_array_push(args, "-p");
 			break;
@@ -1168,7 +1175,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 	enum ssh_variant variant;
 
 	if (looks_like_command_line_option(ssh_host))
-		die("strange hostname '%s' blocked", ssh_host);
+		die(_("strange hostname '%s' blocked"), ssh_host);
 
 	ssh = get_ssh_command();
 	if (ssh) {
@@ -1256,7 +1263,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		child_process_init(conn);
 
 		if (looks_like_command_line_option(path))
-			die("strange pathname '%s' blocked", path);
+			die(_("strange pathname '%s' blocked"), path);
 
 		strbuf_addstr(&cmd, prog);
 		strbuf_addch(&cmd, ' ');
@@ -1301,7 +1308,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		argv_array_push(&conn->args, cmd.buf);
 
 		if (start_command(conn))
-			die("unable to fork");
+			die(_("unable to fork"));
 
 		fd[0] = conn->out; /* read from child's stdout */
 		fd[1] = conn->in;  /* write to child's stdin */
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 6a949484d0..051d2659ae 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -130,7 +130,7 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 	fi &&
 	cat >exp <<-EOF &&
 	fatal: '\''$does_not_exist'\'' does not appear to be a git repository
-	fatal: Could not read from remote repository.
+	fatal: could not read from remote repository.
 
 	Please make sure you have the correct access rights
 	and the repository exists.
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 0d4c52016b..a571f22bfd 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -7,9 +7,9 @@ test_description='test fetching over git protocol'
 start_git_daemon
 
 check_verbose_connect () {
-	grep -F "Looking up 127.0.0.1 ..." stderr &&
-	grep -F "Connecting to 127.0.0.1 (port " stderr &&
-	grep -F "done." stderr
+	test_i18ngrep -F "Looking up 127.0.0.1 ..." stderr &&
+	test_i18ngrep -F "Connecting to 127.0.0.1 (port " stderr &&
+	test_i18ngrep -F "done." stderr
 }
 
 test_expect_success 'setup repository' '
-- 
2.18.0.rc0.309.g77c7720784

