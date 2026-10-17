Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D47B31ED93
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792225466; cv=pass; b=kexTaUOb0AKVbQoo6I57b1uFiJ9IinysxE+BwN8adAmknpogi7uDSIuzbkLfKk39pX9nuR/vrrsnhGJ09KP1ZahdS6u/+P3lGvNoNQBNzrACl9g5JSVqsf7tzEBCyw5NKAbJ2xduvJD2XLLjEvlzn0mm8ygUq5npnWRc1lbPmmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792225466; c=relaxed/simple;
	bh=eWkycQk0vD2giD3wITgB4yc3eEdBStzF+4S6IC0EFeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4QiLrtsp0G3sYyR/H5Sgt5Ep3LloeIoA1o9ZrwPnb0rKwajzza7+edA2e6GVA7NLY7EjbE0hx3kqaFXApALlpsD/ta2uYiExbnBEX47KaLKmpfzCLNnuz+IgJCdKj2S+TPkjehHAXCZzcRmb7tNDXJoa2vsw46hiQP6BmWjS1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8EvodJy; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8EvodJy"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a01cac8733so453679b3a.2
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 01:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792225465; cv=none;
        d=google.com; s=arc-20260327;
        b=U9iahcH0OS6TdX87XETRWz4MCCIh0lXHTzer9b74cCfOT0IvFDUddGs29N69SHoRA4
         /toAnDb+JhxwbdEEShszTzu6iVAHINC+Lu4R64E+h6enIMflejOHf6NsPyOtVLhDg0Fz
         BaPDVGEAAnen73oiSMa4HsbtaTFsz0khIqNqmTZTO0S5JKJcxwvkIZp2bLgRcEAY5+8y
         0Ze0EGTvHE3iX2rk95o7LkK8GguWwArxlyRAiIXw7n743Zn5ujBMnyG3gTTkpmNSR9/Z
         sVdQT6kt0H+VH2rj2cIboGarhP8wUOa80jewkkCGVIMKUpQBNdFoUcZq6j7jqFq6r3Z6
         bLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hpY5//l1+ZriCJ5hoB3VjULJh2W3HA2DUowdw5QA8ug=;
        fh=vy+ekYOhOcayYKYhsQPj4MSZRRObFPXkCEVNFy6W1bs=;
        b=gIYjBfFEi8CQR3ozkpNj8UznvgUcU57cxYpvMw70K1BYPrcK2B5TJpeNVGGid4VNJU
         urpaXP4ot4UOUOmLpNyHlkprB4fhO6sEUix48JaQ7Bjqpvw6hgz9VA0Tz2rUPN7bfX76
         Ll9GIWmFERpB/FNsirToJT879ncntK9/iO6LXoKRK1Tidcw6WZMz6eMU8xCt5jXyCA1x
         c1ddWOPqTWoOklqDi6PmNNvCr7DtlNxznOoCbnhbzU1EW+TpUqnUwz4xzYvrUVvm8jQI
         koh/TbG28Ufo0f50JhajQIcq3exfENu1/8RG1v1ehJKWPHAf6kzWjkPBhuSCLrvxn54d
         s5kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792225465; x=1792830265; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpY5//l1+ZriCJ5hoB3VjULJh2W3HA2DUowdw5QA8ug=;
        b=r8EvodJyP08moYelG/aZM3qztZNw7cB1M9HbeZdiiXC5jLBTMbpPo4QW0SlcP0TNG6
         xA54BCZaEILYOrKhnheWGz1UnuC81d7J/unVNMrkMeHdhjjA3rS7mOik1YZO37XVgPjm
         foukOgJxosURLOzH0xEUDJnsSpC4i8FvL8QPURPzkPF40BG4uODqLTB8MQF64kjqId3k
         a7ITPkvKOMqHJLHPIuNql0OZsFoy0ckCvyEUpGouJPL76i2kM9nqPQtx4oYJ1kJmW7Bk
         YO4/aMfUqVS8MLDGQl+yMEQReGJ5LebXrurfICfdtl+T+RtDYExZ+4mTvp5K+wO1RvBk
         MgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792225465; x=1792830265;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hpY5//l1+ZriCJ5hoB3VjULJh2W3HA2DUowdw5QA8ug=;
        b=Nu8PrVQwH3xiZHFFpA0SkfQQny2JOIyYO2TMoLVVpJiYTDLUMi3xAmXX1AfPnxw70Y
         I5jfZ0Cm1h8nM8G9L2st98zy55wmN7lNBSI+KRZjVgRdjwrxTbER6oqcfxOn2ewttKB9
         JtFWaI3VRUaCxYatJ6DjeVCuNrGuAV4/Nu3794Ya4K/h+O0P5oui4kf/SFDFBevKncpO
         /uiDYs2uWC0QdLzawgcKqMqJsAOI4exTKmLqfovXGvweT75IT06zg+s7px5JTyNerXwu
         +RIPQbdOzlQ4ddFiaLaKO0ms02f4lLwcii47gFgAExQ41o5+CWterw7/WApRDKGR7Zr/
         OHFg==
X-Gm-Message-State: AFq9FYJnClGZxCCfJKFuErrWpJOBrD7t0L0dTbiNWZIUQOmqsgVhleVY
	UI611zcd+U+fjiJv691m+w/LVEHTEsepQJJZAJJxSNXySeomREf8EMEYcotNZLODBkBXKsDPs7y
	hP7qVjS3rH2oxXa5Uw9suwkntTY2PqdQ=
X-Gm-Gg: AYBFou04wlFx26dfpIurYx1O2P0dhA1qNxgHx+W7g1B0GESxUsty5lSwY+fx1VIXjpv
	+1c2U4hNHtXecTWRSCA1WDWCJMDbj5PXkiggQyiMPVl4QD/MvymqoWXVM8uR1QYHTYj1RdmW1HE
	BaZwaauttBgFpXuRKhaTPbdHEmM7+D/a2kDhdleccvTJROR8Jt7kBlePlAddSEHAEhBwszgGHHl
	cMeKFRezpc0lqi1WMkg07Za6oMStpKyxUentbfFmBycPjcI0tkkTcu1en8Trf2Z0UrfK37KdIZh
	sMlMlLp/bq+8PMbQTJNmyra75UbdKDnvwmY5MDA3ztTrDZ+Hc3nmga29Lhp4/4scu84kUMMkflr
	WpIQ4SidQDOk0f9j4kGOizIG50tax8uEPdDZl3+UBXsS/gefMS1vMLN07gKGJzyrqJbOezemetN
	LshCJg1vU1ew==
X-Received: by 2002:a05:6a21:4903:b0:3e2:d8f:600f with SMTP id
 adf61e73a8af0-3e22613d7e1mr1517707637.72.1792225464418; Sat, 17 Oct 2026
 01:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010210050.76064-1-r.siddharth.shrimali@gmail.com>
 <20261016191344.82688-1-r.siddharth.shrimali@gmail.com> <xmqqse25e5ja.fsf@gitster.g>
In-Reply-To: <xmqqse25e5ja.fsf@gitster.g>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sat, 17 Oct 2026 13:53:47 +0530
X-Gm-Features: AclHuK-FjUuX0dZoTIaF_uM_tDyZ2BXsz4SUG5IGm8p_3fB0FOMv4Hdt98vD1ak
Message-ID: <CAGWgyh8H7h=jDnOR2RsiHJ8a_dj2MsSkNZX-A7hoEcgtxjMz3Q@mail.gmail.com>
Subject: Re: [PATCH v3] repack: do not rebuild packs on --dry-run
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, coygeek@gmail.com, ben.knoble@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

On Sat, 17 Oct 2026 at 02:17, Junio C Hamano <gitster@pobox.com> wrote:
> As a part of an answer to a question "was this broken from the
> beginning, or is it a regression?", the last sentence may have
> value, but as part of a standalone proposed log message, it sounds
> weird, don't you think?  You already clearly said this was broken
> since the beginning.
>
> This makes sense as an explanation on the differences between v2 and
> v3, but for those who are reading v3 standalone (which are our
> primary target audience, i.e., those who read "git log -p" in the
> future), it is on the borderline redundant, as it is a natural part
> of what you already described, i.e., return right after giving a
> list without doing anything.

Yes, okay, this makes sense, will keep this in mind for the future patches.

> Will queue as-is.  I think it is good enough, even though I did
> nitpick a couple of points in the above.

Thanks, sounds good

Thanks,
Siddharth
