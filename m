Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8F13DBA0
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762628930; cv=none; b=oNqGgECuZfrhrueGQoGeb/emVisaCbAQeZOz9Dc8++jZLDez3CE3opcWqQvr5V7fxmcaI2tVLyi2R+OpJDkJrW6Mf9j/JNUZJMMlZoRW2RkLl2gCeid/lS28QgqaFS945ADdHHUnYQ2IK/NjS3xNGnYI6P0sN23Bfl3TGCWWZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762628930; c=relaxed/simple;
	bh=UJJc4pRf3fo7vUzBwaM0v3seoTBJBa6b1+NNv8aRHlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SIa64gO60wjOJsY7vd0nsgv26NUv+KbRZTXO7siNt3Wm/WnB0tXj/aYa8zSNF9pDyeMf28+2Cn4L7h1rc+hzJ0o6ThmxMfv42i64EnmZQtz5sYpvuRWCB9YScEcNsBtiKOyTJEnrgKXDUU0ZSbP/6TtGc37zqf0Fk2a6QagV5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvNQF+l3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvNQF+l3"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3436a97f092so1115817a91.3
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 11:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762628927; x=1763233727; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLauOQwh8/5cRLiypkCq2YN1Mv4qH1OUjqDpZdmoFIg=;
        b=fvNQF+l3/JDlB/99cnNh8dIgbR0U5LkhX7z2z5oUOxmcanwwijEqKdEABLgkz+5/nW
         xc8I88Lc9O6HNfnbwQdUAUw6hkxY+WpChEmAeXKWNc83rd9Vn9D8YsLW4UfK7yBLk8RZ
         vZ2r3WTZ6Pw+ozAUf270nGUdXCRIksAgRw+/XNBCZZzH7LmSTl0Jp1Ciw35NY/f5Pu9Y
         8L69Ob5pxyeEvItkRhQpRKyR7NsvTmFgxYUNP5yqg4Bt3nK2RF4mLusj9sdH1w2qk73U
         brE5yIg8dy0PbN5D2HHcSKxANKSGQu913XsHKcaLzmOfUDISKgjNzY81uuISxwxHi1xs
         vCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762628927; x=1763233727;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLauOQwh8/5cRLiypkCq2YN1Mv4qH1OUjqDpZdmoFIg=;
        b=fPyLS1heuyHM9yXR3mEUtUF1Mm7bSqlUnaCpgBTM9ZeqR2k+JSVs/EMiSXUCwyGV9t
         MtgxzPLCd+hxwQcAAwinm1uiqliNdEehHX/jJ0cE1yAT1GQEjmXcUYbHOblCfAeZc0J1
         x6M3rYJBvdHfXdmerpdPikHzzsJ42KzenSaw6Z7d7QAFvf4II7VfnifJMwihpxf6JoHQ
         /CKjDHVFrOcshWxf+l1DhblvkUEIVIgQ8dlQ7NWkicHrnoTznnmkuEKdJT0bvI5UeuLF
         Ihu7a6KSKHUzSr5f4vBPSyZOxIWAZ4/il0cmamXtsU9S1OfCQey2Fx/hGIfktBGs5fbk
         vm5w==
X-Gm-Message-State: AOJu0Yxv/9fzAMgHdGBWoCu7n5x5D21pkkXwYmaO/xRHlWhJa/H2Ack3
	eLI5BLi6T4i/Sh4FThMIjgeE/ExqX6O/q6iPS/QK1PMpdXmUTmL2M8qHm2R82iWchICYOzSAV+9
	O947JQbbeGUokKP/R/TDCJkAKOyct2SPTnQ9V
X-Gm-Gg: ASbGncvqmAJu1mwwor+axvXsh9gd2tgHiOdpGNoVPkbfbrsIQ+MaKT0OECGhAz9D4KT
	IPGC+DeNiKuULQ4j0KwUT+AuMWsqZZWGZdpzMOu85gUR93n2YIQirYOAKC0/ATzk4X5WAUga/b6
	mLAcMZH5yhA3lGM8+Hwzz/xTiL6Vsa1x0wxrZSgRxd68Lt2tPPM4L/27jOhC+H6vK2lv2TQZ1RC
	1yxv+c0wIOFsgPBVGD0dieaMRmIZyfNf20jSXSdDLEqVmtybQJtqmevmADymzaItojKpx3bhHWZ
	Y5vfLeQ=
X-Google-Smtp-Source: AGHT+IFZ9OtTpDXL5sFOz4uuLIPWUXf/yGIPBpMlBWjS1IJRbofNXuwZm2XwOCp1SjShheWMDVEASbWl/cZ6TgtF9ko=
X-Received: by 2002:a17:902:e545:b0:26a:8171:dafa with SMTP id
 d9443c01a7336-297e564cef9mr47839675ad.21.1762628927409; Sat, 08 Nov 2025
 11:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
In-Reply-To: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 8 Nov 2025 14:08:35 -0500
X-Gm-Features: AWmQ_blp13igoNp-sOuGvw5omg_DZO9_nUIuSL9id3OhvFmMqq71Rx6eDc-0shE
Message-ID: <CALnO6CBsXEpeCTS=FpcOvXEOw7sNGT8fdb4Z8PBewoW0iRMnXQ@mail.gmail.com>
Subject: Re: diff --cached --no-ext-diff --find-copies-harder --quiet exits
 with wrong status code
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 2:05=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com>=
 wrote:
>
> AFAICT, you need all of the mentioned options to trigger the bug.
> Allowing ext-diff works fine, I don't think it's triggered in
> non-cached diffs, and I've never seen it without --find-copies-harder.
> Notably, s/quiet/exit-code works just fine.
>
> Here's a repro from git.git:
>
>     cp git{,1}.c
>     git add git1.c
>     git diff --cached --no-ext-diff --quiet --find-copies-harder &&
> echo 'this should exit 1!'
>
> (And of course, ^quiet^exit-code if your shell supports it yields a
> different outcome)
>
> Context: my distro applies a patch that allows
> diff.renames=3Dcopies-harder. In a repo with that turned on,
> git-prompt.sh stopped showing some staged changes.  Turns out it runs
> git diff with all these flags (less --find-copies-harder, which is
> enabled by the config option). I _have_ confirmed this bug exists in
> unpatched Git, however.
>
> Some rough debugging notes: when entering diffcore_std (or
> diffcore_rename_extended's cleanup loop):
> - for exit-code, diff_queued_diff.nr matches "git ls-files :/ | wc -l"
> - for quiet, it's just 1 (the first file listed by git ls-files :/, AFAIC=
T)
> The only other obvious difference I spotted is that the "quick" flag
> is turned on for quiet, which makes sense.

Ah, woops. The reason this matters is that, after diff_rename, in the
correct version the queue is non-empty and has_changes gets set, which
plays into diff_result_code. In the broken version, the resulting
queue ends up empty, so has_changes is _reset_ to 0 (despite
previously being 1?)

I think I also spotted a difference in diff_from_contents, but not
sure if that's relevant.


--=20
D. Ben Knoble
