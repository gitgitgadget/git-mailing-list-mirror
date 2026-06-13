Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E23074A1
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781359734; cv=pass; b=t8yg7zF9oPTMpJQnsDVhi80ageHnT2NmmmHpo8j5N1XgWTczN97yOiRYbCPt+JRnLRyw3owMy28lOA1xxb8oH3769VaT/QHYdV47vXM2TPfaqe/qeGFJWbPnkb/0JsB0Vjnlx0LGMD1pH/cQWnpVGldOK1AIWEWgaFdZlHwIvrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781359734; c=relaxed/simple;
	bh=EBnffDY8LhY7dZoQOwebmXRqbp9s3Cw/Gix/RmP2WjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZxexJ6YUQLRkeckZrKM8NQ+zshenAR1v6pOVpoywxowqNSV59DLqw0lyA/MEjnLpuSfI0XFyoPtUBiPvL0j6uK7O52yoeTNAGpDflSRtk6xBJI2OXag4qxjINtV/BG4kBlI6zsqvl4yg6mn0zqREvA9iuZxmPD+Aoq0QvYTbmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=gA3wtUF3; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="gA3wtUF3"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dc2b658544so12929387b3.2
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 07:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781359732; cv=none;
        d=google.com; s=arc-20240605;
        b=gx487KK9hNTHsv1X7Q0kHyx6H869wDIXp4S9klWFsPO5dqVkzfI/iraMa7puJjunMO
         lA7u50bqJv5SkSWAMq/39OGu6vGoVB1GoVLcZVwUzeSo3Ll5QbEdJbDT7++tZ1QSBwvE
         XZ+rKZk+jPc0UmO3WsLAYC0tOqeaVDpsyEgD+obU0iOyjTYGepwBbhVHB+CsQQ5giafJ
         ynz3wgX9VzWkulR/JEbiclK2gsuvGnbFOpIYuURmJrZaxAqiXLuJjwwTd1jJDk9Bus4U
         +r3zd+9CfeZFRKA+sHp53Wll7hvoEcNRVPrWET1P9r92Nv/EmsQqyvstOvyTXykvRgNt
         2Ktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=82Q+JtSGDjnPrfHNfouFNOjErIg4FQmj1J83nO+w3Yc=;
        fh=2qQh3Twk/9BXP2JN1YJEg5XG37bzhSBn4OXZs4ZhyG4=;
        b=cTQVo2+tXCnu8rGAL6hpxfOOFVMgwPkTvU9EjOe287gj9gLssTz4P5RIsA/zfqLdqi
         i+GrwCzCZXnDdsxUbOeqbUcFUgwXPCmYc/P5UufdnjkQ/Ji5CKhs9uQ6RJgP7wTncy8j
         +xV7BFForu9Ba9sxB/S6E3l9Mv8qB1ICdcGgAwD/joByEeS7InJ1QwmLewKPq2fXyO4u
         ZDGArKd1mxzx1rUc1XRYuqdvVhfbudj2gzGOrZrtuxi583Bz2ZIu1LbX8gz4f57GsZj7
         kjYEEU2ML0m9sQKip6ToQMwX+LLPHxu7ld3kINsYAiSm13khyiTKNIWQ388uUqHlFWYv
         c+gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1781359732; x=1781964532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=82Q+JtSGDjnPrfHNfouFNOjErIg4FQmj1J83nO+w3Yc=;
        b=gA3wtUF3vQUCz3hCXx2GnCKYWY0vt/S1AwVWoy6HfUCgLQ7kpnIcz86OiBeKx/Cht/
         bsO6hTNECtJLM/Jf3s6u4axwrAJnQIhyTUq0NoICziMFkZuYmzZXNGBiZOadY8VLzDhf
         KhAjxjz/32EXJUtOdztGjBUiDjvb+w69cEcyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781359732; x=1781964532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82Q+JtSGDjnPrfHNfouFNOjErIg4FQmj1J83nO+w3Yc=;
        b=aek2KhozswAL/H/2FSzNS/WAr0Z4KdstJN0/+XSPCPcRhMn8UZ6mLamJcpwvNkbY9q
         5woCU31zJgSaY0NM4xF848/bjJqEXPVUpTHN9QelNwrpqrEOuSMukyqqKl+tIc61CvQs
         Gz0RoLutgxwvAOmoxPmuOrRPwov9XmCWJ5of2PsFYLQ2hlQWRV7evxzmm4gvCtRkxzDJ
         JSb4UiN2XBmjYchxmBIllPKzd2oA7piHXGZbZS6LJqk+7ZfkkXjS+7AANZsTBoaPhd12
         BWOuF/LwNA/Jxz3WJyb4FwH2VJu0YCB1DHIJgbNFAKVeKIvG0nqOL7rjxKhjLYLASp0N
         XlvA==
X-Gm-Message-State: AOJu0Ywh6m6/mex8HrUl8bJ4Zt+53cONbSsKQe39/dd5ZIoOR+0x7Gzx
	KRtUzypb/e2trbU80AJ4c4ACDILv8a4FK0avBC6G5O8Gare7dIavKm9Do+K2SXwq+tklr2n7z6J
	8ywliYoN2iTSrMFv3BTgCbL8kfeea265RknTUpzm7Pg==
X-Gm-Gg: Acq92OFwYjbiWJekRg24/iXM1E5n0wAaIFR7TIMymFv+ML1DMiVzvEvo4TPMlD+9JNH
	cP2j5Xb8oe+npdqpcidJ7yYIXBaa5gFt4V4+U9AwOGlA7afwMiNhpnvkSJIErU+x+umq/wMF8i6
	ek2J/xFFdMN/Iuawv+ZZr+fLiLzoIs9Mnm4C9F5WvTaUVu1WH3J31jQ4zB8WT04BpMmPaLMd3fD
	9O/t1xSgGNNEjWozlx+4OIp9yjRYyF6CEGKocZAQPAqTLT1AycRzdWF62CQ9es5qEA5f440r30i
	66Pb9Ec=
X-Received: by 2002:a05:690c:e362:b0:7dd:7b0a:819e with SMTP id
 00721157ae682-7f7b792ca18mr76547207b3.27.1781359731671; Sat, 13 Jun 2026
 07:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
 <0b3f7429-a4fb-4f7a-bf7b-5a0edeb1db52@gmail.com> <CAL71e4OmPzpCXh-zZ8NsT6L4zVKnXV1gqiFZ2w0XgMJhD=LArQ@mail.gmail.com>
 <8d0902ca-98b7-44a4-a23b-51de44ab6daa@gmail.com> <CAL71e4MFb3UUKBr1P4ZwtK3o1gvUHMs+siCpLTXKkW6Vx=BxRg@mail.gmail.com>
 <8c06cc48-d036-4d01-98d3-e94b5edb389c@gmail.com> <CAL71e4NRvmDagFAJE-0HYwiLPSfhVVQO2qZe-EJPVXxeC4PWqg@mail.gmail.com>
In-Reply-To: <CAL71e4NRvmDagFAJE-0HYwiLPSfhVVQO2qZe-EJPVXxeC4PWqg@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sat, 13 Jun 2026 16:08:39 +0200
X-Gm-Features: AVVi8CfB9Vatrnb_PM1tz3m8XpTzFZBeinSMV6723MtA4dK5ZgU5QnS3ax2yc_o
Message-ID: <CAL71e4PD+zT2jLjjvC7EuYX5z6v_VafnWOUDHeEDBq2LGOK7Pw@mail.gmail.com>
Subject: Re: [RFC] commit-reach: terminate merge-base walk when one paint side
 is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2026, Kristofer Karlsson wrote:
> In both shapes, C is the only merge-base.  But in shape 2, the
> walk through X's ancestry is P1-only: STALE propagates through
> C's ancestors but never reaches D's lineage.

I have to add a self-correction here:
STALE does reach D through the main line.  The real
issue is that the bypass branch has a low generation number, so
max_nonstale keeps the loop alive until the stale frontier
drains all the way down.

In our monorepo, the concrete trigger is imported repositories.
An import merge brings in a separate history with its own root
at generation 0.  As soon as the walk crosses one such import
above the merge-base, max_nonstale forces it to drain the
entire main graph.  Instrumenting paint_down_to_common confirms
this: `merge-base --all HEAD HEAD~1000` takes 2.3M steps, of
which almost all are stale.

Thanks,
Kristofer
