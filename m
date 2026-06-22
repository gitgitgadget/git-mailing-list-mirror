Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0C346E7A
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154404; cv=pass; b=kmqmVyRz1fMEzxiDkaOFZJdju7f6mb3eogVUATeueF/rlWqiN6BC28PhWepNTeiW6/NJZPP00ytC7alg99Epo7C5QLNuPHmUBxgGTlA0JQlfqrMvAWJ5oQF/ZeNbI0bkZWOEysLYf713bOK2XCsUOrU60htMGu+9ERC+Cqyg7hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154404; c=relaxed/simple;
	bh=mPnpFFKrG2yZxkbc1fGFaHpA1FTxWlJcmvpf85rTbvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4IIyK7v67rQ4jC1P2tpFhd3QImsHTn5lmOphOqrfuwcaE0eITdEYDHc6XU6deVNVy6d2HmFbfB6X2kbUEXDTnOA3AtpgeogHIj7rSzoF0NyRiMRPIZIFrGk4MJxli/Vm1hwXJGlKU3hZCbqgNXGs4k129c770oDVnSk/T49OnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=FdHO+2xx; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="FdHO+2xx"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-662dd616cdbso4952302d50.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 11:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782154401; cv=none;
        d=google.com; s=arc-20240605;
        b=SGSILUo8DEIQkM8CWJf2jwu3JpUpBvWU/BrR1tC0S1JIbkv0X95Q6s7ejMHKLfCQiR
         K04IxSUyWhMx9rjqUywHZk2FRUVcb579x93Z1yStzJlLzxlBFjq6IL0tUak7bH4lWAxJ
         2uzBekZiEVPgU/qnGUSVcs09Z5dAZ3QJPbmYFSwMDh+zxzfqaZhTM2Anrn1nRFfhmgDr
         7AFXlfQNypAt99CRO5epBxGzsMOq9lnEAA9OXolWAZaA3099h9Dp8pYucIxj4zm+Lxnz
         CP7LOd6PIpWGxv91FXf65QUNd4d1WUlqOnxJzxFuCPbeW0zgS3LdhbITHek0hAfQXEhV
         F8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mPnpFFKrG2yZxkbc1fGFaHpA1FTxWlJcmvpf85rTbvM=;
        fh=dR3pU/XLzbScAjm7LXJKg1ZPAkGzQjgu306KjUZbl9w=;
        b=fLTCui3PuUyUSbVi6NZHLQ4d8q960FvVHp+2GamDI3+7xhF8PvWl5OAzujX85tle6t
         v0jXJGZssXaUiIhGqWOyQbA9XQPbI51hSU6LvsorIm6NzaOqTc0T7TOgKr6i0Ad6dKci
         0/Jy9AmXMyZP+uiweJ5ojc4B3YTkZWCQx//1TEU5HSa34zevoiAw15lGsSAO8AELaP5k
         cLWow9w/wn/vkyJ39vwkxF3tSBMoG/YKrWB8DLR3oXm7MssMSEKuYloEtgYGYHtzc3hJ
         UxF6BryzFR8tpsTTe1vytAb7mPU6YAopq5V+IsOIelPz8ZJv7w3W6TovBHvq8bc0Bt6h
         x5tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782154401; x=1782759201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mPnpFFKrG2yZxkbc1fGFaHpA1FTxWlJcmvpf85rTbvM=;
        b=FdHO+2xxoZCdAjPzQ7zWrjDa7qcIgWDVnQH8zqJi3oKuu/R4XGn494QED80hlvG8mQ
         mT4GNN1NNWCxGoeYcsAXyO+67cCrIf7FjKicHw+JnbdyTuaNS67dtkrbO5lRjlANjn7z
         3izXvBo947/wZ9a2WtNa9YpRSlB+ChFzB96hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154401; x=1782759201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPnpFFKrG2yZxkbc1fGFaHpA1FTxWlJcmvpf85rTbvM=;
        b=BxoHFt5j5gRRQCi0rEI3ty3iCc/o0tLV37Car38AVEdusKIz6C2pO2uO0ShAn4GFW6
         DAq/HwvQtvAOxw1KX+42dAb9qILJeL8WWz0XDmeSZ7shudgWdD/c2EgAKPIZLInq39IC
         sfiZQBcNjjeBzGWF6DvW5Eqc/rM1ERVpOQIYPVb0ySHsGIQQk87JMaxyNggOd3pmF5Rc
         PcwAhaW8emhlhqYEIhRunhRN38qftl5/QrArxsJulvfokC3bp5EPq87Iv1bojL4jtxCt
         KCAKsc+uYwIlpBeCqzm5lrE/8z64AJ6Ms5WOep9rULgXRTmih47anUawh95B14HI20cK
         /bkw==
X-Forwarded-Encrypted: i=1; AHgh+Rrr+LU5bp+kEhC4o5kaOgg2oNwkK99Swxo0AkzBZxVwUyK4ezNr8ecuN1RfjsdAFWABC3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+beDdkVGwUo3BXAfHvhYXCVFFYQWcrL8tkvmKkAggV+sOedYb
	iHfTjdr38SlvqqhvODejIMAyOEVNmAiYfhxfMyROajNS8Z/Bt2zgyLntMAYBlpYynjlMFLI0u1o
	/R+CeUANV5YVqlJPVwEMcRG2H/DjRYDKlglmHSpRCng==
X-Gm-Gg: AfdE7cl24lItN6a7FLi1wn+epcW3W7cuUgCu3F2+3oYvRyQI2bDKajyCjobc2s7XU1L
	ik3hN/uTQ5hdXzGXLQECI9gKvCVLpdY0Lnx858y6E1tUFymuTANeY3DIkT2KY2zj/QIyLFom6Ei
	V84K3Gd/aIDiQPujAh7vyUx6vxuCyC/0po06eJoLzvvin8rxJFnmsv2NDXGHfvcdZJqYQav6UxB
	WGwQQZoDVrpN0Zi7J0mljIgELvyeJIe3jE0XnaUEEdCd3E5n+xDoA+TuL8D/dAZ6v94zMxoMg==
X-Received: by 2002:a05:690e:12cb:b0:662:a4ee:104b with SMTP id
 956f58d0204a3-662ffe593c4mr14319580d50.48.1782154401174; Mon, 22 Jun 2026
 11:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <5492acda0ad05eab67198880a5262e84a3f22ba6.1781951820.git.gitgitgadget@gmail.com>
 <001e8da6-3232-4cfa-ba6b-35d3489e4779@gmail.com>
In-Reply-To: <001e8da6-3232-4cfa-ba6b-35d3489e4779@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 22 Jun 2026 20:53:09 +0200
X-Gm-Features: AVVi8CfvlnhL_-EK7UUf4WevKbyGVMewOHlYoCtyxOnDlcwX3sOEtXkRDBE7odY
Message-ID: <CAL71e4MuRXDs_vB7UWq7kXmUVhDHOCv2jKM0NeAj3Cofbt5hcA@mail.gmail.com>
Subject: Re: [PATCH/RFC 1/6] commit-reach: decouple ahead_behind from nonstale_queue
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 at 20:00, Derrick Stolee <stolee@gmail.com> wrote:
>
> This change is only needed if we are intending to delete the nonstale
> queue struct, which is currently happening in your patch 2. But we
> are essentially recreating its logic in a more disjointed way here,
> leaving this code in a worse state.
>
> I'd rather see patch 2 create a _new_ data structure instead of
> _replacing_ one that already works for multiple callers. (It does
> drop to only one caller, but that seems cleaner to me right now.)

I can definitely do that and leave ahead_behind unchanged for v2.
I was thinking that with only a single caller, and ahead_behind
being simpler than paint_down in this respect, it would be
worthwhile to simplify it, but if so I could instead do that as
a standalone follow up (though it may prove to be not enough
value for the win).

Thanks,
Kristofer
