Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E971FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 20:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbcHZUBB (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 16:01:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34538 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbcHZUBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 16:01:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so699670wma.1
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T2AgvtvpDhZK22cQBHbFcsDfPRjNMzeYlWTcQUqhYFo=;
        b=UbEPQsgCM8/nNoVnHZ0VRZVzCI93id7fEsq/OpBGc5/oXMiy8sXd0rPYon6meHcnmh
         +qJhm/87skjLcXvKUj79QYeBFivGIrrNffcWF5xPQuvce8XAZq7oGKvOY2310NNO3cZu
         RPv10+wbWs1F99FvUwSHwtbLfKH6rGcY90nUIzIavZ1tSGcPGd0AqamdmRp31ykGEIeW
         3xmCJyEPVUWJH1OX20e0vvqyWsbl8QwiQd8YMBhoWYdQecwMjO4nn+MXjJ+Ya7nKYFZ4
         UG1rRfNIFCvjwNXEUZy3gtyvW2XknpURiaZxqG3JCV4SExpspItTgIPxtY0P+dtq4Vhd
         BM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T2AgvtvpDhZK22cQBHbFcsDfPRjNMzeYlWTcQUqhYFo=;
        b=K/6+hvG1zBmrCUsviyZBHqs8nvAhc6WM3viw7QI83q+g2LqitNZZ0rVptqjeIPZ312
         j344XKbkrutQ+UyrQGOaFblVd5tqGia94OO7/MTPBixbIipKqWMxzYGwqpewnQAcdf50
         0Es0CES6RdEZ/9/DdxFqCeWpOpPoRDTv7i1pgmRgd1IbcG7COWAMWKAjYZ0iOJHazdAG
         fg24A1Mrs5rKpqx8BdZvWeHiEYa8MnMsZfTaqQ/+zSS5qrDo6c7C0NLDXaSF0bjnRvPQ
         dh6pNNn3OSg+u3h9/6Fvv+4bjU57DiwMRxX8QRSo/YEo++Xt4CzrXqSPtzLONd/PLIhQ
         HNuw==
X-Gm-Message-State: AE9vXwOI4Puwpj4Rp+q/gaE1vjuBH8q6UhCsweLRATiBZUqyw1JfR/vQMaJynBUfGBlIt+tR8xC1ccmn6UBA+g==
X-Received: by 10.194.235.166 with SMTP id un6mr5665749wjc.169.1472241649186;
 Fri, 26 Aug 2016 13:00:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.230.154 with HTTP; Fri, 26 Aug 2016 13:00:48 -0700 (PDT)
In-Reply-To: <xmqq8tvjgxiy.fsf@gitster.mtv.corp.google.com>
References: <20160818185719.4909-1-ralf.thielow@gmail.com> <20160826175836.14073-1-ralf.thielow@gmail.com>
 <20160826175836.14073-3-ralf.thielow@gmail.com> <xmqq8tvjgxiy.fsf@gitster.mtv.corp.google.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Fri, 26 Aug 2016 22:00:48 +0200
Message-ID: <CAN0XMOKo0VXPZF8ve2e1N5f591Kkz-Gmxt4wJKsev2zj4ubj9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] help: introduce option --exclude-guides
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Joseph Musser <me@jnm2.com>,
        Philip Oakley <philipoakley@iee.org>,
        John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-08-26 21:06 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> Introduce option --exclude-guides to the help command.  With this option
>> being passed, "git help" will open man pages only for actual commands.
>
> Let's hide this option from command help of "git help" itself, drop
> the short-and-sweet "-e", not command-line complete it, and leave it
> not-mentioned here.
>
> It is a different story if this option would really help the end
> users, but I do not think that is the case.  If this were to face
> the end users properly, we would need to worry about making sure
> that "git help -g -e" would error out, and getting all the other
> possible corner cases right.  I do not think the amount of effort
> required to do so (even the "trying to enumerate what other possible
> corner cases there may be" part) is worth it.
>

I'm fine with that as the reason for me was just a "why not?", and
you just gave the reason to not do this. Thanks

>> In the test script we do two things I'd like to point out:
>>
>>> +       test_config help.htmlpath test://html &&
>>
>> As we pass a URL, Git won't check if the given path looks like
>> a documentation directory.  Another solution would be to create
>> a directory, add a file "git.html" to it and just use this path.
>
> I think this is OK; with s|As we pass a URL|As we pass a string with
> :// in it|, the first sentence can be a in-code comment in the test
> that does this and will help readers of the code in the future.
>

Hmm. The "://" is really a URL thing. That's why it's in the code, no?
The code may have some room for improvements in checking for
URLs.

>>> +       test_config help.browser firefox
>>
>> Git checks if the browser is known, so the "test-browser" needs to
>> pretend it is one of them.
>
> Are you talking about the hardcoded list in valid_tool() helper
> function in git-web--browse.sh?  If we use the established escape
> hatch implemented by valid_custom_tool() helper there by setting
> browser.*.cmd, would that be sufficient to work around the "Git
> checks if the browser is known"?
>
>> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
>> index 40d328a..eeb1950 100644
>> --- a/Documentation/git-help.txt
>> +++ b/Documentation/git-help.txt
>> @@ -8,7 +8,7 @@ git-help - Display help information about Git
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git help' [-a|--all] [-g|--guide]
>> +'git help' [-a|--all] [-e|--exclude-guides] [-g|--guide]
>>          [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
>
> So, let's not do this.
>
>> diff --git a/builtin/help.c b/builtin/help.c
>> index e8f79d7..40901a9 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -37,8 +37,10 @@ static int show_all = 0;
>>  static int show_guides = 0;
>>  static unsigned int colopts;
>>  static enum help_format help_format = HELP_FORMAT_NONE;
>> +static int exclude_guides;
>>  static struct option builtin_help_options[] = {
>>       OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
>> +     OPT_BOOL('e', "exclude-guides", &exclude_guides, N_("exclude guides")),
>
> So I'd suggest using PARSE_OPT_HIDDEN for this one and drop 'e' shorthand.
> The only caller of this mode does not use it.
>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index c1b2135..b148164 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1393,7 +1393,7 @@ _git_help ()
>>  {
>>       case "$cur" in
>>       --*)
>> -             __gitcomp "--all --guides --info --man --web"
>> +             __gitcomp "--all --exclude-guides --guides --info --man --web"
>>               return
>>               ;;
>>       esac
>
> So, let's not do this.
>
>> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
>> new file mode 100755
>> index 0000000..fb1abd7
>> --- /dev/null
>> +++ b/t/t0012-help.sh
>> @@ -0,0 +1,33 @@
>> +#!/bin/sh
>> +
>> +test_description='help'
>> +
>> +. ./test-lib.sh
>> +
>> +configure_help () {
>> +     test_config help.format html &&
>> +     test_config help.htmlpath test://html &&
>> +     test_config help.browser firefox
>> +}
>
> Would replacing the last line with:
>
>         test_config browser.test.cmd ./test-browser &&
>         test_config help.browser test
>
> and then writing to test-browser work just as well?  If so, that
> would be much cleaner and more preferrable.
>

I wasn't aware that this is a way to configure things. Thanks.

>> +
>> +test_expect_success "setup" "
>> +     write_script firefox <<-\EOF
>> +     exit 0
>> +     EOF
>> +"
>
> Unless there is a good reason you MUST do so, avoid quoting the test
> body with double quotes, as it invites mistakes [*1*].
>

The test-browser was supposed to be returning just a success
which is good enough for my usage.

> Also, how about using something like:
>
>         write_script test-browser <<-\EOF
>         i=0
>         for arg
>         do
>                 i=$(( $i + 1 ))
>                 echo "$i: $arg"
>         done >test-browser.log
>         EOF
>
> instead?  That way, you can ensure that "git help status" attempts
> to call git-status.html with the expected path, not gitstatus.html
> or status.html, or somesuch, immediately after running "git help
> status" in the next test by inspecting test-browser.log ...
>

We can use this to check whether the correct file was tried to open.
Not a part of this "does it work" test, but good for new ones.

>> +test_expect_success "works for commands and guides by default" "
>> +     configure_help &&
>> +     git help status &&
>
> ... right here.
>
> The output from the test-browser does not have to be multi-line;
> just doing
>
>         echo "$*"
>
> might be sufficient.
>
>> +     git help revisions
>> +"
>
> Thanks.
>
> [Footnote]
>
> *1* Can you immediately tell why this test is broken?
>
> test_expect_success "two commits do not have the same ID" "
>         git commit --allow-empty -m first &&
>         one=$(git rev-parse --verify HEAD) &&
>         test_tick &&
>         git commit --allow-empty -m second &&
>         two=$(git rev-parse --verify HEAD) &&
>         test $one != $two
> "
>

I'm afraid I can't.
