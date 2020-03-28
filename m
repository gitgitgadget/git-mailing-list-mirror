Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B91C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 11:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8D3206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 11:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgC1LjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:39:01 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:22041 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1LjB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 07:39:01 -0400
Received: from [92.30.123.115] (helo=[192.168.1.38])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jI9nm-0009qy-9S; Sat, 28 Mar 2020 11:38:59 +0000
Subject: Re: How log log a feaure request
To:     Junio C Hamano <gitster@pobox.com>, Tymek Majewski <tmaj@pm.me>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <l0W9VY7TaoqT51RecilbNNTaX35RiCNlJtZKcz04cyKexuG06-bZMlwfor5kCvnIHRRWE7s8TSJLwvA-w4-1poMV_gle8iOzd3-wzFVDUh0=@pm.me>
 <xmqq1rs91bo2.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <230b4b11-d1fe-713c-c7b3-c806bff0376f@iee.email>
Date:   Sat, 28 Mar 2020 11:38:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rs91bo2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tymek, Junio

On 09/01/2020 04:44, Junio C Hamano wrote:
> Tymek Majewski <tmaj@pm.me> writes:
>
>> Hello gurus!
>>
>> I looked at https://git-scm.com/community but I failed to find a
>> place to send feature requests to.
>>
>> Q: How to submit a feature request (rather than a bug)?
> Sending it here, which you did, is how ;-)
>
>> Reasoning:
>>
>> I believe that if the git checkout message
>> "Your branch is up to date with 'origin/branch_name_here'"
>> was
>> "Your branch is up to date with the *local* branch 'origin/branch_name_here'"
>> it would make it clearer to new users what is happening.
> I would be sympathetic to the above, if you did not say "local" and
> instead say "remote-tracking". 
Can I agree to both aspects? Yes, the git terminology is "remote
tracking branch", but also that the term is very confusing because it is
not actually remote. It is held on the local machine, may not be up to
date, and doesn't check.

>  A local branch is what you can check
> out and grow its history by making a commit while it is checked out.
> Those refs that are updated when you fetch and/or pull from the
> remote repository in order to keep track of the branches they have
> are called remote-tracking branches.
If we need to explain this then perhaps we haven't been good at naming.
It took me a very long while to appreciate it was all backwards as its a
(local) branch that tracks a remote [sort of reverse Polish notation, or
French 'de' notation (OTAN/NATO)].

>
> Because this message is something people see every day when they run
> "git checkout", I am not sure if the extra explanation is warranted
> or merely annoying, as "origin/branch" notation is used sufficiently
> often for the users to grow accustomed 
I think we have a 'continue to be confused' possibility here.

> to seeing it and knowing what
> it is, and after all no user will stay to be a newbie forever.
I'm sure that for all those who have worked with Git from early days are
quite happy with the rtb notation (it was learnt as it developed), but I
feel that newer users who have arrived from always-on central-server
environments are having multiple challenges all arriving at same time,
so aren't learning.
> Another reason why I am somewhat hesitant to endorse the rephrasing
> is because the name of a remote-tracking branch in the real life
> tends to be longer than just 'origin/master'.  

> We must keep the
> message that comes before the name of the remote-tracking branch
> short in order to make it easier to read the message for the users.
True. Perhaps move the "Your" from the beginning of the sentence, to the
end?

"Branch is up to date with your 'origin/branch_name_here'" or
"This branch is up to date with your 'origin/branch_name_here'"

>
> So... I dunno.
--
Philip
(still catching up with the list)
