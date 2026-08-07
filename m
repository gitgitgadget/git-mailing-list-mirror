Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB10345EB7
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118293; cv=pass; b=eYRSK89cQ7b0rr/PEv1WKhUBcXVx5o2dGYZQRA1z+baZm3exmAvKg/4wmEHKVhL3QezLLxXDI/DH25CsonhVgKo8Vk77EjMgZiVou1T3vagMsYu3Yzi0s5G+0ybWNDsbhKDI5jfzXN8YDDWBMa2YMLsoAd6Jeyz/3xvO7ybT6AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118293; c=relaxed/simple;
	bh=hHXYHAJ6IS3XPLaR6hF6GnVEreHZzRrkfiCPT0LZunU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKdVE86qmS/z4PrnXQHuCk7mp8kEljf2HWqROClHW/KJ9qiEPm6d2loFYGujMSIfRv0BTZ/gG3wLddLp8846WmxmtCXG5gxZzGArRGeBUWzlXRl07FcI7cnHD83MH1ewR1mibKJ+9cC2UJDg6v5a2wuzkStNvm1UVY/MTfwRx4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=VoM8Fa6K; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="VoM8Fa6K"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80cebd41372so53795317b3.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786118290; cv=none;
        d=google.com; s=arc-20260327;
        b=VuWYX6RAt6V5xfTJ0Y9DLqazgzGs+yDVq7kYYPnIaiyQ5ZvurV3nppnq19DwyOkvwK
         JKbDocKa5qfI9Np5CuorjVpD3C4TrulqvSj05T8MjggXzAO6UGg/1qo602mSO0har6F5
         f+3OuE0RuBvNQYgKpZYDAwdoi1sba0kSVhtgWIlReOxLdejfLcNKJCHtg2S0jCmnJTKX
         s+1+ebsdmvg6tDXP/qdMIiXJsD4T9TdKOFuNz3Us9I5lR4aL3tbTHtbZg/a5r/4ykgD0
         AHack87cWXmvc2Umo5eOKnBNTheW1fY4jAU2P6ZJTo9xSRGXLDFAUirs0/lCmpbMklY6
         KIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hHXYHAJ6IS3XPLaR6hF6GnVEreHZzRrkfiCPT0LZunU=;
        fh=DBLE/l5h78hZNRedv8+dYMuoTBE+MYqdK8zXkJNlbf4=;
        b=HuILsWH6VBTWSdHdy3d04XSaTDfAuhlXhCI/jVe9jBDjLdhPh3OHijbk/JQk0Q7aZL
         1/q/x+c+yrFL3bD5ywNoFfNtYKYp9mrPYDGueooq9HsSKsixtv2HRSNuh9t8P5t25w4f
         U/jtYQmqRVaaazGgcbPaGZO0NwQgwziRXKETlHZWrJHiC5XcLkk7Z40Cfs8TXHJi9zsa
         u/oz+HvBZ/ZUwKpN14OLCuIcpWstZdJBQLK9/VLvg1okKX8Qs0+N48O6+8N+w312zBO1
         S44AkxZqpiEthSTcg6K29aXZu57s8Zzp1exKVedZ8GTr8ydMlbcp93zwwQfZUQXjLyHP
         2Dag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1786118290; x=1786723090; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hHXYHAJ6IS3XPLaR6hF6GnVEreHZzRrkfiCPT0LZunU=;
        b=VoM8Fa6KV85SLIHCwCVYBhu84ouZbfWuVJO80YHYsLJj0DrWCb0sJsWbw1kke2eLKJ
         tHlA7RKAAAPe1nJ/FO0KuiGlLydeW0b+PBxYU6UHtxcXiWsafQFSDSPHoAIMUkc0slua
         woF+3ejnu4+vQVBUMtw9o0mGMgE7fdZkHTW9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118290; x=1786723090;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hHXYHAJ6IS3XPLaR6hF6GnVEreHZzRrkfiCPT0LZunU=;
        b=a/uqNGExo+ZdXjA6O2mbHuQdm8l88QYBWuitMWHeMi0I+NjQST/v69KUdGg4JYkWAu
         VBzVM3uT8at7rchg03CJeC9Vjb9zroQH+XYxXYWCKl+HlUgNIqGON5vC1Qt22s6zT1Xu
         /fO9+/sdXXSvs63rcseJwEDg3FpjXzMCLQHjkG3Pry1zJj2JY+Patg0MXd6o/J1S2h4/
         bgz2OcLBQlpuIvIBC2Yhm1pBXKiBSggnMIisLwMsSr2dg5j0cOcSMK5Ezjwhrp2dRNns
         w+InBLtR1USnBHRG89zgQzJlwKxoAmF0i38W+0oawUWCryIx3k2aH+yYndj7oNbtsfuj
         lNrg==
X-Forwarded-Encrypted: i=1; AHgh+RohENKUzebKVQ4Zd5n5jN8zBS3xAlK7sK79sZReZwq1jy8TIcyvI8j5UPudHSRc/aBBmmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlv64tJiL/tJfDRimL4RJRIiI0kkOutt+VlauEWf8bdbC7gCrK
	hbILq0QlF2lZGMcpm1OW47n8UAxKXNQQSKYIh9UabhwCRsZbMGHXJZqRSrvnvVpeQ6QCTtnOkwK
	gx3D4HhS2wDzYUsyab8by4okfTcbOQONVf8OnKoeEuA==
X-Gm-Gg: AR+sD126qUk4onjazTJ2jT5LBGLNK6n84D4q5eh8YUP1zrax/shEukpYujH019IUfrk
	M+gAVa+oIvKeBinavjbREAapolYf4tvStQCxo/bkPO5eOQyh1x6z6qtJ+x9qSjP6kjf7hmVBin+
	9Dg2fjGtCV6tFfMytF/lLzv4XsWdY6fH5nwLXRNIO8Zd7/M6tqUiBDmNlfZ7WsXj9I3W3xWAMlq
	XqKr3kMrnIOqi3qnzdGH5bXKX+V4GV+2Jr6zNn0Xj9+Sgz8QjiJ+GsGUAPDHXLtET8J21DVpmLF
	FfCVgzyogS5sghRssUMi1NO2YT66jQX4R5P2bRVAvzY=
X-Received: by 2002:a05:690c:4a13:b0:81e:735b:c880 with SMTP id
 00721157ae682-82022631e89mr147728227b3.26.1786118290097; Fri, 07 Aug 2026
 08:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <490be76befc4689d463d472829c0271351b69a43.1786013982.git.gitgitgadget@gmail.com>
 <CABPp-BHLHGQxuG3gO+nCa-FPFyOFEU2rk_oxLtFjekLqENvQUw@mail.gmail.com>
 <CAL71e4Opn3u6qYG9xhhkB1qqYj9ZLk6_=fxznyFzSFbrh2BMTw@mail.gmail.com> <CABPp-BHE2KwjcVc14heMhpBLz64eEQ8y6qu56vzXKN9VK12qzA@mail.gmail.com>
In-Reply-To: <CABPp-BHE2KwjcVc14heMhpBLz64eEQ8y6qu56vzXKN9VK12qzA@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 7 Aug 2026 17:57:59 +0200
X-Gm-Features: AUfX_mz7N8pUhEMODJ8xv8i8W3VeMTQ04XFpopdQkecJ0arFNOCaLAlORsxXnGc
Message-ID: <CAL71e4MDRGWeKsmKsRhyFsSBT8+QKbiGZ7+AydRk_Zxb2arn-Q@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] commit-reach: add trace2 instrumentation to paint_down_to_common()
To: Elijah Newren <newren@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 17:49, Elijah Newren <newren@gmail.com> wrote:
>
> I think a short comment in the commit message about the new tests in
> this commit triggering the existing min_generation optimization would
> have dispelled my original misunderstanding and made the review
> easier, and would thus be worthwhile to add for other reviewers or
> future folks running across the commit.

Agreed -- I was initially thinking about adding a comment in the
test itself but adding it to the commit message makes a lot more
sense. Will fix.

Thanks,
Kristofer
