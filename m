Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B49920A10
	for <e@80x24.org>; Sun,  1 Oct 2017 23:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbdJAXJw (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 19:09:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55734 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750943AbdJAXJw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 19:09:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD7529FEBA;
        Sun,  1 Oct 2017 19:09:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=06/a2UUZN9zWf5LuE7Yesm2bK+E=; b=dylL1r
        uAl2FpOU36nwet0B7ukOpX8pCJ/bbZ9LxVHurJXv4LJqjCmWZOQ6aKl7qjAJno0a
        uAQlCMhy2VUI6pTAWYkCB0yr9krQ7jUOfH1rYaZYxj/MJSb+ecKGIByhQAB6UY7J
        hJAtsrz1eNwRcT1/nf8IMmcwnMJ0dxuwgeayE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CNMAhzjCIdyS8xW3wnCslX330T5Dh/UX
        KxZQGCfeRlZbVfh1QKnJJGZPuSUJCL6LPIyiAEVZWB2AQ09tt9JMJcs2AKsoMW3J
        up71qpUtXIA0og1tdth7lo3eFn8XF1WtW+YL/RCpdAqbMFFYifqk/DubL7q48yiU
        yVfqKV7c3zQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6EEE9FEB9;
        Sun,  1 Oct 2017 19:09:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1CCA59FEB7;
        Sun,  1 Oct 2017 19:09:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2017, #06; Fri, 29)
References: <xmqqlgkyxgvq.fsf@gitster.mtv.corp.google.com>
        <5f7dbd81-ae27-c3a2-a14d-2832f71db1e9@gmail.com>
Date:   Mon, 02 Oct 2017 08:09:48 +0900
In-Reply-To: <5f7dbd81-ae27-c3a2-a14d-2832f71db1e9@gmail.com> (Derrick
        Stolee's message of "Fri, 29 Sep 2017 09:08:42 -0400")
Message-ID: <xmqqy3outqgz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A01DD458-A6FD-11E7-9EB9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/29/2017 12:34 AM, Junio C Hamano wrote:
>> * ds/find-unique-abbrev-optim (2017-09-19) 4 commits
>>   - SQUASH???
>>   - sha1_name: parse less while finding common prefix
>>   - sha1_name: unroll len loop in find_unique_abbrev_r()
>>   - sha1_name: create perf test for find_unique_abbrev()
>
> I'll re-roll my patch on Monday if reviews have stabilized. I think I
> understand your comments this time (especially around 32-bit ints).

Will look forward to seeing them.

> What does "SQUASH???" mean? Is that why there are three meaningful
> commits in this note, despite my five-commit patch? Would you like me
> to squash the commits in v3?

These are found on 'pu' branch; you can check output from

    git log --oneline --first-parent origin/master..origin/pu

to see where ds/find-unique-abbrev-optim topic was merged, e.g.

    $ git log --oneline --first-parent origin/master..origin/pu | grep ds/fi
    d8c0323166 Merge branch 'ds/find-unique-abbrev-optim' into jch

and you'll find these four commits with:

    $ git log -p origin/master..d8c0323166^2

I knew you had more patches, but I looked at the first three, found
a few glitches that I knew will have to be rerolled, and stopped
looking at the remainder of the series at that point (not because I
felt the topic was helpless, but because I needed to switch my
attention to other topics), so that is why the only three from the
beginning is queued there.  Then I found that with these three, the
tree does not even compile, but I wanted to make sure that 'pu' at
least builds before I push it out, so I created another commit on
top of these three patches as a fix-up to make it compile, so that I
can merge the topic to 'pu'.  This is done in the hope that it would
help contributors more (by showing a small fix that needs to be
squashed into relevant patches when the topic is updated and
re-sent) than plain dropping a topic that does not compile or pass
test on the floor.

So that is what a SQUASH??? commit at the tip of some topics mean.

Thanks.




