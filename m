Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9C42035F
	for <e@80x24.org>; Fri, 28 Oct 2016 22:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761920AbcJ1WZZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 18:25:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51446 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755086AbcJ1WZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 18:25:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3A4B4ACF9;
        Fri, 28 Oct 2016 18:25:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rdGI6eJy2q8wxDU2dpsrdDMgLFo=; b=O9vsvE
        SO+Q6lyrayrCs6gSSpfclVKGwzFaDBtLY3cst8YeVx1jBvyHDObKjmBN3JanO2cr
        8O1NNrULzQ/Ts56Y0pNH5VE1StcPclmQSeW41SsD+vwU3jDWpQQY5T/Oc1BMlX6g
        dyB5nJyYgpaUU6Wcs081+yd4tQxFVhVcHn+ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jSjKOvRa4iFYuinJy6BfAWHNkCvLI9Xx
        mCIUeH8jlKbAYp5BxSYOxaeRWNkFmo24Rs7pNJ0OJ69ft8t9lDZNS2MOGujakkU+
        lEeTOXjTsLIGe3KjQUq5fmA5M23LcPmvle84Y1HRZ6k9ns6eo9MX7WDJxCPLj8pw
        WmAXxfqlwY0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9DB54ACF8;
        Fri, 28 Oct 2016 18:25:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4085F4ACF7;
        Fri, 28 Oct 2016 18:25:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCHv2 27/36] attr: convert to new threadsafe API
References: <20161028185502.8789-1-sbeller@google.com>
        <20161028185502.8789-28-sbeller@google.com>
        <xmqqinscxh5g.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kayzZOXpRgwREahKAAj+W6M-c2m6dYf5gL3RCxE5+5zJw@mail.gmail.com>
Date:   Fri, 28 Oct 2016 15:25:21 -0700
In-Reply-To: <CAGZ79kayzZOXpRgwREahKAAj+W6M-c2m6dYf5gL3RCxE5+5zJw@mail.gmail.com>
        (Stefan Beller's message of "Fri, 28 Oct 2016 15:08:44 -0700")
Message-ID: <xmqqbmy4xga6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AED4962-9D5D-11E6-9789-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Oct 28, 2016 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Probably this needs to be squashed in, now the MinGW discussion has
>> settled.
>
> I was about to propose this (and resend it non-rebased).
>
> So I do not resend, but rather ask you to squash this patch?

That's OK.  I've queued a "SQUASH???" separately for now and if we
need futher changes, you may want to resend, but I can locally
squash before merging it down to 'next' if it turns out that there
is no more changes necessary.

Thanks.
