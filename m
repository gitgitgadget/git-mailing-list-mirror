Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFFFC433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 15:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244072AbhLWPHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 10:07:51 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:62502 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239868AbhLWPHu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 10:07:50 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n0Ph6-0000xT-Ce; Thu, 23 Dec 2021 15:07:49 +0000
Message-ID: <032aced5-4c50-76f7-9ab6-580ffa5775a5@iee.email>
Date:   Thu, 23 Dec 2021 15:07:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Custom subcommand help handlers
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Erik Cervin Edin <erik@cervined.in>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
 <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>
 <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
 <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net> <xmqqa6guub9n.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2112221717440.347@tvgsbejvaqbjf.bet>
 <xmqqczloju0q.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqczloju0q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/2021 19:53, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Mon, 20 Dec 2021, Junio C Hamano wrote:
>>
>>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>>
>>>> I should point out that in most cases on Unix, it _is_ expected that you
>>>> install your manual pages into the same place as everyone else, so in
>>>> this case, installing the HTML documentation alongside Git's may be the
>>>> best solution.
>>> Yup, that sounds like the most sensible way to do things.
>> So what about `~/bin/git-my-reply-to-junio`? Do we expect people to write
>> a manual page and install it into `~/man/man1` and for `man` to pick that
>> up?
> Yes, if they write one, and then tell man that you have extra
> manpages there via MANPATH.
>
> I expect people *not* to write a manual page in practice for such a
> thing, though ;-)

In the very original use case reported in the git for windows issues
pages, I understood it that the provider of the git-foo script expected
that they would include some detection and response to the --help being
given as an option.

They had the issue that their windows users, using Git for Windows, do
not have the `man` package installed. Rather the `web` help of using the
.html version of the man page is used (needs administrator install in
some case). So user commands would need to provide both the man page for
Linux systems and some process to get the html equivalent into the right
folder - this latter case was the problem step. 

The expectation from the XY-Problem was that if the html (and possibly,
by implication, the man page) was not found by git, that the --help
option would be passed to the command itself for it the command to
process (or ignore)..

It is a bit of a rabbit hole.

Philip
