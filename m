Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D064963CA
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407981; cv=pass; b=pHkbxWCJ6jL+j+r0W08X48+V+i3CuJ2vlibsIAQUtzlfH6Z3ms3CHutosZaVaDNMLD9Vnj1OwjkV3Mq7ujpBbIcL/o02WuOemenuW2Pcxp6fOQOioqMJd5KM05ZMwH6UlVlTWU4CXcOpCDYRasB6o6vkz4yT5ipgFNCWLuCjhE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407981; c=relaxed/simple;
	bh=6mUq6zpiCzlaDuGStoj5XQ5OUCXWmQlNIU46xgQFUTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buGkbTDhJyzk9agEDWSFkbXBOKwcYZUGmDeZ5nqw8u3PasZNRerm+UF/eR7hUaqKueLe+LccPID1Wt/2gVBBkmhlCrAt9eMt4pyYak4Rjx5lxYHHm96fV94KL/cdMo/rKSLiXZyhUmkZpsimVHJCcYpq0tnrbl7zGSG9745v1fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=cQcWRWkN; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="cQcWRWkN"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67149cfbcb7so1391574d50.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 10:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789407978; cv=none;
        d=google.com; s=arc-20260327;
        b=VMCN8UiodLkEAAvJopa2O2p/t/lvINPNX/wWWShHkhUuKXDSnNWYbS/qMC2/KEU4yN
         D15XsvHJaLU7Wyq9m5Dy6jd07fSyoeVNBRZ/OP+NKNlNX2wOjEIenzVU2y11nvZIUI/H
         j1JdnGBMsSQhzYuGzIlphS2z8euS7/5HuwNvNyKUzJe3RFZfx8LBzC65OzSF+L6uNMke
         ySZxvE60PgZG+SolO1DmRZAVxoy5prbAFNwgW+rHHjKkK864HbSWwXgkbxkB9IUMLiVy
         F+m57KYsff+qee7ycY9nRxE4iL6Vm6gCrezqS9XjpDGFwlKrR5Nqbidx6nBkfc3D7WC+
         Jp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=89F5UafHvJQawzzn2U/gKFg1qBTASPFfWwucRiEvGfo=;
        fh=zP/Hr7pwuqfiYK8Q+Eaa97o/hzC/ALqcfnzDTWvAC/s=;
        b=Bcd3BMUCQ5T1fu0kaiSlHeswTcQhrODXz8itaejgPMUMF77A9fb82fJM447fBORs/u
         714d0jzaoVKTt5/P+7VvzGEfsa7wibLvYBfdTbTtbgGmuzB3pr47FqAwI3178VM6Lsxy
         +35PRDGGRbEvXId4xKhmiptmibHDyEAI1kKfXQ8SPQk6Uu9RgxDBpNE7vDIOnyo0apcA
         o0/B0hZ1l08zwE35Q2OYr4Y4d5aiBhK5elv2DDYIsonfH2Mga6lwfqPEkxbyWXTnYLXA
         W2sH12ry8lXGGrf8vdVk/fFc76jEz5iVEDn7W/HMl5nuVYJALW05EUD8VuKslWXtDlx1
         tEUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1789407978; x=1790012778; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89F5UafHvJQawzzn2U/gKFg1qBTASPFfWwucRiEvGfo=;
        b=cQcWRWkNyLIj7mTT1hUIjRhjJpZswoVQO+b1tjAR/TIfHF4X2I7L9wibJxU+Y5m3vF
         KMwbU80oplzgYvjr0PKnQIZ9DTIqsH5TQei1oooBV1VY5mBFSXuSAnRMn9djiAac4y6g
         LM1qoy3DuOXafHd3jFHckISS+6eatwQyYe0L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789407978; x=1790012778;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=89F5UafHvJQawzzn2U/gKFg1qBTASPFfWwucRiEvGfo=;
        b=XAp4z7c2fEDVg+TR/09MipoX9pAmgx5EEAwYHo/6Ls0B2fo9KNRzrRt8Y8yGcq467u
         ciodFyoxeyhSAOkGptw4RfujEKhFXbI0VEgaEORJBKnOCsqfj+DQiiEJkWPfrogV+k2L
         jkRfLf7FoYKE92+8u2iynE/hjv6seg1lQrZq5BfvJqazJitq4Ko6nU3c/t7Wx7Yuyzea
         uzQ8O7isrdQbjmtmVzGXL/Amrm7hPu1TgINKTFInb/tzB0UcCVBf0g3ik/vBkBQQRMOY
         wZ7+gUXB48b479OAu7q3CruHC09PZsW2Oht6zqRFKHCdDHxCzW1S6LTda9hTL5r5xjic
         AfVw==
X-Forwarded-Encrypted: i=1; AKwUvBxb8Qcjk/z9OVinUpYT62snApKwL+JDEre+0Sk5ofR3+k7pjECdspn5FxRCYmYG6HvLIdQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lYd54vQmdlY/kQ4arhrys+8fXhMrSg2MEfFWUWdBBpP7PxVKl8
	aa/X/FlcVHgG/qynvsRbyOcEbBsyBh/Y3wpkPStr105qtBD3jmrpI0vcrx9ujCXFY7R5NZWithj
	a/uVeQvvaSBX7i5RjOsVJT+19DLgRaf/EYkuT+iQThQ==
X-Gm-Gg: AYBFou1xw7v9DbsMYhKJlazKqesEEvU5aiLvc3zi69fRRAZCcUPUEjybsYSPJK8IvG0
	1KyrZXOIHh5ulqZ2ynE6VFO4lNvT2TqROAbOcC/Q/OIjxkc820gU5VdleVFbnWSD/hIWYkkTQ0O
	C/u/iv0Y6dFpLexdyw9q4K7TeVpUckTDMvjSOlFFq0NmvhEuI3VTShh0xVH7AKJshctnrFtet0S
	7+JPY+q1HdnyDMPBIThRk99harHW3XUtvO0gKzyAi8OoXcTB2NKhntu7xncepmJfbcVnpvqc6mg
	FYuOQHmYzjd/R0uTJNJZVrQjrgPn/cSjb+5vwZQOy+6pt5ES6WhhmNAv+dONL3ie1A==
X-Received: by 2002:a05:690e:4385:b0:671:230c:e752 with SMTP id
 956f58d0204a3-6714e188b77mr851753d50.61.1789407978480; Mon, 14 Sep 2026
 10:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <ebe6c90cc58b9e1f64c9bec4a18e8cb3ce9be1b2.1789379276.git.gitgitgadget@gmail.com>
 <xmqqh5jr7t1h.fsf@gitster.g>
In-Reply-To: <xmqqh5jr7t1h.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 14 Sep 2026 19:46:05 +0200
X-Gm-Features: AcwNN1XGN0xFZIyyyTxJZEyYZarguQUR49ewxHIEzBI02sdckw5JUHnfr8juA30
Message-ID: <CAL71e4My+maYAtWbkoHXvsm=qhCmao7K_7mLV5wg1FyKTa3u8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] connected: add incremental connectivity check via rev-list
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Sept 2026 at 17:26, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> I wonder if this is_promisor_object() call comes a bit too late, as
> we earlier already have called odb_read_object_info() which may have
> fetched it lazily from the promisor remote?  Or do we globally
> disable promisor_remote_get_direct() call somehow without having to
> pass OBJECT_INFO_SKIP_FETCH_OBJECT flag?

Yes, I think it's safe due to the following mechanism:

1. If promisors exist, the connectivity-check will invoke
   rev-list with --exclude-promisor-objects.
2. rev-list in turn sets repo->fetch_if_missing = 0 on startup.
3. Then the odb read goes down into do_oid_object_info_extended()
   which respects that flag.

However, my paranoia kicked in so I re-ran my test for this,
after adding some temporary code inside
verify_commits_incremental():

    repo->fetch_if_missing = 1;

And fortunately, one of the tests failed as expected.

    Exactly 1 failure out of 62 tests: test 53
      "incremental: verifies new subtree when parent subtree is
       promised".

And the relevant assertion is this one:

    test_must_fail env GIT_NO_LAZY_FETCH=1 \
        git cat-file -e "$parent_subtree"

which ensures that the object was never fetched.

However, the test only catches this scenario for trees,
not blobs -- that's an oversight, I will add a matching
test for blobs too.

I think the code technically works as-is, but I could also try
to rewrite the code to stop depending on odb_read_object_info()
and instead use odb_read_object_info_extended() which allows
me to pass the flags.  That gives us belts and suspenders, which
may be nicer here.

> Do we assume that we do not have to deal with repository corruption
> in any graceful way?  I am just wondering what happens when
> get_commit_tree_oid() yields NULL after parse_commit_or_die() finds
> p->item is a valid-looking commit object but the tree within it is
> not, and we end up passing NULL to tree_map_add(), perhaps?
>
> The same potential issue may exist in the get_commit_tree_oid() call
> outside the look at the end on the incoming commit's tree.

You're right, this is an oversight.
I think I incorrectly assumed that parse_commit_or_die()
would catch any malformed commit.

I will add a NULL check and a die()-exit at the two call sites
in verify_commit_tree()

    die(_("unable to load root tree for commit %s"),
        oid_to_hex(&commit->object.oid));

Thanks for spotting these errors,
Kristofer
