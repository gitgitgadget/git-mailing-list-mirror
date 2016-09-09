Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA38207DF
	for <e@80x24.org>; Fri,  9 Sep 2016 23:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754929AbcIIXM5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 19:12:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65234 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754666AbcIIXM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 19:12:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C309F3C1C5;
        Fri,  9 Sep 2016 19:12:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vobcQ1ntLNZbFoSy4QF016x7te4=; b=hcCLhJ
        Nex4TiF2wQ1L4M86gkCjSo/ccxqOoqypaksak0MKLBc7itb+iMFAtqCJik1dsAhf
        wj8y2bpRQqL5ip5qradvI08bCjMeg7GSDUkTVouZnUHNfqUDsJSMiiEZbSy+jfHy
        6bUD38OC7rfsNSYaSwRKWNZ2CPAK270QMTb+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f3zQxwCdmWo41v45WEJLEMyIM6tcI9BV
        hVLslNWbRzuRYahsgh1dF3pfiaPCmYQdb6fqmyd3H6JlxuqF4vQEOp04AMMmfk1Z
        19Lvpu4fu2h+Mj8nCFw/0jJR3Ux8VFsXwa0IrhSxnYdWVk8Nwfew/vbR+b1YjEL5
        4iDT/MI4Iy0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BABDB3C1C4;
        Fri,  9 Sep 2016 19:12:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BB733C1C3;
        Fri,  9 Sep 2016 19:12:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     john smith <wempwer@gmail.com>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: How to simulate a real checkout to test a new smudge filter?
References: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
        <b71adc54-2ae6-ef8e-1dca-0883cd617e6e@web.de>
        <CAKmQUfbemaid61xPyvNheLM2jVGXGjiyF_x=NZnxkZ=5wccQ=Q@mail.gmail.com>
        <e17a88cd-2de7-dc84-2262-743e82d8b047@gmail.com>
        <CAKmQUfafCP6ZwUm7Ec5n2PzvNzBHnFWEJL1usMTFB6Ef0m=8pw@mail.gmail.com>
        <xmqqwpik8zy3.fsf@gitster.mtv.corp.google.com>
        <CAKmQUfYCUq=kUTau1-3NjjPVBk6WkP3KdTjgMC8sZtU8h=H4iQ@mail.gmail.com>
Date:   Fri, 09 Sep 2016 16:12:53 -0700
In-Reply-To: <CAKmQUfYCUq=kUTau1-3NjjPVBk6WkP3KdTjgMC8sZtU8h=H4iQ@mail.gmail.com>
        (john smith's message of "Sat, 10 Sep 2016 01:07:00 +0200")
Message-ID: <xmqqd1kc8y6i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0989C02-76E2-11E6-913B-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

john smith <wempwer@gmail.com> writes:

> ... get it.  The problem is that in the scenario presented in my last
> e-mail clean filter is run in the situation which doesn't like a
> checkin to me.  Is `git checkout <PATH>' doing a *checkin*" under the
> hood so that the clean filter is called?  What does actually `checkin'
> mean in Git?  I thought that checkin it's the same as committing a
> file into the repository.

I do not know what Jakub meant.

When we need to see if we need to update a working tree file, and
when we cannot tell if you modified the working tree file since you
checked it out, we may have to run the clean filter (and other
conversions collectively called "convert-to-git") on the contents in
it and see if the resulting blob matches what is recorded in the
index (if they match, there is no need to update the working tree
file; if they don't match, we either report that you have a local
modification, or we overwrite it with the contents, depending on
what operation we are doing for the user).
