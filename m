Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1E433CA
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274777; cv=none; b=ZP4sbDwkCmQtR63JN4DLanOk1NDOSCYyK6mJVEmzmKj5HC/lTpU0PlosnwpzuS39pZDsZx4t/v7redqeymzCUj67Ya/EHb4ecbvApHybWIWJfqxqISEHpVG/FfGPuLdD7/a6sCJednb6D/SMkXVBJGpcJPBGUTFPt/5tqzfvXcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274777; c=relaxed/simple;
	bh=FmdXHQecb6ebPLNThGK9/XGgg0WshvXpOk139o6XXQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcdWI8zsIkdb36oS0BHTU9BhEDpjvW2MwEJDct4cGf5Dw/g80/1YVM8r6ihcp0E+vFaK8BA7sHXXOnvExRrrveiGBUJ3K3C5ie9P9N7STbTUtrIiEMzP+7Y2lPCsLQ9546miXCtwk7ZWX5eMQOId0+7A1WzyNbmhMlkafmsEyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb33996b79so5660466d6.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 21:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728274775; x=1728879575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmdXHQecb6ebPLNThGK9/XGgg0WshvXpOk139o6XXQ4=;
        b=YcGqHI514fG/ULE/IZCPJkxLpNkQYlPJTHqYR3ei+XhuYiLvz42vgp/5JgfLsroCPg
         ZqbhLigonOMWFwm/mQrXH+ZhPGPaMr8D5PKPi+zurmSw6vGw80cNn1pq8XU8xG+wdyZu
         pgd6QDr+ZzDjJenjZ0MuP8KtfJsqXLxp6E1oxkpJWGr5UvW9dtdomDQk37kbacsdU2aQ
         hzcfpfZZ86pa+GFBNr6xVci6BypT1CATJbYhZVAEtvrZUKZZWnvfKq26U7zgYJZzEksM
         Mns6Iwa3izXeLKdJQsqZZdU5XlRGPdww5LH2TEgDcvvfJtJBxz477g/s5GnBArQKFMv0
         Bvbw==
X-Forwarded-Encrypted: i=1; AJvYcCXv2osjlkG1SpMOtocm1S+DebIheq1Zd4Fv7JsuTfZpQCTS48+HJtW4ko7b7R4kBxHBHx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq772Ts2tJI8EyGqsNwYY4d8t9rqsCxVuacX7iDzTCRm0Dhq1S
	iz8D7/mg3FTFQDOsOFEq0vQYgZyki16yYApuAks594jWzT42rju4LscKi0fYYlYNffbBdRC9nc8
	9OvGQ4t+Xp+Fg+blNrqCA0k9riGNx/xEo
X-Google-Smtp-Source: AGHT+IFePQTBrVtIi8Ab5h6gLOOr3Om0esnsYTgP4mmLxUs99K3eiKWQbR+TVjGopRfCw0wbh57h1J6ulo5f2pqx4uo=
X-Received: by 2002:a05:6214:d48:b0:6c5:20da:485d with SMTP id
 6a1803df08f44-6cb9a02a733mr73312176d6.0.1728274774664; Sun, 06 Oct 2024
 21:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>
 <ZwJwsuf5ZOKiWbS1@ArchLinux> <CAPig+cTVf=W5KXkE2iTxCSPmZjOSbmf90J_JugDuTH_xudcW2g@mail.gmail.com>
 <ZwKCxHzbWxNQ92KR@ArchLinux>
In-Reply-To: <ZwKCxHzbWxNQ92KR@ArchLinux>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 7 Oct 2024 00:19:23 -0400
Message-ID: <CAPig+cQHqXrhBQbTx0msqzhNpeK1Uzv2XKZ2SmTmgaFiCcktZQ@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
To: shejialuo <shejialuo@gmail.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 8:29=E2=80=AFAM shejialuo <shejialuo@gmail.com> wrot=
e:
> On Sun, Oct 06, 2024 at 08:06:10AM -0400, Eric Sunshine wrote:
> > Your observation about outdated/confusing "[foo]" annotations is
> > certainly something the submitter should take into consideration for
> > future submissions, but does not seem worthy of a reroll, IMHO. First,
> > `git am` will strip those off automatically, so they won't become part
> > of the permanent project history anyhow when/if Junio picks up the
> > patch. Second, asking for a reroll for something which does not impact
> > the correctness of either the patch or the commit message just makes
> > busy-work for the submitter and wastes reviewer time (which is a
> > limited resource on this project). Third, the point of a microproject
> > is to expose the submitter to the workflow of the Git project and to
> > the review process, and for reviewers to see how the submitter
> > responds. That goal has already been achieved in this case, and
> > rerolling for something so minor provides no additional benefit in
> > that regard.
>
> Thanks for your detailed explanation here. I don't know that "git am"
> could strip those off automatically. I thought the maintainer would
> delete "[foo]" manually. So, my main intention here is that I want the
> submitter to make it more perfect to reduce the overhead of the
> maintainer and also pay attention to this for further submissions.

Okay, that makes sense. Fortunately, the behavior of git-am means that
we don't have to worry about that particular issue.

> And from my perspective, the reroll would not bring much overhead for
> the submitter, so I expressed my words in the previous email. I know you
> concerned that my words would frustrate the Usman.

It's true that I try to be careful to avoid asking submitters to do
unnecessary work, but my bigger concern is that there are many patches
being submitted but very few people reviewing them, so it is a good
idea to avoid piling more work on reviewers if possible.

By the way, I appreciate that you are helping to review patches on
this list; not just this series, but also larger and more complicated
series such as the one for making git-worktree employ relative paths.

> And I wanna say this
> is not my intention here. I think Usamn has already done a great job for
> this microproject to understand the workflow of the Git project. So,
> actually we are on the same boat here.

Agreed.

> Let me withdraw my previous words ("We should reroll the patch"). This
> patch is good and don't need a reroll.
