Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC87B61FCE
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758324710; cv=none; b=Om/bNlDRT9BPP3C7I8iOrHHYG7JcDndhUZJkBaPadHcU+sypvw/1HtGIrZXu+wdwgvqft7A1gXLsPffV8E5UIeGmtfyjupSVp4oc+TwitVbM0QsdI1L+SoJ3lKRdX5rpPkX5KZ+oXxBCTZvtOpHuKiAiH+H9HMC9qWAc2yp1UmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758324710; c=relaxed/simple;
	bh=OyPVd/4WKPCzbNmm6k742y07GdRdQWU1N/pESa6IRjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUqx8txtSiLhK3dm1uxnz71b38jo06+CI+55ZZGyPSQfDEs2AMEGxAkDb5N69HfNJUg/V8iC/lnNJ2GX8/amWxy317YnW7V2M43KLRKA3rk45Er93Wl2Kp4jjO8vxJH8Loahi4oKSkQ1d84K+NEjR01Zu//gDyy3S5e4tmEKXo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDyAddCi; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDyAddCi"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88c347db574so89467839f.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758324708; x=1758929508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x/iTg9WMLl6WctwJjHobIiXLNMTxv2+7EubZDZL8iQ=;
        b=QDyAddCifOGrDQPECNScg77G4mIrcZeEC2Ge+HwM+mQLHl6zNsll0rR7+It9AY0qWe
         Y/2fwwg/C4BZGAJJeUow3ONGWC2CRUIAsP1D/XXVieQnP/P8K0Aeu8ZKG3wFaCrdE9Ra
         0+a3+7pDET3vy/LgNt3zhRDusyvsthcU/p2C+MjCXcotS+f0wUXxg+NUok2yot4mtY53
         yKPc+q0p/xXDgP2cA1VfODJaaHkkqWOfwywefjYu2O8rQi8Hjwa9ycbPDlWCMveDuTht
         /ta7MErDcs5jd/XWsVbVmIM+S9g8rLrvJ7ID34VHWvNHPvOK5/x7908PqVKqMPUtejxu
         /WOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758324708; x=1758929508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7x/iTg9WMLl6WctwJjHobIiXLNMTxv2+7EubZDZL8iQ=;
        b=WKqOInvHUvWtP/MKUaw8cUzUMJGNLDWEU3MPYR3UZrPrTBgc3MgqyAzQ/vWHs4e5Ph
         hx1/tTZV+EwylM2/VjIWD7eEc6jAVGtlAJIvQXoj5cQv0hNwip1QTb1wZs3Li+VPU+pY
         R8coJULvgNjK4hnGIS4eziUuOJBv1uJji5xF81DXTen+kl2m/w/cZUH0dQ86aMOwjCVd
         j5QkhT6CSLRm64htMWM/WfL7sXhT1rD/BD2Q7eFtumt4FF8dT9SZ3u5R0k56qau/5HQG
         OadwVjOyJnkw96thToyi5wcSA3aajRDRSObZhfumipNfLGfDu4rz5f9o7j922W9VWV/U
         0OwQ==
X-Gm-Message-State: AOJu0YzmnwDn+Dhei5Q3TL9vsQuFWRlz9ZE0/slN3ihEEGBxU2PlzkHG
	/w3jWt35Ze0dsO0uwGhv7c60aFZKx8VpLx+8hwE0wRVR7VZqoebp4USczheuYWhK08NQK8PSJ6G
	srXlOY3GzxikLxjJORXxrB5C2mP+q4Wo=
X-Gm-Gg: ASbGncviTNgQvjtUSAOFp3zfCwzilLh0Wm10FwWKdk+7DsajBAyGqzShZYWuLfPi43s
	RKXqrwIS1uD+zq7Ds7dko5JzBUKoxqC3zGZl0HIvH8JPFFX1WnSrlqCjN2r2cBQksEv5pevBBDQ
	mYIqDdcR+bJTRdD1mfLVmQbLEJTQZkbOF7ePzoNjmSPaPyNL3MuiW5kW/ASG0mQfHHvAEASD+a+
	O8aldT4/n5eC2GdYuaRD1B/9sIMhitxs9RsMAZifw==
X-Google-Smtp-Source: AGHT+IFN/9BgMw4VYBXwCfOBQWZBXgHGZcoxlDX0BmsKpSzOMCddDh8fKTlyoKTvTTAFPi7VsnAoP+XKBeJS+caBVMc=
X-Received: by 2002:a05:6e02:170d:b0:424:80c4:c8ac with SMTP id
 e9e14a558f8ab-42481929d72mr89226195ab.13.1758324707787; Fri, 19 Sep 2025
 16:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com> <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 19 Sep 2025 16:30:00 -0700
X-Gm-Features: AS18NWBvVT2S_-xtJmTk1E3rAdxSFARHn6O4hVMjhCgMeshFCo_jXjD1ce6uVcs
Message-ID: <CABPp-BEjX6Nw90P=sgaSVrKLJX9HW6A8P0fyadBD0snURc10fg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Cleanup xdfile_t and xrecord_t in xdiff.
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 8:16=E2=80=AFAM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Changes since v2.
>
>  * No patch changes, just resending to get patch 9 to show up on the mail=
ing
>    list.
>  * A few tweaks to the cover letter.
>
> Changes since v1, to address review feedback.
>
>  * Only include the clean up patches; The remaining patches will be split
>    into a separate series.
>  * Commit message clarifications.
>  * Minor style cleanups.
>  * Performance impacts included in commit message of patch 8.

I read over this latest round and it addresses all my feedback from
v1.  On top of all the nice code cleanups that this series provides, I
appreciate the new detailed performance comparisons in the commit
message in patch 8; while this series as a whole doesn't make the code
appreciably faster yet, it's really cool that you've highlighted
another potential performance optimization (beyond the hashing one you
already highlighted elsewhere on the list) that we'll likely be able
to realize once you get some further preparatory refactoring done.
Looking forward to it.

I think this round is ready to merge to next.
