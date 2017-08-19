Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0AB1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 21:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbdHSVH7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 17:07:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61624 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751631AbdHSVH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 17:07:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E93CFAC2A0;
        Sat, 19 Aug 2017 17:07:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/1Ml1JQbsvh2bIDZXBfAqhH40H0=; b=UiqKEL
        UE7aoeW23jvmmDHc41s3XjPLJKfYj2AK5BjSCfyBJQWO58hEbIqyQ0zCs27JQNSi
        nWFWwjo6/ZDyUFpzlImi1QFgH1b7aWHCoUoz6idfyyGEUZ5+2vlLNakEb/UtW79K
        2OpXAWEPNaaCMRraxAB/BggkpCwpSISrOBH1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D6xd0S7RIIKO4joMfUznOLXZkn9R/Uex
        Ph+vSjg+oVv63w70tBtxVT94nn7NBt3kK1DaIx6Xtv+ap1frmGJfBCxDS7yH5ioD
        f/zPNgDfjl8dwvIRISfPWSl2nGKKXHvM8rmh8F0B07f5vQBQupzCRcuLG11eGdxo
        a1rrbPAKsE4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E12FAAC29F;
        Sat, 19 Aug 2017 17:07:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F58CAC29C;
        Sat, 19 Aug 2017 17:07:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] stash: add test for stash create with no files
References: <20170819201326.6872-1-joel@teichroeb.net>
        <xmqqpobr8ego.fsf@gitster.mtv.corp.google.com>
        <CA+CzEk98Tg_jyteZp7SGTchDNjP8FZFvHNXfvisg1XGgsT0vvg@mail.gmail.com>
Date:   Sat, 19 Aug 2017 14:07:48 -0700
In-Reply-To: <CA+CzEk98Tg_jyteZp7SGTchDNjP8FZFvHNXfvisg1XGgsT0vvg@mail.gmail.com>
        (Joel Teichroeb's message of "Sat, 19 Aug 2017 14:00:36 -0700")
Message-ID: <xmqqh8x38dwb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 756A696C-8522-11E7-B7D9-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> On Sat, Aug 19, 2017 at 1:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Are you documenting an existing breakage?  Are you extending test
>> coverage for some breakage we recently fixed without adding tests to
>> ensure that the fix will stay unbroken?  Are you planning to touch
>> the implementation (perhaps to add yet another feature that uses
>> some existing code) and adding new tests in advance to avoid breaking
>> the existing code?  Some other motivation?
>>
>
> I was just too lazy to write a cover letter, and thought these would
> make sense on their own. I'll make sure to include a cover letter next
> time.
>
> I just ripped them out of my patch series on implementing stash as a
> builtin[1]. Since I haven't had time, I figured I could at least get
> the additional tests I wrote into the codebase.

OK, so it is the third one among my random 4 choices ;-)  

They do look sensible; I did not want to make sure they are not
duplicates myself (i.e. a new test that makes sense may not be an
undesired addition if the only effect it has is to eat more cycles
without improving test coverage).

Will queue.  Thanks.

> The tests mainly expand coverage of git stash, covering a few critical
> error cases that didn't have tests.
>
> [1] https://public-inbox.org/git/20170608005535.13080-1-joel@teichroeb.net/
>
