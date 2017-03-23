Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DBBC20958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbdCWTBl (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:01:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58785 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752106AbdCWTBk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:01:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85BB3669B8;
        Thu, 23 Mar 2017 15:01:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fhKMTEU5j0SkkTCZYZEnWqrSrxM=; b=lOSfVl
        rV1j9G9cE6zAqRG/Tkm8roaHkRJDVbiLlKmD21qeL/274k9ltpKNNferEUp82Tm+
        RRHG9c5tlC68zk/SAZf7HwTMYY2DuKWTZt7xklYHynvQRzk46mNkunGJfqz0nW6c
        aZDKsD0h3wAhbvmVKmoS+dBopQut2X1xV/tHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XcYs74nXk4XyZDRwTvo508o1aPHoAxdP
        XpOnwbSQcVDpm9HbNFtY5e06nf3XVXjBsgvCTWEl50h+j+wDMmkPVm3/y/Ng5KUL
        a2EvC5R4QXlb7gvuxR5oWB+CoBsj4DQ3DSQ+F5WLvgcFYUaLrTON3z1HOsjv9Css
        C2FCu3kGfL8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E32C669B7;
        Thu, 23 Mar 2017 15:01:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD107669B6;
        Thu, 23 Mar 2017 15:01:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch doc: Change `git branch <pattern>` to use `<branchname>`
References: <20170323120326.19051-1-avarab@gmail.com>
        <xmqq1stoexmb.fsf@gitster.mtv.corp.google.com>
        <5d04c82c-45a4-5d5e-0317-511587ee3474@ramsayjones.plus.com>
Date:   Thu, 23 Mar 2017 12:01:36 -0700
In-Reply-To: <5d04c82c-45a4-5d5e-0317-511587ee3474@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 23 Mar 2017 17:44:07 +0000")
Message-ID: <xmqqo9wrddgv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 245A6794-0FFB-11E7-9387-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> I am not sure if it makes that much sense to have that sentence here
>> in the first place (after all, it is describing a behaviour of a
>> mode that is *not* the list mode), but I guess that it may be a
>> common mistake to forget to specify "-l" while asking for branches
>> that match the pattern?  If we were writing this today from scratch,
>> I would perhaps write something entirely different, e.g.
>> 
>> 	--list::
>> 		List branches.  With optional <pattern>... at the
>> 		end of the command line, list only the branches that
>> 		match any of the given patterns.  Do not forget '-l'
>> 		and say "git branch <pattern>", as it will instead
>> 		try to create a new branch whose name is <pattern>,
>> 		which is a common mistake.
>
> Hmm, but with git-branch -l means --create-reflog not --list.
>
> I have make the mistake of using -l rather than --list several
> times ... :D

That too.  With "Do not forget '--list'..." and it will make it
correct again ;-).
