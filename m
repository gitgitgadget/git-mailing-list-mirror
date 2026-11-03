Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793701162;
	b=wFMw6Gob5oK8orRQkAWkFcR0NnamRD8chqu0BEUrChUxRGzpb0TE8gJbV/UIGegolmAd
	 REA2ZgMIWuxdDMIb/I28V6AwKOZV+v+ykak8Z/20NyWbz5ZQV0P6nbpDNK+xLX+WoDkGO
	 aPNQ2NtK3Bo5MoVLHWXWeW87yMaoqB2GOHImmUSg2TJ7GN3F/6Wfgs2Gaex1ojyfhq8Pv
	 OqR4/tJk8wHOzsvQ31qb9WvA5p+yjC/kWaY8Yx9v2iACop7FfvvY0Yz7liS8ila0SjDcb
	 GF84aRr85mEM/kgxkESEtPXoJgBzRfb8ZyKxHPQnxaKLQDGsZohgVFJkqrpAPKjw9lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=xkSe7FzCh6as9yMHTLYyoNMCXGgWC0JK/tAl+WipHck=;
	b=vkxElBBg2WKXFEdSqAcCqFyuLGmuRqbnerE9FD/X4klFVsOIVLSTaZPp9lJ0/tPUYhTP
	 bF9+2AtN4u+NGrzPny0lK8Lu1qQwmilYaczwdVH1a/7YwbST51wFr3/cS0tKgbEwZFBVo
	 HHpb5h8wcbUAdMhDzx59q0CkGv+VeLUH1QVxQqfxRQnFncpvvhyJGQsGcLplBxUNXs3fJ
	 af1W+RKww56cT0iAAh7zlNlWTywpzuWojTqc/f5Rt4gfxlbrrbh5K3YtbUKNxEhdOavkn
	 OB83jcvlgGvwA0ipZ8nsweaKq8XipaZv1OrqkLVw6r1oXHbtPDiqOfgVvrtaoZgtdPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=PzU2AVRB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72C8606A813
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E72C8606A813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=PzU2AVRB
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c247f6687dcso687145266b.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 02:19:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793701160; cv=none;
        d=google.com; s=arc-20260327;
        b=Lvz8g8cI9/luvFihD6t6SuA6626YdV8Kn00NoNK20AwtGQp2024zaJAtpvOIi6ku+3
         ak3QlG9zDtLnRg1OEr2eLkCCir2NDuPiOOxQbb7DPur/dUyL3FRfDbXnnI3w6nlPUuW4
         YuBHpcUJvD6yJh+SjKKOKqIWEXi5yS9rz+J3Ip8Ctgqu/43U4ycX7xdfO+uk0Zvcs1s1
         ysyH/tJiEI2Il3cbjsR4mmEgqglZRkk3hrw6giBi2Ftg7JxseHINLD5oGgitJg1xhhPL
         noExIrBjB59fnDAuDaeoaddA5VFkYEJo8m5DFuWHeulnw/0kmxOu6dHQBXe3llgtEQRV
         QwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xkSe7FzCh6as9yMHTLYyoNMCXGgWC0JK/tAl+WipHck=;
        fh=uncT6Fx2r8v/4/bAgQHGXh33Ng96LtW/XSNHoQBEoj4=;
        b=VYuiEC3C2ZdFyauxTlOsUVdOHU0vzx5B79C9r9eUy0r+xNzcjv4CNt6rh9rekGcCGZ
         9QWb4hzpSVqz6mzsK0Ij794gL4Pi7+0omuRorEySLVZhJwAlVWzWwfE+oPbAhxOb3ciw
         okW0LUnjeqC7C/35CTM9QIegNoG02NtY+QmvNVi7wSSw56SHPBaPBaHzVFY5PGbBmIgS
         YiDbafyuLV9Gwn2LL3Z/YNmJ4tjSMA13VY0xVnvn3OobgwZH0JCP0rfee/cSTgKHWQRe
         r27bNtVc5nUowQSnp2iyFbmtJgH7gwKg9EwAQEvyISHj6Oj4Jrgd8L5FoSfqTwsE3bfw
         JkmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793701160; x=1794305960; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkSe7FzCh6as9yMHTLYyoNMCXGgWC0JK/tAl+WipHck=;
        b=PzU2AVRBfIqzL4OvryQ0eiIOjM3jjzbpTiHzPnIvDZ5CF0XDIGAO/8DYIHC8raoYk/
         ZiLi275hnS/dyNvEN9sRY0oyPMYmSajZWqFKO8Xww7gcjh4Rah8qcHgz/b5pCvO8+WV+
         NTXB/Ok941qu/ZRnIJlFEK9mM27soD3c/j7nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701160; x=1794305960;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xkSe7FzCh6as9yMHTLYyoNMCXGgWC0JK/tAl+WipHck=;
        b=YKi1jNwsjJzuvOdWkEKdCUgsaJediuMNUzSyXNEdLfmurwHsJ8LEPO6zR6//72sIW6
         bpu4ljrr12+G+iIziIKz8tyCi35lwqcfCqphUeIFFh6l+hBBZH31Gs2F6boPcC4J6sVq
         B94WAoDfhEsLZnumTcscFHrtplJKIHVS7GflhqQsASAMffzhdNjmSu/6dc2An4rc9Tr2
         1HG1q4TCbGRNaHNy2xEGKgQvi91AnaFT78gVPYn9UObT52BeJfCDaW19FX1H/e2+T3BF
         tv8YJMyEWngdhFyE+hvI4vZbUkmc8x6Ti6epDnOJAei93rRnLib2QGsZx6YG69KLyy5c
         2kpw==
X-Forwarded-Encrypted: i=1; AKwUvBxCWZ8/N6v6N63/ZDwOnVIo7PaGL/9OY+uZ58RJXKcLqnQPeotrkw90k5FJ7T+j0qIKq1w=@vger.kernel.org
X-Gm-Message-State: APuU4Z93G4kKqOId2tREQKlA6pvZBU2pV4+vobbxXrnRpWMFysx44Hlk
	awITGnE/2/IqNYmFt38+CaQac5TvN6BeCdJQxNlvzyuk9DywHm+zfaxbZ3t0mBfvVVaKq21fmZP
	Ytle3hkxoSMag5hJ2FlCqqlUbe3hjP5mC0CuXB0nhYQ==
X-Gm-Gg: AYBFou0r2w0mfoq0/GGeEL66tJC008WwM6Bre2gKhQDu4QwS3peinvQ0VN3SlgCDRKu
	4xk39T182NojMmQm9FAWVclc3XIKZT/UNtORoEvGth1Ud/1Zq086E1kkW9alHhf1eeemDBTNPQC
	MeZoXDP0EAY5HohiDofreo8yFOWPJVHvLcRQriXphe5NLhyFQwVDzI3ePfIJETv7A8HYjv66SJj
	xcaUa0dmaRpIpLFRglQdG3bOCWM+2mD3KJU46xHc3Vag7SpGBQaSB83fy/oIUS0rCbZwKlW8OTu
	hfAjblro0ObMQ/SHLA9pLSgeamvwgOlds4VPNFsF3xdnpU1apPyyhQOqKKc8TDLlwc8MZfUOvEu
	IAI2aoln8WQvPhJAh201FIcscQQZGuBZOdsgqwg==
X-Received: by 2002:a17:907:96a9:b0:c46:2a05:b257 with SMTP id
 a640c23a62f3a-c4ca7a4066emr999679066b.23.1793701160290; Tue, 03 Nov 2026
 02:19:20 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
 <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com> <xmqq1p92g375.fsf@gitster.g>
 <xmqqld7aen0n.fsf@gitster.g>
In-Reply-To: <xmqqld7aen0n.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 3 Nov 2026 11:19:06 +0100
X-Gm-Features: AclHuK_7tDIDUR5hs3LV2JOMcGRZEiaNjSMfVIGxM2N1I5T6pGgjVN2dYEWEGYA
Message-ID: <CAL71e4PmDkhc_LX_efeS2RZuayjLX2ORiwfQBC4rxN7xSEgYvQ@mail.gmail.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in the quarantine
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 02:12, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >>     Changes since v1:
> >>     ...
> >>        quarantine outside of the commondir.
> >
> > All of the above changes make sense to me.
> >
> > This unfortunately crashes with Patrick's odb-reload-alternates
> > series, but let me see if I can get a reasonable conflict resolution
> > or if it is more reasonable to ask you to rebase this on the other
> > topic.
>
> I decided to queue it as-is instead of asking you to depend on the
> other topic.  Here is what I got after making a trial merge to
> 'seen'.
>

Thank you! I also read through Patrick's changes in
ps/odb-reload-alternates, and they appear to be logically
compatible. I couldn't spot any problematic interactions,
and your conflict resolution looks correct to me.

Kristofer
