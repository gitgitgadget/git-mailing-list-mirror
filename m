Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA81B3B0C
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264848; cv=none; b=ni+3bC9wOQDj5NVxFxKUVF4v/LHXEbZfFySoodhoeLIFZn1tpZKV6as330xZAJMNYoOa9RqeUK3pd8EHwlxsJJ4eCZqd0mewnQrJzRhUIpqRJPt0cD/emVD3wWLtmrfhAlL1mDG69kt1G4GCvaCfNi1l2Od7FKih/V0XT4hz4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264848; c=relaxed/simple;
	bh=f1XOKWjPwcZjdIpOM8djJEcioVZU519a9rVpKOBW/ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=l/1w7rhM8NjV00CFHKLqOuXWK7u9ZHUvr+ki620tiVYfmkYTAt72ylRY62JuXPwVnTcJv+niOcqaJs0s0brlR6c/7OoM5C1nhq0nEofY79YkneUCdQEtNJ+PJ+4Dy3o5k2ZLCInVwS4CllKQhA0h/byqXDVIDkZYU1QEnTCBFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-493b2710495so30150137.1
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 11:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724264845; x=1724869645;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nm2/uOsdKBGjS2SkusL+VvCH9Sjq3ZAQvpwullZyAqc=;
        b=uTFGUVBRi9Yk6Pp1R2WH9GWoi3P1Qij+35RIg+JKfx04jNRU1w1IzEt9B0Wu3+sjwR
         MH/nWyysrOdmz0XFuIAXzBTeLECdr47nH0M3mPbfQ/3fUn0Hgn6wtdiVav4Sa3+EbGEV
         KjGKRYblwPNv6zgx8WKCqGCdrxsxh/ylBNqSyrzF9nzCHNTiLKJt3zHF2E5oTUqeOmxc
         aTw+AGw6HsJgd/8DVBGOOyZ6RcbwIE0TtNYcYTQRjbOZ9Lq74nHguCo0m2CfO5ne8ya9
         s5R61J7GOhcSu80WDGKgCarivF5JxjssG63tV1KnjUN3rFWfu4/nm0cbFf43JqCOzjSn
         oiTg==
X-Forwarded-Encrypted: i=1; AJvYcCXJVocqo1TvoWk0K2tfEoNwdYqE7eqewxc+O0lK4WuFcvF6xS1GEsgEjkT/7rh7QlaWR4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3pKgqFYNXy77/5X9QoAtn5hIHxhQ85rTaYgMYFlRq7HFegdRe
	bdrxJb2VmMKNYoBH8NVH6pnRZXosDwT5iQyxbHKtD/7gaccS6FpxpnypHcgRNvn6i+HeFpZr2pg
	3cO7j7Gc+MbccVOIY27DVIUQkgeQ=
X-Google-Smtp-Source: AGHT+IHRIvkZOiStQB6W3Numr3C8m8mDCOG2dgIqzWi5wrDPimFhOjVeiS2e5ouQ/iNVGpe1o/EXtSB6eoRVbrRGhTU=
X-Received: by 2002:a05:6102:440d:b0:493:b58c:7d98 with SMTP id
 ada2fe7eead31-498d39e4dc7mr2214373137.5.1724264844933; Wed, 21 Aug 2024
 11:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>
 <20240819-jk-send-email-mailmap-support-v2-1-d212c3f9e505@gmail.com> <mjlmmgwczact5ryprmorqztip2ynpcu5gpbulfabnoul2ubnr6@pfaxe7j4xo3h>
In-Reply-To: <mjlmmgwczact5ryprmorqztip2ynpcu5gpbulfabnoul2ubnr6@pfaxe7j4xo3h>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 21 Aug 2024 14:27:12 -0400
Message-ID: <CAPig+cRhEJP6-ZX3X9SYrGM335-XTp8V=D9Yc7xkJQAh-g8xRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] check-mailmap: accept "user@host" contacts
To: Josh Steadmon <steadmon@google.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:50=E2=80=AFPM Josh Steadmon <steadmon@google.com>=
 wrote:
> On 2024.08.19 17:07, Jacob Keller wrote:
> > diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> > @@ -73,11 +73,40 @@ test_expect_success 'check-mailmap --stdin argument=
s: mapping' '
> >  test_expect_success 'check-mailmap bogus contact' '
> > -     test_must_fail git check-mailmap bogus
> > +     cat >expect <<-EOF &&
> > +     <bogus>
> > +     EOF
> > +     git check-mailmap bogus >actual &&
> > +     test_cmp expect actual
> >  '
>
> I think I'd just remove this test case altogether, IIUC it' doesn't
> provide any additional value vs. the "check-mailmap simple address: no
> mapping" test below.

I had the same thought upon reading this.

> >  test_expect_success 'check-mailmap bogus contact --stdin' '
> > -     test_must_fail git check-mailmap --stdin bogus </dev/null
> > +     cat >expect <<-EOF &&
> > +     <bogus>
> > +     EOF
> > +     cat >stdin <<-EOF &&
> > +     bogus
> > +     EOF
> > +     git check-mailmap --stdin <stdin >actual &&
> > +     test_cmp expect actual
> > +'
>
> Similarly, I might change this to use a real address instead of "bogus",
> as we're no longer checking for invalid input.

Ditto for this change, but even more so because this is a fairly
significant semantic change. In particular, the documented and
intended behavior of the command when --stdin is specified is that it
will consume email addresses from *both* the command-line and from
standard input, and I think the point of the original test was to
verify that it still correctly recognized a bogus email address
specified as an argument even when --stdin is requested. Given that
understanding (assuming it's correct), then the original test was
already perhaps somewhat iffy anyhow, but after this change, it is
even less meaningful.
