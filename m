Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8285A207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 20:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161450AbdDUUOv (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 16:14:51 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35827 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161420AbdDUUOu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 16:14:50 -0400
Received: by mail-ua0-f178.google.com with SMTP id f10so86907471uaa.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OU9ILScg8P4smNzGaTxW0+L7srdN0N9EU+xyTmg73iI=;
        b=IqliaQZKP5VpaWB8RVLm34jeEv87WbeOIaSNyTYIo0XlCPRFJcACA0TA5oN1fS8w2G
         c3gMZ5F5mXDUT2yz/3MqvgRTNhVFkdGE2kmgA76+SwWvW6Hz7LqV8GscdXDC4YF2rIey
         0UDYka3HmnS/wKnUeMN6mNGp9ffSZSAsdrJI+exZBby0h/EyUp4wrpsOK/2gvcsor5Tx
         R/u6N50SXte+sHavVsxUOaVFJIgXrqiEjt1PBO0QWKRbGWCppRDnoHgjSiJbslldDvVu
         4VOguj0y3WhFQ1S7ncxmXRFFGHyJ4N18Cj6QDGuLnsiqAS6iRLCkey94OL01KV88O1vO
         jmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OU9ILScg8P4smNzGaTxW0+L7srdN0N9EU+xyTmg73iI=;
        b=gHk4gMsKkWZwNcmM/YDVoRT6mFv/D8ZzJRHrV5SeNJvMhzjeup12iQELjm7mSO6nzo
         FajW4SNCtPxDTLLDyN1P/ATq4ZsOZtI3GlFCZpjp+eTLZisnohBJCB0xdU4pyZkXueyG
         /lRWb2Q/0lrKpHFplBU/zDsX89PlGaLZIbrGxi3Y3ubfJk4xe010OfOIyPnWRR6Yypli
         5obgNyWvbqfWl6fa9U0RcVRRv/WnZ5uDPfgqFSFd97wkLu7JElUC5SgeYkWBhIeq9kp4
         cNqbAJ4A5b+WmK0Koqdlbpf3w2zM9Fo+19cdWqOX70n1fjfzxiFjcQYVu+Be13cbIZmg
         opbg==
X-Gm-Message-State: AN3rC/7wAOWwcUkH9jNEAewy7MCd9W3pv2BcmyiotgrZZYbwfrQaAr2H
        8VzOHqWXr9dcp/xQJM1BFvG08TvoGw==
X-Received: by 10.176.16.206 with SMTP id x14mr8003345uab.174.1492805689198;
 Fri, 21 Apr 2017 13:14:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.211 with HTTP; Fri, 21 Apr 2017 13:14:48 -0700 (PDT)
In-Reply-To: <xmqqzifa4amr.fsf@gitster.mtv.corp.google.com>
References: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net> <xmqqzifa4amr.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 21 Apr 2017 22:14:48 +0200
Message-ID: <CAM0VKjm=JMuYzsS-OTx+p-vFF8PmWJGbFnndag9dWw6xCe3g6Q@mail.gmail.com>
Subject: Re: [PATCH] completion: optionally disable checkout DWIM
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 7:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> When we complete branch names for "git checkout", we also
>> complete remote branch names that could trigger the DWIM
>> behavior. Depending on your workflow and project, this can
>> be either convenient or annoying.
>> ...
>> This is flexible enough for me, but it's possible somebody would want
>> this on a per-repo basis. I don't know that we want to read from `git
>> config`, though, because it's relatively expensive to do so. People who
>> want per-repo settings are probably better off with a hook that triggers
>> when they "cd" around, and sets up their preferences.

We could discern between more than just empty vs. non-empty state of
the environment variable, e.g.:

  - if empty/unset, then include "DWIM" suggestions.
  - if set to 'config', then query the 'completion.checkoutNoGuess'
    configuration variable, and omit "DWIM" suggestions if its true.
  - if set to something else, then omit "DWIM" suggestions.

Then users can themselves decide, whether the per-repo configurability
is worth the overhead of running 'git config'.


> Sounds OK.  I am kind of surprised that --no-guess is the only way
> to turn off this dwimming (not in the completion side, but there
> does not seem to be a way to tell "git checkout" that you do not
> need that create-missing-branch-out-of-remote-tracking).
>
>>  contrib/completion/git-completion.bash | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 1150164d5..f53b18fae 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -28,6 +28,14 @@
>>  # completion style.  For example '!f() { : git commit ; ... }; f' will
>>  # tell the completion to use commit completion.  This also works with aliases
>>  # of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".
>> +#
>> +# You can set the following environment variables to influence the behavior of
>> +# the completion routines:
>> +#
>> +#   GIT_COMPLETION_CHECKOUT_NO_GUESS

That's one long variable name :)
Of course it has to start with the 'GIT_COMPLETION_' prefix, and you
can't win from there...

>> +#     When non-empty, do not include "DWIM" suggestions in git-checkout
>> +#     completion (e.g., completing "foo" when "origin/foo" exists).
>>
>>  case "$COMP_WORDBREAKS" in
>>  *:*) : great ;;
>> @@ -1248,7 +1256,8 @@ _git_checkout ()
>>               # check if --track, --no-track, or --no-guess was specified
>>               # if so, disable DWIM mode
>>               local flags="--track --no-track --no-guess" track_opt="--track"
>> -             if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
>> +             if [ -n "$GIT_COMPLETION_CHECKOUT_NO_GUESS" -o \
>> +                  -n "$(__git_find_on_cmdline "$flags")" ]; then

|| would be better than '-o', because the former short-circuits when
the first condition is true, but the latter doesn't.

>>                       track_opt=''
>>               fi
>>               __git_complete_refs $track_opt

On Fri, Apr 21, 2017 at 7:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> When we complete branch names for "git checkout", we also
>> complete remote branch names that could trigger the DWIM
>> behavior. Depending on your workflow and project, this can
>> be either convenient or annoying.
>> ...
>> This is flexible enough for me, but it's possible somebody would want
>> this on a per-repo basis. I don't know that we want to read from `git
>> config`, though, because it's relatively expensive to do so. People who
>> want per-repo settings are probably better off with a hook that triggers
>> when they "cd" around, and sets up their preferences.
>
> Sounds OK.  I am kind of surprised that --no-guess is the only way
> to turn off this dwimming (not in the completion side, but there
> does not seem to be a way to tell "git checkout" that you do not
> need that create-missing-branch-out-of-remote-tracking).
>
>>  contrib/completion/git-completion.bash | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 1150164d5..f53b18fae 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -28,6 +28,14 @@
>>  # completion style.  For example '!f() { : git commit ; ... }; f' will
>>  # tell the completion to use commit completion.  This also works with aliases
>>  # of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".
>> +#
>> +# You can set the following environment variables to influence the behavior of
>> +# the completion routines:
>> +#
>> +#   GIT_COMPLETION_CHECKOUT_NO_GUESS
>> +#
>> +#     When non-empty, do not include "DWIM" suggestions in git-checkout
>> +#     completion (e.g., completing "foo" when "origin/foo" exists).
>>
>>  case "$COMP_WORDBREAKS" in
>>  *:*) : great ;;
>> @@ -1248,7 +1256,8 @@ _git_checkout ()
>>               # check if --track, --no-track, or --no-guess was specified
>>               # if so, disable DWIM mode
>>               local flags="--track --no-track --no-guess" track_opt="--track"
>> -             if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
>> +             if [ -n "$GIT_COMPLETION_CHECKOUT_NO_GUESS" -o \
>> +                  -n "$(__git_find_on_cmdline "$flags")" ]; then
>>                       track_opt=''
>>               fi
>>               __git_complete_refs $track_opt
