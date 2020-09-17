Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A24C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2CA206A4
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgIQPZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 11:25:02 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:59729 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbgIQPYo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 11:24:44 -0400
X-Greylist: delayed 2510 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:24:40 EDT
Received: from host-89-241-187-35.as13285.net ([89.241.187.35] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kIv7X-0005td-99; Thu, 17 Sep 2020 15:42:48 +0100
Subject: Re: Git in Outreachy?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com>
 <20200903060041.GH4035286@google.com>
 <a3613b9d-730a-7a4b-c84b-c833490fcea6@iee.email>
 <nycvar.QRO.7.76.6.2009060933480.56@tvgsbejvaqbjf.bet>
 <5be2fca8-2dbd-115e-b3bb-5783daeba4a3@iee.email>
 <nycvar.QRO.7.76.6.2009162040420.56@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <0ef7ad0b-4626-2cca-d29c-35d21412e595@iee.email>
Date:   Thu, 17 Sep 2020 15:42:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2009162040420.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 16/09/2020 19:43, Johannes Schindelin wrote:
> Hi Philip,
>
> On Wed, 16 Sep 2020, Philip Oakley wrote:
>
>> On 07/09/2020 19:49, Johannes Schindelin wrote:
>>> On Fri, 4 Sep 2020, Philip Oakley wrote:
>>>
>>>> On 03/09/2020 07:00, Jonathan Nieder wrote:
>>>>> Christian Couder wrote:
>>>>>
>>>>>> I would appreciate help to find project ideas though. Are there still
>>>>>> scripts that are worth converting to C (excluding git-bisect.sh and
>>>>>> git-submodule.sh that are still worked on)? Are there worthy
>>>>>> refactorings or improvements that we could propose as projects?
>>>>> I think setting up something like snowpatch[*] to run CI on patches
>>>>> that have hit the mailing list but not yet hit "seen" might be a good
>>>>> project for an interested applicant (and I'd be interested in
>>>>> co-mentoring if we find a taker).
>>>>>
>>>>> Some other topics that could be interesting:
>>>>> - better support for handling people's name changing
>>>>> - making signing features such as signed push easier to use (for
>>>>>   example by allowing signing with SSH keys to simplify PKI) and more
>>>>>   useful (for example by standardizing a way to publish signed push
>>>>>   logs in Git)
>>>>> - protocol: sharing notes and branch descriptions
>>>>> - formats: on-disk reverse idx
>>>>> - obliterate
>>>>> - cache server to take advantage of multiple promisors+packfile URIs
>>>>>
>>>>> Jonathan
>>>>>
>>>>> [*] https://github.com/ruscur/snowpatch
>>>> A suggestion with high value for the Windows community
>>>> - mechanism to map file names between the index and the local FS, should
>>>> a repos file/path name already be taken, or invalid. [1]
>>> This suggestion keeps coming up, but I cannot help but highly doubt that
>>> it will prove useful in practice: if your source code contains a file
>>> called `aux.c`, chances are that your build system lists this file
>>> specifically, and it won't do at all to "magically" rename it to, say,
>>> `aux_.c` during checkout.
>> I'd disagree with that line of reasoning in the sense that if someone is
>> on Windows wanting to 'view' a repo that was developed on Linux, with
>> colons in pathnames, and filenames like aux.c we shouldn't be
>> deliberately de-include them just because of those file/pathname
>> 'accidents.
> If someone wanted to just have a look, they usually make use of the web
> interface of a Git hosting service and look at the file there.
>
> Even if somebody insists on cloning the entire history, they can easily
> look at the file via `git show origin/HEAD:<path>`.
>
> The most likely users who really need those files to be checked out are
> the ones who need to build the project, and that's simply not possible
> with "magically" renamed files.
>
> Ciao,
> Dscho
Is that the user experience we want to have?

Maybe we need extra documentation on the core.protectNTFS setting noting
that Git itself may not be the right tool for such repositories, and
these workarounds which may not be familiar to many users.

It feels as if we are giving cart-blanche to bad actors who can add an
aux.info or similar files to a repo just to thwart collaborators being
on Windows.

Philip


