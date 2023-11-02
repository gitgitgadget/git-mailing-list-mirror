Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB57486
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VREJKWQH"
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BF9B7
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 07:48:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso1694210a12.3
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698936507; x=1699541307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScgPM8hzETr3rG76ynWXfeVQpRnjUHhpKjQyRhq+5aM=;
        b=VREJKWQHizZJV5Zp/YwByE4PZV3j64zsi7F3z8CAvUbiRRz0fVm2kv3S8mMObOB39x
         uqVy3Fz7DLiYch0aWxpbAudo/qpk2T1M4odgu4UKHJdtJoRhBHjHSvgeY6pp4/4FmSJo
         /edjJcyId/GIQPZ9JCaQQ/squp0LbcnVuqmLQijZ56zlizicXPOdDxcivX9YHTqhAHyO
         BBPbLcDlKCLVkbNL2eZLkZeC88X+Y3eV4Ws8k6zyztT/jZrG5Gy7CnMWLFVst6mStGRw
         qqnroZ0COhZ0QATtvmPrUkccWO3wpuTThHjNqxdCaas0ju3VtyLRWFfvNsdNIt4YJD1q
         GQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698936507; x=1699541307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScgPM8hzETr3rG76ynWXfeVQpRnjUHhpKjQyRhq+5aM=;
        b=WQdnVqQG1p9ot2REu6bxGFwO9tYYQkNR18ySymDFdzIa6H4uYd0Jge/5YQgPNrcej2
         20GZRYD8JfHmp8e3OKpq+7KKfQIMTq8/GPwN/vHWvx32eh/8lbberfNlk3kkCnPeZ1DY
         AzKa+leZOIiCjoid6JSHjr5Ga3v68VdpzD0aQHKF5RKxO8m9AwiQd+ChRh1nqMz461BV
         gw+vPdkhCWBuXxp0dG7LVqymDCXeoBtine8pZx6xXnzKLFZKq3bz60R88PJrb1DLU2W8
         NupYM+0HoTwWlPSKHipBQyQGqQZZIbvC1YCT/MkuxfjoxILxPevtmMLkgaXo6w6xelaX
         aapg==
X-Gm-Message-State: AOJu0YxYLqtpYvW9aHhxFr5zJ50xwfhik8GE81HF9UGxBXECs8NaOvVp
	uMr70uLOhpdiw6+Ex3QL1jDfmn6ZHzKyN9gxErg=
X-Google-Smtp-Source: AGHT+IHnPn+mw2IJD+Lshr4FcWRvcpX03SUFBeYhlTdya+/LnZIi/oCVjYhQEeURUQ5hbWYbVAuvoJ0XFJ4WN+VbEww=
X-Received: by 2002:a50:9fc3:0:b0:543:5852:2f1d with SMTP id
 c61-20020a509fc3000000b0054358522f1dmr9309169edf.37.1698936506646; Thu, 02
 Nov 2023 07:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com> <CABPp-BGCzxL-kpOvZzWRTJcx2v18QHm5ev8bFv7bm0dyNqhKug@mail.gmail.com>
In-Reply-To: <CABPp-BGCzxL-kpOvZzWRTJcx2v18QHm5ev8bFv7bm0dyNqhKug@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Nov 2023 15:48:13 +0100
Message-ID: <CAP8UFD38KEdpArdixVHpTFGF__G89s_sMUHa+gmWoLULv+CvJw@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Introduce new `git replay` command
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, John Cai <johncai86@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 7:00=E2=80=AFAM Elijah Newren <newren@gmail.com> wr=
ote:

> On Tue, Oct 10, 2023 at 5:39=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:

> >     @@ Documentation/git-replay.txt (new)
> >      +
> >      +NAME
> >      +----
> >     -+git-replay - Replay commits on a different base, without touching=
 working tree
> >     ++git-replay - Replay commits on a new base, works on bare repos to=
o
>
> really minor point: "works on" or "works in" or "works with" ?

I have changed it to "works with", I hope it sounds better. Also I
forgot to talk about this change in the cover letter, sorry about
that.
