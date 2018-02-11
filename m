Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4901F404
	for <e@80x24.org>; Sun, 11 Feb 2018 14:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbeBKOrw (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 09:47:52 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32799 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBKOrv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 09:47:51 -0500
Received: by mail-wr0-f196.google.com with SMTP id s5so12737738wra.0
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 06:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=e/mvf1nAFZHetAFGEfAk04ZKMKBcoj5hBr6Hr0u/YwE=;
        b=Qrnhi4m2iQRDD660H/DngicygekzDSmSTCL3d71DC+aUIo9RzWjEy2MXaN/UTgE+vE
         6YbjqXEfGEKLMqJIMrT6AjPXY2O2KAqz5stJJXJxQEmpAyGSQFBu9OkBmzaci10BZvsq
         XNtM/+xkrrDMjq+tNvXkoIOUbsU52a2Yo43PuttHWJ2+bqEMRoAoNcF8N5fSIVXxnhDo
         sshMl5NRSmwm8qjFC5Pj0CiTrTi3VtSbuOxByaNiIEAVJy3pshXR33h+GIcF+F5f+Xg4
         cIDsAi4+jDLJKVx5t8KP+Orp/1yIzSJGl9PqZKtOXt3uqRGtw3hiA6nO7zmfX2In5Qfz
         BXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=e/mvf1nAFZHetAFGEfAk04ZKMKBcoj5hBr6Hr0u/YwE=;
        b=ial1cSd2J2RoH89CY2fBcdTz0d/AD6bafh9NsYqLmiJKwICPHqgDgDGT4nthnIk2CZ
         t1xwFganU78eSlNPE83ZMu9ZXHO3v4gVB2ftf9tEIa1p9CkVx8Y+ofJHfYENCOs0lfdD
         q06xxdYJJoS9dyHp2E9k04MWQlv4QLLW9RU9cTBUfpjsFYA8kdnpqnoHiBAXQ1SoNimW
         6PQ+F+MX6WdaNNe8EBQz7+XdPm3rBs36gjd6Y6yhCDL6SyvenHi2+Bi7h95ot1EneQdJ
         61Q4vQOnI0aBrj86o+Zwu17sK2/sY721l5Xu6C6KCD4DTYZhgGHFMz7vFYas8s9tmwRD
         12tg==
X-Gm-Message-State: APf1xPBpKGLQi8GPEK/z4iznbmnZ9utoppffR38iellrB4ct7DGWdG9/
        V7fOBfGfMR0RaRUgQee9s26MLsxy
X-Google-Smtp-Source: AH8x225B8/to9U444BmPYBkp35JIQ5Jv8Xx/FIQ66+UkemB6G7RHxHA3NA87aHdw17vmY4Quv2fwwg==
X-Received: by 10.223.167.69 with SMTP id e5mr2970088wrd.131.1518360469904;
        Sun, 11 Feb 2018 06:47:49 -0800 (PST)
Received: from evledraar (static-2-73-24-46.ipcom.comunitel.net. [46.24.73.2])
        by smtp.gmail.com with ESMTPSA id m6sm4941636wmb.6.2018.02.11.06.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Feb 2018 06:47:49 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 42/42] git-completion.bash: add GIT_COMPLETION_OPTIONS=all config
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com> <20180209110221.27224-43-pclouds@gmail.com> <877ermmeia.fsf@evledraar.gmail.com> <20180210092945.GA6370@ash>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180210092945.GA6370@ash>
Date:   Sun, 11 Feb 2018 15:47:48 +0100
Message-ID: <874lmnk2gb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 10 2018, Duy Nguyen jotted:

> On Fri, Feb 09, 2018 at 03:19:57PM +0100, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Fri, Feb 09 2018, Nguyễn Thái Ngọc Duy jotted:
>>
>> > By default, some option names (mostly --force, scripting related or for
>> > internal use) are not completable for various reasons. When
>> > GIT_COMPLETION_OPTIONS is set to all, all options (except hidden ones)
>> > are completable.
>> >
>> > Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> > ---
>> >  contrib/completion/git-completion.bash |  6 +++++-
>> >  parse-options.c                        | 11 +++++++----
>> >  2 files changed, 12 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> > index 0ddf40063b..0cfa489a8e 100644
>> > --- a/contrib/completion/git-completion.bash
>> > +++ b/contrib/completion/git-completion.bash
>> > @@ -36,6 +36,10 @@
>> >  #
>> >  #     When set to "1", do not include "DWIM" suggestions in git-checkout
>> >  #     completion (e.g., completing "foo" when "origin/foo" exists).
>> > +#
>> > +#   GIT_COMPLETION_OPTIONS
>> > +#
>> > +#     When set to "all", complete all possible options
>>
>> I was going to suggest some wording like:
>>
>>     When set to "all", include options considered unsafe such as --force
>>     in the completion.
>>
>> However per your cover letter it's not just used for that:
>>
>>      10 --force
>>       4 --rerere-autoupdate
>>       1 --unsafe-paths
>>       1 --thin
>>       1 --overwrite-ignore
>>       1 --open-files-in-pager
>>       1 --null
>>       1 --ext-grep
>>       1 --exit-code
>>       1 --auto
>>
>> I wonder if we shouldn't just make this only about --force, I don't see
>> why "git grep --o<TAB>" should only show --or but not
>> --open-files-in-pager, and e.g. "git grep --<TAB>" is already verbose so
>> we're not saving much by excluding those.
>>
>> Then this could just become:
>>
>>     GIT_COMPLETION_SHOWUNSAFEOPTIONS=1
>>
>> Or other similar boolean variable, for consistency with all the "*SHOW*
>> variables already in git-completion.bash.
>
> No. You're asking for a second default. I'm not adding plenty of
> GIT_COMPLETION_* variables for that. You either have all options, or
> you convince people that --force should be part of the current
> default.

No sorry, I mean that IMO the current patch you have could be simplified
where instead of saying "=all" there's just another variable that only
hides "dangerous" options, i.e. only "--force" (unless I've missed
another supposedly dangerous one).

But as previously discussed I think it just makes sense to stop doing
this conditionally and include --force too, the only stuff we should
hide is stuff like rebase --continue when not in an interactive rebase.

> Or you could push for a generic mechanism that allows you to customize
> your own default. Something like the below patch could give you what
> you want with:
>
>     GIT_COMPLETION_OPTIONS=all
>     GIT_COMPLETION_EXCLUDES=--open-files-in-pager # and some more
>     . /path/to/git-completion.bash
>
> I'm not going to make a real patch for this since people may want to
> ignore --foo in one command and complete --foo in others... I'm just
> not interested in trying to cover all cases.
>
> -- 8< --
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0cfa489a8e..9ca0d80cd7 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -40,6 +40,10 @@
>  #   GIT_COMPLETION_OPTIONS
>  #
>  #     When set to "all", complete all possible options
> +#
> +#   GIT_COMPLETION_EXCLUDES
> +#
> +#     Exclude some options from the complete list
>
>  case "$COMP_WORDBREAKS" in
>  *:*) : great ;;
> @@ -298,7 +302,7 @@ __gitcomp_builtin ()
>  	# commands, e.g. "git remote add" becomes remote_add.
>  	local cmd="$1"
>  	local incl="$2"
> -	local excl="$3"
> +	local excl="$3 $GIT_COMPLETION_EXCLUDES"
>
>  	local var=__gitcomp_builtin_"${cmd/-/_}"
>  	local options
> -- 8< --
