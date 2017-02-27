Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9701F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 12:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbdB0MlZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 07:41:25 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34689 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdB0Mkv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 07:40:51 -0500
Received: by mail-wr0-f193.google.com with SMTP id u48so291997wrc.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 04:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KvJFLfzxu6nnBwmPt8GtPK7Z/OlsYduwb1wawkeLjbg=;
        b=hO7JI0X8Fb9TAq/C0NsVh/nhmrvvKvr2+7E1pRriGJxiuyPF/c7Yajf+X/OdIHTqDe
         5tKDTPVgEhTGhPDKv5MwB9keL5QTxboYEndAwP4Usnt/sQCt1E2IBlfd0fQEnba+/kKM
         dN3bCShuRD8J5j88M0LQm9RVXWBHyGNS+vM0C8YKwDKndPh6hsucLuVSTlfGJKzN7MG9
         fKGA2sphIroQJjAl+Kc3IxEa5V3QtLtBkTwm+rVS0BuTCJzLpQiCS8+CP0cLuPrfpnlU
         xut/+nuv2bjbe3ZCouQVKIj2G5h4DSIfxhQNwJYVcKMcap2SKjlhxTrxjjcDQGHKzKdf
         ED+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KvJFLfzxu6nnBwmPt8GtPK7Z/OlsYduwb1wawkeLjbg=;
        b=lifa7OXdrogNOAKd+/K51Y1f2gsCuHUYUmUxbkC77oGPPGxSmuD/ao4mbfw+wT1dI0
         9SNs0IFlbbyy0TIBB6jXDEJ+ocRSc9THK8UZ/20E3xYsGoPkdVV+tCQwSr28zqwQ7uQG
         yMAvSBv6LdFV9x5qvr+J02oineWacBuC8ogjPn99BWOVt5R3GiTy4axAqjh44XgFXqjd
         kY9qjVoq6AAEWhISyltKKeloOoApvVbAqMV1sJYB9ZmaGE5XduElXQxBwaC9PjUIwiBS
         51psFYEZxjlKrpfMz3BBQfjhHmSBQXq8x9uUphZQCXV4CPwPEuercG6QIRu85SLL/9/0
         ZPaA==
X-Gm-Message-State: AMke39lrntdfzQLmc1tWviU/PMqgl5wN9WLcOsbbgPmPsqdYoHCGBtHPGewmZeDS6tNsMIeLs3jZRMgjN2yp3g==
X-Received: by 10.223.153.9 with SMTP id x9mr8585947wrb.196.1488199156892;
 Mon, 27 Feb 2017 04:39:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.199.13 with HTTP; Mon, 27 Feb 2017 04:39:15 -0800 (PST)
In-Reply-To: <20170227104338.qfaaktf3or4hwfw7@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
 <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net> <8e98a9f9-a431-9170-df9d-24ad8ec59ed7@virtuell-zuhause.de>
 <20170226213042.rd55ykgymmr37c7n@sigill.intra.peff.net> <CAMuHMdXZ2ZPsFbPUgmvx8=-xj3GBNBJwLaGAYj+R=Z2zDQJ+hQ@mail.gmail.com>
 <20170227104338.qfaaktf3or4hwfw7@sigill.intra.peff.net>
From:   Morten Welinder <mwelinder@gmail.com>
Date:   Mon, 27 Feb 2017 07:39:15 -0500
Message-ID: <CANv4PNm4v7-m=UFUtFutdi2JkV7biV68hAaP=AFOYnz9J37VTw@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just swap in md5 in place of sha1.  Pad with '0'.  That'll give you
all the collisions you want and none of those you don't want.

On Mon, Feb 27, 2017 at 5:43 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 27, 2017 at 10:57:37AM +0100, Geert Uytterhoeven wrote:
>
>> > Yeah, that is a lot more flexible for experimenting. Though I'd think
>> > you'd probably want more than 4 bits just to avoid accidental
>> > collisions. Something like 24 bits gives you some breathing space (you'd
>> > expect a random collision after 4096 objects), but it's still easy to
>> > do a preimage attack if you need to.
>>
>> Just shortening the hash causes lots of collisions between objects of
>> different types. While it's valuable to test git behavior for those cases, you
>> probably want some way to explicitly test collisions that do not change
>> the object type, as they're not trivial to detect.
>
> Right, that's why I'm suggesting to make a longer truncation so that
> you don't get accidental collisions, but can still find a few specific
> ones for your testing.
>
> 24 bits is enough to make toy repositories. If you wanted to store a
> real repository with the truncated sha1s, you might use 36 bits (that's
> 9 hex characters, which is enough for git.git to avoid any accidental
> collisions). But you can still find a collision via brute force in 2^18
> tries, which is not so bad.
>
> I.e., something like:
>
> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index 22b125cf8..9158e39ed 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -233,6 +233,10 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
>
>  void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
>  {
> +       /* copy out only the first 36 bits */
> +       static const uint32_t mask_bits[5] = {
> +               0xffffffff, 0xf0000000
> +       };
>         static const unsigned char pad[64] = { 0x80 };
>         unsigned int padlen[2];
>         int i;
> @@ -247,5 +251,5 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
>
>         /* Output hash */
>         for (i = 0; i < 5; i++)
> -               put_be32(hashout + i * 4, ctx->H[i]);
> +               put_be32(hashout + i * 4, ctx->H[i] & mask_bits[i]);
>  }
> Build that and make it available as git.broken, and then feed your repo
> into it, like:
>
>   git init --bare fake.git
>   git fast-export HEAD | git.broken -C fake.git fast-import
>
> at which point you have an alternate-universe version of the repository,
> which you can operate on as usual with your git.broken tool.
>
> And then you can come up with collisions via brute force:
>
>   # hack to convince hash-object to do lots of sha1s in a single
>   # invocation
>   N=300000
>   for i in $(seq $N); do
>     echo $i >$i
>   done
>   seq 300000 | git.broken hash-object --stdin-paths >hashes
>
>   for collision in $(sort hashes | uniq -d); do
>         grep -n $collision hashes
>   done
>
> The result is that "33713\n" and "170653\n" collide. So you can now add
> those to your fake.git repository and watch the chaos ensue.
>
> -Peff
