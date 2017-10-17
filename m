Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94606202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 07:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756918AbdJQHFq (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 03:05:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59927 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753814AbdJQHFp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 03:05:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6058B3B83;
        Tue, 17 Oct 2017 03:05:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4QijcbHymSDG5PqwNeIBTlCrSt8=; b=Ub2vLt
        OedqUbVNnFevsVQZ77YSia0p1KiOC9pQ04cvztxdd0UcI+mbNW7Qi8whl52bqvCF
        KANxSo4HWvZMyNFmbS4dSsFzC4BkAisWTWH+UsZdk5LqCuXv/nkZMsHdv4qSyShF
        wWbb+tPC0yLXU7mCpbDAUpfgZQBDIMNunSULU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kBrjktXI9DkK4kLQdO9vMJGiUl+dJTV/
        UsEP0I24CIV8fBoit9Cc/fcqAcgMvK03EZ5Susg4Im10VXAH9ay3tC9grBXV9xWH
        qS1lL/vd0PCQYBv/TY8BpbhA4CC3VrPgFUaqWCRKf10VogBDs7sd9iLS/2FWqt1u
        DQpk1Mto+Vg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DECE6B3B82;
        Tue, 17 Oct 2017 03:05:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E065B3B81;
        Tue, 17 Oct 2017 03:05:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
        <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
        <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
        <20170717172709.GL93855@aiede.mtv.corp.google.com>
        <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
        <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
        <20171017044111.ahe4eiepvokecnkr@aiede.mtv.corp.google.com>
Date:   Tue, 17 Oct 2017 16:05:43 +0900
In-Reply-To: <20171017044111.ahe4eiepvokecnkr@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Mon, 16 Oct 2017 21:41:11 -0700")
Message-ID: <xmqqinfentiw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97FB9176-B309-11E7-AC8F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> And in that spirit, I think the patch you replied with aims to go in
> the right direction, by providing the core functionality when in a
> repository while avoiding breaking such a script outside of one
> (though I do not understand it fully yet).

Given that, is it safe for me to ignore this earlier one

> For what it's worth, I don't agree with this repurposing of
> "check-ref-format --branch" at all.

as reacting to the patch without reading what it does?

>>                                        (e.g. a wrapper to "git
>> clone" that wants to verify the name it is going to give to the "-b"
>> option), and a check desired in such a context is different from
>> (and is stricter than) feeding refs/heads/$name to the same command
>> without the "--branch" option.
>
> Can you say more about this example?  E.g. why is this hypothetical
> wrapper unable to rely on "git clone -b"'s own error handling?

If I have to guess what you meant, perhaps the Porcelain wanted to
diagnose bad parameter that would be rejected _before_ letting clone
spend cycles and possibly network bandwidth?

But this was my way of rephrasing an earlier example you used while
objecting to Peff's change

    For example, if you have a script with an $opt_branch variable
    that defaults to "master", it may do

            resolved_branch=$(git check-ref-format --branch "$opt_branch")

    even though it is in a mode that not going to have to use
    $resolved_branch and it is not running from a repository.

so my answer to the question in the message I am directly responding
to would be "You tell me." ;-)

> --symbolic-full-name seems like a good fit.  Do you remember why
> check-ref-format was introduced instead?

It really serves two purposes, and at this point, I do not think it
really matters why it also does the @{-1} expansion as well as name
validation.  604e0cb5 ("Documentation: describe check-ref-format
--branch", 2009-10-12) happened 8 years ago, and since then it has
been advertised long enough as if the 80% primary purpose of "c-r-f
--branch" were to expand @{-1} to a branch name; even though the
text hints that it also does the usual checks, by definition
validation of the result of expanding @{-1} ought to succeed; after
all that was the branch we _were_ on ;-).

