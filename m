Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC7F20A29
	for <e@80x24.org>; Wed, 20 Sep 2017 20:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbdITUZp (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 16:25:45 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:55924 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbdITUZo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 16:25:44 -0400
Received: by mail-qk0-f178.google.com with SMTP id q8so2056001qkl.12
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2NIehxA2/tu0NUWzzFiC7vg2vzwkRa+1qe3si/POO10=;
        b=vauHsZGepomAa+WUZqcc68ztTP/MeyVVqlPK7r71Z/yoX4h8htjVBwGtoazyAjiosC
         TpvWlRtEecwCtEXLyN8KcmhrZ+gIO9Zx4Jok8K+AqtB9A7zVywWPt0uGojbyV9NAS1ZB
         mqBtSonUdSpMoXciw4Z9mlV8zgx4E2/NpybQ0bs16Pv4fdDA2xjcM2Izg7yIJuDu3bAR
         Zmpa5TcQfsd1BwkWNcSE549QhIHQiC3qkHtxEfItq1IACUbcoo3Iz/SDYkqlql2Jp1R9
         IYRbIehT10vcsGQw/OvaTFt4ccdY/lmAuFuCjDYchTw7j5bR+RBWyckxjLsiZCbRj5CC
         E0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2NIehxA2/tu0NUWzzFiC7vg2vzwkRa+1qe3si/POO10=;
        b=p1BlAxYJgClILxBdQj7+nUMJZtrk26gi1y3L/+A9X5wSTPy8k9Vjwzx1kutSKbizzo
         Cew4QPVQDMQGCNBOxGCl5GiLbPamXYProwNxEdHWmdp6onke5UDSB0gFgHEuVgfqgIZT
         /MpLdpb7Qa5aOuaHQimEIl58jnUlNHHJUBcUGsmL2ZYaQPJpxAXTI8Xb8xryWP1Y2HJc
         xSFMo7hNHq25T4o7TvYTjJ7lDdiZunI5WHEjp5U/eH5KIAsNHjSaI16QFmpH2u1c5/Py
         O/7je93LH9Nh+MT26Cfn5lEqOqjOfMVQ/p5vmK37vOa1WOfZEISQKIhIaNSsx0sapd/G
         2KWQ==
X-Gm-Message-State: AHPjjUiFX98JraimLnUw2dCGhWjIHQOGhsI5jwzvrcJ0u5cNZmsIS+DE
        R0EFX9dl5lt/chXVcKngK2/eqmzmmAGj0JuhIBx/Dw==
X-Google-Smtp-Source: AOwi7QCa5VMfbJWuudcSxuRJjEA2CS1ELee1xfNcZwPLFk0kcoBCnI3WESwRDDc7/pxmxbZ7HegM8uzrErMJe6/j46E=
X-Received: by 10.55.45.199 with SMTP id t190mr9286218qkh.230.1505939143873;
 Wed, 20 Sep 2017 13:25:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Wed, 20 Sep 2017 13:25:43 -0700 (PDT)
In-Reply-To: <2bb2e8ccb57eef8acbea5004167751a007a1bd2f.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu> <2bb2e8ccb57eef8acbea5004167751a007a1bd2f.1505799700.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 20 Sep 2017 13:25:43 -0700
Message-ID: <CAGZ79kbwCAidGR3cgukdjckZVYwj+qbOikqN-e934uP1yk9Cuw@mail.gmail.com>
Subject: Re: [PATCH v2 02/21] prefix_ref_iterator: break when we leave the prefix
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2017 at 11:22 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> From: Jeff King <peff@peff.net>
>
> If the underlying iterator is ordered, then `prefix_ref_iterator` can
> stop as soon as it sees a refname that comes after the prefix. This
> will rarely make a big difference now, because `ref_cache_iterator`
> only iterates over the directory containing the prefix (and usually
> the prefix will span a whole directory anyway). But if *hint, hint* a
> future reference backend doesn't itself know where to stop the
> iteration, then this optimization will be a big win.
>
> Note that there is no guarantee that the underlying iterator doesn't
> include output preceding the prefix, so we have to skip over any
> unwanted references before we get to the ones that we want.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/iterator.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/refs/iterator.c b/refs/iterator.c
> index c475360f0a..bd35da4e62 100644
> --- a/refs/iterator.c
> +++ b/refs/iterator.c
> @@ -287,6 +287,20 @@ struct prefix_ref_iterator {
>         int trim;
>  };
>
> +/* Return -1, 0, 1 if refname is before, inside, or after the prefix. */
> +static int compare_prefix(const char *refname, const char *prefix)
> +{
> +       while (*prefix) {
> +               if (*refname != *prefix)
> +                       return ((unsigned char)*refname < (unsigned char)*prefix) ? -1 : +1;

This looks interesting.

We get a signed char* , cast it to unsigned char* and then
compare byte by byte.

The cast lead me to think that this should work for non-ASCII
(e.g. ANSI?), but given that there are multi-byte characters (e.g.
UTF-8) depending on your encoding used, we may not assume
that in the given encoding the characters order by their byte order?

But this compare function is not to order by the natural encoding order,
but it's used to detect the '0' at the end of prefix, which orders
before *any* unsigned char.

We cannot enhance starts_with for this case as we'd have to invert
the return value to differentiate between the prefix ordering before
or after the given string.

Essentially compare_prefix wants to provide the same return
value as `strncmp(refname, prefix, min(strlen(refname), strlen(prefix)));`
except that it is optimized as we do not have to walk over a string
multiple times (to determine length and then pass it to compare).

Feel free to ignore the rambling, I just had to sort my thoughts.
The patch looks good.

Thanks,
Stefan

> +
> +               refname++;
> +               prefix++;
> +       }
> +
> +       return 0;
> +}
> +
>  static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  {
>         struct prefix_ref_iterator *iter =
> @@ -294,9 +308,25 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
>         int ok;
>
>         while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
> -               if (!starts_with(iter->iter0->refname, iter->prefix))
> +               int cmp = compare_prefix(iter->iter0->refname, iter->prefix);
> +
> +               if (cmp < 0)
>                         continue;
>
> +               if (cmp > 0) {
> +                       /*
> +                        * If the source iterator is ordered, then we
> +                        * can stop the iteration as soon as we see a
> +                        * refname that comes after the prefix:
> +                        */
> +                       if (iter->iter0->ordered) {
> +                               ok = ref_iterator_abort(iter->iter0);
> +                               break;
> +                       } else {
> +                               continue;
> +                       }
> +               }
> +
>                 if (iter->trim) {
>                         /*
>                          * It is nonsense to trim off characters that
> --
> 2.14.1
>
