Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3B15A8
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728260495; cv=none; b=lAiysWs+CXQERkGPx0G8pRwlKH87rwftmH/fBNuoRHYlyBVgyGb+AyyjfLNqM0zTLGJdZqKhDAI32xOZkNzSqxR8xFuBeqmj2FftaoJDQL0g/4Gysawnin4032YERNN9EbdyVVh8M0BtbrpLMg+eBRgYzyJjVhSjhol429nxmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728260495; c=relaxed/simple;
	bh=zIXi5uJ4gOliUhq47c7dJfq3y34KeVRP7tlQwP1vqdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geL9K/lD818ynXj3e+DeBO7+qVL9TMEB0um+UNAOh+HmBmWZPpK7T4yNBdivNWU5Eyj2byyj7DnGGVudtM7Ln7J836RlOucaNm0aU4b1HVGYEZRAl0CquhJAqLcQt6CcMnsNPh1PweXP6E3PdeRleIfmvCAGxSaiTbIL23SZ8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com; spf=pass smtp.mailfrom=koordinates.com; dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b=Z15SlbwS; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=koordinates.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b="Z15SlbwS"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e77c6ed92bso2457397eaf.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 17:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google; t=1728260492; x=1728865292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q4VM4fHJfncIrStJS1sm2ZrnhNps942Bg86s+nvpvYc=;
        b=Z15SlbwSHPyxlj7FHs0IyvpjHTB8YglxdlPKyccsXcWtWrOyLLDK2CVeu+bS7juRy7
         Tm2v1tHp/DhXvNN/O0gXZ2kPjpJU+v1HIHC1OSyCak/y7fy4cTKKWHx0nPApvcDTBmyh
         nWy8IaEmZU5yFgtOMfx4djc36VZ/S7/gpzRHCpt7hE/fMkRp1rvjQPrHxwJt6Dt1VEV1
         lWErqljee8Z8cO59pI9KpAwe+TQjiW0xPwjubDuR7RKTF0qFxAE9EoRvaqJs/CoJwGkz
         OlLhUcH18fzyhtHGxOhGqytxBw9eelMk3hYZ0rp+tNZdJUBo+AUU1JJRFyziAlVOyzE2
         FvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728260492; x=1728865292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4VM4fHJfncIrStJS1sm2ZrnhNps942Bg86s+nvpvYc=;
        b=HR40TXwc3rHDe2Y5AJQ6nKr0KgcoRr1VUopUoQkbNfyVR8FsHzPTtZEDUkbnYktSsP
         36kPxJqlNoEA5l6jHhEXp+MAFfZoLB9CT9ik8YkqTSqx4wqzJ9xlvk88TBHWxZ21HFZi
         6X7LDqDnU0PwSQyS4SpwrLCflw/qpp8juz9bZPz9GUPZaykpdkhtZrFAyV8tDV6sl6Hk
         NCkJe3B46iYuKuLE14OUxqF/obrjjgbkp8atvjo3v2dUGxlov3C+d6jydWoczqFLsBQZ
         cPgnfUgRXMVTgG3zN3jpshlZeNO8ni0Ui1Hw7sbbPdnc+UnztCN+wEYEWw3H87wVCuD5
         vOFg==
X-Gm-Message-State: AOJu0YyQIaG59fVhK6C2RWXvQSxvRuvGA6oEzuSCAtIr+7t18ChG2Mzj
	DnhPPuNCd6h3cnVuk00kNdV2s0LTaHQBCyCcnRBXSCBlnYXXq7uA0jQ8A5tIdMDbXg7BI/6Y21F
	XuP4/pAKWYrWYmiaR4KwEM56/WGXB3z72J2W3rg==
X-Google-Smtp-Source: AGHT+IEzhvpIy8I4jYeLflJWvyDo8cEljV8LHJjh0r3iu40FDBVAIO0aYMraJwxfWF+kJ/MBVQ7E7CbUaoF7q5QuYTQ=
X-Received: by 2002:a05:6871:14d:b0:277:fbac:1f71 with SMTP id
 586e51a60fabf-287c1d3ebe9mr5860561fac.3.1728260492434; Sun, 06 Oct 2024
 17:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003223546.1935471-1-emilyshaffer@google.com> <xmqqset8c0o7.fsf@gitster.g>
In-Reply-To: <xmqqset8c0o7.fsf@gitster.g>
From: Robert Coup <robert.coup@koordinates.com>
Date: Mon, 7 Oct 2024 01:21:16 +0100
Message-ID: <CAFLLRp+Y1hO6r7mfdghS0q3EyfJhU_e43Hzi9PXgF_EuF9Fuog@mail.gmail.com>
Subject: Re: [RFC PATCH] promisor-remote: always JIT fetch with --refetch
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>, 
	Han Young <hanyang.tony@bytedance.com>, Jonathan Tan <jonathantanmy@google.com>, 
	sokcevic@google.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hi Emily,

I was the one who originally implemented --refetch in [1][2]

[1] https://lore.kernel.org/git/pull.1138.v4.git.1648476131.gitgitgadget@gmail.com/
[2] https://github.com/gitgitgadget/git/pull/1138

On Sun, 6 Oct 2024 at 23:43, Junio C Hamano <gitster@pobox.com> wrote:
>
> Hmph.  The whole lazy fetch business looks more and more broken X-<.
> There is a comment in the refetch code path that tells us to "perform
> a full refetch ignoring existing objects", but if an object truly
> exists, there should be no need to refetch, and it starts to smell
> more like "ignoring somebody who gives us an incorrect information
> that these objects exist".

Basically --refetch was originally designed to send no 'have's during a fetch,
the original motivation being changing a partial clone filter and fetching
all the newly-applicable trees & blobs in a single transfer.

> The documentation for "git fetch --refetch" says that this grabs
> everything as if we are making a fresh clone, ignoring everything we
> already have.  Which makes the change in this patch prohibitively
> expensive for asking each single object lazily from the promisor
> remote, but is that really the case?

From a very quick re-review this is correct that it's expensive: refetch sends
no 'have's, so if you pass a single commit oid then it'll fetch all ancestors
and all the dependent trees & blobs, duplicating what's in the object store and
relying on a repack to clean up. If a commit is missing that's one way to fix
it, but it's a pretty nuclear option: feels like your option iv (terminate with
an error) leading to fsck invoking/suggesting --refetch might avoid
unintentionally recloning the entire repo.

In my original RFC [3], Jonathan Tan suggested that --refetch could be useful
to repair missing objects like this, but it was out of scope for me at the time.
But maybe there's a way to improve it for this sort of case?

[3] https://lore.kernel.org/git/20220202185957.1928631-1-jonathantanmy@google.com/

> Emily Shaffer <emilyshaffer@google.com> writes:
>
> This manifested at $DAYJOB in a repo with the following features:
> * blob-filtered partial clone enabled
> * commit graph enabled
> * ref Foo pointing to commit object 6aaaca
> * object 6aaaca missing[a]

I presume there wasn't an obvious/related cause for commit 6aaaca to go missing
in the first place?

Thanks,

Rob :)
