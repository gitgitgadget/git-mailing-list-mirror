Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C72512EB
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375178; cv=none; b=cx29AiKFmzu+SeQdGKdHuxl+A51DLiMZZB09FMCMEvkANbGJVvl4msNIYl8IbdVfFX4Kq8JvR+fqJD0zPvqt1iJr1jDDl26WF+99XeA7deNut9Hur+zcOMgAnzYrJa9PObqcXz4c+eIJ0e+UvHM8WFw8JRdukQy8w7X6DTLkjr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375178; c=relaxed/simple;
	bh=VCxc34QL3nNmfHFsNYI6LiExz2lUxbi2ZYaJ9iBxh/w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inis3NXSpVsu03EyhKqwAZSiF8Urvcvrxu8naX9ktSsC6rQ38r36KWWVCFexHVAsn8w9k20To7ukKD7g535ghr8Z0/L5yDuPHGOFG8YGeZ4wklWEtJSIU+Hp5K37ixGj+414UOV2LDayhQgIi4RfLxD7YMatBWQ7vNiorZxjsJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMOfMF5S; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMOfMF5S"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d3ac0fec0so6240895241.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 02:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742375175; x=1742979975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Mt6xlyLVkgXyJ9Tw0INo1VgR9t4ljImMaJwxHJa06I=;
        b=dMOfMF5SRZxt7nv/jhMxVEuiOOb6u6eXSWYfNVU8cYhEDKzo0NJRmLMoc4qNPzVuSv
         3M2O9Fy31NPbmdII2KQXgld0tc3bvT0N+oxSAJrJfveGOipgUKBJc9R/DDGzpguE+Lz5
         1SCzTivZgvzN9YS6Qa9iuL/tkUfQMySPC6TVRMI+V4ig/1Cjxxufk3uAh6KFcpQlGi/m
         aQO1ERsQsEi+eaBiDN6+jLToeTUMV2nXWuZSqciIIPtaPreLDANkLmQuPJf/EiiaH4Co
         hQESyVFYrMfx2i9U4wOOxTn8uZYYKHATYHUn64Wujy3OyshOxhwhYpUmJQGUPaDUiP/b
         5VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375175; x=1742979975;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Mt6xlyLVkgXyJ9Tw0INo1VgR9t4ljImMaJwxHJa06I=;
        b=OkkZbvDLZNJHCiz+7rbegm1lQ3lGrTZGZk8kq3xV6NdIoGAOvfY4L0zTi5OhEV8ifs
         FxWkbbwfmZMBFP3mCXcn+6Y3f4gZKR7A1V4uG9vdjALxO8FkpLI6ItrFV/JBTwBOgSZ5
         CLl2rrwcHouPQGJ74EbKdmtKCw0p6dU6ckM2E16DZ1xeINgIBQCpr8udt3FyLHcmEVEm
         7qNa0MhZw5g7lae0Gk9vbIFqp3+Ox3aUFw7/d0NuW7BMbwJ6F46G193vftTV9fQxELhg
         sgWCQOR7Cpq2ejeW6ds1jDc4bWU0X4z4kq3Y8nkzcfYQGQuC7GA/iG2UTQUOFpILj+dO
         H0Lw==
X-Gm-Message-State: AOJu0YwPSdHdiiQUiwXPSzJRqELIiYJP7G8sGlgG058EUaSugHrXDrrX
	csW0Dt0JEYcLz2sdFFAwrugr7dFlSn8RgzaQyj0qUiEm0JBOMrQWinepONSEp3vCZa7504RKrTl
	aaoHiIyl9gGdl/Yzs1z6H0fblLgk=
X-Gm-Gg: ASbGncstD6g6hubAM2H3t88yLBgkjHkBYfgJvi3wFegU28ZNNgRpBsRpL3Hos9S1ksn
	JU98OhL/bRZO1Ppwk1XRfpH0kqXvB6X2Z1DZPZM8TJr1YTpzfYSKSoNjXtCw+OpPmfWVlwiQWX1
	EknLgLHtA22PKrk2VPbOblDH7cNhcCC83UraoAuCmb6ZZDiU/QUZXsoCd/Ng8n
X-Google-Smtp-Source: AGHT+IE2KFvsR3ZXdW5fVR3BYhDLAsVHQDnZnRlKHKnn0jhWkyNU8AvTDVfJpHz2I4rATLNn5g66gdJtECEiKJpeLmc=
X-Received: by 2002:a05:6102:8008:b0:4c1:806a:3b44 with SMTP id
 ada2fe7eead31-4c4ec6304e6mr1177322137.2.1742375175122; Wed, 19 Mar 2025
 02:06:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Mar 2025 04:06:14 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD1vTkPH=5b++6+=koozC31=wD1gQszvdFmzb73B9HM4Aw@mail.gmail.com>
References: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>
 <20250314-493-add-command-to-purge-reflog-entries-v3-2-c24e23a6146d@gmail.com>
 <CAP8UFD2+xQQbUevHTQangg__dq2M615pHLhYYUf7b9shpShD9Q@mail.gmail.com>
 <xmqqsena2pzh.fsf@gitster.g> <CAP8UFD1vTkPH=5b++6+=koozC31=wD1gQszvdFmzb73B9HM4Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Mar 2025 04:06:14 -0500
X-Gm-Features: AQ5f1JqEWvk5vTL5K8aStd7CBCTXqfRkRhsV3szBszKGz3wSFTXNvrn5UbiJMoU
Message-ID: <CAOLa=ZSj11TSTs6CywSX1Q9AAfW28zssS2yrGf8PmBOgd06Etg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] reflog: implement subcommand to drop reflogs
To: Christian Couder <christian.couder@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, kristofferhaugsbakk@fastmail.com
Content-Type: multipart/mixed; boundary="0000000000006119980630ae5525"

--0000000000006119980630ae5525
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Mar 18, 2025 at 6:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > It looks like 'single_worktree' is only used here. This means that if
>> > a user forgets to add --all and only uses --single-worktree, nothing
>> > will happen and it seems to me that the command will exit with code 0.
>> > Even if `git reflog expire` already works like that, I think this is a
>> > bit unfortunate.
>> >
>> > Otherwise this patch series looks very well done to me.
>>
>> In the thread Toon too seems to have noticed the same "what if there
>> is no --all and --single-worktree is given?" gotcha.  Together with
>> the "current would be better name than single", we can consider that
>> these funnies are to be "consistent" with the "expire" thing, and I
>> am OK to see us move on.
>
> I am OK with moving on too. We can "fix" the behavior and naming later
> in a dedicated separate patch series.
>

Seems good, let's do that then. I'll see if I can follow up but this
could also be #leftoverbits if someone wants to pick it up!

>> An alternative is to "fix" the behaviour
>> and naming of the "expire" first, and then use the same improved
>> behaviour and naming when adding "drop" as a new thing.
>
> I would be OK with that too.
>
> Thanks.

--0000000000006119980630ae5525
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c4c525a23b8b3b09_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mYWlRVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0VMQy80aituWnMyajFMYVRWSXplelVZV1A3bVVhQwpIWnJtNEJLOFFl
NEk2QXQzQzNXUlJCdnZDc0xWQlRUY1VYRHZYK0UzVFlveWwzMlFuUmFyc0pTYmxFQXVzWkxJCmNo
aWdOYlBsYzRDMVcvQSthVTQrejFJYTF5ZFdFRFFabGwxd1pFalVWM3JaaWV3NWQrL3NZZHllSHkw
VDdac2oKbm5ySDN6dDljbDFEQlF3cFpDNmJraU0zZEdsZ0RGWk1BVVIvWHhkUEhGeUxlTmZRamhH
YkFYOUwxd25LcGVoTgpQLzlqUHdkRHI4b0c2b1JZd1M2S1ZNWkdSb1YvVk01aXV5VTMvWW13V2d1
cjNyZi9HRVluYlN4SXhxNmExalVDCmhURi9YdjBLTDFHaFd0MTJDRkhtck92NXdaL0RIcGZlSENq
MzZpc0JPR2hMSk9kRmF3UUViNHRjY3RueUllQ00KM0NVSGxtWEZIcXA2aVJPMjlFNkZDYW03UWtq
K0JzbXpodTlXaFFXcTJOMGxtenhDOUtJYVpkQXV4MjRsK2NnaQp2WjFPcDlJUzlOck9GN3ZRdmtr
Um05N09TTHlNWm9BbWNsZzRzb0JuR2lxQWltbVFYQVgrU2tqSHlwVEdrSUxMCnp0aGpqbk83bEhI
dDA0dElaS3Zoa1RNdGdoNkJzTnMzVVRsRC93TT0KPTBhYXEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006119980630ae5525--
