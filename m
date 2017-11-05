Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48AE320450
	for <e@80x24.org>; Sun,  5 Nov 2017 06:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbdKEG2w (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 01:28:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57259 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750782AbdKEG2v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 01:28:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38F25A3AA9;
        Sun,  5 Nov 2017 01:28:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/qo2iQbfMBaVZWivfDcUFW6YRSk=; b=L0NTsD
        cccUBfs0C4s1wNwTaoNMp0mw0hmE65+LrmQSfvTsTtOilGxIJY6+xBZeJtJBH6gn
        g6aTIggOHLLrxUaxUenr32DhLXorL+GPT2yyCi3dRCGcr0vCZMbSyeGIaU/1seNV
        aMKbXWNQbL9JcvPOFUsB6HBwG304YmthKr2hI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i8hPaN8FxAd5ZYAYQlBtyQEdDs/9IePw
        WVDtVJtRyknttVYuWg3b2loAd8LvFFpe3FqTqkUXoKaAnB3HFxhFI/TF3k5CCh3V
        mk3/PNqWYyLweyEwrDe+ccrsOxBj0FO6bL5KNkH9W5r+tlstjwxSxH6sAamU7/V2
        NZDLMhu9hQc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FDA1A3AA8;
        Sun,  5 Nov 2017 01:28:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 94377A3AA7;
        Sun,  5 Nov 2017 01:28:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Stefan Beller" <sbeller@google.com>, "git" <git@vger.kernel.org>,
        "Kevin Daudt" <me@ikke.info>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
References: <20171028004419.10139-1-sbeller@google.com>
        <20171031003351.22341-1-sbeller@google.com>
        <20171031003351.22341-7-sbeller@google.com>
        <xmqqinevzvel.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com>
        <xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYC4=rDSWC7WCGVL4n4OC8BpvMJFwxx+LV9GqoGnSHFSA@mail.gmail.com>
        <xmqqinetsayr.fsf@gitster.mtv.corp.google.com>
        <xmqq375xs3zr.fsf@gitster.mtv.corp.google.com>
        <BFE987312194406AAAEA8DAC7EC5BFF5@PhilipOakley>
Date:   Sun, 05 Nov 2017 15:28:49 +0900
In-Reply-To: <BFE987312194406AAAEA8DAC7EC5BFF5@PhilipOakley> (Philip Oakley's
        message of "Sat, 4 Nov 2017 21:15:18 -0000")
Message-ID: <xmqqlgjlkzmm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 965AA2F6-C1F2-11E7-97A3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> Is this not also an alternative case, relative to the user, for the
> scenario where the user has an oid/sha1 value but does not know what
> it is, and would like to find its source and type relative to the
> `describe` command.

I am not sure what you wanted to say with "source and type RELATIVE TO
the describe command".

The first thing the combination of the user and the describe command
would do when the user has a 40-hex string would be to do the
equivalent of "cat-file -t" to learn if it even exists and what its
type is.  With Stefan's patch, that is what describe command does in
order to choose quite a different codeflow from the traditional mode
when it learns that it was given a blob.

> IIUC the existing `describe` command only accepts <commit-ish> values,
> and here we are extending that to be even more inclusive, but at the
> same time the options become more restricted.

Do you mean that the command should check if it was given an option
that would not be applicable to the "find a commit that has the
blob" mode, once it learns that it was given a blob and needs to go
in that codepath?  I think that would make sense.

> Or have I misunderstood how the fast commit search and the slower
> potentially-a-blob searching are disambiguated?

I do not think so.  We used to barf when we got anything but
commit-ish, but Stefan's new code kicks in if the object turns out
to be a blob---I think that is what you mean by the disambiguation.
