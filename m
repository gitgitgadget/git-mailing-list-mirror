Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E641643B
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959645; cv=pass; b=rrLoI37q1VZvc/qZdwjyteROZWZLgT7M31t70kjqtX+SQSEq3KcvESjYfAAHgFkbFlkWt8CEbhvK6VBhhR3eG83JKN8kilcmwpZSQWN2wk0Lb11WCYNPkMe9XdUgVY5kmbV08eX/Ba6QTlzvOi2UrWyly0Pq4mDqrkYkbSuE6fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959645; c=relaxed/simple;
	bh=SPTBX9fFv41jqUIGMBjKUOJVFrXbvTUbFVYtII4YnAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5KbY/VB2QfiLDtnWkSZ6bM2KxCQW5kcer8CfjOhLWvFM0LGcQFbUlMn9QWrlzfrEfRH0HOZozV6vsm01VP2NStSG3L+skgwDJ8UUCck8SErq1FECPVGRrW5dKpwxJsoFTF17JJksyyaQSdLqHmGWSEfWPl+MFAwpCoI6yvGUPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZBZgbap; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZBZgbap"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae736c64so1749815eaf.2
        for <git@vger.kernel.org>; Sun, 20 Sep 2026 20:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789959642; cv=none;
        d=google.com; s=arc-20260327;
        b=BvTIuHyn7TNIjqVbpkQO5rWZsJz56+ne7zC9vsON+FgLrbr6R1npU830iy0RRs5MKo
         U6bwFgwD0Jw38Jd5RncT8WioNDRUd6cgWiR6Hf1pmBxWVYWTXbIqTM40eOacCtezHlX6
         3BUvX8ua9VaSnCTyavsL+pG5XS192qNsM8s28InbCdqw+L+1Be8A8YMcumn0rdnGOld4
         RiLdy/3yd41uGw/3qoiTMEkuLfoIqBl65oXWCM0wXe38egWibkITZ6UuKmeYxO/VIJ8H
         69VI4FyNLG+ryKJYYi9n2IM1FJTYk7pCBxPpmf1nTJhuzfUzqBLo4qSn/syQHv2b/bHe
         1eSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uApeZzZMZaC/jPOUt7Z0YY7Zx30sEZoQcw/0feK+K1U=;
        fh=1rW94no4T5u0/JmNOFtiyo/IaKxrJb25payfrPPGXvk=;
        b=OND3qXdG7TK5LlNbu+lTYiLoZZLJ8Dx1TDyO+RNtlEdHJeNcl1/C03meUTjrcFU7S5
         WMyFaCPWXRmCxcGAPZ9STH0kUfq55ttQgXkVWW3CRfUCnI4pRoXEGrISQSCkiPqCRbuG
         6jCZGlUvahrP6KQEvLR8PZypcOI/y5wY7XO7aVhfrdESP4Wex94oZbOfslG8NrL/hjD+
         3RYu4i4Gnxos5NdpSB84NwKyKeQHIUtz1as1hCbSrQAM0vXJFY5qOlWZP7uoQt+dBocq
         Ewz9K8RbOP43HZ9CeGLikpY7iRi7KNKQecvIMSzFcEG8I7OVKHifok2a2JZNsvvvUx8N
         nrag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789959642; x=1790564442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uApeZzZMZaC/jPOUt7Z0YY7Zx30sEZoQcw/0feK+K1U=;
        b=MZBZgbapmOT7jU9SeqB0b5kKg14+CQtDcclt5QU8+xX2EPoz+iDbIDhlAyvPB621Ef
         w4tcZtc74Vk3+fXeTT1Q0Y4uLW8Aaj7cAV4iP2tNYTFi3aMjlYXxl9+FMlwL0Zk3rE99
         +G/4sP0o2f/yfVa+7rp6/eLIMRinXYPQfrpOkvgUyoM4S7X5oXmwA8XmTyUPYHGW8h/x
         KGUkVwkDTT5a4L2c2hU3HhYXnluS92zdyxfgBODhU4N/ePfSTGZh54UxzAa2TrL1IkTC
         sKX8rXckM5YYXMvyyhdiXkShvaQMwPuNatF27YOXqFy/I9kEMMgvk+d3pgtSmaD33HxV
         MrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789959642; x=1790564442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uApeZzZMZaC/jPOUt7Z0YY7Zx30sEZoQcw/0feK+K1U=;
        b=x2uuxNBnPc/RM/17onhzqiKEuAgK+fas4YAbfOi78KweZ22KSgNRDtPPcKU7FQMXrZ
         mSwYiCS/tIiCbQsleTRek6lAabVo6RfDl3LQDNgYAEZXKAZ57SrqK0KH4vXkHmzZ5EsI
         KFm9MuKdvXxoTvysXhwoPJTqXAXfoQ/zh/pGlYslwuQ33FLWJUQibdAMNpaJEYO7Yrc8
         +lb+h8k0H1/EJOzV0pwVsFSgiYJDRj96lepqMA1VVM7qpiQ9oZb3HbZTjxl6ZflVypL5
         MGl0hPFguv4sBoBbTjmhhASc7wayPwkNoy/tRZsfcBszXvMhQgL7o82+dNPcDWO96PEx
         J3qg==
X-Forwarded-Encrypted: i=1; AKwUvBzU66xxHHDqWUPByuhT+XDyYAOEwdQALRwCRCqWLENL1zExeu0N7em4UGhTRH0ojaUO6Dk=@vger.kernel.org
X-Gm-Message-State: AFuF++kcAz7S/iMfL6XHxYoKdeSTVXGBEM0VPOrn4oXGS+oEX/caS72+
	99+8zC/Nhmz+V1qEV0qo5linJlkNLUmHkafBepNGWL2YQalfH8SQp2ocz5Tk9eYsuEOJwoldhcP
	QYabZLxUteaYg8ZQSLHxK+11Wpf7o2Qw=
X-Gm-Gg: AYBFou2lw9uhlNe/7DseLjuubxv5I0rfaGbe7EBGd8L5s6161wQcOI7/q3d9cLBFjtu
	k+1jsYwO9UV/030cP4xkdNHYV8EvFR5f6uV01pI8h7q5pndLSjX1QWZxgdKa74AB5E5zTT1MVn4
	RSvs+RPDWBEXgSBGfxFroBhcOYUWYU5Ecdf6/f9PSk2AzzqgM0szLXBQcKP8CD7AnOQBoWm97fc
	yOB1I69OAAVqo2m4r+NM/e19A4hH+jpqd9fo2vzGxcWJnOOpN1r1vKp7OfWC5At6Djn6QV/ofgE
	H+v1FC8QezYsU+rFGjkQ3M04Cj89v4BDnMWjqEVWdI/dNYtMXcqwOps463sQZRuAxdWGuJweXL5
	4/LrVZ2ZzqA==
X-Received: by 2002:a05:6820:2219:b0:6b1:445d:aaef with SMTP id
 006d021491bc7-6ca9a135f02mr8672137eaf.2.1789959642472; Sun, 20 Sep 2026
 20:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916042312.35891-1-yqtian668@gmail.com> <bf0351d8-05fe-4f77-958a-2ac59495029c@web.de>
 <1e706ce8-bebd-4ac1-914a-a55195e7d253@kdbg.org>
In-Reply-To: <1e706ce8-bebd-4ac1-914a-a55195e7d253@kdbg.org>
From: Yongqiang Tian <yqtian668@gmail.com>
Date: Mon, 21 Sep 2026 13:00:00 +1000
X-Gm-Features: AcwNN1VN9GSTJs5WjLNP_6h6DeGrkHXa3wxujQDWE3N4ARvDmzMwYmkDhCpeteQ
Message-ID: <CAEs0Zp4LK1ZHkL0tdi_k_=-u86HVm07FzyOJdO-=+DY9c3ZrYA@mail.gmail.com>
Subject: Re: [PATCH] compat/winansi: fix die_lasterr() argument formatting
To: Johannes Sixt <j6t@kdbg.org>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Patrick Steinhardt <ps@pks.im>, Johannes Schindelin <johannes.schindelin@gmx.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9 and Hannes,

Thank you again for the feedback. I have been thinking about this over
the past week.

I see three possible directions:

1. Turn die_lasterr() into the variadic macro Ren=C3=A9 suggested. This is
   the smallest change and avoids allocation, but still maps the
   original GetLastError() value to errno.

2. Keep a function and format its variadic arguments into a fixed-size
   stack buffer. This would avoid allocation and could preserve the
   original Windows error code, but it adds more error-reporting
   machinery for only four call sites.

3. Remove die_lasterr() and report GetLastError() directly at those
   call sites. This avoids the va_list forwarding, allocation, and
   errno conversion altogether.

The third direction now seems the simplest to me. It also follows
existing Windows-specific code in Git that reports GetLastError()
directly, for example:

https://github.com/git/git/blob/9a0c4701dcd5725c4184599322b52933ff5005ca/co=
mpat/win32/syslog.c#L10-L13

and:

https://github.com/git/git/blob/9a0c4701dcd5725c4184599322b52933ff5005ca/co=
mpat/fsmonitor/fsm-listen-win32.c#L106-L109

The resulting change would be approximately:

diff --git a/compat/winansi.c b/compat/winansi.c
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@
-static void die_lasterr(const char *fmt, ...)
-{
-       va_list params;
-       va_start(params, fmt);
-       errno =3D err_win_to_posix(GetLastError());
-       die_errno(fmt, params);
-       va_end(params);
-}
-
 static HANDLE duplicate_handle(HANDLE hnd)
 {
        HANDLE hresult, hproc =3D GetCurrentProcess();
        if (!DuplicateHandle(hproc, hnd, hproc, &hresult, 0, TRUE,
                        DUPLICATE_SAME_ACCESS))
-               die_lasterr("DuplicateHandle(%li) failed",
-                       (long) (intptr_t) hnd);
+               die("DuplicateHandle(%p) failed: Windows error %lu",
+                   (void *)hnd, GetLastError());
        return hresult;
 }
@@
        if (hwrite =3D=3D INVALID_HANDLE_VALUE)
-               die_lasterr("CreateNamedPipe failed");
+               die("CreateNamedPipe failed: Windows error %lu",
+                   GetLastError());
@@
        if (hread =3D=3D INVALID_HANDLE_VALUE)
-               die_lasterr("CreateFile for named pipe failed");
+               die("CreateFile for named pipe failed: Windows error %lu",
+                   GetLastError());
@@
        if (!hthread)
-               die_lasterr("CreateThread(console_thread) failed");
+               die("CreateThread(console_thread) failed: Windows error %lu=
",
+                   GetLastError());

I used %p for the handle because HANDLE is pointer-sized, whereas long
remains 32 bits on 64-bit Windows. That could also be kept separate if
you would prefer this revision to address only the forwarding issue.

Would this be a preferable direction? If so, I would be happy to prepare
and test a revised patch.

Any suggestions would be really appreciated.

Thanks,
Yongqiang

On Wed, 16 Sept 2026 at 17:09, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 16.09.26 um 08:33 schrieb Ren=C3=A9 Scharfe:
> > That all makes sense, but is quite complicated.  die_errno() itself use=
s
> > a fixed-size buffer to avoid heap allocation, for robustness and to
> > avoid changing errno.  How about turning die_lasterr() into a macro for
> > the same reasons?
> >
> >       #define die_lasterr(...) do { \
> >               errno =3D err_win_to_posix(GetLastError()); \
> >               die_errno(__VA_ARGS__); \
> >       } while (0)
>
> die_lasterr is used to diagnose errors of Windows functions. I dislike
> that this degrades the exact error value of GetLastError() into an
> errno. If this direction is persued, then we should remove die_errno
> from the picture.
>
> But as I hinted elsewhere in the thread, this is all overengineered for
> no good reason.
>
> -- Hannes
>
