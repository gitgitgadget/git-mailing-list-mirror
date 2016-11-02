Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D989720193
	for <e@80x24.org>; Wed,  2 Nov 2016 12:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbcKBM5R (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 08:57:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57997 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752483AbcKBM5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 08:57:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A08F74A695;
        Wed,  2 Nov 2016 08:57:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QIl8vznHnjXvZRbHvMq8gpi9KdA=; b=Bk6E/m
        Ht+ZrRV8LvencbdWpABUeysyAHEaxoRim2gSMepblc1F2Uu1q2zA0rBvmdq7xqgU
        9wDro6rd26+yMDAun5PKSePPGjTuti/veYKIItSeN27CEVijs4Ey4bXiShqpwkvx
        hHWugVc6rSerggulXaTojA8l+oIzEiEWXqXt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nh+E+w2X9SqtYjqXjP1vPUJVWY/OGcWO
        RDbGCT/2MzjXcY2mga6V4+onuIA19jegEWrV8Nmh0V1MF+cKUQwvEH9MWpnwFhFd
        eg+2AesLMT0ePznbCGBWbW/R8+BM/PiZjEzUX3sbx2Z1O3BW6EHF+Y18KoAOqOgl
        5NcUcML7Bew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95B264A694;
        Wed,  2 Nov 2016 08:57:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17B8E4A693;
        Wed,  2 Nov 2016 08:57:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611021054030.3264@virtualbox>
Date:   Wed, 02 Nov 2016 05:57:12 -0700
In-Reply-To: <alpine.DEB.2.20.1611021054030.3264@virtualbox> (Johannes
        Schindelin's message of "Wed, 2 Nov 2016 10:57:19 +0100 (CET)")
Message-ID: <xmqqy412dopj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E043869E-A0FB-11E6-B74F-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 31 Oct 2016, Junio C Hamano wrote:
>
>> * jc/git-open-cloexec (2016-10-31) 3 commits
>>  - sha1_file: stop opening files with O_NOATIME
>>  - git_open_cloexec(): use fcntl(2) w/ FD_CLOEXEC fallback
>>  - git_open(): untangle possible NOATIME and CLOEXEC interactions
>> 
>>  The codeflow of setting NOATIME and CLOEXEC on file descriptors Git
>>  opens has been simplified.
>
> This branch (in particular, the "use fcntl(2)" one) breaks the build on
> Windows. Until this breakage is resolved, I won't be able to see (nor
> report) any test breakages in `pu`.

Thanks for a heads-up.  Anything in 'pu' won't be of importance
until 2.11 final, so please don't worry too much about it.  Instead
please do make sure the tip of 'master' is OK.

Having said that, an incremental update or replacement to help
preparing it for post 2.11 final is appreciated ;-)

FYI, I may be offline for a few days.
