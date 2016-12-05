Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EAA81FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 17:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbcLERtt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 12:49:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56090 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752563AbcLERtn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 12:49:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBFA154651;
        Mon,  5 Dec 2016 12:49:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6xU/5zjUHQrEa+Z4B5XUNwodIzM=; b=Uvsg++
        3x45V4OI66snetjjSnl0RNvMUOGbVg/BX0senCOA8E+8WWzeBSyGmrqMIhMHpzPf
        nCI2ydCd/vyMm8uUosI1iK2zqi5J8x6pfXTDSELoaKm1aIA+HZi0WfdEqHfeV9kE
        93FgpfT5HxEdMGQtRAFinUuYeYY9gk2cPjRV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W7QKFSLtApQ5pQ3ZLBpMsXioYYOVaSq6
        3nG0tjt8mKzmrkpOr5h5K00aRIL7EYlF+95lvDsSamhelawC/hXkwG2JwkM0sHtY
        Vg6sJKlsmzyR0jIMLCQkatqAOBFpiipsmKnHS1o0fhSpgiNLPycygHPQVzTEmdHJ
        sBR9qMKg5YM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B41D154650;
        Mon,  5 Dec 2016 12:49:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27A6A5464E;
        Mon,  5 Dec 2016 12:49:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] docs: warn about possible '=' in clean/smudge filter process values
References: <20161203194516.12879-1-larsxschneider@gmail.com>
        <20161205131219.kdq4zafith26vro2@sigill.intra.peff.net>
Date:   Mon, 05 Dec 2016 09:49:39 -0800
In-Reply-To: <20161205131219.kdq4zafith26vro2@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 5 Dec 2016 08:12:19 -0500")
Message-ID: <xmqqfum25kr0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32C309F4-BB13-11E6-A618-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Dec 03, 2016 at 08:45:16PM +0100, larsxschneider@gmail.com wrote:
>
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> A pathname value in a clean/smudge filter process "key=value" pair can
>> contain the '=' character (introduced in edcc858). Make the user aware
>> of this issue in the docs, add a corresponding test case, and fix the
>> issue in filter process value parser of the example implementation in
>> contrib.
>
> Yeah, I just naturally assumed it would work this way, as it's pretty
> standard in our other key=value protocols. But certainly it's reasonable
> to document it (and to keep the t0021 filter as a good example).

There are diplomatic ways and other ways to say the same thing, it
seems, and yours is almost always more diplomatic than mine ;-) 

My knee-jerk reaction last night that I didn't send was "I would
understand if the new test were about quotes or whitespaces, but is
it even useful to make sure that the value can have an equal sign in
it?"


