Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05AD1FC62
	for <e@80x24.org>; Mon, 21 Nov 2016 23:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbcKUXO2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 18:14:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54342 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754093AbcKUXO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 18:14:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF09352718;
        Mon, 21 Nov 2016 18:14:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W+lYhS+IXhLYsykSMWvDy5XXWr4=; b=JemRyF
        s3QFFRuIEyq2EONk6i1yMbIRwkw/MsqeoNsEca+kVbEql+fkB4DFPeDeNRSPiG49
        y1ku20vWvrmeXJsSP8CC9L0SAOHNGT6TCDGwRMhvF9ANAoqQxuLU9MjZH+GaXfJk
        ZDbgFv+Cpwmr4ihqM3yQo/FoT78Wm6VRl0Dpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RvyDiWTmyWGs8EzrvRbflxKX/ouX0BY6
        AXpJyqH7kVpyWO8BqBC3kkU5MXdUeiGcvjsoSsWhqlbBgBqC+4NYMsqDSt5E1DUL
        0LxxXaRqp3A/gVGQqIq68vTU65wp5KDRAC75iflg7PCj491s7RsHy4f27wWJkif5
        QshjZdJjwN4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4C2552717;
        Mon, 21 Nov 2016 18:14:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38C0F52714;
        Mon, 21 Nov 2016 18:14:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2016, #04; Mon, 21)
References: <xmqqpoloh3xa.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbCebHojPDUdHn2mmjUwRe-FOcnJqtoa828PJwC6P5mNw@mail.gmail.com>
Date:   Mon, 21 Nov 2016 15:14:25 -0800
In-Reply-To: <CAGZ79kbCebHojPDUdHn2mmjUwRe-FOcnJqtoa828PJwC6P5mNw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 21 Nov 2016 14:57:43 -0800")
Message-ID: <xmqqh970h1da.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EFBAEA2-B040-11E6-8D59-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * bw/grep-recurse-submodules (2016-11-18) 6 commits
>>  - grep: search history of moved submodules
>>  - grep: enable recurse-submodules to work on <tree> objects
>>  - grep: optionally recurse into submodules
>>  - grep: add submodules as a grep source type
>>  - submodules: load gitmodules file from commit sha1
>>  - submodules: add helper functions to determine presence of submodules
>>
>>  "git grep" learns to optionally recurse into submodules
>>
>>  Waiting for review.
>
> I did review both off and on list and I think the latest version is good.

I thought that there were strange mixups of two enumeration types
that are incompatible, at least.  Is there an update that I didn't
see, or you didn't read problems pointed out on list?

>> * jt/use-trailer-api-in-commands (2016-11-02) 6 commits
>>  - sequencer: use trailer's trailer layout
>>  - trailer: have function to describe trailer layout
>>  - trailer: avoid unnecessary splitting on lines
>>  - commit: make ignore_non_trailer take buf/len
>>  - SQUASH???
>>  - trailer: be stricter in parsing separators
>>
>>  Commands that operate on a log message and add lines to the trailer
>>  blocks, such as "format-patch -s", "cherry-pick (-x|-s)", and
>>  "commit -s", have been taught to use the logic of and share the
>>  code with "git interpret-trailer".
>>
>>  What's the doneness of this topic?
>
> From a cursory read (with the SQUASH applied)
> this seems to be done to me.

We are not all that in a hurry to move non-fix to 'next' only with a
cursory read at this point in the cycle ;-).

>> * sb/submodule-config-cleanup (2016-11-02) 3 commits
>> - submodule-config: clarify parsing of null_sha1 element
>> - submodule-config: rename commit_sha1 to commit_or_tree
>> - submodule config: inline config_from_{name, path}
>>
>>  What's the doneness of this topic?
>
> Jake Keller reviewed this and it turns out I was not careful in patch 2/3.
>
> Will resend.

OK.  Thanks.
