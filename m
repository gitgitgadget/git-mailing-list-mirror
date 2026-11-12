Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513569;
	b=jOtVZkQzCNo91SQW6oA4THlbuw5Y+mYtKZzG5s/DRuJasIUagmgSk/VV0ynBKXnJoBbZ
	 8lxOWMX9ySzp0MmP8z1L7HJ84SXb1ip5wl+/1fus825W4Pwt/wSBBVw5sJ1yWggaSdA5E
	 VhHic0dH7NziWX+kaguaF/EhAw1bJexQZkAnTRKRH1tdAX3HajnJnbyJiXf18H8C54lHi
	 bF+1eas/LfoaraWzYjmvxK0XKmWhdNOMvsL4VH1+m04ILH24UNjqFDC/zKSLet7wMWEol
	 MFGxMcDw8aRnkfxmXtZkE9s7zfHV8Q7ezSQpg+0MxAPLvuxdtnEn6yQumeFH0azpAug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h7AjQSS0sAguvuv1f8Iea49cOSEmQuDEGG//0hMgN1M=;
	b=LCiYgwc/6ktdvSIs0UUJZXXUi4c+ede/fFN5oAp58QaQvFOwEofy5BV4YiD0dR2wHWFr
	 yqZ6I/W2gBj1a6c9ZASjceNJbnhhKbtiviSJZutkHTl8OSkn8YVGwg+sUGRI1u0bTm15S
	 G4oWcvnyCTrVMJ91ezCm5K/lLc3rjLoYoU8wMQDVesbcJlXMC/ke56es0Y9HXOnAy37bC
	 9BebiOBJaOk5Saj/0E4VEJ68HICkQGEqwNyGmVYPE7FT2s32oPEPYHCUkBA4QcGDKPBXQ
	 yuiyiTpUlSQsPUi2K6+izAVSKFkxQaviqIQD/o3al6yH/QFSq/KyMp4bO2a/NqFezyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MJyL7JY0;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A123606A88C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A123606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MJyL7JY0
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3720addb068so361419eec.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513568; x=1795118368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h7AjQSS0sAguvuv1f8Iea49cOSEmQuDEGG//0hMgN1M=;
        b=MJyL7JY0hGDPQgDrJEoj40+7RceKkfN8vBLtMmQWqd4DlNUx9UotzTfjiZu7oJiYp3
         wC9Cl9voCM9wzINKVgCvirv0nDbLdPXCU0Aila1aAv8LwvyhlkJFrtmhHEhOZgsD5xue
         GK1CrrIYk59U9zFPqgxhjgDTNsBrRr0VvameQ752A6DRDOW4sdLWEI/MP+lCXEcReuCX
         xvf/RTCyfm987VefFgNnVHzzEzNQ3MWFwo5YVRCdkDmicjRFvlZYY8VdjXNs+tRHQA4k
         Fp6J3Urdd0aSg01N8udZTWZZHUTInQBX5GLHzWHDY3+aUhtG8gEDeac7s+/01AgOQekn
         vXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513568; x=1795118368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h7AjQSS0sAguvuv1f8Iea49cOSEmQuDEGG//0hMgN1M=;
        b=L4LKiVcdbF4AJjKGUCB4tdBdOcU8FuB4bEIqXhpb3ZFapLUi0wCHwbk1T7/B4aMU3G
         jsOFxJ23rAlRDqznjw78PBM4JTwemMUx9pAOWd0jxlUNVHrBkK4QiUDUrFSa4/BIg3bT
         gtcXdE25ic0Nps3Da+mTqBZ5cAENoNBlrIMbTWhvEYi3ikhWyXIY18Zw4oWNM+yCXf7J
         ApwhDAd7DGl6Y2CLL0c7sQxT2sqxNUuRAJ8WkzgqiM2rrYYvJo8tK9LdGrD5MdZFbUJB
         r96r8ipVM+a3QVhg4RHbLakh+X97XLuCF4/r0fITNiz1CWMRm3Mu3v9rw/ODbt/f9Iua
         cO5w==
X-Gm-Message-State: APuU4Z9C6zA4PSfDhaSN+cUc6iB7XdvY3lZpKLWrLO7RaQG44r//E1w4
	ks4euRD1UjJNW+YA1wya1S+bajHzSpBsk9uvG2eU46aYv0zNJ1xLkxOIzNQ8N1PI
X-Gm-Gg: AYBFou0O+ABiVKpOFMnbhnxblayb27UVfzMAKoqDSt9R1y1CgT+wFZ17nxjlrppBXuF
	Jhcv1+ImeCwYbCIwDmpQkEfEsSrzGJAxdR1b7XKYpw5PopKpfkJUYG4tRF9WaRN2ioRxYrmLY9a
	7HJ8qlpyftjDn0lPAVcj1murvWAmxNJ4scRImvW3KSVyV+d+gqhFnDmk0yeWFqX194yg6untQFh
	pq1DbZjowzWudaV+Q+1tz2p27rzM4Vp4cO3rmm71reOXIdIbPppUbJD3pRLfGekOGau/L7pK1ww
	yXkznk2a+d2xM3zPsjCsUx3tA5Dogv3GDH5o8s+ICIV8cfumbE7bMuZUstQDOaWp8qOvnCPw7Pj
	Qv/g8qFqd7jp4cWmGDGsC7pItV+mreONSUkPUbD3tZqGM2qh/ueAojJxLpjQVYyt8khswKpKIah
	1/L3hnqYT3z05XIa7XFYiTXaDS5xFDKr5OBUPEV3wBxXhftW6sOFVfSk5cOu+0xlbO7XTkqXDTt
	Od337wzTpNBpj8BujyPCgMMotc/a2a3Alql47D7TfaOW18U0wDThyDSHIHc/WH4pgtyCPQGNGDY
	DB8CK4XuSr/zCykDaxV6s4Z3ReEwhDA23CLnTb9S/Tmydfdpq729isJBzsg60WUIlogOpJ3pEiX
	0jKwgq/YIMhMeHQhpr4KLZjpcHVh+rU94YxnWU56Z0HTKlTxlB2lRX55eIdfrWRLPsIGhkKToTV
	FtaNe3qNZ8dfkE2cN5CaLW1MRsCfFX3wzjd2HIgQkL9r/1MHTQXyKpb/JfvA==
X-Received: by 2002:a05:7301:8617:b0:370:cc56:b61a with SMTP id 5a478bee46e88-37967dd6065mr166659eec.39.1794513568109;
        Thu, 12 Nov 2026 11:59:28 -0800 (PST)
Received: from christian--20230123--2G7D3.nvidia.com ([216.228.127.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316fdsm640395eec.5.2026.11.12.11.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:59:26 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/3] fetch-pack: ensure fetch sends a promisor-remote reply
Date: Thu, 12 Nov 2026 20:59:01 +0100
Message-ID: <20261112195858.53788-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.471.g1891de46f7.dirty
In-Reply-To: <20261112195858.53788-5-christian.couder@gmail.com>
References: <20261112195858.53788-5-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In protocol v2, when the client accepts promisor remotes, the
`promisor-remote=...` reply is only written by send_capabilities(),
which is used to send the `ls-refs` and `bundle-uri` protocol commands.

The request for the `fetch` protocol command is built by
write_command_and_capabilities() called by send_fetch_request() in
"fetch-pack.c" which doesn't send that reply. do_fetch_pack_v2() calls
promisor_remote_reply(), but only to mark the accepted remotes, as
e15a6b2f8b (promisor-remote: change promisor_remote_reply()'s
signature, 2026-02-16) assumed that fetch-pack would not need to send
a reply.

With file:// and ssh:// URLs on a Git server, one upload-pack process
handles both `ls-refs` and `fetch`. The acceptance recorded during
`ls-refs` by promisor_remote_receive() in "serve.c" is still there at
`fetch` time, so the clone succeeds. But it fails when each request is
handled on its own, for example with HTTP where different upload-pack
processes are used, or with other server implementations like JGit.

It also fails when only object IDs are fetched, as no `ls-refs`
command is then sent. In these cases, the server doesn't know that the
client accepted a promisor remote, so it doesn't allow promisor
objects to be missing from the pack it sends, and it fails with "could
not fetch <oid> from promisor remote".

Let's fix that by always properly sending the `promisor-remote=...`
reply when sending a `fetch` request from do_fetch_pack_v2().

The `fetch` requests sent by negotiate_using_fetch() don't ask for a
pack, so they don't need that reply.

Let's also add tests in t5710 to check that the reply is sent with the
`fetch` request, and that fetching only an object ID works. For HTTP,
let's add a new t5711 test script, copying the setup from t5710.

Reported-by: Matt Cote <mcote@nvidia.com>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 fetch-pack.c                               |  13 ++-
 t/meson.build                              |   1 +
 t/t5710-promisor-remote-capability.sh      |  40 +++++++
 t/t5711-promisor-remote-capability-http.sh | 126 +++++++++++++++++++++
 4 files changed, 176 insertions(+), 4 deletions(-)
 create mode 100755 t/t5711-promisor-remote-capability-http.sh

diff --git a/fetch-pack.c b/fetch-pack.c
index 50c97f561e..2f1bb9d62c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1380,14 +1380,16 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain,
 			      int sideband_all, int seen_ack,
-			      struct oidset *negotiation_include_oids)
+			      struct oidset *negotiation_include_oids,
+			      const char *promisor_remote_reply)
 {
 	int haves_added;
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
 	write_command_and_capabilities(&req_buf, "fetch",
-				       args->server_options, NULL);
+				       args->server_options,
+				       promisor_remote_reply);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -1696,11 +1698,12 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
 	const char *promisor_remote_config;
+	char *accepted = NULL;
 
 	fsck_options_init(&fsck_options, the_repository, FSCK_OPTIONS_MISSING_GITMODULES);
 
 	if (server_feature_v2("promisor-remote", &promisor_remote_config))
-		promisor_remote_reply(promisor_remote_config, NULL);
+		promisor_remote_reply(promisor_remote_config, &accepted);
 
 	if (args->filter_options.choice == LOFC_AUTO) {
 		struct strbuf errbuf = STRBUF_INIT;
@@ -1778,7 +1781,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 					       &haves_to_send, &in_vain,
 					       reader.use_sideband,
 					       seen_ack,
-					       &negotiation_include_oids)) {
+					       &negotiation_include_oids,
+					       accepted)) {
 				trace2_region_leave_printf("negotiation_v2", "round",
 							   the_repository, "%d",
 							   negotiation_round);
@@ -1928,6 +1932,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	if (negotiator)
 		negotiator->release(negotiator);
 
+	free(accepted);
 	fsck_options_clear(&fsck_options);
 	oidset_clear(&common);
 	oidset_clear(&negotiation_include_oids);
diff --git a/t/meson.build b/t/meson.build
index 1cf1d95f70..84644703f1 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -766,6 +766,7 @@ integration_tests = [
   't5704-protocol-violations.sh',
   't5705-session-id-in-capabilities.sh',
   't5710-promisor-remote-capability.sh',
+  't5711-promisor-remote-capability-http.sh',
   't5730-protocol-v2-bundle-uri-file.sh',
   't5731-protocol-v2-bundle-uri-git.sh',
   't5732-protocol-v2-bundle-uri-http.sh',
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 463e9e00b0..e5d6f9d1c6 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -999,6 +999,46 @@ test_expect_success "clone and fetch with --filter=auto" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone sends the promisor-remote reply with fetch" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client trace" &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git clone \
+		-c remote.lop.promisor=true \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
+		-c promisor.acceptfromserver=All \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the reply is part of the fetch request
+	sed -n "/clone> command=fetch/,/clone> 0001/p" trace >request &&
+	test_grep "clone> promisor-remote=lop" request &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "fetch by object ID sends the promisor-remote reply" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client trace" &&
+
+	git init client &&
+	git -C client remote add origin "$TRASH_DIRECTORY_URL/server" &&
+	git -C client config remote.lop.promisor true &&
+	git -C client config remote.lop.url "$TRASH_DIRECTORY_URL/lop" &&
+	git -C client config promisor.acceptfromserver All &&
+
+	# Fetching only an object ID skips the "ls-refs" command, so the
+	# reply can only be sent with "fetch"
+	head=$(git -C server rev-parse HEAD) &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch --no-tags \
+		--filter="blob:limit=5k" origin "$head" &&
+	test_grep ! "fetch> command=ls-refs" trace &&
+	test_grep "fetch> promisor-remote=lop" trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
 	git -C server config promisor.advertise true &&
 
diff --git a/t/t5711-promisor-remote-capability-http.sh b/t/t5711-promisor-remote-capability-http.sh
new file mode 100755
index 0000000000..c08cca3e51
--- /dev/null
+++ b/t/t5711-promisor-remote-capability-http.sh
@@ -0,0 +1,126 @@
+#!/bin/sh
+
+test_description='handling of promisor remote advertisement over HTTP'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping promisor remote capabilities tests; Perl not available'
+	test_done
+fi
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+GIT_TEST_MULTI_PACK_INDEX=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
+
+# The setup and helpers below are copied from t5710, except that the
+# server repository is in the HTTP document root.
+
+SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server.git"
+
+check_missing_objects () {
+	git -C "$1" rev-list --objects --all --missing=print > all.txt &&
+	perl -ne 'print if s/^[?]//' all.txt >missing.txt &&
+	test_line_count = "$2" missing.txt &&
+	test "$3" = "$(cat missing.txt)"
+}
+
+initialize_server () {
+	# Repack everything first
+	git -C "$SERVER" -c repack.writebitmaps=false repack -a -d &&
+
+	# Repack without the largest object and create a promisor pack on server
+	git -C "$SERVER" -c repack.writebitmaps=false repack -a -d \
+	    --filter=blob:limit=5k --filter-to="$(pwd)/pack" &&
+	promisor_file=$(ls "$SERVER"/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
+	>"$promisor_file" &&
+
+	# Check objects missing on the server
+	check_missing_objects "$SERVER" 1 "$1"
+}
+
+copy_to_lop () {
+	oid_path="$(test_oid_to_path $1)" &&
+	path="$SERVER/objects/$oid_path" &&
+	path2="lop/objects/$oid_path" &&
+	mkdir -p $(dirname "$path2") &&
+	cp "$path" "$path2"
+}
+
+# On Windows, `pwd` returns a path like 'D:/foo/bar'. Prepend '/' to turn
+# it into '/D:/foo/bar', which is what git expects in file:// URLs on Windows.
+# On Unix, the path already starts with '/', so this is a no-op.
+pwd_path=$(pwd)
+case "$pwd_path" in
+[a-zA-Z]:*) pwd_path="/$pwd_path" ;;
+esac
+
+TRASH_DIRECTORY_URL="file://$pwd_path"
+
+test_expect_success 'setup: create "template" repository' '
+	git init template &&
+	test_commit -C template 1 &&
+	test_commit -C template 2 &&
+	test_commit -C template 3 &&
+	test-tool genrandom foo 10k >template/foo &&
+	git -C template add foo &&
+	git -C template commit -m foo
+'
+
+# A bare repo will act as a server repo with unpacked objects.
+test_expect_success 'setup: create bare "server" repository' '
+	git clone --bare --no-local template "$SERVER" &&
+	mv "$SERVER"/objects/pack/pack-* . &&
+	packfile=$(ls pack-*.pack) &&
+	git -C "$SERVER" unpack-objects --strict <"$packfile"
+'
+
+test_expect_success "setup for testing promisor remote advertisement" '
+	# Create another bare repo called "lop" (for Large Object Promisor)
+	git init --bare lop &&
+
+	# Copy the largest object from server to lop
+	obj="HEAD:foo" &&
+	oid="$(git -C "$SERVER" rev-parse $obj)" &&
+	copy_to_lop "$oid" &&
+
+	initialize_server "$oid" &&
+
+	# Configure lop as promisor remote for server
+	git -C "$SERVER" remote add lop "$TRASH_DIRECTORY_URL/lop" &&
+	git -C "$SERVER" config remote.lop.promisor true &&
+
+	git -C lop config uploadpack.allowFilter true &&
+	git -C lop config uploadpack.allowAnySHA1InWant true &&
+	git -C "$SERVER" config uploadpack.allowFilter true &&
+	git -C "$SERVER" config uploadpack.allowAnySHA1InWant true &&
+	git -C "$SERVER" config promisor.advertise true
+'
+
+# Over HTTP, each request is handled by a separate upload-pack process,
+# so the server knows that the client accepted "lop" only if the reply
+# is sent with the "fetch" request itself.
+test_expect_success "clone over HTTP with an accepted promisor remote" '
+	test_when_finished "rm -rf client trace" &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -c protocol.version=2 clone \
+		-c remote.lop.promisor=true \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
+		-c promisor.acceptfromserver=All \
+		--filter="blob:limit=5k" "$HTTPD_URL/smart/server.git" client &&
+
+	# Check that the reply is part of the fetch request
+	sed -n "/clone> command=fetch/,/clone> 0001/p" trace >request &&
+	test_grep "clone> promisor-remote=lop" request &&
+
+	# Check that the largest object was lazily fetched from lop
+	test_cmp template/foo client/foo &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects "$SERVER" 1 "$oid"
+'
+
+test_done
-- 
2.56.0

