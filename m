Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A902770B
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742958935; cv=none; b=Wx3gHZ95aeIMZbBlHs9Tydjefb3rN8/ukt8zzLYZyAEDovzacLWMeilFuCdA0mdJVZTGt/V6iJ4m3MqEfc26GYzKTbW95q/5+4SjV/qjfU+/tE9lETRgvkoKHz+zMIpv0+AleiR716uYXAUq8mLYSQXSsF7zqJ6PQfc6q5GJC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742958935; c=relaxed/simple;
	bh=QMjZBPdN2Fb13gVX0E7XGkzs88/OIz0BfGB6QiuBtfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdnLGDFkabvyrSu0JtG1hLtfTGP9YWmn24H+RZ6edyO0c8aRZ72POCLm627ISb6+DdkFaGU9gtL9Mot3eXWr6SPmMRxCoiB7HDXptIFL+3I7TqylB+eYjnsxVvAMkHBkdxTvuN/N0j/KaldEmVYU2qbbG+TmcWUsxVDatXPCXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iusx1SJv; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iusx1SJv"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4775ccf3e56so4987091cf.0
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 20:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742958932; x=1743563732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z//sxTxOPbg+x0SQILZz4d0u0EfCi4+QOmJ9ZNDK9s=;
        b=Iusx1SJvA7rUVZ8a1lOWnf0CZOdg9OZ7GxjKvlN7m9wDJMjFVfN0goezswbiVe7WMK
         b1le11txM9TJSABQO5UthoK6VM9YG3xDmHayYcMwEkclmRSjsoVYhu/txiJiC575Uw1/
         adGt9jpn3bDIUjTAVV61HDsSqtaXx4Kx77N7BrC5XYfgvVSrbC8ic4BwrPeHHnl1xkj8
         J8r0OvxLf5cKTp6CjfBiFxYBuKv+jkerDbDVSViNAzStCQZ9MXethYw2dL4d9MbLRaIj
         uaO+f6GpAVqQdePTOiARVFPElFM8rJ1ulZgf5A3emDOZTt9fZx5cuBl+SKNaUn3dTsF2
         x5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742958932; x=1743563732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z//sxTxOPbg+x0SQILZz4d0u0EfCi4+QOmJ9ZNDK9s=;
        b=rTu5HkfuHqGKSr/m0mT3sb76NeUt3tHUv4cqW+c/+UvYDuPd6Jo8nqLvOrOMi5f7dV
         KRUlqYqaBNMToFyhA0FdHgkX/ClLlNH+v33uufSFmypjvCQlDzHjrCIAqvBEuTJ+j4b7
         pZFAu44o9n3N3rYcEC3lE2iZhXhwgm8/0OVZwwbL8uRGeSQKuY0EJH+61wl70GZM17Ux
         53tO0yhPPw1oQNEaj2IhyXADTwAkJRvWi9NiOhQtOnhl78NG7uMs5eccqADbw8cjVI7w
         5Qs5PwvdBmV5+BTcciRTbas/g3q02HsIJLDiw9siLTVzm+kVfA8Ua3MUI0Iu+Ee6DnMB
         Kcdg==
X-Gm-Message-State: AOJu0YxZ0nB/BwLKRWHvw2g/rrxyWm4M1XQZH3AVNWZuyIbFroYbNp70
	dGJTJ2LEXYtNvyDRfejMyWEgZkQGWjwq407brOILORUeuQjL4DAzC1eD+he68M41C5PsLTh14Sf
	ME0UeumCiWFQi3bFvK2bajz3qW2J/wfYP
X-Gm-Gg: ASbGncsCWzQ2bd4uNC8wouQc49ekZnF25VQJ4cZaaSkXE0OA2+Znqysjv9+Tql1TMT0
	HHuRVJvSLBJLgz83woufR9DX/WiwoZEaApNVzAqAJrQA2Hb5vUJ7Zkvxnpbg3sRQJtohKhFlMD9
	8wui3gP/OO3pUQ0nhga6bGvwXSGNBVb6X5k9E=
X-Google-Smtp-Source: AGHT+IFQdQv/c5FgW6TzxlaR5bWakl7IuiAb/ehGfO8IpRQY54TFvW2BpqW4p2X8MY/oVgvV8jhPXR4zJ1CKwjUGyAk=
X-Received: by 2002:a05:622a:4c0d:b0:467:6b6b:fc1 with SMTP id
 d75a77b69052e-4775f3667ddmr37614981cf.16.1742958932424; Tue, 25 Mar 2025
 20:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqa59evffd.fsf@gitster.g> <20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
 <20250321143022.5406-3-jayatheerthkulkarni2005@gmail.com> <xmqqiknzqu2h.fsf@gitster.g>
 <CA+rGoLfALoTvQuAzQPx7rqd-Zy+wMiyEbF5Y8_-2Yi-yE-2qpA@mail.gmail.com>
 <xmqq34f3qbna.fsf@gitster.g> <CA+rGoLf7R5BmpN1E+AXYhEKz=Th2TcpfDr0NxNma54GR_X_K-Q@mail.gmail.com>
 <xmqqiknwldob.fsf@gitster.g>
In-Reply-To: <xmqqiknwldob.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 26 Mar 2025 08:45:21 +0530
X-Gm-Features: AQ5f1Jo6f6sOCDxzPn_ry3mtnFJvGaFW6zVxItR2q-hlNstdRYKukQl7fkK-kQo
Message-ID: <CA+rGoLdJucLSe0fMeOEd6aTJP4p7JD7xyrPmWUetNWbQ0CoeyA@mail.gmail.com>
Subject: Re: [[GSOC][PATCH v3] 3/3] docs: replace git_config with repo_config
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 8:07=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:
>
> >> ... better to explain _why_ each change is made in the text that
> >> precedes the sample code.  E.g.
> >>
> >>     Add `#include "config.h"` because you want to use X and Y,
> >>     and `#include "repository.h"` because you want to use Z.
> >>
> >> ...
> > In the latest patch version I've removed the comments, since we
> > already added a line above saying the user has to include
> > `repository.h` I don't think we need to go in depth into that, do let
> > me know if that is not the case, looking forward to any more feedback.
>
> It's your patch, after all.
>
> But if the reason why you added the comment was "this is a tutorial"
> as you said, I would imagine that it would help readers to say why
> a particular header is needed, when the tutorial text tells them
> that they need to add it.  From a quick look at the patch, it seems
> that the updated text says what the change did (i.e. add a header),
> which is rather obvious in the sample code, without saying why the
> addition is necessary?
>

Agreed, but there will be two things from this point, in the previous
documentation itself the header files didn't have very detailed
explanation. If I do a detailed description of the header files in
this specific tutorial/patch, the documentation will look
inconsistent.

I could do three things,

1. If these series of patches do not have any other faults/feedback,
after merging them I could start working on a second microproject
(Adding the details of header files of the whole document
consistently).

2. I could present a change in this current patch to improve the
details of the header files and re send the patch.

3. We can just leave this as is.

I'm inclined towards the first idea, as I think this will cover my
GSOC timeline and also give me some time to work on my proposal and
fulfill my requirements for GSOC at the same time, and also makes the
documentation good for newbies.

But I'm willing to work with either of these ideas, or any new method
you want to proceed with.


I think the prev email was rendered in HTML
So I resent this.


Thank you,
Jay
