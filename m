Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAE9C433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 11:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352553AbhLXL0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 06:26:09 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:38989 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344108AbhLXL0I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 06:26:08 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n0ii4-0005DG-Bi; Fri, 24 Dec 2021 11:26:07 +0000
Message-ID: <7c98ad08-046c-d2c2-2bfa-e6b559f41fd3@iee.email>
Date:   Fri, 24 Dec 2021 11:26:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Custom subcommand help handlers
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Erik Cervin Edin <erik@cervined.in>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
 <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>
 <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
 <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net> <xmqqa6guub9n.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2112221717440.347@tvgsbejvaqbjf.bet>
 <xmqqczloju0q.fsf@gitster.g> <032aced5-4c50-76f7-9ab6-580ffa5775a5@iee.email>
 <xmqqh7ay6en7.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqh7ay6en7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/12/2021 00:16, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> They had the issue that their windows users, using Git for Windows, do
>> not have the `man` package installed. Rather the `web` help of using the
>> .html version of the man page is used (needs administrator install in
>> some case). So user commands would need to provide both the man page for
>> Linux systems and some process to get the html equivalent into the right
>> folder - this latter case was the problem step.
> So are they willing to prepare `web` help pages, because that is
> what the users of Git for Windows are already familiar with, if "git
> foo --help" is capable of showing it, just like "git commit --help"
> shows the `web` help page for the subcommand?
>
> As I said elsewhere on this thread, lack of equivalent for MANPATH
> and INFOPATH makes `web` help harder to customize in that direction,
> but that is a problem we can solve in our code.  Once it is there,
> they can let the user install their `web` help pages into somewhere
> the user has write access to and point at the "folder" with
> GIT_HTMLPATH, I would presume?
>
> Thanks.
>
I'm not sure if they are willing to create web versions of the man page
or not. The request was that we should let their code decide by passing
the --help option so they could link out to whatever process they have -
maybe it's a SharePoint server with fancy presentations (I never liked
them, but many places have drunk the cool aid).

Having an alternate GIT_HTMLPATH could help some users who do have html
documents, but I was cautious about letting ourselves over automate the
mechanisation and still leave the users out of the picture.

Hopefully Sean will be able to clarify if I've misunderstood the details
of their problems.

Philip
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
