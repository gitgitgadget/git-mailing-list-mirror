Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193318;
	b=NJS90xGdxGgq2/JaKfcombep9Fc+u2WfMHJYzKfXPqpvYa6iQ6l6JpW4MHqfMCxL6hQR
	 X1wmGZxI/F2zUcHoILF90glyUHS2UiWwCnYpiyOPvRBN4ZIWPl5kB/0CKEdESCmtmwJp4
	 ahqCjLNHa1s9CPWzUq+bpo2Un/jsFS5Ua2a5nVOwaGCdauRUX8xUo/LD7tlSHyudaM0/G
	 a4HP4EMfQTA15jynTinyLZQnu33pIF2bIWK7xqVdrIs55x5u37xOcuOYoxSgKpHSt6vOX
	 B3Nbsh40jo/LfzcVSb4B+s9eFCPWU7aDxz2cqlQb7O2x5/5msRxHPq5ZPJuinN8bcqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6mNJ5anPwmCh9NcJlzI6lb6q/uojgMmMnuWvP2T2hbQ=;
	b=LTvMEiIaT87y90FKuhdzXsdE3vg115K2kpQhDPUsxZSlIDfK1HOPDfl9AogurmHXLn01
	 Lg6cs+qAMRZxKNBLNr+3rlsvS3QTtpB+YKlUdGmAYqnMnRrc5ML4zyw6C+Fp4s5HK/1vE
	 RgqCI7FdgFx3z+5X7qJ07roTbmT4oDyGbN785VKB+fZgOYMEsUFRZ43Mk0LE8dAW4E139
	 pve88KBwWY34hAbiWCIljBJEPC+/pmJjw3pIwcbQk9IJZdKcD/6h8mYXMFmjWGEkkZASm
	 2/xoLbfPm6aCZgK14M7pK4j/nDVnSbawywX6ZsJ4509vpXHHwb8P04poke5wmYZt/PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x8JcFM4I;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF7606A32C
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5BF7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x8JcFM4I
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb606491faso6135115e9.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193316; x=1795798116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mNJ5anPwmCh9NcJlzI6lb6q/uojgMmMnuWvP2T2hbQ=;
        b=x8JcFM4ICdrz5w4ljImHqlwYfPjsFDHutzUalGi4q+Joycji+PTf9rWeY9himjrmlG
         nyUkH77ZovjJLMEmd5hvJPeKzrYMuTQ/dXNnNvQQKMmJovWYzv19MqPH9SOkuBSCtu/F
         O48dYlz9i5kedtoGcRYqqSB+Y1V3sT41kGPjs2fqOhg5DeC1x5dygc0pzdPWXv5NlBs6
         Krw6fZASz8oqyBYpCwUQd2iZkEr6a8TR3tjcENOzLMTGlNq+VuOBrWeMSGbLMrOnIXPf
         i7rmgzyOluE8lgLx26rKZ3tuvoL8tcY5pxMFmjcCTl8jvPxtfuPod2TGXpzRbRC/slSb
         lqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193316; x=1795798116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mNJ5anPwmCh9NcJlzI6lb6q/uojgMmMnuWvP2T2hbQ=;
        b=OQ2dgwb5SPXxchtXORPRRReWxu0AqTzIozQ3vEXif10U5lt3GhUTrsMmQ6E/RPBHqS
         6lTQLwvO1RCbteovaH4QveClVEIS90MprbjR4eua9g7VlTW2vRKltr4wy0lG7LQGs5wd
         JqfmlzHnYgsYxb7cXRRuGDWZvqjnoSgcr5lFGVmhuhOisUAMmouqDmPMPpjE7T5D+maS
         eVUVnNRY8TjK9l/PzzguPf4H5HCGAf5qLP6jQA78XOSpt2gQ8Br8wBHFLp4opIVEin8P
         sw+Iqc1/PPkSwNK8AXboi6GVB/NIZIpLEB9w46p9CU/n0ImIl0cPAa9U1hTEjcDp4y44
         LcBQ==
X-Gm-Message-State: APuU4Z/9xqBsN8hidp2HtIW2SK8HiSKC21ZV/Vpa9CGMWE2zc8VLGNgL
	jfsA8/vaC/NjVVgEi0HshFfVk1FQn6nYVUoIZNx8BZDLy1oW/71TMAxV8LiEJA==
X-Gm-Gg: AYBFou3khL39Ji6JyCX1y0n4jHV6H9gVEioG0h50iv8wqo1W6qs7UIhSdMI/p7yvB0P
	x9Pgm1tVcvG/BWxxxbFMifFWzLp9cHKDs+fIetV2JaEfQMAzWO3L8v0gEtjQBiM0u/qEHsTGOMl
	i+p8YmAo7RjE3ZjePyqjr6dlWFmr9WeS3EQDwC7UJJvIqeJoN86rxfCkKvB00KOfQiIqDapZbN0
	UJGMXq1P2b327hgmbq3DD3Cn+nhL6SGIUy0IIq4lYkGiMcriLHPjRozUxfk1MMhNn52ehMJ6rIF
	sYj15SbygGHAb8NPJI8+8hifMAFzssyUW1DysZa5tMVJ1F7VgZ9fImSQay5xBGqnhrFvAZ4YjXQ
	VUsLo4+Eqi8G7ztex4KqcIbcLJIs9Si7A7S68ZnQ3WRLa7GThcFc3U0+SeO/hmqAZ8Ny1PMBDcC
	0hsjhzMoJWQXaC2asK9wn6qE75AxfnrHA2MpqVpTaIJhvqZVieXguxxfwaCCIy72kQKbEXhOqec
	1+ApFWgVW7Gyk2qjtIlKdlVwTM2dhXyOc5e6idiRRgLR/swKniY/tBHy5TvpsC0vFBJLkRBtV8b
	mO04EROfBL9X0tZpIFmwjZhn68Rp3ED4hBrcSVqiMbqVPAQNKqYHtQqMmGzYzkAhfuUn+RhBR6L
	wPWh/BznBrEi6Uo5uIgyXAtMtTCEiNmW3RmmWKkVFn5nYIHvcbPjmRonO5cu39gSWDFD74rXAsN
	lDTdCt24s/oXXBizUisZ3EkuhHBy/080oExTBgUqYTFst5Dg6DHMMYimAFDqn4
X-Received: by 2002:a05:600c:4e87:b0:4a3:59c9:a758 with SMTP id 5b1f17b1804b1-4bb88922c81mr84294215e9.32.1795193315587;
        Fri, 20 Nov 2026 08:48:35 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm6232752f8f.22.2026.11.20.08.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:34 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/8] Fix promisor-remote reply missing from fetch
Date: Fri, 20 Nov 2026 17:48:13 +0100
Message-ID: <20261120164812.707946-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.596.g78bef52d5b.dirty
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

This started as a small series to fix a brown paper bag bug in the
"promisor-remote" protocol v2 capability found by Matt Cote during the
NVIDIA hackathon following the Gerrit User Summit 2026.

But with this version 2, it has become more of a refactoring of the
code that clients use to write protocol v2 capabilities. That's
because there are three different places doing that in "connect.c":

  - send_capabilities() used for `bundle-uri`,
  - get_remote_refs() (using send_capabilities() and its own loop) used
    for `ls-refs`,
  - write_command_and_capabilities() used for `fetch` and `object-info`.

So a large part of this version 2 series refactors this, and now only
write_command_and_capabilities() does it.

The bug, which is addressed in the last two patches of the series, is
that the client doesn't send a "promisor-remote=..." reply with the
`fetch` protocol commands. It does send such a reply with the
`ls-refs` and `bundle-uri` protocol commands. So this works by luck
with a Git server over file:// or ssh://, as the same `upload-pack`
process handles all the requests and remembers the reply from
`ls-refs`.

But it doesn't work with servers that handle each request on its own,
like Git over HTTP. (This is also how it was found with a JGit/Gerrit
setup during the hackathon.) It also doesn't work when only object IDs
are fetched, as no `ls-refs` is sent then.

In these cases, the server doesn't know that the client accepted a
promisor remote, so it doesn't allow the objects available on the
accepted promisor remotes to be missing from the pack, and fails with
"could not fetch <oid> from promisor remote".

This has been the case since the capability was introduced in v2.49,
so it would be nice to have the fix in maint too. The series still
applies cleanly on top of maint (v2.56.1) and the tests pass there. As
the wire changes in the first part of the series are small (see
below), I hope the whole series can be considered for maint.

Other related issues were found during the NVIDIA hackathon, but this
one is the most annoying. The others will be addressed in separate
series.

Overview of the patches
=======================

  - Patches 1/8 to 6/8 make write_command_and_capabilities() the only
    function that writes protocol v2 capabilities. That function
    becomes more generic, while helper functions are added for callers
    to prepare capabilities before passing them to that function.

    There are a few wire changes in those mostly refactoring patches,
    to unify the behavior when sending different requests:

    - patch 2/8 sends "session-id" with `ls-refs` and `bundle-uri`
      requests (only when `transfer.advertiseSID` is set),

    - patch 4/8 changes how failing to write `ls-refs` and
      `bundle-uri` requests is reported, as we now die with "unable to
      write request to remote", like for `fetch` and `object-info`
      requests, instead of with "packet write with format failed" (or
      silently from SIGPIPE on EPIPE),

    - patches 5/8 and 6/8 change the order of the capability lines,
      and "command=bundle-uri" now comes first,

    - patches 5/8 and 6/8 also stop sending a trailing "\n" after
      "command=ls-refs" and "command=bundle-uri".

  - Patch 7/8 ("fetch-pack: ensure fetch sends a promisor-remote
    reply") is the actual fix, with new tests in t5710, and in a new
    t5711 test script for HTTP.

  - Patch 8/8 ("doc: gitprotocol-v2: send the promisor-remote reply
    with fetch") documents that the client should send the reply with
    `fetch` requests asking for a pack.

Changes compared to v1
======================

Thanks to Junio for reviewing v1. As he suggested, callers now build
the list of capabilities they want to send and pass it to
write_command_and_capabilities(), instead of passing a specific
promisor-remote reply argument.

  - Patches 1/8 to 6/8 are new. They replace patch 1/3 in v1 (which
    only added a new `const char *promisor_remote_reply` argument to
    write_command_and_capabilities() so that this function could send
    a promisor-remote reply).

  - Patch 7/8 now uses a new add_promisor_remote_reply() helper
    function introduced by previous patches to prepare the
    "promisor-remote" capability reply, and then always writes it with
    the improved write_command_and_capabilities() when sending a
    `fetch` request. The added tests are the same as in v1.

  - Patch 8/8 now documents that the reply should be sent with each
    `fetch` request asking for a pack (so not with negotiation-only
    requests), and mentions `bundle-uri` along with `ls-refs`.

CI tests
========

Some failed, others didn't even start, see:

https://github.com/chriscool/git/actions/runs/44747276981

But all these issues look unrelated to this series.

Range-diff compared to v1
=========================

1:  523fec7fc3 < -:  ---------- connect: let write_command_and_capabilities() send a promisor-remote reply
-:  ---------- > 1:  0b8a469426 connect: pass capability lines to write_command_and_capabilities()
-:  ---------- > 2:  b5814012e7 connect: send session-id with ls-refs and bundle-uri
-:  ---------- > 3:  9ae83a24d4 connect: pass a reader to write_command_and_capabilities()
-:  ---------- > 4:  b9393478d9 connect: buffer the ls-refs and bundle-uri requests
-:  ---------- > 5:  c7bb7aea1e connect: use write_command_and_capabilities() in get_remote_refs()
-:  ---------- > 6:  6f8b694584 connect: use write_command_and_capabilities() in get_remote_bundle_uri()
2:  8e2294ec62 ! 7:  d3ab977624 fetch-pack: ensure fetch sends a promisor-remote reply
    @@ Commit message
         fetch-pack: ensure fetch sends a promisor-remote reply
     
         In protocol v2, when the client accepts promisor remotes, the
    -    `promisor-remote=...` reply is only written by send_capabilities(),
    -    which is used to send the `ls-refs` and `bundle-uri` protocol commands.
    +    `promisor-remote=...` reply is only sent with the `ls-refs` and
    +    `bundle-uri` protocol commands, by get_remote_refs() and
    +    get_remote_bundle_uri() in "connect.c".
     
         The request for the `fetch` protocol command is built by
    -    write_command_and_capabilities() called by send_fetch_request() in
    -    "fetch-pack.c" which doesn't send that reply. do_fetch_pack_v2() calls
    -    promisor_remote_reply(), but only to mark the accepted remotes, as
    -    e15a6b2f8b (promisor-remote: change promisor_remote_reply()'s
    -    signature, 2026-02-16) assumed that fetch-pack would not need to send
    -    a reply.
    +    send_fetch_request() in "fetch-pack.c" which doesn't send that reply.
    +    do_fetch_pack_v2() calls promisor_remote_reply(), but only to mark the
    +    accepted remotes, as e15a6b2f8b (promisor-remote: change
    +    promisor_remote_reply()'s signature, 2026-02-16) assumed that
    +    fetch-pack would not need to send a reply.
     
         With file:// and ssh:// URLs on a Git server, one upload-pack process
         handles both `ls-refs` and `fetch`. The acceptance recorded during
         `ls-refs` by promisor_remote_receive() in "serve.c" is still there at
         `fetch` time, so the clone succeeds. But it fails when each request is
         handled on its own, for example with HTTP where different upload-pack
    -    processes are used, or with other server implementations like JGit.
    +    processes are used.
     
         It also fails when only object IDs are fetched, as no `ls-refs`
         command is then sent. In these cases, the server doesn't know that the
    @@ Commit message
         objects to be missing from the pack it sends, and it fails with "could
         not fetch <oid> from promisor remote".
     
    -    Let's fix that by always properly sending the `promisor-remote=...`
    -    reply when sending a `fetch` request from do_fetch_pack_v2().
    +    Let's fix that by building the list of capabilities for the `fetch`
    +    requests once in do_fetch_pack_v2(), using add_server_options() and
    +    add_promisor_remote_reply(), and by passing that list to
    +    send_fetch_request(). This way the `promisor-remote=...` reply is
    +    always properly sent with the `fetch` requests, and the accepted
    +    remotes are still marked at the same point as before.
     
         The `fetch` requests sent by negotiate_using_fetch() don't ask for a
         pack, so they don't need that reply.
    @@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator,
      			      int sideband_all, int seen_ack,
     -			      struct oidset *negotiation_include_oids)
     +			      struct oidset *negotiation_include_oids,
    -+			      const char *promisor_remote_reply)
    ++			      const struct strvec *capabilities)
      {
      	int haves_added;
      	int done_sent = 0;
      	struct strbuf req_buf = STRBUF_INIT;
    +-	struct strvec capabilities = STRVEC_INIT;
      
    +-	add_server_options(&capabilities, args->server_options);
      	write_command_and_capabilities(&req_buf, "fetch",
    --				       args->server_options, NULL);
    -+				       args->server_options,
    -+				       promisor_remote_reply);
    +-				       &capabilities, NULL);
    ++				       capabilities, NULL);
      
      	if (args->use_thin_pack)
      		packet_buf_write(&req_buf, "thin-pack");
    +@@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
    + 	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
    + 		die_errno(_("unable to write request to remote"));
    + 
    +-	strvec_clear(&capabilities);
    + 	strbuf_release(&req_buf);
    + 	return done_sent;
    + }
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    + 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
      	int i;
      	struct strvec index_pack_args = STRVEC_INIT;
    - 	const char *promisor_remote_config;
    -+	char *accepted = NULL;
    +-	const char *promisor_remote_config;
    ++	struct strvec capabilities = STRVEC_INIT;
      
      	fsck_options_init(&fsck_options, the_repository, FSCK_OPTIONS_MISSING_GITMODULES);
      
    - 	if (server_feature_v2("promisor-remote", &promisor_remote_config))
    +-	if (server_feature_v2("promisor-remote", &promisor_remote_config))
     -		promisor_remote_reply(promisor_remote_config, NULL);
    -+		promisor_remote_reply(promisor_remote_config, &accepted);
    ++	add_server_options(&capabilities, args->server_options);
    ++	add_promisor_remote_reply(&capabilities);
      
      	if (args->filter_options.choice == LOFC_AUTO) {
      		struct strbuf errbuf = STRBUF_INIT;
    @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
      					       seen_ack,
     -					       &negotiation_include_oids)) {
     +					       &negotiation_include_oids,
    -+					       accepted)) {
    ++					       &capabilities)) {
      				trace2_region_leave_printf("negotiation_v2", "round",
      							   the_repository, "%d",
      							   negotiation_round);
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    - 	if (negotiator)
    - 		negotiator->release(negotiator);
      
    -+	free(accepted);
    - 	fsck_options_clear(&fsck_options);
    - 	oidset_clear(&common);
    - 	oidset_clear(&negotiation_include_oids);
    + 	string_list_clear(&packfile_uris, 0);
    + 	strvec_clear(&index_pack_args);
    ++	strvec_clear(&capabilities);
    + 
    + 	if (fsck_finish(&fsck_options))
    + 		die("fsck failed");
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
3:  4103b0f449 ! 8:  40f7866ade doc: gitprotocol-v2: send the promisor-remote reply with fetch
    @@ Commit message
         Until a previous commit, a client sent its `promisor-remote=...` reply
         only with the `ls-refs` and `bundle-uri` protocol commands.
     
    -    Let's clearly document that the client should send that reply with the
    -    `fetch` command request too.
    +    Let's clearly document that the client should send that reply with each
    +    `fetch` command request asking for a pack too, as protocol v2 is
    +    stateless.
    +
    +    The `fetch` requests sent only for negotiation, like with `git fetch
    +    --negotiate-only`, don't ask for a pack, so they don't need that reply.
     
         Reported-by: Matt Cote <mcote@nvidia.com>
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
    @@ Documentation/gitprotocol-v2.adoc: In this case, or if the client doesn't want t
      "promisor-remote" capability at all in its reply.
      
     +As protocol v2 is stateless (see the "Capabilities" section above),
    -+the client should send this reply with the `fetch` command request,
    -+even if it has already sent it with an earlier command request, like
    -+`ls-refs`. Note that when only some object IDs are fetched, the client
    -+might not send any `ls-refs` command request at all.
    ++the client should send this reply with each `fetch` command request
    ++asking for a pack, even if it has already sent it with an earlier
    ++command request, like `ls-refs` or `bundle-uri`. Note that when only
    ++some object IDs are fetched, the client might not send any `ls-refs`
    ++command request at all.
     +
      On the server side, the "promisor.advertise" and "promisor.sendFields"
      configuration options can be used to control what it advertises. On

Christian Couder (8):
  connect: pass capability lines to write_command_and_capabilities()
  connect: send session-id with ls-refs and bundle-uri
  connect: pass a reader to write_command_and_capabilities()
  connect: buffer the ls-refs and bundle-uri requests
  connect: use write_command_and_capabilities() in get_remote_refs()
  connect: use write_command_and_capabilities() in
    get_remote_bundle_uri()
  fetch-pack: ensure fetch sends a promisor-remote reply
  doc: gitprotocol-v2: send the promisor-remote reply with fetch

 Documentation/gitprotocol-v2.adoc          |   7 ++
 connect.c                                  | 128 ++++++++++++---------
 connect.h                                  |  30 ++++-
 fetch-object-info.c                        |   7 +-
 fetch-pack.c                               |  23 ++--
 t/meson.build                              |   1 +
 t/t5705-session-id-in-capabilities.sh      |  26 +++++
 t/t5710-promisor-remote-capability.sh      |  40 +++++++
 t/t5711-promisor-remote-capability-http.sh | 126 ++++++++++++++++++++
 9 files changed, 322 insertions(+), 66 deletions(-)
 create mode 100755 t/t5711-promisor-remote-capability-http.sh


base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
-- 
2.56.0

