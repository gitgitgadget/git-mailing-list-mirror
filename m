Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793613974;
	b=gwnTC5hTOrlxQ6kGlVYYc8wGs88gB3b0A2AjhVVwekuaHhYznwCokfLNj6XH6gCuC7GU
	 z3Rq+AFS0NpmIyTZIikgmscK84CSFaGtunMB67OQvyoJ+Jgv95r7LZ1DIfGuR8YQrIa7i
	 /5XwIZqGxKE+MRWGDV6rcvPKHgVN7wss67/6ZU6Xilue8rapv4heoMGn9AfXYz8R+99bQ
	 WE3F7wTwgWJYdj24kgofCa0k5wSS9xs2C0P130OnWZklC4++AHk3DKjNqPPOQDMPeM849
	 ME9LlkgWCS/eU05aOrTwK+U/B2EbXokz00AxpzqBX4tPXhB1LWidHSDNfwVsU2cGE0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=DlhMB25pRgwYqYNshrG3DQ71MAPoVXNDch1nDnaT+uc=;
	b=Ven5XB2NZwFk8N9o5qX5zEmmP/uRG3N9kO7dKkLT2hpeZKru9mTAkzaEhmqFbCtoXM8R
	 7lNadnAKxZHwPK9tnfe9dswbD5koGMlNMC/X+S0Xw/rXosA5imBY4oWCDWAR1M/GMJU1U
	 YCcPCqwVl2W13bVLmbyCihzSwBIZkSV32TJFORbzSyXAfbbzZ67mIPYE1QGtgpQYvF5xY
	 P/CRUetlY6ngwrOrpZwPEq0ztM3fbusM7jsyvjeZLuzKS6tywSQAt7LQkzu41/sPY7Wpc
	 HEnc67CD4ZZUfwS//Z6IsqwH/5EMjTW3lJb+QCUzCZ1i9LD+9rNI/FiG4+PKhNl8ZTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eT5Vxfa3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528A606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 10:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D528A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eT5Vxfa3
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so3420475a12.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 02:06:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793613972; cv=none;
        d=google.com; s=arc-20260327;
        b=Du8dRN4qq2upFmFKryh/R0kOM2oGvmhuzxmZn8exphLJs84UxJ9Vqqy4Uw/DioEGCL
         52T9DdC3fgVJIOmqwJzOCnfQDZCKmyqE4jaqaA+kGV4/ikd4x5GCJhCWIAtWbhdP8CQr
         ooskAUt1hNShwdNa3lP1ZOmXBRPQujfRjQERH1IfBk5iZLEO40ujAurIuuhe3P9YWYmD
         5aZUblIn2O6D0pTAYqbFe/MVmYFIvaUU82jkSo84Ds9RGKbDUSziQeswd3j69p/4M9V9
         QuQoIOQ81004hOJBSbwZU6l8LC6ISCM/M3O5Dz7MC0/HkfwG1PTW0B9lgwgR6thge/rz
         WlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DlhMB25pRgwYqYNshrG3DQ71MAPoVXNDch1nDnaT+uc=;
        fh=7zpS/W4pO1XUppz4C6+S0iTph3SHaEFs72f/fNyupuI=;
        b=LDoRZtkinv6bRNrSOvh6zC9+IbZ0LqLDVZpF8mcbEbrMFLUWMLnzHSq9axgYPK8gSu
         tL22yBE9lutO4ltscHLftZVD21ApJCnwK0KH7WKi4pn3V5TLVQZ2EnGu7JBsBwwF3yZZ
         7JD+9bsN7Di7mg6p/8PxdBEVUW3KOGW0I4KruDLayG4e49PBEIe/m32K3LRi3ZOkYMFe
         A8hR1ozjBdQyGZ+gXQSB31+pHl2pepM00PqY9zYAC5HkA/7g8hUZ1WmD6Xt+mIAzG/b9
         gk2ADEFqZrOOrP9ylLOw3DwsmA5esu99OIeqR+nnVZLWe8EuISGi4dm+kWcuIpEni9hB
         hNVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793613972; x=1794218772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DlhMB25pRgwYqYNshrG3DQ71MAPoVXNDch1nDnaT+uc=;
        b=eT5Vxfa3WBhp9YZTfblRUJAFdjbxx0en2ensPDhce1jANFQA01GIqxv18CvZ7881+Z
         tAQyF3FjJHL9VyGn7PqhzanOzFjgCSzA5MNfdxO5/ZcuwIHC88hz3HazWD8Vd+pScTzT
         ot3P7/g/IpuUuq+YjPA1KGkF3xuptlpYWcD27lOgnvPZznNI7xfpEcSNgP52IpHr9+5i
         E0rGD54Yqjib5fmz8xtJDnBN6p5t8ov9Yu1bAvmTy5mAEWsxqrTnAQ8UPF6MaJ8BPIfe
         5rwag6zt8aDR5x1WHefSrpV8uOfZKM5nZppVNnUfd3loP8K8IH9s56jp6nD0Zdw8oKWb
         JC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613972; x=1794218772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlhMB25pRgwYqYNshrG3DQ71MAPoVXNDch1nDnaT+uc=;
        b=Ix+it4vWrzNEDr8OOTVKsFukuecyH2UDFZ9QHUktzeTW/oPqtloXYyZwOg1y/zd13l
         5l6XgP4Li50HkLCg8CF5nojMyze5ZXYdI4bgmh+QDqEzL8vXt4T3xujRZ9kLL4T4W+i0
         z76ykkTSVYPpxrKOjiSX1ESwvsIAHIcWsazHZbwBdWLIbpgUAnXWNQXSt37RZ48rZoly
         3lFvGL5zUye0aHsAh5AGuyiajWzeEodmEBh/DvF0GPF2jOq3oTOCepzwSMBV1tsscXrV
         ll88wSVDJtktQE6xOA9WodEuv0rxTmesz1A1pUt+Bnowtd/3Q6GFUKyFPSu8jvlpVDiT
         ClLQ==
X-Gm-Message-State: APuU4Z9ryLzenyjookRrXz9udpQ76uj3eX7PFobL5cuVlTl/OYU6dTCH
	TbWP5Z/g3XHby70LAguCX9AV5tUBWy1kTXS7GfWeRh4SZqd7A8DwPHzOO/k6+LCGfi/pD9tOlVV
	I98Y8Z40uy20k5T3lDb2mEMyrhSs456g=
X-Gm-Gg: AYBFou09np7l5POP+hTuUtNl63y6IZ2jtSFp4THJ50k7MvuVnqg9Hw9YV1unfvWP797
	ZqEzsPyabsLtbcKbuR3SFTDOnCMy5/ywtMOrS/+LfVuf75qhSX2czfqtgBqu8Tfp1I3grgHMWud
	6IlQeRJ/mEXIWjFfEckpPfgw638hTGrqEKNoJCq3+H/Y3RmkHkxaCcUnfrd/ICNNNLuxvdO9BQB
	OcUVgQwqDJkrBDILvZMZCNISSeB7a1g7dU8YhaHla11fe/pQ5pONaVWX+gNs2i7OQITtEcbMwNU
	bugO5eLjFMpRbz3pBSxYW8IxVsrSvDjnMM74Uav6T7K0V/ZO+xxNkjBwcc+Iq0ZoEG64C+FfWUf
	neMg8ippX9xgCcSud1LZL1UYIw32ohrRee54Q
X-Received: by 2002:a05:6402:2750:b0:6b3:f05e:fd5e with SMTP id
 4fb4d7f45d1cf-6b4d581c1famr6600866a12.33.1793613972112; Mon, 02 Nov 2026
 02:06:12 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2401.git.git.1789144877632.gitgitgadget@gmail.com>
 <pull.2401.v3.git.git.1789458703432.gitgitgadget@gmail.com> <xmqqy0bblhbp.fsf@gitster.g>
In-Reply-To: <xmqqy0bblhbp.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 2 Nov 2026 11:05:35 +0100
X-Gm-Features: AclHuK_k9ildZ6ead7UxPp9PHM7q8wKr_yEE8sQunv-mqbjCUQ3wgX1bARpfq4E
Message-ID: <CAHwyqnVtN79Y7SAWb4YFRCqCO6+Jq9-9tZ9Jho4ec8pjVJR00Q@mail.gmail.com>
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided commits
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:21=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >
> > Reviewing a range-diff often means scrolling past commits that were
> > simply added or dropped, when only the ones that correspond between
> > the two ranges are of interest.
> >
> > --left-only and --right-only already each suppress one of those
> > one-sided groups, but they are defined as "only show this side" and
> > so cannot be given together, which is exactly why show_range_diff()
> > already rejected that combination. Give the "show only the commits
> > that correspond on both sides" behavior its own name, --matched-only,
> > instead of asking users to reach for a combination that errors out.
> >
> > Extend the existing '--left-only'/'--right-only' conflict check to
> > also reject any combination with --matched-only, since all three
> > narrow the output in ways that cannot be combined.
> >
> > Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> > ---
> >     range-diff: add --matched-only to skip one-sided commits
> >
> >     Add git range-diff --matched-only to only show commits that corresp=
ond
> >     between the two ranges, skipping ones that were only added or only
> >     removed.
> >
> >     Changes in v2:
> >
> >      * Update docs and commit message.
> >      * Use die_for_incompatible_opt3.
>
> This is more than 6 weeks old and looking at the archive, nobody
> (including me) was really interested in the topic.  Anybody wants to
> take a fresh look at the topic?
>
> Unless we see some volunteers to give it a review in a few weeks, I
> will discard the topic out of my tree, as 'seen' has been crowded
> with topics that have been collecting dust without getting many
> reviews.

That's a bit sad. I wonder if no one is commenting on it because the
code is too trivial, meaning nothing that stands out to comment on.
All it does is allow left_only and right_only to run at the same time,
and the majority of the new code is tests.


Harald
