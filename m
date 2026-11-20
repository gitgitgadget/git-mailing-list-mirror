Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193326;
	b=rxNOdi9LSBAAmSfacgXZ6PnOzRiWC48NKmj/b1DjghsV5hkDKfC4+SVekVTvPiJDahR3
	 d1nQQPD1J+PAgXFZ+PU/GzXh2iSZCOY6ALN4QIrT2+2z+GI1spvfUziKkv/WTiSuYvYez
	 HMnIlPNWtXfZM2XHqlc9PjfiCyDrqUOfjpcd6D1vqiQPykZeSOa7RO8SxxUb3xeOAVeyV
	 z0viLI06MwEAl+2xBzGC/s30NSSLKuI1uQa5WQSuRujQqQvDNQf2la0hdVlCTNtA8i1Yl
	 mqTDsXizjS4bnjIMpxzbUqEa+wy4HtA9/7yOz9iZnM4DjQF7qJ4tRNDFCoXd2NZKjlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r15xQVuNDUpZmp5dKc4K3yzlDAo4d7nUQ7CiYHf88g0=;
	b=DtQlsRv38H/54u3oTj5+zhmsThbnweqBwN7U9VFm7vLumtpa8oUZSNJDi+RyRQ9TblYp
	 2dPaB2g+T4c+Oq5ZqdJZ+uIQQiwhNdmQi2+/7PwkyZDuscFpRxCJYIwcF47HLa+sXzg8N
	 Y03cBO8tqNfuTOEpl0HAwuLiPoG+iP1c1YCXHHXmVU/Yv2AubPSabCrYHB21p5lty9lrr
	 LGk1VNuy2EXXAgS2c5QHYWDd6D9E67mpjP94ied4S4ht93l+kEQ1wp3Cvfjk15qlMcFBB
	 6th+DBmyozXhrrrdF6NQJNLo0LP0buPwft8JFqr/tOp/CBGJdfCfyXmhENP058oMmHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SN9ftDPi;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244760A2604
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6244760A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SN9ftDPi
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490d59c3edaso763812f8f.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193325; x=1795798125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r15xQVuNDUpZmp5dKc4K3yzlDAo4d7nUQ7CiYHf88g0=;
        b=SN9ftDPiQkqRBAgi7yRbciWe8dwcxXOdSFKWTVsv0Vt/m3dtviNFkI4v1l2Sr6DHsL
         SfqN38ZeA/iv+6Y3smolheot20E9N9O/joMIRaLYSJ2cTfs1mbzw8njyzxkTFikv1WHQ
         lErwcldWq7a7l8YabmJ3vURKejjx57Ecs++o6Hl2awrxgyldzoWRzeE2CDIfAcuCXspj
         8OrU7vjkE6SVQH/cnNeuCp56IXHfhSIhXS7POjo2th+Ly2kX7z21acEFqmDeNp2x6Lea
         R3o1PCI/KU2qmb4vpNmb2Z2nxudFlFus+X0t2+x/RZqHYEZ2h8jYj70Fb0TZWxVId3r5
         M4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193325; x=1795798125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r15xQVuNDUpZmp5dKc4K3yzlDAo4d7nUQ7CiYHf88g0=;
        b=gtN2dKi26nxEojyh4o6rtil7qp7W/bAdJGR8ns+QGNIKULiBK/3T5mSbMCGJD/uSak
         +BOtGgKUh187zD7KtIfHZtidnUZvPWeyqPGaSzKgCEUaVSHjNBtbCnwGRuYMJ+W5EQJz
         egy7x4NQuflsGj0W51ONBPvVDllbd7pIDFfXFGKPG85ZvgVKYkGd3ZjvzLbSGO/QUydj
         U0El1IquOoX4sb5NZwjF+SRVhqG8CV8x3wbwzbue4iK+dyecH2ij+3pv+rDVaaTsmodi
         jo1kk4jyVQvs7YFqLhkWZqoLVNtloYPR7+f+8ZwnKRF8hoBkj0jSQCdddr/tJyQWNoPb
         cf9Q==
X-Gm-Message-State: APuU4Z+cAS/cucgERlP1xONU0bRXHQH+p1PUvPdbv5v3ktdNlbsNZsBL
	HsIywOfuXyevJ9Uc+ulUxyTK6CcaJpZKvqlPmrP+Ap1bbELo1jk0S+8CBW9zmw==
X-Gm-Gg: AZFdTZeWXL/CV9X67YRbU5frmpoVYEt284npKdcqCTm2Q4nzbw8dc1hk1wFuABzxEuz
	yZw16DaN0c7n5k9/zwzmB0F0d98sIXTUFXeY0PO/splCeii9+xeoG/iWFxiuBHzIRpwgdeYpJs5
	bmbOA3QM4lHO25UqIcJBA2H2RN51LAzi7kFmGMGY9zxjrtKF67p5f+X6pMuJDQNey0DaH7oB1S7
	i11r5CBC27gd8M2Xdtr3c1bTwG1+VKy8ung4HcFzUm4ylZiKQvXhfuEamejeSFzp4itDv4hc7q9
	FBR7D2NJ43yVjZHQ0U/kKpq0VsjNvdUDzuCzH/ODRZP7dsgXdExRJ6tfNdnTnSXUYqRkIQXna2C
	GhikmUlcruujax3qWx+eXADRymINy2ZmZZdX0jEWCZtXyzZnke4HAC3H8o/drKyOmytFShfRIgH
	pHG5PFOUhdauYQzBLFikpu+YJPaxks5c9WUH6bWFeY5gNjHDPRAcy7/79q3P7cYQYLNHt3dVakh
	hqHvATsmlS44QdcTByMc4u2qcHbdNmDibHr1vkGg3Bt5ZNYnVjgAvwXd6N8W1GzOnFDhennMRzd
	RLzsIxlVVzCCDRjiPeGFixvpBg4I/KLrzOUJoa9/wASaywARBPmJKfJ29aHqtKKcUWb+UhvQ0gR
	zegrD7IKwjogcF6Ya+xsJEyvdWEDezhV7tQqf/WFUHf2yHmdD6EvoJl3ClB8yZJcU4Hqi5Re2Mn
	Kod+O9h2SbEc2ifiqois8jglryPOWvS/KjlYrkifQBvNian+dKUgDc/q0JMHm2
X-Received: by 2002:a05:6000:401f:b0:48e:7475:fe7b with SMTP id ffacd0b85a97d-4aa545e305fmr10895570f8f.6.1795193324618;
        Fri, 20 Nov 2026 08:48:44 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm6232752f8f.22.2026.11.20.08.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:43 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 7/8] fetch-pack: ensure fetch sends a promisor-remote reply
Date: Fri, 20 Nov 2026 17:48:20 +0100
Message-ID: <20261120164812.707946-17-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.596.g78bef52d5b.dirty
In-Reply-To: <20261120164812.707946-10-christian.couder@gmail.com>
References: <20261112195858.53788-5-christian.couder@gmail.com>
 <20261120164812.707946-10-christian.couder@gmail.com>
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
`promisor-remote=...` reply is only sent with the `ls-refs` and
`bundle-uri` protocol commands, by get_remote_refs() and
get_remote_bundle_uri() in "connect.c".

The request for the `fetch` protocol command is built by
send_fetch_request() in "fetch-pack.c" which doesn't send that reply.
do_fetch_pack_v2() calls promisor_remote_reply(), but only to mark the
accepted remotes, as e15a6b2f8b (promisor-remote: change
promisor_remote_reply()'s signature, 2026-02-16) assumed that
fetch-pack would not need to send a reply.

With file:// and ssh:// URLs on a Git server, one upload-pack process
handles both `ls-refs` and `fetch`. The acceptance recorded during
`ls-refs` by promisor_remote_receive() in "serve.c" is still there at
`fetch` time, so the clone succeeds. But it fails when each request is
handled on its own, for example with HTTP where different upload-pack
processes are used.

It also fails when only object IDs are fetched, as no `ls-refs`
command is then sent. In these cases, the server doesn't know that the
client accepted a promisor remote, so it doesn't allow promisor
objects to be missing from the pack it sends, and it fails with "could
not fetch <oid> from promisor remote".

Let's fix that by building the list of capabilities for the `fetch`
requests once in do_fetch_pack_v2(), using add_server_options() and
add_promisor_remote_reply(), and by passing that list to
send_fetch_request(). This way the `promisor-remote=...` reply is
always properly sent with the `fetch` requests, and the accepted
remotes are still marked at the same point as before.

The `fetch` requests sent by negotiate_using_fetch() don't ask for a
pack, so they don't need that reply.

Let's also add tests in t5710 to check that the reply is sent with the
`fetch` request, and that fetching only an object ID works. For HTTP,
let's add a new t5711 test script, copying the setup from t5710.

Reported-by: Matt Cote <mcote@nvidia.com>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 fetch-pack.c                               |  18 +--
 t/meson.build                              |   1 +
 t/t5710-promisor-remote-capability.sh      |  40 +++++++
 t/t5711-promisor-remote-capability-http.sh | 126 +++++++++++++++++++++
 4 files changed, 176 insertions(+), 9 deletions(-)
 create mode 100755 t/t5711-promisor-remote-capability-http.sh

diff --git a/fetch-pack.c b/fetch-pack.c
index 176d625936..3d6d3e33a2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1380,16 +1380,15 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain,
 			      int sideband_all, int seen_ack,
-			      struct oidset *negotiation_include_oids)
+			      struct oidset *negotiation_include_oids,
+			      const struct strvec *capabilities)
 {
 	int haves_added;
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
-	struct strvec capabilities = STRVEC_INIT;
 
-	add_server_options(&capabilities, args->server_options);
 	write_command_and_capabilities(&req_buf, "fetch",
-				       &capabilities, NULL);
+				       capabilities, NULL);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -1454,7 +1453,6 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
 		die_errno(_("unable to write request to remote"));
 
-	strvec_clear(&capabilities);
 	strbuf_release(&req_buf);
 	return done_sent;
 }
@@ -1698,12 +1696,12 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
-	const char *promisor_remote_config;
+	struct strvec capabilities = STRVEC_INIT;
 
 	fsck_options_init(&fsck_options, the_repository, FSCK_OPTIONS_MISSING_GITMODULES);
 
-	if (server_feature_v2("promisor-remote", &promisor_remote_config))
-		promisor_remote_reply(promisor_remote_config, NULL);
+	add_server_options(&capabilities, args->server_options);
+	add_promisor_remote_reply(&capabilities);
 
 	if (args->filter_options.choice == LOFC_AUTO) {
 		struct strbuf errbuf = STRBUF_INIT;
@@ -1781,7 +1779,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 					       &haves_to_send, &in_vain,
 					       reader.use_sideband,
 					       seen_ack,
-					       &negotiation_include_oids)) {
+					       &negotiation_include_oids,
+					       &capabilities)) {
 				trace2_region_leave_printf("negotiation_v2", "round",
 							   the_repository, "%d",
 							   negotiation_round);
@@ -1924,6 +1923,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);
+	strvec_clear(&capabilities);
 
 	if (fsck_finish(&fsck_options))
 		die("fsck failed");
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

