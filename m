Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD60620D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 20:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdFAUvc (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 16:51:32 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33755 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdFAUvb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 16:51:31 -0400
Received: by mail-io0-f194.google.com with SMTP id m4so6543103ioe.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3JmlnFSHbdDossb/qvLYWpF7nql7WPEuuWvrb7C9pEk=;
        b=cSexF15mS13hu9PTCSMG7hVVL+oMzctjseyzCyJdnGJou0fC3hpCzCmk9oMqlO4W+i
         n+fGPzJbRdmJnP9KtPZII9N2JWAdgV3wHD56akwYPkzhfExY9iL/SeBtQhmAR+UnhE41
         3laMl45IMzBleYu0OlDpfq2/Mrlz+MlwcD0Rmj28fFwEZvAdA7/0hx4SAstiNJ0iTCYo
         SFcsaMFaJGuFjQOZ9qCPTE2EXs1ItFgwoiulc37rtxr1JkPI6N8A44nRprtiwX+Rr8UO
         pdFN7eKYNOnQzMNKbCbZ3FraG/aZ97V8bjog+LnNJbbxq0oBDLriouKQ8cmF2NtVnE/W
         f6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3JmlnFSHbdDossb/qvLYWpF7nql7WPEuuWvrb7C9pEk=;
        b=d35qEctYlJL2+Gk6HOb5lGIF3fRleDHzxAjzNycggVFPXTjWVnPxO9pOr+t5hOAPx7
         NHOZr0LQfXengI2avoxNoFWP0zsQIXv+vehD4MNSOAyHA29lCttvgxleg/WnkrthFdMN
         gpuWTdbYOqoZj0EX7y6jsqePoyESn6P4IEv9VT4pEdwCDeMb6Dw4K5Z624DdI5eEvqDb
         sCwbL50a6Gux7PULmgmqn4dNR9KW3eG5XS4wvkR4gqczqL8X54tksgok5DrReIckT21O
         yXuy0Q0Ve8BIfxWvEWtsWs/BNqx63OjFE8aIk+XVUDnJn83yCTNJqJ78fliptCRZd3kl
         2ywQ==
X-Gm-Message-State: AODbwcDoA5GXhNvRO1yrxJJWOgiNyykXwPyMZBx38xlOHCEd8MOiRlp8
        SFMCWLCY4nQpCHcEIx08y4ee2Q5JoHJIZ4o=
X-Received: by 10.107.178.215 with SMTP id b206mr969146iof.50.1496350290633;
 Thu, 01 Jun 2017 13:51:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 13:51:09 -0700 (PDT)
In-Reply-To: <20170601155105.28356-1-benpeart@microsoft.com>
References: <20170601155105.28356-1-benpeart@microsoft.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 1 Jun 2017 22:51:09 +0200
Message-ID: <CACBZZX5e58bWuf3NdDYTxu2KyZj29hHONzN=rp-7vXd8nURyWQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Fast git status via a file system watcher
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 5:50 PM, Ben Peart <peartben@gmail.com> wrote:
> Changes from V3 include:
>  - update test script based on feedback
>  - update template hook proc with better post-processing code and make
>    it executable

I have watchman running finally, so aside from issues applying this I
can finally test this. I set up a watch of linux.git:

$ watchman watch $PWD
$ watchman watch-list|jq '.roots[]'
"/home/avar/g/linux"

And first, for simplicity, I'll be turning core.fsmonitore on later:

$ for c in fsmonitor untrackedCache splitIndex; do git config core.$c
false; done

On a hot fs cache running "git status" takes me 80ms, but if I flush caches:

# free && sync && echo 3 > /proc/sys/vm/drop_caches && free

Running "git status" takes me 4s. Now, right after flushing those caches:

$ date +%s
1496349235
$ time (echo '["query", "/home/avar/g/linux", {"since": 1496349235,
"fields":["name"]}]' | watchman -j) | jq '.files[]'

real    0m0.664s
user    0m0.000s
sys     0m0.004s
$ touch foo bar
$ time (echo '["query", "/home/avar/g/linux", {"since": 1496349235,
"fields":["name"]}]' | watchman -j) | jq '.files[]'
"bar"
"foo"

real    0m0.044s
user    0m0.000s
sys     0m0.000s

Without the monitor running "git status' takes me ~2.5s, i.e. from cold cache:

$ time GIT_TRACE=1 ~/g/git/git-status
20:34:49.154731 git.c:369               trace: built-in: git 'status'
On branch master
Your branch is up-to-date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        bar
        foo

nothing added to commit but untracked files present (use "git add" to track)

real    0m2.546s
user    0m0.060s
sys     0m0.228s

Now, I would expect the case where the working tree isn't in the fs
cache to be lightning fast, since the watchman command is really fast
(flushed the cache again, turned on the fsmonitor):

$ date +%s
1496349523
$ time (echo '["query", "/home/avar/g/linux", {"since": 1496349523,
"fields":["name"]}]' | watchman -j) | jq '.files[]'

real    0m0.529s
user    0m0.000s
sys     0m0.004s
$ touch foo bar
$ time (echo '["query", "/home/avar/g/linux", {"since": 1496349523,
"fields":["name"]}]' | watchman -j) | jq '.files[]'
"bar"
"foo"

real    0m0.312s
user    0m0.000s
sys     0m0.000s

But if I run "git status" (and I instrumented the hook to dump the
changed files) it takes a long time (those 10s are just the disk being
slow, but it should be ~0s, right?):

$ time GIT_TRACE=1 ~/g/git/git-status
20:39:11.250128 git.c:369               trace: built-in: git 'status'
20:39:14.586720 run-command.c:626       trace: run_command:
'.git/hooks/query-fsmonitor' '1' '1496349494197821000'
Watchman says these changed: bar foo hi there .git .git/index.lock .git/index
On branch master
Your branch is up-to-date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        bar
        foo

nothing added to commit but untracked files present (use "git add" to track)

real    0m10.791s
user    0m0.108s
sys     0m0.228s

If I re-run that it takes ~160-200ms with the hook, 80-120ms without
it, so in this case once the data is in the fscache watchman is
actually slower.

But manually running watchman shows that it's really fast, usually
returning within 3ms, I flush the fscache in the middle of this,
that's the 600ms time, that could be some global kernel lock or
something due to the odd manual proc operation, I haven't actually
tested this on a system under memory pressure:

$ for i in {1..10}; do (time (printf '["query", "/home/avar/g/linux",
{"since": %s, "fields":["name"]}]' $(($(date +%s)-3)) | watchman -j |
jq '.files[]')) 2>&1 | grep -e '"' -e ^real && touch $i && sleep 1;
done
real    0m0.004s
"1"
real    0m0.003s
"2"
"1"
real    0m0.605s
"3"
real    0m0.003s
"4"
"3"
real    0m0.003s
"5"
"4"
real    0m0.003s
"6"
"5"
real    0m0.003s
"7"
"6"
real    0m0.003s
"8"
"7"
real    0m0.003s
"9"
"8"
real    0m0.003s

So something really odd is going on here. This should be speeding up
"git status" a lot, even with a hot fs cache doing stat on all of
linux.git takes a lot longer than 3ms, but for some reason it's
slower.
