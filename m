Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5911A6802
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489370; cv=pass; b=LueqntLzc8wx9VdIpHfcFa5Su4zbZtdIREXC6+IEpgmWrLmft7JNOLbcwqmUqzxUe++JOr0QFdUlSEf84fXOxkkJ9NPx0tVhxaBC9uuE/J5WqIEVF81uPDKGMqasN8FcykgFqF4GkQHS6kLwokZMJLAWChQEJwN3YJczwkJ8YlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489370; c=relaxed/simple;
	bh=45w/OFEEj0jTmPZOUv7hDe2TLhVJWC6jTab7KB7NOl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxwFRoI11coSfN1lLIubcjFIj9pxjT7hMNzMrKzABhAWehq9rPAt2/itqkKJYSIy9S08tMGyUeAOt4Rj5+CiylM+n81MyYCKVFpHWwribb241zxXUV5apwEZNPM5s761/9d58EvlmOaewvvnAzwS5tP/j5iaXgdzZMMd8CMHXcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQIu9HUE; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQIu9HUE"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6726f320b54so3015053eaf.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 14:09:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772489368; cv=none;
        d=google.com; s=arc-20240605;
        b=Q1P1XMSd3AZGXl0R3+hA0KlXF31sGY7L3wYdXJd/yJ+zvrFy1PrmdzKkXJaeoOrMpL
         yOHgb+UHV9deWXsG772NFByKC8KqmOExr6Hg+8/nJKKQoWtZDahu4ahdY2WiruDi9LAh
         vPL5z1NuRcz4BEx/CG9up+AtbCaVJHdtiXtz9UUWoi+0QlGsYZzIBM4A2mpzt73o33jk
         7v9Sd1n2n/D6cVR9xM0bMZRXKEDWav9RNc3PK8XaSNmc90VbmO0LVC5NJnd8sIJwU7mw
         dmpzATUXkxcSFPKVqaJVss1zY8bcQMGUXFoC7jvYcHoQ1NRFAVsGHcjm+Aly5IA3n89Q
         uZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=45w/OFEEj0jTmPZOUv7hDe2TLhVJWC6jTab7KB7NOl0=;
        fh=Jmd0cpIvL4GD8LbSvXfxvZVUUiDUY2dkYONYdrJRNf8=;
        b=WNEuPFof61DCFJnh8/1GV9tNapFbA0WZtUEIkWiLGvG6VmumYxCTy3BThfBCJ+LB2w
         6np9u3Yb5AfdV2xnDKPDFYnF7bWufDE4X7+LSFPsJcM27YextFZBEhB66B0ifLvuoUbI
         HjiU9p0uE0MyCUJVa3LX7NC56HMsloYKwr685a+jTKbUtLZjSWRJWSFv6FY0Zck5rF4e
         jzV6Ho2/OvhluJKHjimxwDW+7rPaEAf7N+Ltk5GYI4gntMIYzJ42AgX+G0GMlln4//3X
         GIrw2lhM2aKnaIkUwd/0++gvhYJ7EDDjdTm+X9wBoLygyKSd2fIBtlwUwSNpRlg1QFwQ
         0BKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772489368; x=1773094168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45w/OFEEj0jTmPZOUv7hDe2TLhVJWC6jTab7KB7NOl0=;
        b=EQIu9HUEYwwoth0Rs8wnRBbQEwWV9MEaaB7O6g0ywfR49gl8n+c6pLBxpcnmHylvgt
         mESxYtrz5cX/GEbIAP6UyztjMq/sLOMjsXANcQ/VUnx/HiSGJj/r9/kPaxzmceR3owO0
         lIz8gXl5yOlcImKPucXHrAuuSZKF0PpIqUYqa843vTs/cKn/ATosrC7Sp2Q67jbfPk+g
         /Mbsf5fs2nvhFQjL8yxlPvwoa5sGtK170WQKiZ5By0o4JMi4kECQ/JT7uHAjl3QzG+sK
         LohuHhQ7QN5ni+mTiqyzKVs7wBP89zfe5Pmm07Q8GO5prpogg5aP0jq05dFmF8dyA/VA
         eQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772489368; x=1773094168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45w/OFEEj0jTmPZOUv7hDe2TLhVJWC6jTab7KB7NOl0=;
        b=YtJCXfTor5SATC0FyF3a+nObh52iWIl47Uc5EHKDaURTLKjSavgbVQ9qn0X0OlgBfT
         0ZJN4tcO1VOjMZF2YBdoHUJfh90P4dv5oagtzge3Hqwn9QOhsLkhTPgIdN1trDtBMSy0
         RpdyzaKxnU8F5OiK1wruGbCT/ecBgkyrxcSOWKzc0gKZOmZ+C20AXnS5ZVpUeBtrMIUS
         nyCTq9IP5cb1L4gKluvMBn5SBOZM+qbINlAkt8/MI46Z1hdpMjDQq+Gm4ciILOOMl+c7
         IXxpYVaCg1Dzmvwa5Dya2ihrH9MLWiH+5fSDWaeb3nl/ajNbxzWmDEvrK2MIMH3HRt1Q
         naqg==
X-Gm-Message-State: AOJu0Yx+yu3kFcUGGB8Qtz8I/H2L06cDeFBkje3u5NpEods61WaOZp1n
	DGU/K+LwIl/qYtoP1PQ5YixNT9BCw77HVmZyFAVbntRPKRnOQQJ+ei7TTsN1gUZdVN3SCdQlFG2
	sOmFvnjpdkLVtSq09xUofc01X0JJun6w=
X-Gm-Gg: ATEYQzz/Z7edL5KFKiGWTozveSzwKV7Rind9WFPB+RwaxgmTOfQH2uN5gepJWK6eN8s
	t0YrUiQ8BSAXw0V1ILdWbKrzwbh+XFZUWKolHztHlQHOP4vy5yAVJHPjbxOSYkI+aVF/vn8wkdC
	m7GqZIVx1AeUIG7N/H2VyIl6gdZvgd99SjZH9ZkIDjA92rv7AhN2ZJpWiQlPBkk5IXFA5xdj1Ek
	yy4SZh50ExkEYBzdDsIR4Ww6IbhsWOQNnYfGOqrx7BjGpXmwudJog9ovwH5WhVOaczAxIvXO6n+
	Lu3s7g==
X-Received: by 2002:a05:6820:3102:b0:679:e750:6c0e with SMTP id
 006d021491bc7-679fadbad18mr8402144eaf.8.1772489368657; Mon, 02 Mar 2026
 14:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com> <20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
In-Reply-To: <20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Mon, 2 Mar 2026 14:09:18 -0800
X-Gm-Features: AaiRm53B1P93Sj_gnuUtffBl4E1ML8IE8_Mveqdkb56yjrCOXt-d0pe1_a4FQCs
Message-ID: <CA+P7+xqC10D9a3zp7JO_yoK9Vjpg+xua7yH=fGXjApUYisTf4w@mail.gmail.com>
Subject: Re: [PATCH v4] submodule: fetch missing objects from default remote
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 6:53=E2=80=AFPM Nasser Grainawi
<nasser.grainawi@oss.qualcomm.com> wrote:
>
> When be76c21282 (fetch: ensure submodule objects fetched, 2018-12-06)
> added support for fetching a missing submodule object by id, it
> hardcoded the remote name as "origin" and deferred anything more
> complicated for a later patch. Implement the NEEDSWORK item to remove
> the hardcoded assumption by adding and using a submodule helper subcmd
> 'get-default-remote'. Fixing this lets 'git fetch --recurse-submodules'
> succeed when the fetched commit(s) in the superproject trigger a
> submodule fetch, and that submodule's default remote name is not
> "origin".
>
> Add non-"origin" remote tests to t5526-fetch-submodules.sh and
> t5572-pull-submodule.sh demonstrating this works as expected and add
> dedicated tests for get-default-remote.
>
> Signed-off-by: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
> ---
> I removed Jacob Keller's Reviewed-By since there are more significant
> edits to the tests in v4 that they haven't reviewed.
>
> v4 includes fixes for the issues Junio patched in seen and I confirmed
> it merges cleanly to seen (with v3 reverted) as well as next and passes
> tests.
>

v4 looks good, thanks!

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
