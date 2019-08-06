Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046361F731
	for <e@80x24.org>; Tue,  6 Aug 2019 03:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbfHFD3q (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 23:29:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58093 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfHFD3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 23:29:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 768331516B5;
        Mon,  5 Aug 2019 23:29:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=epbMe40IUknpTiPpOBSjz/lega0=; b=aQYSbr
        ghA/S1vZgqSe31l6z6X2BG65XWG2SBXDn0fwlhFk4xWdFXMp4sIZQIRNM0s1SPY7
        9EVjCo1xdvSGqZhwh/gFQ8a15bJyn/SvG/ETrM+Vld2f8Axz0i0szrgQD8mtLza4
        CmPRZhjaHisP/gEf7HjZjDaZMEXjkDMT9mU0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I+9tE5SuyftP5dmdgn1eB8asToTmGH8P
        0ha3kJjp0dvs3+cwLquo4zE0x5gz9jRcCgFzIKeMv7Wy7wc2ORSTyCsv0xCccBiE
        Hx0bIC10nZ+EyqNn5JdKI44qAqUMgMdP1sunFeq0gkzlvI1AuM9/gbejRsMku95C
        CiaXbeaUNK0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F2391516B4;
        Mon,  5 Aug 2019 23:29:44 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6E661516B3;
        Mon,  5 Aug 2019 23:29:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lukas Gross <lukasgross@u.northwestern.edu>, git@vger.kernel.org
Subject: Re: amend warnings with no changes staged
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
        <20190806013030.GA61803@google.com>
        <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
        <20190806021618.GC61803@google.com>
        <xmqqtvavko1h.fsf@gitster-ct.c.googlers.com>
        <20190806030026.GA8864@google.com>
Date:   Mon, 05 Aug 2019 20:29:42 -0700
In-Reply-To: <20190806030026.GA8864@google.com> (Jonathan Nieder's message of
        "Mon, 5 Aug 2019 20:00:26 -0700")
Message-ID: <xmqqpnljkm3d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EBAB81C-B7FA-11E9-B4FF-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>> Some non-judgemental descriptive output like
>>>
>>> 	$ git commit --amend --no-edit
>>> 	No changes.
>>> 	$
>>>
>>> would address this case, without bothering people who are doing it
>>> intentionally.  So I think there's room for a simple improvement here.
>>
>> I do that to refresh the committer timestamp.
>
> I do, too.  The proposal is, paraphrasing,
>
> 	$ git commit --amend --no-edit
> 	Ah, I see that you want me to refresh the committer timestamp.
> 	Done, as requested.
> 	$

Ah, OK then.  I somehow misread "No changes." as an error message.
