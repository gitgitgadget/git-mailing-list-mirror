Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5A2E9753
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849948; cv=none; b=QoU78m+9DX09kxgJqP3xgdlC6pW68ftCmVwICyxuecmJJRYijPZiw4wFeCXu5nypwgsm9rGGuaKwT0p+PFf5KLqImGhCbsFI18ytQoZMBjAFPhzIO5KA5kSCqJ4h6zxhPe8bhFpGjhU9ihMkZu+dSjxrIF7XYlZ5p3rap2ONAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849948; c=relaxed/simple;
	bh=sb1cmYzm1pCjn2WnqA4RvJzZwb+zLkV/gI3443M5HbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDQTwk6nLjTO2HGsX2aoIugmmtfffLIxlGjDLGiaCIyJ93+YP1tGmKyoyFRadHpAu1Z85GnuQ0y6h3Duxz2JhuNBgiDUdlk1FGbTkAY7BfxOsMCErZuAiSGJ3nKfGq4IIYXDwcdX3CmiP7C/KjNiYSUQzu12LsQNFpJbePqnWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e87055f827so86555485a.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 14:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756849945; x=1757454745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ltT3L8a27n9XxK88UKYeK9gGYK6FTYeZ4qpPBI4mUo=;
        b=eL4t9dpFPng5NIXnuuC37dvZvpdlPtzn4JusUPtSRJQyZgxaUxgzG6sYE0TP7bStD4
         y2iNHzYysnjmoV/5FxqywJtbpBH2XlHBSBk1qJaN4oI1FM3FGkjoJuCt+ys2y3ihge8x
         vLp9XDkfJfvRdUrN17Qz+dkA3s6hFaJVOYRrEwFfWxEj9N8hbUKdo/l5D0fRADS9+PPj
         mJRv98DklkU/xGDDXITu2gETlx3BWbkY/+KvIvt+IksIkdNhCpqDsSZCjfA380a5b0y2
         VrDpDmyJvksMxEA8GC+QLeEkHqIqoiSDvCO+Qd+IOMmIIacpFxkDbl5BYZVKjOZfFyYw
         Pw4g==
X-Gm-Message-State: AOJu0YwYnRsim3HXX9yMea/K+CXpR5iLIjxlhX2353CYg1DCWq0Tebsw
	EhoxgUXV/7Bn3y5wN1QTbe0Lgh6N7tZJCNZPTELxmTqVMdbMIkXvkNYNdjheb8kQUU93kYUuR4T
	S9fpgQdFgAApA8O/eWO4SGtHuBVkHoFM=
X-Gm-Gg: ASbGncu+jMd8LumiC4tW9HlDUeiDArVXprbhMxskGF8X0ik+62s42+KI0YiJ9MpsDfZ
	E02XshT1NSLOISCF7Ykc8SkOy9GKsxhO6K2WSJWzmV9mTWv1V+4O5Vs6PD2IO3cQamQfptRtzAR
	j+VS/7gBETBjPNiAvAPbDvRNmaPLRNQhC4HPBA5Bg2Ig7Je+Dz9TzzTN35Z6cbfG7ASxEBhgJPT
	xjLOT8SvKccisqKZh83XkcsRjADBOPXL2GI/vGFQTUD8HSc8q8=
X-Google-Smtp-Source: AGHT+IE9193lOq4KK0mdNtznqzOGaKHyxAfZvyqbsXWC7k7bphs7YgPCISTY4+aRVDU6kUBwYmwovFchxzw3hFklpPE=
X-Received: by 2002:ad4:5961:0:b0:70d:fc2d:7de9 with SMTP id
 6a1803df08f44-70fa1dda407mr114573216d6.5.1756849944711; Tue, 02 Sep 2025
 14:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22c8463a5eebc609b4848f6db1db231fcce7d839.1756840261.git.me@ttaylorr.com>
In-Reply-To: <22c8463a5eebc609b4848f6db1db231fcce7d839.1756840261.git.me@ttaylorr.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 2 Sep 2025 17:52:13 -0400
X-Gm-Features: Ac12FXwYuLZJoeYlsUWfRVSXWlbS55t9z-1dBrqhRcOsqMM-TpYVlMfNgPImvI4
Message-ID: <CAPig+cTPgkkhAdmws9XM58744zs7A4QDOkgnYPcbgB0G9f1ivQ@mail.gmail.com>
Subject: Re: [PATCH] gitweb: plug various command-line option injection holes
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Moritz Sanft <moritz.sanft@outlook.de>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 3:11=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote:
> When running Gitweb and loading a blobdiff with the "hpb" ("hash parent
> base") query parameter set to a valid diff-tree option, say,
> "--output=3D/tmp/pwned", Gitweb will faithfully execute "diff-tree"
> internally (via "sub git_blobdiff") and blindly pass in the "hpb" query
> parameter.
>
> In other words, visiting a URL like:
>
>     http://127.0.0.1:1234/?p=3D<PROJECT_NAME>;a=3Dblobdiff;f=3D*;hpb=3D--=
output=3D/tmp/pwned;hb=3DHEAD
>
> will result in the file "/tmp/pwned" being created. This happens as a
> result of gitweb executing something like:
>
>     git diff-tree -r -M --output=3D/tmp/pwned HEAD --
>
> , where "--output=3D/tmp/pwned" is substituted in as the value of
> "$hash_parent_base".
>
> There are various other spots in Gitweb which are too eager to pass
> untrusted query parameter values as command-line arguments, leading to
> at least the above option-injection attack, and likely many others.
>
> Since 51b4594b40 (parse-options: allow --end-of-options as a synonym for
> "--", 2019-08-06), we have the "--end-of-options" command-line flag as
> a standard mechanism to indicate that any further argument should not be
> interpreted as command-line options.
>
> Guard agains this and other option-injection attacks by placing the
> "--end-of-options" flag before any untrusted user-input in any place
> that gitweb spawns Git as a sub-process.

s/agains/against/

> Reported-by: Moritz Sanft <moritz.sanft@outlook.de>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
