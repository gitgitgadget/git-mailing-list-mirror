Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 346081F991
	for <e@80x24.org>; Thu,  3 Aug 2017 21:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdHCVHu (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 17:07:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60697 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751746AbdHCVHu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 17:07:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A42F8BECE;
        Thu,  3 Aug 2017 17:07:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q7esaaMK4zXSBu4MMicHaJnxa8E=; b=D5y5em
        gh990yNBZwWK6RqtmmduTJB1pvdKEzD9ErxP/XZhhxt8JYVnOpfwpx07BxYDJyeK
        GI+ixdAgIY5G2qc+gdjP1OW2Xp17mIOjDitU9WwBFXyjAd+l4HdmC9hW11s5V3bC
        vRFtNIeKAvrI5ws9M9IZACAyjbyR1Mx6iktMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DSKYgVqaOO6EqGxERcUzzeZGxca5mqCH
        QnGhzIVYiWb3M5UJJZrOfWdSiLsfEvulVYSKRj+WyD2/SfSYioUM4HsXTJdu6mWw
        IGTQdEbo9KVa1JcVbiQdqyYVgjcguBknXTqHdpTBqxyV9IxFMSdiGM97vj6ChkaN
        mPrCHL8Rbsc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35A358BECC;
        Thu,  3 Aug 2017 17:07:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9891E8BECB;
        Thu,  3 Aug 2017 17:07:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com>
        <232547ab-3b87-debc-36a4-d2285ec10a06@ramsayjones.plus.com>
        <CALiud+nm9wu4rBY6zBXmenJj_0Mn7xeU_FAvSdn4fdH+q--Jag@mail.gmail.com>
Date:   Thu, 03 Aug 2017 14:07:47 -0700
In-Reply-To: <CALiud+nm9wu4rBY6zBXmenJj_0Mn7xeU_FAvSdn4fdH+q--Jag@mail.gmail.com>
        (Sahil Dua's message of "Thu, 3 Aug 2017 22:26:10 +0200")
Message-ID: <xmqqd18cweak.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDCB58EA-788F-11E7-AC08-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

> Ah! I had skipped this reply from Ramsay earlier.
>
> On Tue, Aug 1, 2017 at 1:36 AM, Ramsay Jones
> ...
>>>  I personally do not think "branch --copy master backup" while on
>>>  "master" that switches to "backup" is a good UI, and I *will* say
>>>  "I told you so" when users complain after we merge this down to
>>>  'master'.
>>
>> I wouldn't normally comment on an issue like this because I am
>> not very good at specifying, designing and evaluating UIs (so
>> who in their right mind would listen to me). ;-)
>>
>> FWIW, I suspect that I would not like using this interface either
>> and would, therefore, not use it.
>
> Does that mean you'd use it when "branch --copy feature-branch
> new-feature-branch" in the case when you would want to start working
> on a new branch (to modify or experiment with your current feature
> branch) on top of a branch keeping intact all the configuration and
> logs?

I am not Ramsay, but your choice of branch names in your question,
i.e. "branch --copy feature new-feature", is what we do not agree
with in the first place, especially when we are *on* the "feature"
branch.

We view "copy A B" as a way to make a back-up of A in B.  I.e. We
want to keep working on A, but just in case we screw up badly, make
a backup copy of A in B, so that we can recover by a "branch --move
B A" later if needed.  So touching B is the last thing we want to do
after "copy A B" operation---hence we do not want to switch to B.

That is not to say that you are wrong to wish to create a new
branch, check it out and start working on it with a single command.
We already have such a command all Git users are accustomed to,
which is "git checkout -b new-feature-branch feature-branch".  

That existing command does not copy things other than the commit
object name from "feature-branch", and I do not think it should by
default.  But I do not think it is wrong to extend it with a new
option (think of it as "checkout --super-b" ;-) to copy other things
like branch descriptions etc.

So from that point of view, your new feature conceptually fits a lot
better to "git checkout", and does not belong to "git branch".  That
is why I do not think "git branch --copy A B" while you are on A
should check out B after creating the copy.
