Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA43EDC
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720319456; cv=none; b=NLiu+e1bQBp+DlawQTSkQpTcrG3oVm05qNvgI3o4HI/yDnC5IrEz0uBzzuRKK7HvAI9XnyXgogsmGLVHfq4EaeZxYM0NdxNKt9yY6qM5oqSNaYg1i6B+3xM2r7tIIjANHkXxagBzvQMcAlch3YsqyVfxyAtoXO5IeA+y4ahOBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720319456; c=relaxed/simple;
	bh=xGEALbsmW9oo6of5IbCcseejpcTzRgu89wmYQpvOTXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAwYGEMWgjLz6pKsDFnh1dQupBX08i7hG+HJL6LEfMG4RmsSJ1I9sMibBGhJ/1BTDYvpsQCpdBJGmgdAlPEKBIZ4oFnvSLzpwXwWCs1SLkZQaJx5qLpCjhAB93n9TaOx1k4eqV8vN4nixIOXWTTt+1VuiXpCA0VObryRmMxFRNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0ZR5c4w; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0ZR5c4w"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f30f3be999so294681e0c.3
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 19:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720319454; x=1720924254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DU5p8ccCC8UxfaVHaDccG2zmn1vxFZfQid3ZNM7yQv8=;
        b=d0ZR5c4weRhfQsIp7X3X2QhQUuYuDle/UOo2x7+kiwOcIjd41D8AXxzMDprbbYh1wF
         nJcXHlTVEq6FGIcvuEE/JoXp3WAcUeSDhs99HUL3EAWv2NRgHSSiPHaswOmrqetpH95/
         Hh9XlowmJ7O9xAOSoVRFtYSMlrJuRvIwPXA7nAK/Pu/6TBUYPKBrrLCLjawMHrstPPl1
         n4LI1t4Xpotfofbp+pR6lLHTi7UyJ4emPrT5dCsGN7C0qC0kgFyLa6J2tMlwVM0gcMps
         ShgAFw1aonmpCPugmKJBAmucdgZtpeamI3jE7IKsJgr4GUrFl4jNw9Z+YJ83N9Yr1Xq0
         schg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720319454; x=1720924254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DU5p8ccCC8UxfaVHaDccG2zmn1vxFZfQid3ZNM7yQv8=;
        b=pYQBcDh44JI5jjuO6+mt9dW7/FrD9fUZIQhC6yBgnj+Ci/YF27XYAPiTuTU6IXyCWC
         QtRb1T0SMI637yx0mOfO8KTy9q1NR3vhMFsm5wZdd1CnkawW3WaQ8Iw2XQLo6yL6sxUc
         tbUE6YzCURpKo5GDeMEX2u6nQT+GZpvn4ajs+CWO52+Z3nvvkVyn4FlR7vcxReQplxZc
         7LWWeO0x8M5zPTodNagQDStJ32QAWq6M18lRP2HzyNADC/xRDJf2dpkyJcBF6u+ZuDcO
         YnTvyeHMVv5OSI9xo7JdGPVb8L9kb9K1bkUXm7EHx0ey3zP+EkYnJApLNFyLE23GQCpY
         cEBQ==
X-Gm-Message-State: AOJu0YwAbFXgr595X1/+5A97RakjqEwsLb1mRdsF23mJ3gmNjwXVInIz
	reqtq3zLxnddvHWdyl0Ockj3wl5Zbp51gGvUKDmTpyIIA6CR8/Lg6hlW72BRkbTeWDZlyV9Ac0M
	L4BoIojj5GOVkZ5icyqv3rUS5zCiRVfZUwhc=
X-Google-Smtp-Source: AGHT+IGwH1cN8TIqgYWx1R016OKCv1Z7Q2it6GWG+7JqqR4hnRz2LzPxBy5Nbmf3mD8Dk8kcqIfMftP7VJ0Hxg5e7Qc=
X-Received: by 2002:a67:e897:0:b0:48f:bbf3:b8b5 with SMTP id
 ada2fe7eead31-48fee651c52mr9491209137.7.1720319453952; Sat, 06 Jul 2024
 19:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1757.v3.git.1720318768439.gitgitgadget@gmail.com> <pull.1757.v4.git.1720319311301.gitgitgadget@gmail.com>
In-Reply-To: <pull.1757.v4.git.1720319311301.gitgitgadget@gmail.com>
From: rikita ishikawa <lagrange.resolvent@gmail.com>
Date: Sun, 7 Jul 2024 11:30:42 +0900
Message-ID: <CAKPZ46fzz3PyLhSXU8RrzfBbWSSH34hcLz9wVvErNsfF6vH-_A@mail.gmail.com>
Subject: Re: [PATCH v4] doc: fix the max number of git show-branches shown
To: Rikita Ishikawa via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for sending in consecutive messages.
I changed `From:`.
Thank you for following us often.

2024=E5=B9=B47=E6=9C=887=E6=97=A5(=E6=97=A5) 11:28 Rikita Ishikawa via GitG=
itGadget <gitgitgadget@gmail.com>:
>
> From: Rikita Ishikawa <lagrange.resolvent@gmail.com>
>
> The number to be displayed is calculated by the
> following defined in object.h.
>
> ```
>   #define REV_SHIFT        2
>   #define MAX_REVS        (FLAG_BITS - REV_SHIFT)
> ```
>
> FLAG_BITS is currently 28, so 26 is the correct
> number.
>
> Signed-off-by: Rikita Ishikawa <lagrange.resolvent@gmail.com>
> ---
>     doc: fix the max number of git show-branches shown
>
>     Changes since v1:
>
>      * Explain in the commit message why "26" is the correct number.
>      * No change (to rename GitHub and re-send).
>      * Change the author of the commit.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1757%2F=
wonda-tea-coffee%2Fupdate-git-show-branch-description-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1757/wonda=
-tea-coffee/update-git-show-branch-description-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1757
>
> Range-diff vs v3:
>
>  1:  c1e236d843c ! 1:  76ab2f17015 doc: fix the max number of git show-br=
anches shown
>      @@
>        ## Metadata ##
>      -Author: wonda-tea-coffee <lagrange.resolvent@gmail.com>
>      +Author: Rikita Ishikawa <lagrange.resolvent@gmail.com>
>
>        ## Commit message ##
>           doc: fix the max number of git show-branches shown
>
>
>  Documentation/git-show-branch.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-b=
ranch.txt
> index c771c897707..bc31d8b6d33 100644
> --- a/Documentation/git-show-branch.txt
> +++ b/Documentation/git-show-branch.txt
> @@ -22,7 +22,7 @@ Shows the commit ancestry graph starting from the commi=
ts named
>  with <rev>s or <glob>s (or all refs under refs/heads
>  and/or refs/tags) semi-visually.
>
> -It cannot show more than 29 branches and commits at a time.
> +It cannot show more than 26 branches and commits at a time.
>
>  It uses `showbranch.default` multi-valued configuration items if
>  no <rev> or <glob> is given on the command line.
>
> base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
> --
> gitgitgadget
