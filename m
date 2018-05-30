Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCEC1F42D
	for <e@80x24.org>; Wed, 30 May 2018 22:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbeE3Wc5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 18:32:57 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:32775 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932393AbeE3Wc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 18:32:56 -0400
Received: by mail-yw0-f196.google.com with SMTP id u124-v6so5406740ywg.0
        for <git@vger.kernel.org>; Wed, 30 May 2018 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sMt4k2w9iCdYl0hIheORtPqQhGs/vCqaAq63m6C3zo8=;
        b=D788CEky2ywyAhrdgegaDL8yPT/t4VT0aGCZx/Ph5U+w1IHp+W3ZDOjtRQNk9kIo7N
         u+jlVQcdaxSu0yoFTBBPHwnz8TdeeonOEBgfuiCkz4DEwsGDdvqnDkofM+5kZ0sqMfSl
         dJQ5oxfLtkMWibdADPltqza19hJwzqnggLmVM/gDRwZiVzKE+vA+9mmAlU4wvGNWKW/3
         1ZHyNWd6pH3rHbrPi2qABVblW2UEz1lVMI4ccbQKdITYEGbICkOH0vSbH2BaWjJmGWF6
         ONQ5ZlU4UpXlTtm8wGljOUceaRNXLWeEYB4AN9tMOC4ACkV4NspKIw2lDYHNSxY5py64
         dw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sMt4k2w9iCdYl0hIheORtPqQhGs/vCqaAq63m6C3zo8=;
        b=uAoY670kLxVQWW5sqTTX+HbWEcOV8/6PRwWghc0H4GAqwm7zItNhIRGfP2IzfJbIFW
         IK5E49uEsqohPrqW1ccpzEnaChjsM449MAwl6ZkdG8X7Cq9C2ulDJpwTV0Ja6SoxR7Mr
         0HRbu9BZ1Yt7EgdhRcMrqmCrb4LwiInBWUiEAHsB3UEYGEwdELIUs3uMulg992PUiK6o
         mZElPms9nmV2YRvOuwxIt4JAc+nMVS8Y4+gzGZByRZhyZOKcJQ0Zy/jClO7iwa6oqvGI
         MBXU6P2M9zxvbK2MK9tjp+foJCzg/mavnff4++JdGiRTskZtGJIfUz+dPTL2MsbSoWt6
         ++6g==
X-Gm-Message-State: ALKqPweO77fTwIOUbL0bcoP2rRa0EzMN942lfzagJndflqwo3WWf1GoI
        /HDoGz8hxVZSBEP3NuaPgJVWysHm+fs+WNrxrMYt4Q==
X-Google-Smtp-Source: ADUXVKLHRZGzFkTDvxrqd6fou4Y1f/2GTN5cWmsWmRTuZYgb2naJmUhLUOkSrfpeyPpuCsR8UZQeLsoq5PctF94f56s=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr2458240ywg.345.1527719575454;
 Wed, 30 May 2018 15:32:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Wed, 30 May 2018 15:32:54 -0700 (PDT)
In-Reply-To: <20180530210641.19771-4-avarab@gmail.com>
References: <20180530210641.19771-1-avarab@gmail.com> <20180530210641.19771-4-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 May 2018 15:32:54 -0700
Message-ID: <CAGZ79kZVq1szZ=nPQ87nv1Hrg+yCrQbbkzfuNg1itfEGrBR03w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] color.ui config: don't die on unknown values
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 2:06 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Before this change git will die on any unknown color.ui values:
>
>     $ git -c color.ui=3Ddoesnotexist show
>     fatal: bad numeric config value 'doesnotexist' for 'color.ui': invali=
d unit
>
> This makes the failure mode of introducing any new values in the
> future really bad, as explained in the documentation being added
> here. Instead let's warn and fall back to "auto".

We had a similar regression in the protocol.version setting in 2.16 IIRC.
It makes sense to fix it this way.

> The reason for the !warned++ pattern is when stepping through this in
> the debugger I found that git_config_colorbool() is called more than
> once on e.g. a "show" if color.ui=3Dfoo is set in the config, but
> color.ui=3Dbar in the command-line, and would then warn about
> both.
>
> Maybe we should warn about both in that case, but I don't know if
> there's other cases where not doing this would cause a warning flood,
> and in any case the user is unlikely to have such a bad value in
> multiple places, so this should be good enough.

agreed.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/config.txt |  5 +++++
>  color.c                  | 13 +++++++++++++
>  t/t7006-pager.sh         | 16 ++++++++++++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4767363519..b882a88214 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1291,6 +1291,11 @@ color.ui::
>         want such output to use color when written to the terminal (as
>         determined by a call to `isatty(3)`) or to a pager (unless
>         `color.pager` is set to false).
> ++
> +Setting this to some value unknown to git will warn and fall back to
> +`auto`. This is so that new values can be recognized in the future
> +without the git configuration file being incompatible between versions
> +to the point of most porcelain commands dying on the older version.
>
>  column.ui::
>         Specify whether supported commands should output in columns.
> diff --git a/color.c b/color.c
> index b1c24c69de..e52c6cdd29 100644
> --- a/color.c
> +++ b/color.c
> @@ -311,6 +311,19 @@ int git_config_colorbool(const char *var, const char=
 *value)
>         if (!var)
>                 return -1;
>
> +       /*
> +        * If future git versions introduce new color.ui settings we
> +        * don't want to die right below when git_config_bool() fails
> +        * to parse them as bool.
> +        */

I am not sure we need to document this here. Ignoring unknown
(or warning about unknown) values is the standard for config keys
at least, for values we probably want a similar thing.

> +       if (git_parse_maybe_bool(value) < 0) {
> +               static int warned =3D 0;

As someone who moved a lot of global state into the repository object
this is a fine example where we do not want to have the counter not
in the repository? (although strictly speaking you'd want to have the
warning approximately once per repository that is configured wrongly
or do you want to have this warning once at all?)

I think we should take patches 1-3 at least.

Thanks,
Stefan
