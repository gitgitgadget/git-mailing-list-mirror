Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3722D202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 16:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbdJYQog (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 12:44:36 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:49006 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbdJYQof (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 12:44:35 -0400
Received: by mail-qk0-f182.google.com with SMTP id d67so832554qkg.5
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hqoK8cB4C3u3TzABQbykQyKrARJYRQol0eg26nD1IjM=;
        b=tx7+yg5N+DoWl31HiNOQ0q9xBJhZGjgKHfKywqcMwmmpqGww34ThMZ/W1jN9BCej8k
         2+QZQoLAOJ/Y2Hh3EkHummrxS54aAi3uCG4b4S/+hWQrL0ufn1B/yKbBByeloSf/HTQ7
         sBWLvyhI6UngOY8xZWKXP6AHDHFBrk4a3YEob6IDOV6yEWxhKuKLkvqx3iMDGdIy2K9J
         4ecXSnHdenP9KeXiPTP9YvZ5NvvWsF8b4ytQ0Qu9BRlLmZz6kQ7NTuahvwaF4g8OjlOm
         BZY/pjtejKb9LR3v7pnQCiPQX4MebgMI1CM/AmLJW0gruAv/UuLZGJsjdqdAU1DdoBVY
         /RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hqoK8cB4C3u3TzABQbykQyKrARJYRQol0eg26nD1IjM=;
        b=hu883DT33IOd+NZ9nSy2dA0LYxZOLKB4JsAscZeYpDkMwjkDIfge1nq/dfUyem2YxQ
         lYAc1gN0ovkujfxyFyF3GkwoOxH85/teSv2beURG3vu2V7PWhy5dlgrTFyur3MLWtFEB
         3+DKvAQX6a4xlYluboWK465FuRWIqdJiS8DBW4K5tmvRq9KOhEUK238Hx67JGp2q8fZZ
         7hAabcdhQI0/fm8Zkm3H3NxGt+hLfPSFlqVeIh+qT5R3bfqQ8aEbz5h1zOqeY0ve2DXH
         5xW8l5/D/sHd5wJKew1vCzKmMZ8UCWLt4qrRDkgRlBn+XHTI3ESvxU8AWnYKe6RsEmQL
         TYXA==
X-Gm-Message-State: AMCzsaWrYaksFrb2+nfl3e6PLXh3pPIdCi4C40quntp3X3C0UyPHt34L
        ZBo1Z732qE96NmNjiHXoZFHt6yc84swJgLoGXMCpKg==
X-Google-Smtp-Source: ABhQp+SnEDyvdeCmvooW7g2WG0lcqSUJu4g6agwITPAo6meR2lCSPObqpglzahXlQWV9LRwfs7m5dP4HmA217Qo5168=
X-Received: by 10.55.33.203 with SMTP id f72mr4033783qki.176.1508949874509;
 Wed, 25 Oct 2017 09:44:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.17.36 with HTTP; Wed, 25 Oct 2017 09:44:32 -0700 (PDT)
In-Reply-To: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
 <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
 <xmqq4lqoj8pe.fsf@gitster.mtv.corp.google.com> <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Oct 2017 09:44:32 -0700
Message-ID: <CAGZ79kbgjgOhQuK0-zF7oTvuM_gWKF25+uAf-hsHK2Xg4yshhA@mail.gmail.com>
Subject: Re: Consequences of CRLF in index?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 9:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Here is a lunch-time hack to add that option.  As you can see from
> the lack of docs, tests and a proper log message, I haven't played
> with it long enough to know how buggy it is, though.  I am not all
> that interested in polishing it to completion myself and prefer to
> leave it as #leftoverbits ;-)

Ok, nevertheless a review pointing out a couple things would be
useful for those who pick it up later, I assume.

> Also I didn't bother teaching this to Stefan's color-moved thing, as
> the line comparator it uses will hopefully be unified with the one I
> am touching in xdiff/ with this patch.

which will be rerolled shortly fixing just the parameter names as Eric
mentioned.

>  diff.c            |  5 ++++-
>  merge-recursive.c |  2 ++
>  xdiff/xdiff.h     |  3 ++-
>  xdiff/xutils.c    | 34 ++++++++++++++++++++++++++++++++--
>  4 files changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 6fd288420b..eeca0fd3b8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4202,7 +4202,8 @@ void diff_setup_done(struct diff_options *options)
>
>         if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
>             DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
> -           DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
> +           DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL) ||
> +           DIFF_XDL_TST(options, IGNORE_CR_AT_EOL))

This highlights another part of the flag macros, that could be made nicer.
All these flags combined are XDF_WHITESPACE_FLAGS, so this
if could be written without the macros as

  if (options->xdl_ops & XDF_WHITESPACE_FLAGS)

which we might want to hide in a macro

  DIFF_XDL_MASK_TST(options, mask)

or such?


>  #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
> -#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
> +#define XDF_IGNORE_CR_AT_EOL (1 << 5)
> +#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL | XDF_IGNORE_CR_AT_EOL)
>
>  #define XDF_PATIENCE_DIFF (1 << 5)

(1<<5) is taken twice now. Currently there is only one
unused free bit (but that was used once upon a time);
so we have to think how we revamp the flag system to
support more than 32 bits.

See also the answers to
https://public-inbox.org/git/20171024000931.14814-1-sbeller@google.com/
as that started this discussion already.

>  #define XDF_HISTOGRAM_DIFF (1 << 6)
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 04d7b32e4e..8720e272b9 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -156,6 +156,21 @@ int xdl_blankline(const char *line, long size, long flags)
>         return (i == size);
>  }
>
> +/*
> + * Have we eaten everything on the line, except for an optional
> + * CR at the very end?
> + */
> +static int ends_with_optional_cr(const char *l, long s, long i)
> +{
> +       if (s && l[s-1] == '\n')
> +               s--;

so first we cut off the '\n',

> +       if (s == i)
> +               return 1;

then we either have an ending without

> +       if (s == i + 1 && l[i] == '\r')
> +               return 1;

or with a '\r' before.

That seems correct after some thought; I might offer
another easier to understand (for me) solution,
which is
{
       /* cut of ending LF */
       if (s && l[s-1] == '\n')
               s--;
      /* do we only need to cut LF? */
      if (i == s)
        return 1;

       /* cut of ending CR */
       if (s && l[s-1] == '\r')
               s--;
      /* was this everything to cut? */
      return i == s
}

Though this seems even more complicated
after having it written down.

>          * Each flavor of ignoring needs different logic to skip whitespaces
>          * while we have both sides to compare.
> @@ -204,6 +220,14 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
>                         i1++;
>                         i2++;
>                 }
> +       } else if (flags & XDF_IGNORE_CR_AT_EOL) {
> +               /* Find the first difference and see how the line ends */
> +               while (i1 < s1 && i2 < s2 && l1[i1] == l2[i2]) {
> +                       i1++;
> +                       i2++;
> +               }
> +               return (ends_with_optional_cr(l1, s1, i1) &&
> +                       ends_with_optional_cr(l2, s2, i2));
>         }
>
>         /*
> @@ -230,9 +254,15 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
>                 char const *top, long flags) {
>         unsigned long ha = 5381;
>         char const *ptr = *data;
> +       int cr_at_eol_only = (flags & XDF_WHITESPACE_FLAGS) == XDF_IGNORE_CR_AT_EOL;
>
>         for (; ptr < top && *ptr != '\n'; ptr++) {
> -               if (XDL_ISSPACE(*ptr)) {
> +               if (cr_at_eol_only) {
> +                       if (*ptr == '\r' &&
> +                           (top <= ptr + 1 || ptr[1] == '\n'))
> +                               continue;
> +               }
> +               else if (XDL_ISSPACE(*ptr)) {
>                         const char *ptr2 = ptr;
>                         int at_eol;
>                         while (ptr + 1 < top && XDL_ISSPACE(ptr[1])
>
>
