Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526601FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 15:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761750AbdAIPFX (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 10:05:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61647 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1761697AbdAIPFS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 10:05:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44AA25B9E4;
        Mon,  9 Jan 2017 10:05:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZSrGg9hmtLOjsRPDJDuYR7nS8NY=; b=B1ltG3
        FGnYAGNl9FGM6pZKZZGKcZbGhwX9ehD1JItOYHyURbVtDfIzO9uBm08V5T6eM4aX
        ABVwFZqwIdK00TVDFF6PG/60NogDZ0kvM389FPWHrcrnqw2guaDzPWKuIXjIziyN
        UMkeTdy7Phnivz6zM01sJAAtsCOA0cHcSvYHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pDVwvo70ylUTq/dS8HtYHmqjpbRKRKSi
        xcyhXAUpCu9MBg6fmt1a9BtKYQin1ECEtNLWqw30xv8LqJRgnsfQhJh8JOp0xKTn
        9xKpi1kjiK3fTb4qO3i3GBXXbjJ+VCIoOd22F6fJ/I4Fg+8lXgSMhEyqt0vGKTz6
        srC7clnnamo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CA9F5B9E3;
        Mon,  9 Jan 2017 10:05:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DBBD5B9E2;
        Mon,  9 Jan 2017 10:05:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (preview)
References: <xmqqmvf0yke0.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701091228460.3469@virtualbox>
Date:   Mon, 09 Jan 2017 07:05:15 -0800
In-Reply-To: <alpine.DEB.2.20.1701091228460.3469@virtualbox> (Johannes
        Schindelin's message of "Mon, 9 Jan 2017 12:36:52 +0100 (CET)")
Message-ID: <xmqqmvf0uvdg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0782128C-D67D-11E6-B881-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Sun, 8 Jan 2017, Junio C Hamano wrote:
>
>> * js/difftool-builtin (2017-01-08) 4 commits
>>  - t7800: run both builtin and scripted difftool, for now
>>  - difftool: implement the functionality in the builtin
>>  - difftool: add a skeleton for the upcoming builtin
>>  - git_exec_path: avoid Coverity warning about unfree()d result
>> 
>>  Rewrite a scripted porcelain "git difftool" in C.
>> 
>>  What's the doneness of this topic?
>
> There was only one bug report since the first iteration, and it has been
> fixed as of v4.

This is more RFH than FYI, but some topics in flight add more tests
to t7800 and with everything merged, the test breaks at the tip of
'pu' as of tonight (eh, technically last night, as I ended up not
sleeping due to jetlag), even though each individual topic passes
it.  It _might_ indicate a problem with this topic, or it may merely
be a biproduct of a mismerge.

