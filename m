Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5111A1F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 16:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbcHBQdd (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 12:33:33 -0400
Received: from siwi.pair.com ([209.68.5.199]:45179 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935405AbcHBQdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 12:33:03 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 36E9A845D7;
	Tue,  2 Aug 2016 12:31:53 -0400 (EDT)
Subject: Re: [PATCH v3 7/8] status: update git-status.txt for --porcelain=v2
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org
References: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
 <1469567483-58794-8-git-send-email-git@jeffhostetler.com>
 <fe5d1dd7-11da-e09b-5880-cf103e34fb9a@gmail.com>
 <579F6D3A.3010704@jeffhostetler.com>
 <4afec4ce-ecb4-dcce-b8f5-c37844d963d8@gmail.com>
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57A0CA79.7040809@jeffhostetler.com>
Date:	Tue, 2 Aug 2016 12:29:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <4afec4ce-ecb4-dcce-b8f5-c37844d963d8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 08/02/2016 11:19 AM, Jakub Narębski wrote:
> W dniu 01.08.2016 o 17:39, Jeff Hostetler pisze:
>> On 07/30/2016 01:22 PM, Jakub Narębski wrote:
>>> W dniu 26.07.2016 o 23:11, Jeff Hostetler pisze:
>>>
>>> This is a nice change, available because of lack of backward
>>> compatibility with v1.  The porcelain v2 format branch-related
>>> information could be enhanced without risk of breaking parsers,
>>> or having new information put at the end even if it does not fit
>>> there (like in previous iteration).
>>>
>>> One thing that can serve as goal for the series is using the
>>> question: would it make __git_ps1() from git-prompt.sh be able
>>> to render fully decorated prompt with all bells and whistles,
>>> and with all combinations of options.  Thus beside upstream
>>> in the future we might want SVN upstream, and/or pushed-to
>>> remote branch (and remote push upstream repository), etc.
>>>
>>> But that's for the future (and it is possible for the future)...
>>>
>>
>> Yes, I was hoping to be able to simplify and/or speed up
>> __git_ps1() with this data.  "Namespacing" the branch data
>> here.  And then later add the state data (in a merge,
>> in a rebase, and etc.) in a series of "# state.*" headers.
>> And so on, until we get everything that __git_ps1() needs.
>> However, to really make that work, we might want to add
>> a --no-scan (or minimial scan) option, to just return the
>> header data, since __git_ps1() doesn't care about the list
>> of changes.
>
> But __git_ps1() with GIT_PS1_SHOWDIRTYSTATE would want to know
> if there are unstaged and staged changes, and with
> GIT_PS1_SHOWUNTRACKEDFILES it would want to know if there
> are untracked (unknown) files, isn't it?
>
> And GIT_PS1_SHOWSTASHSTATE would want to know if there is
> something stashed, but I guess it is outside the remit of
> git-status...
>
> Also, __git_ps1() uses colors from git-status, so if it
> is switched to use --porcelain=v2, then there should be an
> option to turn the color on, isn't it?
>

All of these are good questions.  But __git_ps1() is outside my
scope right now.  All I was saying above is that by making
the branch details available here and, later, extending V2
output by adding other such headers to the output, we could
try to remove much of the business logic in __git_ps1() and
hopefully reduce it to just formatting and coloring the prompt
using the computed result from status.

But I've only skimmed __git_ps1() (and it's a little dense),
so I'd have to study it more before I could answer all of your
questions.

Thanks,
Jeff




