Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792849779;
	b=GdR5sg6OG+NpMpfswoxheeFUyALoXVh+XmqXclvA4r2BTrzhU3BRibfaElIMKMKRju2I
	 Nr0fAjEDPxPjxCIueNsMQcMIYDvdiTpiFwacIU3l1V2PGdGmXBDPmVQF3LgQHl4UQxkRY
	 jWG2Bk3VONCHOzSbwx8sYEAlkzOGTszFJLwHMwe/U+nDkpH7VAHq1eiSJ7+ddxf/rKkNz
	 5b0S3m904c4XHPYRBPUA3q6YsgmeBg3mIyE+OspQbuHR1JG3JUmqfCnBAmtMDWIv3XUJr
	 l9saJH6TUGULjBPBFUwMCAKMZkWO6ds24uv13WvpuapL4C8SHjSoHOXcHL0pxRLr6/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792849779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fRNztQ9slKb0sQvv/6HMi6fGYCSWzwDjovpFpTPxUBc=;
	b=eZaw3SaYqFLihD/CxYQeLoJN4wHAwikdW7hsbR7fBht3mxC0xQHlF6VRoBEHfVhZIAYs
	 qDSrPuek/OLmvB+2vwERFU6tNWoBDxYSLUmzk5lVKwVjwtZZEuqgw2tgfeaPVYHt2jsl7
	 XuXjmSO2zlEDwyY+NjXk+sTFM6oUptfBrZGJS/DgNrOB4NxruHMgpO7uspVdi6Xg+e9MC
	 +6BkyoQVk74cTuTKvdAucS7N7EwhefQKCgMM3QFRB5yoTLZDJQeJ2hOtsgl7nPgE4qik+
	 vfHWW3k+3Teb2hjZDOS50GNo4HaGULCQSxLcedbSIqnzR/IWukEQ2oIkRQRIQXugasA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gGjaznY4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A054606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 13:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A054606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gGjaznY4
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a06c60065fso1374352b3a.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 06:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792849778; cv=none;
        d=google.com; s=arc-20260327;
        b=OVHwL7HFL5Qx7EuU02kF57/4nYyFMkxwOg9/yYIvX9vks18wnjzWnZnFh4fPNLPkSQ
         PNUwYh+hcbolsUI/nfpbBPuCYduTyXIlBmhdSK9Vm9KdNyZXnlY/HgOE6Dc9hWfNHaUT
         CLvyfXs1C7tcz9oEl5HCwfaHZQb0cmSBIwphCssmLRYaUO8COsR5LUmi8GpYXm+ieaTR
         7BuQQ/Ju3asr9PEttUxIYG4nVjysxWe5Sv2emUB3NBiM5Qd2lVs8j+hKcQiUVAoqNLVn
         riQ+Pdl/w1WXP7DM+dpZ8WZxHeQjXotZxE27yGAayYTj8TkgQVb461MO37VjSlGFQmQX
         6GNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fRNztQ9slKb0sQvv/6HMi6fGYCSWzwDjovpFpTPxUBc=;
        fh=DB3dlBjaJH+ZUZnFZCcHfvvUHBM4Dd4zykfu039Yx3I=;
        b=FiiYSFbhk4mHZgtUOCzMd+crvdRia+7UzWU2EmqykBj1TNNINbBzpLaqUnG6fxh/1Y
         57jv5b3tDRqxV2XypJaE39SoX8kbRGj3s51DrCUJND/z9KBt/znATq3b78b6mirPsD47
         UyLGl7wza3jnGTb7Wkv752Rhcw3k3dv1ZgHqjKxY+CvmDhaYetWtyKKgNrY7D7YNnAqu
         2quzNIO+VJF04km867ihVF5ojb1Elm9L3aI6G6T9Kze/xwWDmSuzeyck3F7zjuQgqxAq
         xBO8aZ8pLU/3puUQPoFCEGKpBZzRWNnBkdkiehGcMq3hpaLMMnpJfTDqa75n7OalOke9
         pRLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792849778; x=1793454578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fRNztQ9slKb0sQvv/6HMi6fGYCSWzwDjovpFpTPxUBc=;
        b=gGjaznY4dKOJs0djp0Lks5GiYiJCZXD3yXs/FEqGwQ6o3PFb++wgwrGLuV4hnqL4DT
         yceLkdo+SXP5nCK2byXuwGi+gThI28ToK8+/J8lI+3uqz7j7xhvxLKX0ZpIonCe18uyG
         AFDouK7Pq8FY9qRArX0m9HSK8lwpQqfrNxIzNeuY9s6gtahMbiUodKoOVZRgfnxeVUSk
         mHu9MWxiHGAqvB0MxhUifq/1NMDskOHFQRKcKm1X8Pfte3wixDX41WJ4H8YGp6W2A6nk
         NFD8JvjwCDU8uAQnNazoBnxZRyKbYTDO2pPm5/fqf8/32x7PQdidDuWavCm6TrLxxesi
         tqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792849778; x=1793454578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fRNztQ9slKb0sQvv/6HMi6fGYCSWzwDjovpFpTPxUBc=;
        b=DRuh7AxJFuOFlKou35anX+L/Krl1dlLwvmY7o84WyK7O2/1LZSjAHHIPUJo96gwn+K
         TrAeasti+5OEZ9oFPsyc5/ldXqoGf9JST2T4O2CkGSSAdvjMjh1ta7Rm8+8W3Gyiv5MB
         /jHuNmPujr3aRMUN4DX7g5v6D3YJKV035/BO0jIjmMHokorI8md/tTNeYyD4ijgIEsMO
         FgvHi9E7cBPVpu0Ef+aChxmHPmS5qMejVhm0otaZi1kguyl5Z1660J9+xUnpn+ZHTxw+
         3IIoL4VazPIDWDSD4ThkvoktYwjSMfxq8shC8BWn/gwKaPW+UltkuLKJ/6E43MEH7YTb
         zZtg==
X-Forwarded-Encrypted: i=1; AKwUvBwcwZalqf8hipmjzpvQXPhj4m3km/FO9Ri36cLgZkWxzZFW3jy98Yq3UOIJK/MW6YXW7rM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcj5oOtSubyUYKhr1Axhr9VkP3nct1k+pp4n+WdS18RYib2V5p
	9yCnabNAM6dJQx5dVKATrstp94NIs2LAfVnJOD6MgBqSYyICLoLJqoRZngBU6X/KY1041MCxXt9
	jwrRf7ZhDRZ9Oc02b1K5XpX1CiNJua4o=
X-Gm-Gg: AYBFou2EjhNQrqd82mLCpO6QtbcJOQnNBnNqlR23fEk3dkvI8cAhvajFBxm/7GcTJj2
	g1jW8M9j33ONh9D5YiN3Kh3refP/cIrnbHa18WkOtL80cwwM/sgCRAN5evWwJdkMl64B0GnW9+6
	5tcLqHt6VApg1agv/Ew+4n0KAeJ2nZDYLhZmkKUXAv+5IWRDY5Xtdv+PQM8uf/ryyFXtKGVf875
	zmh/RMbXMvAb+9rob+AFlRMQDAWQrAfH734BrQX8uxTJ8x3zHGd1kwfLGcWIYjFdQpr1HnBRquN
	6TFTA7xUcYdaFYxA8l14v3HM4nGxw/Px76yOll4GKXB8jMvL8ClzyQmYZ4xwsXdoQ4fkwje47u3
	s2Zu+62BFX8L0if6mPo/0ZgzjC4lsAJFm+pdxUryCEXqbj1P8le/UphSUxWunCmVZJMQxEWo+JG
	y4eFyNdZh9iZ4f+DoXeVDvScLBQtble55TkUSK46II9xuAxeaZZvng
X-Received: by 2002:a05:6a21:a91:b0:3e1:7249:e265 with SMTP id
 adf61e73a8af0-3e7bfa41069mr1518552637.27.1792849778162; Sat, 24 Oct 2026
 06:49:38 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
 <pull.2458.v2.git.git.1792585662669.gitgitgadget@gmail.com> <xmqqld7o71ot.fsf@gitster.g>
In-Reply-To: <xmqqld7o71ot.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 09:49:26 -0400
X-Gm-Features: AclHuK8FKFkc4ZpXhhuAbH3HrY7HGuOmPq6ooQew7dsebLNn0oBpUHltd2D62bQ
Message-ID: <CALnO6CBD2aGg_wDZZsT-mWJ99MXYUycx32JfsK8zJXfcmjTBDw@mail.gmail.com>
Subject: Re: [PATCH v2] status: compare against both upstream and push branch
 by default
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 1:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Showing both without any configuration was the original proposal for
> > that commit. But some found the comparison with the push branch to be
> > noise. So the comparison was made opt in [1], with the idea of
> > flipping the default later if people like the option.
>
> The key phrase here is "if people like the option".
>
> > Those who find the comparison with the push branch to be noise can
> > set status.compareBranches to "@{upstream}" to get the old output
> > back.
>
> The presence of an escape hatch is described here.  But its
> existence is not a valid excuse to force people to use it, nor does
> it answer the question "if people like the option" posed above.

I agree, though I still support changing the default. I think we need
to make a stronger case.

> The paragraph above (and below) also assumes that comparing with
> @{push} is not noise for many people.  We have not yet heard a
> convincing argument supporting that assumption in the proposed log
> message.  In a triangular workflow, @{upstream} is not under your
> control, so you may want to monitor its progress closely.  But isn't
> your @{push} destination typically owned solely by you?  In other
> words, aren't you the only one who pushes to it?  If so, whatever
> you did locally would be the only change that could go on top of
> @{push}, and unlike @{upstream} you would not see any unexpected
> work over there appearing without your control.

I think this paragraph assumes that either

* I'm only pushing new commits to @{push}, or
* I remember what the current state of @{push} is without checking.

I may not see "unexpected" work appearing there in most cases, but I
certainly appreciate the reminder when returning to a topic after
working on something else. Have I rebased/amended/git-history'd lately
and need to force-push? Do I care about the differences? Sometimes I
already know the answer and want to validate what I'm about to send
out, kind of like "git send-email" with sendemail.annotate (and
multiedit, for me) configured.

I have a number of ways of helping answer this question, personally:

* git status: only ahead-behind count, but lets me know if there's
anything to do. I don't actually check this output too often myself
because I built the below prior the config under discussion, and they
are focused + finger memory---I almost always run short status when I
do look at status, but that's because I don't normally need the
verbose output these days ;) That's not the case for most of our
users.
* "git sbup" =3D show-branch HEAD HEAD@{push} HEAD@{upstream}: a quick
divergence check
* "git rdup" =3D range-diff HEAD@{upstream} HEAD@{push} HEAD: a detailed
comparison
* "git div" [1] runs a triple-dot graph log (with more options)
comparing HEAD against @{push} (if they differ) or @{upstream} (if
they're the same), omitting some other inferences and ways to supply
which topic to inspect.

[1]: https://github.com/benknoble/Dotfiles/blob/master/links/bin/git-div

So, I suppose my point is: as someone who almost exclusively has
triangular workflows, I'm already checking this push--local divergence
on a regular basis. I just built my own extensions to do so prior to
Harald's welcome addition to status. Perhaps that can help Harald
argue the case more convincingly in a proposed log message?

(Julia and I discussed briefly off-list whether "git-div"/"git-vee"
should be part of Git, and I'm noodling on whether such a thing might
make sense as "git log --divergence" or something.)

--=20
D. Ben Knoble
