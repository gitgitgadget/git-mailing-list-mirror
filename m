Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3917B1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 20:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeAJUCx (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 15:02:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50062 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeAJUCx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 15:02:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F7C9D18C2;
        Wed, 10 Jan 2018 15:02:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5Ml+kTFf8KXe
        2fR/c70/fOQu8uI=; b=p2oU7Ye2EpQHy3Eq+HCKQ+Nynnsm5U13M9/Ipc0pdb8v
        +lSQbkjQgx1GELCD53PkhCJW8t5GPCkk+rxpTKA0dWdKvznbUPQ1MRTC3SoLoY0x
        FFzLtuOxzgLFtegR5u832M4TbVxOvyiQKjx4QJQtZAkPWGAWjJsZslZ4MAC6xUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oDjnZw
        IJnj7oXpjL1ytm5Yc9LaOez/gb2L8onf7MyLISPAVi5o7M3S/qp612SbK5wq8Y/H
        q/qt04bBUC1quRfHuzB2LPcPUD62sdwVTak58/mZ7pKg+/EVlQhNa8w4fmhPDaYF
        MZV+ZrIkmvvUIjJamGnOHFZdJL6aFjV8veusU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48B2CD18C1;
        Wed, 10 Jan 2018 15:02:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD74AD18C0;
        Wed, 10 Jan 2018 15:02:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2018, #02; Tue, 9)
References: <xmqqa7xm38wc.fsf@gitster.mtv.corp.google.com>
        <87vaga9mgf.fsf@evledraar.gmail.com>
Date:   Wed, 10 Jan 2018 12:02:50 -0800
In-Reply-To: <87vaga9mgf.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 10 Jan 2018 08:56:00 +0100")
Message-ID: <xmqqo9m11nyt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D2592BC-F641-11E7-81DC-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jan 09 2018, Junio C. Hamano jotted:
>
>> * ab/wildmatch-tests (2018-01-04) 7 commits
>>   (merged to 'next' on 2018-01-09 at 09f0b84098)
>>  + wildmatch test: create & test files on disk in addition to in-memor=
y
>>  + wildmatch test: perform all tests under all wildmatch() modes
>>  + wildmatch test: remove dead fnmatch() test code
>>  + wildmatch test: use a paranoia pattern from nul_match()
>>  + wildmatch test: don't try to vertically align our output
>>  + wildmatch test: use more standard shell style
>>  + wildmatch test: indent with tabs, not spaces
>>
>>  More tests for wildmatch functions.
>>
>>  Will cook in 'next'.
>
> Please don't merge it down for now.

Oops, the above entry in the "What's cooking" report is totally
bogus.  It is not merged to 'next' yet, and 09f0b84098 does not
exist in the public history of the project.

What happened was that I rewound 'next' after making a trial merge
before pushing the result out.  I updated the "What's cooking" report
while the trial merge was in 'next', which I should have redone.

>> * ab/perf-grep-threads (2018-01-04) 1 commit
>>   (merged to 'next' on 2018-01-09 at 8fe1d71894)
>>  + perf: amend the grep tests to test grep.threads
>>
>>  More perf tests for threaded grep
>>
>>  Will cook in 'next'.
>
> Re: the concern raised in xmqqa7xsaqki.fsf@gitster.mtv.corp.google.com =
I
> think it makes sense to just document (and I can do that if you agree)
> that:
>
>     test_expect_success SOME_PREREQ,$SOME_OTHER_PREREQ,$ANOTHER_ONE [..=
.]
>
> Will work as far as prereqs goes even though the variables might be
> empty. It's much less verbose than the proposed alternative, and easy t=
o
> support.

OK.

>>  Will [cook in|merge to] 'next'.
>
> Refresh my memory, that means merge down post-2.16.0 at this point,
> right?

After -rc1, anything merged to 'next' will by default stay there
until the final.  Hotfixes will be merged to 'next' and (unless I
forget) will be marked as "will merge to 'master'" when that
happens, so that we will have them in the final.
