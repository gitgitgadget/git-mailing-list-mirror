Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A1220357
	for <e@80x24.org>; Tue, 11 Jul 2017 07:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755381AbdGKHbi (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 03:31:38 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36589 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755271AbdGKHbh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 03:31:37 -0400
Received: by mail-qk0-f170.google.com with SMTP id p21so93419193qke.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jFnxigeqS/bdQbUDkP3OG6dl1BrpbC6QL/Ry1pjGbP4=;
        b=u0Fw7WTZzlQh6/ECw94k53ny7vQ6k3XxYA8+RYiPGnrT/FJgBpB4OvOverRWjjd9il
         5+RTk4+OmrMfuLiRNVq9Q5dl2isQjW7wkwlQm5ZU3KreDW8tZiRX/nHDinel5dTcXm0y
         ch0Md3DIFYBcmpVcm8G6iw4eiU6AXbuZGZgA0E56NSELbsi9XBgSQ/k+CUIlKUByhkb4
         Kp7amqZj/ANY8UC/D4uGxgachOq0oS84pIYSn5HXIIt342P3ltD2BTjHaekbfOLFAMNn
         c6aLz/RdVIlgWiYpUsCkFzb6VN0FH+EShMoplOkROt4t/5kdpUD4ozA61gOAhuDpK7/W
         TKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jFnxigeqS/bdQbUDkP3OG6dl1BrpbC6QL/Ry1pjGbP4=;
        b=GfubXEXtvTagOSJe1n7ObIOCYV3SgPED4SFTZ4uSYKXnPMDmIcUtSsIGxCQKOgs22F
         ZMGtzxftfdd2yh4+WTmjx2YQoWcZqvC2qoL+wWv+vBcTz0bGMS+BmMNKGIxWBjAdiPWk
         T+GjUsF+79vAX50BU2JUd5XGnk70hipHzrZoLVKPy1/FSvwmFURoYUpQCL1orUW9c0G1
         TTj/AvvwMKkCzsHbBzUy/4VPRuBnCkrpegCylxi1jmqgCeQ+0gxHVZD6VpukcZW9yYaw
         NeiXoA0AwnWIyssLrQLy3wxIjV+trZ2XDwUmn9pVy3uK9ln4nZJE7sLlHJnFa4Zk5G4h
         4Spg==
X-Gm-Message-State: AIVw1110QJ1yGfXWDdBGvh4I4iOSTBrCHYbmouv8lcFplc5/ET4cs9EB
        je16Z4eNChnY0A4yBMSXWi1bu/H1xA==
X-Received: by 10.55.132.135 with SMTP id g129mr9352017qkd.36.1499758286296;
 Tue, 11 Jul 2017 00:31:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.45.7 with HTTP; Tue, 11 Jul 2017 00:31:25 -0700 (PDT)
In-Reply-To: <20170711070618.dq52o67ixvjudafg@sigill.intra.peff.net>
References: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
 <d047a884-b698-c25b-59e9-3a2704f79fb3@web.de> <20170711070618.dq52o67ixvjudafg@sigill.intra.peff.net>
From:   Peter Eckersley <peter.eckersley@gmail.com>
Date:   Tue, 11 Jul 2017 00:31:25 -0700
Message-ID: <CAOYJvnLCwR7CkG32E_r5BcVm5tFt5zsgYe7TUW3hVGBtQBHzGw@mail.gmail.com>
Subject: Re: Weirdness with git change detection
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did try to test that hypothesis by editing the filter to be a no-op,
but it's possible I go that wrong. My apologies for bugging the list!

On 11 July 2017 at 00:06, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 11, 2017 at 06:15:17AM +0200, Torsten B=C3=B6gershausen wrote=
:
>
>> On 11/07/17 01:45, Peter Eckersley wrote:
>> > I have a local git repo that's in some weird state where changes
>> > appear to be detected by "git diff" and prevent operations like "git
>> > checkout" from switching branches, but those changes are not removed
>> > by a "git reset --hard" or "git stash".
>> >
>> > Here's an example of the behaviour, with "git reset --hard" failing to
>> > clear a diff in the index:
>> >
>> > https://paste.debian.net/975811/
>> >
>> > Happy to collect additional debugging information if it's useful.
>> >
>> If possible, we need to clone the repo and debug ourselfs - in other
>> words, the problem must be reproducible for others.
>>
>> It the repo public ?
>
> It looks like https://github.com/AI-metrics/AI-metrics.
>
> I notice it has a .gitattributes file with:
>
>   *.ipynb filter=3Dclean_ipynb
>
> There's a config snippet in the repo with:
>
>   [filter "clean_ipynb"]
>     clean =3D ipynb_drop_output
>     smudge =3D cat
>
> and the drop_output script is included. From the paste we can see that
> Peter was at commit c464aaa. Checking out that commit and running the
> script shows that it produces the differences that Git is showing.
>
> The problem is that the currently committed contents do not match the
> output of the clean filter. So even when "git reset --hard" puts the
> content from the repository back into the working tree (putting it
> through the smudge filter, which is a noop), running the clean filter on
> the result will always have a difference. Either the filter needs to be
> disabled, or the cleaned contents committed.
>
> -Peff



--=20
Peter
