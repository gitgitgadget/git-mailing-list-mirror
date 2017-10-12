Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E3B20467
	for <e@80x24.org>; Thu, 12 Oct 2017 16:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbdJLQvf (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 12:51:35 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:49969 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbdJLQve (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 12:51:34 -0400
Received: by mail-qt0-f172.google.com with SMTP id k31so14786262qta.6
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6ua9N0+g6TxYolIWFxHw4VdnYbM+JoNT6815Ow49Vy8=;
        b=dVJkIxkYJUO8TDdhUVqUVtPe/YCmfNPQE6DAAG5enT8v2UEk/483gHl8PSe8w8Fmoi
         +tB3jIom0dZbOdmXhoI42ipEG9bhzBYEl3OvFgu67/Idsdq2TLrksfIm9GbpP/DqMZWH
         JjifrT2F3sVCyyrBoJjyQVvZClXtUHDAuWbYJjJgZEHbkOUnnCmG29SJuYyN5SB+m8Fb
         nQhUCsVrK4zvD8pp2G3i6XUOsRR6UzROIW2ikkLsPdZ4Fel+eKzcmOrGoyw2hG1WzVw4
         nkKgjySaNZ4MBf/YjLrKYeyC0Ko5Y40HzjWSLF63nIhykMdlpRoZina340LX2sfRrPoD
         qKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6ua9N0+g6TxYolIWFxHw4VdnYbM+JoNT6815Ow49Vy8=;
        b=eSq+18C59afkeDW9q/ydRkOahpreQXwKjMQsRhDQk/xDjdi+yLmRdJirDoTcghXXm5
         YHpBah1pfLt6RB/2lGPdQcL5wCTYX+c9yyXko+xfKlEnCFRXlJvFsQY1V2jUp0jizVlD
         8Tpqb/23pnEwT7UE4awErekm8WjQ0dnfPpAs412pb/3odH+pdTf3vmeN498ofUS1QLHg
         PWbFx+UiC5Lii9ki+O2XXpPfHF1Gah9+PcXcHhRKXTDmYMf9wqtQgz9HOyKlrbRVT/ce
         peeCcKV5zsSrwPFk5MwPPgY8fMWTSXijp6q1+NZstWy+xHd81+3YbWRcWp/aehtsqr/w
         2j/w==
X-Gm-Message-State: AMCzsaXo/pqoLJw/2WD7bvdwyG1+xeC4hklKB/totICh5Vx2yAuf0Wnb
        WLrbPic7yNH85k5by+MGlTlrEFGFJIoreemr5hoFlIiLXFM=
X-Google-Smtp-Source: AOwi7QCxFBzF+BjlWgXPHfsHPrpOAlLfUMrWcTvYQhBqtDyvPGZJ+yYL3SdMCWkpgiOlDVJjLJt89jKyQve+sd0PlsE=
X-Received: by 10.200.8.53 with SMTP id u50mr4787146qth.260.1507827094090;
 Thu, 12 Oct 2017 09:51:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Thu, 12 Oct 2017 09:51:33 -0700 (PDT)
In-Reply-To: <CAK7vU=0A_nf2bAgV6dQyiesLJ3HHs5guyfNSNTwzYzgS2+YeWg@mail.gmail.com>
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
 <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
 <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
 <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com>
 <xmqqh8v5ls8i.fsf@gitster.mtv.corp.google.com> <CAK7vU=0wbGsFCXmwmCc-XX9K07UF_OZ7tFa4_GVb-H7fxakssg@mail.gmail.com>
 <CAK7vU=0A_nf2bAgV6dQyiesLJ3HHs5guyfNSNTwzYzgS2+YeWg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 12 Oct 2017 09:51:33 -0700
Message-ID: <CAGZ79kZEQ9WeJdTu83PxC7KSfvQAE3aX4D0M-vRth8P5O2TrVA@mail.gmail.com>
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
To:     Marius Paliga <marius.paliga@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, thais.dinizbraz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 9:32 AM, Marius Paliga <marius.paliga@gmail.com> wrote:
> Subject: [PATCH] Added support for new configuration parameter push.pushOption
>
> builtin/push.c: add push.pushOption config
>
> Currently push options need to be given explicitly, via
> the command line as "git push --push-option".
>
> The UX of Git would be enhanced if push options could be
> configured instead of given each time on the command line.
>
> Add the config option push.pushOption, which is a multi
> string option, containing push options that are sent by default.
>
> When push options are set in the system wide config
> (/etc/gitconfig), they can be unset later in the more specific
> repository config by setting the string to the empty string.

Now that I review this patch, this is nice information and can
remain in the commit message, but it would be more useful
in the Documentation as that is where the users look.
(Another thing regarding the documentation: Maybe we want
to update Documentation/config.txt as well, that contains all
configuration)

> @@ -503,6 +505,14 @@ static int git_push_config(const char *k, const
> char *v, void *cb)
>          int val = git_config_bool(k, v) ?
>              RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
>          recurse_submodules = val;
> +    } else if (!strcmp(k, "push.pushoption")) {
> +        if (v == NULL)
> +            return config_error_nonbool(k);
> +        else
> +            if (v[0] == '\0')
> +                string_list_clear(&push_options, 0);

Junio,
do we have variables that behave similarly to this?

(I just wondered if the `v == NULL` could be lumped in
to here, resetting the string list)

>
> +test_expect_success 'default push option' '
...
> +'
> +
> +test_expect_success 'two default push options' '
...
> +'
> +
> +test_expect_success 'default and manual push options' '
...
> +'

Thanks for adding thorough tests!
Do we also need tests for the reset of the list?

Thanks,
Stefan
