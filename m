Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C711F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 01:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391173AbeKVLnJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 06:43:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63936 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbeKVLnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 06:43:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9CBB116660;
        Wed, 21 Nov 2018 20:06:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Ehwu1u9YYvIzQjJTy59CJfpTqk=; b=FxI9uj
        BXjW4fWIHekipxIXw6+33jgljJb+uPTDPtn4SCCWVc8CJjZ9c+dTF+X2mrnsCI8H
        CQqCsJhxVLBY9WvexyxJwitodf0ZApI3oIFo9uj3tXIgBMdnQViNdgHQcBMie1iJ
        5QOiovjJGWRL+U69hdmay2qG0r4TD7DRYkjb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yB6G9iw5/ynQTh70c+N/5UME8sftejM/
        cszyUuZPAoQOguZwcLAVSa25GX+q5SF4FDpKDRhhAwVb4feiUlIDoj9siABoSww+
        WZl94lvIDu3+29d1JbCIr7dcG6Ov0/ijwMYSNpfJwUbAjLDwPHQLVmW1AavG8VeY
        mbndzWM70So=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C175611665F;
        Wed, 21 Nov 2018 20:06:14 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4608D11665E;
        Wed, 21 Nov 2018 20:06:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
        <1965413.u7ZHvrJggb@thunderbird>
Date:   Thu, 22 Nov 2018 10:06:13 +0900
In-Reply-To: <1965413.u7ZHvrJggb@thunderbird> (Stephen P. Smith's message of
        "Wed, 21 Nov 2018 16:54:04 -0700")
Message-ID: <xmqq8t1l6hve.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CED8D49A-EDF2-11E8-818E-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> On Wednesday, November 21, 2018 2:00:16 AM MST Junio C Hamano wrote:
>> [Stalled]
>> 
>> * lt/date-human (2018-07-09) 1 commit
>>  - Add 'human' date format
>> 
>>  A new date format "--date=human" that morphs its output depending
>>  on how far the time is from the current time has been introduced.
>>  "--date=auto" can be used to use this new format when the output is
>>  goint to the pager or to the terminal and otherwise the default
>>  format.
>
> What needs to be done with this patch to move it along?

In a random order as they come to my mind:

 - Support by people other than the original author;

 - Deciding what to call this (i.e. Linus's personal preference
   would not be the only 'human' style, but we may declare it is
   good enough as "a" human format, not "the" human format);

 - Some mechanism (either technical or documentation) to prevent
   endless stream of "I like human output, but I'd tweak it slightly
   this way" updates in the future;

 - Doc;

 - Command line completion;

 - Tests;

 - Waiting for the end of feature freeze before the upcoming
   release.

There may be others, but without all of the above, I'd feel a bit
uncomfortable.

> I see that both Linus and Junio have signed the patch.  

That does not assert that the code is desirable thing to add.  It
just says we made sure that we legally have rights to include it, if
we want to.
