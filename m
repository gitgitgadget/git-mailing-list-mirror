Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8119CC14
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 02:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770518059; cv=pass; b=k9mEFn+oN4LWpNdMZPrUTWD1pxw5MQsOowIE6DxoBMoYMr1rn4K3STvHN3twNVpKvh5kFYOh7IFvEiITGrvJDnuZHQSChHgwhLSLGGFVrA3QAls0bvbjbl21wkMX9q5MRdQCGu0k7UGSZyP234bBc+6gyQyRlM3o0tQPx1fi1js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770518059; c=relaxed/simple;
	bh=gub9liULB4aasCfLoqbfo2fjk36sAOV/IoDX+9sKNGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmsaQYOEX2nzyi1lIgHnfAThvYskzB9NnZlQD6XS61RZ2NYdl/4PH+cg3r3tFp2f6q+/V+Er/e5WBDvurwSqfuYKDil+/H8jtzGVpVcN9vq7aO0kBDMjUElPzXavJ1uZbXZsoWUnoBDc3YZZG9SecqXTRBT1T8JqyW+LqinWm3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ng6iJTDi; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng6iJTDi"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c62239decbeso691687a12.2
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 18:34:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770518058; cv=none;
        d=google.com; s=arc-20240605;
        b=Gb+4w4qB2lZf8CVBogUPUP/OVtKJtk+q9uTXa1KZ/gOoYaKiguOyPTKsQoz3IcriqP
         vKSpjROuEdXEzI4kTIOCg9FSsIKHtKTMQTBqAn0CcSW+JwxYX6UCRAV0OHj9x96LmKnY
         jWBt9/uMejStumBTmY4tzZLVaDTz/vqVIry7VQasiL70nSnaoKy2G/FQXRatLy62f4pB
         JEfRcTYa3WPM0ELuojz0soeEzvLpmPqbRAQXK7MduTFpyXdctHfbV3ZaFAVotKOUZp6s
         msnpNypabH5PCUxDnUlGuYUHULCu/sdVzFbIAeR1svxg8B4u1K5R+LgeiOLFJjIaz+gh
         FPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xBKRHFgBuVyH7Z6/5n0m+6Ku3W8xMC8Zz5cs7uJQr2s=;
        fh=gufDFpp/YKRKGLb/aXsvmgwOEw9HXGp/ynRTMJheky4=;
        b=i1aJb30M94OAFgYnqZt91ZN6uV2JA6gkzyHMtbZoVxG15gtS2WDIoWPkv5fPLqlV3X
         PTpQm0aF5f5mIVQ43ptlpdw6xCLxkQXuliDhsqlaIJWr4Q0bt4b4F0Evv/9yLi2R2s+W
         Js9mBGp2fV79HbBA+Md6bVPUEsWl4ujHCTyGBCeKa7fsmIx8BqJHwvvm/H6HprUVbkCK
         W759oAjvo9/ZZ/sta/GSGx2ekzAgEAFL7d8UaU6pXvay5c/NpfciNmy0LZsTIDlcFM/O
         Gp4iCLc5pQLVYGlLslebv6r+NNpauK14mHeCmAKg1xigOzmiD0jVTsNUgX3MPRSGVbLi
         Bulg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770518058; x=1771122858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBKRHFgBuVyH7Z6/5n0m+6Ku3W8xMC8Zz5cs7uJQr2s=;
        b=Ng6iJTDilvxQduFgyqX9m3c6+XrdKl8qq+LlEDMrNw4DCKqvINpV8Pw3HuN9s4KOh2
         wZTprTz38io/yW05z1oUPxoJAh8AMyz1cimiPBj6Idfe7Q5v0787+UewjmyclRg9r/fy
         sChectW+Bqtwce1LTp7YMv/VOHehk28b00ldb8TSM8l2iLCwHK3lHTu10Q+LQWvRLqlU
         1kRJSn3QnH9KlWf77jw8CbrlQ5bXol9mjABjoHZcRG4nBTq/XVBGwkc4KIHwVS3naAgn
         L5mQRqkk3Hcxa+XYCskv1zZCHU6duR3s/jZ/Q2vs+qhTK9GKBbf9yTfya8Ux5Z2qe8uj
         09uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770518058; x=1771122858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xBKRHFgBuVyH7Z6/5n0m+6Ku3W8xMC8Zz5cs7uJQr2s=;
        b=eMfKGPlXSxdZu/XSTXclYJM3ND0XPrAuZ2VFY0bQrAlm15zRvPkr5F4iJR4BpFcxnX
         Q4dQFB2tJVn5vxVUc5zVbbu5ajBwZbAF5H6u7yk/V7eEIsQUBVeOxopTZfr+mvechAi8
         5Lm8INALG9j4x3exykNQvYdQG06dUNGLblOF0ogXw2oxmHB8CGHj2mBScfo4456LRXB1
         2XicTUc1B48getX5D06CLzHGdik9ftwNwk3u2+0QYfnLrpDb1eKinWz6dD695LuX98nK
         rBeR8xKPb63Mq7LEOg0HBiRtNM0s/u7TtUQM5nNBp+JJ5kZg+PWiI0jod1m15gd1j8DW
         iuSg==
X-Gm-Message-State: AOJu0Ywm+Z0VjdWXaWWdr3T6fFabHiZy5Pags0MEJS687WIEjRRx8fJ4
	9KnVxEr5DKB42pu+k4h3DpPZkRER/sEm1vX/AfsEhr4NMoFJ2IWXGvj50RfkSfymK5fK9RM/GZX
	YBxdxev22fOveGeW6OvRC6q5+ZnLLtot5Lg==
X-Gm-Gg: AZuq6aJls/unGqkj2g4CgGV5GwGJXy63Xfzyb/TY6rsY3vSIaYk6766Brwqge4hLtDm
	5Egmgx97fSXdPP5qYuigb0MYVAxGvneTU8tbgSaaR1RaPC7w6LZAUK99nh9m/+tiXoq1zuMDnhJ
	aEWYTa/xTEWRQt66px608PNIPSCzOvCGjghsdcamLdi8TiTb2nmNBTevGlzUcPlmh+0qvmt4bKf
	rBmDnAe+i7rdL7DIjk0YEvkoRonbDy9NknAP2PvL6SbUoYBOji2rEHcGRyPG+wGIjbdGmq9l7CH
	2ifRDQkO1L/3+ns7jrRXmhdFugsmGpjJ0pPKsqRLmVSD6RYNffarMKzc7qtv4PxXjqcupolzNW9
	4bUeBkfDGapWKXQ==
X-Received: by 2002:a17:902:ce12:b0:2a0:97d2:a264 with SMTP id
 d9443c01a7336-2a95180ea22mr66311265ad.37.1770518058506; Sat, 07 Feb 2026
 18:34:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_doc_patch-id_4.275@msgid.xyz> <mapper_example.277@msgid.xyz>
In-Reply-To: <mapper_example.277@msgid.xyz>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 7 Feb 2026 21:34:07 -0500
X-Gm-Features: AZwV_QhdEQ75O8NErgx4q9uuAV1Z4Q9kTDtaNcWBd8Atl5P7TVC9UQYl9TMRp7g
Message-ID: <CALnO6CC997noiLAFmsy=4DCxc-d5CzaJew0Ri1x6CUtnL4kLXA@mail.gmail.com>
Subject: Re: [PATCH 2/3] doc: patch-id: add script example
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 10:07=E2=80=AFAM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> The utility and usability of git-patch-id(1) was discussed
> relatively recently:[1]
>
>     Using "git patch-id" is definitely in the "write a script for it"
>     category. I don't think I've ever used it as-is from the command
>     line as part of a one-liner. It's very much a command that is
>     designed purely for scripting, the interface is just odd and baroque
>     and doesn't really make sense for one-liners.
>
>     The typical use of patch-id is to generate two *lists* of patch-ids,
>     then sort them and use the patch-id as a key to find commits that
>     look the same.
>
> The command doc *could* use an example, and since it is a mapper command
> it makes sense for that example to be a little script.
>
> Mapping the commits of some branch to an upstream ref allows us to
> demonstrate generating two lists, sorting them, joining them, and
> finally discarding the patch ID lookup column with cut(1).
>
> [1]: https://lore.kernel.org/workflows/CAHk-=3DwiN+8EUoik4UeAJ-HPSU7hczQP=
+8+_uP3vtAy_=3DYfJ9PQ@mail.gmail.com/
>
> Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     The script will not list the commits in rev-list order because of
>     the sorting.
>
>  Documentation/git-patch-id.adoc | 38 +++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id=
.adoc
> index e95391cd255..19780f86425 100644
> --- a/Documentation/git-patch-id.adoc
> +++ b/Documentation/git-patch-id.adoc
> @@ -68,6 +68,44 @@ This is the default if `patchid.stable` is set to `tru=
e`.
>  +
>  This is the default.
>
> +EXAMPLES
> +--------
> +
> +linkgit:git-cherry[1] shows what commits from a branch have patch ID
> +equivalent commits in some upstream branch. But it only tells you
> +whether such a commit exists or not. What if you wanted to know the
> +relevant commits in the upstream? We can use this command to make a
> +mapping between your branch and the upstream branch:
> +
> +----
> +#!/bin/sh
> +
> +upstream=3D"$1"
> +branch=3D"$2"
> +test -z "$branch" && branch=3DHEAD
> +limit=3D"$3"
> +if test -n "$limit"
> +then
> +    tail_opts=3D"$limit".."$upstream"
> +else
> +    since=3D$(git log --format=3D%aI "$upstream".."$branch" | tail -1)
> +    tail_opts=3D--since=3D"$since"' '"$upstream"
> +fi
> +for_branch=3D$(mktemp)
> +for_upstream=3D$(mktemp)

Do we want to delete these when we are done (via trap or just cleanup
at the end)?

> +
> +git rev-list --no-merges "$upstream".."$branch" |
> +    git diff-tree --patch --stdin |
> +    git patch-id  --stable | sort >"$for_branch"
> +git rev-list --no-merges $tail_opts |
> +    git diff-tree --patch --stdin |
> +    git patch-id  --stable | sort >"$for_upstream"
> +join -a1 "$for_branch" "$for_upstream" | cut -d' ' -f2,3
> +----
> +
> +Now the first column shows the commit from your branch and the second
> +column shows the patch ID equivalent commit, if it exists.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> --
> 2.53.0.26.g2afa8602a26
>
>


--=20
D. Ben Knoble
