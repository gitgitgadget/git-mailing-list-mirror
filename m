Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122EB2D0629
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932938; cv=none; b=MOA6yNfyhqUiCZbU5fmU8UwPtCH01p0aFIghR8c6GH8xxO8RTAiUWGucRUI7LvTw5nyG4Q1JGUGQL43v5L2niB7ISzW5v486+sfuByi/orVTo3m5klWw3YWQH+Tu5eiRMQmeTobESjj32leL4MCUiFBYkYJG/CEdHcqYk0/8PII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932938; c=relaxed/simple;
	bh=thR0HMopmpzvHjEv9NXAv1SgWSOATjvs04OHaTNGciI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=qQxgOBYndLk4IktcztvaVmOfHJzp3RsXiobci7zC0O5Ev1Xy2B0FFPCeREHR42EDYhLrKD8URVylAHXZ1ckFNU7j8IusGd2PdL7+HLMMTP+HmX5VccH/RpAFQPVyHNtvXNxfzDEF+GAcSNZu2bsCgV+2B2jtX+nUUNlry3IvmUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DMd28tFe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQOZUVNR; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DMd28tFe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQOZUVNR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 341D81D0004A;
	Wed,  9 Sep 2026 01:48:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 09 Sep 2026 01:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788932936;
	 x=1789019336; bh=XK6gER79Z35JW0xpNq0GBP8gvo7ym3sP76xwW9AMDO4=; b=
	DMd28tFeic8Zf7Q5KBi2VR5heIY4k66eXUnzDBh0KE1lUbylJ95FdjLGQj3lvfwo
	QLGnuUE2oz6GFdXjxNWv+4q87CSP/b5uew1rGGkVQ92K7Wd8Ip1brsS4AQYhAhd2
	5YoY+GOuw03pcRRNghuqCFkNW0HQEbsvkgbDDHCAXHO+LE9ROVy2Mg9yE4IEKeYo
	+Kuvwe7JC19c/G8V4cxcR0YQT2B0S82VgOfiOaXdC4YTub75oz9QHpXj+nT6HAw/
	4Izje85ws47xi+WLjI8eOaTFk/mJFQdUlYcCoOEBWbrFuGL6NAlfcwNgZ7l3qa08
	QrC4ASPD2iq9LhNVMQ6VQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788932936; x=
	1789019336; bh=XK6gER79Z35JW0xpNq0GBP8gvo7ym3sP76xwW9AMDO4=; b=V
	QOZUVNRDTrh+Q7b2QkL9WW1WzXo36zTuWWIuTEVbSmgVDkZxnaLOiFkKedrMPnVu
	NCMgLIYet9ythffS+FB+UD4ms5fOM2aveVEV7h45KT6ETbSvjWcFtTnO2SQ3d4Mv
	KK/9uTJJsBRlqheQVpMnjpy4Nr4XAvghFYQdwMinBXJZ7Jf9APxKNnwRV37JPEZY
	Z1Lue+MtFbseOo7WsVMuiv3A6bdsr6tcpDfya3LLIW4G3V3Gkvni+2aoyyaXFfA8
	hWXdZ8Q98qC2wlqMXVxyYa1RJNR0Vkv+Sf1XSLY+Jf1GUhV2dsj25PInamDqrxhu
	Z2q4Zn6uV2yw4FAgk5ekA==
X-ME-Sender: <xms:R_Ogams0GCD4kQWDcu-TI0Kv8N-V-IxKfHmguRFjELAumG1JyQg0Cw>
    <xme:R_Ogaic0OenZ9CHs1nc9m4deNpRoTrxnlnKGRn6TMdUmRJCoD-kH5l6hxveI83DuL
    tJrfEhwBgKhuR_xYcS4BvpuDrZQHaupDKsOv9AhnRqLiEqj_hfBvak>
X-ME-Received: <xmr:R_OgamxMFAYRYvbMeJkJ3wGBNUUrM-ih6ANpZw4BD_gh25EqbhDw6joQdK3phFOkzzEfVw>
X-ME-Proxy-Cause: dmFkZTECyiIy/ikrvz9pXdO6CeWyo2079aXBOnxg0Is5Ppq6BprTahnWUXUzj2nGoqDK+j
    AUTAuCmCeACLAh3T4cpZSl/re7mWkqIkcZ50PgZ3Ydyg2anU3pc7qm/2AOU+73vCiA1b2l
    r2aXJMvXwS0tKeFRDhtsL8klyCTiO+i/AkpCFiG+sIzdbnJEKaLqnDpm0ZOUPOnWrzFdxM
    3mrS8Q36GFB0EnXUuHvTeTTxrYnAFcREgGhmlC6K1DZa3yaZBQfMkjxxgYpowtQLHoWzZT
    +Fw1A3NlpQJSkATZJABCEgVBbRNP27Zrx+aknLXe7AnJAk+rQrF892bOBwk0VTiHwR6UKC
    ZwmQQIjd0Y0PxsDP4BMCAoUgCAHoNgN1Wrc5HhcRMCxBUEeLVwq/glyFZQ7UHU8pqodMfj
    mCXFbbsiEYgqtf5+RQJrbjNfSNM/Sc67Cef6owy61I98fr+7ZgvhIhAC8v/LGgwandV8Td
    pY0VgrHIWflWysFKcbJD1AXk8EwBOIW2ynKhgr5LoHkzGjDyzWVD3HHLB9Nc8kEI62Borj
    4x+E5NUlWtwKqDNCBIxbzImnfX0xUbS/8QFiKL85aFat2lclvgTeWUrTuBGcCPnfdJ4Nxc
    4wcLiscZab+u3m001U63hxz5nW9Jbd5u/AvJ/Jvch1RX4iz1XgocR3CvZRgg
X-ME-Proxy: <xmx:R_OgagGg_cc50hxVDolh_hrxR9-d5yB8xczxBmzw-zXb-pCyk_EhmA>
    <xmx:R_Ogaiw86xCLje6JKi58TmCtM5oXihB7f1LvBLDvxxG9qYiruLG7Lg>
    <xmx:R_Ogapt0XntyBi38CGzv0cvfamgc9D0Q837RWnJEAPhx6ImmixJFIg>
    <xmx:R_Ogan37ydTp9EwCI1C-1_QeijRnTwYQ_U17kpOEfHzMc1KcjUy8iw>
    <xmx:SPOgaqNKlpkiAe8xiODFxDzM10rRAsJWb8vbEd_J9RaD9IfHc_fdOVY5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:48:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25d71918 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:48:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/9] odb: write alternates at creation time
Date: Wed, 09 Sep 2026 07:48:42 +0200
Message-Id: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XOTU7DMBCG4atUXjNoxhO3DSvugViM7YEaaFLZJ
 oCq3B2nIH6WWX7S+Hl9NkVz0mJuNmeTdUoljUMb3dXGhIMMjwoptm0s2i3uieH0XGCMHt5yqgr
 yUjUPUrWAVAhZpTYAajoqbDskjOr7TtA075T1Ib1fWnf3X7u8+icNdQksF4dU6pg/Lp+ZaLn77
 lq3ojsRIPREjthL7wLftrfX6WiW6GT/sExrWNtY0RAt760XCv9Y/mV73K1hubE7dhG986yIP+w
 8z58SrebbnwEAAA==
X-Change-ID: 20260813-pks-odb-write-alternates-at-creation-time-64010deb94a0
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

writing alternates into the object database currently happens via
`odb_source_write_alternate()`. But while that creates the ability to
create alternates at arbitrary points of a source's lifetime, we don't
use that functionality in the first place. Instead, we only ever write
alternates when creating a new repository.

This design is suboptimal due to a couple of reasons:

  - It requires us to have a `write_alternates()` callback, which is
    overblown as we never even write alternates to an object database
    after it has been created.

  - We're about to make alternates an implementation detail of the
    object database's backend in a future patch series, so alternate
    implementations may not even support them.

  - The backend has more flexibility with how exactly alternates are
    configured when it itself is in full control over their setup at the
    time where it creates the object database itself.

This patch series thus refactors how we handle alternates so that we
don't write them ad-hoc anymore. Instead, the series introduces a new
option for `odb_source_create_on_disk()` that makes it handle those
alternates at creation time.

This is part of the bigger goal of moving handling of alternates into
the "files" backend.

This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
with ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
`alternates_db` field, 2026-08-17) merged into it.

Changes in v4:
  - Add documentation for the different functions that play a role in
    creating repositories.
  - Link to v3: https://patch.msgid.link/20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im

Changes in v3:
  - Refactor `init_db()` to not create the reference and object database
    at all anymore. Instead, it's now called `create_repository()` and
    it is responsible for creating the initial repository skeleton,
    only. This allows us to get rid of the flags and overall makes the
    logic more straight-forward by moving the command-specific logic
    into the respective commands.
  - A couple of typo fixes.
  - Link to v2: https://patch.msgid.link/20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im

Changes in v2:
  - Use a lockfile to write "info/alternates" during creation time.
  - Remove useless "strvec.h" include by reordering declarations a bit.
  - Link to v1: https://patch.msgid.link/20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      setup: split up concerns of `init_db()`
      builtin/clone: defer setup of the object database
      builtin/clone: move around `setup_reference()`
      builtin/clone: refactor handling of "--reference{,-if-able}"
      builtin/clone: move setup of alternates for shared local clones
      builtin/clone: move setup of alternates for non-shared local clones
      odb/source: support writing alternates when creating the database
      builtin/clone: write alternates via `odb_create_on_disk()`
      odb/source: remove the ability to write alternates

 builtin/clone.c            | 111 +++++++++++++++++++++++---------------
 builtin/init-db.c          |  32 ++++++++---
 odb.c                      |   9 ----
 odb.h                      |   7 ---
 odb/source-files.c         | 130 ++++++++++++++++++++++++++-------------------
 odb/source-inmemory.c      |   7 ---
 odb/source-loose.c         |   7 ---
 odb/source-packed.c        |   7 ---
 odb/source.h               |  43 +++++----------
 setup.c                    |  61 ++++++++-------------
 setup.h                    |  47 +++++++++++-----
 t/t5604-clone-reference.sh |  25 +++++++++
 12 files changed, 264 insertions(+), 222 deletions(-)

Range-diff versus v3:

 1:  b0e8d52235 !  1:  e6a17864eb setup: split up concerns of `init_db()`
    @@ setup.h: int apply_repository_format(struct repository *repo,
     -	    enum ref_storage_format ref_storage_format,
     -	    const char *initial_branch, int init_shared_repository,
     -	    unsigned int flags);
    ++/*
    ++ * Create the repository by creating the necessary directory structures,
    ++ * setting up the configuration and configuring the repository's format. If
    ++ * `template_dir` is set, copy over templates from that directory. Furthermore,
    ++ * if and only if `reinit_ok` is a non-NULL pointer, then the function may
    ++ * reinitialize a preexisting repository. In that case, the pointer will be set
    ++ * to `1` in case the repo was reinitialized and `0` if it didn't exist yet.
    ++ *
    ++ * Note that this function does not create the reference and object databases.
    ++ */
     +void create_repository(struct repository *repo,
     +		       const char *git_dir,
     +		       const char *real_git_dir,
    @@ setup.h: int apply_repository_format(struct repository *repo,
     +		       enum ref_storage_format ref_storage_format,
     +		       int init_shared_repository,
     +		       int *reinit_ok);
    ++
      void initialize_repository_version(struct repository *repo,
      				   int hash_algo,
      				   enum ref_storage_format ref_storage_format,
      				   int reinit);
    ++
    ++/*
    ++ * Create the reference database for the repository. The repository and its ref
    ++ * storage format must have already been configured properly before calling
    ++ * this function. When set, `initial_branch` overrides the default branch that
    ++ * HEAD will point to.
    ++ */
      void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
    -+void create_object_database(struct repository *repo);
      
    ++/*
    ++ * Create the object database for the repository. The repository must have
    ++ * already been configured properly before calling this function.
    ++ */
    ++void create_object_database(struct repository *repo);
    ++
      /*
       * NOTE NOTE NOTE!!
    +  *
 2:  4fc3a45d2d =  2:  45ae2231ad builtin/clone: defer setup of the object database
 3:  fd875b60b9 =  3:  92f00f1905 builtin/clone: move around `setup_reference()`
 4:  1ca710255b =  4:  b6860d41fb builtin/clone: refactor handling of "--reference{,-if-able}"
 5:  08a3a7a682 =  5:  070558b0b8 builtin/clone: move setup of alternates for shared local clones
 6:  afe84c063b =  6:  8e767a103a builtin/clone: move setup of alternates for non-shared local clones
 7:  8f0d3b13d5 =  7:  39ee1b828d odb/source: support writing alternates when creating the database
 8:  75d1e1e34c !  8:  531152ee93 builtin/clone: write alternates via `odb_create_on_disk()`
    @@ setup.c: static int create_default_files(struct repository *repo,
      	 * Create the "objects" directory in the common directory. This is done
     
      ## setup.h ##
    -@@ setup.h: void initialize_repository_version(struct repository *repo,
    - 				   enum ref_storage_format ref_storage_format,
    - 				   int reinit);
    - void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
    +@@ setup.h: void create_reference_database(struct repository *repo, const char *initial_bran
    + 
    + /*
    +  * Create the object database for the repository. The repository must have
    +- * already been configured properly before calling this function.
    ++ * already been configured properly before calling this function. When set,
    ++ * `alternates` is the list of alternates that should be written into the
    ++ * object database.
    +  */
     -void create_object_database(struct repository *repo);
     +void create_object_database(struct repository *repo, const struct strvec *alternates);
      
 9:  a674c3af3c =  9:  25bd93544e odb/source: remove the ability to write alternates

---
base-commit: afa255aeb620346d56a2c01fb5ae9163513c56d7
change-id: 20260813-pks-odb-write-alternates-at-creation-time-64010deb94a0

