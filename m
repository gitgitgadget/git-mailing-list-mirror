Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722571;
	b=McXeeqiQFllkraeva9DHxkQiI747hcSQmbOEYxVcaP3YKT0pVOc8XG0W6Isk+cfMwTJM
	 RelNxnCP0j6YZ6DYf0wW6YLuCQhDCcQk2zm6jht4kBF4KoXvafKXCQtpx/pY2f4lYFK2d
	 lKtbUU15BnJ+tZy8jRWtGktZZg4xIWACywSnj/ZmmO1JV5oTIy2Ggn1R1OS6WYr+4hTRS
	 sFqi2mcAwuMu3O7uLu9yczYdX3g6aB9ofsYD39vasQjHrp0tpEl+ftcqi7jWmjrjYMYn9
	 FDy7XbIoR4Ln9xdKs4kl9LVHb8HwBTKDqVFY7snk71/lJbbMMDsnOIvcfJV5IrooRoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=sx6TuxhXAPOhr8YfH/4UTC7A6nmD3P9PxNXnb7gpRtE=;
	b=3HFrLfC5wnpyXL3n/p8dd+A43anPk8ae4O9bsSoqJTet/CDGaQwgt8s5fWhW4ADbkTwD
	 axR6z4R9uGr4NMaH2iNJ2l9o/oApdEheSR+dIgq0ps9ZaQelEBFaL0cM5hFdrHxqwShBy
	 K0ns4FyctKDgQ4xmVvQg65is4l/IVTz7IyfPfZim9t98vZHAbXxjIhM2OV61Z7Rx7KwJK
	 YaxD5OKdBHBi6wSuu5+887nuxf3C6Ub999HUqWu8jQlFiSkbNoXeqZ5xv8/vJ4B8VYrLh
	 krNpUblspmg6jfOf/n6tCAXOs3yVl8T78IEgGX0pL+tLEYPtdQcOmrq2yL7r/5Kn60A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M4uB3hiZ;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602AC606A332
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 16:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 602AC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M4uB3hiZ
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-47b47de8b4cso2408839fac.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 08:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793722570; x=1794327370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sx6TuxhXAPOhr8YfH/4UTC7A6nmD3P9PxNXnb7gpRtE=;
        b=M4uB3hiZL+X2uHPzJYpHF5pjXRb70E+43GWw1JUr5Vwhf2ec1nWmD/WsJJ5uPtiG44
         97QGd8xMb7914a4chyFXGYwuVZ4lAjnYDlwB+8UJkkbFwaynVRFBAh6CJwP9Kifi1IDw
         f2vk2MyWnqQl6C4sv7rH+pp99XFx/5giC3r4T5q5gVzbaD99ckYYRxc2ng5UkvBIIL+Y
         CTZuZ+plxc86jN78okYiTs6RK9oiJi4YfluCRYh3aCg6NKPuq0MaupXn3b8epUsB0LNb
         Qh2VhncHZZglXuHFGOWHVqkv/iM1FbNNAPXUeMVZ968MO2XMJz2+OkRn/pa5LiPFs8eR
         BqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722570; x=1794327370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sx6TuxhXAPOhr8YfH/4UTC7A6nmD3P9PxNXnb7gpRtE=;
        b=oUr8A/xcFLzByX4DC0+kN8nxsaYhT/PGZc5nIy4ybmCWgQPJTBh/Avm3Uc2/0KUMYc
         /8SduAi6H7jZi97f0ItUZzfE5h7ObIKpAoYze2uykO1He8XenPdmnapgDYOotTVDlwUp
         fGkS5qwbvUOr1U5t6H5nOJF6OtYZDKF/i43D9R5CzFwrvXAyLpa9MyPcBNQ7fHWugLHZ
         oOa9JglY4D94zuoZojx3gw9IozwfmUHImgcfHKlVon3Ufz4AH9PiyrtqVMyRTutYATFj
         GCR31Y5Ylkq08hetjqSqk6X7zVNEUynM0AKVY590YJOJCztxvMbhY5wgH6IVp2QTpPvi
         OqDw==
X-Gm-Message-State: APuU4Z/yTGxljpweIRRYCnyGxz0Go0N56fVM8kzy2IzsvE/0xkqhCtw1
	l4Q5++Fi0cdvxf8OeXKBwk0MHAD7cYa8F8YENG+6p0bZUZ571akqc2ji
X-Gm-Gg: AYBFou17tH4fnSS+NmPlRJLQdzVL4M50QBwxzDTm8UN9i+if/wsQHWEgmAWhbuvnUGt
	nssqFXWpBAtTujq+iyXQjg3EFOIixlCAfgWK4JVJFmdKeIz3vxsTtVwZqDRZzLc82Doj3lJK59c
	hTAuQRtvy6CuvvIcnMn19ifJ6EPnMAjv4EkGuzfpbEmelDEv6vM4ywwcLBuOlVv0YMMKunMKCZ1
	IoLLU/OZyFZNo06fLBScpFF/L0+4Hdn11nHzUOZS4AokJsYUREjHkkPbgQznZ0QTHrPCQAHlzCB
	0THbvaee0y8YUr+G7HauL70KYov1kpFwdGXzdjcTVB2KGRzccv9IEIJyVH+y8aqd+EzMHGSHLp1
	TrmjLwSYwVFpskLYLpn8Onedg/SeBDvxsMOYOHVMnQV0NstfS8RqbzoPaNzmercLYkB+iBGckQH
	YIMoWDCy7zHLVbZboZvXhOxxdKCfYQq1pbuLtL0J1UjLWrsoNd1m7HVBWO+XzDe0gmIQ4wUyZ5J
	8CmAo/g9RNh21IF9p6kjN86t3vGm7selqTkBWuaLtEfHhZxheShC2p1fH4NJn8obgP/HR8BETM1
	GIsF8D/3JcJpuPCSi+ThYVYcCNX+P3q0xeQAEhyUoUTu1W03uk5/
X-Received: by 2002:a05:6870:70a4:b0:48f:e107:3188 with SMTP id 586e51a60fabf-4a907778d19mr8256831fac.40.1793722570177;
        Tue, 03 Nov 2026 08:16:10 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a9218e97fcsm10218586fac.5.2026.11.03.08.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:16:09 -0800 (PST)
Date: Tue, 3 Nov 2026 10:16:09 -0600
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Subject: Re: [GSoC Patch v7 4/8] repo: add path.hooks with absolute and
 relative suffixes
Message-ID: <auoHYyR7WMfqosDq@denethor>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-5-jayatheerthkulkarni2005@gmail.com>
 <aukHlEd5udC1gLYZ@denethor>
 <CA+rGoLeSfwSQs6hOyGxjRhyCLqjWBMQ4yfXUYWiCz+MHqsgWAA@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+rGoLeSfwSQs6hOyGxjRhyCLqjWBMQ4yfXUYWiCz+MHqsgWAA@mail.gmail.com>

On 26/11/03 08:01AM, K Jayatheerth wrote:
> On Tue, Nov 3, 2026 at 4:02 AM Justin Tobler <jltobler@gmail.com> wrote:
> >
> > So if a repository has `core.hooksPath` set to "/dev/null", the relative
> > path output here would be something like "../../../../dev/null". I
> > recognize that this matches the current behavior:
> >
> >   $ git -c core.hooksPath=/dev/null rev-parse --path-format=relative --git-path hooks
> >   ../../../../dev/null
> >
> > ...but I'm still not really convinced that is is a behavior we would
> > want to carry over as it makes it harder to users to figure out when
> > hooks are disabled.
> >
> > I would suggest we print the "/dev/null" here even when the relative
> > path is requested and document the behavior.
> >
> 
> I am more inclined with you, and
> I see how returning "/dev/null" for the relative key makes it
> much easier for scripts to detect when hooks are disabled.
> 
> One thing I wanted to check: in a follow-up series, Junio suggested
> extracting a common helper library to share implementations between
> `git rev-parse` and `git repo info`. If `git repo info` special-cases
> "/dev/null" for `path.hooks.relative` while `rev-parse --git-path hooks`
> continues to relative-format it, would that divergence be an issue for
> sharing the underlying helper, or should we special-case it only in the
> `path.hooks` getter?

I don't really think that would be an issue. Regarding the follow-up
series, I figure you could just not use a shared helper here if the
behavior is diverged, or special case it some way.

-Justin
