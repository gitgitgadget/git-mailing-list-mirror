Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618839A818
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938854; cv=pass; b=dFnO/QLE5RAkwRAIVs6jaFt8BzTPGCKW+C3JKufbuzo+ykpjw9uH8hRruKOkU2W+sGyVk6+R2J0Db/fUloEC/AU/cYkify+hLpf9d8KTrDVcyJNLjPNh75UY6mqXqYRe9QrT6v+wHgx3m8fYP7gLxZln8YerbIYen16MSsVnlwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938854; c=relaxed/simple;
	bh=Y5YzBmfWawW5Zj/lqws//C1Su2AUbuoEb8xgwWHzeFM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2NYe+FuO2m476cBzG50IhJ5W+U7w8SL/n9CmIKqlXcvjYs7ZitaF+J5BhYHCd5D2aRlRTVorYqHeyPapNe7HbmBUWhGUpPLh0fxKaxxWzrkyBEzRq9Gqdr9ulpQKO8futFMIo89L8ByVfqbcqlNuqV+NzxOU7+JUeuO2eHZqu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxMkqnxT; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxMkqnxT"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5fa3f2b8f7fso1242769137.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 05:14:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771938852; cv=none;
        d=google.com; s=arc-20240605;
        b=QMTuI+fKIpK4OOtxlPJWiwtYyNGimYi37NoHGaJVb6WfqFkKMwHV09PBLaDaBtF3Tj
         bpj1JbRy97EdtZnZQo9e/tw0OA3zdEOtdUbvoXP322vkY5B4HEQcshe/pXmhgGy/XAWy
         pPZ3uxt65aNi6kwUcR6XnJkZpSN3WnFjvLvlNJWbPeexlRMyEpuaUFUFgOrXDzMVj87d
         cr67uM0jXmNnNXi4hlsUlvSvyEyq5BhznVVnFqcFjtoXWnzUQn4QSJzC2mCd+J1fQDz6
         DM0KrBZ8DsCHgLZKC1QT29rFIstUtbDYllyZVnWP2bpG+G/uEjHPqc9MS853GrkXak07
         zv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=lhoJEL8ARfV4O2irYh61mbTe/qvaqpvhIOEtGSAYnzs=;
        fh=it2rvcX6E2xAt6KJ/2X9eoDqGSvvj75C0U4+KcTsXL0=;
        b=Vb7rWwdjLXkKsRoOHPbsq4xepHxvLAo/S9m+mE53Bj97m9LBILvITK37/cqjMg/sBS
         V/ojMzyqeiWVXlt40nDj7q316EaCftZiX473fCvbB2ap3Ne/w/0ScvnlkVBZG7h2qzdL
         /i7o6nxMqKJfo2Kq2rMshdv9Y6KzAurhV/7Rer1L+sbsvKDJVfZ4XxF2XL7SLyRtlEBv
         d6RTJ5OrIY1pk3jJlVzq/K8uC9yCy0oR+Fz8vp1d0NLaFyhZxoeaSUBIVzaw/Y/TX9Z3
         pT3dIzpJEf6ZoObytRky+xQaSzS7ilCqpcUg39tUVcE+C8hBbZb/1KfHJFiTZRdsoVN3
         tt6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771938852; x=1772543652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lhoJEL8ARfV4O2irYh61mbTe/qvaqpvhIOEtGSAYnzs=;
        b=dxMkqnxT83g0SPkr06GeNcXY3GIW2eEJoF0bzVMQPSiq1WZYRGnLk6sjhIpg/Sbkfq
         TDt/dHEHpZaUYDHR1Zg0hiiVDH1K6slTFr41X0YJ6AZ+nrxpk9Rg3W0H2Puz+M2kno8d
         x0CfLU7fD3BgK2jIM3O/X1ACA9UehioBMGci8FnH+aEc4v0MMApkIbh0w9TbAndUq6c3
         HdBrlgQOurJzVgPj1ZyVktu2SHmscwBjGjm86DH60+p6Hgr9QqG09rUU7EcF3r43rTKO
         SyCBkE6s5TDhGcxrdfPvJfZT3DUqpo+IdqefXJl9YKk1VmhVBzM5dgbeDk/ZnckSK0OH
         1XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771938852; x=1772543652;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhoJEL8ARfV4O2irYh61mbTe/qvaqpvhIOEtGSAYnzs=;
        b=KAGDJjmleafM1riutIMedt7IVRRkPZps5OQvxiXM4n03byhPLtBaEpGAOpCOSBBcDk
         PPwfJUPZ6RvjvN3S44MGeIK8L8g1SsCFjCdb/sN8laQao90Mw5dnPuq3W9P4hm4eYdw0
         9nvIv58KKgDeD2p7XMk5vFxOk2sJi18qFi+4/s+DrFdloE/Na1J5TMAxZ8wUEGDEjDzY
         xOwMHbZHvosE1rLxxv8JyjajnHyNrqDvTZ8CQ3BEfAW1mvEStG2shWkOkVTxE85U67Mf
         fK1ZBgCUgJ9QfLPPZQX1xbdo57ZOhI0mpegDuif9ImvJTWP6yGfjI9J3R36f1JkWukEb
         7e2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6xoLgcYFoofcdBn1ZUpDMFvTLoPIK0QBwN4YnWK0TK4WrYhuJmBg3ZbGQyRRsLjR0B2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6u1wm1sfGf6FpeSVORXvU99DJJd26N5nhC+7uqkjTM1CXq/o
	/U1QaRfcKxC8aWsgrsJh4f/JGw4RBW/xnFwtdzwbXKwgzkTFtkElvHww5qhSiq0q/pWNF98eF5q
	fj2vHK+nTTb4Kmor1IFjyLHSY4EAvyOg=
X-Gm-Gg: ATEYQzyZQWS+HBlWdxazazYlRnsM7YIuDyk7Z2Su709S6fSy0/nI6GO0lomHfIWfqT2
	oHw4GUXCQntxlvqQ6/XAHw5MTleSoXovXL8i9bG8ndv53eXeGi0UxQg4fuaounnzEslkOoSXJ1L
	BsV8/5Vege98HMm97PRzJDGfcnF7yduLIyFk3YaqvbAJf5iMhCrApTJEcL7ymYSuQVhLgmDqe1W
	7rkMMHE8b4qEvM8Q/KNL9H2jkHvehz2gBfi04w05DzsZRLkIje/NyYlsI1DfCakAhI8O6ZQz8sw
	YHaVPmiWIZf/sfJfi5clmWFOydudl5lGR81qI06WBg==
X-Received: by 2002:a05:6102:4192:b0:5ee:a2a8:2e73 with SMTP id
 ada2fe7eead31-5feb303a876mr4168099137.26.1771938851828; Tue, 24 Feb 2026
 05:14:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 08:14:10 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 08:14:10 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im> <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Feb 2026 08:14:10 -0500
X-Gm-Features: AaiRm51qk8WXYYVLBl-0G98eHrA1bjMC53vbM78Ua2mndG91qTL3NF9z4uBaQD4
Message-ID: <CAOLa=ZTz-9JKHC3H8tSwP=bDvX2mNA-erjr5Ni6Tiq4cm4WmLg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] refs: unify `refs_for_each_*()` functions
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Content-Type: multipart/mixed; boundary="000000000000d3dd7d064b91a91f"

--000000000000d3dd7d064b91a91f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> we currently have 14 different `refs_for_each_*()` functions, with each
> of them doing slightly different things. This makes for a confusing API
> surface, and because the API is not built for extension we have to add a
> new function every now and then to handle another esoteric edge case
> that will ultimately only have at most a handful of callers.
>
> This design isn't really sensible in my opinion, and this patch series
> aims to fix that. Instead of having a dozen different functions, it
> introduces a new `refs_for_each_ref_ext()` function that simply takes an
> options structure as input. From thereon, callers can mix and match the
> parameters that they care about.
>
> The patch series is structured like this:
>
>   - Patches 1 to 5 introduce some preliminary cleanups.
>
>   - Patches 6 to 9 introduce `refs_for_each_ref_ext()` and move
>     more functionality into it. This also fixes a performance bug that
>     we have in one of the implementations.
>
>   - Patch 10 adds some more verification for options that would have
>     caught the bugs in ps/for-each-ref-in-fixes.
>
>   - The remaining patches drop 7 out of 14 functions and replace them
>     with `refs_for_each_ref_ext()`. It results in a bit of churn, so
>     while I think this churn is worth it, I consider these patches to be
>     optional.
>
> The patch series is built on top of 73fd77805f (The 5th batch,
> 2026-02-17) with ps/for-each-ref-in-fixes at 6375a00ef1 (bisect:
> simplify string_list memory handling, 2026-02-19) merged into it.
>
> Changes in v2:
>   - Move the removal of `refs_for_each_include_root_ref()` to the
>     beginning of the series to avoid some unnecessary churn.
>   - Some commit message improvements.
>   - Make the converted version of `refs_for_each_glob_ref_in()` fit into
>     the new calling conventions a bit better. The function was still
>     stripping the prefix unconditionally for example, which I've now
>     changed.
>   - Link to v1: https://lore.kernel.org/r/20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im
>

The range-diff looks good. I'm happy with this version! :)

[snip]

--000000000000d3dd7d064b91a91f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1228329c8a5ba173_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tZHBDRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK24rREFDTVBSamxLQWVuNnhxb0t4c0pzdlVBQXhQYgpUeVU2TWJqTzlt
OW5lckJCWVZJbVU5bCt2dXlZKzZvdHYvaWdic05mQ0J5TUNMOC9tdFN4dmxjNEFQaVZxcDRFCldE
Sk5nM1BOeDc4QmN0L1RyWGxkWk05QzU4bEJhZk9JU0VERG5qTFFwLzFTK3BKa2Z5K1NoeW4vOEVq
YVlCdW8KRHpuZHc3UmkvSURKcTl0a1hqN3lFd0NUclBZUGp2bkRsWUZCTjhVQStGSUNhU3VGSlJU
YTF2SVJvUU9nTTJMQQpQMkVRd3pDZlRjQ2RiZmFWVUsvS0hkeVVhWHdRZ0Jsbjg5NnFWaGdSb0h2
SW1rSWpsNkJZV0JLbUNxQmdqRWZvCmpRdzRPZHAzTzNOWlV4cWFwdGoyOVlXU001ZW5KUVFqa2lV
VDBrbU02V2pFcFBudlJDdlYvcytMZFhPWUpacXAKeDZnTW1hRlBTTFhSUGJVemhtV2JWdEhOa250
RUxXVi8zZlFkMnJCTER1dnkwSm9EWkZtMnhpMmgxUExuaDJjVwpRRmI3bFlZTll3c1gvYXlmd2hq
Y05LYlJOMHhLdTdxZmY5bEZBcGFmUnJJMVcrVDhrelJqVisyKzRyMkowNWRpCnowWTNMek9oUkpp
TE0yblNzMlpIYUROaEc2YTJOWmlad0lBWFpKRT0KPTkwUlIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d3dd7d064b91a91f--
