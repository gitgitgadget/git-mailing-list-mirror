Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A833B1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 15:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeFKPTw (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 11:19:52 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41291 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932704AbeFKPTv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 11:19:51 -0400
Received: by mail-ua0-f193.google.com with SMTP id a5-v6so13774146uao.8
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7HXGbJ9oKrsRY159GvPhQJZ6u9eXAZhnNt+Ifbdz+QA=;
        b=ff0VFSE6jZRFtIdUv/JlEA0gXgWFJgpWSnjkhoTnHxIdyHNjnj1VbzhKK7Ro1W2t7C
         o952lq33Pbyriv0w71BONYW561n/W6zGdKmvv/myBAFj0wE9kzl+7ERC1SmYEhzrbsU2
         cizx9thE5zy+t52INft0sZRuYECCLZIgIpl3qjK2SQ+89gIMYyef7aGSoV1I+4GfPpW4
         n0Tsmqu+KtnSnSPofAH694TDfsEQGc67ZoDFgZnDt0h64VTT6iwqOim1E4RygkJh7iDE
         ImYy+DiislQkErzMfngtm0dp+hyRLAXT0jmH6yawwQohtut3rUI0tbs2/yt2gUHBtp8H
         EqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7HXGbJ9oKrsRY159GvPhQJZ6u9eXAZhnNt+Ifbdz+QA=;
        b=FgM4je2/FlL1Wv4FWizrSqdEWxPnpx5IHUDnOJHTJ7/w2LKfT70ua22On55pda0YBp
         wfHhBblDntlonlsR7m0U3F3kjc9i1BedET8x8rByhp2a7WkMFlfvdnyKNA7/LpI7DTDn
         RgOCaNqpVOmgwgzMmXG32yx1rH/bcYJ0HFdK2Q9ygWWNSg0zwY56Cjph74gfHOnOdJyB
         NV2NxfcPApMBRA2EDVrQuPGLCokwx87+6DQBYNz6E6vgdUA93RlVIXB+DoTPVihs3tpw
         qwqHpoei8cHZKpBeHnuAXKWN2s84G6JUEVn/vpzjloZRdEdrZ7saQ3UNpt7vsymTp0G+
         bppA==
X-Gm-Message-State: APt69E3bsnvy0k1eEy3jfJyGbOR8KEYP8rPZl7FTPV4Me38RmB6GFxU8
        Ttvwm/XCbj/5UiLNLDIaM09dqnftP24nDRzrgOE=
X-Google-Smtp-Source: ADUXVKKyQnA7r0ZYEU7xFMeGRpOZvIQFPUMKyslOdQ8qFUXtCP0IZnolbRQZUE6o71CqsIeAW7EcILhtyICVOT61Dmk=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr11479704uae.199.1528730390575;
 Mon, 11 Jun 2018 08:19:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 08:19:49
 -0700 (PDT)
In-Reply-To: <cec770a8-28ee-d546-8c27-905d2fcdb0c8@talktalk.net>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050654.19663-1-newren@gmail.com> <20180607050654.19663-2-newren@gmail.com>
 <cec770a8-28ee-d546-8c27-905d2fcdb0c8@talktalk.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Jun 2018 08:19:49 -0700
Message-ID: <CABPp-BG7sR6NvHf4=ZOwxRh-KKR8QEVwB=D5p9DE_h1oDgRvoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-rebase: error out when incompatible options passed
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On Sun, Jun 10, 2018 at 12:40 PM, Phillip Wood
<phillip.wood@talktalk.net> wrote:

>>   Documentation/git-rebase.txt           | 15 +++++++++++++--
>>   git-rebase.sh                          | 17 +++++++++++++++++
>>   t/t3422-rebase-incompatible-options.sh | 10 +++++-----
>>   3 files changed, 35 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 0e20a66e73..451252c173 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -243,6 +243,10 @@ leave out at most one of A and B, in which case it
>> defaults to HEAD.
>>   --keep-empty::
>>         Keep the commits that do not change anything from its
>>         parents in the result.
>> ++
>> +This uses the `--interactive` machinery internally, and as such,
>> +anything that is incompatible with --interactive is incompatible
>> +with this option.
>>     --allow-empty-message::
>>         By default, rebasing commits with an empty message will fail.
>> @@ -324,6 +328,8 @@ which makes little sense.
>>         and after each change.  When fewer lines of surrounding
>>         context exist they all must match.  By default no context is
>>         ever ignored.
>> +       Incompatible with the --merge and --interactive options, or
>> +       anything that implies those options or their machinery.
>
>
> struct replay_opts has an allow_empty_message member so I'm not sure that's
> true.

I think you were confused by the way the patch broke up.  The jump to
line 328 means that this comment is about the -C option, not the
--allow-empty-message option.

However, I probably should add a comment next to the
--allow-empty-message option, to not the reverse is true, i.e. that
it's incompatible with am-based rebases.  (git-rebase--am.sh ignores
the allow_empty_message variable set in git-rebase.sh, unlike
git-rebase--interactive.sh and git-rebase--merge.sh)

>>   -f::
>>   --force-rebase::
>> @@ -355,13 +361,15 @@ default is `--no-fork-point`, otherwise the default
>> is `--fork-point`.
>>   --whitespace=<option>::
>>         These flag are passed to the 'git apply' program
>>         (see linkgit:git-apply[1]) that applies the patch.
>> -       Incompatible with the --interactive option.
>> +       Incompatible with the --merge and --interactive options, or
>> +       anything that implies those options or their machinery.
>
>
> I wonder if it is better just to list the incompatible options it might be a
> bit long but it would be nicer for the user than them having to work out
> which options imply --interactive.

That could work.  Would this be done at the end of the 'OPTIONS'
section of the manpage?  Should I create an 'INCOMPATIBLE OPTIONS'
section that follows the 'OPTIONS' section?

>>   --committer-date-is-author-date::
>>   --ignore-date::
>>         These flags are passed to 'git am' to easily change the dates
>>         of the rebased commits (see linkgit:git-am[1]).
>> -       Incompatible with the --interactive option.
>> +       Incompatible with the --merge and --interactive options, or
>> +       anything that implies those options or their machinery.
>>     --signoff::
>>         Add a Signed-off-by: trailer to all the rebased commits. Note
>> @@ -400,6 +408,9 @@ The `--rebase-merges` mode is similar in spirit to
>> `--preserve-merges`, but
>>   in contrast to that option works well in interactive rebases: commits
>> can be
>>   reordered, inserted and dropped at will.
>>   +
>> +This uses the `--interactive` machinery internally, but it can be run
>> +without an explicit `--interactive`.
>> ++
>
> Without more context it's hard to judge but I'm not sure this adds anything
> useful

Hmm, yeah.  I noted that --exec had similar wording, noted that
--preserve-merges had something along the same lines but as a warning,
and didn't see the similar wording for --rebase-merges -- I somehow
missed the paragraph right above where I added these lines.  Oops.
Anyway, I'll pull it out.

>>   It is currently only possible to recreate the merge commits using the
>>   `recursive` merge strategy; Different merge strategies can be used only
>> via
>>   explicit `exec git merge -s <strategy> [...]` commands.
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index 40be59ecc4..f1dbecba18 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -503,6 +503,23 @@ then
>>         git_format_patch_opt="$git_format_patch_opt --progress"
>>   fi
>>   +if test -n "$git_am_opt"; then
>> +       incompatible_opts=`echo "$git_am_opt" | sed -e 's/ -q//'`
>
>
> I think the style guide recommends $() over ``

Will fix.


Thanks for taking a look!

Elijah
