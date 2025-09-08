Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C81E1E1E
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757311649; cv=none; b=iP1A5+WjYVNWoi76R0PrhwBuQNxT8rvdpjzB4JLp2+/lQ1dYdwl/x9Crpz2iT0CMF0FPOWIuxte0txPHlMrNUYt/0uyNszWvgZsPpP3hWOBC5sthGKF3lS1C8/+fupbtJQJzRMHYUw3y0LyPA1Sehgs5mmuEPBRAuI2mcArg2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757311649; c=relaxed/simple;
	bh=5N1DgIvJfLpBu65j4R/vKp09FSHBhiDymUs/nnpntb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgU8d+yUHiawHtm675FQ68TAW0Yt+eiPNuISZp/NrggG7HIr7kxHWHIPSztAgucZ2YjqYvUqlI0Vx1jki9Q0cVi0QgCm0y8tU5MnCNYzI3hKHMU21Mgxq8I6DM1hR8T9oQYJYg/mjsxHy+v4a+zP5qX4pjrCFFpA/nKY5s8VtxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArtkTGz0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArtkTGz0"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61d143aa4acso6369498a12.2
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 23:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757311646; x=1757916446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDiyrivV/VdaSZnKtkYjBfbC4uPR72/UzirZHzZmQMI=;
        b=ArtkTGz0ao/gunlN2PkBO59x2SheCGbbXtUzW1FUW89v0PI9oEYzYkHxVAB2L7T/cf
         CDgWwf8EA7KNDtruhtyNN8Gz/UHgSl/KxXa5knLhtLdI6zcLVcjLX5FCRMVelLoanItR
         TX9criZO03EA2Cx/J/joj7oQjYYfRd3rJNWF3cT1C+e530Tu42zG+puxrKQlXcHq2vfD
         Z5ZuKhvrEz2I+rdqAth/XrMGho5vyUSt2ntm1vNchfjLYp9XQzI4FKRSagICPd+7jAPV
         HMGtEM07OvGlrPQapACQ5IfUWUtjMMfutcih5bA6631QmwdWs6iZVEjXxLNOCossQJGF
         M5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757311646; x=1757916446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDiyrivV/VdaSZnKtkYjBfbC4uPR72/UzirZHzZmQMI=;
        b=Ii0ZFez4LsgeMBpIAVQmkP1gEBUr7+Nb8GIqwFDX+enn6CuD7oxM2SDYS17A08X2Y5
         zh+UsKcegj/RIxG4fPRetdixFbD7ZCq4N+keCEHuSM3nmxAOIYURZespSx74qEr5pSsK
         3Iik9v8h3aPmECgjh++OYR6hD7f5VX1v+wDuOP7bIctNzZRTaORBBEjgN1+pinfXeQpf
         vMnN3j51KIH1W9vsoKsAuPNscaYasx0am6rrRaxSKl1kyzywzyAqfjlLKVgCNfBUgu0N
         bkepiOFINi5hrK2w0FcYuONVL5kW+y5l7Oq154Ka3qJtef3yqCalgSPrVtaNrWUswlBA
         blug==
X-Gm-Message-State: AOJu0YzX9tWybq+dQs8wpkbvEaHsBoNTHfUNW06WR6Y5NpbJynI5otzf
	yniq0U0HjMhAuzdLcIskSj2Ho8aGsNGcaiLyAMSON77RKNc9SkC/JVSdJzbum79KiVJcXaAmK/t
	B5dqEhrDIjJEyEYPQqqXCQdblLryeJKw=
X-Gm-Gg: ASbGncvC7pdlyhue/taAN+N+NFiJfwJ2AFk9UYOZGtH92HzZ/QJiu0uQBID56LGSC2E
	JfEQNyUSCf24dWdRsC47uWeB2LEvRdm1sdnhSfrpeE3lRKp1ang3qs74y00BChJNYv1Np8TALam
	BfdSP9LSEI/PhVwp8vv8h16IVRVqrvh8+5hZz9QSKrdmhEgG65Wy8+uZE1Q/H7G9bZT1/IRbXYR
	M1LP3nPMw==
X-Google-Smtp-Source: AGHT+IFUPhmW2fO5GKHZ3l4Qm6Tw20AtV8VblDDgq2YzKabo8OInP1oGxIVyEIUGD7sBsBJLBP0IlFsAsdx0KGNMgxs=
X-Received: by 2002:a05:6402:1ec8:b0:628:f0df:2ca2 with SMTP id
 4fb4d7f45d1cf-628f0df30f3mr1114893a12.9.1757311646170; Sun, 07 Sep 2025
 23:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
In-Reply-To: <20250908043620.57848-1-siddharthasthana31@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 8 Sep 2025 08:07:14 +0200
X-Gm-Features: AS18NWDJOnJWeqhgX_OOBzWJ2I1AAdYhO8-UaSmsDSw1VWeGI_Fqm6F99u_GR0o
Message-ID: <CAP8UFD2XyqgypPfkQav4Fub0AEwyJjXpvfwMPe-adWyCKRa7fQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] replay: add --update-refs option
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, 
	John Cai <johncai86@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:36=E2=80=AFAM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> This patch series adds a --update-refs option to git replay. Right now,
> when you use git replay, you need to pipe its output to git update-ref
> like this:
>
>     git replay --onto main topic1..topic2 | git update-ref --stdin
>
> This works fine, but it means running two commands and doesn't give you
> atomic transactions by default. The new --update-refs option lets you do
> the ref updates directly:
>
>     git replay --update-refs --onto main topic1..topic2

Thanks for working on this.

> I discussed this feature with Christian Couder earlier, and we agreed tha=
t
> it would be useful for server-side operations where you want atomic updat=
es.

Yeah, right. This is something the Git team at GitLab has been
interested in for some time.

> The way it works:
> - By default, it uses atomic transactions (all refs get updated or none d=
o)
> - There's a --batch option if you want some updates to succeed even if
>   others fail
> - It works with bare repositories, which is important for server operatio=
ns
>   like Gitaly
> - When it succeeds, it doesn't print anything (just like git update-ref
>   --stdin)
> - You can't use --update-refs with the existing --update option

There is no existing --update option. This series also introduces the
--update option.

> This should help with git replay's goal of being good for server-side
> operations. It also makes the command simpler to use since you don't need
> the pipeline anymore, and the atomic behavior is better for reliability.

I have commented only on the documentation patch for now as I think
it's better to review the design of the new options first, and the
documentation looks like a good place for that.

Thanks again.
