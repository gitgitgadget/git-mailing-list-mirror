Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46081FC43
	for <e@80x24.org>; Sun, 12 Mar 2017 09:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933848AbdCLJP6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 05:15:58 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36200 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933837AbdCLJPz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 05:15:55 -0400
Received: by mail-io0-f195.google.com with SMTP id 68so10791454ioh.3
        for <git@vger.kernel.org>; Sun, 12 Mar 2017 01:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yBY5+jO/oXa4BMz7yy5QbMjMrye8aSXPBEXKO1MXM1M=;
        b=NJ7z3Bi0+jHXPzvGXzWrz7OTA9sJ4wRRURokCEJLypXJseOd5wxL3xKtltPSNOS2a1
         sWn6sN3wTAirGe28nJLWroRhALF5jxjcycji3AvxYPUozmjMCr14api+QQIoNTIUW16u
         FnNp1VLuirWjgM8jmCt59Nfx8NDYBqnrc0GEPQaZypAypvrSdVLU8Wii/dPb5cp0RL+Z
         5Pa7uqcS60Te8zMLgE7z6hjIJllmn5kU7xPYHYo9m8CxEU4IQVbCjjF6nMdde8+rvPKZ
         uV3nY1FAsQmSox+9D1ws5pILG2iqf5e/OtkN+JcRdu8jE0SIFEIZ/rufPrfpGlIA3Erw
         OwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yBY5+jO/oXa4BMz7yy5QbMjMrye8aSXPBEXKO1MXM1M=;
        b=mCRKxsyRdj4CbwTlYGasyJci9ZiC9nRAEqsQjpFFTxMcLrwiV2a/gFWP54qS05/pdn
         K+x0EbjB1itib2MqrpeUPpxbks/14MTCmL1QOAt7BSx1tZZM+48mEM8YFEYk8K76m5og
         G/MBt2SNm3R3bmCQMCfFo3z3PqHwLNchIu1M7v1rrjCapI4m31gz6+88njLjhGph3zdY
         0/Vt9zM535nX+ZJhxw/0PZk2zFi8VpCyzaOesQzpG9c3mIXnpml9g5BWw2ZyF82RkCDA
         SI11nkQceYN55Aycs5C5Kphn0QX+1B7l72y1/mtYyzuXVdLPHMWUwBOaWAp54sOwC9yf
         WrRA==
X-Gm-Message-State: AMke39kYdM82tZjaPHjr6liQROt082wBx5YCZiTc2Le58A32oKw7uR//3uXDwiKTyXRdNxGLMz3L9Sk00NuDHg==
X-Received: by 10.107.200.139 with SMTP id y133mr25428046iof.147.1489310154340;
 Sun, 12 Mar 2017 01:15:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sun, 12 Mar 2017 01:15:33 -0800 (PST)
In-Reply-To: <xmqq4lyzw5az.fsf@gitster.mtv.corp.google.com>
References: <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net>
 <20170311120855.16756-1-avarab@gmail.com> <xmqq4lyzw5az.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 12 Mar 2017 10:15:33 +0100
Message-ID: <CACBZZX6pvjn8_BGhK8+3LyJpVWSjE9utvHuYzGLC5YZeDj5ykg@mail.gmail.com>
Subject: Re: [PATCH] tag: Implicitly supply --list given another list-like option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jake Goulding <goulding@vivisimo.com>,
        Jeff King <peff@peff.net>, Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 12, 2017 at 4:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change these invocations which currently error out without the -l, to
>> behave as if though -l was provided:
>>
>>     git tag -l [--contains|--points-at|--[no-]merged] <commit>
>
> Shouldn't this be
>
>         git tag -l [[--[no-]contains|--points-at|--[no-]merged] <commit>]=
 [<pattern>]
>
> i.e. if you are giving <commit> you need how that commit is used in
> filtering, but you do not have to give any such filter when listing,
> and <pattern>, when given, is used to further limit the output, but
> it also is optional.
>
>> Subject: Re: [PATCH] tag: Implicitly supply --list given another list-li=
ke option
>
> s/Implicit/implicit/ (ask "git shortlog --no-merges" over recent history)
>
>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> index 525737a5d8..c80d9e11ba 100644
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -94,6 +94,9 @@ OPTIONS
>>       lists all tags. The pattern is a shell wildcard (i.e., matched
>>       using fnmatch(3)).  Multiple patterns may be given; if any of
>>       them matches, the tag is shown.
>> ++
>> +We supply this option implicitly if any other list-like option is
>> +provided. E.g. `--contains`, `--points-at` etc.
>
> Who are "we"?
>
>         When any option that only makes sense in the list mode
>         (e.g. `--contains`) is given, the command defaults to
>         the `--list` mode.
>
> By the way, do we catch it as a command line error when options like
> `--points-at` are given when we are creating a new tag?
>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index ad29be6923..6ab65bcf6b 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -454,6 +454,12 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>>       }
>>       create_tag_object =3D (opt.sign || annotate || msg.given || msgfil=
e);
>>
>> +     /* We implicitly supply --list with --contains, --points-at,
>> +        --merged and --no-merged, just like git-branch */
>
>         /*
>          * We write multi-line comments like this,
>          * without anything other than slash-asterisk or
>          * asterisk-slash on the first and last lines.
>          */
>
>> +     if (filter.with_commit || filter.points_at.nr || filter.merge_comm=
it)
>> +             cmdmode =3D 'l';
>
> Don't we want to make sure we do the defaulting only upon !cmdmode?
> Doesn't this start ignoring
>
>         tag -a -m foo --points-at HEAD bar
>
> as an error otherwise?
>
>> +     /* Just plain "git tag" is like "git tag --list" */
>>       if (argc =3D=3D 0 && !cmdmode)
>>               cmdmode =3D 'l';
>
>> @@ -486,12 +492,6 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>>       }
>>       if (filter.lines !=3D -1)
>>               die(_("-n option is only allowed with -l."));
>> -     if (filter.with_commit)
>> -             die(_("--contains option is only allowed with -l."));
>> -     if (filter.points_at.nr)
>> -             die(_("--points-at option is only allowed with -l."));
>> -     if (filter.merge_commit)
>> -             die(_("--merged and --no-merged option are only allowed wi=
th -l"));
>
> And I do not think removal of these check is a good idea at all.
> Perhaps you were too focused on '-l' that you forgot that people may
> be giving an explicit option like -a or -s, in which case these
> error checks are still very sensible things to have, no?

I'll fix this up and make sure to do more sanity checks with the
different option combinations before resending.
