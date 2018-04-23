Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B50151F424
	for <e@80x24.org>; Mon, 23 Apr 2018 15:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755634AbeDWPMr (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 11:12:47 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:37983 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755047AbeDWPMq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 11:12:46 -0400
Received: by mail-vk0-f51.google.com with SMTP id b16so9613099vka.5
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TQQZt4nShpD1FaYMKsPe4javpwHJi+1VANe0HZhXBpc=;
        b=YOAmc3UgkXeM+TLhMtNUkj+Ohs3cISMOZB5DRoqPIiISf6VYfRTFymboaywY/G/16k
         0j8HHAuJjJtTurHYPs6djSBXbZcZgraAdr0skSddGbyYIn6yZbYFkSDLXlorrp0DBoLI
         oAoIWkXW7QTuitzC79FlrgNNKFGSTkhAsfEFsJBey2JDwVwgQaWmfymyDcG19f6GMoCh
         mw20nGb28QZdmmoAC+TtI1FJarL7d1Upn5qw8YjsXk2d9MyZgiNmZIhrEVaCaRquFqVu
         64yjP3cgp0q7IO0XAvTgOathPR5xlCVSb1k4S7kTHnmY8RgNfLV9mD7RS0jqFmL9sxDq
         50xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=TQQZt4nShpD1FaYMKsPe4javpwHJi+1VANe0HZhXBpc=;
        b=EyjuWK8jC7gWvhuXF7TpT8eCRzgkcfl2txR/4//EXc2nvt+ItqmEq7/gjBV9AMCRcj
         77vdsWR5ixWyybVKT+9djuE5f7GB5b7SrBwlv6PcPosU12x8ekPUiwPLymD/Quy5Wkpv
         WB+d+jrdoHtUZ6F8igH+mpc9pSbuerZU4/ScLNT6Rx1rlLzDt5N5IU1XDiYcUOlcT/1j
         CW2qgUDwUni8xhLnHYEII8RRjue2gTBkfB/NpWhdTWktsGNTnrP25O0YadUHUP/sPWj1
         24bg/bqePpPgwzr8zJ1sLoeHi5bFUZe2rsWRdJKMpocFmSyxV/YzoZunhVctQHuOS/k6
         Z/Kw==
X-Gm-Message-State: ALQs6tCvOmSmocg/lhgq8HaU4eSr5p4EHv7p9Nkm6RUo6eD7tUVYePgk
        i8Mw4FPXq+d4eMAugQsHOag9vrIqi9OSU2fjLLk=
X-Google-Smtp-Source: AIpwx48BWk/W6XsYikCz58jLSfdYQFglSMLKxGaEPOaAKZduvkKOP0I3w+4b+CrVjVePG+5Q/IHWNlEEAWtr9lYsvtw=
X-Received: by 10.31.132.213 with SMTP id g204mr14720166vkd.2.1524496365487;
 Mon, 23 Apr 2018 08:12:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Mon, 23 Apr 2018 08:12:44 -0700 (PDT)
In-Reply-To: <20180419190725.GA8555@furore>
References: <CAM0VKj=pDVxfJtUZx7c6uCmPxwQFPBOQYdd7NH=YnVG86iK0Pw@mail.gmail.com>
 <20180419190725.GA8555@furore>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 23 Apr 2018 17:12:44 +0200
Message-ID: <CAM0VKjmJBzBFDAi1FQAgytb82-Q7JhO+aOfKi=YBZ3YtNxwPTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] completion: load completion file for external subcommand
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 9:07 PM, Florian Gamb=C3=B6ck <mail@floga.de> wrote=
:
> On 2018-04-18 21:51, SZEDER G=C3=A1bor wrote:
>>
>> On Tue, Apr 10, 2018 at 10:28 PM, Florian Gamb=C3=B6ck <mail@floga.de> w=
rote:
>>>
>>> Adding external subcommands to Git is as easy as to put an executable
>>> file git-foo into PATH. Packaging such subcommands for a Linux distribu=
tion
>>> can be achieved by unpacking the executable into /usr/bin of the user's
>>> system. Adding system-wide completion scripts for new subcommands, howe=
ver,
>>> can be a bit tricky.
>>>
>>> Since bash-completion started to use dynamical loading of completion
>>> scripts since v1.90 (preview of v2.0),
>>
>>
>> I believe the main bash-completion repository can be found at:
>>
>>  https://github.com/scop/bash-completion.git
>>
>> This repository still contains the branch 'dynamic-loading'; for the
>> record it points to 3b029892f6f9db3b7210a7f66d636be3e5ec5fa2.
>>
>> Two commits on that branch are worth mentioning:
>>
>>   20c05b43 (Load completions in separate files dynamically, get rid of
>>             have()., 2011-10-12)
>>   5baebf81 (Add _xfunc for loading and calling functions on demand,
>>             use it in apt-get, cvsps, rsync, and sshfs., 2011-10-13)
>
>
> Nice, thanks for the pointers!
>
>>> (...)
>>>
>>> I think the easiest method is to use a function that is defined by
>>> bash-completion v2.0+, namely __load_completion.
>>
>>
>> This is wrong, __load_completion() was introduced in cad3abfc
>> (__load_completion: New function, use in _completion_loader and _xfunc,
>> 2015-07-15), and the first release tag containg it is '2.2' from 2016-03=
-03.
>
>
> Dang, I thought it was introduced at the same time. Sorry for that. I gue=
ss,
> 2016 is a bit too young to take it for granted then?
>
>> The release tags '1.90' and '2.0' are from 2011-11-03 and 2012-06-17,
>> respectively.  This leaves a couple of years long hole where completions
>> were already loaded dynamically but there was no __load_completion()
>> function.
>>
>> Would it be possible to use _xfunc() instead to plug that hole?  It seem=
s
>> the be tricky, because that function not only sources but also _calls_ t=
he
>> completion function.
>
>
> But isn't this exactly what we want?

No, that's definitely not what we want.

The bash-completion project can get away with it, because they only
use their _xfunc() to source a file they themselves ship and to call a
completion function they know that that file contains.

We, however, would like to load a file that might not exist and to
call a function that might not be defined.  Git has a lot of plumbing
commands with neither a corresponding _git_plumbing_cmd() completion
function in our completion script nor a corresponding
'git-plumbing-cmd' file that could be sourced dynamically to provide
that function.  The same applies to any 'git-foo' command in the
user's $PATH (the user's own scripts or various git-related tools,
e.g. Git LFS).

So if someone tries e.g. 'git diff-index <TAB>' to complete files in
the current directory, then it would result in an error message like

  _git_diff_index: command not found

Furthermore, earlier versions of _xfunc(), I think until the
introduction  of __load_completion(), tried to source the file given
as parameter without checking its existence beforehand, so on whatever
LTS I happen to be currently using I would also get an error like

  bash: /usr/share/bash-completion/completions/git-diff-index: No such
file or directory

Finally, since all this is running in the user's interactive shell,
Bash will even run the 'command_not_found_handle', if it's set (and
most Linux distros do set it in their default configuration (OK, maybe
not most, but at least some of the more popular do)), which may or may
not have any suggestions, but at the very least it takes quite a while
to scan through its database.


> Lucky us, we can replace the whole
> if-fi block with a simpler:
>
>    _xfunc git-$command $completion_func 2>/dev/null && return
>
> If _xfunc is not defined -- as in, bashcomp is not installed / loaded --
> then the return will not get called and the original completion will
> continue:
>
>    declare -f $completion_func >/dev/null 2>/dev/null &&
>        $completion_func && return
>
> Since this would be redundant, we could define a fall-back for _xfunc lik=
e
> so:
>
>    declare -f _xfunc || _xfunc() {
>        declare -f $completion_func >/dev/null 2>/dev/null &&
>            $completion_func && return
>    }
>
> This way, we retain the "old" behavior and get dynamic loading if bashcom=
p
> is available. The actual call to get the completions would just be _xfunc
> like in my first example above.
>
> What do you think?
>
> --
> Regards
>
> Florian
