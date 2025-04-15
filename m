Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41712DFA29
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 02:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685893; cv=none; b=ZlVXqVN8rpZEGB6jPhgPhpAMv1Aqvg+TrvqbEqv+VJedJ13EmRbebROsf9F3n0nBW0vMDxq6lROuveu4PldeB46P+SPRQPbpYa+HoCzjfepB3lv82B2DYE6ucTl59nUHBZWkvhUFCBw/aZzT11F7nbBBmXh+2nBBttojThi5S1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685893; c=relaxed/simple;
	bh=lcYJgqq11LSLNHwnFjwcwvvHA5HtxhJAjW+3DuWOX6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpT8gFFLG0NkoFAAGuQqM1TKT+F4pm0gKH0oN1fXNLNTcZdY7yuqSVyatAA1iv/78vqhNWpZVPYZa2iBbwPJW+KQ5vd89C1xYu3gwWL2DSufMw/JgHnZlp7LCu5RvBKpLKzLWoeRicv60abt7no0OM47zZyJoC24FzFYLXxh7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB8r9C/l; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB8r9C/l"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b41281b50so135815139f.3
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 19:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744685891; x=1745290691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKMb5oAyOjyzIhPAqVe+pHeRmNLFu9f44HORyqiXBsA=;
        b=kB8r9C/lcR/AlVkoHVXJsgDxhaYCR2T70EG9fekqW7euz7XnsRId6axovfveSZWwZB
         JA9ur0QFZLmey/6Bcc+JmG0JriOXOdG4XVv317r/MjwL5f0HgaTr/dgHlJIfAk/Y7oRh
         u0ZCf6eV46g12tX/+rAhoxp+VWfjvoJP6RcE+LHimHQRyBCgKU+rO7vPVA8ITEzG9iel
         4IMLzC3TUUBxWXdzqWfv3VzAnmfiWloQHn7AMXrw5Y0MAfsP6a3f/ZgLQidGOrusa8GG
         jZtGCLKTyGZMODvJ0pGXi3bzSDf0Ea0d8VNpO78xSHgcQUhYuFeTYvPyNvmeam31lrLY
         3PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685891; x=1745290691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKMb5oAyOjyzIhPAqVe+pHeRmNLFu9f44HORyqiXBsA=;
        b=F0BcsoID8cgPIVpi1BnXc+MSidgHu7wa+efHMMlXQ0Za2l8ydi25/coMr3jI4Z8nw7
         pysk8zly3wYSkDW5xIn+zR6vCEqz949uiYqpYnAa8GGVw1vFL9b/2MrcISlWf3NjJ7iJ
         Q0MjCpRhQfyrU1iKvxqLoK4tI5JYYc42WyWzzvISqzxQbzzmkC0kI5t8K6id0CMXQb7n
         dHYzWX+7/8QtYk+wuqzdqVmIN97YVaf41m2j8V2OO8CoDpv6U/9N4POuvv/qg149kxvb
         c+C92RJkm+5RoB2w4Mzc++A2AeSdAyyNtrS8Ff36VcpoqBob2WImrxQ0lKyyrzgL6RD5
         qEoA==
X-Gm-Message-State: AOJu0YzuBdoLwCoNnqnnJSdHnb9grI6pvpcr7kAz6GSRQdcYJ3t0D1+2
	qmpRZilaWYw+u0EJQUJqdNk4bgrf2lzM6EIfrv0wMRutYe7+Yv0956mLjorCVvqtDCAnaT2II6b
	3YbEs4J3/xdy/wWe/NKiANpZi3jTDAtV1
X-Gm-Gg: ASbGnctt6T19rCFvPCXakFIIklLoTgSxKNjOBLYQ82/vmQ7AooJ3H+qTIKb9QMdKRvn
	93f8U6+1QCxHLpYfvDCd+CbufRxQk3zk4PDs4bcVbb6buZi9wm5Jw6Q5yciL20sVZO0BuIYgeE7
	zpd7ml9sFRxBPCa6jXhTfAHNe24/7bCNInYjGL+RFZT2wXw5R1Vk6UYgw=
X-Google-Smtp-Source: AGHT+IEiDoY3eR+fsa2Q7LMEmL3OqXjGJHnNbmUPAlvUIs3sA67ZaV97Zf2Lhyt30RbH1JxbVdeJI1it3otlV1VtZGI=
X-Received: by 2002:a05:6602:c89:b0:85e:8c26:8e2d with SMTP id
 ca18e2360f4ac-8617cb728bcmr2006554039f.4.1744685890817; Mon, 14 Apr 2025
 19:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1744661167.git.me@ttaylorr.com>
 <920c91eb1e5a1b6d5faa54240dd9c85f72968edc.1744661167.git.me@ttaylorr.com>
In-Reply-To: <920c91eb1e5a1b6d5faa54240dd9c85f72968edc.1744661167.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 14 Apr 2025 19:57:59 -0700
X-Gm-Features: ATxdqUHO-gfUs5nyvvqaUpkuibrWPcvERX7ahirUN_afZJpgM9HcgLvxNCk39CE
Message-ID: <CABPp-BGH=GRAo2Vy8sia75p=2Uoza0kwTzoy9FKKxE5jDFfGXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] object-store-ll.h: add note about designated initializers
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:06=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> The following commit will use a designated initializer to initialize a
> 'struct object_info'. This obviously depends on having the rest of the
> fields having a default value of zero, since unspecified fields in a
> designated initializer are zero'd out.
>
> Before writing that designated initializer, I wondered if there were
> other spots that also use designated initializers to set up object_info
> structs, and there are a handful.
>
> To prevent potential breakage against future object_info changes that
> would introduce/change a field to have a non-zero default value, note
> this dependency in a comment near the OBJECT_INFO_INIT macro.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  object-store-ll.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/object-store-ll.h b/object-store-ll.h
> index cd3bd5bd99..7ff180d7f2 100644
> --- a/object-store-ll.h
> +++ b/object-store-ll.h
> @@ -337,6 +337,14 @@ struct object_info {
>  /*
>   * Initializer for a "struct object_info" that wants no items. You may
>   * also memset() the memory to all-zeroes.
> + *
> + * NOTE: callers expect the initial value of an object_info struct to
> + * be zero'd out. Designated initializers like
> + *
> + *     struct object_info oi =3D { .sizep =3D &sz };
> + *
> + * depend on this behavior, so consider strongly before adding new
> + * fields that have a non-zero default value.
>   */
>  #define OBJECT_INFO_INIT { 0 }

There are 46 #define'd designated initializers in the code base, from
DIR_INIT to OIDMAP_INIT and everything in-between.  The logic used in
your comment to suggest not using an all-zeroes initializer doesn't
seem to depend in any way on something specific to object_info, yet
none of those other 46 cases in my quick scanning have such a warning.
And 29 of the 46 define some kind of initial value for some fields
instead of using all zeroes.  That would suggest that one of the
following is true: (a) those 29 cases are buggy and shouldn't be doing
that, (b) those 29 are all special cases someone has thought through
carefully but perhaps someone should add the same warning you have
here to those 29 other cases to avoid uncarefully thought cases from
being added, (c) there is something specific about object_info that
you didn't call out here, or (d) this warning you add is unnecessary.
