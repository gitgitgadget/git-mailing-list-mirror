Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47A1E0DF5
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424767; cv=none; b=iRUwHEhwQhgXUQby+L4YuTKEno6iNbO70O75EjVgr6RM24Pzq4lHOUWcCzRWJK0bVLLqwFWL6i13R2RKIzaOxMtfsqnAdUEvKaaJu5uL1WDFVvDLeYagcVdevUwQBEJuKOo2xbaLQTpVsNFkLB5wxXcqY1ov8bakEa273O0fW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424767; c=relaxed/simple;
	bh=gmwTELdaYXyVFzlqkvbuwMq0RzmqA1+Tvoq0at7HkfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmtRPi0R7SZHblucAYbIgjbBag8fScyDOfGS9QjOA1m6va2P4Yb95F+OsQNtt4QtzyxPCJIR2sbpfgbsX3f3VRN+EVrJlwGHB1i9IbBNK2aWgDh8iOXe2bHomCiExRzGYsFIXHWkG/yieJTPR+uTxqoVSggdTrDnHk9D1zZEDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ci6Q8l5E; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ci6Q8l5E"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3bf231660so29614085a.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742424764; x=1743029564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1PZBXIkJy4rH0ipfYQmyJS0g3i6n/Z4a1fx+VdjAOpE=;
        b=ci6Q8l5EN/dUZWhZwpspLk6pXkMBMtmaH3F9e3krDjK+8FceyYvfGZJrWlDMA8qeNJ
         pQHcw8RxTuTBobILL3ZLj9zZAyLW51OEC7UDx/32xUYR6xk98U2/8tZgyiufnIPTukHX
         gSJ1sxroMQvZqgcrGkbjL2psGaA0/IOhh+c6NVlydM0VADTLLI7mBN+7Z+ZwnKBkjMtr
         KnWhopLINfqe00HBpXwYDRoA4lKIheJvp5FLgK4CiL85ly27Nse1W3q2HnCIsodw3iVW
         bB5pz45d6TMLrqU7hvogMVYo+pkRmgbYWzTQWMgrtp1vfx8UAR6vPcDdpKgVOgFlYzVz
         ig3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424764; x=1743029564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PZBXIkJy4rH0ipfYQmyJS0g3i6n/Z4a1fx+VdjAOpE=;
        b=lN2q4wc45n501ScSvkgX55KbdEqscmg6Mx8oG9ic3L+DzBleDREWwaaQlfNX226Z3z
         dxszioNz1hgJwgtZC4JxJvbqlzFGUP6xAPcGHofgW4LEAvVr/gZeX7O9vpWqgVqDd7+6
         Zs5jQquM7kNS0jzez6TPZCtfRbdmpTY5hw9TLt9Age9W6tjUwB/wUJwxpJIWvLho33Lh
         CWqLBs87IDKlAyx/3qyYYWRxxvUyM8m7wbmhkP3kBW6fobSAXeCchNht9IuA+b/mpyET
         vAyLMSYTg5HyxJi7vnW6UQaFE6noD1IXjK3mIuk/6MJWM15GI946+brXYLCFAdO64wQX
         dQZA==
X-Gm-Message-State: AOJu0YzUP8GA1JvgBLEdg+O5ULBcqscPO0GSviGZtqPuvsQ44P8PL22s
	uUBwdhX6rxev61/ziRw0dUT7LIVi2DcQgNxdxrTI303IcIqaoAaH64VLKq81QPSdIj5I2N95+Jp
	MFGI=
X-Gm-Gg: ASbGncsIWXGGWiThG0BWsTs+YSh/SZwk9Ln+z46iiW7ft9Vc+M4IjBUykK8jo5A3l/b
	PxL46EAtK/B1ipoKbH5/Jeha5EVE66oeZ/qFAmSLW/YboZRH/she7h4YCM0h/phr5NAPgs/H+XP
	AjqY3oDviTsloAmHNEiBb5IsPYRdthYEBNBy6fPuJkERGEv1gTYY8DQC2YHUGgnnBJrx8VRMUTw
	8tuduOsbyYIV/jtZJG2u9TSw5fCqCBGRuyxg3K6StDSQMhwphr2RMMJjibH1FxQay+htxcwnTPG
	NxbZQu8ptPN2tt2LEYP8VgYzTUxzl180W9mQ4ziV7qUE0FjM6CFTTeC52c2Xpd54RQIHwBWAEHi
	SwN896VVh92vLEUR6
X-Google-Smtp-Source: AGHT+IFpgQZbWHfe0aSaH4DdQ8Tmbn79PaKUksN9QMeJ9dYvHiyN7b4IWMSvggBwjC9JPObLG//YOg==
X-Received: by 2002:a05:620a:3903:b0:7c5:9a1b:4f22 with SMTP id af79cd13be357-7c5a84bd488mr691662985a.56.1742424764205;
        Wed, 19 Mar 2025 15:52:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d9253asm909171185a.104.2025.03.19.15.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:52:43 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:52:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/5] repack: introduce '--combine-cruft-below-size'
Message-ID: <cover.1742424671.git.me@ttaylorr.com>
References: <cover.1742252411.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742252411.git.me@ttaylorr.com>

Here is a small reroll of my series to introduce a new 'repack' flag
called '--combine-cruft-below-size'. There aren't any functional changes
in this round, and the changes that do exist are limited to
documentation and commit message tweaks in the final patch.

A range-diff is included below, as well as the original cover letter:

(This is based on tb/multi-cruft-pack-refresh-fix from Junio's tree,
which is at 08f612ba70 (builtin/pack-objects.c: freshen objects from
existing cruft packs, 2025-03-13) at the time of writing).

This series replaces something close to the existing behavior of
repack's '--max-cruft-size' flag with '--combine-cruft-below-size'.

The new flag is much clearer in its intent and function, and avoids the
lack of clarity between the two that was discussed in

  <cover.1741648467.git.me@ttaylorr.com>

The new behavior is as follows:

  - '--max-cruft-size' is a cruft pack-specific override for repack's
    '--max-pack-size' command-line flag.

  - '--combine-cruft-below-size' instructs repack to only combine cruft
    packs which are smaller than the given threshold. This will likely
    result in packs which are larger than the threshold. But that is OK:
    the point is to limit the size of the individual packs on input, not
    the size of the outgoing pack.

This series does break the existing behavior of '--max-cruft-size'. But
I think breaking backwards compatibility here is OK, since the existing
behavior was so broken to begin with. I'm happy to consider other
alternatives if others feel that this isn't OK.

The series has an interesting structure that I feel may be worth calling
out. The first three patches are trivial test cleanups. The fourth patch
modifies the existing behavior of '--max-cruft-size', but does so while
keeping some of the old infrastructure around.

That may seem like an unnecessarily complicated approach, but it greatly
simplifies introducing the new behavior in the following (and final)
commit. I think that this results in a series that is a little easier to
review (since we don't see a ton of code being removed in one commit and
then re-added in another immediately following it). But if others feel
like this was a mistake, please let me know ;-).

Thanks in advance for your review!

Taylor Blau (5):
  t/t5329-pack-objects-cruft.sh: evict 'repack'-related tests
  t/t7704-repack-cruft.sh: clarify wording in --max-cruft-size tests
  t/t7704-repack-cruft.sh: consolidate `write_blob()`
  repack: avoid combining cruft packs with `--max-cruft-size`
  repack: begin combining cruft packs with `--combine-cruft-below-size`

 Documentation/git-repack.adoc |  21 ++-
 builtin/repack.c              |  62 +++----
 t/t5329-pack-objects-cruft.sh | 302 ++++++----------------------------
 t/t7704-repack-cruft.sh       | 293 ++++++++++++++++++++++++++++++---
 4 files changed, 355 insertions(+), 323 deletions(-)

Range-diff against v1:
1:  0aa8aa65c1 = 1:  0aa8aa65c1 t/t5329-pack-objects-cruft.sh: evict 'repack'-related tests
2:  5e8bd3e66e = 2:  5e8bd3e66e t/t7704-repack-cruft.sh: clarify wording in --max-cruft-size tests
3:  b075ad8601 = 3:  b075ad8601 t/t7704-repack-cruft.sh: consolidate `write_blob()`
4:  7941997e33 = 4:  7941997e33 repack: avoid combining cruft packs with `--max-cruft-size`
5:  7f120c35e9 ! 5:  dee780a2aa repack: begin combining cruft packs with `--combine-cruft-below-size`
    @@ Commit message
         Introduce a new flag, '--combine-cruft-below-size' which is a
         replacement for the old behavior of '--max-cruft-size'. This new flag
         does explicitly what it says: it combines together cruft packs which are
    -    smaller than a given threshold, and prohibits repacking ones which are
    +    smaller than a given threshold, and leaves alone ones which are
         larger.

         This accomplishes the original intent of '--max-cruft-size', which was
    @@ Commit message
         But that's OK: the point isn't to restrict the size of the cruft packs
         we generate, it's to avoid working with ones that have already grown too
         large. If repositories still want to limit the size of the generated
    -    cruft pack(s), they may use '--max-cruft-size' instead.
    +    cruft pack(s), they may use '--max-cruft-size'.

         There's some minor test fallout as a result of the slight differences in
         behavior between the old meaning of '--max-cruft-size' and the behavior
    @@ Documentation/git-repack.adoc: to the new separate pack will be written.

     +--combine-cruft-below-size=<n>::
     +	When generating cruft packs without pruning, only repack
    -+	existing cruft packs whose size is strictly less than `<n>`.
    -+	Cruft packs whose size is greater than or equal to `<n>` are
    -+	left as-is and not repacked. Useful when you want to avoid
    -+	repacking large cruft pack(s) in repositories that have many
    -+	and/or large unreachable objects.
    ++	existing cruft packs whose size is strictly less than `<n>`,
    ++	where `<n>` represents a number of bytes, which can optionally
    ++	be suffixed with "k", "m", or "g". Cruft packs whose size is
    ++	greater than or equal to `<n>` are left as-is and not repacked.
    ++	Useful when you want to avoid repacking large cruft pack(s) in
    ++	repositories that have many and/or large unreachable objects.
     +
      --expire-to=<dir>::
      	Write a cruft pack containing pruned objects (if any) to the

base-commit: 08f612ba7000bf181ef6d8baed9ece322e567efd
--
2.49.0.4.ge59cf92f8d
