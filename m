Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F887E
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBFf7n2j"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3BB1A2
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:54:48 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507962561adso8021723e87.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699930486; x=1700535286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M2jnZbdiNAYGkNUecKACnjXnWIY910J/Npl8Nd03+Q=;
        b=jBFf7n2jFUOTyP2dwJ2UshhqEfHiLH+38aaZHG6jAqi60Drg4rbqukvP0b87y2Ej41
         k36ChJG4o/Hc/TV5pnuNcuU56an3f9787g+FnLJspGuL1oNafwlOof1JW8lNbDH/z8BI
         flJAgGC+blSleyFZ4KJt5b2Q6M5uAlo8LuVR9+/sY5e7HflTfOv85MAvIyRLIhwATzhz
         ENz6G6QSbWVyI7UWkKJeF8gnJcPFGV8N0GsKANynyenD5vqj/KPjZY2m78+PRqRHgeGs
         dY1DtLZ8SATYCpYq43t0LNr0zsZ51Rr4TDKJkBKMlbfanfw48+w7z4fWEv6gxw87nXcm
         6A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699930486; x=1700535286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M2jnZbdiNAYGkNUecKACnjXnWIY910J/Npl8Nd03+Q=;
        b=X3bbvWksqJJ9Bu20KgJxUT4T6UvMjr+u6bL/wNWO2uYp20PM29O5Gm2PxVDOxBlSx/
         UW/2ZXDcTa7oyRj7sN/eupAgZeQGm8X4pWVlbKAm0VjxNsNvJmJmDQ2cuQFwJHBdW855
         gL9WUvmBMyvjMlmwesvuPmwA3d4ygQhDz0uSWtyxHwUwA2p+Fbxrd0/Xt0o248xZz7so
         TrS9Uyj1uglFBpH11LyKOpNU85AJkGvZjU0h3l8dXwteEwfwMUmn115UHKq67nST9F74
         ABXW+2cMyn6HIzQovSpzF3NsqIGpguzkn/2ZB+ZYWq1tKSCC6z0rf5J4tsNR9mHPxVHS
         Qa9A==
X-Gm-Message-State: AOJu0Yx8J4KJ8yrJfDwUUVJsyStJmrYDjfyWLle2ooePgLUj4bVWv1ds
	XOsC/WkKdYeglweU7Czei5a77p6K7mYZcpawLG4=
X-Google-Smtp-Source: AGHT+IE6a9pj0zgEhxa7NrkZq3SayMvD9dC3ar8LH29Ll/sJmWG8h951wbkMa6JIdMYT7grDFYJODda5W+WpOCEjJlI=
X-Received: by 2002:a05:6512:3608:b0:507:c871:7888 with SMTP id
 f8-20020a056512360800b00507c8717888mr5846101lfs.9.1699930486312; Mon, 13 Nov
 2023 18:54:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697736516.git.me@ttaylorr.com> <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 <ZU7X3N/rqCK/Y9cj@nand.local> <20231113220546.GB2065691@coredump.intra.peff.net>
 <xmqqpm0d1591.fsf@gitster.g>
In-Reply-To: <xmqqpm0d1591.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 13 Nov 2023 18:54:33 -0800
Message-ID: <CABPp-BGukcQVkzOOzuGLgcGSctrdzydMV5FSXn=gmUe9RQE=Hw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for `--write-pack`
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	"Eric W. Biederman" <ebiederm@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 5:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > I posted an alternative in response to Elijah; the general idea being t=
o
> > allow the usual object-lookup code to access the in-progress pack. That
> > would keep us limited to a single pack.
>
> If such a mechanism is done in a generic way, would we be able to
> simplify fast-import a lot, I wonder?  IIRC, it had quite a lot of
> code to remember what it has written to its output to work around
> the exact issue your alternative tries to solve.  In fact, maybe we
> could make fast-import a thin wrapper around the bulk checkin
> infrastructure?

fast-import also attempts to delta objects against previous ones as it
writes them to the pack.  That's one thing still lacking from this
solution, but aside from that, it also sounds to me like the bulk
checkin infrastructure is getting closer to becoming a replacement for
much of the fast-import code.
