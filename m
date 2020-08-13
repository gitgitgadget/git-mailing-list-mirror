Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E522C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466262078D
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 16:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YehOCc2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMQqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:46:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52137 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHMQqU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 12:46:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C831878C5B;
        Thu, 13 Aug 2020 12:46:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1wQET/KKII3ZwrWFMUrHUnyiVyU=; b=YehOCc
        2GRrPx+t1ob5vsbG//DIPPVhPBme/S2HfohCiSNdIsLXwA3qDVP+/Xjh1sv0w7zo
        LSRvcyfdAUPbnP16JBAZNewXde0wp49cIyPHKhhumHmSXu0SLkZ2eMvzmBd2Yma6
        jR5Za884oxqTd3eF9bWgB2VXZSLJZLtJ23EpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vmcPYxlpZZ5i1H9WI+uBakOenkkuFGHg
        pUF5q80/4aOe5Etat3syCSjE2ozT88EtVGVqeHuQwK18mdoeQAFZw5Oac0NZc+fg
        rhrFIDqgLszpZmaJWAsnN1fvMMSr8W/FOnrOljwxDQbdblHUzBuTWmVXvyUtTmUe
        lgrn+fYJsZ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE45478C5A;
        Thu, 13 Aug 2020 12:46:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24B6078C59;
        Thu, 13 Aug 2020 12:46:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de, liu.denton@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/4] t7401: modernize style
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
        <20200812192737.13971-1-shouryashukla.oo@gmail.com>
        <20200812192737.13971-2-shouryashukla.oo@gmail.com>
        <c70f7bb5d1289f5318da7b99e41cf5828a451174.camel@gmail.com>
Date:   Thu, 13 Aug 2020 09:46:14 -0700
In-Reply-To: <c70f7bb5d1289f5318da7b99e41cf5828a451174.camel@gmail.com>
        (Kaartic Sivaraam's message of "Thu, 13 Aug 2020 13:36:49 +0530")
Message-ID: <xmqqd03u4hpl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80A15C38-DD84-11EA-AD43-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>> @@ -16,12 +16,13 @@ add_file () {
>>  	owd=$(pwd)
>>  	cd "$sm"
>>  	for name; do
>> -		echo "$name" > "$name" &&
>> +		echo "$name" >"$name" &&
>>  		git add "$name" &&
>>  		test_tick &&
>>  		git commit -m "Add $name"
>>  	done >/dev/null
>> -	git rev-parse --verify HEAD | cut -c1-7
>> +	git rev-parse --verify HEAD >out &&
>> +	cut -c1-7 out
>
> In any case, I believe we can avoid the 'cut' altogether in both places
> by doing something like this instead:
>
>    git rev-parse --short=7 HEAD

Ah, I missed the fact that this was a helper function and most of
the error status is discarded anyway.  For example, we still run the
rev-parse even after the for loop fails.

If the focus of this test script were to ensure that rev-parse works
correctly, being careful to catch its exit status might have had a
good value, but for that, all the other operations that happen in
this helper function (including the "what happens when the loop body
fails for $name that is not at the end of the argument list?") must
also be checked for their exit status in the first place.

Since that is not done, and since testing rev-parse should not have
to be part of the job for submodule test, the net effect of the
above change has quite dubious value---it clobbered a file 'out'
that may be used by the caller.

Doing "cd" without introducing a subshell is a bit harder to fix, as
test_tick relies on the global counter in the topmost process.  It
can be done, but I do not think it is worth doing here.  Most of the
users of this helper function call it in var=$(add_file ...)
subshell anyway (so test_tick is incrementing the timestamp
independently for each caller and discarding the resulting
timestamp).  As a NEEDSWORK comment added in the series says, this
script may need a bit more work.

I agree with you that the split of "rev-parse | cut -c1-7" into two
statements and clobbering 'out' is a bad change---that part should
be reverted.  The style change on 'echo "$name" >"$name"' line is
OK, though.

Thanks.

> My quick check shows the test script is happy with this change.
>
>>  	cd "$owd"
>>  }
>>  commit_file () {
>> @@ -125,7 +126,8 @@ commit_file sm1 &&
>>  head3=$(
>>  	cd sm1 &&
>>  	git reset --hard HEAD~2 >/dev/null &&
>> -	git rev-parse --verify HEAD | cut -c1-7
>> +	git rev-parse --verify HEAD >out &&
>> +	cut -c1-7 out
>>  )
>>  
>>  test_expect_success 'modified submodule(backward)' "
