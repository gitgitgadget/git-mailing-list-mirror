Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2DFC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B3461078
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFGL1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:27:23 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:46815 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFGL1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 07:27:23 -0400
Received: by mail-pf1-f179.google.com with SMTP id u126so8853379pfu.13
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WHF36IXxm8wMM1irgbfNdLu5JTEihHRhBMcXDGwiAVI=;
        b=OGzFP9N5bEhooSLebhPwVz30ZHvi6aut9pC/hAUFN4/q1CoYekLA5iXfx4B6gAfjcy
         n0YeVspmhTWwEIOrxj2fDf9Sqrl0JkOvwCJurD9NvpdkzbNISU7hoVjfKeu0btZW0a0P
         lVQT69RSU571x0o+mqSOCdKsrE7W8dt/fNQqjPZxJlBvDXQy9RsNIqCDYx1pvyRz/ePG
         P/iQD/bSXO2Tf0seZKb6TUY2OFLM01jm1xgqkP7ABhr5oYOvVbZRFS5NjT75sbXvZrst
         qPPuvrUZzjiea3FjrZKJb0klCCHRdAJ6GWgwUOWe5w6EJuli3gVP1CTaFzfuJH7kJp2f
         w2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WHF36IXxm8wMM1irgbfNdLu5JTEihHRhBMcXDGwiAVI=;
        b=mJW6pwrg39g5WC9RM8tLbAhxoMlw2pvClamlg96IiCjCEe9DCzdKiYL9jCvHiysG0e
         SMaNoqf50aYaUyOME9xgMA5pnj0pCBocgsZAGn7/UaMfU3OkQZuZRN5e4d643lv4nqJA
         vfpZZiK+gZ9K/QbHzL39zCo5UiQkCvUjh8ECtP5WUbTxd8FRtSDiAOE4hFk0ruZ7Eaag
         LOe6iZEbz2gkGdPGiAKaiPfg+h1Af5/TgA6Cgy6GtsxH/PAuA5N95kZ9JXuo30ZqBN/4
         cyMotrDyiDAQqW8GEXdFee263WrU/LdLZddzA5BUdTAbrBSLbH0JMTeLmkmtkWIzLSpT
         KB1w==
X-Gm-Message-State: AOAM532IWAzx/4YmIxkOe9Syydan29rKJwnXiMqpd9uCGs5GBBRScE+X
        9adPfIbi7e2yk0O0tvF6x2g=
X-Google-Smtp-Source: ABdhPJwanxIYVdyMupDDWn/SD+5gE0bspYp1rrnNb6FgIozs6QWq4mYxbCzfBTBSH2zlUn38xuCEAQ==
X-Received: by 2002:a63:7204:: with SMTP id n4mr17656664pgc.78.1623065071889;
        Mon, 07 Jun 2021 04:24:31 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id ft16sm6383900pjb.28.2021.06.07.04.24.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jun 2021 04:24:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] [PATCH 2/2] submodule--helper: introduce add-config
 subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAP8UFD2kwSB60kF_cjs4JYSYeXzvjAtz0OuFOfTqEU7F+ijR-w@mail.gmail.com>
Date:   Mon, 7 Jun 2021 16:54:27 +0530
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <441792CB-259C-4635-8B00-9511E8D1FC3C@gmail.com>
References: <20210605113913.29005-1-raykar.ath@gmail.com>
 <20210605113913.29005-3-raykar.ath@gmail.com>
 <CAP8UFD2kwSB60kF_cjs4JYSYeXzvjAtz0OuFOfTqEU7F+ijR-w@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07-Jun-2021, at 14:54, Christian Couder <christian.couder@gmail.com> =
wrote:
>=20
> On Sat, Jun 5, 2021 at 1:42 PM Atharva Raykar <raykar.ath@gmail.com> =
wrote:
>>=20
>> Add a new "add-config" subcommand to `git submodule--helper` with the
>> goal of converting part of the shell code in git-submodule.sh related =
to
>> `git submodule add` into C code. This new subcommand sets the
>> configuration variables of a newly added submodule, by registering =
the
>> url in local git config, as well as the submodule name and path in =
the
>> .gitmodules file. It also sets 'submodule.<name>.active' to "true" if
>> the submodule path has not already been covered by any pathspec
>> specified in 'submodule.active'.
>>=20
>> This is meant to be a faithful conversion from shell to C, with only =
one
>> minor change: A warning is emitted if no value is specified in
>> 'submodule.active', ie, the config looks like: "[submodule] =
active\n".
>=20
> Maybe explaining a bit how this warning is useful could help reviewers
> here. Especially what could happen if no value is specified in
> 'submodule.active'?

Will do.

For now I'll leave an explanation here as well, so that those
who might see this thread can know the motivation behind it.

(I'll make it more concise in my cover letter of v2)

Junio in his review of Shourya's patch[1] said:
> When a user has "[submodule] active" in his or her
> configuration file, it is a configuration error.  When Git reads
> "submodule.active" configuration variable to make a decision (like
> the above code) and finds that the user has such an error, the user
> would appreciate if the error is pointed out, so that it can be
> corrected, rather than silently ignored.

Git might set 'submodule.<name>.active =3D true' in the above case, and
since it has a higher priority[2] than the 'submodule.active' switch,
it would be useful to let the user know of this change, and the =
incorrect
configuration that led to this behaviour, so that they may be able to
remedy it, and avoid surprises later on.

[1] https://lore.kernel.org/git/xmqqo8isxefz.fsf@gitster.c.googlers.com/
[2] https://git-scm.com/docs/gitsubmodules#_active_submodules

>> The structure of the conditional to check if we need to set the =
'active'
>> toggle looks different from the shell version -- but behaves the =
same.
>> The change was made to decrease code duplication. A comment has been
>> added to explain that only one value of 'submodule.active' is =
obtained
>> to check if we need to call is_submodule_active() at all.
>>=20
>> This is part of a series of changes that will result in all of
>> 'submodule add' being converted to C.
>=20
> [...]
>=20
>=20
>> +       /*
>> +        * NEEDSWORK: In a multi-working-tree world this needs to be
>> +        * set in the per-worktree config.
>> +        */
>> +       pathspec_key_exists =3D =
!git_config_get_string("submodule.active",
>> +                                                    =
&submod_pathspec);
>> +       if (pathspec_key_exists && !submod_pathspec)
>> +               warning(_("The submodule.active configuration exists, =
but "
>> +                         "no pathspec was specified. Setting the =
value of "
>> +                         "submodule.%s.active to 'true'."), =
add_data->sm_name);
>=20
> It's not very clear that we will actually set
> 'submodule.<name>.active' to true below as it depends on the result of
> calling is_submodule_active()

Hmm, I see the issue.

Would it be more accurate to say this:

"The submodule.active configuration exists, but no pathspec
was specified. If the module is not already active, the value
of 'submodule.<name>.active' will be set to 'true'."

> , and anyway is_submodule_active() will
> check again if "submodule.active" is set, which is wasteful.
>=20
> Maybe we could set a variable, called for example "activate" here,
> with something like:
>=20
>       if (pathspec_key_exists && !submod_pathspec) {
>               warning(...);
>               activate =3D 1;
>      }
>=20
> and below use a check like:
>=20
>       if (!pathspec_key_exists || activate ||
>           !is_submodule_active(the_repository, add_data->sm_path)) {

Got it. Thanks for suggesting this improvement!

> ...
>=20
>> +       /*
>> +        * If submodule.active does not exist, we will activate this
>> +        * module unconditionally.
>> +        *
>> +        * Otherwise, we ask is_submodule_active(), which iterates
>> +        * through all the values of 'submodule.active' to determine
>> +        * if this module is already active.
>> +        */
>> +       if (!pathspec_key_exists ||
>> +           !is_submodule_active(the_repository, add_data->sm_path)) =
{
>> +               key =3D xstrfmt("submodule.%s.active", =
add_data->sm_name);
>> +               git_config_set_gently(key, "true");
>> +               free(key);
>> +       }
>> +}
>=20
> The rest looks good to me! Thanks!

:^)=
