Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37BCF20A40
	for <e@80x24.org>; Fri, 24 Nov 2017 06:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbdKXGXI (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 01:23:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65284 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751507AbdKXGXH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 01:23:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1EEFACA28;
        Fri, 24 Nov 2017 01:23:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IxSR1FHUUBOgR7NXoTgYH59rOyk=; b=sW4GOv
        xcycJWyvSWkwg1npv/PA512NenLHjPBprlWLJf6YufOqjBYevdezRUGqB6KoggYU
        wGDjV9FePZCRrcDEXLSBMYZ3YfgxKp9qw/NmvsVD8d6T39E4f8/m15VN7UwtU9kG
        Dvh3zEyRtLAeiIVvvC9p5Q50xGt2o7sy3CCHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cXtSIJFZY/Iegoc+dmXdW4Aj8h09dqH4
        72q/KZoishOusTOBkUjqDs9+9KPDcMNAc7MC/NFpo9ZEoqXdG+KuKpXzXUYMR+8w
        hEQ/nLWPKX4Nu+UaZazLmP6kgA4g2taVcUs6Q/kelcMxlJPTETStGDtn7UkjCNgi
        xV7rcmrM0j4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A85DACA27;
        Fri, 24 Nov 2017 01:23:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DE74ACA26;
        Fri, 24 Nov 2017 01:23:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] doc: tweak "man gitcli" for clarity
References: <alpine.LFD.2.21.1711220701070.12544@DESKTOP-1GPMCEJ>
        <xmqqd148p8v4.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 24 Nov 2017 15:23:04 +0900
In-Reply-To: <xmqqd148p8v4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 24 Nov 2017 14:02:23 +0900")
Message-ID: <xmqqo9nsnqk7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EED62C42-D0DF-11E7-B7BE-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> - * Without disambiguating `--`, Git makes a reasonable guess, but errors
>> -   out and asking you to disambiguate when ambiguous.  E.g. if you have a
>> -   file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
>> + * In cases where a Git command is truly ambiguous, Git will error out
>> +   and ask you to disambiguate the command.  E.g. if you have a file
>> +   called HEAD in your work tree, `git diff HEAD` is ambiguous, and
>>     you have to say either `git diff HEAD --` or `git diff -- HEAD` to
>>     disambiguate.
>>  ...
>
> The above "truly" is misleading by giving the information the other
> way around.  We ask to disambiguate when we cannot readily say the
> command line is *not* unambiguous.  That is different from asking
> when we know it is truly ambiguous.
>
> Also see <xmqq7eugqykq.fsf@gitster.mtv.corp.google.com> if you want
> to know more.

So, here is my attempt (other than "the original reads clear enough
to me, so I am not sure what's there to improve"):

    When the command line does not have the disambiguating `--`, Git
    needs to find where the revisions end and paths begin.  In order
    to make sure it does not guess incorrectly, Git errors out when
    it cannot cheaply determine that there is no ambiguity, and asks
    you to disambiguate with `--`.  If you have a file whose name is
    HEAD, "git diff HEAD" gets an error for this reason; you need to
    say "git diff -- HEAD" or "git diff HEAD --" to disambiguate.

    Also, if you do not have a file whose name is Nakefile and it is
    not a branch or tag name, "git log Nakefile" is flagged as an
    error.  If you know there used to be a file called Nakefile but
    not in the current working tree, "git log -- Nakefile" is how
    you tell Git that you did not make a typo and you mean to find
    commits that touch the path.

I briefly considered the following as a more technically correct
description for "cheaply determine", but I am not sure if we want to
go down to that level of detail:

    ... when it cannot determine that every argument before one
    point on the command line names a revision and does not have a
    file with that name in the working tree, and every argument
    after that point does have a file with that name and cannot be
    interpreted as a valid revision.

>>  When writing a script that is expected to handle random user-input, it is
>>  a good practice to make it explicit which arguments are which by placing
>> -disambiguating `--` at appropriate places.
>> +a disambiguating `--` at appropriate places.

I forgot to mention in my earlier message, but this part of the
patch is obviously good ;-)
