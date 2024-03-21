Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005EC2D630
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710998496; cv=none; b=kM+TBdhBa2cPX/FG9A/CZweNdTp4at6Sv2Gbu/qsJCeA9r/11EqkAS4YYUueZmPfy56boICOlaAtXr7cFj0ZV/2BG6BBuu/dB/SpBBJdOBEFltF1GpIZZY2TsV9KI0rY/Jv25Xrqs5HgTsjSi2TTR4mDv+gaGcueQAdUYtS45Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710998496; c=relaxed/simple;
	bh=qHXCFlal8oSxgF9GL0zk5+wh/rCsMpPsbLxNI2NQdC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhFoC9Y5W9z/4n6u/K8enbXV/KCZYsVN8zcRyomysvkL1HW2zRUEH/3hQfRBKYDrRpbJLIqq6SFO++9OHscrRVCQcQy4+4y+z9IweWwAbL7gA1w489J10xLsNuQLqJKJuUYdpJFMqUe3mULDUninZAtsIu8JiVj8vZDIxN20KGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690de619293so3964346d6.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710998493; x=1711603293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JMcMQEHBOtg5JeqDSYdWSB2jvkRKkjAPIIvd8uViRM=;
        b=LJnKzU3XiwgPHxSozvcVre1jWSZAryvvAyJOgYB50AW3phcOObM11DYRLhHZguVnrb
         oUk8h+n0eJnnCDyFpVvZSALKtHrKrrNbyp26l5WOhDRJoJZbQrjhzpIRoCg1N6yLYTKL
         3AolyIfCHK3+ShKfeqE4koE5OZCUiTjdaW7Kuw1IT6wysrYiOZsU0k5lQ+owJY9lUPEU
         oPSN2kwP51FNRx08KR2Lw3hvQ3JDve+s7ngw6Z5IuYlbNi6fphWuo1xm1uR9cT9cXt0R
         mUqgpvrd6FTBAQaqIh2caQlwQc+mnO6c2kNQqcANSnP0y2lM5tBEDfHrrk9p/YxGYhEE
         Lo4w==
X-Gm-Message-State: AOJu0Yw1EC4P7OjV+slFvxWp8HMnSCYycwBmyn0784tlLpNFDKbCOJQY
	CUxdyNupBy3/IDovJnIXqUT4SzqKtPIgb3IzeEqIk3JlbZYx32MI7uAtNvS/YziK4s07xg6owjk
	LK6SN8/ePu3AOev3I1QYet97V9CE=
X-Google-Smtp-Source: AGHT+IEPgGZXdyxRR9AwSGcdGQUClTYGk0n+TPkUDUmZWIRfHv2gRnrtXHXhj8vmnbs4BiM4mYE+KLiC2RECCY7megA=
X-Received: by 2002:ad4:53a6:0:b0:690:df46:2ebb with SMTP id
 j6-20020ad453a6000000b00690df462ebbmr23057693qvv.56.1710998492906; Wed, 20
 Mar 2024 22:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710994548.git.dsimic@manjaro.org> <f84c5e8e4a90be3f9fe3cc853e0d40aed4e58826.1710994548.git.dsimic@manjaro.org>
 <CAPig+cSYhYBa0NsvJCOYo4JsWzLJT9rU++U1QKA3jRB6Cptbhw@mail.gmail.com> <9a5217f7f7a35768a3eb45060fb3e4f4@manjaro.org>
In-Reply-To: <9a5217f7f7a35768a3eb45060fb3e4f4@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 21 Mar 2024 01:21:22 -0400
Message-ID: <CAPig+cTgbjCg5jkidEufgHgpkPOZPhfSbd_gbBxOFK=B8mX+fw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] config.txt: describe handling of whitespace further
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 1:16=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-03-21 06:11, Eric Sunshine wrote:
> > It should be possible to rephrase it to be more definite, while
> > dropping the final sentence altogether. Perhaps:
> >
> >     Whitespace surrounding `name`, `=3D` and `value` is ignored. If
> >     `value` is surrounding by double quotation marks (`"`), all
> >     characters within the quoted string are retained verbatim,
> >     including whitespace. Comments starting with either `#` or `;` and
> >     extending to the end of line are discarded. A line that defines a
> >     value can be continued to the next line by ending it with a `\`;
> >     the backslash and the end-of-line are stripped.
>
> Looking good to me, thanks.  I'll include it into the v5, with
> a small grammar issue fixed.

For completeness, I should mention that I intentionally reordered the
topics so that the most common/important ones are mentioned earlier
rather than later; i.e. (1) surrounding whitespace ignored, (2)
double-quoted value, (3) comments, (4) `\` line-splicing with.
