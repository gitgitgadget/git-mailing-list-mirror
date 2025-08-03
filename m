Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418F119755B
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754262397; cv=none; b=dcBMRcoKdp38QuE+1GERSAiVh+bQrvtc+9LlNFd4/hlfWn8cTNF3ASiyYF7U5x9ndwwDqb/yRfPF/YQMCgeDOmDqQX5tgOwx91LV+ZOJoVgNgbjCxBwJbIVWPA04sGEu97k1BNTH3P+7KJFJlUyvaSDSQN5PzFHtkw3iGOHxaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754262397; c=relaxed/simple;
	bh=eMMVhkq6cNpEANBo8CQeJ+46hG/ztD6MQ9mneBpTCFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POYiDgbkIQSoS3H+DjSiySidmUH4rI4dyPZ+7snV5XUzyk6ZtZZ3G9dS7n7DjoIPnTfiFs3+ziHnIDk7MMYbqmvlOVPOhQ3eF8IwKgCqYHxcu2KNWMNINtbfNECNoB6f+qZLhHYNDVXJZdqmSxGfGoLlVKwiu6HRH+RJ7vm/r5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70742520205so9651766d6.2
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 16:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754262394; x=1754867194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMMVhkq6cNpEANBo8CQeJ+46hG/ztD6MQ9mneBpTCFg=;
        b=l1G0G3FptvdgoymY34QjsulvX/aAP7BRv9Xt690PVnzzxIcwicSpXT7mM6T3Syw9lD
         9HFQ011UxAVtYiwO/413yWw6rWrtE5qC1tVKkTBA4H/tcFxjENaYTHwDvOLXI6mM7FTc
         vlANV0rqdpGoJRQCBVvVntIbQ101MbQS19D9LCgiyCZ2SLrhacuo64W5nbXS2caHpEKD
         eQOdgzvDm1tHUzUsfs4NPTPLYxVduC/DyyNUqulj7x1qMG08QF+UlO9P99BYR+XQiCNA
         1lhT4OyGkQiKhr98pXONkHBl8oRyM6FQFuM2W74dqrq37enjIh+lAw9R9uCrQmXuRdqj
         MmTg==
X-Gm-Message-State: AOJu0Yz3lLN6qgb/3ReNbRUp7MqaC8hfug2ECtXACnzYgKkKiE4g+kzE
	MZcVCfb37yTlKOeI060NE9VxWz2RDy5R3NNwpjLS6weCD64VKQWkor8em8hKmFzuSVs3CshtQE2
	0Q/9prvpCt982lz7LC10izsFaITYZ9rE=
X-Gm-Gg: ASbGnctVhseS8AxTgzNkJOlb6ZBtU45gCWToaSLtMlq+Lqhn25Ge/vhiH/z29uqQZAB
	wX5wHHbF28WzI1qoDZZ41RBhrnks3CAvqa83WY4PWHYji6xNlUUYPMXo8G4n/f9JMcoZCE30SyV
	8sV0Ko1zXFqWkCK0MCGxDLp0NS7PEavG3UWoP+FhMB/ZQMqg8SIQyR0ANjNcnbqpA2bNuGWFpYi
	QGG1HMtuE+2UJoWx3f81pCuws+GFKTU6v17fvlP
X-Google-Smtp-Source: AGHT+IHjRl/3TWgnMmejUeUqWzMyICvbwqiO8O/P7CNu1k8Arl+bASYPctKAkuqOQetoTy9mKnAlsHbBeEGfjxwAc00=
X-Received: by 2002:a05:6214:509c:b0:707:6f5:7f99 with SMTP id
 6a1803df08f44-70936300021mr49354736d6.6.1754262394014; Sun, 03 Aug 2025
 16:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com> <20250801131111.8115-4-lucasseikioshiro@gmail.com>
 <CAPig+cR=vRu7GwGx_wpS_GZNdX7giosDK12K+qQdOW1va-6oWw@mail.gmail.com> <DADE940E-482B-45DC-8020-BD422FBA7B2E@gmail.com>
In-Reply-To: <DADE940E-482B-45DC-8020-BD422FBA7B2E@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 3 Aug 2025 19:06:23 -0400
X-Gm-Features: Ac12FXxxCYmx6Ob_vPF70qm9A9YwpGahxC71B1mFhLcJeJRWxX3S_LPY4JTQexE
Message-ID: <CAPig+cSqrmoC68Yc5OEb7oHS2V6YsWL-bfiPh7bHCQq-MV-fhQ@mail.gmail.com>
Subject: Re: [GSoC PATCH v7 3/5] repo: add the field layout.bare
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 6:54=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> > The quote placement used in these calls to `test_repo_info` is quite
> > unusual and more than a little confusing. I'm guessing you did it this
> > way to avoid having to use a backslash to continue the line or did it
> > to mimic how `test_expect/fail` is called
>
> Yeah, that's true :-). I'll change it. However, in the next patch, where
> I add `repository.shallow`, I need a more complex script for creating
> a shallow repository which needs several lines. In this case, do you
> think it would it be better to use the backslash before the line break
> or would it be like it currently is?

If you take the suggestion I made in my review[*] of that subsequent
patch (specifically, create a separate "setup"-style test), then I'm
pretty sure you won't need to use the complex script for the function
argument; it should collapse to a single line as shown in [*].

[*]: https://lore.kernel.org/git/CAPig+cTtJHn3NxrXF-AU_0cRzccDOo+j8JTAq1Jyq=
m4BzXBpSw@mail.gmail.com/
