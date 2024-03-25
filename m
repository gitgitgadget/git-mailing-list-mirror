Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF771B39
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404590; cv=none; b=qQAYGwHWwZVu0RsNnuUqxhV4TJKGInT3dDjrPIyCWv0Y/C9WtvflpzyDBLQArfVh8dnpCJIGKxhAvDzU2kvxLNna6ZC1E13pVLw04rR1Tg4gh9MYcP/8jRIFh1W3op/e56CIS00thgmd2HR6ArMcT78v4DZWVjisIsGkw372GY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404590; c=relaxed/simple;
	bh=IjVylOzuueQCFp0MjLt28gqgZ/P4LFQqdwj0tAzaJic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJCqQLQwX94SLXXoc9RxOwjzs52el40dWYMAkFNEbQ5A1CKkNDksbLBIIwsRBlXw1iK+gbmRVmY37OivEn8l62xsed4M3dyRxNF/S8Er9NYZppmHTrFRH4iv99InqsgE4R7bn9cXX/zZ98G8hKHTofZd4KUTcsLKw+zOwxfz9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=h8ASf85k; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="h8ASf85k"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690bd329df2so26910376d6.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711404588; x=1712009388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HIT2EjUYbLHImKUkA2PD2UuyJxuoL8/hN88x8SDZvU=;
        b=h8ASf85kzYUfCCzVLw56fLirpTj5dRiID0QbcptdYftfDddBjIRasYu8QLhrDCSKzf
         3TeGYWAH24ePN1oQzgJvobGXRwOKNvtOav6fo9sl8TQVBIhoOQfPxJ6C+VKKtI65fQGh
         XMfJOJaXcLV9yV6tVsfEbOs/M0ErVuSO+4SCnB3c/Er6v22QSYJCFp/OJIREm7bMUuK7
         MdAvuR78lRXAddGsCzt+kCp89gFvCi+vooCNtWCgak9ny722p1wU5Mrmd2VmeZ1BPcxL
         lhsm2CMDVbW+0TcW6Mk7nkd4PXD1u2fHzgcEE1WhulvacwNkiRCzytEufAxUawAbX3r/
         z8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711404588; x=1712009388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HIT2EjUYbLHImKUkA2PD2UuyJxuoL8/hN88x8SDZvU=;
        b=PRcIHaB/tazFUUseGhn6BQvi1HIZSm278VtccVYGe/+XJzSBHC3QT4GvNXQ7VTUAyu
         Xhr5X3j2BiqTz3avoXMFs8TjEK0x4zxnk58QSBmdPiWrCQwPVAo8zha849sN4BRcsLCZ
         7PIGmvLU0HSovFMedE53fjv9xr+V0ay7wGfUwPB9G0nSd3+YosQ92b7xxfZks3ZUJtO9
         qiBcgaiuibhTIkhc0VLe3ltfbvyezHNo6XYj1i+6I3om/HSToFNBPFCBiU6mx0Twd0gu
         kx2y87QsRM5fWHz6K/f36i+XDhgma0r+KXlZlf6nw93HKrO8ivbGY8YfbMyYyKXlFHqu
         vujQ==
X-Gm-Message-State: AOJu0Yx160SUJZDWM17IJdEGrVsCXJ+BjcwX+s/3rm4OcFfpcowoP1EX
	g3Rx0M4wUzQv0NAlIS7K9+rrHKig8K/YIRExxXsnVHvPhuTZuQ2iIuzbn9nRnEo=
X-Google-Smtp-Source: AGHT+IHXopOR+NHRVLtFyweUqyLRwbcuKEqBInZHmwCXs7Fdnrjk7QfaAvTEqOs+oOu2GqD0tGmFMA==
X-Received: by 2002:a05:6214:268f:b0:691:1f38:3ca9 with SMTP id gm15-20020a056214268f00b006911f383ca9mr10660142qvb.36.1711404587687;
        Mon, 25 Mar 2024 15:09:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a17-20020a0cc591000000b006904d35e1c6sm3941726qvj.58.2024.03.25.15.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:09:47 -0700 (PDT)
Date: Mon, 25 Mar 2024 18:09:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/11] midx-write: initial commit
Message-ID: <ZgH2JJZ1sdVeVne2@nand.local>
References: <cover.1711387439.git.me@ttaylorr.com>
 <ffa8ba18de8be68eb8dbb1e17b5bf8800f564505.1711387439.git.me@ttaylorr.com>
 <xmqq1q7yjbpz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q7yjbpz.fsf@gitster.g>

On Mon, Mar 25, 2024 at 01:30:32PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Introduce a new empty midx-write.c source file. Similar to the
> > relationship between "pack-bitmap.c" and "pack-bitmap-write.c", this
> > source file will hold code that is specific to writing MIDX files as
> > opposed to reading them (the latter will remain in midx.c).
> >
> > This is a preparatory step which will reduce the overall size of midx.c
> > and make it easier to read as we prepare for future changes to that file
> > (outside the immediate scope of this series).
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  Makefile     | 1 +
> >  midx-write.c | 2 ++
> >  2 files changed, 3 insertions(+)
> >  create mode 100644 midx-write.c
> >
> > diff --git a/Makefile b/Makefile
> > index 4e255c81f2..cf44a964c0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1072,6 +1072,7 @@ LIB_OBJS += merge-ort-wrappers.o
> >  LIB_OBJS += merge-recursive.o
> >  LIB_OBJS += merge.o
> >  LIB_OBJS += midx.o
> > +LIB_OBJS += midx-write.o
> >  LIB_OBJS += name-hash.o
> >  LIB_OBJS += negotiator/default.o
> >  LIB_OBJS += negotiator/noop.o
> > diff --git a/midx-write.c b/midx-write.c
> > new file mode 100644
> > index 0000000000..214179d308
> > --- /dev/null
> > +++ b/midx-write.c
> > @@ -0,0 +1,2 @@
> > +#include "git-compat-util.h"
> > +#include "midx.h"
>
> I noticed that "nm midx-write.o" after this step gives us nothing.
> A source that produces absolutely nothing may not successfully
> compile everywhere.  It is unlikely we will stop the series at this
> step and it won't break bisection, though.
>
> I do not quite see why the first 3 patches need to be split this
> way, rather than being done as a single step.  Is it making the
> review any simpler?

I was hoping that it would make review simpler. If you're concerned
about an empty compilation unit, we could:

  - combine the first three patches into one, so that we start by just
    porting `midx_repack()`

  - combine the first seven patches into one, so that the move is done in
    a single step, or

  - leave it as-is

Whatever you think makes most sense is fine with me. The original
motivation behind splitting them was to make the steps easier to review,
but if that doesn't seem to be the case, I'm happy to combine them.

Thanks,
Taylor
