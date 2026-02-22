Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA4DF6C
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 05:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771736600; cv=pass; b=IMI44REwaC+Ran478uIcCepczdgzbbln5C4kR41Kxmv7NIuOpQBVBwPkLoIswRDmCJae5wmJBGXZjQgOFt+8GycxGvgMr1m04JvyaKbKNv1r5BVQVj6jvvBznFP4BRAjD3jvra3R7E25HzkI+Vydwt75WSYkL8+OL3WeaYOaykI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771736600; c=relaxed/simple;
	bh=q0Mf11BmCeluxDNYigeT5X+E7l8VFO9+v/4yTAs/Nmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qS9TrRRlwC6tOX4HcKnwTeHPNDtsjpQf27RNUmUm8xm863z3Wx14yqg6rYsKFKzKUmia7TGgDBq/w3xiD+kVjbw/v0GDuceuZNLs3fN+oby7eDfmnkMJEF7+nqTx3klxtuMyEqejFKxo4PSaeCOoScJ2ZCinQvBIY2gipX3/0+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHkmptiY; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHkmptiY"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d18a9d2b1aso3180639a34.2
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 21:03:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771736598; cv=none;
        d=google.com; s=arc-20240605;
        b=F77iYIV2l21U8pAmucN7AO4JE/ZOiIbzBDpKC4wUMID05izrwiL9qCoAabYLjMkSid
         fLHQ/RLRUKknL3jB6nPLhdBRfx45WfbubPFiGPoDeyOIUPOAdM96n8DCw1hG8U0jXr+m
         9yeQfjZBSA1yDqviCsnbZoo9zUsnqjHL8vXMSubOhCvE/nuS0cLT1Gz9+Zodug01qoAy
         DxEBalwQN1meX9c93HeI9Y28Wo1XO6XTdG5YQ2EKU2MU8UOY6DIGlA0NpCetoPmS++ww
         SP3CGJer01tpdYivKlweJ8KJSNbAvWw0fCXl8RqtOUgGOh7PbZO2v1JL/V7ecW2X+u5o
         wwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XzoYAPL/4fbLTJuhPmtIJQ/FIj7cAIMusKKrMUukvkM=;
        fh=5oCIUwhLyPaS/wWfhFbmODtYZk0T5T8OqHRd5o33Cgs=;
        b=NZQgXlEw4V7m6TvM0BO5FtsUiRbZKQ0PzVwybJWYeGQHp729iEvyg/qrGmprbXWfy3
         mYyXwDPCuPL9v66bTAOomTt8PySEnqDwd1n0Oa5U0kOEs+wg3+DXwNdQbRned0Wlib/U
         duu4nAjq/XDmox+V+y990pD2wUUuTMRTDG1XAYEYKAq3A62TdahtAN8XrlVV/cr6XDXf
         N9PKCOZDgxCQE7ZVTcCY7yn8hqqOeRG9njHSVrbLmaeqzZlWdxtGzxg2BJYFC5HjAAsF
         zxdgbzPEf9uVmQTFQJtAvYx2nRb7g1LjZ2rRFrEReVJTl2AbAbSYTZ50m2jy7861dzAg
         qpPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771736598; x=1772341398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzoYAPL/4fbLTJuhPmtIJQ/FIj7cAIMusKKrMUukvkM=;
        b=iHkmptiYBzv65xoWxl5YKWDpUB+iaCB/ER/6qAQJKebPQ44zof0v0icmkBcDIJ/tzr
         L/zr10k9EF4ZMtpX7Z3GMlMsVM3Twu3D/H26sQim3R7ie6JKMNKGq7KKSnV72rRhP8DJ
         iv2AcaSM9gksM6J5CvnbR0WuFkW2iyfKbuBn3Gqgipx+bIY2VSBoiLD8iXUEKbHG9/Y/
         pAjJNT1/g2tC5co2xITGibzGo4YFmApoM3dpEmKt47XCoQFfZI6V4ilijYbOc0kLwJVO
         h2BPwhel1ac+LJMUU5Bq+pXjDqOcpA1M1LzZ+3j+BB1H1aOBA7a5ukadzC76KLZnvsWP
         DgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771736598; x=1772341398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XzoYAPL/4fbLTJuhPmtIJQ/FIj7cAIMusKKrMUukvkM=;
        b=Xvj3TxHJiyVlNHcc07OK263SR7nPlyRoPpMVMWKM71u/piY6ojWsHuGjjp4WUUsSZW
         WiL7uLUUmobIVtvFCcFl0E2cxTOaUDCM99StIP8cuaZ/NW+aKRlpLcY4BzLYdZu/e5Oc
         FWbR3Udt2qvB66jRfGkvEDQGnLwcHUlAGcEotaqwLVc33mzEYsk9iHcov6+87q4a4nyP
         KFW2ippIGiXpo8ZS4tV7jHOT1XPdURUQA1gPrTUBUG43Nq/hJMuzAuZHJ7MdWaja07Fs
         xCitL2h+Q4P2HN0kaZJtbolTNnC1sBsx2c2Goo8rvpVA981MxPVqleCLi+ZO+VjoOMLf
         6Llg==
X-Forwarded-Encrypted: i=1; AJvYcCXhQQKe9nC8hX0KQEC2RcphPd0yawt62Wk6m9sJFKyjtwJlWhy2EQPQHu344vryajBrO18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFaaW3nRn07FL8QHumJ4WlLrKfLId4AeFzZewlSOM9QZsDcWq/
	kgsvqsPlbt7VwZo26sMZQxVdV8/Qs3Me5FQvmB7q7OASveXzfPkumkzv0W3LptmogoxZn0bG7Us
	nQOucrUpOxpZQIRSPWsXmn8pRFYFFGvs=
X-Gm-Gg: AZuq6aLb8vOen84X6maT+2HSzPI7mEUh5/uoYqNQvs8r3E6Kycq4XTPpPrK2NIMHwD8
	ABy8iI0PPp3Qjf68GoqWEhhUHVTw7dI0itvbkD0c6/98BNCxLNnEGJUZ62yVfwsJdne30uvv/2r
	aVneqoyBEtS2phFk0a/QIKrx2EIdwWM/hhMjJ/GD/mC3dBhdNvUoeUA/hD2E36hv3hV/2PEo/3k
	n84C727eiDWQYBo6u0OumQNL7ykTzQXdW5lY7yqMePiNQqiJwVabgto2FvXEzlrs9Q65VXEODEQ
	zVuTD9yoGtHyj/nx5BOjE8voaj0mW33PTVMl/g==
X-Received: by 2002:a05:6820:290e:b0:679:96f:3ef2 with SMTP id
 006d021491bc7-679c4507d69mr2563001eaf.60.1771736598216; Sat, 21 Feb 2026
 21:03:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
 <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com> <xmqqcy1xsds1.fsf@gitster.g>
In-Reply-To: <xmqqcy1xsds1.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 21 Feb 2026 21:03:06 -0800
X-Gm-Features: AaiRm53ENUcHq1CBueaNwVGJyoVKVBnFlYQSN6OSIrdqpvcrAygZMFIuuc4AmTU
Message-ID: <CABPp-BE_FZJ_=-pMPbt_6QxiraLQwSs8DCAgbDwBFkOgczGgUw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Avoid the_repository in merge-ort and replay
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 6:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Changes since v2:
> >
> >  * In first patch, actually avoid the_repository when attempting to rem=
ove
> >    check against the_repository
> >  * Fix commit message of patch 3 due to the new patch 1.
> >  * Slight tweak to commit message of patch 6.
> > ...
> > As noted in the comments on v1, I actually do not know why
> > prefetch_for_content_merges() needs to use the_repository. When I intro=
duced
> > it back in 2bff554b23e8 (merge-ort: add prefetching for content merges,
> > 2021-06-22), I was just looking at diffcore_std() and trying to mimic h=
ow it
> > did the prefetch, and it has such a comparison. If anyone knows why
> > diffcore_std() needs to compare against the_repository, I'd love to hea=
r...
>
> Is this comment still current?

No, I should have pulled it out of the cover letter since the commit
message of patch #1 answers this; sorry for the oversight.

> > Elijah Newren (6):
> >   merge,diff: remove the_repository check before prefetching blobs
> >   merge-ort: pass repository to write_tree()
> >   merge-ort: replace the_repository with opt->repo
> >   merge-ort: replace the_hash_algo with opt->repo->hash_algo
> >   merge-ort: prevent the_repository from coming back
> >   replay: prevent the_repository from coming back
>
> I do not seem to see the last step on the list archive.

Weird.

> https://lore.kernel.org/git/pull.2048.v3.git.1771718393.gitgitgadget@gmai=
l.com/
>
> I'll resurrect it using the previous one and ...
>
> >  6:  67db46f34f ! 6:  0654d04584 replay: prevent the_repository from co=
ming back
> >      @@ Commit message
> >           coming back.
> >
> >           Define the_repository to make it a compilation error so that =
they don't
> >      -    come back any more.
> >      +    come back any more; the repo parameter plumbed through the va=
rious
> >      +    functions can be used instead.
> >
> >           Signed-off-by: Elijah Newren <newren@gmail.com>
>
> ... this piece of information.

Thanks.
