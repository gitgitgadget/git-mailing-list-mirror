Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E3CC433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 08:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7A661057
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 08:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhJWIGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 04:06:06 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:42995 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhJWIGF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 04:06:05 -0400
Received: from [79.233.238.25] (helo=[192.168.2.202])
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <test2@mfriebe.de>)
        id 1mdwV4-00073p-0k; Fri, 22 Oct 2021 17:30:30 +0200
Subject: Re: changing the experimental 'git switch' (was: [Summit topic]
 Improving Git UX)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
 <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
 <9c6b3041-a5c0-6fe1-860e-7bfcb292ae81@mfriebe.de>
 <211022.86v91pjfn7.gmgdl@evledraar.gmail.com>
From:   martin <test2@mfriebe.de>
Message-ID: <dc5dcc43-34d0-f4a8-93fa-6875c98e74a5@mfriebe.de>
Date:   Fri, 22 Oct 2021 17:30:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <211022.86v91pjfn7.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/10/2021 16:24, Ævar Arnfjörð Bjarmason wrote:
> FWIW one reason this would be needed is that "switch" intentionally did
> not take "git switch unknown-name" to create "unknown-name", but maybe
> we could relax that if we just e.g. printed out a notice saying a new
> branch is created (which we probably do already...).
I think the "required flag for create" is a good idea and should be 
kept. (My 2 cents)

having the "new name" identified, also helps the user to get the order 
of the arguments right.
Take
   git rebase  <upstream>   <branch>
Why is the target listed before the source? But whichever way round, it 
is hard to remember.
If rebase would only take one <upstream>, and the optional <branch> 
would be a "--from", wouldn't that be easier?

>> If 2 letters could be used, then -c could be given twice for "create copy"
>> -c  => create
>> -c -c  => create copy
>> -cc  => create copy
> Hrm, that's interesting. But probably better to have a long-option.
Well, both: Long and short. But long is --copy or --create-copy.
The issue is finding a short option. -cc imho is still short.

>> But in "git switch" a new commit for the top is given. So that differs.
>> Maybe someone can educate me ?
> Maybe I'm being dense, but I'm not really seeing how a:
>
>      git switch [some create option] <new> <old>
>
> Would have caveats that we don't have already with:
I only tried to illuminate my question with some made-up examples (the 
examples were not meant to be a solution).

What exactly does copy/move do? Am I missing any point?
- They create a new branch (when using switch this branch will also be 
reset to a given commit)
- They copy the reflog
- "move" deletes the old branch (or can be seen as rename)

Anything else?


