Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B3825FA05
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399873; cv=none; b=oAmOFfivUUEbe6vGHcLTMq3ZtvxkZVWtnvPwjBWvucwEncw4+ta/4g8eDM1a9KY6AAL1mYffFs3M4stEXCBuBNE+Zf2gp+ECibCTI8BTPcgf4RNXG9D/R7dGKRGwd8STvYR5fLxy2M8RvFflAjzxabARsskj5a0C++UP6qLSX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399873; c=relaxed/simple;
	bh=jcfBpeYW1XV6KFJYxDn9CBhsA7+LwnY2aTjZCwYzYTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iesUTjfQUTIQriKuV2McDdsVhWIQpaQ4XRO/vvHbkegzfSdisHph192kXdzXboFfUWf5T3K6cYxIzsMSrZPpvsRtUpkTpgEhWkNMxrNzgA+nRBtmIMu/9IpRasXn8/czQU76M+wwV4lJ+rJqLcRQynIZ/CkOOHMUJi48jTodqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxnHofQB; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxnHofQB"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e854d14bdaso12282355ab.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756399871; x=1757004671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOnnW2qK0m1wNHknIUg24awb3O2zLW/fJttl6OtDUzw=;
        b=cxnHofQBlZ7VYdEy+/tqctK0Rq/RB6wxNw4oYUB53e3RvqU1UzfVgyalMnnoe81DwM
         AXhrP3tee05WrDm8aPJa4SPnPeoyPtN1jKuI0/VnrPRc+4OG9kQyxeYCHjLiUCK4UhBH
         JNMoYppFhQfwTB/8ytl98Le8VlmBJtdc65oX0tzKc+6sA37SvBzorP1uHgsQfZ3ezVwu
         PewZWjF2Nop5JohjTGRCHegFzgBw9/lumUUKvpBal6CLZBKo34mfsaLy3XJOQImfnyxf
         otGKAHByFCWhYBa2FtGIsVZWmkebeQzwrPsFJp8g9SuXXD76ftB+UJETfLW6coCB/GwP
         FjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399871; x=1757004671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOnnW2qK0m1wNHknIUg24awb3O2zLW/fJttl6OtDUzw=;
        b=mrqLEz7M1/bI/aSLjvt5KcVwWT8SEvjeQwxb+bDjDcA17klzcB9uCMMRRyJe5fI023
         g3VBWH2AnoLl+BNasftOYq8cpr5G/I2NFh6yWISj/dT3TdHIxFguN0zSPXp5qYw0EHrp
         vgeCUzDKRPhWx4CnA3GmpQDnZv+NppbGBM2twwLwXl8UhhPdkjD0qYv3PEUgSvzWP17F
         SFacRQ+lrMccqXflDlbSXrdShKAf/j3KqJCqYa4ooMbNguqyIASSqhgYsXFBja++Jb4J
         ushSgb4hRj2Ext6fBr/+JrCPwnWf4BJiKSb7DH3QYKZ2p2ykBtyORPvjNFMl0sSXGFcx
         liiw==
X-Gm-Message-State: AOJu0YylYm1w47+KWbkf1OYkUlRUFEMC9PxTIHAS/KNcNZdOJUIe6KxW
	kpJJSQJ3K66cq1LcLh2Qv2DM8Lchaii/G/gGfJt3nHQ1dUClWQgwXLo2IDdJevn3MZlUjXA+h85
	TAK4xxEwxiiBU1hv5lqFbY0wYJSdLSWs=
X-Gm-Gg: ASbGnctDGgOjUpz6Mz0/Q+fbWW5zcxkrVqsYA/SpITp9EdcPjqhbCMo2p87wp9b9mpG
	vnCWvRSszZgT187n0pUYR+UCjIYSo65SbTlXXMqUD+IlBFnffPVxfG9xkhxzyiLcf318pPfPXDs
	LdUpt0W47K+qud0slPOawaZ5c+zDUKzJ5jFvkNJC5HClnMK7EIqThy6lnw/gK2r0u2AbMhpXPNw
	UddFo4budV3duNPOOqqlbercQ6DPw56DIdg2mDZL7/du9VvZpc=
X-Google-Smtp-Source: AGHT+IFYzUO+vEvHskCNRXgXCX+tPhaEqP2Tc4LFmA3WrkaIVDqGb8Cnk2uP3BqnSZKIOci43G0aH8iD66vy831Y3rE=
X-Received: by 2002:a05:6e02:2784:b0:3f1:258e:93cb with SMTP id
 e9e14a558f8ab-3f1258e9425mr49709085ab.14.1756399870691; Thu, 28 Aug 2025
 09:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADR1ei4LFVoLhMyya+wx8dXBmrRNSNy6L5Ye_MJgL4kzgtVR_A@mail.gmail.com>
In-Reply-To: <CADR1ei4LFVoLhMyya+wx8dXBmrRNSNy6L5Ye_MJgL4kzgtVR_A@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 28 Aug 2025 09:50:58 -0700
X-Gm-Features: Ac12FXwek28guqkmdxF46rf49OmrzXgEuuDQZdT0n2fKPTVNmpmO5y8kfOJOvy8
Message-ID: <CABPp-BELxkVgXPJtQj1XACP5DSCiPsW36erQzMGSPwpsY-o-6Q@mail.gmail.com>
Subject: Re: question: what does "garbage" field in "git count-objects -v"
 represent? Is it broken?
To: Daniele Sassoli <danielesassoli@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:33=E2=80=AFAM Daniele Sassoli
<danielesassoli@gmail.com> wrote:
>
> Hi All,
>
> When reading the output `git count-objects -v` there is a `garbage` field=
. At
> first I thought this would highlight objects that are considered "garbage=
", i.e.
> could be garbage collected. However, I kept noticing that this wasn't the=
 case,
> despite my repository having plenty of dangling objects (that where remov=
ed once
> I run `git gc --prune=3Dnow`), garbage kept being 0.
>
> I then turned to reading the docs, which state:
> garbage: the number of files in the object database that are neither
> valid loose objects nor valid packs
>
> I don't think I've ever seen a definition of an invalid object? I tried a=
dding
> random chars to an object, effectively corrupting the repository(which `g=
it
> fsck` correctly picked up), but count-objects kept returning 0 at the gar=
bage
> field.
>
> The only way I've been able to get count-objects to report some garbage i=
s by
> creating files in the packs directory (or in any of the sub-directories o=
f
> `objects` folder) with random names, like "test", or sometimes I've seen =
it
> report the existence of lock files or even preserved files.
>
> So my question is, am I fundamentally misunderstanding what garbage means=
, are
> the docs simply unclear or is the functionality not working as expected?
>
> Thanks for taking the time to read this and respond.
> Dani

The most common way I've seen to get garbage files into the repository
is either someone pushing from elsewhere into the current repository
and interrupting the transfer mid-way through, or someone fetching
from elsewhere into the current repository and interrupting the
transfer mid-way through.  In either case, there will be a partial
packfile with a temporary name (since we use a temporary name at the
beginning and rename to the final location after the transfer is
complete), and `git count-objects -v` will report it as garbage.
