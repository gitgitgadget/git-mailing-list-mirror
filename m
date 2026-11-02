Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638041;
	b=RdA9mtO9/D6zn5SN/VwfRYrIMedYXTBw/eyQD6E391htdzbb52ouMuKe/P2sTLvuiYXE
	 Ng4NzIKVQonSLQFBf5nZ5Gr+hmUnFvY7iQlY8uLlkMyrfBRjcVc8QKNZ+1J45WAU50/jR
	 gYOb7Izc8wOhmOiF5vvFjqjvw6++iSHKuLOg8flqHbyJuww0Kz/K92njMLs/SwDBLe9Uh
	 JqBk9gZM5bnKBjgUuEy5U6glswpsd6YOIC34YHkmaOCHwPEjt20npnVD/4eAvOCaZr0JG
	 JaPVSo27+GZwhhcD04fjF/x0LnnyKynN61BlTTQzYSjOJLUwQI6qJiEExN0aDjGiCSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=bm7JU63ozMmtE8z9v3s+3IRlcOCdgZccS3kBxhWhVHQ=;
	b=zaspgBVGNTeiUqTh6JGMmFQLcUSQjyIaH/Pb77/kd//l4cLgQHPVxwOIuBhvuZrexnoh
	 Sr2mEfz4ZYstfpdsneI5F2dXO0aT5tWisR19xBADouc1qpQfAeZHk7LZZWJ8/1mpn3IpX
	 k5Mo7uof7ol4wmwtGpJa/2pkih5qzeqOqhzB3qfsUG56Qwo847/PnS0VYzW3n/L2Bpl1Q
	 ASkPGZTuB9UQDwBhuTgfzFfcTve1WEeNsknxFoDZEZMg/SihxhKoZTVmiYDIm0izUMj4x
	 hgKDpqXdcSPACKA4EuKEOFUnd3e8rKCkX9Qb6vn66J3yMRvK1J7AHHihHHGrIv0WUoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S1HjKiL9;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C73606B0E9
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96C73606B0E9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S1HjKiL9
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b12b1ee403so18429907b3.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 08:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638040; x=1794242840; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bm7JU63ozMmtE8z9v3s+3IRlcOCdgZccS3kBxhWhVHQ=;
        b=S1HjKiL9ockCSSVf0rHw5NZghERfutjM/AkTUUpIdi1L6OTfGkxkKyKrqDdqI2X01K
         K873GQ9/wNRXWUArN2iPAlvEpJTsW9fJJvWwECXhcxBN3Y4xzYinbQmJ9NGN76xaQ6JL
         leWwi2W2q/aRZJ4davJsCPnUpYbr4nO6Woi8SuSS9l1NlDvtZYQHCew7QfWeMu1bO7ct
         3uXpqFv5X6IFY8+FQqvW1m+dU2+gdkmRPCyKuC/FExCqmy/itBk6v0ydHqQcsRCsNn6q
         XrhgCETM6+LVliGzWr61APTupczrkr/p3BRKhbiJKRV8MmDKrZ0oj2tbfD62qeKRUnai
         s3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638040; x=1794242840;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bm7JU63ozMmtE8z9v3s+3IRlcOCdgZccS3kBxhWhVHQ=;
        b=ieGu51MEEN+udoIktlmwYOoDJCalBz801WcHtEZhuE1aEtHY+fJ+E4qIq6lkuxVb8p
         4+L9vPZNqukn80+s7sN9mg0uXnxFC2pC/Peew7XndxJRAlPLiXFUiTx87zId5AmHEH/z
         Ug3YCaEAVANl7tbJpMXoWLzUJ0rbnDc3pysVgoljfi8qvk/WPBgw3ZFKcC3uXoKR8TVN
         021L9eqsJuoL/0D5RgfHhW9+0jC68EsKK3GhcLbkxQMTAL0pcqNLQXfMi1pCvFAQHT63
         VWfKIc1mRw/IUvMJjP62zHPFnTpr8nS84w2ADyZQyeF9/nVpepsIvxZaz+cI369PA8Xu
         ifKw==
X-Forwarded-Encrypted: i=1; AKwUvBzjQnnfl9iqHi4CV5j3zhbHX5Z79Z+BSSOQ3lBsdKdyfcmfu2EfQ4jKVDYAdRvNGuKKCQ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VQ85GOGkINJh+kbHzSYa5yCxIOW2L8UmtTwnWX3K5x0sAmS2n
	UtKnZl+2xk7HvW6loXcMr5Ufj48/Z1MdTh3rWjmuWVBz3CTLDhOmITTy
X-Gm-Gg: AYBFou0fYN59xk+mAu1aBuowcDgHluYtonk7uqzCXRe6LRdGXeF8f11j6hu4NmebB8r
	6OG1p2NuML5ZxblWlnJxfvlU1KriPpgV2G983PAruEhE6v6xiutzow5M3MZsjQJLfAB57JXZGB/
	a6wXlU1phQa07RFxmX+BFi2+qnxIYSwShFjTBVSL+ffTa2/uhal+DQCnnfBpiJ+BHaKki5ThmwT
	jgoMs7DOZ7+FAdwUFrzl9n7E741OYDyhOUK+C676dAPJpQdUjmQ18PIw+wBJTLUj9InJaJ+VwMX
	1Wjp8Hyp5yqUeGYViRwBxlsF/uyHbKrPa7LehQyrj9XAyNi5HGj/EHiOEDRfbZfUPmFm/2GyTYy
	kDIW6e8fuFZ1FWvBc1OvKDJWz/PgoebTlknw+OFCGApiBZrCj7Cn88k8tZ7osJL4aufomy32ghX
	RHhYG0iqgCAmiiAjQjbxpKBOgA849a5Kj8rHI8CCT9OahTgnXhdHZ1fdZOcId4Ze8h5Y2FdmE83
	gaq4TfSTvtEpueBcj8G1C+jvcHU1mOdsrYRc3iakNey/Dff9nEcdiiPZ5xOM3ijoAjlaEOcBZzJ
	DcTqYizP6CBZqizT2/EAPYHDGDQ3gueXqTaloWOuf5pRV257Lfpf4rsxIdomddx3uYuwyicml2X
	zaORyT1W+B/45qoGTfur+E8VUo3dFfTvsDKEAdXBdRMnIlsY9qtRi0p4O/9aNs171CFx7AgUGIa
	6tfrVgKcF0AXg+oPNXjSNU
X-Received: by 2002:a05:690c:6e83:b0:8b0:e680:6157 with SMTP id 00721157ae682-8b2b6774208mr67770237b3.39.1793638040544;
        Mon, 02 Nov 2026 08:47:20 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:753f:c392:a7d3:dbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b7123fd9sm56557807b3.12.2026.11.02.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:47:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided commits
Date: Mon, 2 Nov 2026 11:47:09 -0500
Message-Id: <73E9A266-5224-43CC-ABC4-83FBC6B77F13@gmail.com>
References: <CAHwyqnVtN79Y7SAWb4YFRCqCO6+Jq9-9tZ9Jho4ec8pjVJR00Q@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
In-Reply-To: <CAHwyqnVtN79Y7SAWb4YFRCqCO6+Jq9-9tZ9Jho4ec8pjVJR00Q@mail.gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 2 nov. 2026 =C3=A0 05:11, Harald Nordgren <haraldnordgren@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn Mon, Nov 2, 2026 at 10:21=E2=80=AFAM Junio C Hamano <gitster@p=
obox.com> wrote:
>>=20
>> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>=20
>>> From: Harald Nordgren <haraldnordgren@gmail.com>
>>>=20
>>> Reviewing a range-diff often means scrolling past commits that were
>>> simply added or dropped, when only the ones that correspond between
>>> the two ranges are of interest.
>>>=20
>>> --left-only and --right-only already each suppress one of those
>>> one-sided groups, but they are defined as "only show this side" and
>>> so cannot be given together, which is exactly why show_range_diff()
>>> already rejected that combination. Give the "show only the commits
>>> that correspond on both sides" behavior its own name, --matched-only,
>>> instead of asking users to reach for a combination that errors out.
>>>=20
>>> Extend the existing '--left-only'/'--right-only' conflict check to
>>> also reject any combination with --matched-only, since all three
>>> narrow the output in ways that cannot be combined.
>>>=20
>>> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>>> ---
>>>    range-diff: add --matched-only to skip one-sided commits
>>>=20
>>>    Add git range-diff --matched-only to only show commits that correspon=
d
>>>    between the two ranges, skipping ones that were only added or only
>>>    removed.
>>>=20
>>>    Changes in v2:
>>>=20
>>>     * Update docs and commit message.
>>>     * Use die_for_incompatible_opt3.
>>=20
>> This is more than 6 weeks old and looking at the archive, nobody
>> (including me) was really interested in the topic.  Anybody wants to
>> take a fresh look at the topic?
>>=20
>> Unless we see some volunteers to give it a review in a few weeks, I
>> will discard the topic out of my tree, as 'seen' has been crowded
>> with topics that have been collecting dust without getting many
>> reviews.
>=20
> That's a bit sad. I wonder if no one is commenting on it because the
> code is too trivial, meaning nothing that stands out to comment on.
> All it does is allow left_only and right_only to run at the same time,
> and the majority of the new code is tests.
>=20
>=20
> Harald

I just skimmed the v3 message, and I=E2=80=99m missing the motivation.
When looking at a range-diff, why would I want to hide the added/deleted
commits?

I suppose when rebasing, I might want to not show the dropped
fixup commits or something in a range-diff of @{1}=E2=80=A6, but
I=E2=80=99m having a hard time coming up with another use case.

Doesn=E2=80=99t mean there aren=E2=80=99t any! [But the patch might get more=

and better reviews if it is well motivated?] Anyway, I=E2=80=99d be curious
to learn what motivated Harald, as it might be useful to my=20
own workflows, in which case I might be able to review more.=
