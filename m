Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434271F51C
	for <e@80x24.org>; Sun, 20 May 2018 15:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeETPxa (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 11:53:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32860 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbeETPx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 11:53:29 -0400
Received: by mail-oi0-f66.google.com with SMTP id k5-v6so11036255oiw.0
        for <git@vger.kernel.org>; Sun, 20 May 2018 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UM9YUIf2JWy0LZxNgwjw8e0CfY4e7cLXhXyEFalnvO0=;
        b=eYs7EQwxEwg19heFNluj/TumbFGMORYiTp247SUQfR2los5OMQtQM4dCjH67bOj5me
         IdAziWNQS9Aa3VI1oBPty1aLzPNKGfnXiZyOzvGeXevvK3RmwkOF+FDNy2WLkp/10HHD
         eSSoBTPrGdcsFboQ20aLpanCUF1XApjV+JkktUh8OYMtuhHN5THh2dyKEx9mrWIOd867
         CivoKSwZSMMkeV/gclmzwx/evq3GeJGmTUCLZT8gGvPrKma+htJ+cpc4Yx+aDGaGKrdf
         oIHkMDCJq+2MpTjnxI+eR/Bj8ASF8q/EI1QjBjvIj44VIILER4w6fJldO7SXxtU0qmM0
         Ecrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UM9YUIf2JWy0LZxNgwjw8e0CfY4e7cLXhXyEFalnvO0=;
        b=DSRj88+qyLcEenUa48p3cFuFRR3aAKNWogM3jJUGZmxKGOP3YHsoxyZEl7BOm94LEp
         X+GF1gizPGgWp/mgfO0Ydu8VYW4V6lkmh+JYwD3k2F/YcKEwkPrymdAXMFhVHhsJgDV/
         rQgoty3bApXAuRbiioaIZDSlGGc8WZZkRXWyWhtzKh+KM1l5bM+LyOoSog+PxVhoq8ME
         0t3JwpK/JB7huXJ5hLKumTy34o8xji2Vf4vvOgKErWIRWZab+oeqqxeLlRjkDA8kJu4y
         KXXUZTcNuGOsDCI2srZQYeVQpZ43mII4nlacn87BtBnfpgoSL0LPxNda8EbNoHzoccEE
         zrFg==
X-Gm-Message-State: ALKqPwelw+9x7zqa4KlSRKX+KauDkGMazxu9HEcTSkgpGiWEfU5Gyj5J
        CDJ96ojgfL3e9uPYQmKRUClJINHvhCV42S3Dyjk=
X-Google-Smtp-Source: AB8JxZoJ4SYwWZOgjQOtg9GU7EuaqtG6KGf/X8l7UwJU41dJo5kieOKrXGavrDabcR1PfHp9YUa8CIRi8h1rgma0gA0=
X-Received: by 2002:aca:2813:: with SMTP id 19-v6mr10330242oix.281.1526831608689;
 Sun, 20 May 2018 08:53:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sun, 20 May 2018 08:52:58 -0700 (PDT)
In-Reply-To: <CAM0VKjn1WyRgGZDidPjr3YatRV65h_sSzQQpg+=OUtiaTxMgpw@mail.gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com> <20180519042752.8666-15-pclouds@gmail.com>
 <CAM0VKjn1WyRgGZDidPjr3YatRV65h_sSzQQpg+=OUtiaTxMgpw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 20 May 2018 17:52:58 +0200
Message-ID: <CACsJy8B29o0ZJoecrdsiVpma3iudwUCyyD_-yCe_3ePad1WKKQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] completion: allow to customize the completable
 command list
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 20, 2018 at 4:27 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Sat, May 19, 2018 at 6:27 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> By default we show porcelain, external commands and a couple others
>> that are also popular. If you are not happy with this list, you can
>> now customize it. See the big comment block for details.
>>
>> PS. perhaps I should make aliases a group too, which makes it possible
>> to _not_ complete aliases by omitting this special group in
>> $GIT_COMPLETION_CMD_GROUPS
>
> Note that the completion script reads the configured aliases each time
> the user attempts to complete commands.  So if the user adds or
> removes an alias, then it will automatically be taken into account the
> next time after 'git <TAB>'.  By turning aliases into a group listed
> by 'git help' they would be cached like all other commands, so this
> would no longer be the case.

Maybe we can stop caching "git --list-cmds=3D..." then. We achieve the
same effect for completion.commands (changes take effect immediately)
and don't add any more overhead (still one git call per completion)?
This can also avoid the per-repository limitation below.

>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  Documentation/config.txt               | 10 ++++++++
>>  contrib/completion/git-completion.bash | 28 +++++++++++++++++++++-
>>  git.c                                  |  2 ++
>>  help.c                                 | 33 ++++++++++++++++++++++++++
>>  help.h                                 |  1 +
>>  5 files changed, 73 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 2659153cb3..91f7eaed7b 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1343,6 +1343,16 @@ credential.<url>.*::
>>  credentialCache.ignoreSIGHUP::
>>         Tell git-credential-cache--daemon to ignore SIGHUP, instead of q=
uitting.
>>
>> +completion.commands::
>> +       This is only used by git-completion.bash to add or remove
>> +       commands from the complete list. Normally only porcelain
>
> s/complete list/list of completed commands/ perhaps?
>
>> +       commands and a few select others are in the complete list. You
>
> s/in the complete list/completed/
>
>> +       can add more commands, separated by space, in this
>> +       variable. Prefixing the command with '-' will remove it from
>> +       the existing list.
>> ++
>> +This variable should not be per-repository.
>
> I think this should also mention that changing the value of this
> config variable will not immediately affect the commands listed after
> 'git <TAB>', but the user will have to re-dot-source the completion
> script first.
>
> The way I understand the rest of the patch, this config variable
> doesn't have any effect if $GIT_COMPLETION_CMD_GROUPS doesn't contain
> "config".  If that is indeed the case, then that should be mentioned
> here as well.
>
> Having said that, I wonder whether we should really require "config"
> in $GIT_COMPLETION_CMD_GROUPS.  Isn't having 'completion.commands' set
> in the config a clear enough indication in itself that the user wants
> to customize the listed commands?

$GIT_COMPLETION_CMD_GROUPS is for really specific customization. I
initially added it because "config" was not default, and because
completion.commands could not exclude commands, only include them. Now
that is possible, perhaps just completion.commands (no
$GIT_COMPLETINO_CMD_GROUPS) would suffice for most cases?

>
>> +
>>  include::diff-config.txt[]
>>
>>  difftool.<tool>.path::
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion=
/git-completion.bash
>> index cd1d8e553f..f237eb0ff4 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -38,6 +38,29 @@
>>  #
>>  #     When set to "1", do not include "DWIM" suggestions in git-checkou=
t
>>  #     completion (e.g., completing "foo" when "origin/foo" exists).
>> +#
>> +#   GIT_COMPLETION_CMD_GROUPS
>> +#
>> +#     When set, "git --list-cmds=3D$GIT_COMPLETION_CMD_GROUPS" will be
>> +#     used to get the list of completable commands. The default is
>> +#     "mainporcelain,others,list-complete" (in English: all porcelain
>
> Mental note #1: "mainporcelain"
>
>> +#     commands and external ones are included. Certain non-porcelain
>> +#     commands are also marked for completion in command-list.txt).
>> +#     You could for example complete all commands with
>> +#
>> +#         GIT_COMPLETION_CMD_GROUPS=3Dmain,others
>
> Mental note #2: "main"
>
>> +#
>> +#     Or you could go with main porcelain only and extra commands in
>> +#     the configuration variable completion.commands with
>> +#
>> +#         GIT_COMPLETION_CMD_GROUPS=3Dmainporcelain,config
>> +#
>> +#     Or go completely custom group with
>> +#
>> +#         GIT_COMPLETION_CMD_GROUPS=3Dconfig
>> +#
>> +#     Or you could even play with other command categories found in
>> +#     command-list.txt.
>>
>>  case "$COMP_WORDBREAKS" in
>>  *:*) : great ;;
>> @@ -842,8 +865,11 @@ __git_commands () {
>>                 if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
>>                 then
>>                         printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST=
"
>> +               elif test -n "$GIT_COMPLETION_CMD_GROUPS"
>> +               then
>> +                       git --list-cmds=3D"$GIT_COMPLETION_CMD_GROUPS"
>>                 else
>> -                       git --list-cmds=3Dlist-mainporcelain,others,list=
-complete
>> +                       git --list-cmds=3Dlist-mainporcelain,others,list=
-complete,config
>
> So first it was "mainporcelain", then simply "main", then
> "mainporcelain" again, and now "list-mainporcelain"?!
> You've lost me here.
>
> Are the possible values documented anywhere?

In the code :) I did not document it because it was hidden option and
it may change again. list-XXX corresponds to the XXX tag in
command-list.txt while the no "list-" like "main", "config", or
"others" provide the command list from other sources (e.g. libexec for
"main", $PATH for "ohers", completion.commands for "config")

> Furthermore, the default value mentioned in the comments above didn't
> include "config", either (but then again, I don't think we really need
> "config" in the first place).

Yeah that comment block was out of date. I think including "config" by
default gives a smoother experience. You just update
completion.commands and ready, you don't need to export
$GITC_COMPLETION_CMD_GROUPS before sourcing git-completion.bash
(which, depends on distro, may be done automatically and hard to
intervene except modifying the script itself).
--=20
Duy
