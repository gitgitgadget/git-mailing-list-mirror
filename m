Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A83F2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 18:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdBWSkv (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 13:40:51 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:32984 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdBWSku (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 13:40:50 -0500
Received: by mail-oi0-f43.google.com with SMTP id 2so22104568oif.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 10:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+BAKWoSm2prNLbBzNBrJkKksXGaga6F5V2i9H1FzBO0=;
        b=clmBJycfTCdahdD534NQQKHVzq0niJ20hAE+2e9UpxlnIhZiUgGF589rV1S0Sb+xwX
         Ulv6xwH1E0pwZ2WTJ+/w520EkzWyLNI6sjy02gmAc6rP8GfvwJzFfieMEsmhFhAWnHYj
         JzVsAvGCrY/P6i7jIb1hOCjfLNK2zc+b7Lq4Suv5Tj3Wl+S/AEW/nzY3hePImUZ3J3kx
         dCjn8OWV6IA0EFAyqkktf7kAIXWbKO4g3jHu6inCaYkZUT2831MxvoXcP81Vbcb5U3Ic
         Qgr0FakKfVLzP2ZTXjddc7KLCsoqU4y1x1NFvl2Ue+X0ESLIcA6ygz3uvQXebwd55pRb
         mMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+BAKWoSm2prNLbBzNBrJkKksXGaga6F5V2i9H1FzBO0=;
        b=OXnakKHG2+oNWCuG4QoZbMGqTimFgNcW+5ErNELi5Gbuvm0sXdjgEkghEb62D/aUGG
         z0ZomzaKZotn0irVQnuPy9EanOdOf6obbtil15DVEjVbzmaUUzNDIfsupbY1zH2SBh4d
         9Msx9XhEAyovqVoFeBmuXhvLDhluSaGwBU5vM106qfJOKuL9u58unQu6TsU7ps+aHE9l
         Z0RiilsDm+kzzNpiJBSPAGEE9zqpxonfhvAHrvykvd9zw2LBzUGf6C8T3pWCsrRIAlSf
         0JjVjbl5kIsPvrHGujOFCpxxhbumN9kdLEQFmPwnUIDHyiTusJxJOLgGXxFJxe72I8rE
         QQow==
X-Gm-Message-State: AMke39nCtODgZZwPOZuZCUfD4RH4zRdWzqxyI/jJWepT8e+/3iu3cQ3p9KyaWyMDwdHbLZoa8ABZ/A9JdDyLTw==
X-Received: by 10.202.214.145 with SMTP id n139mr12403979oig.177.1487875249320;
 Thu, 23 Feb 2017 10:40:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Thu, 23 Feb 2017 10:40:48 -0800 (PST)
In-Reply-To: <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net> <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2017 10:40:48 -0800
X-Google-Sender-Auth: 1NzxuUe_ocjaL1eMJutvEZvlgYw
Message-ID: <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Joey Hess <id@joeyh.name>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 10:21 AM, Joey Hess <id@joeyh.name> wrote:
> Linus Torvalds wrote:
>> What you describe pretty much already requires a pre-image attack,
>> which the new attack is _not_.
>>
>> It's not clear that the "good" object can be anything sane.
>
> Generate a regular commit object; use the entire commit object + NUL as the
> chosen prefix, and use the identical-prefix collision attack to generate
> the colliding good/bad objects.

So I agree with you that we need to make git check for the opaque
data. I think I was the one who brought that whole argument up.

But even then, what you describe doesn't work. What you describe just
replaces the opaque data - that git doesn't actually *use*, and that
nobody sees - with another piece of opaque data.

You also need to make the non-opaque data of the bad object be
something that actually encodes valid git data with interesting hashes
in it (for the parent/tree/whatever pointers).

So you don't have just that "chosen prefix". You actually need to also
fill in some very specific piece of data *in* the attack parts itself.
And you need to do this in the exact same size (because that's part of
the prefix), etc etc.

So I think it's challenging.

... and then we can discover it trivially.

Ok, so "git fsck" right now takes a couple of minutes for me and I
don't actually run it very often (I used to run it religiously back in
the days), but afaik kernel.org actually runs it nightly. So it's
pretty much "trivially discoverable" - imagine spending thousands of
CPU-hours and lots of social capital to get an attack in, and then the
next night the kernel.org fsck complains about the strange commit you
added?

                  Linus
