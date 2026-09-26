Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B7346FBC
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790424284; cv=pass; b=RkvMo2bnLdL5jGeiV/PtnbsckQ7Wce26Mu8+vNC+AA4xDbKBMVwjCoYYfnO5lRKg9bscINm/AMMUv4iY8YE2K26wggTFDB68jQbddM+NQMg38zoEpdo09s/q17K4A7vZqHpuzEMRsHiQ7e2eL+k02fxJImGT1R+Sl9qeLKSBwJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790424284; c=relaxed/simple;
	bh=//G9WKdGTx/hEyA3HYr1oDXjQSqg3soR/8p7neS3u6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqxnlICSpT6uCCFggP/OgUFMCvDtfYTgsw/JFgTctP7V6Z7jfPQ8gQ73sVY5NXDn5FdXANoB4QlGwNRHCAR/6JMimNsaja4V6HvkVqU4D1eZieRYlv0MVrMdf3zLEH0NEGfkh215/bunaFiXb+Ir6LoNnYZBLS2twyllRU669FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzvF2UL7; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzvF2UL7"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so567411a91.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 05:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790424282; cv=none;
        d=google.com; s=arc-20260327;
        b=QtqY00qVhHC9YIwjXVDVcB/cy3ByGw0p1LxXVwHrXkodP/9CbvWCUdnScwp2+Sf1ta
         L5Np5tysDFV1TnIfsjDHPANUj6xi7MU3lioZn0FeFuvUFABvyD51dS8u/MwHuuGbwlAK
         Q87wiVWygdj++fDF/bFMgCKdvCNDfoRlaKKnGPXcKVHVRBJFfl05uyWadkEkHDutd5Sr
         NdG0XjoYWUaOYdNL7duNunBVvc9HUQPJtgllNRMpfDvJtAVbH3ZL5qkutEaHTesuU7VV
         +JjvyFBPZVxFmzNWzcTpjob/TkfmDOaExuzWTRbYb3B2/AAWdbxEnk/4iQKOI7u5ZXQr
         tWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dvtVOEUglWlULZ9speKWJGgB1QaV5xNeDDmOxLkBXFU=;
        fh=Ix0yJrKLcACLSKu9Fwm8GEHXdJVgOX3a5x/p2hneejU=;
        b=Q7QT8e0ztfNR6O8+QNCpOH04vi1RkA/71bst1RP/OxP8CXaBlZePvyiFBWF+a0gnJP
         f4Gg4V0qis7y7jZQ2mR5IGLd4UhvFotp7/SqkadvMP5sKOpQwoand6og3nkZMKxu81v5
         ZNlae5NX+SUHgA04uOFduJgS0TZNYSH4O763Xaj6Csesqly/758hsj1ExVtFALeJf152
         Ekb3bmszQCVTw8XpAyZWtXIfEbArBVqpNNJFb+NhNJOqF1vcGeBv9iGszr1wM4eR4tAa
         E/sh+jkD7Rem2uFs78gkikitcgwXDuxYDZyPeUszjid5EAP0gjjCjzr8wLgLD10kB0hc
         2Bhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790424282; x=1791029082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvtVOEUglWlULZ9speKWJGgB1QaV5xNeDDmOxLkBXFU=;
        b=kzvF2UL7suw0xX+V6QZDqvY3bQ8UJWrtVqkKJkMefAxBVpEI30T1uLCQfyS5OrekA4
         +isb5kK7aZ+uMSvencPesDPDnrbebB8n7JMs+7gW1HvQ4GP6GuZKkXAydaZ8TSzF09Eu
         t4vW6ZY24XA0jPOeal/PjaN4UODuluM8E6VovWMeVRzXos3jh+c9uwTvfbhuLEErAB8K
         sCCR6v515BUiLsrMvwyYQgRQSFI3x0IeyHC9Lt8pwmU2qxL7ZnJjHz+WUiQ0mF1nigqe
         i47qKdPEgY1Vj61sf1HQoSh3t0cPv/adoDGRNqLLsqaQLzNG43OQxAOpnQpe4LsxptVh
         WBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790424282; x=1791029082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvtVOEUglWlULZ9speKWJGgB1QaV5xNeDDmOxLkBXFU=;
        b=C3YpcICh+4F9pHKNR+8xw/TGAl2P7Kadc1VBlvpQzGi4on0rrGOYY7NWzl7Al715mz
         PmErSfURQiQtXfmJHHF7kXpb9lwJfMz13hs6ErEvY4ek5fUPE2CKdMLDu0joprI6CO58
         SInpJa2sqg/Xg4qkTgVRueXsqlRhN+5saN3KqqQTUKGyNLVHmcftvSmNCn0LlG6lIuEi
         L5o71y6Y+nU7cNCxl95Yd0XpZSeXbFObCuu8o2QKwX0sFEG6lyaLN0fls1Vj4KT0PuwI
         4BHNScKv2GN9U9TuSOvH+oT9ZP9Q+RS9Rva8KGp3EsybkE6FbynPwN4z9FT7rrNaWOEA
         J8nQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJLuHPYevm/tTm25cfAqwGFAGDTK5MIzlNNfruXGpRc4RNvmmSmv3k/blrmHKKfdSDM/Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGXEmURmrzt8iSOfUkDnFJVpEwXQrhwYpomHKh7rs8JpfAyFmO
	ttvUP5Tu0ab8Rr7dEgj+ouOzYgm8f6HQptNkl+wUVzoLVE4zF5r3UcnRkmAyxZ/89XfvvyKlTsW
	BtEAenBfZlA1mied/YKlZBjshtvJuhT0=
X-Gm-Gg: AYBFou1HaHz3fv21mXjZ6qvxlZmC/zTdOLBk0azwwdBkJHv6OV8RMo2CS5uXEivV6W7
	XHuCdj5D6jJqjHZqqZt9uuWp4VP7LHiGUbox6a1NQBnkluIrxP2Ia1d4Nf11d+B4CPM+nT41m/h
	PKK08Q9B9RrRaQ2r87U8+XA7rmEGKrFReS+GTNv3JSiErNSh6nq0KI0WnqFPSJirxTYfJbJkeUQ
	WaEOk2N1C4bLSFOnVIYwafGWOxl+OofH4vqfdr5GcSv9gN8Q55MOlvJbkpRPeaBipIl2jztvRix
	cGVwyJL81C7TXk5iqSrGsJQ59n0wXQqgaj3fc+ZzdNiz7y+4w6UmfkXUC7/V8Mm7P3nKFXKrQ1X
	ewunYjnbJbbzXpZGIXxM0kf05GWP99+iBTChSFdNTO65IPnOLhgIeRszyja3Kex6Djw5Nypxps5
	5i4PKQLFY=
X-Received: by 2002:a17:90a:d64f:b0:3a0:e985:9ca2 with SMTP id
 98e67ed59e1d1-3a0e985a241mr454728a91.31.1790424280953; Sat, 26 Sep 2026
 05:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790168285.git.ben.knoble@gmail.com>
 <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
 <xmqqse2yz4y4.fsf@gitster.g> <CALnO6CBhoBcVjLXidvii+o_Ump_k9disW177LeSS0118t3oGKg@mail.gmail.com>
 <xmqqpky1wb76.fsf@gitster.g> <c2bab13f-a9f1-473d-97aa-c201b2060bfd@gmail.com>
In-Reply-To: <c2bab13f-a9f1-473d-97aa-c201b2060bfd@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Sep 2026 08:04:28 -0400
X-Gm-Features: AclHuK83ewiFoZqksEn1uTlh1UG2oUZD9-TkyYmdxWIcU92tW70C-P6bS1Ksqz0
Message-ID: <CALnO6CC5bj0-yhoMD3AUGcO=uxX+y4btC=nGZ6QbmOoGr97B3w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Adam Johnson <me@adamj.eu>, Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>, 
	Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 5:51=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 25/09/2026 17:24, Junio C Hamano wrote:
> > "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> >
> >> On Thu, Sep 24, 2026 at 5:59=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
> >>>
> >>> Ahh, or perhaps the trees are indeed given in a wrong order, but not
> >>> in a random wrong order.  merge_ort_nonrecursive(), which is *not*
> >>> the function you are using, takes head, merge, and merge_base in
> >>> this order, and that order matches what you wrote.
> >>>
> >>> Perhaps the true culprit in this confusion is that the order in
> >>> which merge_ort_nonrecursive() takes its three trees (head, merge,
> >>> and common) and the order in which merge_incore_nonrecursive() takes
> >>> its trees (merge_base, side1, and side2) are different, and if we
> >>> fix them to match, it would make it easier to work with?
> >>
> >> Indeed, the confusion is that simple ;) Shamefully, we don't have
> >> enough test coverage to catch that regression, so I'm very glad indeed
> >> you spotted it.
> >>
> >>> The new test in the attached patch will fail with this step but if
> >>> we revert the changes to builtin/stash.c in this step, it passes.
> >>
> >> Any objection to me adding this test as a preparatory patch? There's
> >> no sign-off, so I don't want to mess up the DCO here.
> >
> > It was written merely as an illustration and is not something I am
> > proud of.  For example, creating a totally new playpen repository
> > only for a single piece of test and remove the entire thing when the
> > single test piece is done was done only to make sure the existing
> > test that come later can never be affected.  Also the test only uses
> > the most trivial case (a file is added in the stashed change, nobody
> > else involved in the stash application has touched the file so there
> > is nothing to "merge" in the file).  It was enough to demonstrate
> > that the order of arguments given to the function was wrong, but
> > we wouldn't catch problems in content-level merge with such a test.
> >
> > So, I wouldn't mind if you reused that as one in a series of tests,
> > but I'd prefer to see those who are move invested in the topic to
> > come up with a bit more realistic scenario.
>
> Maybe something like the test below (which I admit I haven't actually
> tested). That checks we merge the file contents and puts the changes in
> the file close enough together so that the old code would fail and has
> different contents for the three merged blobs.
>
> test_write_lines A B C >file &&
> git commit -m xxx file &&
> test_write_lines A B staged >file &&
> git add file &&
> test_write_lines A B unstaged >file &&
> git stash &&
> test_write_lines committed B C >file &&
> git commit -m yyy file &&
> git stash pop --index &&
> git show :file >actual &&
> test_write_lines committed B staged >expect &&
> text_cmp expect actual &&

s/text/test ;)

> test_write_lines committed B unstaged >expect &&
> test_cmp expect file

This does fail on the original code (head, base, merge_base) because
the index (git show :file) has "A B staged" lines instead of
"committed B staged" lines.

This test does pass on the new code, but needs some
arrangement/cleanup for the later "stash -k" test to succeed, so I'll
include that in the next round as well.

--=20
D. Ben Knoble
