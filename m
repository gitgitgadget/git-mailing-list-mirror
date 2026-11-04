Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822007;
	b=LOS2rg47MaIgfQi0PAmgehuuU+anwCpqhsErc9P+Kze4umHfl8lQC2PaSc3M9Wis5lCP
	 c5QIhBp4X8GZySWRfC+GPkDc4uQy7IZjdDcUxuUkCwSO9ir0P9Tk8xQOLTEKQ/7cHo3Pg
	 EGkvbCU1P6OOJ74I780914VqwqpXjwIJy6ZXB/p8ITioVHejt4XlrBxlndmsOTTPzie4I
	 qJSkSMpAwCdCPMytsy2zBPYeuupJMzrHtpVcf9+SJ/nTGCbqvi2Q/3m/Zpf/UU4dAY2G0
	 cKb+4/XvuoSGUzDMs6nK+ru8Vz7MJcv0j7e+U/ZtIsSA2RHc1tTYW0P8iiR3/WItVfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=5aj+gybRWnZcO5jirgnBYuv2kZcBZ1AEMGtJ4gEhpes=;
	b=lEyCYugVS1F4KaYLOgy9vFR9Q8LmA9P8RGKAz1NZxOyJE0I7pvyJE3FsyZDxUp625ti2
	 ikmqmyYOyFpZYU9TmI3USsfh6/1tQfuYQSd/5Xsql6WdDTqcaJa1yDZowBzzKasu5d1mN
	 H6ngn7ej37N63tOCByx9Jd53DOPt80oA8iROwVmncDye4klMLIZjKAK3/LnF4hOB22i9y
	 gNRnTV+VORnyxP36TXU4kMo/lVBhqx2WzApu4TLK3UlPtVeW4LX44c/efQ+TGjbBnETLY
	 tgAni7GvCT4O890KnHD5rSB1DHThQygqG7a0cBhu0+iygBe34dCmXsN4X+SObR4BAow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QOwx7knG;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D496097649
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 19:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96D496097649
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QOwx7knG
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36d6e342f98so1170293eec.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 11:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822006; x=1794426806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5aj+gybRWnZcO5jirgnBYuv2kZcBZ1AEMGtJ4gEhpes=;
        b=QOwx7knGUYlO33GYZBJDlYlRS64aYewhOWAQDCW13gYf9+Yb1ZEjfhhItrDAPlJCFz
         zHf/p5ImZlPvsImsSUCSGmQKAIsdlp8Q3XpDCVcIYpga0S+uJV5/S2OmGB4616wsnzxt
         kj4v4x3sTTV2dBciU2KB4TxG90F6Co1E2ATypKzYM2XAyfCnwKYodqPhOtX5p4so9uvQ
         4tQ9PTGrFdAgSDEwvtUdeYZnEufo1G5FThYjvagid7+gF2zLCCkL6MZd32RU9RXU0mXL
         UTVhVkaJqCZiVkgqALdVOfC0+QF4em51m82peKz+Kw0h7lRLPcJtp3+xCafcNNFoveRk
         Srjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822006; x=1794426806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5aj+gybRWnZcO5jirgnBYuv2kZcBZ1AEMGtJ4gEhpes=;
        b=vgqKM5s7oxIRUooLPe4O7gLRB22UB7YwsGvdvi9dwCXWZX4FzDy9XrR7D93X4IpAZQ
         q+W52imQtX0Ljv+nyh2g7a6eJx919UZKgjkmdZrtYulMhLbH2DuCP6TQSn8k9rAYjWDE
         UAQZC802DdRVzizKg7SMgOttzeLzIC9izXBCffwsPnfryxMXXLAQjhNHojaZvZ0f41zT
         dKkHqhPmmX92CK9y71Y7VTfU+Fn/wXB0yQ6tsetOnLpIjuFy//8FSg5eGKwneDVPFjAR
         3yGtjJmKR0Ybz9yx5A3zXmyf8PsAQGlxfuF6uesWPSC5C5SzlvE8QQZILETW7+bZjIPV
         E5dg==
X-Gm-Message-State: APuU4Z9lTZOOEnkohp7ZVAi3HfVU6EVQAsGFBRdMcoTMPHeFyJx6f1R5
	xHHq98b4lBEou3WfNKcRiPXO8JLrd3biT8hmvpyxAe7OINoAs6uz6OzJ
X-Gm-Gg: AYBFou3cU+i8+Pcjr/sg+72Zp82CXsNRpKlZKu+/aDyslrLFVA2ea1RkCzKnwqGWyso
	tWTZwzm0SkEhcGQJlEtXznzRf2K6cvleYRq6bh8pgFAlT6/Dt2dWOYNhzv6f41nbOPIZ/6aptXp
	IXJHjKcgKKn04T/6UM1nyAeaEXVwSxQ9AOe8Umq4EsfdFNGzKPZ5k/OIQ6N6ijjBV7cLQnsXTI7
	icZQYa/6UAr+SGWh9NMAbln7adxos9f1Ex+1LPj0lyT19LwXRx1teTWIBxkEn5hZrYOHDasp/WL
	T11IOhOw3p0+S3ugxcSVNO2rvWp3GWnTUhyceW1I/aIYbW9AE3yMzEbMttSRsEi7XvBOSnhPhRi
	NWcUKs8xR1FJ2dvvSUR55zD4eaNKIHkMgVg9eQ5Ot9qR+JUQWEroRKZbFbM2kMS9xsxeVHocEqL
	VV+Q97h6m2UwYv7b6rv+GDpvmKuVHlZyr1D2ig97Xj541Kvd81+zV1DucSngT2UfOtLgvp49ePY
	PIcLrTIRnBwwiHrEY40YwHY6/L5HNnCwSqZZrXjPP7Ug61yTo8snhaopg5UyLP3XUqgsLvP2Mko
	iI1aylTB/PMg9xqw6D7D9bih/qEpmNMsvC4=
X-Received: by 2002:a05:7300:c00e:20b0:35d:4e41:d2c2 with SMTP id 5a478bee46e88-36a4241b0b2mr29274798eec.33.1793822005391;
        Wed, 04 Nov 2026 11:53:25 -0800 (PST)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3788bffsm9598670eec.1.2026.11.04.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:53:25 -0800 (PST)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Wed, 04 Nov 2026 11:53:16 -0800
Subject: [PATCH v2 3/3] credential-cache--daemon: do not take over a
 running daemon's socket
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-fz-credential-cache-race-v2-3-ddccd0831eba@gmail.com>
References: <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
In-Reply-To: <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Patrick Steinhardt <ps@pks.im>, M Hickford <mirth.hickford@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Jeff Hostetler <jeffhostetler@github.com>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.15.2

When no daemon is running, two "git credential-cache store" run at the
same time each try to start one. unix_stream_listen() removes whatever
is at the socket path before it binds, so the second daemon takes over
the socket of the first. The first daemon keeps running, but no client
can reach it:

 - the credential its client stored is lost;

 - "git credential-cache exit" does not stop it, and it keeps the
   password in memory until it times out;

 - when it does exit, it removes the socket of the daemon that is
   still running, losing that daemon's credentials too.

Fix this by creating the socket with unix_ss_create(), which the
simple-ipc server already uses. It takes a lock and binds only if no
other server is listening on the socket. The lock is held only while
binding, so a stale lockfile left behind by a crashed daemon is
unlikely to need manual cleanup.

Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
 builtin/credential-cache--daemon.c | 28 ++++++++++++++++++++--------
 t/t0301-credential-cache.sh        | 23 +++++++++++++++++++++++
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 9e6ed9c922..03d314f19f 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -11,6 +11,7 @@
 #include "tempfile.h"
 #include "credential.h"
 #include "unix-socket.h"
+#include "unix-stream-server.h"
 
 struct credential_cache_entry {
 	struct credential item;
@@ -231,12 +232,25 @@ static int serve_cache_loop(int fd)
 static void serve_cache(const char *socket_path, int debug)
 {
 	struct unix_stream_listen_opts opts = UNIX_STREAM_LISTEN_OPTS_INIT;
-	int fd;
+	struct unix_ss_socket *server_socket;
+	struct tempfile *socket_file;
+	int ret;
 
-	fd = unix_stream_listen(socket_path, &opts);
-	if (fd < 0)
+	ret = unix_ss_create(socket_path, &opts, -1, &server_socket);
+	if (ret == -2) {
+		/*
+		 * Another daemon is already listening on the socket. "ok"
+		 * tells our client that a daemon is ready, after which the
+		 * client connects to the socket and talks to that daemon.
+		 */
+		printf("ok\n");
+		exit(0);
+	}
+	if (ret < 0)
 		die_errno("unable to bind to '%s'", socket_path);
 
+	socket_file = register_tempfile(socket_path);
+
 	printf("ok\n");
 	fclose(stdout);
 	if (!debug) {
@@ -244,10 +258,11 @@ static void serve_cache(const char *socket_path, int debug)
 			die_errno("unable to point stderr to /dev/null");
 	}
 
-	while (serve_cache_loop(fd))
+	while (serve_cache_loop(server_socket->fd_socket))
 		; /* nothing */
 
-	close(fd);
+	delete_tempfile(&socket_file);
+	unix_ss_free(server_socket);
 }
 
 static const char permissions_advice[] = N_(
@@ -303,7 +318,6 @@ int cmd_credential_cache_daemon(int argc,
 				const char *prefix,
 				struct repository *repo UNUSED)
 {
-	struct tempfile *socket_file;
 	const char *socket_path;
 	int ignore_sighup = 0;
 	static const char *usage[] = {
@@ -331,13 +345,11 @@ int cmd_credential_cache_daemon(int argc,
 		die("socket directory must be an absolute path");
 
 	init_socket_directory(socket_path);
-	socket_file = register_tempfile(socket_path);
 
 	if (ignore_sighup)
 		signal(SIGHUP, SIG_IGN);
 
 	serve_cache(socket_path, debug);
-	delete_tempfile(&socket_file);
 
 	return 0;
 }
diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 6f7cfd9e33..8e07e55520 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -51,6 +51,29 @@ test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
 	test_path_is_socket "$HOME/.cache/git/credential/socket"
 '
 
+test_expect_success 'a second daemon does not take over the socket' '
+	test_when_finished "git credential-cache exit" &&
+	check approve cache <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	git credential-cache--daemon "$HOME/.cache/git/credential/socket" >out &&
+	echo ok >expect &&
+	test_cmp expect out &&
+	check fill cache <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	--
+	EOF
+'
+
 XDG_CACHE_HOME="$HOME/xdg"
 export XDG_CACHE_HOME
 # test behavior when XDG_CACHE_HOME is set

-- 
2.55.0

