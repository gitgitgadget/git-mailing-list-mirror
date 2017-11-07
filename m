Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B0AD20A10
	for <e@80x24.org>; Tue,  7 Nov 2017 02:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754187AbdKGCBA (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 21:01:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61966 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751728AbdKGCA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 21:00:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E184AA5D13;
        Mon,  6 Nov 2017 21:00:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kj/xUbFbq9JVonDI7AQmZm4X318=; b=eiZ89D
        qiI60pDxldnGDAbvTXrMPYGkFZKDq5Fp7lyt/kNi5KKmFkPPMuRQlY7IyDHrqQBw
        K9zP44+DRSOtg2i53hQZlXT3R+UOcktKR6iLCOtBz/j+MPfFqZ8MdY6ovlI6mEVa
        nw1GArxnRZVATy2aCDvKN0AOElXvkcRHgSRaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JPL55TH9P91eDcC20GvM7vNpNdIp6yuc
        wmbxjDKrV7oaeGvFso6oOvmgkSFawB7cFzc6HOt7yZgsc/gfDodu2f91nCOeO012
        aS8UE+wDtQ03okPwgW+uZBFwIx7Uc7U5scOo+CQJOA18DdtskuKgD9U7lXpg2KJM
        nrktFZnhOVo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8B08A5D12;
        Mon,  6 Nov 2017 21:00:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44D9CA5D0E;
        Mon,  6 Nov 2017 21:00:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: sb/submodule-recursive-checkout-detach-head
References: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYUZv0g+3OEMrbT26A7mSLJzeS-yf5Knr-CnARHqVB=aQ@mail.gmail.com>
Date:   Tue, 07 Nov 2017 11:00:57 +0900
In-Reply-To: <CAGZ79kYUZv0g+3OEMrbT26A7mSLJzeS-yf5Knr-CnARHqVB=aQ@mail.gmail.com>
        (Stefan Beller's message of "Fri, 27 Oct 2017 11:50:49 -0700")
Message-ID: <xmqq4lq6hmp2.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F4A69DE-C35F-11E7-8E72-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
>>   (merged to 'next' on 2017-10-26 at 30994b4c76)
>>  + Documentation/checkout: clarify submodule HEADs to be detached
>>  + recursive submodules: detach HEAD from new state
>>
>>  "git checkout --recursive" may overwrite and rewind the history of
>>  the branch that happens to be checked out in submodule
>>  repositories, which might not be desirable.  Detach the HEAD but
>>  still allow the recursive checkout to succeed in such a case.
>>
>>  Undecided.
>>  This needs justification in a larger picture; it is unclear why
>>  this is better than rejecting recursive checkout, for example.
> ...
> Detaching the submodule HEAD is in line with the current thinking
> of submodules, though I am about to send out a plan later
> asking if we want to keep it that way long term.

Did this "send out a plan" ever happen?  I am about to rewind 'next'
and rebuild on top of v2.15, and wondering if I should keep the
topic or kick it back to 'pu' so that a better justification can be
given.

