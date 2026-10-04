Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6415C40861C
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791152956; cv=pass; b=jz6sEW5CRsggXY1KdPW/Onov+ggyvN2mJWcFYhesVaNsz3kbSncjq+BmsVBPW0LbXiegYfEyDXh+MR6F1wMrIyO6+ex8+wzraAayOUPo6G6s4cIHsuOc3ovHvwTbxrv+73INGciyys5mKR0Q2ijw/QYRGSlCRdC1UkjVVSHsfOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791152956; c=relaxed/simple;
	bh=jFXkEAqsIFRqb+4oTtb8/M1SRnsbeZFEW+GMXy1gETc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsOq/Khm3FP/7XnLbenGQz3HZYCZKdbBOE5PP8EPbsTZyYsvaViMBdNNDMJ3sNwfd/Az5/ZoaxmY40tzbSFZTrnqVyFaxsfeuYmJGUijKJUan3+deZSXfyFbsSq5p1TpKHuv0Lrw5D5hU+mlL1SJOjfKA/72pHVJGGm4lFEl91k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDc1EUQg; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDc1EUQg"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e2050feb1so220787666b.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 15:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791152953; cv=none;
        d=google.com; s=arc-20260327;
        b=O4nQ+eJ/U4vfpvq09UaYWpICdOwilRMMYoCny8beHtxcyCybCcj5lz+nwH9iyefdJa
         ahlbd63JZBMTegjQWzfn6YwJgNmSngdYeDF/ZdKTqi3G5FTQXEXM2QUt4Enwt0YcgF7p
         B5RaQWrhuALa7QV6b0egaM/ipK2XGDD+dA5bh+5KZ3egVBslYOUYlQ9zlxGV+kCD4Mx6
         Bj+Q7Oib/D1BQsiwgk8+EPQ5HLSulGB3pNycTEvPHqc8+eSB8Q/wB1IvmoyQbQtrsADC
         vbP4eGtvDcM29FODCxANVbN4HwaQlnAClkDRe6LtNh8FxtVK96rUdUthbHRsQmTIvS+u
         f9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jFXkEAqsIFRqb+4oTtb8/M1SRnsbeZFEW+GMXy1gETc=;
        fh=enM17F3fRxx3D5YM0FVDlkLXb1+iOJabwBxiiXSFal4=;
        b=qdjGas9ZuwtvrtBLTWgfi2VQk5lTE7mol0oLGiCTqPEdK4KkPsvCp+hVR4ymmPATt+
         9EZ0N0ZZNgGeT0pY9kcIiKZuLmLzzrAEOf1JpOqcb14ti/4bCdGNeQ26oj+Hg4pXFqB5
         DxzVADKdw1L0ijkpFICcCnPfjW4/cc5IulfO79aBzyYet4iunE6zhH404LmEpRGDafW6
         zslLolY/TVt6zdVTfZpx5Khaq2OVsu0OVKuxyYfpwE6dRV3ZSTeCg8TnBMzHqe6DS30s
         tOWx2OpdLubeoRMLMMO1LwIo9QEIpIwk1j3ZIzcSj09JHoycaA6kpnJ3Cwxh/3ZDZfZ4
         YbCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791152953; x=1791757753; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jFXkEAqsIFRqb+4oTtb8/M1SRnsbeZFEW+GMXy1gETc=;
        b=VDc1EUQgf98EP8ZDJnS9V5TgeKcptMru18AWjjNJFzmS1tzWp8XBgjGhI8/xTolWlE
         H3mO6vrL+d9jU3ao1SD8hbHqyX6HwrV3CskdJWuIupPI4YI2zYgFV+TmUnpW2cKXr1qg
         9zozPhseP1zen5+VUt9yEIyv+qOkmceAEO7SIwZ9StAHLjI/aZXKHSk70oGFTzR9twCw
         Jfv7zg8XRbKnnWPFDwJB4kK9chQruzPBjcF37k/bhfTjVcGhtFulqy1x637T5+uaTaoM
         BYhJtorrxXAJw23Qsv06UFEOjU14vhkUn4vapD6PJ2UBR5nTIvgOUkZFO02W85hwB4T6
         bcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791152953; x=1791757753;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jFXkEAqsIFRqb+4oTtb8/M1SRnsbeZFEW+GMXy1gETc=;
        b=WEmY5B36A46I/oLi3m4TVS5e1+hrAj7i3dl3NU+PMMIKU1QwyoMs7MpulkCCsAZ8a6
         JUksHgXaJ9g1pRXAw9V5THfWvdTww0lO86cgCtvmvH4k+bC3wMI+6Lua7Uiar1nJkd1N
         COZ81o6vD1EH7rtKz2/MFKrAkIJnoSzjrCH9xMl7/CjtvVK5C5rirOa/ZbNTG8DEfh+s
         tu5e+krdP7+G2S4hBznt8QmD6jl9xS0wFJDs0jeRBvl8CUIsXkZoi+BnbSNI2817QRkc
         PI5p9VQQydv6fpXzjsTblPYLEnU9RHAsJUehBgdAa68w5Fa2DaGVzzXByVX/oUozOZOW
         N5jA==
X-Forwarded-Encrypted: i=1; AKwUvBxIfdn0yQW0NaNxmLejB4omy51djZZ/VGhZtb3NhDc/XrLcwz3rE7+hnkL5PYeXljM5awo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwm3XEYNX/y+dId/UFstwdUpofznj6oTBLkI0ydeDIn3pbG01Y
	5N6yXvBaFf2aCwxbtG4LNrPXUtJvO9QxuRkYsekhDzjPBDAZlE2BpT/QYWpoO8tS34RzDj4/TA1
	TpvGw/28i18OcF31rQHY3fHl+qEj3XGQ=
X-Gm-Gg: AYBFou03zbsQNAYvrQjNo60KqYDu76zcO34LDgd1TauQf8Sz2d88Rt0haGVgSE/ni3o
	X4V7b0U+lmNLySnhhnFOlgZubJ5m37q/XyXO7T8vrKJEE508DNTNFIYNPh0mS+0iP/lEmb2GsBX
	7HVTMefwQpGU6sUPwPqPkelmfGrdxe0qgk8rtFsZt9OpFX5jeWQF+Rrr9xBEXLRMIvpnL2bMqSq
	bvue+UvOM8Wn2O8NOgE8hbOEXbFabY8fbwATUuGbW5SScLvvefyOSyNYKPMf8wrzCcLXnay68EI
	griNPrJvqe07/4DOUhKrYcR1bFwfVprMz7eDTsjWJMyE0vruFewsjxw=
X-Received: by 2002:a17:907:3f87:b0:c2e:856:2a08 with SMTP id
 a640c23a62f3a-c2e4a9b37a6mr734249766b.1.1791152953276; Sun, 04 Oct 2026
 15:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com> <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com>
In-Reply-To: <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 5 Oct 2026 00:28:36 +0200
X-Gm-Features: AclHuK-OuHbA223Ms6RvJw21yJzJ2fD5QxhCO6i4N3h_wZhCndD1a5v_OXPKaa4
Message-ID: <CAHwyqnVoMnO_fYGJ0N29bQv=Lh5naZ0jc5uSpiS2urQMZVG5-Q@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> As far as I can see the implementation here makes a separate upstream
> revision walk for each branch, and recalculates the upstream diffs each
> time which seems less efficient than it could be.

Yes, that can be improved!

> > In the squash case, I suppose the best we can do is check that all our
> > changes were applied at some point between the merge-base and the tip.
> > There probably won't be any tree-same commits, though maybe a
> > (premature?) optimization can return early if the trees match exactly.
...
> If you know your repository only has squash merges that were not rebased
> it would be a lot more efficient to just look at the trees and
> merge-bases, especially in a blobless clone. Having an option to turn
> off the patch-id based detection would probably be useful in that case.

Maybe yes, but for users I imagine they want the interface to be as
simple as possible.

I'm iterating on the code on my side (sharing logic between branches,
etc) and it became fast on my local Git repo. If there are no
performance concerns then would we still want the option to turn it
off?


Harald
