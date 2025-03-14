Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390221BC3C
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961425; cv=none; b=W6VekQH9JlAz3mE/TeFx0EUrLoQ/JX81VJR/fQz2i1WFxdC1elXnOXQ1L5f9Qxl9xdwxfnzccVwOftS/A+AsEio2+PeGGvVvBHZkpMitivlfGkQn11uAy6AvsFFa9T77QLkEQ/uFkt0CKO23CSH6voMgxfox1lkuV/F8PmYoe6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961425; c=relaxed/simple;
	bh=M6OyzZGNq91TkHZYkc2r6DGuMkp7hRaUYHAEpDa4/Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jd32FRlspMDd0kAO5C0XdsLf4inw1LuNON0jRcXvxXsdrZw3tnmDK8U7qPhrdxepnjQV0DjYtkKxnr3FZwWnKrY05SmCYP/2rQYiD1otJxpyzlBanykH16ArBkjj5oidKZDkCE6KJh22Rj6HtMoDhqNzzv+iOxfkJSsHo5THi3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccycx5uc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccycx5uc"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so307646166b.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741961422; x=1742566222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LFKe8AiT3/DaIlppk+Loby96MZDcqUGUSdpwXKLRfs=;
        b=ccycx5ucoCDE8ZKEfAjUwoEpLaBJ3jUrdWpLiBMCV1U9rAMgqlDBh66R7HuxiNhURm
         c4Sq79UlqqSQqtgYd2OjSpZTnDzVATX2F/jFSpCidOrD5dCv/ErtJC4irCiQp/RY+R58
         KS76f59zlvkdyO1kIBDaoqHhUNdbQgHVBbJ2cMKfdTmD0+7DhXWVBIIPcb0b7c0eZlRR
         347R0beRWWP2WD5+yCPjfSJcU0/gB1a3H8rO+KAsYtSYoLHj8VJ/Tfd3PZpxFk35WQGd
         l2fR6smJ2GJ9/PE5eTUjgoQog8vrCmJxI7sfLlXB4u0ME4CMPnceuYBWB1DDXwxfJrh8
         QGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961422; x=1742566222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LFKe8AiT3/DaIlppk+Loby96MZDcqUGUSdpwXKLRfs=;
        b=DBLaoWxwSPSveAn6A2llUkN9FPDVWXDytYObkutuM1wRDRw6cScVCwSWs7x3f3LPnp
         FIPxue63XIWQpkuod1hmnHSSNGSZ5qhyxgUT+srZJ+oUD8xKJWmNozCYawkl495Szajx
         Mi6TfeNsfxb0N0XMw/ayumz/iLVMGPIWpuDY1e2lxw3zk5Hpal8/HrFcc+32K2xuQQlD
         fs+hP/fRMJiixcOhwc41Zj/A/QTcojB1jaz9OcIiSkYopDV97GnwGRM9lc4eYkswqcEl
         W2hce9LdwvVdOb3BN2hyNsb7sysGpJ49ZfbKbsbhBt0oL9m2bTiO71nrZ3tkJKSgP1eB
         g+8A==
X-Gm-Message-State: AOJu0Yy8XakWmQgyJOJ31+26j/VM0/MHEsXtRNcrK9SlNuwSx+e1ELOw
	IseCdz2gU0Cd4jDRSoNal1m0C0uBFJlDkmee2j6NysYuzLwaOZztu0X6Gc0n83nfBeoEmwOy7hV
	dp9xoYpC8zB/08SC7raNc3md5Iiw=
X-Gm-Gg: ASbGncuJLjqFzpeOvJE+z0Asbe0kA/X77L9+KnDImG+cvsuCK+htz6+CzkU8tm/vg1Y
	fr8Q7ex1f1ETwgoLxLrpk02jtwnEkQW36AW9jRxryq24+DE7EwB4Hsx5Cobx5INry7tO9dNebYb
	Qfi4FBEroHnSxNaSrG01aAg7PJZNYq92ymfUpr2AY=
X-Google-Smtp-Source: AGHT+IEaOhvvceH0HZEBm3qninABXf3d25m9W0hWkHTqfzpfn7Jf8T4vil3GWagdybRvKo4dEsAmNzwQPlXNMxMfbaA=
X-Received: by 2002:a17:907:7d92:b0:ac1:fa31:78cf with SMTP id
 a640c23a62f3a-ac3303716f0mr324685466b.35.1741961422017; Fri, 14 Mar 2025
 07:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312114628.2744747-1-christian.couder@gmail.com>
 <20250313103859.817127-1-christian.couder@gmail.com> <xmqqv7scq4iu.fsf@gitster.g>
In-Reply-To: <xmqqv7scq4iu.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 14 Mar 2025 15:10:09 +0100
X-Gm-Features: AQ5f1Jrhzsvu8EmkqthTKIAeu1wPVucJSGojfJIIpGPc_tBcXajR0RNTcTvRGuw
Message-ID: <CAP8UFD3O9_22br2vxUp2YqsE39JYHwyf-G0FJ3PqQg6mO5q3+w@mail.gmail.com>
Subject: Re: [PATCH v4] promisor-remote: fix segfault when remote URL is missing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 5:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > While at it, let's warn and reject the remote, in the 'KnownUrl' case,
> > when no URL or an empty URL is advertised by the server, or when an
> > empty URL is configured on the client for a remote name advertised by
> > the server and configured on the client. This is on par with a warning
> > already emitted when URLs are different in the same case.
>
> That explanation makes it unclear why we need a new one.  If the
> configured and davertised are both empty and the same, according to
> that "warning already emitted", that is not a warning-worthy event,
> is it?

We have to check that remote_url is not NULL before using it in
strcmp(). If it is NULL, we need to reject the remote, and it makes
sense to warn before doing that with `return 0;` because we warn
otherwise when a remote is rejected to try to help diagnose things at
the end of the function.

And while we are checking that remote_url is not NULL and warning if
it is, it makes sense to also help diagnose the case where remote_url
is empty with something like:

    if (!remote_url || !*remote_url) {
        warning(_("no or empty URL advertised for remote '%s'"), remote_nam=
e);
        return 0;
    }

I have used the above in the next version. Also I think this part
deserves its own patch too, so it is in a separate patch in the next
version.

> > Let's also warn if the remote is rejected because name and url are the
> > same, as it could mean the url has not been configured.
>
> Are we rejecting a remote _because_ r->name is used?  I thought the
> code did something quite different.  We reject because the url does
> not match, and then after that give an extra warning if remote nick
> was used as a fallback URL.  Even if URL is configured as 'orogin'
> for a remote with nick 'origin', the code would have rejected the
> remote with the same logic in the same code path, wouldn't it?  It
> is a bit confusiong to call such a situation "rejected because name
> and URL are the same".

Yeah, I have removed the above code as it's not needed anyway if we
don't process the remotes when they don't have a non-empty URL
configured.

Thanks.
