Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E513774D
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756589013; cv=none; b=S2b/sJuHo0u08wCzyC4pXEWNsSe6h2P4QclsSKP1ezm8+rYUFcsEec0ctAKsYf9YqHQo8GCFVJxjUTTgve3XvTjFN/3g0Qp5AYZoAMTP3YOR4wW5oLguLhJEXf/CaHRtJfbDgVB9jbVqCq7C3iXOp7r/owN0fGPRer8Hexdald8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756589013; c=relaxed/simple;
	bh=cfIHQkW42hbL+YquUSxjazwJv9eIFXD7H7MzE1ZL1SY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kR7XfYznkTsGurEUkcPeBNL9GwjLtWqO8shCESwPDgafFN9rlZYc5RbNAg2JXWBgElyAlgD+ToGwEPBnVog3ZpogK5W8oB+Oum5i+cQX6HIxUfqmpzuYY+SxT1i+epOACWEOsJ9Z0feTQdII1+z9JhYZ9Y6G2ACOBTaRMX7Qedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L59A4Tqb; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L59A4Tqb"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b30f73ca43so13973681cf.3
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756589010; x=1757193810; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5R9qK7o/lAPezkrK6tWt/6PQtOuwLj0RXySupD86K0I=;
        b=L59A4TqbBYhi7k4Z1jRhzAW8H9ilAnfFD3oxI7qhDXrY184+oFZjL8FmEEdNLGcRWJ
         KTfI31ggKU99QSFrDMmWC984Dn0PEQ9NX5QWHUqEv5EkOWBDfl/XGQ48mJ/NRkzOV2ja
         XmevoTuHYkX9spog3Rh9codNQNv9PS0v1DoOJwav7FbJ2qenCoPwk+G3okRBCd4lKYEW
         sJ3wyYptIbejGod30rddjWma1BU5VR56QdQDGJu0I2Zo6J1akkFC/3vZAE/+27V0c8y9
         fYq628kP2XCcpbT0ZD2Iij9H2m7HgOrrpl0b/ZzZfskXQxqaRpwUFdLzZ3BGn21my4CT
         QSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756589010; x=1757193810;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R9qK7o/lAPezkrK6tWt/6PQtOuwLj0RXySupD86K0I=;
        b=WmdSFNbD1Sl81nwa4DisZl/AHDbvvorH1GMR/st01JmqwXypjhSRwdxnpQdsOats2R
         XgXZSH7VjM9ogNWqIWWVhmF+HFSovUbQRYFCRoMEVkbbp/7w5G/7QdP8mGNUoOsNX/Ef
         oCFM1ZFARmYumCP6QCeXo6Id7KdePtvcOH/RyxLkINsO1kZzOofpcJ9AiL2hLeZoH6h3
         SXvbAwljaLEPd/RCj5ooa61nJVcaTZdEupqME97SYlZx+UtLzve1UKL3ggjlbS7U7yEU
         uMFoA2G9fyoAHwKO0TPpYAQRnm+c9RYThUlS4XDAwcq/dhwj8SyKwhbYZM0zMsuIgSQk
         QEBw==
X-Gm-Message-State: AOJu0Yz2QPzkf7KhQIkQcW+kBzZBTG93pb69Icd64F6LolQbxpDXCxF2
	Iy2B+rcoeTEK67rRPGZtU1h5TxTRXe2cCaTmJ8jLQN3HgyleQWQeW/8P6ykX6XFG
X-Gm-Gg: ASbGnct7E86vaxf1mD41gB9h23YlIsnMIvf32hKxyNEuAyLxdhcUduFB+BaasPCnEIb
	su1V34JqzKvzSfCEIfsXZp8reUVVaQIKN6DkV/Dp9cMJQgdoGv5JAf8fAwE7ndI6Bf9dMdm2D8c
	339zDZgwQwAAUaTR4Rugaz08ZbV4O3S2Tf8H4xW0cprRexNTHXXZUgdBDiqZ6iEY3L3PZ+RdNgv
	FcWGK4+80T0EplyCWsckRxrdYsf3nCwC6+f72CgI/NDthqkZReob385SKGecs2hz1AmwYpa5yuK
	tDpP5TzFKtjf+aOU1Rl6e3L2dVyq/ayPvpqy6qD+3LyjwfHxf6fYLJY02V8zC5CKMzTHtVZbgpM
	Fs++quSznCuYF1ah3moHvV1cjTJpqvvVngtM1bfm9gJqv85c=
X-Google-Smtp-Source: AGHT+IFDu97ZQzTQaYYkeniIgGrRvl0WBl6sk1T1tHzl+WsXMGj9tltq/7lIO3RypU4AhbR+KY5KNw==
X-Received: by 2002:a05:622a:8b:b0:4b2:d607:16c8 with SMTP id d75a77b69052e-4b31d89da2amr37217851cf.37.1756589009901;
        Sat, 30 Aug 2025 14:23:29 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.103.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b54cc37sm35657871cf.12.2025.08.30.14.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 14:23:29 -0700 (PDT)
Message-Id: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 30 Aug 2025 21:23:21 +0000
Subject: [PATCH v2 0/6] midx-write: fix segfault and do several cleanups
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
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Derrick Stolee <stolee@gmail.com>

I was motivated to start looking closely at midx-write.c due to multiple
users reporting Git crashes in their background maintenance, specifically
during git multi-pack-index repack calls. I was eventually able to reproduce
it in git multi-pack-index expire as well.

Patch 1 is the only change we need to fix this bug. It includes a test case
that will fail under --stress with SANITIZE=address. It requires creating
many packfiles (50 was not enough, but 100 is enough). As far as I can tell,
this bug has existed since Git 2.47.0 in October 2024, but I started hearing
reports of this from users in July 2025 (and took a while to get a
dump/repro).

The remaining patches are cleanups based on my careful rereading of
midx-write.c. There are some issues about error handling that needed some
cleanup as well as a removal of the DISABLE_SIGN_COMPARE_WARNINGS macro.


Updates in V2
=============

 * A stale comment to an unsubmitted version of the test is removed.
 * More cases needing open_pack_index() are patched.
 * Typos fixed.
 * A new patch assumes error and sets result to zero only on the few
   successful paths.

Thanks, -Stolee

Derrick Stolee (6):
  midx-write: only load initialized packs
  midx-write: put failing response value back
  midx-write: use cleanup when incremental midx fails
  midx-write: use uint32_t for preferred_pack_idx
  midx-write: reenable signed comparison errors
  midx-write: simplify error cases

 midx-write.c                | 134 +++++++++++++++++-------------------
 t/t5319-multi-pack-index.sh |  22 +++++-
 2 files changed, 86 insertions(+), 70 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1965%2Fderrickstolee%2Fmidx-write-cleanup-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1965/derrickstolee/midx-write-cleanup-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1965

Range-diff vs v1:

 1:  4a4b35c694 ! 1:  e02a444315 midx-write: only load initialized packs
     @@ Commit message
          Add a new test that breaks under --stress when compiled with
          SANITIZE=address. The chosen number of 100 packfiles was selected to get
          the --stress output to fail about 50% of the time, while 50 packfiles
     -    could not get a failure in most --stress runs. This test has a very
     -    minor check at the end confirming only one packfile remaining. The
     -    failing nature of this test actually relies on auto-GC cleaning up some
     -    packfiles during the creation of the commits, as tests setting gc.auto
     -    to zero make the packfile count match the number of added commits but
     -    also avoids hitting the memory issue.
     +    could not get a failure in most --stress runs.
      
          The test case is marked as EXPENSIVE not only because of the number of
          packfiles it creates, but because some CI environments were reporting
     @@ Commit message
              #4 0x562d5d46fff6 in cmd_multi_pack_index builtin/multi-pack-index.c:305
              ...
      
     -    This failure stack trace is disconnected from the real fix because it
     -    the bad pointers are accessed later when closing the packfiles from the
     -    context.
     +    This failure stack trace is disconnected from the real fix because the bad
     +    pointers are accessed later when closing the packfiles from the context.
      
          There are a few different aspects to this fix that are worth noting:
      
     @@ midx-write.c: static int fill_packs_from_midx(struct write_midx_context *ctx,
      -				if (open_pack_index(m->packs[i]))
      -					die(_("could not open index for %s"),
      -					    m->packs[i]->pack_name);
     +-			}
      +			if (prepare_midx_pack(ctx->repo, m,
     -+					      m->num_packs_in_base + i)) {
     -+				error(_("could not load pack"));
     -+				return 1;
     - 			}
     ++					      m->num_packs_in_base + i))
     ++				return error(_("could not load pack"));
       
      +			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
       			fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
     @@ midx-write.c: static int write_midx_internal(struct repository *r, const char *o
       		goto cleanup;
       	}
       
     +@@ midx-write.c: static int write_midx_internal(struct repository *r, const char *object_dir,
     + 		struct packed_git *oldest = ctx.info[ctx.preferred_pack_idx].p;
     + 		ctx.preferred_pack_idx = 0;
     + 
     ++		/*
     ++		 * Attempt opening the pack index to populate num_objects.
     ++		 * Ignore failiures as they can be expected and are not
     ++		 * fatal during this selection time.
     ++		 */
     ++		open_pack_index(oldest);
     ++
     + 		if (packs_to_drop && packs_to_drop->nr)
     + 			BUG("cannot write a MIDX bitmap during expiration");
     + 
     +@@ midx-write.c: static int write_midx_internal(struct repository *r, const char *object_dir,
     + 
     + 			if (!oldest->num_objects || p->mtime < oldest->mtime) {
     + 				oldest = p;
     ++				open_pack_index(oldest);
     + 				ctx.preferred_pack_idx = i;
     + 			}
     + 		}
      @@ midx-write.c: static int write_midx_internal(struct repository *r, const char *object_dir,
       
       	if (ctx.preferred_pack_idx > -1) {
 2:  709555c531 ! 2:  a1dd3ed874 midx-write: put failing response value back
     @@ Commit message
      
          This instance of setting the result to 1 before going to cleanup was
          accidentally removed in fcb2205b77 (midx: implement support for writing
     -    incremental MIDX chains, 2024-08-06).
     +    incremental MIDX chains, 2024-08-06). Build upon a test that already deletes
     +    a packfile to verify that this error propagates to full command failure.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ midx-write.c: static int write_midx_internal(struct repository *r, const char *o
       		goto cleanup;
       	}
       
     +
     + ## t/t5319-multi-pack-index.sh ##
     +@@ t/t5319-multi-pack-index.sh: test_expect_success 'load reverse index when missing .idx, .pack' '
     + 		mv $idx.bak $idx &&
     + 
     + 		mv $pack $pack.bak &&
     +-		git cat-file --batch-check="%(objectsize:disk)" <tip
     ++		git cat-file --batch-check="%(objectsize:disk)" <tip &&
     ++
     ++		test_must_fail git multi-pack-index write 2>err &&
     ++		grep "could not load pack" err
     + 	)
     + '
     + 
 3:  a5bee03601 = 3:  c4f75cca09 midx-write: use cleanup when incremental midx fails
 4:  bd97db26f7 ! 4:  2290e27ded midx-write: use uint32_t for preferred_pack_idx
     @@ midx-write.c: static int write_midx_internal(struct repository *r, const char *o
      +		struct packed_git *oldest = ctx.info[0].p;
       		ctx.preferred_pack_idx = 0;
       
     - 		if (packs_to_drop && packs_to_drop->nr)
     + 		/*
      @@ midx-write.c: static int write_midx_internal(struct repository *r, const char *object_dir,
       			 * objects to resolve, so the preferred value doesn't
       			 * matter.
 5:  eb1abdca32 = 5:  35302f5228 midx-write: reenable signed comparison errors
 -:  ---------- > 6:  7be25cf534 midx-write: simplify error cases

-- 
gitgitgadget
