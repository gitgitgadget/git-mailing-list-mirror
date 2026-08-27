Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83B3D093A
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869436; cv=pass; b=Wg+/6a5DTjjFVLoA9QYKK5+HiZWCYiTys9h23AGjZ4ter1fipJmfq1Lbhfc2vimJ3AmcJLNAH7CBV1vbqnY+aMvsEwni1y3sinstTvJH+QZ+z1UIUwcP6HBAkaVUrXkqweA7KVCVVsH6rsXunxpK9JzuZ7cjo+YIs0AnrOYir6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869436; c=relaxed/simple;
	bh=GAKyG3bl5JMfp5juJ/HZV4kgFSyjDGj6YD2hjPyxEb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSrByW9n1hI1qaWz1p64MwHTINyrtjvIagh4Edzx6PDlnELCO8svtzrQlQnO7zyAp6TVgAWA7wEuWKmH+sm1TLgHPvSDVjYdvD6iBKmDUWh37Qxpq4eO1ynzP0qQ6T65SWdaJQ3+9xTWMsqSCpCQNnnnDpw5J8T8FyQj8k2mEQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+W8CIlA; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+W8CIlA"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-495c49f8eccso406162b6e.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 15:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787869423; cv=none;
        d=google.com; s=arc-20260327;
        b=TT33U2QSO8cOO4WN1eYKlwaxgQBVZYZD6MxnHOMRj4/Wj4xrdUhAnmQ7BtoRgebtce
         zxbtx2X0uYon4g65iMQyq9y7RIcPvZgFcg3T1OA714Wa+YrId7Px/cecg8QtmgSHNJhO
         09bsm1d4KUB90aZqqXj4NkKaUolLEfTxo4GUzwhSHq1pxh8l/tQvRKvWUmFl6trJzeDS
         kl1HZ8S8FXucvDSP0+lUpXIvyxGQ7CbL/oZ3Dut2hyMs72wvRvxD0cBoOoYWvIGf2vgU
         RzyTwmiq+qqt8tCz0cU7bxhRdnsxliCgWwPaFESMf0ONwD5DQEJaesMYDCYbUF4Njip8
         BlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cqLsY9c543+LfLjpVCB0RehheX+qPphaRzYHKznco+U=;
        fh=mvcUsIs4eCjloLhnzVIuHYE614KnBwBSceXQWox9ur8=;
        b=Uyp3T/W7wrGEgTnW1r2LnGxhK6jbOeXs21YnazHXJ4/GPMGR1V2fTneJUIYxeawsHD
         UW0ezTS0nsaE2Ynzy9JXoXp4ijwd6JjFEX6R+xuGq3Sl1xfCk58GcJEvQeiVkTOYpMT9
         WU1N+gwc64hM5elDpSXxBiIGTZOuD/bT2ItWr6Tp0iF5XGdRHYNDXzcG6ElHHuRJkRJD
         nFCSHVU22vpZ7xmpjViEIVn3jjKXqcp72mBVCL/3fM9c6PluquHEYVoJ3KDHGxZlmjW/
         USCWOf1xmrt2A1CIPboUEP2P5vVm2Bt2X2d+VmeVCRqA28GtAcaFSwMH9txXwuLw7jeu
         1i6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787869423; x=1788474223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cqLsY9c543+LfLjpVCB0RehheX+qPphaRzYHKznco+U=;
        b=r+W8CIlA5lVokGs8InrDAFrMwwYEg6hGChX4D9RKa+sRExB6r1QzE7bmOQ73oEdtud
         Mvja9ro6/kTvC+l1z8tA1xSl3mSaDDLKr7XgCiStvTg7yZ9CLm1iNG0VqqN3mAVRMzd5
         VvP/jH39nJAiupNA77U+/qyufsuF9TvtZjwEvjZ+ga2z/G3mxctPPDdf7t0VdPSgilcv
         R0xqf6PCQFCP9ZX+DX3c2jLJBaBjaH/woBG9SjZM1NATHlEqs1Mq4yd9qEG/AH0dFEvb
         ad9RJuMdH+1h7qjp/sviai+NUCTmY0mASoxlIsT6TU6pgBzNoWgLWSASA/cqrhRLrzgQ
         kOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869423; x=1788474223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cqLsY9c543+LfLjpVCB0RehheX+qPphaRzYHKznco+U=;
        b=FfW/fD/FRfIg+Vz8xuDBjcaykJgtusAw+WzoGIPovpW/4lRfGx/WmU+c6mOTDmbCuV
         UOZ2ezsnKQidRPh9uXxfQP+a5Zh59YUqYeRj7gnEWwGu3SaL1JWxOMEzu7hS/J6Kngl7
         MpT7ItMQNjvH7Pjok1qmBTjpcIpVR8sCYaLzVG4IxzQ5MW8C6je0BLKDdqYecupVtiJY
         rPpFr/vWb7cn+chW00R/erXON4vJ7ZJ2N6ZBE6lJ6sv3+XnDGJZ2Ce4vNQtr/bLVekcw
         EwuZ53GfQLuqUI3gczGZhaKt8vJPOXrtbWLsKifHLAu3q+B/FcPPiWCYBx/fIVutAz3j
         lnVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqpF3r4i6dL4cNFBfLGbk9Md9MQFrFzgC8LMzQTDL1PEAW+PbUSnL9PwhDp2sEYWgX2m6c=@vger.kernel.org
X-Gm-Message-State: AFuF++liPBv/U1gcCcVu8jNj0L30M2VnAD5w6acpEU/ciL9NLllC6BcD
	lDm+Rkx18j9yWKHBElrh1O58cBwxsTJ/XRNtytF2Yc4RZc6yf/sGpmq1BJn8ugyIrm3RPQiBRMt
	A5rVuP14uFxubuZfV/r0PXRsu2xuLNBmerg==
X-Gm-Gg: AR+sD10tUnmmmMPt9kZEIwbJYx0bqF5M8H2xcCTdXHupqNQg/C/X7f3si5KQHkRLrTV
	xhSl5dDEGsjQAb2QuKE/Lkq6k3KxS/FOUlvKZ9LbJRTXdO6YdAyBgaCJ79558kyssuxP0xTOili
	mRIbVuuS+jAVGyunF0dFYcZFvLtQ+oBU5ISCKNAavop7p2U2mVfnBfTuln30/jUhz0OR9UwtIf3
	M+PkXVvmzuwK1eqGlNmPGYE6gfGYOHlZHWg3HqI+YY/KiVfd8uLi3gQZmXfOO8vrw4DMLrHWF66
	EdoK4dFCbn8k4UbZuN4nQ1F/G4ZAo98H4QS3uhu6lyEqHofYR/U0Y/I52r2t2QZNR8U8XsON1l7
	2pMpYxoW0SFP2Nd0/h3GnZgW/GDo5ruBebvFAvIh5BBj1Uar92kfCT9VkQi3IDdnsjgF25zw=
X-Received: by 2002:a05:6808:17a9:b0:4b3:79b0:8481 with SMTP id
 5614622812f47-4b3983537c2mr2975577b6e.19.1787869422651; Thu, 27 Aug 2026
 15:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com> <fc98f48ddb4d46cad66a40ecdd96c139e1397784.1787684429.git.gitgitgadget@gmail.com>
 <20260827055743.GB189659@coredump.intra.peff.net>
In-Reply-To: <20260827055743.GB189659@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 27 Aug 2026 15:23:30 -0700
X-Gm-Features: AcwNN1XC3ixq7kZYdISu47h8lhi07XZHzCWsog379lnESGy6R5yz3Xsi3am-K1E
Message-ID: <CABPp-BEmReAR-f-aweM=f=5QhRPxG1K-KLTsbyRt2aDQD_QnVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] packfile: recover object lookups racing a
 concurrent repack
To: Jeff King <peff@peff.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:57=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 25, 2026 at 07:00:28PM +0000, Elijah Newren via GitGitGadget =
wrote:
>
> >   1. open_pack_index() fails, so we print
> >
> >         error: packfile <path> index unavailable
> >
> >      and report the pack as unusable, even though the object still live=
s
> >      in the replacement pack.
> >
> >   2. A normal lookup recovers: odb_read_object_info_extended() issues a
> >      second read that reloads the on-disk pack state and finds the obje=
ct
> >      in its new home, making the message above mere noise.  But an
> >      OBJECT_INFO_QUICK lookup deliberately skips that second read to st=
ay
> >      fast on a genuine miss, so it does *not* recover: it reports the
> >      object as absent even though it still lives in the replacement pac=
k.
> >      A resident reader that resolves objects with a QUICK lookup -- suc=
h
> >      as the `git mktree --batch` process the tests below drive -- then
> >      produces wrong results.  Even where a spurious miss is not fatal i=
t
> >      is not harmless: `git upload-pack` checks a client's "have" lines
> >      with a QUICK lookup, and a dropped "have" removes a common object
> >      from the negotiation, so the client is sent more than it needs.
>
> Maybe I am still being dense, but this description does not make any
> sense to me at all.
>
> The _point_ of QUICK is to accept those false negatives. It is the right
> thing for upload-pack to do, to avoid re-scans for objects which we
> simply don't have (and don't necessarily expect to have).

It's far more likely that I am the one being dense.  My rough line of think=
ing:

* We see "packfile ... index unavailable" in our logging
* There's only one thing that remove packfiles
* Investigate the mechanism
* Look for other affected callers (e.g. mktree --batch)
* Consider corrective measures

Steps 1-4 above are probably fine, and step 5 may have been where I
went off the rails.  My thinking there, wrong or right, was:

* It makes sense that we don't want to reprepare most of the time
* ...but _if_ we know of the existence of some specific packfile in
this process and that packfile has since disappeared by the time we go
to open or read it, is that a special case?  Should it be?

> It sounds like mktree is wrong to be using QUICK at all. It comes from
> 817b0f6027 (mktree: do not check type of remote objects, 2022-06-21)
> which rewrote a call to vanilla oid_object_info(). From the description
> there it probably should be using SKIP_FETCH_OBJECT but not QUICK. Or
> possibly it should use neither unless --missing is given.
>
> So I don't see QUICK itself here violating any contract (even if it
> _could_ find the object in some cases with just a little more work, as
> in the case that we were discussing for v1).

I'll drop this patch and instead send a small mktree change that stops
passing OBJECT_INFO_QUICK (keeping SKIP_FETCH_OBJECT), so mktree
recovers via the normal reprepare like every other non-QUICK reader.
That removes the packfile.c changes entirely, so both the
reload-under-QUICK hack and the .idx/.pack raciness you noted in
pack_index_is_missing() go away with them.
