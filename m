Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C03D1CCE
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903181; cv=none; b=JHRVXbgQ+kQaEdGaeArnIGPBydVvomCZ5fAofqvNht2BFa8tdkFozw+2ifIqnC6s8DkJ0TYbnjG1qYjr2xcKiSFHdq7Vy6M4Ees8d+o03L7slVyIqRVo+TtD8gmoHIPP6xwCC0QSiUbaZ/ON24AAg/ZaZMU9lHvCL6COtcP/K8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903181; c=relaxed/simple;
	bh=T14GMJ3rNlboxqbbPxBn8+VwQIgd0/s3BtmdND5J0nA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=csevqUeUx9HgJGcDUVOu6N7XBFIxVU/bcU4tqQuWzMhpMosbFI3DRvosYs7e039ozrt9x3jQvUPJu3fyRpWWyTk+vDLzslYXlD6P6iHk+ndiQLKdvSEsQEH71AkRJwhXhb39M+Ls8vrepvvOie98ICcld74x6NcsnPqeojVXp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWE00RUH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWE00RUH"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43596062728so11317f8f.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768903177; x=1769507977; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAvZLZcFY2WGvi2BQvDD+a1ldwjWfHOPk5ZlIcLbbuY=;
        b=hWE00RUHy5iL8sCQmTE4VZDzjD9S4bZIIkmH4MLWoBeDUguXYmWPrSxp8wOZ3db8ZY
         HYiifAwijSvPk1WZDmZ7Pm7PH2xkLOc2uJTdCBwD1tBoU/+d2Soe1U7aKQ7UWY0Paa1j
         FRJY54XNHuhmG47Kor4uV9LfEksFhp2fiOfzfpEyUee8GD3Tbkay9U28vIU1S/b5PTtl
         ZGo6fvWzLKfNK291wxi9pxsC2b/FL8XaQ8miSPZhM/dEoOreuzs2fLFxfNu7FZnFwHup
         whqevBJyS8AwJqWmb4zn5oeyF33XneR51jOWi4WgpL2d3GGMck0j2lCthSdGH5ctpekF
         Zt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903177; x=1769507977;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAvZLZcFY2WGvi2BQvDD+a1ldwjWfHOPk5ZlIcLbbuY=;
        b=IEO576v+sSHB/9HoWhClQVVKnMhVMQpT6xV54/De8L9ExipnFtXJmpRQBgSW2LYCPj
         B8iLGiS7Ku2LtW8BHOu6FHhVRvBvrIQ9PX2lVuCWvbiiSApoOGtP4J+YKlPv/3zMQy5q
         ouRW4ihX+feOQYsIpioS0w4kBOnJlJt1NaulRf7YdxZ/eIYWSCviaGW5uoQ5BAD+cdRl
         mdtlbkjSrZpvdVxSAmaO4r+VSOWwnf7kRo7kTkHolzWnZ+T1BzIW0yBBe0P7OkXjDoDi
         Pdx90EOrqC0yFGA/crpf1+mZyJTQNDnpJXPzzGcvipEMlyWZzDfgdhV1OaugYjC4P2tU
         IFvg==
X-Gm-Message-State: AOJu0Yx8TCzLZDHqC+GUMVTzBx/aWfeKqXZ25scT5vwnmg+ZOG2Tui3Z
	fckK4SLh99yyarAivkynyrxNk2c03apSIoNaUojFOO5C8JXv7etsh85I
X-Gm-Gg: AZuq6aJGsk/Iv/wUE0TMLHyRnoIXNi7PQdi9n/0pMXVG7HbIqOqbUAM/Lq2o3qL9Qwy
	NIvivgGY7M0Xt3twWW8mNYe5kF+3vYS5MTGv8gZgZX73RYUfAWOaA+qW/adOtrZ/oLMidkau0UH
	4+e1A1V4n6NOYPrqodRsFHyVA4y2miBE1hLjB8l3EPKfGHLUHJ60DS7Bwgmthm+El6loMf9/0q4
	CEQYkM6B6bQXdOUvtHHyXqf4I5hdC22Gxv9/xdblGzpQvcfwSuN5Se8taBxICko6fv0aDszB+d8
	IlfrvAZtTE0rC2T/pWpY+HBws5V9uNNQrUwT1fPF4f6i2wHvZZaQSCmPT+r6sZsfbVMAKfjA3rr
	/1Xd5z8d7meptZtiUdF50+ZiV8qFxRkMAp/iZ557G6IIfMFpHjDEdoFOedFdc/ztFKL9NKWOYnC
	AwR1eSWz5ugeXcWcilBQ62PSUp1WkL
X-Received: by 2002:a05:6000:2906:b0:432:5a4e:c023 with SMTP id ffacd0b85a97d-4356954f212mr20876619f8f.13.1768903176215;
        Tue, 20 Jan 2026 01:59:36 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9d17:c155:e8f0:9505])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm27879778f8f.4.2026.01.20.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:59:35 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/6] refs: provide detailed error messages when using
 batched update
Date: Tue, 20 Jan 2026 10:59:18 +0100
Message-Id: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPZRb2kC/7XOS27DIBAG4KtErDsVj/iVVe9RZYExtqeKIWKI0
 yry3Tu4qpQLZMcP/zDfQ5BP6EmcDg+R/IqEMXAwbwfhZhsmDzhwFlrqWiploDYGkp+Sp1KFS6Q
 MA9op8AEdLHxveeo++wDXG80YJghcdHFZMEPsv7zLBDnyLyPB7O1AoJqmrXst2+5oBa++8ht+7
 6zP81+m2z5ZLKUxI+WYfnb3qkrvn3h8DXFVIGGsxrZXjXGVVB/TYvHyzkOiEFf9jKhfhNCM6HR
 lpe9cMxr9jNi27Rd+a8T0zwEAAA==
X-Change-ID: 20260113-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-17786b20894a
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 newren@gmail.com, gitster@pobox.com, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=28993;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=T14GMJ3rNlboxqbbPxBn8+VwQIgd0/s3BtmdND5J0nA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlvUgawaz4Ve8ggF5kqWhzkGy0Xd7qZV9jgk
 zs9Gywy3kisnIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpb1IGAAoJED7VnySO
 Rox/on0L/As8Qwwxc2wuaqgzGndvczYR20tbO7Ni3zbOvMjGW6TOXUvSE+R99HYpEQZJLahE4cs
 YpQJ7tR52HIbaog6U1VxskDCeyUvI5gKP4R5VrmrVaxgyg63BScCP85eTM7uhWZw+VoAtbdM1dw
 u/UMT23nD2ZN9yeE91c00wRHqgYoJS8CNjoLbpDOjq3VJxVUuihfenHHumG6qeoq5X28k/AST2S
 h0RtcDByc//0FvDjg79TggtX05IoANKdYiVXkT7anNqVo4NlinW1L6Zb7kuv7lD5vhnOIzmvqV6
 i+eSrVeX7cmbKFhRIEux9q6oEf4LY7449w9oZoT0pYZ70ltmcTO/K9M0AZUfyHJ4mO0snMBBXyN
 rdgi2jfAd/KStWBOlOs3JDL/BFOgt5zTdt0WHZ8l1zQRcK1z2dLmX9ZY0bO2xLRiCLxOfCx1uZJ
 fOc0kWlzwyrnX1bS2WU9R46Kxqa+JSDuarthVmYaMpjcSPUBbJxWsFGfUDl5SlPNo/Qwxwe8AU4
 Rk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The refs namespace uses an error buffer to capture details about failed
reference updates. However when we added batched update support to
reference transactions, these messages were never propagated, instead
only an error code pertaining to the type of failure was propagated.

Currently, there are three regions which utilize batched updates:

  - git update-ref --batch-updates
  - git fetch
  - git receive-pack

While 'git update-ref --batch-updates' was a newly introduced flag, both
'git fetch' and 'git receive-pack' were pre-existing. Before using
batched updates, they provided more detailed error messages to the user,
but this changed with the introduction of batched updates. This is a
regression in their workings.

This patch series fixes this, by passing the detailed error message and
utilizing it whenever available. The regression was reported by Elijah
Newren [1] and based on the patch submitted by Jeff King [2].

[1]: https://lore.kernel.org/all/CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com/
[2]: https://lore.kernel.org/all/20251224081214.GA1879908@coredump.intra.peff.net/

---
Changes in v3:
- Drop the first commit.
- For the last commit, where we delay 'git fetch' status information,
  delay all information to the end. Also use a list to compliment the
  existing strmap, this ensures that the order is maintained.
- Link to v2: https://patch.msgid.link/20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com

Changes in v2:
- Updates to the commit messages to be more descriptive.
- Instead of passing the char pointer for the error description, pass
  the 'strbuf' itself. This makes the API a lot cleaner to deal with.
  Also avoids having to remember to reset the strbuf after usage.
- Chalk out a separate commit for using a 'goto next_ref' in
  `refs_verify_refnames_available()`. This makes the intention much
  clearer.
- For git-update-ref(1), keep the existing implementation as is and only
  output the detailed error message to stderr.
- For git-receive-pack(1), use 'rp_error()' for detailed error message
  while keeping the current implementation as is.
- Added a separate patch to handle missing information in git-fetch(1)'s
  status table. This involves delaying updates to the end, where update
  success/failure information is available. I'm not too confident about
  this approach though, we could also drop it from the series and I
  could pick that up independently. This is still 1.19 ± 0.02 times
  faster than non-batched version (v2.50.0) in the files backend.
- Link to v1: https://patch.msgid.link/20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com

---
 builtin/fetch.c         | 259 +++++++++++++++++++++++++++++++++++++-----------
 builtin/receive-pack.c  |   7 +-
 builtin/update-ref.c    |   7 +-
 refs.c                  |  46 +++++----
 refs.h                  |   1 +
 refs/files-backend.c    |   5 +-
 refs/packed-backend.c   |  12 +--
 refs/refs-internal.h    |   4 +-
 refs/reftable-backend.c |   5 +-
 t/t1400-update-ref.sh   |  71 +++++++------
 t/t5510-fetch.sh        |   8 +-
 t/t5516-fetch-push.sh   |  16 +++
 12 files changed, 316 insertions(+), 125 deletions(-)

Karthik Nayak (6):
      refs: skip to next ref when current ref is rejected
      refs: add rejection detail to the callback function
      update-ref: utilize rejected error details if available
      fetch: utilize rejected ref error details
      receive-pack: utilize rejected ref error details
      fetch: delay user information post committing of transaction

Range-diff versus v2:

1:  7592b0a9aa < -:  ---------- refs: drop unnecessary header includes
2:  97095095bc = 1:  dbabb9a172 refs: skip to next ref when current ref is rejected
3:  2dadab77a2 = 2:  b0ab39a262 refs: add rejection detail to the callback function
4:  007c6d58c1 = 3:  2b323bddbc update-ref: utilize rejected error details if available
5:  0d0b8b75c8 = 4:  8bf3d986f4 fetch: utilize rejected ref error details
6:  b9348b5ae3 = 5:  5dab402570 receive-pack: utilize rejected ref error details
7:  d90420903f ! 6:  596762e6b5 fetch: delay user information post committing of transaction
    @@ Commit message
         `ref_update_display_info` which will hold individual update's
         information and also whether the update failed or succeeded. This
         finally allows us to iterate over all such updates and print them to the
    -    user. While this brings back the functionality, it does change the order
    -    of the output. Modify the tests to reflect this.
    +    user.
     
    -    Using an strmap does add some overhead to 'git-fetch(1)', but from
    -    benchmarking this seems to be not too bad:
    +    Using an dynamic array and strmap does add some overhead to
    +    'git-fetch(1)', but from benchmarking this seems to be not too bad:
     
           Benchmark 1: fetch: many refs (refformat = files, refcount = 1000, revision = master)
    -        Time (mean ± σ):      51.9 ms ±   2.5 ms    [User: 15.6 ms, System: 36.9 ms]
    -        Range (min … max):    47.4 ms …  58.3 ms    41 runs
    +        Time (mean ± σ):      42.6 ms ±   1.2 ms    [User: 13.1 ms, System: 29.8 ms]
    +        Range (min … max):    40.1 ms …  45.8 ms    47 runs
     
           Benchmark 2: fetch: many refs (refformat = files, refcount = 1000, revision = HEAD)
    -        Time (mean ± σ):      53.0 ms ±   1.8 ms    [User: 17.6 ms, System: 36.0 ms]
    -        Range (min … max):    49.4 ms …  57.6 ms    40 runs
    +        Time (mean ± σ):      43.1 ms ±   1.2 ms    [User: 12.7 ms, System: 30.7 ms]
    +        Range (min … max):    40.5 ms …  45.8 ms    48 runs
     
           Summary
             fetch: many refs (refformat = files, refcount = 1000, revision = master) ran
    -          1.02 ± 0.06 times faster than fetch: many refs (refformat = files, refcount = 1000, revision = HEAD)
    +          1.01 ± 0.04 times faster than fetch: many refs (refformat = files, refcount = 1000, revision = HEAD)
     
         Another approach would be to move the status printing logic to be
         handled post the transaction being committed. That however would require
    @@ Commit message
         which is more involved infrastructure work compared to the strmap
         approach here.
     
    +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Reported-by: Jeff King <peff@peff.net>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ builtin/fetch.c: static void display_ref_update(struct display_state *display_st
     +	const char *summary;
     +	const char *fail_detail;
     +	const char *success_detail;
    ++	const char *ref;
     +	const char *remote;
    -+	const char *local;
     +	struct object_id old_oid;
     +	struct object_id new_oid;
     +};
     +
    -+static struct ref_update_display_info *ref_update_display_info_new(
    -+						char success_code,
    -+						char fail_code,
    -+						const char *summary,
    -+						const char *success_detail,
    -+						const char *fail_detail,
    -+						const char *remote,
    -+						const struct object_id *old_oid,
    -+						const struct object_id *new_oid)
    ++static struct ref_update_display_info *ref_update_display_info_append(
    ++					   struct ref_update_display_info **list,
    ++					   size_t *count,
    ++					   char success_code,
    ++					   char fail_code,
    ++					   const char *summary,
    ++					   const char *success_detail,
    ++					   const char *fail_detail,
    ++					   const char *ref,
    ++					   const char *remote,
    ++					   const struct object_id *old_oid,
    ++					   const struct object_id *new_oid)
     +{
     +	struct ref_update_display_info *info;
    -+	CALLOC_ARRAY(info, 1);
    ++	size_t index = *count;
     +
    ++	(*count)++;
    ++	REALLOC_ARRAY(*list, *count);
    ++
    ++	info = &(*list)[index];
    ++
    ++	info->failed = false;
     +	info->success_code = success_code;
     +	info->fail_code = fail_code;
     +	info->summary = xstrdup(summary);
     +	info->success_detail = xstrdup_or_null(success_detail);
     +	info->fail_detail = xstrdup_or_null(fail_detail);
     +	info->remote = xstrdup(remote);
    ++	info->ref = xstrdup(ref);
     +
     +	oidcpy(&info->old_oid, old_oid);
     +	oidcpy(&info->new_oid, new_oid);
    @@ builtin/fetch.c: static void display_ref_update(struct display_state *display_st
     +	free((char *)info->success_detail);
     +	free((char *)info->fail_detail);
     +	free((char *)info->remote);
    ++	free((char *)info->ref);
     +}
     +
     +static void ref_update_display_info_display(struct ref_update_display_info *info,
     +					    struct display_state *display_state,
    -+					    const char *refname, int summary_width)
    ++					    int summary_width)
     +{
     +	display_ref_update(display_state,
     +			   info->failed ? info->fail_code : info->success_code,
     +			   info->summary,
     +			   info->failed ? info->fail_detail : info->success_detail,
    -+			   info->remote, refname, &info->old_oid,
    ++			   info->remote, info->ref, &info->old_oid,
     +			   &info->new_oid, summary_width);
     +}
     +
      static int update_local_ref(struct ref *ref,
      			    struct ref_transaction *transaction,
    - 			    struct display_state *display_state,
    +-			    struct display_state *display_state,
      			    const struct ref *remote_ref,
    - 			    int summary_width,
    +-			    int summary_width,
     -			    const struct fetch_config *config)
     +			    const struct fetch_config *config,
    -+			    struct strmap *delayed_ref_display)
    ++			    struct ref_update_display_info **display_list,
    ++			    size_t *display_count)
      {
      	struct commit *current = NULL, *updated;
      	int fast_forward = 0;
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
    + 
    + 	if (oideq(&ref->old_oid, &ref->new_oid)) {
    + 		if (verbosity > 0)
    +-			display_ref_update(display_state, '=', _("[up to date]"), NULL,
    +-					   remote_ref->name, ref->name,
    +-					   &ref->old_oid, &ref->new_oid, summary_width);
    ++			ref_update_display_info_append(display_list, display_count,
    ++						       '=', '=', _("[up to date]"),
    ++						       NULL, NULL, ref->name,
    ++						       remote_ref->name, &ref->old_oid,
    ++						       &ref->new_oid);
    + 		return 0;
    + 	}
    + 
    + 	if (!update_head_ok &&
    + 	    !is_null_oid(&ref->old_oid) &&
    + 	    branch_checked_out(ref->name)) {
    ++		struct ref_update_display_info *info;
    + 		/*
    + 		 * If this is the head, and it's not okay to update
    + 		 * the head, and the old value of the head isn't empty...
    + 		 */
    +-		display_ref_update(display_state, '!', _("[rejected]"),
    +-				   _("can't fetch into checked-out branch"),
    +-				   remote_ref->name, ref->name,
    +-				   &ref->old_oid, &ref->new_oid, summary_width);
    ++		info = ref_update_display_info_append(display_list, display_count,
    ++						      '!', '!', _("[rejected]"),
    ++						      NULL, _("can't fetch into checked-out branch"),
    ++						      ref->name, remote_ref->name,
    ++						      &ref->old_oid, &ref->new_oid);
    ++		ref_update_display_info_set_failed(info);
    + 		return 1;
    + 	}
    + 
      	if (!is_null_oid(&ref->old_oid) &&
      	    starts_with(ref->name, "refs/tags/")) {
    ++		struct ref_update_display_info *info;
    ++
      		if (force || ref->force) {
    -+			struct ref_update_display_info *info;
      			int r;
     +
      			r = s_update_ref("updating tag", ref, transaction, 0);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -					   remote_ref->name, ref->name,
     -					   &ref->old_oid, &ref->new_oid, summary_width);
     +
    -+			info = ref_update_display_info_new('t', '!', _("[tag update]"), NULL,
    -+							   _("unable to update local ref"),
    -+							   remote_ref->name, &ref->old_oid,
    -+							   &ref->new_oid);
    ++			info = ref_update_display_info_append(display_list, display_count,
    ++							      't', '!', _("[tag update]"), NULL,
    ++							      _("unable to update local ref"),
    ++							      ref->name, remote_ref->name,
    ++							      &ref->old_oid, &ref->new_oid);
     +			if (r)
     +				ref_update_display_info_set_failed(info);
    -+			strmap_put(delayed_ref_display, ref->name, info);
     +
      			return r;
      		} else {
    - 			display_ref_update(display_state, '!', _("[rejected]"),
    +-			display_ref_update(display_state, '!', _("[rejected]"),
    +-					   _("would clobber existing tag"),
    +-					   remote_ref->name, ref->name,
    +-					   &ref->old_oid, &ref->new_oid, summary_width);
    ++			info = ref_update_display_info_append(display_list, display_count,
    ++							      '!', '!', _("[rejected]"), NULL,
    ++							      _("would clobber existing tag"),
    ++							      ref->name, remote_ref->name,
    ++							      &ref->old_oid, &ref->new_oid);
    ++			ref_update_display_info_set_failed(info);
    + 			return 1;
    + 		}
    + 	}
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      	updated = lookup_commit_reference_gently(the_repository,
      						 &ref->new_oid, 1);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -				   remote_ref->name, ref->name,
     -				   &ref->old_oid, &ref->new_oid, summary_width);
     +
    -+		info = ref_update_display_info_new('*', '!', what, NULL,
    -+						   _("unable to update local ref"),
    -+						   remote_ref->name, &ref->old_oid,
    -+						   &ref->new_oid);
    ++		info = ref_update_display_info_append(display_list, display_count,
    ++						      '*', '!', what, NULL,
    ++						      _("unable to update local ref"),
    ++						      ref->name, remote_ref->name,
    ++						      &ref->old_oid, &ref->new_oid);
     +		if (r)
     +			ref_update_display_info_set_failed(info);
    -+		strmap_put(delayed_ref_display, ref->name, info);
     +
      		return r;
      	}
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -				   remote_ref->name, ref->name,
     -				   &ref->old_oid, &ref->new_oid, summary_width);
     +
    -+		info = ref_update_display_info_new(' ', '!', quickref.buf, NULL,
    -+						   _("unable to update local ref"),
    -+						   remote_ref->name, &ref->old_oid,
    -+						   &ref->new_oid);
    ++		info = ref_update_display_info_append(display_list, display_count,
    ++						      ' ', '!', quickref.buf, NULL,
    ++						      _("unable to update local ref"),
    ++						      ref->name, remote_ref->name,
    ++						      &ref->old_oid, &ref->new_oid);
     +		if (r)
     +			ref_update_display_info_set_failed(info);
    -+		strmap_put(delayed_ref_display, ref->name, info);
     +
      		strbuf_release(&quickref);
      		return r;
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     -				   remote_ref->name, ref->name,
     -				   &ref->old_oid, &ref->new_oid, summary_width);
     +
    -+		info = ref_update_display_info_new('+', '!', quickref.buf,
    -+						   _("forced update"),
    -+						   _("unable to update local ref"),
    -+						   remote_ref->name, &ref->old_oid,
    -+						   &ref->new_oid);
    ++		info = ref_update_display_info_append(display_list, display_count,
    ++						      '+', '!', quickref.buf, _("forced update"),
    ++						      _("unable to update local ref"),
    ++						      ref->name, remote_ref->name,
    ++						      &ref->old_oid, &ref->new_oid);
    ++
     +		if (r)
     +			ref_update_display_info_set_failed(info);
    -+		strmap_put(delayed_ref_display, ref->name, info);
     +
      		strbuf_release(&quickref);
      		return r;
      	} else {
    +-		display_ref_update(display_state, '!', _("[rejected]"), _("non-fast-forward"),
    +-				   remote_ref->name, ref->name,
    +-				   &ref->old_oid, &ref->new_oid, summary_width);
    ++		struct ref_update_display_info *info;
    ++		info = ref_update_display_info_append(display_list, display_count,
    ++						      '!', '!', _("[rejected]"), NULL,
    ++						      _("non-fast-forward"),
    ++						      ref->name, remote_ref->name,
    ++						      &ref->old_oid, &ref->new_oid);
    ++		ref_update_display_info_set_failed(info);
    + 		return 1;
    + 	}
    + }
     @@ builtin/fetch.c: static int store_updated_refs(struct display_state *display_state,
      			      int connectivity_checked,
      			      struct ref_transaction *transaction, struct ref *ref_map,
      			      struct fetch_head *fetch_head,
     -			      const struct fetch_config *config)
     +			      const struct fetch_config *config,
    -+			      struct strmap *delayed_ref_display)
    ++			      struct ref_update_display_info **display_list,
    ++			      size_t *display_count)
      {
      	int rc = 0;
      	struct strbuf note = STRBUF_INIT;
    + 	const char *what, *kind;
    + 	struct ref *rm;
    + 	int want_status;
    +-	int summary_width = 0;
    +-
    +-	if (verbosity >= 0)
    +-		summary_width = transport_summary_width(ref_map);
    + 
    + 	if (!connectivity_checked) {
    + 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
     @@ builtin/fetch.c: static int store_updated_refs(struct display_state *display_state,
    + 					  display_state->url_len);
      
      			if (ref) {
    - 				rc |= update_local_ref(ref, transaction, display_state,
    +-				rc |= update_local_ref(ref, transaction, display_state,
     -						       rm, summary_width, config);
    -+						       rm, summary_width, config,
    -+						       delayed_ref_display);
    ++				rc |= update_local_ref(ref, transaction, rm,
    ++						       config, display_list,
    ++						       display_count);
      				free(ref);
      			} else if (write_fetch_head || dry_run) {
      				/*
    +@@ builtin/fetch.c: static int store_updated_refs(struct display_state *display_state,
    + 				 * would be written to FETCH_HEAD, if --dry-run
    + 				 * is set).
    + 				 */
    +-				display_ref_update(display_state, '*',
    +-						   *kind ? kind : "branch", NULL,
    +-						   rm->name,
    +-						   "FETCH_HEAD",
    +-						   &rm->new_oid, &rm->old_oid,
    +-						   summary_width);
    ++
    ++				ref_update_display_info_append(display_list, display_count,
    ++							       '*', '*', *kind ? kind : "branch",
    ++							       NULL, NULL, "FETCH_HEAD", rm->name,
    ++							       &rm->new_oid, &rm->old_oid);
    + 			}
    + 		}
    + 	}
     @@ builtin/fetch.c: static int fetch_and_consume_refs(struct display_state *display_state,
      				  struct ref_transaction *transaction,
      				  struct ref *ref_map,
      				  struct fetch_head *fetch_head,
     -				  const struct fetch_config *config)
     +				  const struct fetch_config *config,
    -+				  struct strmap *delayed_ref_display)
    ++				  struct ref_update_display_info **display_list,
    ++				  size_t *display_count)
      {
      	int connectivity_checked = 1;
      	int ret;
    @@ builtin/fetch.c: static int fetch_and_consume_refs(struct display_state *display
      	ret = store_updated_refs(display_state, connectivity_checked,
     -				 transaction, ref_map, fetch_head, config);
     +				 transaction, ref_map, fetch_head, config,
    -+				 delayed_ref_display);
    ++				 display_list, display_count);
      	trace2_region_leave("fetch", "consume_refs", the_repository);
      
      out:
    @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
      			 struct fetch_head *fetch_head,
     -			 const struct fetch_config *config)
     +			 const struct fetch_config *config,
    -+			 struct strmap *delayed_ref_display)
    ++			 struct ref_update_display_info **display_list,
    ++			 size_t *display_count)
      {
      	int retcode, cannot_reuse;
      
    @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
      	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
      	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
     -					 fetch_head, config);
    -+					 fetch_head, config, delayed_ref_display);
    ++					 fetch_head, config, display_list, display_count);
      
      	if (gsecondary) {
      		transport_disconnect(gsecondary);
    @@ builtin/fetch.c: struct ref_rejection_data {
      	bool conflict_msg_shown;
      	bool case_sensitive_msg_shown;
      	const char *remote_name;
    -+	struct strmap *delayed_ref_display;
    ++	struct strmap *rejected_refs;
      };
      
      static void ref_transaction_rejection_handler(const char *refname,
    -@@ builtin/fetch.c: static void ref_transaction_rejection_handler(const char *refname,
    - 					      void *cb_data)
    - {
    - 	struct ref_rejection_data *data = cb_data;
    -+	struct ref_update_display_info *info;
    - 
    - 	if (err == REF_TRANSACTION_ERROR_CASE_CONFLICT && ignore_case &&
    - 	    !data->case_sensitive_msg_shown) {
     @@ builtin/fetch.c: static void ref_transaction_rejection_handler(const char *refname,
      			      refname, ref_transaction_error_msg(err));
      	}
      
    -+	info = strmap_get(data->delayed_ref_display, refname);
    -+	if (info)
    -+		ref_update_display_info_set_failed(info);
    -+
    ++	strmap_put(data->rejected_refs, refname, NULL);
      	*data->retcode = 1;
      }
      
    @@ builtin/fetch.c: static void ref_transaction_rejection_handler(const char *refna
       */
      static int commit_ref_transaction(struct ref_transaction **transaction,
      				  bool is_atomic, const char *remote_name,
    -+				  struct strmap *delayed_ref_display,
    ++				  struct strmap *rejected_refs,
      				  struct strbuf *err)
      {
      	int retcode = ref_transaction_commit(*transaction, err);
    @@ builtin/fetch.c: static int commit_ref_transaction(struct ref_transaction **tran
      			.conflict_msg_shown = 0,
      			.remote_name = remote_name,
      			.retcode = &retcode,
    -+			.delayed_ref_display = delayed_ref_display,
    ++			.rejected_refs = rejected_refs,
      		};
      
      		ref_transaction_for_each_rejected_update(*transaction,
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      	struct fetch_head fetch_head = { 0 };
      	struct strbuf err = STRBUF_INIT;
      	int do_set_head = 0;
    -+	struct strmap delayed_ref_display = STRMAP_INIT;
    ++	struct ref_update_display_info *display_list = NULL;
    ++	struct strmap rejected_refs = STRMAP_INIT;
    ++	size_t display_count = 0;
     +	int summary_width = 0;
    -+	struct strmap_entry *e;
    -+	struct hashmap_iter iter;
      
      	if (tags == TAGS_DEFAULT) {
      		if (transport->remote->fetch_tags == 2)
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      
      	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
     -				   &fetch_head, config)) {
    -+				   &fetch_head, config, &delayed_ref_display)) {
    ++				   &fetch_head, config, &display_list, &display_count)) {
      		retcode = 1;
      		goto cleanup;
      	}
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      			 */
      			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
     -					  &fetch_head, config))
    -+					  &fetch_head, config, &delayed_ref_display))
    ++					  &fetch_head, config, &display_list, &display_count))
      				retcode = 1;
      		}
      
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      	retcode = commit_ref_transaction(&transaction, atomic_fetch,
     -					 transport->remote->name, &err);
     +					 transport->remote->name,
    -+					 &delayed_ref_display, &err);
    ++					 &rejected_refs, &err);
      	/*
      	 * With '--atomic', bail out if the transaction fails. Without '--atomic',
      	 * continue to fetch head and perform other post-fetch operations.
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      		commit_ref_transaction(&transaction, false,
     -				       transport->remote->name, &err);
     +				       transport->remote->name,
    -+				       &delayed_ref_display, &err);
    ++				       &rejected_refs, &err);
     +
    -+	/*
    -+	 * Clear any pending information that needs to be shown to the user.
    -+	 */
    -+	strmap_for_each_entry(&delayed_ref_display, &iter, e) {
    -+		struct ref_update_display_info *info = e->value;
    -+		ref_update_display_info_display(info, &display_state, e->key, summary_width);
    ++	for (size_t i = 0; i < display_count; i++) {
    ++		struct ref_update_display_info *info = &display_list[i];
    ++
    ++		if (!info->failed && strmap_contains(&rejected_refs, info->ref))
    ++			ref_update_display_info_set_failed(info);
    ++		ref_update_display_info_display(info, &display_state, summary_width);
     +		ref_update_display_info_free(info);
     +	}
      
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      	if (transaction)
      		ref_transaction_free(transaction);
     +
    -+	strmap_clear(&delayed_ref_display, 1);
    ++	free(display_list);
    ++	strmap_clear(&rejected_refs, 0);
      	display_state_release(&display_state);
      	close_fetch_head(&fetch_head);
      	strbuf_release(&err);
    @@ t/t5516-fetch-push.sh: test_expect_success 'pushing non-commit objects should re
      		test_grep "trying to write non-commit object $tagsha to branch ${SQ}refs/heads/branch${SQ}" err
      	)
      '
    -
    - ## t/t5574-fetch-output.sh ##
    -@@ t/t5574-fetch-output.sh: test_expect_success 'fetch aligned output' '
    - 		grep -e "->" actual | cut -c 22- >../actual
    - 	) &&
    - 	cat >expect <<-\EOF &&
    --	main                 -> origin/main
    - 	looooooooooooong-tag -> looooooooooooong-tag
    -+	main                 -> origin/main
    - 	EOF
    - 	test_cmp expect actual
    - '
    -@@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output' '
    - 		grep -e "->" actual | cut -c 22- >../actual
    - 	) &&
    - 	cat >expect <<-\EOF &&
    --	main       -> origin/*
    - 	extraaa    -> *
    -+	main       -> origin/*
    - 	EOF
    - 	test_cmp expect actual
    - '
    -@@ t/t5574-fetch-output.sh: do
    - 		cat >expect <<-EOF &&
    - 		- $MAIN_OLD $ZERO_OID refs/forced/deleted-branch
    - 		- $MAIN_OLD $ZERO_OID refs/unforced/deleted-branch
    --		  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
    - 		! $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/unforced/force-updated
    -+		* $ZERO_OID $MAIN_OLD refs/forced/new-branch
    -+		* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
    -+		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updated
    -+		  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
    - 		* $ZERO_OID $MAIN_OLD refs/unforced/new-branch
    - 		  $MAIN_OLD $FAST_FORWARD_NEW refs/forced/fast-forward
    --		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
    --		* $ZERO_OID $MAIN_OLD refs/forced/new-branch
    - 		  $MAIN_OLD $FAST_FORWARD_NEW refs/remotes/origin/fast-forward
    --		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updated
    --		* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
    -+		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
    - 		EOF
    - 
    - 		# Change the URL of the repository to fetch different references.
    -@@ t/t5574-fetch-output.sh: test_expect_success 'fetch porcelain overrides fetch.output config' '
    - 	new_commit=$(git rev-parse HEAD) &&
    - 
    - 	cat >expect <<-EOF &&
    --	  $old_commit $new_commit refs/remotes/origin/config-override
    - 	* $ZERO_OID $new_commit refs/tags/new-commit
    -+	  $old_commit $new_commit refs/remotes/origin/config-override
    - 	EOF
    - 
    - 	git -C porcelain -c fetch.output=compact fetch --porcelain >stdout 2>stderr &&


base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
change-id: 20260113-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-17786b20894a

Thanks
- Karthik

