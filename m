Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F42931F7
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825069; cv=pass; b=gXfv9MJhWEmiiGK91oS+hRUBIMTzJurifGBHD099yxz/KZLqRwA+6XRB5osTT4lk5h70l0/zdHK7iwTYqkJYTcKy5a/GG4sAGyxUeMQrBUXg35CBVW7LsnR6zYBlb6w5HrYxLvC2YeSTRJ9w/SB3yO4+Nc4GmbJDsq55S0Rpen4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825069; c=relaxed/simple;
	bh=LW/VX07jzudxQHb/HdVxbyRqNpGOAAzeMSyYd+wapZ8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clobLePS7mcYkIfq7KpY5dmNryK394gqL9R+1O3xD5G34FIL3YfXU8ibQK8cIXYOyAn9HFhdazfH1kh7hh9M7HGHVNWet6fwdmgIAhUNDj00gW5GxGztvlzXgVDPvco/UlgiRNbC3I6uqfZ23UlNanoJy6N1xF9XgcUGXKz0xcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijKSo1/6; arc=pass smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijKSo1/6"
Received: by mail-vs2-f42.google.com with SMTP id ada2fe7eead31-798396c2ec0so918725137.2
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 06:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789825064; cv=none;
        d=google.com; s=arc-20260327;
        b=Fj1044GE8qKbgfmjx8j++p8z9PGwashnQtiijrcYUgr2DPZ+3uJX9NbZFHnfmMJcan
         51QMVesXFe0YWacfPXH0qeUxbBWRHxg99XeAElwDShm1dPL1pN5lQdKOdEbx9iShEk0u
         MpFC+7FVe7CfUU0FyDRUmmMyxqA3wwFGPAvKUWJe1ngPApIGfyT+kT6Dvx/mSKrYgiTU
         3i4QeJ8WcDlXpbDICVlyG5roxDQe+yomO7VBF9jY47N7z+LB+34ATuIu6RHj4NdGV7bQ
         Q0zr8kzqeVvThaMDLVitThcIRqGvNKiqYD9AQE5MfHDSLlFBRT/zG5F6mMzFdQQL2A3a
         hX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=978u9r8BPazSzRQeIRRQptZXLb5NjTD20pp5wpwmsQs=;
        fh=AtArL3ewF/76w11aAwbL0Z+W0x+FiBX99+At/SbvRoI=;
        b=TTNwjPnGh404Vj7VwbuBkh6WliAi/lNBc4U4KdXydw6dNSsl2K6HjPnHS4fWfq0HgY
         DYOt3jTJkCoIIrmLxUq3lrpToMhUz+bYyaOH48W5bYS8n58UrKnFzddFi33uT9I+l50h
         4IBa46pO3m+t69qHsgheeorL0LIToxEvXSEdx9D/GPUzH+9yKMxW4UBS+yBF2DuG8xGu
         BHACYzMjJ+9xZPHu9y91MOawEd1t77CKG9nq/iHm69nq7dYdY5aS6SF8IrkDmxD1V00F
         vNJZVFXk6KutMqtOXc6Afpgi7INnyNyhuOVTzH8kMnRHnkeinYROse+ll4sNzRynRWig
         rn5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789825064; x=1790429864; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=978u9r8BPazSzRQeIRRQptZXLb5NjTD20pp5wpwmsQs=;
        b=ijKSo1/6A42nfpZOaIz6YjzMOscUadE35nTw2a0H/qNWJLjRzz2H9g36OFnKh6gwcY
         ZE4tz9dgv3qLkZ4n8epnnaVR+mIBjH5kZGbk4PY7U4TCYKrJ9iPStJNb3X82jwHw6wFH
         Dr4b+ePrGmFaPBtKvAX0Re08gQFmI7dgWNJqAof9QbOUOggF661B6KZDdk0+olikWGPN
         khHpwm1ntnStgE8gV+nQEBxgxtPVJ6pPNkAA1HKREFy2P1A3QqMNWAh+lzSql1xy2LUM
         4n/tzySP1E0SVeX+1Ls98XVnsCfaMzyvDqGa5RxMeMsVJejujzNYOlvpMir/JedHbQJT
         w8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789825064; x=1790429864;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=978u9r8BPazSzRQeIRRQptZXLb5NjTD20pp5wpwmsQs=;
        b=U6GgQHLj4dPge2Q+DagFwc0P280ogSc4uutvliQHcI5FuXuDQ5tyRravFE/D7Ql8Mm
         FcFvKDyb1nv6wNkylE98uXpH53GVHCr29IUjgO20wNQe+pWO+WOKm20kNnbUYoSBUjSz
         rz02HnPK6q4EKvPbLWhuX4f9tSpYS6cVKWn9t4gl091sG/+0of9rIr9gsrzVI2ulYQZG
         p4M8rjzXdvkMzqez2ioZIMblt1n3LkTnSFJ4PwhF9a+pdORGHajjrF1mQD38MiOO3HmV
         YfVfzTvNK2CXnRguw/gH7SR//+lmbIUiXdmCJjuCjXInX34zhVXe5jSbzfscID9GnzkE
         b4iw==
X-Forwarded-Encrypted: i=1; AKwUvBxZmpH5+vMsv9oiOeB5T6gTiXQ6y1qmMnUyj2fOqeW/Pj0xkTG/5Jgz8N1e7GoqHfZg1ZQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nYQZ28K47ZBSGKNGFBomATp9RSSCm9udNZ5QAez24qIHQjgarK
	eTc1qFLbqBuCR4KlIoxrCY0dwXPEHmrwtd9xrD4gSrkiuswamWLbF8CA4FKJHll72Nz2HTeOvCw
	laJFK7/305CSVaSjhb9Rv0vTKC37EaGG3ui9r
X-Gm-Gg: AYBFou2UY2pwK4b/C0UssHPqW5cD81p/CBtLHQNKwqQOnauVo/MwqbRLNj6VMbWUNK8
	QhJm1z3bz7dnriT1CqoV1xuyrCz2m5CPLgT9V+8eOAeriq6gh5almVLhV/0nmpGSXmVABrjHoDE
	6TVGr0/hVwbHzSmoYxdiFgR3OjYtr4Sj8RR+OA3Zn6hmY21DwGW3G3b5pYp3me9Vux/rxVy9WqI
	rQQELseS6LnoKHH3bfjEy4llSGdo++UGMA7opSuqru8ocW7ECLHzp3i7SI3hiCdEy+pqlMRLtSH
	MHEDE2m70y4UIxuvWSjQAzOAgH8y82r3urnHZc4olU5cjjyCqrILDLzMfQYYqe+boFp2bmhxtxH
	Enpv4kxxp7qIYQ7bYLi2LM9D3svcMCt6l9JZFl65wUl1eIw==
X-Received: by 2002:a05:6102:2911:b0:7a7:198a:c2b8 with SMTP id
 ada2fe7eead31-7a7198adcfamr418112137.32.1789825064471; Sat, 19 Sep 2026
 06:37:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 19 Sep 2026 06:37:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 19 Sep 2026 06:37:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Sep 2026 06:37:43 -0700
X-Gm-Features: AcwNN1UZA1xYV4hPogPcnw0gzUMiX1pzrb1TF6bQyQK8wsvXgnV1fcxAs54KWug
Message-ID: <CAOLa=ZTgF+Qw_1FMUEF-YyBYo-gKnhPVk+qxd+gt1PMrt9GYqQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] gitlab-ci: fix the cargo invocation in the Windows job
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="0000000000002db1e2065bd61fb4"

--0000000000002db1e2065bd61fb4
Content-Type: text/plain; charset="UTF-8"

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In https://lore.kernel.org/git/xmqq8q4zosri.fsf@gitster.g/, Junio mentioned
> that the GitLab CI seems broken since I enabled Rust in the Windows-based CI
> jobs. This patch series should fix it (lightly tested, but I don't have a
> whole lot of build minutes on GitLab).
>

I've created an MR [1] on our team repo for testing, I'll try to update
with newer versions (if any). The pipeline for this version is here [2].

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/671
[2]: https://gitlab.com/gitlab-org/git/-/pipelines/2863888081

> Johannes Schindelin (4):
>   ci(gitlab,windows): provision GNU Rust for SDK-based MinGW builds
>   ci(gitlab,windows): preserve exclusions during dependency setup
>   ci(gitlab,windows): fix Rust setup for GitLab's MinGW build
>   ci(gitlab,windows): provide GNU Rust's host-linker support
>
>  .gitlab-ci.yml              |  5 ++++-
>  ci/install-dependencies.ps1 | 22 ++++++++++++++++------
>  2 files changed, 20 insertions(+), 7 deletions(-)
>
>
> base-commit: d38352cd43ab9745686d697872408bc3249a153f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2233%2Fdscho%2Ffix-cargo-in-windows-gitlab-ci-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2233/dscho/fix-cargo-in-windows-gitlab-ci-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2233
> --
> gitgitgadget

--0000000000002db1e2065bd61fb4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 10f93a70d2991bdf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xdWtDVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMEZjREFDYjRyYXZxN29rQVZBYU5WQThvTVNZemlXVApZUkJ6YzNFZGRK
a29jYUxxNTlRbVpTbFdRMjdjb0FlQnl0MnRERTZsK3dpMUp3UlhmR0llMjFLZlJuMC9SRk11CnBz
b0NYa0c3S0RVLzgxRFRlT3FBRkRTVTFDeklYYnZRSllVSnVqQVh6VTNMcGY5V2RmTFhEemxpWjdq
YmRUV2MKb3ZGajA4QVJnejRjazNkL2JvMEU0dVN5MStlOE9pblBTWVdUbGR1RFBaNjFBUkpqdERD
SnIxUkFKOER3UjdqNApoZ1VTVVhrLzM1UlFTam9CejcybGt4N1ZLVFh6ZCtEdmlMV0ZsZDR0OVd3
OFcxYWpWT2JuSzY4SjFScjlhQkRGCmljdVgvcW1VTzUxc3daTWZ3OXZ2QWJFT1BhaDdoK2o3LzdY
Z3d3WXBrRXNMdEhuQk8rUVJKRk16KzVSTkZ2WTQKWm5ZYVJzYlBMRFplN2ZVWGtxMExQYkZuOENh
SG53aHAyTVlDMEN2aWVEQ25WNUNJb2t2TXY4ZTVsZHNERnhyeQpwV2QvMFJFOGRoQW5iUEhjQkQ0
aXdZTllWazN4RUxmWVlRNUxsaGozanVsZVUzSndESi8yZ2J6V085U0RISEpLCnYyMWl1eW1DRXZx
bkMwQVdmeWE0cGNHOTY2QW9nbEFZL3ZYZ3VFST0KPThoQkMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002db1e2065bd61fb4--
