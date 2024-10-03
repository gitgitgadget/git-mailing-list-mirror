Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207491CC8A5
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994135; cv=none; b=FX1kX02hpW1M93sSOggjdyHB4FWml5YTmmHpuyD2wepqh5bTrnku7YXFw+eR+NCRXlH/wm2BccW9XtNAkeWlInpzPy894DBDHngeNHhhAZonOnwz6QJAl86pw12tSdxotA/akJQwK8hre4Tn4EYFj52gVqutmrpnuB5fdI46ifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994135; c=relaxed/simple;
	bh=lAFai0jn7hGB4Fn8Y+S5vnX5xLqKrqrO9dKU10yB0eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOZUNCKslX8KG8uOxgn1i266kDoccS7d3TXziW8plgwK0sXXghnjfrxhY4lC7cb1Ac5w7SnS7a8lxNLqSUJuAghd1tg2c2LLTTBV6cVWpVjnD3B9UtG0VULl3efHcTBNiq9Ze2JfoENZfO6y4b/ATu3HCEjm4Mn6Ob/l/NutNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb36237f28so1497976d6.3
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 15:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994132; x=1728598932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAFai0jn7hGB4Fn8Y+S5vnX5xLqKrqrO9dKU10yB0eA=;
        b=CT92A3kzc3yeGlAxD2Fm3lt3yfHfSb3Ifi+mKuPzDwamYY2c+wzVHixcg7Iwml2feE
         VDXon7HgFeff+yhhVuxww27wghXJ3VXQfDdHGheA8yUa5DuYgyHhp+7eOX49fIA2D26C
         +xmEYD7iPK8oK2xBrij423LtKMfcKi1Z6dSjbDquXadYXZGllWhhZYHD8hXeUs/LlutQ
         Jbi6eLSGGrofaX2pps1orP9H1WenzB5D2Lg7/P+daJ9ql7ZpK+NuR6Okb0MfMwIi+2to
         CYrnmQ5q/xFsN2+yJjz6uzp6KPoptV/dBZZMDagb87+TcJ1GS82zG4adqQhFZVKSYPty
         z9BA==
X-Forwarded-Encrypted: i=1; AJvYcCWSH+/GFTZLudnprxrt6uBgrIId33e+HkdL5eOSJ9Ng/8hihRpeW5uJYff7YnSVGCH1Nf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/WbGMcDVsSOXSglhBdKDJUtkRYtGU3Y2u5p+UojIVcmQ3LOz
	++5uQtlxRrySbr4QeGK3+nKxK56ZC8gdqOfZTrXtFiu/T40iNNCPjN0Or9MqD5E0Vf261uN1cUA
	3I04aPNvc1f5yMmhOInG3ifCgXWY=
X-Google-Smtp-Source: AGHT+IGbnXYaiNG1Qi5aHQ+Zs/gy9GeytcOXlWnNjrySuSxzTLAlhuKQ274v6af9t2SsLQt+/c/gqtpWagVM13dlosQ=
X-Received: by 2002:a05:6214:2481:b0:6c3:67a8:dd48 with SMTP id
 6a1803df08f44-6cb9a456115mr7224966d6.6.1727994132022; Thu, 03 Oct 2024
 15:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727881164.git.ps@pks.im> <00fd829833cae1d192d6c42237aa13427156e3ea.1727881164.git.ps@pks.im>
 <CAPig+cSqeKJX99jbxouJZHdGZuyAgNz-wOgt+0C5OPvW3MHgLw@mail.gmail.com> <cf2ad192-928d-4bc6-974f-da5b217fba30@gmail.com>
In-Reply-To: <cf2ad192-928d-4bc6-974f-da5b217fba30@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 3 Oct 2024 18:22:00 -0400
Message-ID: <CAPig+cSuXojVPeVE_0HFwrQQqYn-SwCvHQ9yG+c8H1dgaH00pA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/21] t3404: work around platform-specific behaviour
 on macOS 10.15
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 11:16=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> On 02/10/2024 22:43, Eric Sunshine wrote:
> > On Wed, Oct 2, 2024 at 11:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> >> Two of our tests in t3404 use indented HERE docs where leading tabs on
> >> some of the lines are actually relevant. The tabs do get removed thoug=
h,
> >> and we try to fix this up by using sed(1) to replace leading tabs in t=
he
> >> actual output, as well. But on macOS 10.15 this doesn't work as expect=
ed
> >> and we somehow keep the tabs around in the actual output.
> >
> > I presume this nebulous explanation is due to the fact that the reason
> > why macOS 10.15 exhibits this anomalous behavior is not yet known?
>
> I suspect that the problem is that we use "\t" which is non-standard
> rather than a literal tab character in the sed expression.

Ah yes. The `sed` on macOS 10.15 would have been of an older
BSD-lineage than the more modern macOS versions, so that makes sense.
It wouldn't be a bad idea for the commit message to mention something
along those lines.

(I always use literal TAB with `sed` for this precise reason, which
may explain why my eyes skipped right over the non-standard use of
"\t" or I just wasn't paying close enough attention, which is equally
likely.)
