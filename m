Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CCA3BBC7
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881727; cv=none; b=KFvb/Rex68Bi5P2X/ImuaS79PPiODsegZk7xn3FZefqA0ju62sZlkhCFCjoC8YqVs7pYfja0HqadC2Zj03WyhIWVYi+1WaBUlfN8UKQE5lGSYG+sMkp7Jvd3WcR6Ai+1w+caltkgb7JbWOyPiLGmi9sBz8zYbjqXMBIefnlzwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881727; c=relaxed/simple;
	bh=a/wNaDztv4CNZcdq4Z6YwEOz9B2Y6xfG9ouCcYoGAQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlEtADrd9b2t20UOobkGFIHP0DWCcxqIZjr5fseXS8Ux+FMf/wo3obOhBl3l6HbusezRaTqihWtHxDb6Qj2/bd+16tk9oT8xWVeJ4yteUeVqMPemEX+R2YjV/pK+IRapQfk1EB1rvjGwxQtoyA9LXGaFVfp3HPspX0U8o3KX7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690e2d194f6so41117186d6.0
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 13:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710881724; x=1711486524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVWaJfn4hTQ+49ZZgbCeTQPnhJ9YmVtDxV52DC/FkPw=;
        b=cxpqhXoHf82xU3+SShZcnT+kXk43cuHJji3DdlSS/X2eamK48RxUHl1DvxVwVeIOG2
         XNm2dTlegLDfQCg5N+UbKKu1Mihf3gONA1ykREmrzba51qrm8QxzZCfZhKrcH5H/Rnfh
         XhH1tsv1vvYzF37LphF2z4YAGMkjJpUnaq49xZ4WA/kh6OOkgRB0eUDXK+d5ERayQEou
         PX6izVOJu+bxGa60v99lxdhWB4pFOK8DhCtiUBSH4bEnXMZ1m2ZXIxCaQj9pReXJuHm0
         KbzgebxPHWakkqu/9N2+IWJKR5hvzTuJ5mf8W5WYj1xcWlpO/VHRcOyiJPJmTM1Nkrzx
         YxgA==
X-Gm-Message-State: AOJu0Yx9Qr4rVdYTaMTyfvES0qA9qPiFq8NAGizxi9LUguxwzOK6gxOo
	sVMBAflnEwYxcTIWh1aCUEgEjv6uhVixdyV/n084uK3IWWg+hFmmQXsUKCPIqkD5MYx1SpYcZLY
	f7S1MlBfikv7lo2zI77FdhSr/61s=
X-Google-Smtp-Source: AGHT+IFwzdBvDEZDgz7KXVHnVL1lmlNMJATUByjn3iNKqLxqt57hCtddIScy4hqcqvTTKv+PQtI9engT3pUoPc3w4A0=
X-Received: by 2002:a0c:f38e:0:b0:691:3ccd:62cc with SMTP id
 i14-20020a0cf38e000000b006913ccd62ccmr4182938qvk.6.1710881723978; Tue, 19 Mar
 2024 13:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309181828.45496-1-ignacio@iencinas.com> <20240319183722.211300-1-ignacio@iencinas.com>
In-Reply-To: <20240319183722.211300-1-ignacio@iencinas.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 19 Mar 2024 16:55:12 -0400
Message-ID: <CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:38=E2=80=AFPM Ignacio Encinas <ignacio@iencinas.c=
om> wrote:
> It was pointed out that it wasn't particularly obvious what it was meant =
by
>
>   "If the current hostname matches the pattern, the include condition is =
met."
>
> which is definitely true. Despite this, to my knowledge, there isn't a
> way to precisely define what we mean by "hostname" other than saying
> that we mean whatever is returned by gethostname(2).
>
> I still think the documentation isn't great, but I don't see a way to
> improve it further.

Peff provided the answer when he suggested[1] implementing `git config
--show-hostname-for-includes`.

[1]: https://lore.kernel.org/git/20240318081722.GA602575@coredump.intra.pef=
f.net/

> 1:  cf175154109e ! 2:  dec622c38916 config: learn the "hostname:" include=
If condition
>     @@ Documentation/config.txt: As for the naming of this keyword, it is=
 for forwards
>      +`hostname`::
>      +  The data that follows the keyword `hostname:` is taken to be a
>      +  pattern with standard globbing wildcards. If the current
>     -+  hostname matches the pattern, the include condition is met.
>     ++  hostname (output of gethostname(2)) matches the
>     ++  pattern, the include condition is met.

This is still unnecessarily user-hostile, especially to users who are
not programmers, but also to programmers who don't want to waste time
writing a little test program to determine what gethostname(2) returns
on each platform they use. That's not a great situation.

Peff felt that adding `git config --show-hostname-for-includes` was
probably overkill, but I'd argue that it is necessary to enable users
to deterministically figure out the value to use in their
configuration rather than having to grope around in the dark via
guesswork and trial-and-error to figure out exactly what works.

And the option name doesn't necessarily have to be so verbose; a
shorter name, such as `git config --show-hostname` may be good enough.
Implementing this option would also obviate the need to implement
`test-tool xgethostname` (though, I agree with Junio that `test-tool
gethostname` would have been a better, less implementation-revealing
name).
