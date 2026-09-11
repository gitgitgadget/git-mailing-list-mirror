Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A304A92D7
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150017; cv=pass; b=qqf8Ui5sanLwEGYjM89AIMY/yegUhwttRb1JQhJQDWGpPV0LZJOkRi8JuauCG5HWEapmGgG0iMtzEMIQQG3BPnxdButF/hvgY879SmM/YT7JSL9AXvzFUIHAD68fs2ZweYwtTEmZ4/d7FMicaQjLK9CMekj4z2NLMYpFQXJ3K7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150017; c=relaxed/simple;
	bh=s4LtqAj6H1n5JFk6vX4jQVbcbFW5Y1UHv5Low1hbFkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqwkKpwefG+olPLCYokNNS5gTknTMb+vfkn1lVt37K1525tYor464bePhsYmJzIoEIYIYPh6rb3eqEzmCJoszMywVoqNgtNf/XVl0XNBbdL4/pXWYkZCZHYcTxYJBwmm1WeFYM7RVdYrhS6nr6u1DeVsVjHEZyjE2vCtXgp9eGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9w4CErc; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9w4CErc"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b0496f4bbcso996509eaf.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 11:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150015; cv=none;
        d=google.com; s=arc-20260327;
        b=GZNf1vdUJTTM8KEB9YucgempVo0h7ogH0Y/Jas5Eb90Y4jJxPzvx3f6RiWTQZuIA2J
         kajWFS7PyZnPx9VLRbF0VjXl57hpX6PXWAMv2dr7t3VHnklS8TmQ/VgA2q/c2MQUV8lw
         Y+EZ+/geGO7RGfz14Kx4luU0/fBgJ6tdVI3FIhI6KbqXJ7V0BQGflsvPTUZ8VT9Yj41v
         USdHP/Fhtqy0fZVw6V+H/uzULd+dJIRepsn3xcfeN6N6cy7x+UEWMO9P6PY7aJgfkRZ+
         OxdGpOjSZRGX3KwSHr+3lht1JxV6b4E4CpDBN0UY0/APnrd19JsdMEbSanPjqsAKPxwG
         hloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VWs9zzcikcmUVWnsOThu0e7EKt+sQwbjoMHymr0F9i4=;
        fh=BZHgaQ8VeIZtkgjKnadltri0QohAe7KtZH8/bnlqLPo=;
        b=egGfT+8vAXtwbj3+q8GZD/B30jYs3SYG8Gqx/p43P26lpZtgvJOWLhg8pITg2q+IRx
         HAAOKeXF/+o3W6rDz0lvL258zn5HFHCq1fH3/0Wh9BPRd0J1u0NT5soYHAEzHq/tfpJM
         KP02WWtLD/Qi8vY/Bm3vyZ+dPfV+dghMLBIo6cTzqW5Y8tC8FJ8cg821obGb5hn78mbE
         jVJlf1zbzWWr9a71zhNUSA3OoLtXou6UkveDFGNE4uRvflwCCnuGbuEMZnCM356j5FCM
         PyImHUrs5ziy4MSCQbN5Jjnk65Omb6fRSNfQepPY2QBbqWVlFOdOg/OARO+wXheh0Hpl
         1vzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789150015; x=1789754815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VWs9zzcikcmUVWnsOThu0e7EKt+sQwbjoMHymr0F9i4=;
        b=V9w4CErcPg0Kp3vcBpjuSqw4EmzkmceqUXQwY5f4vvmefRzCrQBXj1d38ba+U10zgf
         0BPnQo07/j37HNJ+2eCvFS7uk3NuWjQJ8NH/jx/xauLLVJJaSZfSoKXK/L9On6PCwbHY
         WSoF+51uYviifqQVgXS0tmFlqRpKUz77YXJ2yG9eFTeWXLgTs6y5mV7jHQp2hIwVnlJ8
         XkMHsQ/+HaJh6f2didZ2gh5SNP3ZAuiONnzb/QDiV8ed5S0pWFCiu6I51Iek63AWyVfS
         TASPGFDvpgYBFpq3zEFmpJlFcugTHGfUn5qiG0Rex6lrY0QwqEGcNEy5aGpGijkafK3+
         IMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150015; x=1789754815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWs9zzcikcmUVWnsOThu0e7EKt+sQwbjoMHymr0F9i4=;
        b=KN6RD8x/G7TtId/rK7VDaP2ImAv/3wN6XzgxmYrp/vsAlrexq4clW2IyJ4p9WrQfNU
         JUJtki3CNY9rtqo1xlO5mhstdgC1kBTCZrdx31rTRI8ic+JVhC23L1kE5DSXDxHQO/Qi
         HZWlP+Xf4jUS2Gy+eh5GqCKTAEYIZ3R3bDJEDE8muuLF5wqcpCqa116stvSJKbBowxXX
         26x/KmV0ynn98DoqSFF8rV1wjUYKKIGQ18Tv7m/7yGuoT4lbyYi2ukJWYY9IwOEgrSUT
         mxTWQgdjWkHj/3HROHF2JxnYi4R4bVbN7DFnVTpcxld1U5bEnEMdOc+sTd/OaSPwnM7n
         cCMg==
X-Forwarded-Encrypted: i=1; AKwUvBzUkX+RBxz3T9Nb2MwOTKQYTlQqQMQHtSOqd9/laJJ3bu92yPLrb5ACmKhek/dv3z2V66c=@vger.kernel.org
X-Gm-Message-State: AFuF++mk5h9rQHaP/CmSov61Sjp+jabK9t/IgBXO/dGquZke2BIg81oG
	+Belviq+tOTPo4KrMx3g0KvDkpNqt9ltQCLn8QUYkv+KR9QV34CvIyO5CtshdxkdP6Nc7ehk8Tc
	D9eVj7wAJxRCr3RZ0mjZx3XFV7mg2zcQ=
X-Gm-Gg: AYBFou3Eu+ROLEwEp/1+nmA0AdOx5wHlqxqIZbue4lTkjZFwx6235b4rSawrTN/nc1z
	1BwYNaSclcXSJhT7VgjkQz7jzqxoLuYOcohxU/Eon24Ze5s0qRTKYe2j9wkF4m67QxLP7r+1xzo
	0pLRRsPY+OFWGkbeWfMCad6a8y/tRW0iegU9GoF7paYJHNE0M5QVxnByHRjAxNVmI/VVZKS98I/
	ab+Vbf+RfIxbWkX6uK3/iGjbOVznQLeDSsKnlmiy0yXm8PmJ0GN631EUCGDLp/+D04hzy3449s5
	1MznAatmKARLF+y13EB7SJVXtsdJMG0FCVbfFq8NsU7fFH6tsA5lRTakvfjDNVQi/ukM9bkERc5
	PuP3tyNQB8Nov++mXjtax6kFdYpipALwSRQ2AOk+qExL+tCoBmtJNiynAoPZXJJpUV/e3koqT
X-Received: by 2002:a05:6820:83db:10b0:6c0:dbd:309b with SMTP id
 006d021491bc7-6c0bdb6bab9mr2951621eaf.59.1789150014944; Fri, 11 Sep 2026
 11:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911171044.GA1609692@coredump.intra.peff.net> <20260911171139.GB1610200@coredump.intra.peff.net>
In-Reply-To: <20260911171139.GB1610200@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 11 Sep 2026 11:06:43 -0700
X-Gm-Features: AcwNN1Vo2wdLw_XDI-hAI0JS4H5GY71KFl4VdVGYte0MIG_bTMdMrfsoiC6t7os
Message-ID: <CABPp-BG6wYkr4wjr-iqak9fYo4+49WvjROdZ_MK5=g27WcUmMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] merge-ll: catch close() errors when writing
 external tempfiles
To: Jeff King <peff@peff.net>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, git@vger.kernel.org, 
	Jean Delvare <jdelvare@suse.de>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:11=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> When writing out tempfiles for an external merge driver, we catch the
> case that write() fails, but not the follow-up close(). This close()
> would usually succeed, but the system could report a delayed write error
> (e.g., on a network file system).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  merge-ll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/merge-ll.c b/merge-ll.c
> index 5b6af15e23..5a11a9613b 100644
> --- a/merge-ll.c
> +++ b/merge-ll.c
> @@ -180,9 +180,9 @@ static void create_temp(mmfile_t *src, char *path, si=
ze_t len)
>
>         xsnprintf(path, len, ".merge_file_XXXXXX");
>         fd =3D xmkstemp(path);
> -       if (write_in_full(fd, src->ptr, src->size) < 0)
> +       if (write_in_full(fd, src->ptr, src->size) < 0 ||
> +           close(fd) < 0)
>                 die_errno("unable to write temp-file");
> -       close(fd);
>  }
>
>  /*
> --
> 2.56.0.rc0.314.g7a874b6915

I got tripped up at first on this patch; if write_in_full() < 0, then
we won't explicitly close(), but since die will result in an implicit
close, that's not a problem.

Instead, the only thing that changes is we also die if close() fails.

Looks good.
