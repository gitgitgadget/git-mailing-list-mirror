Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3E020D09
	for <e@80x24.org>; Mon, 17 Apr 2017 00:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756951AbdDQAiw (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 20:38:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62688 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756803AbdDQAiv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 20:38:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BA9B8AD1E;
        Sun, 16 Apr 2017 20:38:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gspI2crTn7nw
        xBRFh26leI1Mzi4=; b=o+nPVEc10d6OBDv7WFeYNxTl7cfebN/vZsJs8Vmr+jXM
        ArdgLtmh1mxzJXIEPp/VHJf+8qTXIz9s2oAlxqTyF6y/tW3kdjHK2he05zAwITXc
        yWRF5xsEYxS7cwlFn2h10eQhVG0fhCar1ssVD/n5FLkwaaE1iJQVLZYMOrV5Y+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=V6R5f+
        vEhnrW3nBJVnyEKKXiBA47XXU3V/9fU4miA3zj0XolcC7AtgHqgU7dEK89cD9Iwv
        WLAkCsLlYuqv9Vw272KC5zVjmZrSdIi64ujz5jmFjW7z2MOp5zrd095H0ZCaH3VM
        tLzMKv8eW+HxFAQgjqP77N7kmB28bsbup+CEw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 635868AD1D;
        Sun, 16 Apr 2017 20:38:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C64238AD1C;
        Sun, 16 Apr 2017 20:38:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Fred .Flintstone" <eldmannen@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: --format=json
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
        <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
Date:   Sun, 16 Apr 2017 17:38:48 -0700
In-Reply-To: <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 8 Apr
 2017 18:26:20
        +0200")
Message-ID: <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 396C45F8-2306-11E7-84F9-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Apr 8, 2017 at 6:07 PM, Fred .Flintstone <eldmannen@gmail.com> =
wrote:
>> $ git log --format=3Djson
>> [{
>>     "commit": "64eabf050e315a4c7a11e0c05ca163be7cf9075e",
>>     "tree": "b1e977800f40bbf6de906b1fe4f2de4b4b14f0fd",
>>     "author": "Tux <tux@example.com> 1490981516 +0200",
>>     "committer": "Tux <tux@example.com> 1490981516 +0200",
>>     "message": "This is a test commit",
>>     "long_message": "This explains in more details the commit"
>> }]
>>
>> This would make it easy to parse the output.
>
> The git-log command isn't plumbing that's meant for machines, but the
> git-for-each-ref command is what you're most likely looking for.

They are apples and oranges.  log is about traversing the history.
"for-each-ref" is about listing the tips of refs.  It doesn't and it
shouldn't traverse the history.

The plumbing to use when you want to reimplement "git log" lookalike
is "rev-list".
