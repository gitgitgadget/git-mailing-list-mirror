Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA451F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 20:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436486AbfJRUxF (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 16:53:05 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:47248 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390535AbfJRUxE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 16:53:04 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iLZF8-0004ZH-Bc; Fri, 18 Oct 2019 21:53:03 +0100
Subject: Re: [PATCH v1] config/branch: state that <name>.merge is the remote
 ref
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GitList <git@vger.kernel.org>
References: <20191016112822.1701-1-philipoakley@iee.email>
 <xmqqwod26dp7.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c96f4dbd-ebc6-b743-716e-e1e17333c06b@iee.email>
Date:   Fri, 18 Oct 2019 21:53:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqwod26dp7.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 18/10/2019 02:32, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>>   branch.<name>.merge::
>>   	Defines, together with branch.<name>.remote, the upstream branch
>> -	for the given branch. It tells 'git fetch'/'git pull'/'git rebase' which
>> +	for the given branch. It defines the branch name _on the remote_,
>> +	which may be different from the local branch name.
> While I do agree with the goal of make things more clear, I'd avoid
> being overly redundant and giving irrelevant information (e.g. the
> copy you have locally may be made under arbitrary name that is
> different from the name used at the remote).  After all, the users
> do not even need to know about the remote-tracking branch to
> understand this naming mechanism.
I'd argue that the user has to know about the branch <name> to even get 
here,
and that the key value can be confusing (been there!), so improving the 
understanding
was the aim.

That said, tedious repetition should be avoided, so I'll look to reword 
it while still retaining the emphasis. Perhaps:

branch.<name>.merge::
     Defines, for the local branch <name>, the upstream branch ref
     _on the remote_ (as given by branch.<name>.remote).
     The upstream ref may be different from the local branch ref.

optionally s/different from/ same as/ ?

>
> Perhaps something along this line instead:
>
>      The name of the branch at the remote `branch.<name>.remote` that
>      is used as the upstream branch for the given branch.  It tells
>      `git fetch`, etc., which branch to merge and ...
>
If this, should we also say it (the key value) is that of the upstream 
branch _ref_?

Hmm, *thinks*, I think I'm being swayed by your version. Update to follow.

Philip
