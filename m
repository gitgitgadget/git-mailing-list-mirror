Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702608;
	b=ioGvAY2K3PPdsBuYAk6jwN5fRlrJQz6gCbQ+82WzJ6dLL2v7er/Z3kwICvQFOqMBDjPh
	 VYGCj9OPZURIzzsU6AnOz8FMTtfjUw/fCgOQv66WsyyTDdzhCXsRUAYOxImXKrIUxV28s
	 eD508skCCuzpSfU2Ei71qJxW0snzFiwa2of879Ye1uDA59uMxIJbFUAJCkKe0e4np78Mz
	 A8NyKZ97g900ieVEJqg1Wm3CmSdrD4DKL+ZaEd7I8d48+p+8HfCd2eIeDH9SA54CH5QOs
	 SoT735yUtbtXl6NU4ZJUuvbdKUfejOu80CEvVRdLwlVB0uwSfGfMyIPJJEA68ZTsl4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GVP0Deyh5Us1qbEquLg2bOpq+87xRUjTHn802VXxy5k=;
	b=d/qv+2PR36/Zys8WM7d/5jXYRsvNusUM6n9bTciphtbydAyMARRO/14npkZdVRlgRXqD
	 q4C8FZR9/jeJ/iIrjBaXUBMntlQ9606HyFbol/p+KB3NvotBaF/MI6dSryIyx7ASysY0I
	 ARbBewhri4MqCWAPZTRqOmH3vx5pAzhbKN/er9uPWWVLoEMLtJCC0RjgUF06BCiytpbNz
	 Lq49gJHNfmjpY53cLgGp21NQA+YcRPoXGJudR/P05P5ekYI23fMR5WlvLVk+DtKJpbYp7
	 vW+UBMMR6EGzPBAUod3V90fIYxVPvvtscIhlVfzZTXzDfu3PXp2VGPoyovEo/5YkXrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B196ee6l;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0A606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EC0A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B196ee6l
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a358881793so3721271f8f.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 06:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702607; x=1796307407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GVP0Deyh5Us1qbEquLg2bOpq+87xRUjTHn802VXxy5k=;
        b=B196ee6lyyrur5Qq46v47TKoMA3j4tb15vNfL5INmHwi9Nzuf8vsZhoBXrzlRDQPX9
         DS/D7T+YlC60l8FCw+qn/esU+6g9VJNO+oiMo4Jv2pg7vLj7ZnrJk46lCONtuwPn8v0m
         A9QW8y0JpqiClMrzfCQX15Dz9pFzcdAJjf4weoJek+J56OVg5H+V/xiBKb8pXSL2K1ZA
         2lDkc9fE9lo5xOSMv++ha2n3op7pMMtEkA1JxOD0X3UvvemfNrJqhM2C6pDW888+gDAd
         YQtYbRfOFxkDC7FgtM0CVytaVblRD1+VJyIAPaT+W19UA7gTFvqC5l1yeFL5BnOl54Ze
         9z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702607; x=1796307407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GVP0Deyh5Us1qbEquLg2bOpq+87xRUjTHn802VXxy5k=;
        b=NJyvGB8AYPvWtixKcav5YUzLdCIPnN3lePDEsNHKNj4BbAfG6JoJ13v3iF64Y1HxF1
         L2p9M/AmhjTo2Rriu5QUs178RMm/s6/X8mZ0/A/bIo+nUxZaFfwDif20K9iiFIQsMyDx
         7kkrZrADew2bDY0v6ixKm004HkRq19o81zg02oEyoWrpS2z9KryR/EF2UrRtXXqXAII1
         jcEaRl62EhI22nc6OhIJZVdIJrP5kb+6qQPHAuyUsB+YjWqcje7Ced9jyEXrHNzLZyp0
         qzTNUHXY+FCrSgDINsyeKqBZt+DqoGcjeAqhenGCV/Nc1/lsmICZ7kIaBSH90lYnc5Wt
         phdA==
X-Gm-Message-State: APuU4Z9F83/fRaxGrmmvyWsWZSUOuNydk36d31DQSH8A8MpGdyJFP++r
	nlUl8lgQa9Ae815zjAJYpworvRvQSZlwomuVHC8YQQmRuFHGLN1No3tliX/oqw==
X-Gm-Gg: AZFdTZcz+2B+rvoKKa1FlKW3wHRVE6tUupbFxRwDNlIZN9ZyLUF5dqJJRqTbAM8QB9/
	OMRgQsfqfBwEEikGy2fbeM1vUzgGe1AcqfxjY+NnyAbBKfmHuQwaZbDpl6YO6OwM2QnUbGrLv+j
	+H/4UEjQn3zGqtD7K/3IVnOIXUPfiGrKuNpDG0ytFM5/ZNQix4rDyPOSS2CZMFiAQdw81QDyqVB
	tynCaKanx1QFFpGNvh/QlEPzKkwtgE/uCc1bbPb4e22u/4xdgLfn1iD2Nh5FCY5EBaJeH+wWLg5
	ZLDrxtcp49RWWF5ww/wfca1FUpSb1ovqLoNIR32UStGZjTvmZHed3imybYarOPsFGWS3zGvWnct
	2439wlsAnQntvClY2g9k9mPlO+MI291qjynuU/LB7GJ2acbgibKxzfmF2ho7ZHz1rP+37HntGQh
	7epsw5S14FyjL0yF1KjjfK1M6cSMVaj7i2XvsTk2DhTO2/Ty+OcN2/UfRnQPzJmqNSHILSesqgT
	cyTBBuJ6rkV6DO8MRAkqORKBGY5gRfRuj2VN0bGaTt2gSbekS06Us9tIUBgPbRtnFlLwg5QFowF
	F4V/dpW9UoZXuVmZeTHJtsj7Eq/GkZUi+CZP4tyr9jQq/4YOsyiKr8uSeWGavo7XF+ZVVJK/VF5
	J041WWvcarpmD878jbtK+XK7XMltv99wsfQv/PjO6dqNuOCWA0XqcRGHHKwgw74ux1qPGBghpRX
	UFYD/D+ZTmVKrYUdX7SyqN6dFOjtMrCqQ766QogQA=
X-Received: by 2002:a05:6000:470c:b0:4a7:593a:f421 with SMTP id ffacd0b85a97d-4abb73b557amr38978819f8f.47.1795702606454;
        Thu, 26 Nov 2026 06:16:46 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b8e564e39asm10127999f8f.57.2026.11.26.06.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:16:45 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/2] Fix crash without a repository in ls-remote
Date: Thu, 26 Nov 2026 15:16:27 +0100
Message-ID: <20261126141626.914848-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.472.g808159e44e.dirty
In-Reply-To: <20261113000600.202744-2-christian.couder@gmail.com>
References: <20261113000600.202744-2-christian.couder@gmail.com>
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

When `git ls-remote` is run outside a repo, it can crash when trying
to reply to the "promisor-remote" advertisement from a server, if it's
configured to save some information from the server into a repo config
it doesn't have. Instead it should not try to reply at all.

This is a fix for another bug found during the NVIDIA hackathon
following the Gerrit User Summit 2026.

Overview of the patches
=======================

 - Patch 1/2 is new in this v2. It adds a new
   `struct repository *repo` argument to promisor_remote_reply(), and
   makes its callers pass `the_repository` through it, instead of
   using that variable itself. It's a small refactoring to prepare for
   the fix in the next patch, and to prepare a bit for when we won't
   use `the_repository` anymore.

 - Patch 2/2 is the actual fix. It adds checks in
   promisor_remote_reply() to return right away, without replying to
   the server's advertisement, if it isn't passed a real repository.

This series applies cleanly to 'maint'.

But it conflicts trivially with my "cc/fetch-promisor-remote-reply"
series, which replaces both promisor_remote_reply() callers. To help
with this, I can rebase one series on top of the other when that other
series graduates.

Changes compared to v1
======================

Thanks to Junio and Patrick for reviewing v1.

 - This v2 is rebased on top of current 'master' to get the recently
   merged CI fixes (though some macOS jobs still didn't run, see
   below).

 - Patch 1/2 is new (see above). I thought it was cleaner to have the
   mechanical changes to add a new `struct repository *repo` argument
   to promisor_remote_reply() (as suggested by Junio) and to change
   its callers in a preparatory patch.

 - Patch 2/2 has a number of changes:

   - The check for a real repo is now made at the beginning of
     promisor_remote_reply() rather than in filter_promisor_remote()
     to make sure we don't do anything if there is no real repo. And
     this check now has a code comment to explain it.

   - We check for `!repo` too as suggested by Patrick, to make it
     possible for callers to just pass a NULL `repo` when they are not
     in a repository, once the call chains leading to
     promisor_remote_reply() stop using `the_repository`.

   - We also properly set `*accepted_out` to `NULL` in the no real
     repo case.

   - In "promisor-remote.h", we document the new `repo` argument and
     what happens when it's NULL or not a real repository.

   - The commit message is improved, especially by:

     - explaining why it's safe not to reply, quoting
       gitprotocol-v2(5), and

     - moving up the paragraph about `git ls-remote` being the only
       command that can run outside a repo and still process the
       "promisor-remote" capability.

CI tests
========

The osx-meson (macos-15) and osx-clang (macos-15) jobs never ran at
all as no runners were available. Otherwise all the test jobs
succeeded, see:

https://github.com/chriscool/git/actions/runs/45808010154

Christian Couder (2):
  promisor-remote: pass a repository to promisor_remote_reply()
  promisor-remote: fix crash without a repository

 connect.c                             |  2 +-
 fetch-pack.c                          |  2 +-
 promisor-remote.c                     | 17 +++++++++++++--
 promisor-remote.h                     | 16 +++++++++-----
 t/t5710-promisor-remote-capability.sh | 31 +++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 9 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  04e4ff85eb promisor-remote: pass a repository to promisor_remote_reply()
1:  d599b50dce ! 2:  72be57dd95 promisor-remote: fix crash without a repository
    @@ Commit message
         since 7a56394fc6 (promisor-remote: auto-configure unknown remotes,
         2026-05-27) for the auto-creation case.
     
    -    Let's fix that by checking if `repo->gitdir` is NULL at the beginning
    -    of filter_promisor_remote() and returning from it right away in that
    -    case. It doesn't make sense to further process the promisor remote
    -    advertisement as `git ls-remote` currently has no use for promisor
    -    remotes anyway.
    -
         Note that `git ls-remote` seems to be the only command that can run
         outside a repo and still process the "promisor-remote" capability
         advertised by the server, as sending the `ls-refs` protocol v2
         command makes it call send_capabilities(), which processes that
         advertisement.
     
    -    Let's also add tests in t5710 for both cases where a crash happened.
    +    Let's fix that by checking, at the beginning of
    +    promisor_remote_reply(), if the repository it is passed is NULL or
    +    has its `gitdir` member set to NULL, and by returning right away
    +    without accepting any promisor remote in that case.
    +
    +    It doesn't make sense to further process the promisor remote
    +    advertisement there, as `git ls-remote` currently has no use for
    +    promisor remotes anyway. And not replying is fine, as
    +    gitprotocol-v2(5) says that if the client doesn't want to use any
    +    promisor remote the server advertised, it shouldn't advertise the
    +    "promisor-remote" capability at all in its reply.
    +
    +    Checking for a NULL repository isn't needed yet, as all the callers
    +    currently pass `the_repository`, but it will make it possible for
    +    callers to just pass NULL when they are not in a repository, once
    +    the call chains leading to promisor_remote_reply() stop using
    +    `the_repository`. This would avoid having to check whether the
    +    repository passed is a real one.
     
    +    While at it, let's document the behavior when `repo` is NULL or not
    +    a real repository in "promisor-remote.h", and let's add tests in
    +    t5710 for both cases where a crash happened.
    +
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## promisor-remote.c ##
    -@@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
    - 	struct store_info *store_info = NULL;
    - 	struct string_list_item *item;
    - 	bool reload_config = false;
    --	enum accept_promisor accept = accept_from_server(repo);
    -+	enum accept_promisor accept;
    - 	struct string_list accept_urls = STRING_LIST_INIT_DUP;
    +@@ promisor-remote.c: void promisor_remote_reply(struct repository *repo,
    + {
    + 	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
      
    -+	if (!repo->gitdir)
    ++	/*
    ++	 * We can be called outside a repository, for example by
    ++	 * "git ls-remote", which has no use for promisor remotes.
    ++	 * Not replying is fine then (see gitprotocol-v2(5)).
    ++	 */
    ++	if (!repo || !repo->gitdir) {
    ++		if (accepted_out)
    ++			*accepted_out = NULL;
     +		return;
    ++	}
     +
    -+	accept = accept_from_server(repo);
    -+
    - 	/* Load and validate the acceptFromServerUrl config */
    - 	load_accept_from_server_url(repo, &accept_urls);
    + 	filter_promisor_remote(repo, &accepted_remotes, info);
      
    + 	if (accepted_out) {
    +
    + ## promisor-remote.h ##
    +@@ promisor-remote.h: char *promisor_remote_info(struct repository *repo);
    + /*
    +  * Prepare a reply to a "promisor-remote" advertisement from a server.
    +  * Check the value of "promisor.acceptfromserver" and maybe the
    +- * configured promisor remotes, if any, to prepare the reply. If the
    +- * `accepted_out` argument is not NULL, it is set to either NULL or to
    +- * the names of the accepted promisor remotes separated by ';' if
    +- * any. See gitprotocol-v2(5).
    ++ * configured promisor remotes, if any, to prepare the reply.
    ++ *
    ++ * If the `accepted_out` argument is not NULL, it is set to either
    ++ * NULL or to the names of the accepted promisor remotes separated by
    ++ * ';' if any. See gitprotocol-v2(5).
    ++ *
    ++ * `repo` may be NULL, or not a real repository, and in that case
    ++ * nothing is accepted and `*accepted_out` is set to NULL.
    +  */
    + void promisor_remote_reply(struct repository *repo,
    + 			   const char *info,
     
      ## t/t5710-promisor-remote-capability.sh ##
     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with invalid promisor.acceptFromServerUrl" '

base-commit: acba8bf9753134d9bde89f94369f775838a8c5fe
-- 
2.56.0

