Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7FF91F404
	for <e@80x24.org>; Sun, 29 Apr 2018 11:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeD2LPo (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 07:15:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbeD2LPn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 07:15:43 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue101
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LnjcV-1ejCRM0T8x-00hzRA; Sun, 29
 Apr 2018 13:15:35 +0200
Date:   Sun, 29 Apr 2018 13:15:33 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 1/1] completion: load completion file for external
 subcommand
Message-ID: <20180429111533.GA31974@furore>
Mail-Followup-To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=MVY15SbRanfhXP3pPjNEuhZ=dbQmhXox6n5AOFyz2oQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Provags-ID: V03:K1:sTF7GUiGz8kunO5epj0C087xwzCzEpTuj3uB4hojLaNa9q5jd9k
 fjo3ig7vRHilnmwlOGShyOMkZHLPe9gSW8JNVmYGwDgg7LjSUnbuxq9iRBwqPzli0Nfv0GE
 BpO6pZnDK2iO7jrEX9ZMqgsMP7d7cGKaoQRQTGKoZIW8vq2/BTxwjsU8vwLsHIWhOmkIXVZ
 pXmzAQ6qMxEgMUjK+LlXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0HHL3AfyTBc=:KymsAcMdTPgIJJVkz3m5NZ
 wJ54YqJRysk8yv6lK6/4BIdbAuPdicD5uyhYIX+UzmotLH5NKbvdqLcViLS+ubFW8w1FE6w/O
 GsVU/Juie+CvuhnfAcuCe7eWCVEeK9DtYkjm8pQL8vJl9ndybwRx5ki8CPiPld1tdMvH3gSwN
 G1cFLxhXcikuTjysiiU73EWrAWJz7Gmuh37iLdM5ioL8ujJvdEz7SOiFzb2/SNWn8r41m5R/3
 mtt9qz9TTYhmixwlhUwV3bN1qHIaCdJWmFQ2sldEyYMlrg36LyFfoLNZufwH2LFp7b4CZpzct
 l+1eLf1wssJZLCy/gqJR1RUM1V6RKjeE/6RAI4wooftXJWTq/0+o0PSRSIS6GcP0bPimWhbJX
 WpURg3lVaQ63KAEX8GVUqwBtuNEp6TeOWpY00b41ZI5euNOCMJonabx3sgKBoDQS+l0z0Il/r
 5bSgl9Vm3RQaMHQh01D1Pt9lLxv3mtVW0YdCtZ+JrOjrLJPJArqpBfJC2L5xQIboOs1CBlE5p
 8BhIIR5lmqkiViEPUfFJ6OIBtZFd2ZOioYd5oMd8BwaFGmaLtIDm0nHPelQK3XZVhLztwYt+F
 08iny9qDJXZARE+FZjGc+p6meDYtfSqRfZOjYM6BbpYFL61uxqUOb2eRciatbScrnvC5BJ/cw
 iRsQXEinZMuJ3OrnpuXzOAlHdhXqaPKIVYskvt6yfOXUnldzWz9zn2+PxyY+vcLwLQoU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-25 16:40, SZEDER Gábor wrote:
> In my previous emails I overlooked the _completion_loader() helper 
> function.
>
> It seems that this function does almost exactly what we want.  It was 
> introduced along with dynamic completion loading back in 20c05b43, so 
> it's available for us even in older LTS/Enterprise releases.  Since 
> cad3abfc it's a wrapper around __load_completion() and thus benefits 
> from all the improvements, notably searching for completion scripts in 
> a user-specified directory ($BASH_COMPLETION_USER_DIR) or in the 
> user's home directory ($XDG_DATA_HOME or ~/.local/...) as well.  It 
> loads the matching completion script, but does not call the completion 
> function unconditionally.

Sounds good so far.

> The "almost" refers to he case when _completion_loader() can't find a 
> completion script with a matching name to load, and then registers the 
> _minimal() completion function for the given command to do basic path 
> completion as fallback.  I don't think this matters in practice, 
> because in this case the given command is a git command in its dashed 
> form, e.g. 'git-diff-index', and those have been deprecated for a long 
> time.

I sense a problem here. If I have a directory with a file xyzfoobar in 
it, and I type `git xyz`, with no defined subcommand that starts with 
these letters, then minimal bashcomp would give me `git xyzfoobar`, 
which can of course not execute. This can be unintuitive for users, as 
in: "If it can't be executed correctly, then why does it even suggest 
such a completion?"

> I think all you need to do is run a 
> s/__load_completion/_completion_loader/ on your patch and update the 
> commit message with relevant bits from the above discussion.

I can do that, no problem. But prior to that I want to be sure that you 
are okay with the above mentioned drawback. Will the behavior be 
acceptable in this case? Or should we try to somehow "undo" the minimal 
completion afterwards?
