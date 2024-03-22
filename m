Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C972D78A
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102129; cv=none; b=oqqjOIGjRmafUP+z/N7GeErlLlg8KHx2Cdj3XmYLZTFMyT+umxBtha1UEOWFWbeyWfZGCMeUU+pelX9EW1kRmXOZv2kwldYK9El2aUtJM+INk5O1PyPZXXA4slMPiFUMJ59mULASDFdG5nlwFP0Ye4Adq4HKbbSjw25Lj3bA0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102129; c=relaxed/simple;
	bh=AfWghvNiOvbuc/4BHN0KkRkBIox6Cx8zale6VCtqg60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frqvrC4FfuryIevp3nIL/9o7T8uwQetp9PC4KPzJN3zT05++mkdXQdKBKBiGfmp+1YyfPJHs6aXelPqtb9U9otEXEH/ISZcCXyq7Xa6NdShyOvILxrDJGdVBeIP658Bbgq+AWMofppCfcxG+lBLexa2yIaxyb4bFfaqYXPXceww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVYke8nX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVYke8nX"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso252521966b.2
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 03:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711102126; x=1711706926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inSRp+uDVV5icbGYCGQefOzEXNI0E42RFPIY+v9bVN4=;
        b=DVYke8nXHkwcm8NT8jsVyTuyAitoRsct5JOdja+FOm5lxiYv2O7tc0sqDNh/S3MtO5
         4+mIUhON4KtZ4LToRTEgbKQEgWto3hLLJjAWL/8DGoZBonM9tzGM46x5SXnFLuKlW+Qw
         1SPKE7Zr7M7mVJywW6qAtIkOJlJWODuU5YC/gR3wKMPXK0DhZgvxk9FmvsxxicQSPDbz
         ZT8ckHSLiol5ZyJytR82fhp0IULg4WEMYjkNmrlUuScUPzPyRg8X5IfhNjiMbJChA0if
         LjMtVN7n7UFWah7bfe110QokfCV1mKppwJ2WGysHoZvMpgN8PHbzF8GK+3iL9wv6Fd7m
         FacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711102126; x=1711706926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inSRp+uDVV5icbGYCGQefOzEXNI0E42RFPIY+v9bVN4=;
        b=kDobQuiCVNGcameft4q26thsoz/qv5+GW1aGzm5ZNMEM/UQQG4pXIhEdQajSV5qlJr
         HPwxThzGThuMzKHpJgauMgF6R9qzJRrbSNKjBuYXiIVDB5ViVokPQupw6WUiSzf6m5XH
         bAa2I/DbfQM/yt3xCvM5RXuocNjf78NNXagrEsDl8nL+XXADBSxYecQFl6bJEF62VGcx
         ZCgpHcVOyfQRc3PUrpQhKwSKEY6naPCuuZ3D0Ne6ZeKs2bpVwt/bOQk+acYSW/yu9ypL
         a6u0ivMVX+Lnl8PYmVQLmMAqxkl4o657lCZ1hSurdu8SliYE3RlBh0x8X5VHW6dTPgwj
         AW6g==
X-Forwarded-Encrypted: i=1; AJvYcCXNoH/lqlZEPnsUyNfVNb2txbgc2lnUdMBO950jZv86sFo47hzQgRa5g0eZwg16xaxpvVBBmj6zPTIgF/52qfPFakPA
X-Gm-Message-State: AOJu0YxfcDMukTM+pkwIUM0e2FRTOVR/pWZOAPfR91BqZ4cs8adp071S
	rpcPIFoCHYLS9uDGZytlvjeIzdo3UapeLNPLc7tA140H3oWDwXorefGdvyzQ0kja/y916/R/5PR
	+tOGiZ5Mo/FkqVXiWxKoJfqT8mQjPKc1hNf9Fuw==
X-Google-Smtp-Source: AGHT+IFbhi4nvEprCNMJ3R9iZELdjSNO9rsnN1Cg3bdwEMp6RJnZ9hWwvQF0SkSytNT8jdeF/thJ7cobEc5BtoBZ7S8=
X-Received: by 2002:a17:907:a4e:b0:a46:ac55:8e69 with SMTP id
 be14-20020a1709070a4e00b00a46ac558e69mr1736174ejc.14.1711102126266; Fri, 22
 Mar 2024 03:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
 <ZYQl_G-S4vQibHWn@framework> <Zad1S3vCuv4KYIzx@tanuki> <ZfwY_h70OeuRT7mk@tanuki>
 <xmqqy1aba6i6.fsf@gitster.g> <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl>
 <ZfzUb9HkZLq1UIed@tanuki>
In-Reply-To: <ZfzUb9HkZLq1UIed@tanuki>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 22 Mar 2024 11:08:34 +0100
Message-ID: <CAP8UFD2LmapWutRpfveL6ChSg8xrCkQXyQaJwHyEp8JA0p_Osw@mail.gmail.com>
Subject: Re: Git mirror at gitlab
To: Patrick Steinhardt <ps@pks.im>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	psteinhardt@gitlab.com, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Sorry for initially sending this privately to Patrick.)

On Fri, Mar 22, 2024 at 10:41=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Thu, Mar 21, 2024 at 11:27:07PM +0100, Olliver Schinagl wrote:
> > Hey all,

> > As for my mirror, I started my mail with I'd me more then happy to
> > transfer ownership. The name I post cked as a reference to
> > git-scm.org, and never intended to keep it for myself. As I initially
> > wrote, I was just slow and lazy to sort thongs out ;)
> >
> > I will transfer and relinquish any and all control of the group once I
> > know to whom.
>
> Okay, thanks, I didn't quite remember :) In any case, unless we get a
> hold of git-vcs/git, we have two viable options:
>
>   - gitvcs/git owned by Olliver.
>
>   - git-scm/git. I just discovered a few hours ago that the git-scm
>     group is owned by Chris, so we can set this one up easily.

It's owned by me and James Ramsay (ex-GitLab). James created it when
he was the Gitaly Product Manager and added me as owner.

> I'd personally rather go with the latter, mostly because it matches our
> git-scm.com domain. I also like it better than the current git-vcs/git
> because of that.
>
> So Chris, would you mind adding me (@pks-t, my non-GitLab handle) as an
> additional owner of that group?

Done.

> I'd be happy to manage the rest from
> there -- setup of the project, mirroring, CI system and changing our
> docs to point to the new mirror.

Thanks for doing this!
