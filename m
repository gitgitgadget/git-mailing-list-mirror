Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793575773;
	b=wrBgxo0xrPaISkNqbrkA9Puiza9ATdlMvDDTVqS+M1FD+Nz4xTyTlXThR8Z3FxwfIrrp
	 PbCnsQ5kkWt8SKsP5Ibpr53or4Ev8t5d9vEP8gNMTvsawVSeAtSZJCNrvgFzLw2rVL9wR
	 VDYOIBl9wzUFwN61b/GKHPDQqA9t5yedaapFo10lFS47C3i7YndjcjFcvkLoCY69brBDC
	 qwy/guG2B2XIe/OFeW3wIO0CGuk6G25o42WcUZmpc4HzQP1IjKixTrYRDM9N4LXqALGM9
	 9BQgH65if5ER6WIDReUBsg9MAWTPehXIij5V8+fwPY8H8ZqUm8Guu1YwUTCe+C5B8bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=xMhb76wvWFK1hk36+KOW+8sV3dyeaT6+fp6Gf9VbPg0=;
	b=RL7OfbLcIIeruJ5DG/zAJ6MjZIQSG5ttLdcBWF1mi+eGsGNNE9BK57RXIE8lfembQ+2p
	 SqTXANRkKVsCGl8+bfjZ1CGWIltopN0hsqszqtL5CeCKmhRhNxa/gi7kBzUBtgMxt0TRG
	 W8sBs482KjuPtT5MrzSsJ2qky72CvfmRjvheGdhE4vyuOeQQxv2TwxCnPQTsWwf1MA8x2
	 U1eSpSz+qgzTg51rXN4IOSw9p06TQREAqpnle785+4cmgXjQr6dz1wlmyorH0UmzpQQ/Y
	 Zu/ctQO78dLKPF4gcB5+Mk1xu2q8gSWWNypj0le2kT+j7PZdgF7aWhKUP/gpJa+x5mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DS/MgrTX";
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078F606A337
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5078F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DS/MgrTX
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a3c08d6928so2726815c88.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793575772; x=1794180572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xMhb76wvWFK1hk36+KOW+8sV3dyeaT6+fp6Gf9VbPg0=;
        b=DS/MgrTXCfSmtmhO8GWStm6KoELQ/gSiTlrdbQIPWm+ZLZCW35AqJZs+1Se71OVSTl
         CSHGmwG96e6yA3q0CtwITI5opajL1HeVkZ1bakk6bfTPhn/qrW9HhPV3JS/+xVrqtiXW
         qvXpSB6EF+MaPSfTK26oyctnkdvJ2lq8FW9QLmvX1CYOj6Fsfu5H+wck503I8CQv0LZ0
         Wx5TMMQ5Od804foIP10byZ0mjEVz9SOzQ3Y4ACJwTIspaAaEj/EMtaABDTPI815IerZU
         Z9y68eIhmf1DJpfrvkDpuftSNm5TXioPoVSkyH8+Ftc5SsmBl7HePqi27oLo1kZ/H2i9
         mfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793575772; x=1794180572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xMhb76wvWFK1hk36+KOW+8sV3dyeaT6+fp6Gf9VbPg0=;
        b=CqohzRn3pZTQVuRg/UdRiANWyCpgBGlnGJYmfzrXzKg19l9Xclc+jG0um4QfS4an6o
         EQuZrp6PsaXB9BibWn+8jh689S7GmS4xJjyuCD/htV1p9fpKMvqfT2qG25UbyD6HXs5u
         BKpfXwG5dZ3ot+klKoWiaVqKlauGQIwKQjEvG+03UhsR/yWyIddJHEuiYAjiH7hTskER
         B/omylKO6f9L6SJ6lOB3i/OUiIN5Q+CtpxKmxr3exZQb2DgDJrd7fKZxRKSgtFIoihIV
         DiZE5MItNzTKmoiMmmANuezWJhfBJvlpQGy0+aWbmbhHw685HoFxRz7geJtLobOh4Cjp
         rAQA==
X-Gm-Message-State: AFq9FYIEqL89QRo8zl3lvTq2xGIFk0mrojBAJgFHoxIzqakwoQ1UnLWp
	cFjVIXh8B/uauJzXV0aEoSMcHnuDpMWaUD0MgyyP1+zgmRSpmRo/F60p
X-Gm-Gg: AYBFou3AuNsl3sEkghx2S6TulXCxaF8yMG6TZcuijw2/ZsOVJWHKZO9pFbr5sIAlU+u
	S47ynOgyhPBJsJh9DWCuHBOIX41jyO5jt/q0iDS3kqgJRz+nM97Y9nBCPDfuPoVqGisTdTse+Sv
	8Q4F1R0l/3ppPTmS6aUwOWN4h9RaSRMlupUCUIvzmo2S4ZUEYc+Wp74yF46oiBzI/KEoUGZV2GO
	zJBk8wsXciuvl9fw1r2Dn/dtUitDe4wovsXIvIcjQDpwA3Yu4cmnJ6WZ8bz3Yd08mWBjoucdfCI
	qMVNPHHbWeBoBETGCUD3k3FHjc8pGJdC6YeK/mP2FbrKwtFxOjDm29/8B2WQPFcOZr3WKl39tyH
	XHMALDFzKkS8DFeuCcg4qfsRCKlDkADASJPBgVTLai5uqPXowSYrWFbuqw4tLspPNhi+xx8GH0b
	a8i1AxKPEw8MAY8cSvi5HgNDG6pHdwAIg6k4n8OGZzxhrwSOMIwJS70GTVWPo6TdtWa+a4U+7ga
	trHKoG74W6SR0V9coU/n21kvoNLEzYzGt7Bg3Kb/SoKRNFjl4TBH8pMrD2ipZxjsAe5/GpwDN5D
	KxtskoIpNRuWOZ45ZztOcB4eGc0eWgOpSWDG
X-Received: by 2002:a05:701b:4244:10b0:149:1b5b:1f25 with SMTP id a92af1059eb24-1ac5b211405mr13230699c88.15.1793575772168;
        Sun, 01 Nov 2026 15:29:32 -0800 (PST)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a98f65sm30367724eec.28.2026.11.01.15.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 15:29:31 -0800 (PST)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Sun, 01 Nov 2026 15:29:26 -0800
Subject: [PATCH 2/2] credential-cache--daemon: do not take over a running
 daemon's socket
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
Message-Id: <20261101-fz-credential-cache-race-v1-2-28f0bac51e11@gmail.com>
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
In-Reply-To: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
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

The fix is to create the socket with unix_ss_create(), which the
simple-ipc server already uses. It takes a lock and binds only if no
other server is listening on the socket. A daemon that finds one prints
"ok" and exits, and its client talks to the running daemon. Register
the socket for removal only after binding it, so a daemon that loses
never removes the other one's socket.

Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
 builtin/credential-cache--daemon.c | 29 +++++++++++++++++++++--------
 t/t0301-credential-cache.sh        | 23 +++++++++++++++++++++++
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 0dfa11e2ec..de6720c276 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -11,6 +11,7 @@
 #include "tempfile.h"
 #include "credential.h"
 #include "unix-socket.h"
+#include "unix-stream-server.h"
 
 struct credential_cache_entry {
 	struct credential item;
@@ -231,12 +232,26 @@ static int serve_cache_loop(int fd)
 static void serve_cache(const char *socket_path, int debug)
 {
 	struct unix_stream_listen_opts opts = UNIX_STREAM_LISTEN_OPTS_INIT;
-	int fd;
+	struct unix_ss_socket *server_socket;
+	struct tempfile *socket_file;
+	int ret;
 
-	fd = unix_stream_listen(socket_path, &opts);
-	if (fd < 0)
+	/*
+	 * Two clients may each start a daemon at the same time. Bind only
+	 * if no other daemon is listening yet; otherwise leave the socket
+	 * to that one, and our client will talk to it.
+	 */
+	ret = unix_ss_create(socket_path, &opts, -1, &server_socket);
+	if (ret == -2) {
+		printf("ok\n");
+		return;
+	}
+	if (ret < 0)
 		die_errno("unable to bind to '%s'", socket_path);
 
+	/* Remove the socket at exit only now that it is ours. */
+	socket_file = register_tempfile(socket_path);
+
 	printf("ok\n");
 	fclose(stdout);
 	if (!debug) {
@@ -244,10 +259,11 @@ static void serve_cache(const char *socket_path, int debug)
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
@@ -303,7 +319,6 @@ int cmd_credential_cache_daemon(int argc,
 				const char *prefix,
 				struct repository *repo UNUSED)
 {
-	struct tempfile *socket_file;
 	const char *socket_path;
 	int ignore_sighup = 0;
 	static const char *usage[] = {
@@ -331,13 +346,11 @@ int cmd_credential_cache_daemon(int argc,
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

